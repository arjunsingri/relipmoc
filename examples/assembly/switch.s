	.file	"switch.c"
.globl var
	.data
	.type	var,@object
	.size	var,1
var:
	.byte	122
.globl c
	.align 4
	.type	c,@object
	.size	c,4
c:
	.long	-1044554134
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
	movsbl	var,%eax
	movl	%eax, -4(%ebp)
	cmpl	$97, -4(%ebp)
	je	.L3
	cmpl	$109, -4(%ebp)
	je	.L4
	jmp	.L5
.L3:
	incb	var
	jmp	.L2
.L4:
	flds	c
	fld1
	fsubrp	%st, %st(1)
	fstps	c
	jmp	.L2
.L5:
	movb	$-37, %al
	addb	%al, var
.L2:
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
