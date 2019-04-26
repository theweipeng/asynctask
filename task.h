typedef void* (*start_fun)();
struct taskinfo
{
    //0:rbp,1:rsp,2:rbx, 3: rip
    // 参数  4:rdi, 5:rsi, 6 %rdx, 7 %rcx, 8 %r8, 9 %r9
    u_int64_t reg[10];
    u_int64_t result;
    u_int64_t waitaddr;
    u_int64_t parent;
    void *stack;
    start_fun _start_fun;
    u_int64_t stack_size;
};


typedef struct taskinfo taskinfo_t;



typedef struct task task_t;
struct task
{
    int status; // 0: stop 1: running 2: new 3: waiting
    taskinfo_t handler;
};
task_t* task_run(u_int64_t stack_size, start_fun _start_fun, u_int64_t args[]);
void task_yield();
void start_loop();
void* task_await(task_t*);
void init_loop();