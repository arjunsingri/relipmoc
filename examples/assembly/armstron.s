	.file	"armstron.c"
	.section	.rodata
.LC0:
	.string	"Enter the number : "
.LC1:
	.string	"%ld"
	.align 32
.LC2:
	.string	"The armstrong number upto %d are\n"
.LC3:
	.string	"%ld\n"
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
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	subl	$8, %esp
	leal	-4(%ebp), %eax
	pushl	%eax
	pushl	$.LC1
	call	scanf
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	subl	$8, %esp
	pushl	-4(%ebp)
	pushl	$.LC2
	call	printf
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	movl	$1, -8(%ebp)
.L2:
	movl	-8(%ebp), %eax
	cmpl	-4(%ebp), %eax
	jle	.L5
	jmp	.L3
.L5:
	subl	$12, %esp
	pushl	-8(%ebp)
	call	isarmstrong
	addl	$16, %esp
	testl	%eax, %eax
	je	.L4
	subl	$8, %esp
	pushl	-8(%ebp)
	pushl	$.LC3
	call	printf
	addl	$16, %esp
	movl	%eax, -12(%ebp)
.L4:
	leal	-8(%ebp), %eax
	incl	(%eax)
	jmp	.L2
.L3:
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
.globl isarmstrong
	.type	isarmstrong,@function
isarmstrong:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$10, -20(%ebp)
	movl	$0, -8(%ebp)
	movl	$0, -4(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	%eax, -12(%ebp)
.L8:
	cmpl	$0, 8(%ebp)
	jne	.L10
	jmp	.L9
.L10:
	movl	-20(%ebp), %edx
	movl	8(%ebp), %eax
	movl	%edx, %ecx
	cltd
	idivl	%ecx
	movl	%eax, 8(%ebp)
	leal	-4(%ebp), %eax
	incl	(%eax)
	jmp	.L8
.L9:
	nop
.L11:
	cmpl	$0, -12(%ebp)
	jne	.L13
	jmp	.L12
.L13:
	subl	$8, %esp
	pushl	-4(%ebp)
	movl	-20(%ebp), %edx
	movl	-12(%ebp), %eax
	movl	%edx, %ecx
	cltd
	idivl	%ecx
	pushl	%edx
	call	power
	addl	$16, %esp
	movl	%eax, %edx
	leal	-8(%ebp), %eax
	addl	%edx, (%eax)
	movl	-20(%ebp), %edx
	movl	-12(%ebp), %eax
	movl	%edx, %ecx
	cltd
	idivl	%ecx
	movl	%eax, -12(%ebp)
	jmp	.L11
.L12:
	movl	-16(%ebp), %eax
	cmpl	-8(%ebp), %eax
	jne	.L14
	movl	$1, -24(%ebp)
	jmp	.L7
.L14:
	movl	$0, -24(%ebp)
.L7:
	movl	-24(%ebp), %eax
	leave
	ret
.Lfe2:
	.size	isarmstrong,.Lfe2-isarmstrong
.globl isprime
	.type	isprime,@function
isprime:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$1, -12(%ebp)
	movl	$2, -4(%ebp)
.L16:
	movl	-4(%ebp), %eax
	imull	-4(%ebp), %eax
	cmpl	8(%ebp), %eax
	jle	.L19
	jmp	.L17
.L19:
	movl	8(%ebp), %edx
	movl	%edx, %eax
	cltd
	idivl	-4(%ebp)
	testl	%edx, %edx
	jne	.L18
	movl	$0, -12(%ebp)
.L18:
	leal	-4(%ebp), %eax
	addl	$2, (%eax)
	jmp	.L16
.L17:
	movl	-12(%ebp), %eax
	leave
	ret
.Lfe3:
	.size	isprime,.Lfe3-isprime
.globl power
	.type	power,@function
power:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$1, -4(%ebp)
	movl	$1, -8(%ebp)
.L22:
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jle	.L25
	jmp	.L23
.L25:
	movl	-4(%ebp), %eax
	imull	8(%ebp), %eax
	movl	%eax, -4(%ebp)
	leal	-8(%ebp), %eax
	incl	(%eax)
	jmp	.L22
.L23:
	movl	-4(%ebp), %eax
	leave
	ret
.Lfe4:
	.size	power,.Lfe4-power
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
