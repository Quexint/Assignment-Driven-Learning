#include <errno.h>
#include <string.h>
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <termios.h>
#include <fcntl.h>

#include "process.h"
#include "shell.h"
#include "parse.h"
#include "io.h"

/**
 * When job is done, release the resource.
 */
void free_job(job *j)
{
  job *i, *fir, *last;
  for(i = first_job, fir = last = NULL; i != NULL; i = i->next){
    if(fir == NULL && i != j) fir = i;
    if(i != j) last = i;
  }
  first_job = fir, last_job = last;
}

/**
 * redirect_IO - Input/Output Redirection
 * Make the redirection, only for < and >.
 */
void redirect_IO(tok_t *tokens, int *fd_in, int *fd_out)
{
  char arr[2] = {'<', '>'};
  char ch;
  int itr;

  for(int i=0; i < 2; i++){
    ch = arr[i];
    itr = is_direct_tok(tokens, &ch);
    if(itr){
      remove_tokens(tokens, itr);
      if(i==0 && (*fd_in = open(tokens[itr], O_RDONLY)) < 0)
        exit(EXIT_FAILURE);
      else if(i==1 && (*fd_out = open(tokens[itr], O_CREAT|O_TRUNC|O_WRONLY, 0644 )) < 0 )
        exit(EXIT_FAILURE);

      remove_tokens(tokens, itr);
    }
  }
}

/**
 * get_path_tokens - Make the Path Resolution Tokens
 */
tok_t *get_path_tokens(tok_t *tokens)
{
  tok_t *pathTokens = NULL;
  char *ptr = strchr(tokens[0], '/');
  if(ptr == NULL){
    char *pwdPath = getcwd(NULL, 0);
    char *ptr = getenv("PATH");
    char *buffer = (char*)malloc(strlen(pwdPath) + 1 + strlen(ptr) + 5);
    sprintf(buffer,"%s:%s", pwdPath, ptr);
    pathTokens = get_toks(buffer);
    free(pwdPath);
  }else{
    pathTokens = get_toks(strdup(tokens[0]));
    *ptr = '\0';
    strcpy(pathTokens[0], tokens[0]);
    memmove(tokens[0], ptr+1, strlen(ptr+1)+1);
  }
  return pathTokens;
}

/**
 * exec_program - Run the problem, supporting finding the prog in the PATH
 * According to the homework requirement, we can't use 'execvp'.
 */
void exec_program(tok_t *tokens, tok_t *pathTokens)
{
  int i;
  int flag;

  char *filename = strdup(tokens[0]);
  char *pathWithFile = NULL;

  for(i = flag = 0; flag==0 && pathTokens[i] != NULL; i++){
    pathWithFile = (char*)malloc(strlen(filename) + 1 + strlen(pathTokens[i]) + 5);
    sprintf(pathWithFile, "%s/%s", pathTokens[i], filename);
    tokens[0] = pathWithFile;
    if(execv(tokens[0], tokens)==0)
      flag = 1;
    free(pathWithFile);
  }
  if(!flag)
    fprintf(stderr, "The Executable '%s' Not Found.\n", filename);

  if(filename) free(filename);

  if(flag) exit(EXIT_SUCCESS);
  else exit(EXIT_FAILURE);
}

/**
 * launch_process - Executes the program
 * According to the GNU C Library Reference Ch. 28 Job-Contorl, modified some part of func.
 */
void launch_process(process *p, pid_t pgid, int infile, int outfile, int errfile, int foreground)
{
  pid_t pid;

  if(shell_is_interactive){
    pid = getpid();
    if(pgid == 0) pgid = pid;
    setpgid(pid, pgid);
    if(foreground)
      tcsetpgrp(shell_terminal, pgid);

    /* Reset the Signal */
    signal(SIGINT, SIG_DFL);
    signal(SIGQUIT, SIG_DFL);
    signal(SIGTSTP, SIG_DFL);
    signal(SIGTTIN, SIG_DFL);
    signal(SIGTTOU, SIG_DFL);
    signal(SIGCHLD, SIG_DFL);
  }
  redirect_IO(p->tokens, &infile, &outfile);

  if(infile != STDIN_FILENO){
    dup2(infile, STDIN_FILENO);
    close(infile);
  }
  if(outfile != STDOUT_FILENO){
    dup2(outfile, STDOUT_FILENO);
    close(outfile);
  }
  if(errfile != STDERR_FILENO){
    dup2(errfile, STDERR_FILENO);
    close(errfile);
  }

  tok_t *pathTokens = get_path_tokens(p->tokens);
  exec_program(p->tokens, pathTokens);
  free(pathTokens[0]);
  exit(1);
}

/**
 * launch_job - Executes the Command
 * According to the GNU C Library Reference Ch. 28 Job-Contorl, modified some part of func.
 */
