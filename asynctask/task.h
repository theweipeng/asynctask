typedef void* (*start_fun)();
void task_run(void *stack, int stack_size, start_fun _start_fun);
void task_yield();
void start_loop();
