typedef void* (*start_fun)();
struct taskinfo
{
    //0:rbp,1:rsp,2:rbx,3:rdi,4:rsi
    u_int64_t reg[5];
    u_int64_t result;
    u_int64_t waitaddr;
    u_int64_t parent;
    void *stack;
    start_fun _start_fun;
    void *start_arg;
    u_int64_t stack_size;
};


typedef struct taskinfo taskinfo_t;



typedef struct task task_t;
struct task
{
    int status; // 0: stop 1: running 2: new 3: waiting
    taskinfo_t handler;
};
task_t* task_run(u_int64_t stack_size, start_fun _start_fun);
void task_yield();
void start_loop();
void* task_await(task_t*);
