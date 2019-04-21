.align    4
.globl    restore
.globl    _restore
restore:
_restore: 
    movq 0(%rdi), %rbp 
    movq 8(%rdi), %rsp
    movq 16(%rdi), %rbx
    movq 24(%rdi),%rdi
    movq 32(%rdi),%rsi
    jmp *%rsi

.align    4
.globl   get_fu_run_status
.globl    _get_fu_run_status
get_fu_run_status:
_get_fu_run_status:
    movq %r15, %rax
    retq

.align    4
.globl   run_and_restore
.globl    _run_and_restore
run_and_restore:
_run_and_restore: 
    popq %r8
    movq %rbp, 0(%rdi)
    movq %rsp, 8(%rdi)
    movq %rbx, 16(%rdi)
    movq %rdi, 24(%rdi)
    movq %r8, 32(%rdi)

    pushq %r8

    callq _get_ret_addr
    movq %r8, -8(%rax)

    movq 0(%rsi), %rbp 
    movq 8(%rsi), %rsp
    movq 16(%rsi), %rbx
    movq 24(%rsi),%rdi
    movq 32(%rsi),%rsi

    jmp *%rsi
    retq

.align    4
.globl   run_and_store
.globl    _run_and_store
run_and_store:
_run_and_store:
    movq %rbp, 0(%rdi)
    movq %rsp, 8(%rdi)
    movq %rbx, 16(%rdi)
    movq %rdi, 24(%rdi)
    movq %rdx, 32(%rdi)

    jmp *%rsi

.align    4
.globl   task_yield
.globl    _task_yield
task_yield:
_task_yield:
    popq %rdx
    call _get_current_taskinfo
    movq %rax, %rdi
    call _get_fun_to_switch_to_main
    movq %rax, %rsi
    jmp _run_and_store


.align    4
.globl   get_rip
.globl    _get_rip
get_rip:
_get_rip:
popq %rax
pushq %rax
retq


.running:
    popq %rdi
    pushq %rax
    callq _get_waitaddr
    movq %rax, %rdi
    popq %rax
    callq _get_result
    jmp *%rdi

.not_running:
    jmp _task_yield



.align    4
.globl   task_await
.globl    _task_await
task_await:
_task_await:
    callq _set_waiting
    popq %rdi
    callq _set_waitaddr
    push %rdi
    callq _get_rip
    pushq %rax

    callq _get_is_running
    movq %rax, %r12
    cmpq $0, %r12
    je .not_running
    jmp .running
