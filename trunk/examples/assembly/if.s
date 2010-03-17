	.file	"if.c"
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
	.long	1079613850
	.section	.rodata
.LC0:
	.string	"Hello, world\n"
.LC1:
	.string	"Bye, world\n"
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
	fildl	a
	flds	b
	fxch	%st(1)
	fucompp
	fnstsw	%ax
	andb	$69, %ah
	cmpb	$64, %ah
	je	.L3
	jmp	.L2
.L3:
	subl	$12, %esp
	pushl	$.LC0
	call	puts
	addl	$16, %esp
	movl	%eax, -4(%ebp)
	jmp	.L4
.L2:
	subl	$12, %esp
	pushl	$.LC1
	call	puts
	addl	$16, %esp
	movl	%eax, -4(%ebp)
.L4:
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
