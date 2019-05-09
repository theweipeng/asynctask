#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "task.h"

int fun3(u_int64_t a, u_int64_t b, u_int64_t c)
{
    task_yield();
    return a + b + c;
}


int fun2(u_int64_t s)
{
    task_yield();
    u_int64_t a2[] = {222, 333 , 444};
    auto a = task_await(task_run(4096, fun3, a2));
    return a + s;
}

int fun1(u_int64_t s)
{
    u_int64_t a2[] = {111};
    auto a = task_await(task_run(4096, fun2, a2));
    u_int64_t a3[] = {9999};
    auto v = task_await(task_run(4096, fun2, a3));
    printf("result %d", a + v + s);
    printf("\n");
    return a + v + s;
}

int fun4(u_int64_t s)
{
    return s;
}


int main()
{
    init_loop();
    u_int64_t a[] = {1};
    task_run(4096, fun1, a);

    u_int64_t b[] = {-22};
    task_run(4096, fun1, b);
    task_run(4096, fun4, b);
    start_loop();
    return 0;
}
