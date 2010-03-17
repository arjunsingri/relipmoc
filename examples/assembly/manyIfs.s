	.file	"manyIfs.c"
.globl c
	.data
	.align 4
	.type	c,@object
	.size	c,4
c:
	.long	4
.globl d
	.align 4
	.type	d,@object
	.size	d,4
d:
	.long	343
	.section	.rodata
.LC0:
	.string	"%d%d%d"
.LC1:
	.string	"a = %d b = %d c = %d d = %d"
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
	pushl	$c
	pushl	$b
	pushl	$a
	pushl	$.LC0
	call	scanf
	addl	$16, %esp
	movl	%eax, -4(%ebp)
	movl	b, %eax
	addl	a, %eax
	cmpl	c, %eax
	jle	.L2
	cmpl	$0, a
	je	.L3
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L16
	incl	a
	cmpl	$0, a
	je	.L5
	decl	a
	jmp	.L6
.L5:
	incl	a
.L6:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L7
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L16
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L9
	movl	a, %eax
	cmpl	b, %eax
	jne	.L10
	incl	a
	jmp	.L16
.L10:
	incl	b
	jmp	.L16
.L9:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L16
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L16
.L7:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L16
	incl	c
	jmp	.L16
.L3:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L17
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L16
.L17:
	incl	a
.L16:
	cmpl	$0, a
	je	.L19
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L32
	incl	a
	cmpl	$0, a
	je	.L21
	decl	a
	jmp	.L22
.L21:
	incl	a
.L22:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L23
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L32
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L25
	movl	a, %eax
	cmpl	b, %eax
	jne	.L26
	incl	a
	jmp	.L32
.L26:
	incl	b
	jmp	.L32
.L25:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L32
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L32
.L23:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L32
	incl	c
	jmp	.L32
.L19:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L33
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L32
.L33:
	incl	a
.L32:
	cmpl	$0, a
	je	.L35
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L48
	incl	a
	cmpl	$0, a
	je	.L37
	decl	a
	jmp	.L38
.L37:
	incl	a
.L38:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L39
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L48
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L41
	movl	a, %eax
	cmpl	b, %eax
	jne	.L42
	incl	a
	jmp	.L48
.L42:
	incl	b
	jmp	.L48
.L41:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L48
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L48
.L39:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L48
	incl	c
	jmp	.L48
.L35:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L49
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L48
.L49:
	incl	a
.L48:
	cmpl	$0, a
	je	.L51
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L64
	incl	a
	cmpl	$0, a
	je	.L53
	decl	a
	jmp	.L54
.L53:
	incl	a
.L54:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L55
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L64
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L57
	movl	a, %eax
	cmpl	b, %eax
	jne	.L58
	incl	a
	jmp	.L64
.L58:
	incl	b
	jmp	.L64
.L57:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L64
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L64
.L55:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L64
	incl	c
	jmp	.L64
.L51:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L65
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L64
.L65:
	incl	a
.L64:
	cmpl	$0, a
	je	.L67
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L80
	incl	a
	cmpl	$0, a
	je	.L69
	decl	a
	jmp	.L70
.L69:
	incl	a
.L70:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L71
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L80
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L73
	movl	a, %eax
	cmpl	b, %eax
	jne	.L74
	incl	a
	jmp	.L80
.L74:
	incl	b
	jmp	.L80
.L73:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L80
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L80
.L71:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L80
	incl	c
	jmp	.L80
.L67:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L81
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L80
.L81:
	incl	a
.L80:
	cmpl	$0, a
	je	.L83
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L96
	incl	a
	cmpl	$0, a
	je	.L85
	decl	a
	jmp	.L86
.L85:
	incl	a
.L86:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L87
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L96
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L89
	movl	a, %eax
	cmpl	b, %eax
	jne	.L90
	incl	a
	jmp	.L96
.L90:
	incl	b
	jmp	.L96
.L89:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L96
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L96
.L87:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L96
	incl	c
	jmp	.L96
.L83:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L97
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L96
.L97:
	incl	a
.L96:
	cmpl	$0, a
	je	.L99
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L112
	incl	a
	cmpl	$0, a
	je	.L101
	decl	a
	jmp	.L102
.L101:
	incl	a
