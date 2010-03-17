	.file	"prime1.c"
	.section	.rodata
.LC0:
	.string	"\nENTER THE NUMBER\n"
.LC1:
	.string	"%d"
.LC2:
	.string	"%d IS a prime number\n"
	.align 32
.LC3:
	.string	"%d IS NOT a prime number\nIt is divisible by %d\n"
	.text
.globl main
	.type	main,@function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	andl	$-16, %esp
	movl	$0, %eax
	subl	%eax, %esp
	movl	$0, -12(%ebp)
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	subl	$8, %esp
	leal	-4(%ebp), %eax
	pushl	%eax
	pushl	$.LC1
	call	scanf
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	movl	$2, -8(%ebp)
.L2:
	movl	-8(%ebp), %eax
	cmpl	-4(%ebp), %eax
	jl	.L5
	jmp	.L3
.L5:
	cmpl	$0, -12(%ebp)
	jne	.L4
	movl	-4(%ebp), %edx
	movl	%edx, %eax
	cltd
	idivl	-8(%ebp)
	testl	%edx, %edx
	jne	.L4
	movl	-8(%ebp), %eax
	movl	%eax, -12(%ebp)
.L4:
	leal	-8(%ebp), %eax
	incl	(%eax)
	jmp	.L2
.L3:
	cmpl	$0, -12(%ebp)
	jne	.L8
	subl	$8, %esp
	pushl	-4(%ebp)
	pushl	$.LC2
	call	printf
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	jmp	.L9
.L8:
	subl	$4, %esp
	pushl	-12(%ebp)
	pushl	-4(%ebp)
	pushl	$.LC3
	call	printf
	addl	$16, %esp
	movl	%eax, -16(%ebp)
.L9:
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
