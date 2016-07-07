#include <arpa/inet.h>
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <netdb.h>
#include <netinet/in.h>
#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <dirent.h>


#include "libhttp.h"

/*
 * Global configuration variables.
 * You need to use these in your implementation of handle_files_request and
 * handle_proxy_request. Their values are set up in main() using the
 * command line arguments (already implemented for you).
 */
int server_port;
char *server_files_directory;
char *server_proxy_hostname;
int server_proxy_port;
struct passing_data{
  int idx;
  int fd[2];
};

void load_data(char filename[], char **data, int *data_sz){
  FILE *fp = fopen(filename, "rb");
  if(fp == NULL){
    *data_sz = -1;
    return ;
  }
  fseek(fp, 0L, SEEK_END);
  *data_sz = ftell(fp);

  fseek(fp, 0L, SEEK_SET);
  *data = malloc((*data_sz)*sizeof(char));
  fread(*data, sizeof(char), *data_sz, fp);

  fclose(fp);
  return ;
}
/*
 * Reads an HTTP request from stream (fd), and writes an HTTP response
 * containing:
 *
 *   1) If user requested an existing file, respond with the file
 *   2) If user requested a directory and index.html exists in the directory,
 *      send the index.html file.
 *   3) If user requested a directory and index.html doesn't exist, send a list
 *      of files in the directory with links to each.
 *   4) Send a 404 Not Found response.
 */
void send_data(int fd, int status_code, char content_type[], char data[], int data_sz){
  char buf[20];
  sprintf(buf, "%d", data_sz);
  http_start_response(fd, status_code);
  http_send_header(fd, "Content-type", content_type);
  http_send_header(fd, "Content-Length", buf);
  http_end_headers(fd);
  http_send_data(fd, data, data_sz);
}

void handle_files_request(int fd) {

  /* YOUR CODE HERE (Feel free to delete/modify the existing code below) */
  char *data = NULL;
  int data_sz;
  char *file_with_path;
  struct stat stat_buf;
  DIR *dirp;
  struct dirent *dp;
  char *ptr;
  char *backupPATH = NULL;
  struct http_request *request = http_request_parse(fd);

  file_with_path = malloc(strlen(server_files_directory) + strlen(request->path) + 20);
  sprintf(file_with_path, "%s%s", server_files_directory, request->path);
  stat(file_with_path, &stat_buf);

  if(S_ISDIR(stat_buf.st_mode)){
    backupPATH = strdup(file_with_path);
    ptr = malloc(strlen(file_with_path) + 20);
    sprintf(ptr, "%sindex.html", file_with_path);
    free(file_with_path);
    file_with_path = ptr;
  }
  load_data(file_with_path, &data, &data_sz);
  if(data_sz >= 0){
    send_data(fd, 200, http_get_mime_type(file_with_path), data, data_sz);
  }else if(backupPATH != NULL && (dirp = opendir(backupPATH))){
    data = strdup("<a href=\"../\">Parent directory</a>");
    data_sz = strlen(data);
    while ((dp = readdir(dirp)) != NULL) {
      if(strcmp(".", dp->d_name)==0)continue;
      if(strcmp("..", dp->d_name)==0)continue;
      int d_namelen = strlen(dp->d_name);
      char *buf = malloc(strlen(data) + strlen("</br><a href=\"") + d_namelen + strlen("\">") + d_namelen + strlen("</a>"));
      sprintf(buf, "%s</br><a href=\"%s\">%s</a>", data, (dp->d_name), (dp->d_name));
      free(data);
      data = buf;
      data_sz = strlen(data);
    }
    send_data(fd, 200, "text/html", data, data_sz);
    closedir(dirp);
  }else{
    data = strdup("");
    data_sz = 0;
    send_data(fd, 404, "text/html", data, data_sz);
  }

  free(data);
  free(backupPATH);
  free(file_with_path);
}

