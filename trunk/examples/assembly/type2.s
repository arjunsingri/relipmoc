	.file	"type2.c"
.globl a
	.data
	.type	a,@object
	.size	a,1
a:
	.byte	97
.globl c
	.align 4
	.type	c,@object
	.size	c,4
c:
	.long	1070537376
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
	movb	a, %al
	negl	%eax
	movb	%al, -1(%ebp)
	movb	a, %al
	movb	%al, -2(%ebp)
	movsbl	a,%eax
	negl	%eax
	movl	%eax, -8(%ebp)
	flds	c
	fnstcw	-22(%ebp)
	movw	-22(%ebp), %ax
	movb	$12, %ah
	movw	%ax, -24(%ebp)
	fldcw	-24(%ebp)
	fistpl	-12(%ebp)
	fldcw	-22(%ebp)
	movl	c, %eax
	movl	%eax, -16(%ebp)
	fildl	b
	fstps	-20(%ebp)
	leal	-8(%ebp), %eax
	addl	$3, (%eax)
	leal	-1(%ebp), %eax
	decb	(%eax)
	leal	-2(%ebp), %eax
	incb	(%eax)
	flds	-16(%ebp)
	fld1
	faddp	%st, %st(1)
	fstps	-16(%ebp)
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.comm	b,4,4
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
