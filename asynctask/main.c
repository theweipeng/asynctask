#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "task.h"


void* fun2()
{
    printf("%s", "fun2 start\n");
    task_yield();
    printf("%s", "fun2 end\n");
    return 2;
}

void* fun1()
{
    printf("%s", "fun1 start\n");
    int a = task_await(task_run(10, 4096, fun2));
    printf("%d", a);
    printf("%s", "fun1 end\n");
    return 0;
}


int main()
{
    task_run(10, 4096, fun1);
    start_loop();
    return 0;
}
