#ifndef _UTHREAD_H
#define _UTHREAD_H

typedef void* (*start_fun)(void *); 
typedef struct uthread* uthread_t;

uthread_t uthread_create(void *stack, int stack_size);

void uthread_destroy(uthread_t*);

void uthread_make(uthread_t u,uthread_t p,start_fun st_fun);

void* uthread_switch(uthread_t from,uthread_t to);


#endif