void launch_job(job *j, int foreground)
{
  process *p;
  pid_t pid;
  int mypipe[2], infile, outfile;

  infile = j->std_in;
  for(p = j->first_process; p; p = p->next){
    if(p->next){
      if(pipe(mypipe) < 0){
        perror("pipe");
        exit(1);
      }
      outfile = mypipe[1];
    }else
      outfile = j->std_out;

    pid = fork();
    if(pid == 0)
      launch_process(p, j->pgid, infile, outfile, j->std_err, foreground);
    else if(pid < 0){
      perror("fork");
      exit(1);
    }else{
      p->pid = pid;
      if(shell_is_interactive){
        if(!(j->pgid))
          j->pgid = pid;
        setpgid(pid, j->pgid);
      }
    }

    if(infile != j->std_in)
      close(infile);
    if(outfile != j->std_out)
      close(outfile);
    infile = mypipe[0];
  }

  if(debug)format_job_info(j, "launched");

  if(!shell_is_interactive)
    wait_for_job(j);
  else if(foreground)
    put_process_in_foreground(j, 0);
  else
    put_process_in_background(j, 0);
}

/**
 * put_process_in_foreground
 * According to the GNU C Library Reference Ch. 28 Job-Contorl.
 */
void put_process_in_foreground(job *j, int cont)
{
  /* Put the job into the foreground. */
  tcsetpgrp(shell_terminal, j->pgid);
  if(cont){
    tcsetattr(shell_terminal, TCSADRAIN, &(j->tmodes));
    if(kill(-j->pgid, SIGCONT) < 0)
      perror("kill (SIGCONT)");
  }
  wait_for_job(j);
  /* Put the shell back in the foreground. */
  tcsetpgrp(shell_terminal, shell_pgid);
  /* Restore the shell's terminal modes. */
  tcgetattr(shell_terminal, &(j->tmodes));
  tcsetattr(shell_terminal, TCSADRAIN, &shell_tmodes);
}

/**
 * put_process_in_background
 * According to the GNU C Library Reference Ch. 28 Job-Contorl.
 */
void put_process_in_background(job *j, int cont)
{
  /* Send the job a continue signal, if necessary. */
  if (cont && kill(-(j->pgid), SIGCONT) < 0)
    perror("kill (SIGCONT)");
}

job *find_job (pid_t pgid){
  job *j;
  for(j = first_job; j; j = j->next)
    if(j->pgid == pgid)
      return j;
  return NULL;
}

int job_is_stopped(job *j)
{
  process *p;
  for(p = j->first_process; p; p = p->next)
    if(!(p->completed) && !(p->stopped))
      return 0;
  return 1;
}

int job_is_completed(job *j)
{
  process *p;
  for(p = j->first_process; p; p = p->next)
    if(!(p->completed))
      return 0;
  return 1;
}

int mark_process_status(pid_t pid, int status)
{
  job *j;
  process *p;
  if(pid > 0){
    for(j = first_job; j; j = j->next)
      for(p = j->first_process; p; p = p->next)
        if(p->pid == pid){
          p->status = status;
          if(WIFSTOPPED(status))
            p->stopped = 1;
          else{
            p->completed = 1;
            if(WIFSIGNALED(status))
              fprintf(stderr, "%d: Terminated by signal %d.\n", (int)pid, WTERMSIG(p->status));
          }
          return 0;
        }
    fprintf(stderr, "No child process %d.\n", pid);
    return -1;
  }else if(pid == 0 || errno == ECHILD)
    return -1;
  else {
    perror("waitpid");
    return -1;
  }
}

void update_status(void)
{
  int status;
  pid_t pid;
  do
    pid = waitpid(WAIT_ANY, &status, WUNTRACED|WNOHANG);
  while(!mark_process_status(pid, status));
}

void wait_for_job(job *j)
{
  int status;
  pid_t pid;
  do
    pid = waitpid(WAIT_ANY, &status, WUNTRACED);
  while(!mark_process_status(pid, status) && !job_is_stopped(j) && !job_is_completed(j));
}

void format_job_info(job *j, const char *status)
{
  fprintf(stderr, "%ld (%s): %s\n", (long)j->pgid, status, j->command);
}

void do_job_notification(void)
{
  job *j, *jlast, *jnext;

  update_status();

  jlast = NULL;
  for(j = first_job; j; j = jnext){
    jnext = j->next;

    if(job_is_completed(j)){
      /*format_job_info(j, "completed");*/
      if(jlast)
        jlast->next = jnext;
      else
        first_job = jnext;
      free_job(j);
    }else if(job_is_stopped(j) && !(j->notified)){
      format_job_info(j, "suspended");
      j->notified = 1;
      jlast = j;
    }else
      jlast = j;
  }
}

void mark_job_as_running(job *j)
{
  process *p;
  for(p = j->first_process; p; p = p->next)
    p->stopped = 0;
  j->notified = 0;
}

void continue_job(job *j, int foreground)
{
  mark_job_as_running(j);
  if(foreground)
    put_process_in_foreground(j, 1);
  else
    put_process_in_background(j, 1);
}
