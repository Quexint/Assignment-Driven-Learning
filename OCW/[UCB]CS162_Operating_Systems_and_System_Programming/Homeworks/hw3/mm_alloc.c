/*
 * mm_alloc.c
 *
 * Stub implementations of the mm_* routines.
 */

#include "mm_alloc.h"
#include <stdlib.h>
#include <sys/resource.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <stddef.h>

#define container_of(ptr, type, member) ({ \
    const typeof( ((type *)0)->member ) * __mptr = (ptr); \
    (type *)( (char *)__mptr - offsetof(type, member) );})

struct free_list_node
{
  struct free_list_node *prev, *next;
  char isFree;
  int size;
};

struct free_list_node *root = NULL;

int max(const int a, const int b){ return (a>b?a:b); }
int min(const int a, const int b){ return (a<b?a:b); }

void free_list_node_init(struct free_list_node *ptr, struct free_list_node *prevNode, struct free_list_node *nextNode, char isF, int sz)
{
  ptr->prev = prevNode;
  ptr->next = nextNode;
  ptr->isFree = isF;
  ptr->size = sz;
}

void trace_list(){
  struct free_list_node *itr;
  printf("*********** Mem List *************\n");
  for(itr = root; itr != NULL; itr = itr->next){
    printf("itr %p: prev %p next %p isFree %d size %d\n", itr, itr->prev, itr->next, itr->isFree, itr->size);
  }
}

int free_list_chk()
{
  struct free_list_node *itr;
  for(itr = root; itr != NULL; itr = itr->next){
    if((itr->next) != NULL && (itr->next->prev != itr)) return 0;
  }
  return 1;
}

void *mm_malloc(size_t alloc_size) {
  struct free_list_node **ptr = &root;

  /* Why use <= not < ? Mem after ptr: alloc_size | (sizeof(node) | Some Mem at least 1 byte */
  while(! ( (*ptr)==NULL || ((*ptr)->isFree == 1 && ((*ptr)->size) > alloc_size + sizeof(struct free_list_node))))
    ptr = &((*ptr)->next);

  void *addr;

  if((*ptr) == NULL){
    /* No available space */
    struct free_list_node *newNode = sbrk((int)sizeof(struct free_list_node) + (int)alloc_size);
    if(newNode == (void*)-1) return NULL;

    if(ptr == &root){
      /* The 1st allocation (root:NULL) */
      root = newNode;
      free_list_node_init(newNode, NULL, NULL, 0, alloc_size);
    }else{
      struct free_list_node *lastNode = container_of(ptr, struct free_list_node, next);

      lastNode->next = newNode;
      free_list_node_init(newNode, lastNode, NULL, 0, alloc_size);
    }

    addr = (char*)newNode + sizeof(struct free_list_node);
  }else{
    struct free_list_node *availableNode = *ptr;
    struct free_list_node *reallocNode = (struct free_list_node *)((char *)availableNode + sizeof(struct free_list_node) + alloc_size);
    int reallocSize = (availableNode->size) - alloc_size - sizeof(struct free_list_node);

    if(availableNode->next != NULL) availableNode->next->prev = reallocNode;
    free_list_node_init(reallocNode, availableNode, availableNode->next, 1, reallocSize);
    free_list_node_init(availableNode, availableNode->prev, reallocNode, 0, alloc_size);

    addr = (char*)availableNode + sizeof(struct free_list_node);
  }
  return addr;
}

void *mm_realloc(void *ptr, size_t size)
{
  if(size <= 0) return NULL;

  struct free_list_node *itr;
  struct free_list_node *reallocNode = (struct free_list_node *)((char *)ptr - sizeof(struct free_list_node));
  void *memSrc = ptr, *memTar = NULL;

  if(reallocNode->size >= size) return memSrc;

  /* Eat the node behind ptr, if possible */
  if(reallocNode->next != NULL && (reallocNode->next->isFree) == 1 && (reallocNode->size) + sizeof(struct free_list_node) + (reallocNode->next->size) >= size){
    struct free_list_node *nextNode = reallocNode->next;
    reallocNode->next = nextNode->next;
    if(nextNode->next != NULL) nextNode->next->prev = reallocNode;
    reallocNode->size += sizeof(struct free_list_node) + (nextNode->size);
    return memSrc;
  }

  for(itr = root; itr != NULL && !(itr->isFree && itr->size >= size); itr = itr->next);
  /* Find a slot */
  if(itr != NULL){
    memTar= (char *)itr + sizeof(struct free_list_node);
    memcpy(memTar, memSrc, min(size, reallocNode->size));
    reallocNode->isFree = 1;
    itr->isFree = 0;
    return memTar;
  }

  /* Realloc new space */
  memTar = mm_malloc(size);
  if(memTar != NULL){
    memcpy(memTar, memSrc, min(size, reallocNode->size));
    reallocNode->isFree = 1;
    return memTar;
  }
  return NULL;
}

int isLegelAllocPtr(void *ptr){
  struct free_list_node *itr;
  for(itr = root; itr != NULL && (char*)itr + sizeof(struct free_list_node) != ptr; itr = itr->next);
  return itr != NULL;
}

void *mm_free(void *ptr)
{
  if(ptr == NULL) return NULL;

  /* check whether the pointer is in the free_list */
  if(!isLegelAllocPtr(ptr)) return NULL;

  struct free_list_node *freeNode = (struct free_list_node *)((char *)ptr - sizeof(struct free_list_node));
  freeNode->isFree = 1;

  /* merge if the next node is free */
  if((freeNode->next != NULL) && (freeNode->next->isFree == 1)){
    struct free_list_node *nextNode = freeNode->next;
    if(nextNode->next != NULL) nextNode->next->prev = freeNode;
    freeNode->next = nextNode->next;
    freeNode->size += (nextNode->size) + sizeof(struct free_list_node);
  }
  /* merge if the previous node is free */
  if((freeNode->prev != NULL) && (freeNode->prev->isFree == 1)){
    struct free_list_node *prevNode = freeNode->prev;
    if(freeNode->next != NULL) freeNode->next->prev = prevNode;
    prevNode->next = freeNode->next;
    prevNode->size += (freeNode->size) + sizeof(struct free_list_node);
    freeNode = prevNode;
  }

  return NULL;
}