.L102:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L103
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L112
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L105
	movl	a, %eax
	cmpl	b, %eax
	jne	.L106
	incl	a
	jmp	.L112
.L106:
	incl	b
	jmp	.L112
.L105:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L112
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L112
.L103:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L112
	incl	c
	jmp	.L112
.L99:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L113
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L112
.L113:
	incl	a
.L112:
	cmpl	$0, a
	je	.L115
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L128
	incl	a
	cmpl	$0, a
	je	.L117
	decl	a
	jmp	.L118
.L117:
	incl	a
.L118:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L119
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L128
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L121
	movl	a, %eax
	cmpl	b, %eax
	jne	.L122
	incl	a
	jmp	.L128
.L122:
	incl	b
	jmp	.L128
.L121:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L128
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L128
.L119:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L128
	incl	c
	jmp	.L128
.L115:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L129
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L128
.L129:
	incl	a
.L128:
	cmpl	$0, a
	je	.L131
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L144
	incl	a
	cmpl	$0, a
	je	.L133
	decl	a
	jmp	.L134
.L133:
	incl	a
.L134:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L135
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L144
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L137
	movl	a, %eax
	cmpl	b, %eax
	jne	.L138
	incl	a
	jmp	.L144
.L138:
	incl	b
	jmp	.L144
.L137:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L144
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L144
.L135:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L144
	incl	c
	jmp	.L144
.L131:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L145
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L144
.L145:
	incl	a
.L144:
	cmpl	$0, a
	je	.L147
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L160
	incl	a
	cmpl	$0, a
	je	.L149
	decl	a
	jmp	.L150
.L149:
	incl	a
.L150:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L151
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L160
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L153
	movl	a, %eax
	cmpl	b, %eax
	jne	.L154
	incl	a
	jmp	.L160
.L154:
	incl	b
	jmp	.L160
.L153:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L160
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L160
.L151:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L160
	incl	c
	jmp	.L160
.L147:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L161
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L160
.L161:
	incl	a
.L160:
	cmpl	$0, a
	je	.L163
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L176
	incl	a
	cmpl	$0, a
	je	.L165
	decl	a
	jmp	.L166
.L165:
	incl	a
.L166:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L167
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L176
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L169
	movl	a, %eax
	cmpl	b, %eax
	jne	.L170
	incl	a
	jmp	.L176
.L170:
	incl	b
	jmp	.L176
.L169:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L176
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L176
.L167:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L176
	incl	c
	jmp	.L176
.L163:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L177
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L176
.L177:
	incl	a
.L176:
	cmpl	$0, a
	je	.L179
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L192
	incl	a
	cmpl	$0, a
	je	.L181
	decl	a
	jmp	.L182
.L181:
	incl	a
.L182:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L183
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L192
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L185
	movl	a, %eax
	cmpl	b, %eax
	jne	.L186
	incl	a
	jmp	.L192
.L186:
	incl	b
	jmp	.L192
.L185:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L192
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L192
.L183:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L192
	incl	c
	jmp	.L192
.L179:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L193
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L192
.L193:
	incl	a
.L192:
	cmpl	$0, a
	je	.L195
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L208
	incl	a
	cmpl	$0, a
	je	.L197
	decl	a
	jmp	.L198
.L197:
	incl	a
.L198:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L199
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L208
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L201
	movl	a, %eax
	cmpl	b, %eax
	jne	.L202
	incl	a
	jmp	.L208
.L202:
	incl	b
	jmp	.L208
.L201:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L208
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L208
.L199:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L208
	incl	c
	jmp	.L208
.L195:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L209
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L208
.L209:
	incl	a
.L208:
	cmpl	$0, a
	je	.L211
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L224
	incl	a
	cmpl	$0, a
	je	.L213
	decl	a
	jmp	.L214
.L213:
	incl	a
.L214:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L215
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L224
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L217
	movl	a, %eax
	cmpl	b, %eax
	jne	.L218
	incl	a
	jmp	.L224
.L218:
	incl	b
	jmp	.L224
.L217:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L224
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L224
.L215:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L224
	incl	c
	jmp	.L224
.L211:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L225
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L224
.L225:
	incl	a
.L224:
	cmpl	$0, a
	je	.L227
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L240
	incl	a
	cmpl	$0, a
	je	.L229
	decl	a
	jmp	.L230
