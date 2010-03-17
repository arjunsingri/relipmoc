	.file	"type3.c"
.globl a
	.data
	.align 4
	.type	a,@object
	.size	a,4
a:
	.long	0
.globl b
	.align 4
	.type	b,@object
	.size	b,4
b:
	.long	9
	.align 4
	.type	arjunsingri,@object
	.size	arjunsingri,4
arjunsingri:
	.long	0
	.align 4
	.type	singri,@object
	.size	singri,4
singri:
	.long	1091777331
	.align 4
	.type	arjunsingri.0,@object
	.size	arjunsingri.0,4
arjunsingri.0:
	.long	3
	.section	.rodata
.LC1:
	.string	"%d"
	.align 4
.LC0:
	.long	1077936128
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
	movl	$0x40400000, -4(%ebp)
	movswl	-6(%ebp),%eax
	cmpl	b, %eax
	setg	%al
	movzbl	%al, %edx
	movswl	-6(%ebp),%eax
	addl	b, %eax
	cmpl	%eax, %edx
	jle	.L2
	movzbl	arjun, %eax
	sall	$3, %eax
	movl	%eax, arjunsingri.0
.L2:
	leal	-12(%ebp), %eax
	incl	(%eax)
	flds	-4(%ebp)
	flds	.LC0
	faddp	%st, %st(1)
	fstps	-4(%ebp)
	movzbw	arjun, %ax
	movw	%ax, -6(%ebp)
	movswl	-6(%ebp),%eax
	sall	$1, %eax
	movl	%eax, arjunsingri.0
	addb	$4, arjun
	fildl	-12(%ebp)
	flds	c
	fdivp	%st, %st(1)
	fnstcw	-14(%ebp)
	movw	-14(%ebp), %ax
	movb	$12, %ah
	movw	%ax, -16(%ebp)
	fldcw	-16(%ebp)
	fistps	-18(%ebp)
	fldcw	-14(%ebp)
	movw	-18(%ebp), %ax
	movb	%al, arjun
	movswl	-6(%ebp),%edx
	movzbl	arjun, %eax
	movl	%eax, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movw	%ax, -6(%ebp)
	cmpb	$1, arjun
	jne	.L3
	subl	$8, %esp
	leal	-4(%ebp), %eax
	pushl	%eax
	pushl	$.LC1
	call	scanf
	addl	$16, %esp
	movw	%ax, -6(%ebp)
	fnstcw	-14(%ebp)
	movw	-14(%ebp), %ax
	movb	$12, %ah
	movw	%ax, -16(%ebp)
.L3:
	flds	-4(%ebp)
	fldcw	-16(%ebp)
	fistps	-18(%ebp)
	fldcw	-14(%ebp)
	movw	-18(%ebp), %ax
	movb	%al, arjun
	movzbl	arjun, %eax
	movl	%eax, arjunsingri.0
	subl	$12, %esp
	pushl	b
	pushl	c
	movzbl	arjun, %eax
	pushl	%eax
	pushl	-4(%ebp)
	fildl	arjunsingri.0
	leal	-4(%esp), %esp
	fstps	(%esp)
	movswl	-6(%ebp),%eax
	pushl	%eax
	movzbl	arjun, %eax
	pushl	%eax
	pushl	-4(%ebp)
	movzbl	arjun, %eax
	pushl	%eax
	call	function
	addl	$48, %esp
	movb	%al, arjun
	incl	arjunsingri.0
	leal	-6(%ebp), %eax
	incw	(%eax)
	flds	d
	fld1
	faddp	%st, %st(1)
	fstps	-24(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, d
	movl	%eax, c
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
.globl function
	.type	function,@function
function:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	20(%ebp), %eax
	movw	%ax, -2(%ebp)
	incl	8(%ebp)
	flds	12(%ebp)
	fld1
	faddp	%st, %st(1)
	fstps	12(%ebp)
	leal	16(%ebp), %eax
	incl	(%eax)
	leal	-2(%ebp), %eax
	incw	(%eax)
	flds	24(%ebp)
	fld1
	faddp	%st, %st(1)
	fstps	24(%ebp)
	flds	36(%ebp)
	fld1
	faddp	%st, %st(1)
	fstps	36(%ebp)
	flds	12(%ebp)
	fnstcw	-4(%ebp)
	movl	-4(%ebp), %eax
	movb	$12, %ah
	movw	%ax, -6(%ebp)
	fldcw	-6(%ebp)
	fistpl	32(%ebp)
	fldcw	-4(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, 28(%ebp)
	flds	singri
	fld1
	faddp	%st, %st(1)
	fstps	singri
	movswl	-2(%ebp),%edx
	movl	32(%ebp), %eax
	movl	%edx, %ecx
	cltd
	idivl	%ecx
	pushl	%eax
	fildl	(%esp)
	leal	4(%esp), %esp
	fadds	12(%ebp)
	fildl	16(%ebp)
	fsubrp	%st, %st(1)
	fadds	24(%ebp)
	flds	28(%ebp)
	fmuls	12(%ebp)
	faddp	%st, %st(1)
	fldcw	-6(%ebp)
	fistpl	arjunsingri
	fldcw	-4(%ebp)
	fildl	arjunsingri
	fadds	24(%ebp)
	fadds	c
	fldcw	-6(%ebp)
	fistps	-2(%ebp)
	fldcw	-4(%ebp)
	fildl	40(%ebp)
	fadds	36(%ebp)
	filds	-2(%ebp)
	faddp	%st, %st(1)
	fldcw	-6(%ebp)
	fistpl	32(%ebp)
	fldcw	-4(%ebp)
	movl	32(%ebp), %eax
	movl	%eax, arjunsingri
	incl	arjunsingri
	movl	32(%ebp), %eax
	leave
	ret
.Lfe2:
	.size	function,.Lfe2-function
	.comm	arjun,1,1
	.comm	c,4,4
	.comm	d,4,4
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