/*
 * Opens a connection to the proxy target (hostname=server_proxy_hostname and
 * port=server_proxy_port) and relays traffic to/from the stream fd and the
 * proxy target. HTTP requests from the client (fd) should be sent to the
 * proxy target, and HTTP responses from the proxy target should be sent to
 * the client (fd).
 *
 *   +--------+     +------------+     +--------------+
 *   | client | <-> | httpserver | <-> | proxy target |
 *   +--------+     +------------+     +--------------+
 */
void thread_handler(void *arg){
  int idx = ((struct passing_data *)arg)->idx;
  int fir_fd = ((struct passing_data *)arg)->fd[idx];
  int sec_fd = ((struct passing_data *)arg)->fd[idx^1];
  int n;
  char buffer[30000];
  memset(buffer, 0, sizeof(buffer));

  while( ( n = read(fir_fd, buffer, 25600) ) > 0 ){
    if(n)printf("buffer(%d->%d) %s\n",idx, idx^1, buffer);
    write(sec_fd, buffer, n);
    memset(buffer, 0, sizeof(buffer));
  }
  pthread_exit(0);
}
void handle_proxy_request(int fd) {

  /*printf("hostname %s port %d\n",server_proxy_hostname, server_proxy_port);*/

  fd_set rd;
  int sockfd;
  struct sockaddr_in serv_addr;
  struct hostent *server;
  int n;
  char buffer[30000];
  memset(buffer, 0, sizeof(buffer));

  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  if(sockfd < 0)
    perror("error");

  server = gethostbyname(server_proxy_hostname);
  if(server == NULL)
    perror("No host");

  memset(&serv_addr, 0, sizeof(struct sockaddr_in));
  serv_addr.sin_family = AF_INET;
  memcpy(&serv_addr.sin_addr.s_addr, (server->h_addr), server->h_length);
  serv_addr.sin_port = htons(server_proxy_port);
  if(connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0)
    perror("Error Connection");

  enum{SELECT_WAY, PTHREAD} way = PTHREAD;

  while(way == SELECT_WAY ){
    int result;
    int nfsd = (sockfd > fd ? sockfd : fd);

    do {
      FD_ZERO(&rd);
      FD_SET(sockfd, &rd);
      FD_SET(fd, &rd);
      result = select(nfsd + 1, &rd, NULL, NULL, NULL);
    } while (result == -1 && errno == EINTR);

    if (result > 0) {
      if (FD_ISSET(fd, &rd)) {
        n = read(fd, buffer, 25600);
        if(n)printf("buffer(client->server) %s\n", buffer);
        write(sockfd, buffer, n);
        memset(buffer, 0, sizeof(buffer));
      }else if(FD_ISSET(sockfd, &rd)){
        n = read(sockfd, buffer, 25600);
        if(n)printf("buffer(client<-server) %s\n", buffer);
        write(fd, buffer, n);
        memset(buffer, 0, sizeof(buffer));
      }
    }
  }

  while(way == PTHREAD){
    pthread_t thread[2];
    struct passing_data tmp[2];
    int i;
    for(i = 0; i < 2; i++){
      tmp[i].idx = i;
      tmp[i].fd[0] = fd;
      tmp[i].fd[1] = sockfd;
      pthread_create(&thread[i], NULL, (void*) thread_handler, &tmp[i]);
    }
    for(i = 0; i < 2; i++)
      pthread_join(thread[i], NULL);

  }


  close(sockfd);
}

/*
 * Opens a TCP stream socket on all interfaces with port number PORTNO. Saves
 * the fd number of the server socket in *socket_number. For each accepted
 * connection, calls request_handler with the accepted fd number.
 */
