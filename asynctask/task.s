.align    4
.globl    store
.globl    _store
store:
_store: 
    popq %r8
    movq %rbp, 0(%rdi)
    movq %rsp, 8(%rdi)
    movq %rbx, 16(%rdi)
    movq %rdi, 24(%rdi)
    movq %r8, 32(%rdi)
    push %r8
    retq


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
.globl   run_and_store
.globl    _run_and_store
run_and_store:
_run_and_store: 
    popq %r8
    movq %rbp, 0(%rdi)
    movq %rsp, 8(%rdi)
    movq %rbx, 16(%rdi)
    movq %rdi, 24(%rdi)
    movq %r8, 32(%rdi)
    push %r8
    popq %rdx
    callq *%rsi
    callq _set_current_task_done
    callq _task_switch_to_main

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

    movq 0(%rsi), %rbp 
    movq 8(%rsi), %rsp
    movq 16(%rsi), %rbx
    movq 24(%rsi),%rdi
    movq 32(%rsi),%rsi

    callq _set_currenttaskflag_done

    jmp *%rsi

.align    4
.globl   run_and_store2
.globl    _run_and_store2
run_and_store2:
_run_and_store2:
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
    call _set_currenttaskflag_running
    call _get_current_taskinfo
    movq %rax, %rdi
    call _get_fun_to_switch_to_main
    movq %rax, %rsi
    jmp _run_and_store2

