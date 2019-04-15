.align    4
.globl    uthread_switch
.globl    _uthread_switch
uthread_switch:
_uthread_switch: ##arg from to
    pushq %rbp
    movq -4(%rsp), %rbp
    movq %rsp, 4(%rbp)
    movq %rbx, 8(%rbp)
    movq %rdi, 12(%rbp)
    movq %rsi, 16(%rbp)
    pushq %rax
    movq %rax, 0(%rbp)

    movq 4(%rbp), %rsp
    movq 8(%rbp), %rbx
    movq 12(%rbp),%rdi
    movq 16(%rbp),%rsi
    movq 0(%rbp), %rbp 

    retq
.align    4
.globl    uthread_run1
.globl    _uthread_run1
uthread_run1:
_uthread_run1: ##arg u_context
    movq -24(%rsp),%rax

    movq %rbp,20(%rax)
    movq %rsp,24(%rax)
    movq %rbx,28(%rax)
    movq %rdi,32(%rax)
    movq %rsi,36(%rax)

    movq %rdx, %rdi # 参数
    call  *%rsi # 函数

    movq 20(%rax),%rbp    # 恢复寄存器现场
    movq 24(%rax),%rsp
    movq 28(%rax),%rbx
    movq 32(%rax),%rdi
    movq 36(%rax),%rsi
    ret
.align    4
.globl    uthread_run2
.globl    _uthread_run2
uthread_run2:#param p,u,start_fun,arg
_uthread_run2:
    movq 4(%rsp),%rax  #get p
    movq %rbp,0(%rax) #save register of p
    movq %rsp,4(%rax)
    movq %rbx,8(%rax)
    movq %rdi,12(%rax)
    movq %rsi,16(%rax)
    movq 8(%rsp),%rax  #get u
    movq 16(%rsp),%rcx #get arg
    movq 12(%rsp),%rdx #get st_fun
    movq 0(%rax),%rsp  #change stack
    movq %rsp,%rbp
    pushq %rax
    pushq %rcx     #push arg
    callq  *%rdx    #call st_fun
    popq  %rax
    popq  %rax
    movq $1,44(%rax)
    movq 40(%rax),%rax   #get parent
    movq 0(%rax),%rbp    #restore register
    movq 4(%rax),%rsp
    movq 8(%rax),%rbx
    movq 12(%rax),%rdi
    movq 16(%rax),%rsi
    ret