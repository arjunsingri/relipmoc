	.file	"type1.c"
.globl arjun
	.data
	.align 4
	.type	arjun,@object
	.size	arjun,4
arjun:
	.long	232
.globl b
	.align 4
	.type	b,@object
	.size	b,4
b:
	.long	1080033280
	.text
.globl f
	.type	f,@function
f:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$12, %esp
	movl	16(%ebp), %eax
	movl	20(%ebp), %edx
	movw	%ax, -2(%ebp)
	movb	%dl, -3(%ebp)
	incl	8(%ebp)
	flds	12(%ebp)
	fld1
	faddp	%st, %st(1)
	fstps	12(%ebp)
	leal	-2(%ebp), %eax
	incw	(%eax)
	fildl	8(%ebp)
	fadds	12(%ebp)
	filds	-2(%ebp)
	faddp	%st, %st(1)
	movsbw	-3(%ebp),%ax
	pushl	%eax
	filds	(%esp)
	leal	4(%esp), %esp
	faddp	%st, %st(1)
	fildl	24(%ebp)
	faddp	%st, %st(1)
	fnstcw	-6(%ebp)
	movw	-6(%ebp), %ax
	movb	$12, %ah
	movw	%ax, -8(%ebp)
	fldcw	-8(%ebp)
	fistpl	-12(%ebp)
	fldcw	-6(%ebp)
	movl	-12(%ebp), %eax
	leave
	ret
.Lfe1:
	.size	f,.Lfe1-f
	.data
	.align 4
	.type	z.0,@object
	.size	z.0,4
z.0:
	.long	234
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
	flds	b
	fld1
	faddp	%st, %st(1)
	fstps	b
	subl	$12, %esp
	flds	b
	fnstcw	-2(%ebp)
	movw	-2(%ebp), %ax
	movb	$12, %ah
	movw	%ax, -4(%ebp)
	fldcw	-4(%ebp)
	fistpl	-8(%ebp)
	fldcw	-2(%ebp)
	movl	-8(%ebp), %eax
	pushl	%eax
	flds	b
	fldcw	-4(%ebp)
	fistps	-10(%ebp)
	fldcw	-2(%ebp)
	movw	-10(%ebp), %ax
	movsbl	%al,%eax
	pushl	%eax
	movswl	arjun,%eax
	pushl	%eax
	fildl	singri
	leal	-4(%esp), %esp
	fstps	(%esp)
	pushl	a
	call	f
	addl	$32, %esp
	leave
	ret
.Lfe2:
	.size	main,.Lfe2-main
	.comm	a,4,4
	.comm	singri,4,4
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
