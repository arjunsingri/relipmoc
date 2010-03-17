	.file	"fact.c"
	.section	.rodata
.LC0:
	.string	"Enter the number: "
.LC1:
	.string	"%d"
.LC2:
	.string	"The factorial of %d is %d\n"
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
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	movl	%eax, -8(%ebp)
	subl	$8, %esp
	leal	-4(%ebp), %eax
	pushl	%eax
	pushl	$.LC1
	call	scanf
	addl	$16, %esp
	movl	%eax, -8(%ebp)
	subl	$4, %esp
	subl	$8, %esp
	pushl	-4(%ebp)
	call	factorial
	addl	$12, %esp
	pushl	%eax
	pushl	-4(%ebp)
	pushl	$.LC2
	call	printf
	addl	$16, %esp
	movl	%eax, -8(%ebp)
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
.globl factorial
	.type	factorial,@function
factorial:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$1, -4(%ebp)
	movl	$1, -8(%ebp)
.L3:
	movl	-8(%ebp), %eax
	cmpl	8(%ebp), %eax
	jle	.L6
	jmp	.L4
.L6:
	movl	-4(%ebp), %eax
	imull	-8(%ebp), %eax
	movl	%eax, -4(%ebp)
	leal	-8(%ebp), %eax
	incl	(%eax)
	jmp	.L3
.L4:
	movl	-4(%ebp), %eax
	leave
	ret
.Lfe2:
	.size	factorial,.Lfe2-factorial
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
