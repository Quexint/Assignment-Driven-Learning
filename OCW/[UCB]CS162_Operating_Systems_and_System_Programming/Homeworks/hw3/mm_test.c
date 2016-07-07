/**
 * A simple test harness for memory alloction. You should augment this with your
 * own tests.
 */

#include <stdio.h>
#include "mm_alloc.h"
#include <string.h>
#include <time.h>
#include <assert.h>
#include <unistd.h>

#define kSize 10000
#define kMax 10

/* Test on kSize x 1D Array. */
char *data[kSize];
char ans[kSize][kMax];
int sz[kSize];
int n = 0;

int check_correctness()
{
  int i,j;
  for(i=0; i<n; i++)
    for(j=0; j<sz[i]; j++)
      if(data[i][j] != ans[i][j]) return 0;
  if(!free_list_chk()) return 0;
  return 1;
}

void test_assignment(int i)
{
  char x = 0xFF;
  int ele;
  for(ele=0; ele < sz[i]; ele++)
    *(data[i] + ele) = ans[i][ele] = x;
}

void test_allocation()
{
  /* The matrix is Full. */
  if(n == kSize) return ;
  /* Set the size of new array. */
  sz[n] = rand() % (kMax/2) + (kMax/2);
  data[n] = (char*)mm_malloc(sz[n]);
  test_assignment(n);
  n++;
}

void test_reallocation()
{
  if(n == kSize) return ;
  int i;
  for(i=0; i<n; i++){
    sz[i] = rand() % (kMax/2)+ (kMax/2);
    data[i] = (char*)mm_realloc(data[i], sz[i]);
    test_assignment(i);
  }
}

void test_free()
{
  if(n == 0) return ;
  if(n == 1) mm_free(data[0]);
  else{
    int kil = rand()%n;
    mm_free(data[kil]);
    if(kil != n-1){
      sz[kil] = sz[n-1];
      data[kil] = data[n-1];
      test_assignment(kil);
    }
  }
  n--;
}

int main(int argc, char **argv)
{
  int i,j;
  int op;
  int chk_times;
  n = 0;
  srand(time(0));

  for(chk_times = 1; chk_times < 300 * 10000; chk_times++){
    printf("Iteration %d op %d sbrk %p\n", chk_times, op, sbrk(0));
    op = rand() % 4;
    if(op == 0) test_allocation();
    if(op == 1) for(i=0; i<n; i++) test_assignment(i);
    if(op == 2) test_reallocation();
    if(op == 3) test_free();
    assert(check_correctness());
  }

  return 0;
}