void serve_forever(int *socket_number, void (*request_handler)(int)) {

  struct sockaddr_in server_address, client_address;
  size_t client_address_length = sizeof(client_address);
  int client_socket_number;
  pid_t pid;

  *socket_number = socket(PF_INET, SOCK_STREAM, 0);
  if (*socket_number == -1) {
    perror("Failed to create a new socket");
    exit(errno);
  }

  int socket_option = 1;
  if (setsockopt(*socket_number, SOL_SOCKET, SO_REUSEADDR, &socket_option,
        sizeof(socket_option)) == -1) {
    perror("Failed to set socket options");
    exit(errno);
  }

  memset(&server_address, 0, sizeof(server_address));
  server_address.sin_family = AF_INET;
  server_address.sin_addr.s_addr = INADDR_ANY;
  server_address.sin_port = htons(server_port);

  if (bind(*socket_number, (struct sockaddr *) &server_address,
        sizeof(server_address)) == -1) {
    perror("Failed to bind on socket");
    exit(errno);
  }

  if (listen(*socket_number, 1024) == -1) {
    perror("Failed to listen on socket");
    exit(errno);
  }

  printf("Listening on port %d...\n", server_port);

  while (1) {

    client_socket_number = accept(*socket_number,
        (struct sockaddr *) &client_address,
        (socklen_t *) &client_address_length);
    if (client_socket_number < 0) {
      perror("Error accepting socket");
      continue;
    }

    printf("Accepted connection from %s on port %d\n",
        inet_ntoa(client_address.sin_addr),
        client_address.sin_port);

    pid = fork();
    if (pid > 0) {
      close(client_socket_number);
    } else if (pid == 0) {
      // Un-register signal handler (only parent should have it)
      signal(SIGINT, SIG_DFL);
      close(*socket_number);
      request_handler(client_socket_number);
      close(client_socket_number);
      exit(EXIT_SUCCESS);
    } else {
      perror("Failed to fork child");
      exit(errno);
    }
  }

  close(*socket_number);

}

int server_fd;
void signal_callback_handler(int signum) {
  printf("Caught signal %d: %s\n", signum, strsignal(signum));
  printf("Closing socket %d\n", server_fd);
  if (close(server_fd) < 0) perror("Failed to close server_fd (ignoring)\n");
  exit(0);
}

char *USAGE =
  "Usage: ./httpserver --files www_directory/ --port 8000\n"
  "       ./httpserver --proxy inst.eecs.berkeley.edu:80 --port 8000\n";

void exit_with_usage() {
  fprintf(stderr, "%s", USAGE);
  exit(EXIT_SUCCESS);
}

int main(int argc, char **argv) {
  signal(SIGINT, signal_callback_handler);

  /* Default settings */
  server_port = 8000;
  server_files_directory = malloc(1024);
  getcwd(server_files_directory, 1024);
  server_proxy_hostname = "inst.eecs.berkeley.edu";
  server_proxy_port = 80;

  void (*request_handler)(int) = handle_files_request;

  int i;
  for (i = 1; i < argc; i++) {
    if (strcmp("--files", argv[i]) == 0) {
      request_handler = handle_files_request;
      free(server_files_directory);
      server_files_directory = argv[++i];
      if (!server_files_directory) {
        fprintf(stderr, "Expected argument after --files\n");
        exit_with_usage();
      }
    } else if (strcmp("--proxy", argv[i]) == 0) {
      request_handler = handle_proxy_request;

      char *proxy_target = argv[++i];
      if (!proxy_target) {
        fprintf(stderr, "Expected argument after --proxy\n");
        exit_with_usage();
      }

      char *colon_pointer = strchr(proxy_target, ':');
      if (colon_pointer != NULL) {
        *colon_pointer = '\0';
        server_proxy_hostname = proxy_target;
        server_proxy_port = atoi(colon_pointer + 1);
      } else {
        server_proxy_hostname = proxy_target;
        server_proxy_port = 80;
      }
    } else if (strcmp("--port", argv[i]) == 0) {
      char *server_port_string = argv[++i];
      if (!server_port_string) {
        fprintf(stderr, "Expected argument after --port\n");
        exit_with_usage();
      }
      server_port = atoi(server_port_string);
    } else if (strcmp("--help", argv[i]) == 0) {
      exit_with_usage();
    } else {
      fprintf(stderr, "Unrecognized option: %s\n", argv[i]);
      exit_with_usage();
    }
  }

  serve_forever(&server_fd, request_handler);

  return EXIT_SUCCESS;
}
