#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "task.h"


void fun2()
{
    printf("%s", "fun2 start\n");
    task_yield();
    printf("%s", "fun2 end\n");
}

void fun1()
{
    printf("%s", "fun1 start\n");
    task_yield();
    printf("%s", "fun1 end\n");
}

void fun3()
{
    printf("%s", "fun3 start\n");
    task_yield();
    printf("%s", "fun3 end\n");
}

void fun4()
{
    printf("%s", "fun4 start\n");
    printf("%s", "fun4 end\n");
}

int main()
{
    char *s = malloc(4096);
    task_run(10, 4096, fun1);
    task_run(10, 4096, fun2);
    task_run(10, 4096, fun3);
    task_run(10, 4096, fun4);
    start_loop();
    return 0;
}
