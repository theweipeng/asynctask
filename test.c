#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "uthread.c"
#include "uthread.h"

struct pair
{
    uthread_t self;
    uthread_t other;
};


void fun2(void *arg)
{
    int i = 0;
    struct pair *p = (struct pair*)arg;
    uthread_switch(p->self,p->other);
}

void fun20() {
    printf("run12\n");
}

void fun1(void *arg)
{
    int i = 0;
    struct pair *p = (struct pair*)arg;
    char *s = malloc(10); 
    uthread_t u2 = uthread_create(s,4096);
    struct pair _p = {u2,p->self}; 
    uthread_run(p->self,u2,fun2,&_p);
    fun20();
    uthread_switch(p->self,u2);
}

int main()
{
    char *s = malloc(4096); 
    uthread_t u1 = uthread_create(s,4096);
    struct pair p = {u1,0};
    uthread_run(0,u1,fun1,&p);
    printf("return here\n");
    return 0;
}