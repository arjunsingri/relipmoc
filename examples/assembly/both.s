	.file	"both.c"
.globl c
	.data
	.align 4
	.type	c,@object
	.size	c,4
c:
	.long	4
.globl d
	.align 4
	.type	d,@object
	.size	d,4
d:
	.long	343
	.section	.rodata
.LC0:
	.string	"%d%d%d"
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
	pushl	$c
	pushl	$b
	pushl	$a
	pushl	$.LC0
	call	scanf
	addl	$16, %esp
	movl	%eax, -4(%ebp)
	movl	b, %eax
	addl	a, %eax
	cmpl	c, %eax
	jle	.L2
	movl	b, %eax
	andl	%eax, a
.L3:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L5
	jmp	.L2
.L5:
	incl	a
	cmpl	$0, a
	je	.L6
	decl	a
	jmp	.L7
.L6:
	incl	a
.L7:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L8
	movl	b, %eax
	movl	%eax, a
.L9:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L11
	jmp	.L3
.L11:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L12
	movl	a, %eax
	cmpl	b, %eax
	jne	.L13
.L14:
	decl	a
	cmpl	$0, a
	jne	.L16
	jmp	.L9
.L16:
	movl	d, %eax
	cltd
	idivl	a
	movl	%edx, b
	movl	a, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	shrl	$31, %eax
	leal	(%eax,%edx), %eax
	sarl	$1, %eax
	movl	%eax, a
	jmp	.L14
.L13:
	incl	b
	jmp	.L9
.L12:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L9
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L9
.L8:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L3
	incl	c
	jmp	.L3
.L2:
	nop
.L22:
	movl	a, %eax
	cmpl	b, %eax
	jge	.L24
	jmp	.L23
.L24:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L25
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L22
.L25:
	incl	a
	jmp	.L22
.L23:
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.comm	a,4,4
	.comm	b,4,4
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
