#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "task.h"

int fun3()
{
    printf("%s", "fun3 start\n");
    task_yield();
    printf("%s", "fun3 end\n");
    return 999;
}


int fun2()
{
    printf("%s", "fun2 start\n");
    task_yield();
    int a = task_await(task_run(4096, fun3));
    printf("%d", a);
    printf("%s", "fun2 end\n");
    return 0;
}

int fun1()
{
    printf("%s", "fun1 start\n");
    int a = task_await(task_run(4096, fun2));
    printf("%d", a);
    printf("%s", "\n");
    printf("%s", "fun1 end\n");
    return 10086;
}

int main()
{
    init_loop();
    task_run(4096, fun1);
    task_run(4096, fun1);
    start_loop();
    return 0;
}