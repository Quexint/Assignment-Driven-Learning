#include <ctype.h>
#include <errno.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <signal.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>

#include "io.h"
#include "parse.h"
#include "process.h"
#include "shell.h"

int cmd_quit(tok_t arg[]);
int cmd_help(tok_t arg[]);
int cmd_pwd(tok_t arg[]);
int cmd_cd(tok_t arg[]);
int cmd_bg(tok_t arg[]);
int cmd_fg(tok_t arg[]);

/* Built-in command functions take token array (see parse.h) and return int */
typedef int cmd_fun_t(tok_t args[]);

/* Built-in command struct and lookup table */
typedef struct fun_desc
{
  cmd_fun_t *fun;
  char *cmd;
  char *doc;
} fun_desc_t;

fun_desc_t cmd_table[] = {
  {cmd_pwd, "pwd", "return working directory name"},
  {cmd_cd, "cd", "change directory"},
  {cmd_help, "?", "show this help menu"},
  {cmd_quit, "quit", "quit the command shell"},
  {cmd_bg, "bg", "background processing"},
  {cmd_fg, "fg", "foreground processing"}
};

int cmd_cd(tok_t arg[])
{
  if(chdir(arg[0])) return 0;
  return 1;
}

int cmd_pwd(tok_t arg[])
{
  printf("%s\n", getcwd(NULL, 0));
  return 1;
}

int cmd_help(tok_t arg[])
{
  for (int i = 0; i < sizeof(cmd_table) / sizeof(fun_desc_t); i++) {
    printf("%s - %s\n", cmd_table[i].cmd, cmd_table[i].doc);
  }
  return 1;
}

int cmd_quit(tok_t arg[])
{
  kill(shell_pgid, SIGTERM);
  job *i, *nxt;
  for(i = first_job; i; i = nxt){
    nxt = i->next;
    killpg(i->pgid, SIGTERM);
  }
  kill(shell_pgid, SIGTERM);
  exit(0);
  return 1;
}

int cmd_bg(tok_t arg[])
{
  return cmd_fbg(0, arg);
}
int cmd_fg(tok_t arg[])
{
  return cmd_fbg(1, arg);
}


int cmd_fbg(int foreground, tok_t arg[])
{
  if(arg[0] == NULL){
    int i;
    job *j, *jnext;
    for(i=1, j=first_job; j;i++, j = jnext){
      jnext = j->next;
      fprintf(stderr, "[%d] %d ", i, j->pgid);
      if(job_is_completed(j)) fprintf(stderr, "(completed)");
      else if(job_is_stopped(j)) fprintf(stderr, "(stopped)");
      else fprintf(stderr, "(running)");
      fprintf(stderr, " %s", j->command);
    }
  }else{
    /* Support "fg %i" to continue the i-th job */
    if(arg[0][0] == '%') {
      int i, tar = atoi(&arg[0][1]);
      job *j, *jnext;
      for(i=1, j=first_job; j; i++, j=jnext){
        jnext = j->next;
        if(i==tar)continue_job(j, foreground);
      }
    /* Support "fg [pid]" to continue the job with [pid] */
    }else if(find_job(atoi(arg[0]))!=NULL)
      continue_job(find_job(atoi(arg[0])), foreground);
  }
  return 1;
}

/**
 * Looks up the built-in command, if it exists.
 */
int lookup(char cmd[])
{
  for (int i = 0; i < sizeof(cmd_table) / sizeof(fun_desc_t); i++) {
    if (cmd && (strcmp(cmd_table[i].cmd, cmd) == 0)) return i;
  }
  return -1;
}

int debug = 0;
/* Whether the shell is connected to an actual terminal or not. */
bool shell_is_interactive;

/* File descriptor for the shell input */
int shell_terminal;

/* Terminal mode settings for the shell */
struct termios shell_tmodes;

/* Process group id for the shell */
pid_t shell_pgid;

job *first_job = NULL, *last_job = NULL;

/**
 * Intialization procedures for this shell
 */
