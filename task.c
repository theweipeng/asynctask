#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>


typedef void* (*start_fun)(); 

struct taskinfo
{
    //0:rbp,1:rsp,2:rbx,3:rdi,4:rsi
    u_int64_t reg[5];
    void *stack;
    start_fun _start_fun;
    void *start_arg;
    u_int64_t stack_size;
};
typedef struct taskinfo taskinfo_t;

struct task
{
    int status; // 0: stop 1: running 2: new
    taskinfo_t handler;
};

typedef struct task task_t;

void store(taskinfo_t* t);

void restore(taskinfo_t* t);

void run_and_store(taskinfo_t* t, start_fun _start_fun);

void run_and_restore(taskinfo_t* t, start_fun _start_fun);


#define TASKLENGTH 10

task_t* current;
task_t tasks[TASKLENGTH];
task_t main_task = {0,0};


void push_task(taskinfo_t t)
{
    for (int i = 0; i < TASKLENGTH; i++)
    {
        if(!tasks[i].status) {
            tasks[i].status = 2;
            tasks[i].handler = t;
            return;
        }
    }
}

void start_loop()
{
    current = &main_task;
    current->status = 1;
    while (1)
    {
        for (int i = 0; i < TASKLENGTH; i++)
        {
            task_t u = tasks[i];
            if(u.status == 1)
            {
                current = &u;
                run_and_restore(&(main_task.handler), &(u.handler));
            } else if (u.status == 2)
            {
                current = &u;
                tasks[i].status = 1;
                run_and_store(&(main_task.handler), u.handler._start_fun);
                printf("%s", "hfe");
            }
        }
    }
}

void task_switch_to_main() {
    current = &main_task;
    restore(&(main_task.handler));
}

void task_yield()
{
    run_and_store(&(current->handler), task_switch_to_main);
}

void task_run(void *stack, int stack_size, start_fun _start_fun)
{
    taskinfo_t u;
    u.stack = stack;
    u.stack_size = stack_size;
    u.reg[0] = (uint32_t)stack+stack_size;
    u.reg[4] = (uint32_t)stack+stack_size;
    u._start_fun = _start_fun;
    push_task(u);
}
