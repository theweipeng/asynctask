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
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %esi
	addl	-8(%rbp), %esi
	movl	%esi, %eax
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
	subq	$32, %rsp
	movl	$5, %edi
	movl	$6, %esi
	movl	$0, -4(%rbp)
	movl	$1, -8(%rbp)
	movl	$2, -12(%rbp)
	movl	-8(%rbp), %eax
	addl	-12(%rbp), %eax
	movl	%eax, -20(%rbp)         ## 4-byte Spill
	callq	_ha
	movl	-20(%rbp), %esi         ## 4-byte Reload
	addl	%eax, %esi
	movl	%esi, -16(%rbp)
	movl	-16(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function

.subsections_via_symbols
