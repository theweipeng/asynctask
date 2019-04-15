.align    4
.globl    uthread_switch
.globl    _uthread_switch
uthread_switch:
_uthread_switch: ##arg from to
    pushq %rbp
    pushq %rax
    movq %rbp, 0(%rdi)
    movq %rsp, 8(%rdi)
    movq %rbx, 16(%rdi)
    movq %rdi, 24(%rdi)
    movq %rsi, 32(%rdi)

    movq 0(%rsi), %rbp 
    movq 8(%rsi), %rsp
    movq 16(%rsi), %rbx
    movq 24(%rsi),%rdi
    movq 32(%rsi),%rsi
    jmp *%rsi
.align    4
.globl    uthread_run2
.globl    _uthread_run2
uthread_run2:#param p,u,start_fun,arg
_uthread_run2:
    popq %r8
    movq %rdi,%rax # parent  rcx
    movq %rbp,40(%rax) # save parent
    movq %rsp,48(%rax)
    movq %rbx,56(%rax)
    movq %rdi,64(%rax)
    movq %r8,72(%rax)
    pushq %r8
    movq %rcx, %rdi # 参数
    call  *%rdx # 函数
    movq 40(%rax),%rbp    # 恢复parent寄存器现场
    movq 48(%rax),%rsp
    movq 56(%rax),%rbx
    movq 64(%rax),%rdi
    movq 72(%rax),%rsi
    ret
.align    4
.globl    uthread_run1
.globl    _uthread_run1
uthread_run1:
_uthread_run1: ##arg u_context
    popq %r8
    movq %rbp,0(%rdi)
    movq %rsp,8(%rdi)
    movq %rbx,16(%rdi)
    movq %rdi,24(%rdi)
    movq %r8,32(%rdi)
    pushq %r8
    movq %rdx, %rdi # 参数
    call  *%rsi # 函数

    movq 0(%rdi),%rbp    # 恢复寄存器现场
    movq 8(%rdi),%rsp
    movq 16(%rdi),%rbx
    movq 24(%rdi),%rdi
    movq 32(%rdi),%rsi
    ret
