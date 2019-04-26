#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "task.h"

int fun3(u_int64_t a, u_int64_t b, u_int64_t c)
{
    printf("%s", "fun3 start\n");
    int ha = a - b;
    task_yield();
    printf("%s", "fun3 end\n");
    printf("%d", a);
    printf("%s", "\n");
    printf("%d", b);
    printf("%s", "\n");
    printf("%d", c);
    printf("%s", "\n");
    printf("%d", ha);
    printf("%s", "\n");
    return 999;
}


int fun2()
{
    printf("%s", "fun2 start\n");
    task_yield();
    u_int64_t a2[] = {222, 333 , 444};
    int a = task_await(task_run(4096, fun3, a2));
    printf("%d", a);
    printf("%s", "fun2 end\n");
    return 19;
}

int fun1(u_int64_t s)
{
    printf("%s", "fun1 start\n");
    u_int64_t a2[] = {111};
    int a = task_await(task_run(4096, fun2, a2));
    printf("%d", a + s);
    printf("%s", "\n");
    printf("%s", "fun1 end\n");
    return 10086;
}

int fun4(u_int64_t s)
{

    printf("%s", "fun4 start\n");
    printf("%d", s);
    printf("%s", "fun4 end\n");
    return 10086;
}


int main()
{
    init_loop();
    u_int64_t a[] = {1};
    task_run(4096, fun1, a);
    task_run(4096, fun1, a);
    task_run(4096, fun4, a);
    start_loop();
    return 0;
}
