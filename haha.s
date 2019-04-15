	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 13
	.globl	_ha                     ## -- Begin function ha
	.p2align	4, 0x90
_ha:                                    ## @ha
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rdx
	movl	$0, (%rdx)
	movq	-8(%rbp), %rdx
	movl	$1, 4(%rdx)
	movq	-16(%rbp), %rdx
	movl	$0, (%rdx)
	movq	-16(%rbp), %rdx
	movl	$1, 4(%rdx)
	movq	-24(%rbp), %rdx
	movl	$0, (%rdx)
	movq	-24(%rbp), %rdx
	movl	$1, 4(%rdx)
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movl	$0, -4(%rbp)
	movl	$1, -8(%rbp)
	movl	$2, -12(%rbp)
	movq	-24(%rbp), %rdi
	movq	-32(%rbp), %rsi
	movq	-40(%rbp), %rdx
	callq	_ha
	movl	-8(%rbp), %eax
	addl	-12(%rbp), %eax
	movq	-24(%rbp), %rdx
	addl	(%rdx), %eax
	movl	%eax, -44(%rbp)
	movl	-44(%rbp), %eax
	addq	$48, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function

.subsections_via_symbols
