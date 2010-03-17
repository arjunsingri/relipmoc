	.file	"goto.c"
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	"Hello, world\n"
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
	subl	$8, %esp
	leal	-4(%ebp), %eax
	pushl	%eax
	pushl	$.LC0
	call	scanf
	addl	$16, %esp
	movl	%eax, -8(%ebp)
.L2:
	cmpl	$0, -4(%ebp)
	jle	.L3
	jmp	.L4
.L3:
	subl	$12, %esp
	pushl	$.LC1
	call	printf
	addl	$16, %esp
	movl	%eax, -8(%ebp)
	leal	-4(%ebp), %eax
	incl	(%eax)
	jmp	.L2
.L4:
	subl	$8, %esp
	pushl	-4(%ebp)
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	movl	%eax, -8(%ebp)
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
