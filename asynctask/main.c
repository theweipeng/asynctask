#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "task.h"


void fun2()
{
    printf("%s", "fun2 start\n");
    task_yield();
    printf("%s", "fun2 start2\n");
    task_yield();
    printf("%s", "fun2 start3\n");
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

    printf("%s", "fun3 end\n");
}

int main()
{
    task_run(10, 4096, fun1);
    task_run(10, 4096, fun2);
    task_run(10, 4096, fun3);
    start_loop();
    return 0;
}
