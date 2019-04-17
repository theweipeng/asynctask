#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "task.h"

void fun3()
{
    task_yield();
}

void fun2()
{
    int aa2 = 1 + 1;
    task_yield();
    int aa = 1 + 1;
}

void fun1()
{
    int aa2 = 1 + 1;
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
