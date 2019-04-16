#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "task.c"

void fun3(void *arg)
{
    printf("%s", "fun3 start");
    task_yield();
    printf("%s", "fun3 end");
}

void fun2(void *arg)
{
    printf("%s", "fun2 start");
    task_yield();
    printf("%s", "fun2 end");
}

void fun1(void *arg)
{
    printf("%s", "fun1 start");
    task_yield();
    printf("%s", "fun1 end");
}

int main()
{
    char *s = malloc(4096); 
    task_run(10, 4096, fun1);
    task_run(10, 4096, fun2);
    start_loop();
    return 0;
}