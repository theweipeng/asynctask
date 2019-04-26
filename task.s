.align    4
.globl    restore
.globl    _restore
restore:
_restore:
    movq 0(%rdi), %rbp
    movq 8(%rdi), %rsp
    movq 16(%rdi), %rbx
    movq 24(%rdi),%r15
    movq 32(%rdi),%rdi
    movq 40(%rdi), %rsi
    movq 48(%rdi), %rdx
    movq 56(%rdi), %rcx
    movq 64(%rdi), %r8
    movq 72(%rdi), %r9

    jmp *%r15

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
    popq %r15
    movq %rbp, 0(%rdi)
    movq %rsp, 8(%rdi)
    movq %rbx, 16(%rdi)
    movq %r15, 24(%rdi)
    movq %rdi, 32(%rdi)
    movq %rsi, 40(%rdi)
    movq %rdx, 48(%rdi)
    movq %rcx, 56(%rdi)
    movq %r8, 64(%rdi)
    movq %r9, 72(%rdi)

//0:rbp,1:rsp,2:rbx, 3: rip
    // 参数  4:rdi, 5:rsi, 6 %rdx, 7 %rcx, 8 %r8, 9 %r9

    pushq %r15

    pushq %rsi
    callq get_ret_addr
    movq %r15, -8(%rax)
    popq %rsi

    movq 0(%rsi), %rbp 
    movq 8(%rsi), %rsp
    movq 16(%rsi), %rbx
    movq 24(%rsi),%r15
    movq 32(%rsi),%rdi
    movq 48(%rsi), %rdx
    movq 56(%rsi), %rcx
    movq 64(%rsi), %r8
    movq 72(%rsi), %r9
    movq 40(%rsi), %rsi


    jmp *%r15
    retq


.align    4
.globl   task_yield
.globl    _task_yield
task_yield:
_task_yield:
    popq %r12

    call get_current_taskinfo
    movq %rax, %r13

    movq %rbp, 0(%r13)
    movq %rsp, 8(%r13)
    movq %rbx, 16(%r13)
    movq %r12, 24(%r13)
    movq %rdi, 32(%r13)
    movq %rsi, 40(%r13)
    movq %rdx, 48(%r13)
    movq %rcx, 56(%r13)
    movq %r8, 64(%r13)
    movq %r9, 72(%r13)


    call get_fun_to_switch_to_main
    movq %rax, %r12

    jmp *%r12


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
    popq %rdi
    
    callq get_waitaddr
    movq %rax, %r12

    callq get_result
    jmp *%r12

.not_running:
    jmp _task_yield



.align    4
.globl   task_await
.globl    _task_await
task_await:
_task_await:
    callq set_waiting
    popq %rdi
    callq set_waitaddr
    pushq %rdi

    callq _get_rip
    pushq %rax

    callq get_is_running
    movq %rax, %r12
    cmpq $0, %r12
    je .not_running
    jmp .running
