	.file	"func.c"
	.section	.rodata
.LC0:
	.string	"%d%d"
.LC1:
	.string	"a = %d b = %d i = %d\n"
	.text
.globl main
	.type	main,@function
main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$60, %esp
	andl	$-16, %esp
	movl	$0, %eax
	subl	%eax, %esp
	subl	$4, %esp
	pushl	$b
	pushl	$a
	pushl	$.LC0
	call	scanf
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	leal	(%eax,%ebx), %esi
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	imull	%ebx, %eax
	addl	%eax, %esi
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	andl	%ebx, %eax
	movl	%esi, %edi
	xorl	%eax, %edi
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	movl	%ebx, %eax
	cltd
	idivl	-60(%ebp)
	movl	%eax, -20(%ebp)
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	movl	-20(%ebp), %eax
	cltd
	idivl	-60(%ebp)
	movl	%edx, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	addl	%eax, %ebx
	movl	%ebx, -24(%ebp)
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%ebx, %esi
	imull	%eax, %esi
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	movl	%ebx, %eax
	cltd
	idivl	-60(%ebp)
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	imull	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	imull	%ebx, %eax
	addl	%eax, %esi
	movl	%esi, -28(%ebp)
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -32(%ebp)
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %esi
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	movl	%ebx, %eax
	cltd
	idivl	-60(%ebp)
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	imull	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	imull	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	movl	%ebx, %eax
	cltd
	idivl	-60(%ebp)
	movl	%edx, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	imull	%ebx, %eax
	addl	%eax, %esi
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	movl	%ebx, %eax
	cltd
	idivl	-60(%ebp)
	xorl	%edx, %esi
	movl	%esi, -36(%ebp)
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -40(%ebp)
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %esi
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	imull	%ebx, %eax
	subl	%eax, %esi
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	movl	%ebx, %eax
	cltd
	idivl	-60(%ebp)
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	imull	%ebx, %eax
	leal	(%eax,%esi), %eax
	andl	-40(%ebp), %eax
	movl	-36(%ebp), %edx
	orl	%eax, %edx
	movl	%edx, -44(%ebp)
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -48(%ebp)
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	movl	%ebx, %eax
	cltd
	idivl	-60(%ebp)
	movl	%edx, %esi
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	movl	%ebx, %eax
	cltd
	idivl	-60(%ebp)
	movl	%eax, -60(%ebp)
	movl	-60(%ebp), %edx
	leal	(%edx,%esi), %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	leal	(%eax,%ebx), %esi
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -52(%ebp)
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	imull	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	movl	%ebx, %eax
	cltd
	idivl	-60(%ebp)
	movl	-52(%ebp), %ebx
	subl	%edx, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	xorl	%ebx, %eax
	leal	(%eax,%esi), %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	leal	(%eax,%ebx), %esi
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -56(%ebp)
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	movl	%ebx, %eax
	cltd
	idivl	-60(%ebp)
	movl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	imull	%ebx, %eax
	movl	-56(%ebp), %ebx
	subl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	leal	(%eax,%ebx), %eax
	andl	%esi, %eax
	xorl	-48(%ebp), %eax
	orl	-44(%ebp), %eax
	movl	-32(%ebp), %ebx
	subl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	leal	(%eax,%ebx), %eax
	addl	-28(%ebp), %eax
	movl	-24(%ebp), %ebx
	andl	%eax, %ebx
	subl	$8, %esp
	pushl	b
	pushl	a
	call	function
	addl	$16, %esp
	xorl	%ebx, %eax
	orl	%edi, %eax
	movl	%eax, -16(%ebp)
	pushl	-16(%ebp)
	pushl	b
	pushl	a
	pushl	$.LC1
	call	printf
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	movl	$0, %eax
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
.globl function
	.type	function,@function
function:
	pushl	%ebp
	movl	%esp, %ebp
	movl	a, %eax
	addl	8(%ebp), %eax
	addl	b, %eax
	movl	%eax, 12(%ebp)
	movl	12(%ebp), %eax
	leave
	ret
.Lfe2:
	.size	function,.Lfe2-function
	.comm	a,4,4
	.comm	b,4,4
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
