#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "task.c"

void fun3()
{
    task_yield();
}

void fun2()
{
    task_yield();
}

void fun1()
{
    task_yield();
    int aa = 1 + 1;
}

int main()
{
    char *s = malloc(4096); 
    task_run(10, 4096, fun1);
    task_run(10, 4096, fun2);
    start_loop();
    return 0;
}