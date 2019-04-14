#include <stdint.h>
#include "uthread.h"
#include <stdlib.h>
#include <stdio.h>

struct uthread
{
    //0:ebp,1:esp,2:ebx,3:edi,4:esi
    uint32_t reg[5];
    uint32_t parent_reg[5];
    struct uthread *parent;//如果_parent非空,则_start_fun结束后返回到_parent中
    uint32_t __exit;//主函数调用完成设置
    void *stack;
    start_fun _start_fun;
    void *start_arg;
    uint32_t stack_size;
};

uthread_t uthread_create(void *stack, int stack_size)
{
    uthread_t u = calloc(1,sizeof(*u));
    u->stack = stack;
    u->stack_size = stack_size;
    u->reg[0] = (uint32_t)stack+stack_size;
    u->reg[4] = (uint32_t)stack+stack_size;
    u->__exit = 0;
    return u;
}

extern void uthread_run1(uthread_t u,start_fun st_fun,void *arg);
extern void uthread_run2(uthread_t p,uthread_t u,start_fun st_fun,void *arg);

void uthread_run(uthread_t p,uthread_t u,start_fun st_fun,void *arg)
{
    u->parent = p;
    if(u->parent)
    {
        uthread_run2(p,u,st_fun,arg);
        if(u->__exit)
            uthread_switch(u,p);
    }
    else
    {
        uthread_run1(u,st_fun,arg);
    }
}


void uthread_destroy(uthread_t *u)
{
    free(*u);
    *u = 0;
}