	.file	"operators.c"
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
	incl	arjun
	incl	darshan
	decl	arjun
	decl	darshan
	cmpl	$0, darshan
	sete	%al
	movzbl	%al, %eax
	movl	%eax, arjun
	movl	darshan, %eax
	notl	%eax
	movl	%eax, arjun
	movl	darshan, %eax
	addl	%eax, arjun
	movl	darshan, %eax
	subl	%eax, arjun
	movl	arjun, %eax
	imull	darshan, %eax
	movl	%eax, arjun
	movl	arjun, %eax
	cltd
	idivl	darshan
	movl	%edx, arjun
	fildl	darshan
	flds	farjun
	fdivp	%st, %st(1)
	fstps	farjun
	movl	darshan, %eax
	orl	%eax, arjun
	movl	darshan, %eax
	andl	%eax, arjun
	movl	darshan, %eax
	xorl	%eax, arjun
	movl	darshan, %eax
	sall	$4, %eax
	pushl	%eax
	fildl	(%esp)
	leal	4(%esp), %esp
	fstps	farjun
	movl	arjun, %eax
	sarl	$3, %eax
	movl	%eax, darshan
	fildl	darshan
	flds	farjun
	fxch	%st(1)
	fucompp
	fnstsw	%ax
	testb	$5, %ah
	sete	%al
	movzbl	%al, %eax
	movl	%eax, arjun
	movl	$0, arjun
	flds	farjun
	fldz
	fxch	%st(1)
	fucompp
	fnstsw	%ax
	andb	$69, %ah
	xorb	$64, %ah
	jne	.L3
	jmp	.L2
.L3:
	cmpl	$0, darshan
	je	.L2
	movl	$1, arjun
.L2:
	fildl	arjun
	flds	farjun
	fucompp
	fnstsw	%ax
	testb	$69, %ah
	je	.L6
	jmp	.L4
.L6:
	fildl	darshan
	fnstcw	-2(%ebp)
	movw	-2(%ebp), %ax
	movb	$12, %ah
	movw	%ax, -4(%ebp)
	fldcw	-4(%ebp)
	fistpl	-12(%ebp)
	fldcw	-2(%ebp)
	jmp	.L5
.L4:
	flds	fdarshan
	fnstcw	-2(%ebp)
	movw	-2(%ebp), %ax
	movb	$12, %ah
	movw	%ax, -4(%ebp)
	fldcw	-4(%ebp)
	fistpl	-12(%ebp)
	fldcw	-2(%ebp)
.L5:
	movl	-12(%ebp), %eax
	movl	%eax, arjun
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.comm	arjun,4,4
	.comm	darshan,4,4
	.comm	farjun,4,4
	.comm	fdarshan,4,4
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
