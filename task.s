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
    jmp *32(%rdi)

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

    callq *%rsi

    retq