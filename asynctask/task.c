#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include "task.h"


void store(taskinfo_t* t);

void restore(taskinfo_t* t);

void run_and_store(taskinfo_t* t, start_fun _start_fun);

void run_and_restore(taskinfo_t* t, start_fun _start_fun);


#define TASKLENGTH 3
#define TASKDONEFLAG 108

int current;
int currenttaskflag;
task_t main_task;
task_t tasks[TASKLENGTH];
task_t main_task = {0,0};


void set_currenttaskflag_done() {
    currenttaskflag = 0;
}

void set_currenttaskflag_running() {
    currenttaskflag = 1;
}

task_t* push_task(taskinfo_t t)
{
    for (int i = 0; i < TASKLENGTH; i++)
    {
        if(!tasks[i].status) {
            tasks[i].status = 2;
            tasks[i].handler = t;
            return &tasks[i];
        }
    }
    return 0;
}

void start_loop()
{
    main_task.status = 1;
    while (1)
    {
        for (int i = 0; i < TASKLENGTH; i++)
        {
            if(tasks[i].status == 1)
            {
                current = i;
                run_and_restore(&(main_task.handler), &(tasks[i].handler));
                
                if (currenttaskflag == 0) {
                    tasks[i].status = 0;
                    tasks[tasks[i].handler.parent].status = 1;
                    tasks[tasks[i].handler.parent].handler.result = 886;
                }
            } else if (tasks[i].status == 2)
            {
                current = i;
                tasks[i].status = 1;
                run_and_restore(&(main_task.handler), &(tasks[i].handler));
                if (currenttaskflag == 0) {
                    tasks[i].status = 0;
                    tasks[tasks[i].handler.parent].status = 1;
                    tasks[tasks[i].handler.parent].handler.result = 886;
                }
            }
        }
    }
}

void set_task_stop() {
    tasks[current].status = 0;
}

void task_switch_to_main() {
    current = -1;
    restore(&(main_task.handler));
}

typedef void* (*task_switch_to_main_fun)();

task_switch_to_main_fun get_fun_to_switch_to_main() {
    return task_switch_to_main;
}

taskinfo_t* get_current_taskinfo() {
    return &(tasks[current].handler);
}

void set_current_task_done() {
    tasks[current].status = 0;
}

task_t* task_run(u_int64_t stack_size, start_fun _start_fun)
{
    taskinfo_t u;
    void* stack = malloc(stack_size);
    u.stack = stack;
    u.stack_size = stack_size;
    u.reg[0] = u.stack + stack_size;
    u.reg[1] = u.stack + stack_size - 8;
    u.reg[4] = _start_fun;
    u._start_fun = _start_fun;
    u.parent = current;
    u.result = 0;
    return push_task(u);
}

void* get_result() {
    return tasks[current].handler.result;
}

void set_result(void* result) {
    tasks[tasks[current].handler.parent].status = 1;
    tasks[tasks[current].handler.parent].handler.result = result;
}

void set_waiting() {
    tasks[tasks[current].handler.parent].status = 3;
}

void set_waitaddr(u_int64_t a){
    tasks[current].handler.waitaddr = a;
}

u_int64_t get_waitaddr(){
    return tasks[current].handler.waitaddr;
}

void* get_ret_addr(){
    return tasks[current].handler.stack + tasks[current].handler.stack_size;
}