.L229:
	incl	a
.L230:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L231
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L240
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L233
	movl	a, %eax
	cmpl	b, %eax
	jne	.L234
	incl	a
	jmp	.L240
.L234:
	incl	b
	jmp	.L240
.L233:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L240
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L240
.L231:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L240
	incl	c
	jmp	.L240
.L227:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L241
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L240
.L241:
	incl	a
.L240:
	cmpl	$0, a
	je	.L243
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L256
	incl	a
	cmpl	$0, a
	je	.L245
	decl	a
	jmp	.L246
.L245:
	incl	a
.L246:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L247
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L256
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L249
	movl	a, %eax
	cmpl	b, %eax
	jne	.L250
	incl	a
	jmp	.L256
.L250:
	incl	b
	jmp	.L256
.L249:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L256
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L256
.L247:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L256
	incl	c
	jmp	.L256
.L243:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L257
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L256
.L257:
	incl	a
.L256:
	cmpl	$0, a
	je	.L259
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L272
	incl	a
	cmpl	$0, a
	je	.L261
	decl	a
	jmp	.L262
.L261:
	incl	a
.L262:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L263
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L272
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L265
	movl	a, %eax
	cmpl	b, %eax
	jne	.L266
	incl	a
	jmp	.L272
.L266:
	incl	b
	jmp	.L272
.L265:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L272
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L272
.L263:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L272
	incl	c
	jmp	.L272
.L259:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L273
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L272
.L273:
	incl	a
.L272:
	cmpl	$0, a
	je	.L275
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L288
	incl	a
	cmpl	$0, a
	je	.L277
	decl	a
	jmp	.L278
.L277:
	incl	a
.L278:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L279
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L288
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L281
	movl	a, %eax
	cmpl	b, %eax
	jne	.L282
	incl	a
	jmp	.L288
.L282:
	incl	b
	jmp	.L288
.L281:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L288
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L288
.L279:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L288
	incl	c
	jmp	.L288
.L275:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L289
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L288
.L289:
	incl	a
.L288:
	cmpl	$0, a
	je	.L291
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L304
	incl	a
	cmpl	$0, a
	je	.L293
	decl	a
	jmp	.L294
.L293:
	incl	a
.L294:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L295
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L304
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L297
	movl	a, %eax
	cmpl	b, %eax
	jne	.L298
	incl	a
	jmp	.L304
.L298:
	incl	b
	jmp	.L304
.L297:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L304
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L304
.L295:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L304
	incl	c
	jmp	.L304
.L291:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L305
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L304
.L305:
	incl	a
.L304:
	cmpl	$0, a
	je	.L307
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L320
	incl	a
	cmpl	$0, a
	je	.L309
	decl	a
	jmp	.L310
.L309:
	incl	a
.L310:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L311
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L320
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L313
	movl	a, %eax
	cmpl	b, %eax
	jne	.L314
	incl	a
	jmp	.L320
.L314:
	incl	b
	jmp	.L320
.L313:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L320
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L320
.L311:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L320
	incl	c
	jmp	.L320
.L307:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L321
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L320
.L321:
	incl	a
.L320:
	cmpl	$0, a
	je	.L323
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L336
	incl	a
	cmpl	$0, a
	je	.L325
	decl	a
	jmp	.L326
.L325:
	incl	a
.L326:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L327
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L336
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L329
	movl	a, %eax
	cmpl	b, %eax
	jne	.L330
	incl	a
	jmp	.L336
.L330:
	incl	b
	jmp	.L336
.L329:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L336
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L336
.L327:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L336
	incl	c
	jmp	.L336
.L323:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L337
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L336
.L337:
	incl	a
.L336:
	cmpl	$0, a
	je	.L339
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L352
	incl	a
	cmpl	$0, a
	je	.L341
	decl	a
	jmp	.L342
.L341:
	incl	a
.L342:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L343
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L352
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L345
	movl	a, %eax
	cmpl	b, %eax
	jne	.L346
	incl	a
	jmp	.L352
.L346:
	incl	b
	jmp	.L352
.L345:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L352
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L352
.L343:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L352
	incl	c
	jmp	.L352
.L339:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L353
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L352
.L353:
	incl	a
.L352:
	cmpl	$0, a
	je	.L355
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L368
	incl	a
	cmpl	$0, a
	je	.L357
	decl	a
	jmp	.L358
