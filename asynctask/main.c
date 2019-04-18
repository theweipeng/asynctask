#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "task.h"


void fun2()
{
    printf("%s", "jahah");
    task_yield();
    int aa = 1 + 1;
}

void fun1()
{
    printf("%s", "jahah");
    task_yield();
    printf("%s", "jahah");
}

int main()
{
    char *s = malloc(4096);
    task_run(10, 4096, fun1);
    task_run(10, 4096, fun2);
    start_loop();
    return 0;
}
