	.file	"fibo.c"
	.section	.rodata
.LC0:
	.string	"Enter the number: "
.LC1:
	.string	"%d"
	.align 32
.LC2:
	.string	"The %d fibonacci number is: %d\n"
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
	subl	$12, %esp
	pushl	$.LC0
	call	printf
	addl	$16, %esp
	movl	%eax, -8(%ebp)
	subl	$8, %esp
	leal	-4(%ebp), %eax
	pushl	%eax
	pushl	$.LC1
	call	scanf
	addl	$16, %esp
	movl	%eax, -8(%ebp)
	subl	$4, %esp
	subl	$8, %esp
	pushl	-4(%ebp)
	call	findFiboN
	addl	$12, %esp
	pushl	%eax
	pushl	-4(%ebp)
	pushl	$.LC2
	call	printf
	addl	$16, %esp
	movl	%eax, -8(%ebp)
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
.globl findFiboN
	.type	findFiboN,@function
findFiboN:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$8, %esp
	cmpl	$1, 8(%ebp)
	jg	.L3
	movl	8(%ebp), %eax
	movl	%eax, -12(%ebp)
	jmp	.L2
.L3:
	subl	$12, %esp
	movl	8(%ebp), %eax
	decl	%eax
	pushl	%eax
	call	findFiboN
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$12, %esp
	movl	8(%ebp), %eax
	subl	$2, %eax
	pushl	%eax
	call	findFiboN
	addl	$16, %esp
	leal	(%eax,%ebx), %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, -12(%ebp)
.L2:
	movl	-12(%ebp), %eax
	movl	-4(%ebp), %ebx
	leave
	ret
.Lfe2:
	.size	findFiboN,.Lfe2-findFiboN
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