.L357:
	incl	a
.L358:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L359
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L368
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L361
	movl	a, %eax
	cmpl	b, %eax
	jne	.L362
	incl	a
	jmp	.L368
.L362:
	incl	b
	jmp	.L368
.L361:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L368
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L368
.L359:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L368
	incl	c
	jmp	.L368
.L355:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L369
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L368
.L369:
	incl	a
.L368:
	cmpl	$0, a
	je	.L371
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L384
	incl	a
	cmpl	$0, a
	je	.L373
	decl	a
	jmp	.L374
.L373:
	incl	a
.L374:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L375
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L384
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L377
	movl	a, %eax
	cmpl	b, %eax
	jne	.L378
	incl	a
	jmp	.L384
.L378:
	incl	b
	jmp	.L384
.L377:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L384
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L384
.L375:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L384
	incl	c
	jmp	.L384
.L371:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L385
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L384
.L385:
	incl	a
.L384:
	cmpl	$0, a
	je	.L387
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L400
	incl	a
	cmpl	$0, a
	je	.L389
	decl	a
	jmp	.L390
.L389:
	incl	a
.L390:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L391
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L400
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L393
	movl	a, %eax
	cmpl	b, %eax
	jne	.L394
	incl	a
	jmp	.L400
.L394:
	incl	b
	jmp	.L400
.L393:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L400
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L400
.L391:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L400
	incl	c
	jmp	.L400
.L387:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L401
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L400
.L401:
	incl	a
.L400:
	cmpl	$0, a
	je	.L403
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L416
	incl	a
	cmpl	$0, a
	je	.L405
	decl	a
	jmp	.L406
.L405:
	incl	a
.L406:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L407
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L416
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L409
	movl	a, %eax
	cmpl	b, %eax
	jne	.L410
	incl	a
	jmp	.L416
.L410:
	incl	b
	jmp	.L416
.L409:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L416
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L416
.L407:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L416
	incl	c
	jmp	.L416
.L403:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L417
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L416
.L417:
	incl	a
.L416:
	cmpl	$0, a
	je	.L419
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L432
	incl	a
	cmpl	$0, a
	je	.L421
	decl	a
	jmp	.L422
.L421:
	incl	a
.L422:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L423
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L432
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L425
	movl	a, %eax
	cmpl	b, %eax
	jne	.L426
	incl	a
	jmp	.L432
.L426:
	incl	b
	jmp	.L432
.L425:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L432
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L432
.L423:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L432
	incl	c
	jmp	.L432
.L419:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L433
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L432
.L433:
	incl	a
.L432:
	cmpl	$0, a
	je	.L435
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L448
	incl	a
	cmpl	$0, a
	je	.L437
	decl	a
	jmp	.L438
.L437:
	incl	a
.L438:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L439
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L448
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L441
	movl	a, %eax
	cmpl	b, %eax
	jne	.L442
	incl	a
	jmp	.L448
.L442:
	incl	b
	jmp	.L448
.L441:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L448
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L448
.L439:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L448
	incl	c
	jmp	.L448
.L435:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L449
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L448
.L449:
	incl	a
.L448:
	cmpl	$0, a
	je	.L451
	movl	b, %eax
	andl	%eax, a
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	je	.L2
	incl	a
	cmpl	$0, a
	je	.L453
	decl	a
	jmp	.L454
.L453:
	incl	a
.L454:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	je	.L455
	movl	b, %eax
	movl	%eax, a
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	je	.L2
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
	movl	a, %eax
	cmpl	b, %eax
	jg	.L457
	movl	a, %eax
	cmpl	b, %eax
	jne	.L458
	incl	a
	jmp	.L2
.L458:
	incl	b
	jmp	.L2
.L457:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
	cmpl	$0, a
	je	.L2
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L2
.L455:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
	cmpl	$0, c
	je	.L2
	incl	c
	jmp	.L2
.L451:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	je	.L465
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L2
.L465:
	incl	a
.L2:
	subl	$12, %esp
	pushl	d
	pushl	c
	pushl	b
	pushl	a
	pushl	$.LC1
	call	printf
	addl	$32, %esp
	movl	%eax, a
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.comm	a,4,4
	.comm	b,4,4
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
