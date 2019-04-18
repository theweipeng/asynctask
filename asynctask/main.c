#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "task.h"


void fun2()
{
    printf("%s", "fun2 start\n");
    task_yield();
    printf("%s", "fun2 end\n");
    printf("%s", "-----------\n");
}

void fun1()
{
    printf("%s", "fun1 start\n");
    task_yield();
    printf("%s", "fun1 end\n");
    printf("%s", "+++++++++++\n");
}

int main()
{
    char *s = malloc(4096);
    task_run(10, 4096, fun1);
    task_run(10, 4096, fun2);
    start_loop();
    return 0;
}
