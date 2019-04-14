.align    4
.globl    uthread_switch
.globl    _uthread_switch
uthread_switch:
_uthread_switch: ##arg from to
    movl 4(%esp), %eax 
    movl %ebp, 0(%eax)
    movl %esp, 4(%eax)
    movl %ebx, 8(%eax)
    movl %edi, 12(%eax)
    movl %esi, 16(%eax)
    movl 8(%esp), %eax
    movl 0(%eax), %ebp 
    movl 4(%eax), %esp
    movl 8(%eax), %ebx
    movl 12(%eax),%edi
    movl 16(%eax),%esi
    ret
.align    4
.globl    uthread_run1
.globl    _uthread_run1
uthread_run1:
_uthread_run1: ##arg u_context
    movl 4(%esp),%eax
    movl %ebp,20(%eax) #save register
    movl %esp,24(%eax)
    movl %ebx,28(%eax)
    movl %edi,32(%eax)
    movl %esi,36(%eax)
    movl 12(%esp),%ecx #get arg
    movl 8(%esp),%edx #get st_fun
    movl 0(%eax),%esp  #change stack
    movl %esp,%ebp
    pushl %eax
    pushl %ecx     #push arg
    call  *%edx    #call st_fun
    popl  %eax
    popl  %eax
    movl 20(%eax),%ebp    #restore register
    movl 24(%eax),%esp
    movl 28(%eax),%ebx
    movl 32(%eax),%edi
    movl 36(%eax),%esi
    movl $1,44(%eax)
    ret
.align    4
.globl    uthread_run2
.globl    _uthread_run2
uthread_run2:#param p,u,start_fun,arg
_uthread_run2:
    movl 4(%esp),%eax  #get p
    movl %ebp,0(%eax) #save register of p
    movl %esp,4(%eax)
    movl %ebx,8(%eax)
    movl %edi,12(%eax)
    movl %esi,16(%eax)
    movl 8(%esp),%eax  #get u
    movl 16(%esp),%ecx #get arg
    movl 12(%esp),%edx #get st_fun
    movl 0(%eax),%esp  #change stack
    movl %esp,%ebp
    pushl %eax
    pushl %ecx     #push arg
    call  *%edx    #call st_fun
    popl  %eax
    popl  %eax
    movl $1,44(%eax)
    movl 40(%eax),%eax   #get parent
    movl 0(%eax),%ebp    #restore register
    movl 4(%eax),%esp
    movl 8(%eax),%ebx
    movl 12(%eax),%edi
    movl 16(%eax),%esi
    ret