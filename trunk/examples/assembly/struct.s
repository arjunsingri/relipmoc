	.file	"struct.c"
	.section	.rodata
.LC0:
	.string	"\ny.a = %d y.b = %d\n"
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
	movl	$234, -8(%ebp)
	movw	$3, -4(%ebp)
	movswl	-4(%ebp),%eax
	addl	-8(%ebp), %eax
	incl	%eax
	movl	%eax, -16(%ebp)
	movl	-4(%ebp), %eax
	addl	-8(%ebp), %eax
	movw	%ax, -12(%ebp)
	subl	$4, %esp
	movswl	-12(%ebp),%eax
	pushl	%eax
	pushl	-16(%ebp)
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
