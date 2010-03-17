	.file	"prime2.c"
	.section	.rodata
.LC0:
	.string	"\nEnter the two numbers\n"
.LC1:
	.string	"%d %d"
.LC2:
	.string	"%d\t"
.LC3:
	.string	"\n"
	.text
.globl main
	.type	main,@function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	andl	$-16, %esp
	movl	$0, %eax
	subl	%eax, %esp
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	movl	%eax, -24(%ebp)
	subl	$4, %esp
	leal	-16(%ebp), %eax
	pushl	%eax
	leal	-12(%ebp), %eax
	pushl	%eax
	pushl	$.LC1
	call	scanf
	addl	$16, %esp
	movl	%eax, -24(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, -4(%ebp)
.L2:
	movl	-4(%ebp), %eax
	cmpl	-16(%ebp), %eax
	jle	.L5
	jmp	.L3
.L5:
	movl	$0, -20(%ebp)
	movl	$2, -8(%ebp)
.L6:
	movl	-8(%ebp), %eax
	cmpl	-4(%ebp), %eax
	jl	.L9
	jmp	.L7
.L9:
	cmpl	$0, -20(%ebp)
	jne	.L8
	movl	-4(%ebp), %edx
	movl	%edx, %eax
	cltd
	idivl	-8(%ebp)
	testl	%edx, %edx
	jne	.L8
	movl	-4(%ebp), %eax
	movl	%eax, -20(%ebp)
.L8:
	leal	-8(%ebp), %eax
	incl	(%eax)
	jmp	.L6
.L7:
	cmpl	$0, -20(%ebp)
	jne	.L4
	subl	$8, %esp
	pushl	-4(%ebp)
	pushl	$.LC2
	call	printf
	addl	$16, %esp
	movl	%eax, -24(%ebp)
.L4:
	leal	-4(%ebp), %eax
	incl	(%eax)
	jmp	.L2
.L3:
	subl	$12, %esp
	pushl	$.LC3
	call	printf
	addl	$16, %esp
	movl	%eax, -24(%ebp)
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