void init_shell()
{
  /* Check if we are running interactively */
  shell_terminal = STDIN_FILENO;
  shell_is_interactive = isatty(shell_terminal);

  if(shell_is_interactive){
    /* Force the shell into foreground */
    while(tcgetpgrp(shell_terminal) != (shell_pgid = getpgrp()))
      kill(-shell_pgid, SIGTTIN);

    /* Ignore interactive and job-control */
    signal(SIGINT, SIG_IGN);
    signal(SIGQUIT, SIG_IGN);
    signal(SIGTSTP, SIG_IGN);
    signal(SIGTTIN, SIG_IGN);
    signal(SIGTTOU, SIG_IGN);
    signal(SIGCHLD, do_job_notification);

    /* Saves the shell's process id */
    shell_pgid = getpid();

    /* Take control of the terminal */
    tcsetpgrp(shell_terminal, shell_pgid);
    tcgetattr(shell_terminal, &shell_tmodes);
  }
}

process *get_process(char *cmd)
{
  process *p;
  int i;

  p = (process*)malloc(sizeof(process));
  p->next = NULL;
  p->tokens = get_toks(strdup(cmd));
  p->completed = p->stopped = p->status = 0;
  if(p->tokens[0] == NULL){
    free(p);
    return NULL;
  }
  if(debug){
    fprintf(stderr, "make process: cmdd\"%s\"\n", cmd);
    for(i=0; p->tokens[i] !=NULL; i++)
      fprintf(stderr, "(%d) %s",i, p->tokens[i]);
    fprintf(stderr, "\n");
  }
  return p;
}

job *get_jobs(char *cmd)
{
  job *j;
  process *last_p, *p;
  int sav = 0;
  int i;
  char *arr[MAXTOKS];
  char *ptr;

  if(debug)fprintf(stderr, "get Jobs: \"%s\"\n", cmd);

  j = malloc(sizeof(job));
  j->command = strdup(cmd);
  j->pgid = 0;
  j->next = NULL;
  j->notified = 0;
  j->std_in = STDIN_FILENO;
  j->std_out = STDOUT_FILENO;
  j->std_err = STDERR_FILENO;
  j->tmodes = shell_tmodes;

  last_p = NULL;

  ptr = strtok(cmd, "|");
  do{
    arr[sav] = ptr;
    sav++;
  }while((ptr = strtok(NULL, "|")));

  for(i=0;i<sav;i++){
    p = get_process(arr[i]);
    if(p==NULL) continue;
    if(last_p == NULL) j->first_process = last_p = p;
    else {
      last_p->next = p;
      last_p = p;
    }
  }

  if(j->first_process == NULL){
    free(j->command);
    free(j);
    return NULL;
  }
  return j;
}


int shell(int argc, char *argv[]) {
  char *input_bytes;
  int line_num = 0;
  job *j;
  int fg = 1;
  char *ptr;
  int fundex;

  init_shell();

  /* Please only print shell prompts when standard input is not a tty */
  if (shell_is_interactive)
    fprintf(stdout, "%s $ ", getcwd(NULL,0));

  while ((input_bytes = freadln(stdin))) {
    char *tmpStr = strdup(input_bytes);
    tok_t *tokens = get_toks(tmpStr);
    fundex = lookup(tokens[0]);
    if (fundex >= 0) {
      cmd_table[fundex].fun(&(tokens[1]));
    } else {
      fg = 1;
      ptr = strchr(input_bytes, '&');
      if(ptr) {
        *ptr = ' ';
        fg = 0;
      }

      j = get_jobs(input_bytes);
      if(j){
        if(first_job == NULL) first_job = last_job = j;
        else {
          last_job->next = j;
          last_job = last_job->next;
        }
        launch_job(last_job, fg);
      }
    }
    do_job_notification();
    /* Please only print shell prompts when standard input is not a tty */
    if (shell_is_interactive)
      fprintf(stdout, "%s $ ", getcwd(NULL,0));
  }
  return 0;
}

