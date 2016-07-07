#ifndef _PROCESS_H_
#define _PROCESS_H_

#include <stdbool.h>
#include <signal.h>
#include <sys/types.h>
#include <termios.h>
#include <unistd.h>
typedef char *tok_t;

/* A process is a single process. */
typedef struct process
{
  struct process *next;
  tok_t *tokens;
  pid_t pid;
  char completed;
  char stopped;
  int status;
}process;

/* A job is a pipeline of process. */
typedef struct job
{
  struct job *next;
  char *command;
  process *first_process;
  pid_t pgid;
  char notified;
  int std_in, std_out, std_err;
  struct termios tmodes;
}job;

/**
 * Executes the program pointed by process name
 */
void launch_process(process *p, pid_t pgid, int inflie, int outfile, int errfile, int foreground);
void launch_job(job *j, int foreground);

/**
 * Puts a process group with id PID into the foreground. Restores terminal
 * settings from *tmodes. Waits until the process with id PID exits or pauses.
 * Then, saves the current terminal settings into *tmodes. Finally, puts the
 * shell back into the foreground and restores terminal settings from
 * shell_tmodes.
 *
 */
void put_process_in_foreground(job *j, int cont);

/**
 * Put a job in the background.
 *
 *     pid
 *     cont -- Send the process group a SIGCONT signal to wake it up.
 *
 */
void put_process_in_background(job *j, int cont);
int mark_process_status(pid_t pid, int status);
void update_status(void);
void wait_for_job(job *j);
void format_job_info(job *j, const char *status);
void do_job_notification(void);
void mark_job_as_running(job *j);
void continue_job(job *j, int foreground);

job *find_job (pid_t pgid);
int job_is_stopped(job *j);
int job_is_completed(job *j);

#endif
