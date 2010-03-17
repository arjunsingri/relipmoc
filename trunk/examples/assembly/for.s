	.file	"for.c"
.globl i
	.data
	.align 4
	.type	i,@object
	.size	i,4
i:
	.long	3
	.text
.globl main
	.type	main,@function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	andl	$-16, %esp
	movl	$0, %eax
	subl	%eax, %esp
	movl	var, %eax
	movl	%eax, i
.L2:
	cmpl	$9, i
	jle	.L5
	jmp	.L3
.L5:
	incl	var
	incl	i
	jmp	.L2
.L3:
	cmpl	$10, var
	jle	.L6
	movl	i, %eax
	cltd
	idivl	var
	movl	%eax, var
	jmp	.L7
.L6:
	movl	i, %eax
	negl	%eax
	xorl	%eax, var
.L7:
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.comm	var,4,4
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
