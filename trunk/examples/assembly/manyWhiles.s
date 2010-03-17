	.file	"manyWhiles.c"
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
	.string	"a = %d b = %d c = %d d = %d\n"
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
.L2:
	movl	b, %eax
	addl	a, %eax
	cmpl	c, %eax
	jg	.L4
	jmp	.L3
.L4:
	movl	b, %eax
	andl	%eax, a
.L5:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L7
	jmp	.L6
.L7:
	incl	a
.L8:
	cmpl	$0, a
	jne	.L10
	jmp	.L9
.L10:
	decl	a
	jmp	.L8
.L9:
	incl	a
.L11:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L13
	jmp	.L12
.L13:
	movl	b, %eax
	movl	%eax, a
.L14:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L16
	jmp	.L11
.L16:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L17:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L20
	jmp	.L18
.L20:
	movl	a, %eax
	cmpl	b, %eax
	je	.L22
	jmp	.L21
.L22:
	incl	a
	jmp	.L20
.L21:
	incl	b
	jmp	.L17
.L18:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L23:
	cmpl	$0, a
	jne	.L25
	jmp	.L14
.L25:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L23
.L12:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L26:
	cmpl	$0, c
	jne	.L28
	jmp	.L5
.L28:
	incl	c
	jmp	.L26
.L6:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L29:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L31
	jmp	.L30
.L31:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L29
.L30:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L32:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L34
	jmp	.L33
.L34:
	incl	a
.L35:
	cmpl	$0, a
	jne	.L37
	jmp	.L36
.L37:
	decl	a
	jmp	.L35
.L36:
	incl	a
.L38:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L40
	jmp	.L39
.L40:
	movl	b, %eax
	movl	%eax, a
.L41:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L43
	jmp	.L38
.L43:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L44:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L47
	jmp	.L45
.L47:
	movl	a, %eax
	cmpl	b, %eax
	je	.L49
	jmp	.L48
.L49:
	incl	a
	jmp	.L47
.L48:
	incl	b
	jmp	.L44
.L45:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L50:
	cmpl	$0, a
	jne	.L52
	jmp	.L41
.L52:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L50
.L39:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L53:
	cmpl	$0, c
	jne	.L55
	jmp	.L32
.L55:
	incl	c
	jmp	.L53
.L33:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L56:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L58
	jmp	.L57
.L58:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L56
.L57:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L59:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L61
	jmp	.L60
.L61:
	incl	a
.L62:
	cmpl	$0, a
	jne	.L64
	jmp	.L63
.L64:
	decl	a
	jmp	.L62
.L63:
	incl	a
.L65:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L67
	jmp	.L66
.L67:
	movl	b, %eax
	movl	%eax, a
.L68:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L70
	jmp	.L65
.L70:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L71:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L74
	jmp	.L72
.L74:
	movl	a, %eax
	cmpl	b, %eax
	je	.L76
	jmp	.L75
.L76:
	incl	a
	jmp	.L74
.L75:
	incl	b
	jmp	.L71
.L72:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L77:
	cmpl	$0, a
	jne	.L79
	jmp	.L68
.L79:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L77
.L66:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L80:
	cmpl	$0, c
	jne	.L82
	jmp	.L59
.L82:
	incl	c
	jmp	.L80
.L60:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L83:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L85
	jmp	.L84
.L85:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L83
.L84:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L86:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L88
	jmp	.L87
.L88:
	incl	a
.L89:
	cmpl	$0, a
	jne	.L91
	jmp	.L90
.L91:
	decl	a
	jmp	.L89
.L90:
	incl	a
.L92:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L94
	jmp	.L93
.L94:
	movl	b, %eax
	movl	%eax, a
.L95:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L97
	jmp	.L92
.L97:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L98:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L101
	jmp	.L99
.L101:
	movl	a, %eax
	cmpl	b, %eax
	je	.L103
	jmp	.L102
.L103:
	incl	a
	jmp	.L101
.L102:
	incl	b
	jmp	.L98
.L99:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L104:
	cmpl	$0, a
	jne	.L106
	jmp	.L95
.L106:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L104
.L93:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L107:
	cmpl	$0, c
	jne	.L109
	jmp	.L86
.L109:
	incl	c
	jmp	.L107
.L87:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L110:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L112
	jmp	.L111
.L112:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L110
.L111:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L113:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L115
	jmp	.L114
.L115:
	incl	a
.L116:
	cmpl	$0, a
	jne	.L118
	jmp	.L117
.L118:
	decl	a
	jmp	.L116
.L117:
	incl	a
.L119:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L121
	jmp	.L120
.L121:
	movl	b, %eax
	movl	%eax, a
.L122:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L124
	jmp	.L119
.L124:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L125:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L128
	jmp	.L126
.L128:
	movl	a, %eax
	cmpl	b, %eax
	je	.L130
	jmp	.L129
.L130:
	incl	a
	jmp	.L128
.L129:
	incl	b
	jmp	.L125
.L126:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L131:
	cmpl	$0, a
	jne	.L133
	jmp	.L122
.L133:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L131
.L120:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L134:
	cmpl	$0, c
	jne	.L136
	jmp	.L113
.L136:
	incl	c
	jmp	.L134
.L114:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L137:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L139
	jmp	.L138
.L139:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L137
.L138:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L140:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L142
	jmp	.L141
.L142:
	incl	a
.L143:
	cmpl	$0, a
	jne	.L145
	jmp	.L144
.L145:
	decl	a
	jmp	.L143
.L144:
	incl	a
.L146:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L148
	jmp	.L147
.L148:
	movl	b, %eax
	movl	%eax, a
.L149:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L151
	jmp	.L146
.L151:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L152:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L155
	jmp	.L153
.L155:
	movl	a, %eax
	cmpl	b, %eax
	je	.L157
	jmp	.L156
.L157:
	incl	a
	jmp	.L155
.L156:
	incl	b
	jmp	.L152
.L153:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L158:
	cmpl	$0, a
	jne	.L160
	jmp	.L149
.L160:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L158
.L147:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L161:
	cmpl	$0, c
	jne	.L163
	jmp	.L140
.L163:
	incl	c
	jmp	.L161
.L141:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L164:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L166
	jmp	.L165
.L166:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L164
.L165:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L167:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L169
	jmp	.L168
.L169:
	incl	a
.L170:
	cmpl	$0, a
	jne	.L172
	jmp	.L171
.L172:
	decl	a
	jmp	.L170
.L171:
	incl	a
.L173:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L175
	jmp	.L174
.L175:
	movl	b, %eax
	movl	%eax, a
.L176:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L178
	jmp	.L173
.L178:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L179:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L182
	jmp	.L180
.L182:
	movl	a, %eax
	cmpl	b, %eax
	je	.L184
	jmp	.L183
.L184:
	incl	a
	jmp	.L182
.L183:
	incl	b
	jmp	.L179
.L180:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L185:
	cmpl	$0, a
	jne	.L187
	jmp	.L176
.L187:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L185
.L174:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L188:
	cmpl	$0, c
	jne	.L190
	jmp	.L167
.L190:
	incl	c
	jmp	.L188
.L168:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L191:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L193
	jmp	.L192
.L193:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L191
.L192:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L194:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L196
	jmp	.L195
.L196:
	incl	a
.L197:
	cmpl	$0, a
	jne	.L199
	jmp	.L198
.L199:
	decl	a
	jmp	.L197
.L198:
	incl	a
.L200:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L202
	jmp	.L201
.L202:
	movl	b, %eax
	movl	%eax, a
.L203:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L205
	jmp	.L200
.L205:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L206:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L209
	jmp	.L207
.L209:
	movl	a, %eax
	cmpl	b, %eax
	je	.L211
	jmp	.L210
.L211:
	incl	a
	jmp	.L209
.L210:
	incl	b
	jmp	.L206
.L207:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L212:
	cmpl	$0, a
	jne	.L214
	jmp	.L203
.L214:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L212
.L201:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L215:
	cmpl	$0, c
	jne	.L217
	jmp	.L194
.L217:
	incl	c
	jmp	.L215
.L195:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L218:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L220
	jmp	.L219
.L220:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L218
.L219:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L221:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L223
	jmp	.L222
.L223:
	incl	a
.L224:
	cmpl	$0, a
	jne	.L226
	jmp	.L225
.L226:
	decl	a
	jmp	.L224
.L225:
	incl	a
.L227:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L229
	jmp	.L228
.L229:
	movl	b, %eax
	movl	%eax, a
.L230:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L232
	jmp	.L227
.L232:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L233:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L236
	jmp	.L234
.L236:
	movl	a, %eax
	cmpl	b, %eax
	je	.L238
	jmp	.L237
.L238:
	incl	a
	jmp	.L236
.L237:
	incl	b
	jmp	.L233
.L234:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L239:
	cmpl	$0, a
	jne	.L241
	jmp	.L230
.L241:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L239
.L228:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L242:
	cmpl	$0, c
	jne	.L244
	jmp	.L221
.L244:
	incl	c
	jmp	.L242
.L222:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L245:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L247
	jmp	.L246
.L247:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L245
.L246:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L248:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L250
	jmp	.L249
.L250:
	incl	a
.L251:
	cmpl	$0, a
	jne	.L253
	jmp	.L252
.L253:
	decl	a
	jmp	.L251
.L252:
	incl	a
.L254:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L256
	jmp	.L255
.L256:
	movl	b, %eax
	movl	%eax, a
.L257:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L259
	jmp	.L254
.L259:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L260:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L263
	jmp	.L261
.L263:
	movl	a, %eax
	cmpl	b, %eax
	je	.L265
	jmp	.L264
.L265:
	incl	a
	jmp	.L263
.L264:
	incl	b
	jmp	.L260
.L261:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L266:
	cmpl	$0, a
	jne	.L268
	jmp	.L257
.L268:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L266
.L255:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L269:
	cmpl	$0, c
	jne	.L271
	jmp	.L248
.L271:
	incl	c
	jmp	.L269
.L249:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L272:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L274
	jmp	.L273
.L274:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L272
.L273:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L275:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L277
	jmp	.L276
.L277:
	incl	a
.L278:
	cmpl	$0, a
	jne	.L280
	jmp	.L279
.L280:
	decl	a
	jmp	.L278
.L279:
	incl	a
.L281:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L283
	jmp	.L282
.L283:
	movl	b, %eax
	movl	%eax, a
.L284:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L286
	jmp	.L281
.L286:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L287:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L290
	jmp	.L288
.L290:
	movl	a, %eax
	cmpl	b, %eax
	je	.L292
	jmp	.L291
.L292:
	incl	a
	jmp	.L290
.L291:
	incl	b
	jmp	.L287
.L288:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L293:
	cmpl	$0, a
	jne	.L295
	jmp	.L284
.L295:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L293
.L282:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L296:
	cmpl	$0, c
	jne	.L298
	jmp	.L275
.L298:
	incl	c
	jmp	.L296
.L276:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L299:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L301
	jmp	.L300
.L301:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L299
.L300:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L302:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L304
	jmp	.L303
.L304:
	incl	a
.L305:
	cmpl	$0, a
	jne	.L307
	jmp	.L306
.L307:
	decl	a
	jmp	.L305
.L306:
	incl	a
.L308:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L310
	jmp	.L309
.L310:
	movl	b, %eax
	movl	%eax, a
.L311:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L313
	jmp	.L308
.L313:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L314:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L317
	jmp	.L315
.L317:
	movl	a, %eax
	cmpl	b, %eax
	je	.L319
	jmp	.L318
.L319:
	incl	a
	jmp	.L317
.L318:
	incl	b
	jmp	.L314
.L315:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L320:
	cmpl	$0, a
	jne	.L322
	jmp	.L311
.L322:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L320
.L309:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L323:
	cmpl	$0, c
	jne	.L325
	jmp	.L302
.L325:
	incl	c
	jmp	.L323
.L303:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L326:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L328
	jmp	.L327
.L328:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L326
.L327:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L329:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L331
	jmp	.L330
.L331:
	incl	a
.L332:
	cmpl	$0, a
	jne	.L334
	jmp	.L333
.L334:
	decl	a
	jmp	.L332
.L333:
	incl	a
.L335:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L337
	jmp	.L336
.L337:
	movl	b, %eax
	movl	%eax, a
.L338:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L340
	jmp	.L335
.L340:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L341:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L344
	jmp	.L342
.L344:
	movl	a, %eax
	cmpl	b, %eax
	je	.L346
	jmp	.L345
.L346:
	incl	a
	jmp	.L344
.L345:
	incl	b
	jmp	.L341
.L342:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L347:
	cmpl	$0, a
	jne	.L349
	jmp	.L338
.L349:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L347
.L336:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L350:
	cmpl	$0, c
	jne	.L352
	jmp	.L329
.L352:
	incl	c
	jmp	.L350
.L330:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L353:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L355
	jmp	.L354
.L355:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L353
.L354:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L356:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L358
	jmp	.L357
.L358:
	incl	a
.L359:
	cmpl	$0, a
	jne	.L361
	jmp	.L360
.L361:
	decl	a
	jmp	.L359
.L360:
	incl	a
.L362:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L364
	jmp	.L363
.L364:
	movl	b, %eax
	movl	%eax, a
.L365:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L367
	jmp	.L362
.L367:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L368:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L371
	jmp	.L369
.L371:
	movl	a, %eax
	cmpl	b, %eax
	je	.L373
	jmp	.L372
.L373:
	incl	a
	jmp	.L371
.L372:
	incl	b
	jmp	.L368
.L369:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L374:
	cmpl	$0, a
	jne	.L376
	jmp	.L365
.L376:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L374
.L363:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L377:
	cmpl	$0, c
	jne	.L379
	jmp	.L356
.L379:
	incl	c
	jmp	.L377
.L357:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L380:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L382
	jmp	.L381
.L382:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L380
.L381:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L383:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L385
	jmp	.L384
.L385:
	incl	a
.L386:
	cmpl	$0, a
	jne	.L388
	jmp	.L387
.L388:
	decl	a
	jmp	.L386
.L387:
	incl	a
.L389:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L391
	jmp	.L390
.L391:
	movl	b, %eax
	movl	%eax, a
.L392:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L394
	jmp	.L389
.L394:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L395:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L398
	jmp	.L396
.L398:
	movl	a, %eax
	cmpl	b, %eax
	je	.L400
	jmp	.L399
.L400:
	incl	a
	jmp	.L398
.L399:
	incl	b
	jmp	.L395
.L396:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L401:
	cmpl	$0, a
	jne	.L403
	jmp	.L392
.L403:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L401
.L390:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L404:
	cmpl	$0, c
	jne	.L406
	jmp	.L383
.L406:
	incl	c
	jmp	.L404
.L384:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L407:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L409
	jmp	.L408
.L409:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L407
.L408:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L410:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L412
	jmp	.L411
.L412:
	incl	a
.L413:
	cmpl	$0, a
	jne	.L415
	jmp	.L414
.L415:
	decl	a
	jmp	.L413
.L414:
	incl	a
.L416:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L418
	jmp	.L417
.L418:
	movl	b, %eax
	movl	%eax, a
.L419:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L421
	jmp	.L416
.L421:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L422:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L425
	jmp	.L423
.L425:
	movl	a, %eax
	cmpl	b, %eax
	je	.L427
	jmp	.L426
.L427:
	incl	a
	jmp	.L425
.L426:
	incl	b
	jmp	.L422
.L423:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L428:
	cmpl	$0, a
	jne	.L430
	jmp	.L419
.L430:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L428
.L417:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L431:
	cmpl	$0, c
	jne	.L433
	jmp	.L410
.L433:
	incl	c
	jmp	.L431
.L411:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L434:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L436
	jmp	.L435
.L436:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L434
.L435:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L437:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L439
	jmp	.L438
.L439:
	incl	a
.L440:
	cmpl	$0, a
	jne	.L442
	jmp	.L441
.L442:
	decl	a
	jmp	.L440
.L441:
	incl	a
.L443:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L445
	jmp	.L444
.L445:
	movl	b, %eax
	movl	%eax, a
.L446:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L448
	jmp	.L443
.L448:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L449:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L452
	jmp	.L450
.L452:
	movl	a, %eax
	cmpl	b, %eax
	je	.L454
	jmp	.L453
.L454:
	incl	a
	jmp	.L452
.L453:
	incl	b
	jmp	.L449
.L450:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L455:
	cmpl	$0, a
	jne	.L457
	jmp	.L446
.L457:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L455
.L444:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L458:
	cmpl	$0, c
	jne	.L460
	jmp	.L437
.L460:
	incl	c
	jmp	.L458
.L438:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L461:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L463
	jmp	.L462
.L463:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L461
.L462:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L464:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L466
	jmp	.L465
.L466:
	incl	a
.L467:
	cmpl	$0, a
	jne	.L469
	jmp	.L468
.L469:
	decl	a
	jmp	.L467
.L468:
	incl	a
.L470:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L472
	jmp	.L471
.L472:
	movl	b, %eax
	movl	%eax, a
.L473:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L475
	jmp	.L470
.L475:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L476:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L479
	jmp	.L477
.L479:
	movl	a, %eax
	cmpl	b, %eax
	je	.L481
	jmp	.L480
.L481:
	incl	a
	jmp	.L479
.L480:
	incl	b
	jmp	.L476
.L477:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L482:
	cmpl	$0, a
	jne	.L484
	jmp	.L473
.L484:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L482
.L471:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L485:
	cmpl	$0, c
	jne	.L487
	jmp	.L464
.L487:
	incl	c
	jmp	.L485
.L465:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L488:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L490
	jmp	.L489
.L490:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L488
.L489:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L491:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L493
	jmp	.L492
.L493:
	incl	a
.L494:
	cmpl	$0, a
	jne	.L496
	jmp	.L495
.L496:
	decl	a
	jmp	.L494
.L495:
	incl	a
.L497:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L499
	jmp	.L498
.L499:
	movl	b, %eax
	movl	%eax, a
.L500:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L502
	jmp	.L497
.L502:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L503:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L506
	jmp	.L504
.L506:
	movl	a, %eax
	cmpl	b, %eax
	je	.L508
	jmp	.L507
.L508:
	incl	a
	jmp	.L506
.L507:
	incl	b
	jmp	.L503
.L504:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L509:
	cmpl	$0, a
	jne	.L511
	jmp	.L500
.L511:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L509
.L498:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L512:
	cmpl	$0, c
	jne	.L514
	jmp	.L491
.L514:
	incl	c
	jmp	.L512
.L492:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L515:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L517
	jmp	.L516
.L517:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L515
.L516:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L518:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L520
	jmp	.L519
.L520:
	incl	a
.L521:
	cmpl	$0, a
	jne	.L523
	jmp	.L522
.L523:
	decl	a
	jmp	.L521
.L522:
	incl	a
.L524:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L526
	jmp	.L525
.L526:
	movl	b, %eax
	movl	%eax, a
.L527:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L529
	jmp	.L524
.L529:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L530:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L533
	jmp	.L531
.L533:
	movl	a, %eax
	cmpl	b, %eax
	je	.L535
	jmp	.L534
.L535:
	incl	a
	jmp	.L533
.L534:
	incl	b
	jmp	.L530
.L531:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L536:
	cmpl	$0, a
	jne	.L538
	jmp	.L527
.L538:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L536
.L525:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L539:
	cmpl	$0, c
	jne	.L541
	jmp	.L518
.L541:
	incl	c
	jmp	.L539
.L519:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L542:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L544
	jmp	.L543
.L544:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L542
.L543:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L545:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L547
	jmp	.L546
.L547:
	incl	a
.L548:
	cmpl	$0, a
	jne	.L550
	jmp	.L549
.L550:
	decl	a
	jmp	.L548
.L549:
	incl	a
.L551:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L553
	jmp	.L552
.L553:
	movl	b, %eax
	movl	%eax, a
.L554:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L556
	jmp	.L551
.L556:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L557:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L560
	jmp	.L558
.L560:
	movl	a, %eax
	cmpl	b, %eax
	je	.L562
	jmp	.L561
.L562:
	incl	a
	jmp	.L560
.L561:
	incl	b
	jmp	.L557
.L558:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L563:
	cmpl	$0, a
	jne	.L565
	jmp	.L554
.L565:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L563
.L552:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L566:
	cmpl	$0, c
	jne	.L568
	jmp	.L545
.L568:
	incl	c
	jmp	.L566
.L546:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L569:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L571
	jmp	.L570
.L571:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L569
.L570:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L572:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L574
	jmp	.L573
.L574:
	incl	a
.L575:
	cmpl	$0, a
	jne	.L577
	jmp	.L576
.L577:
	decl	a
	jmp	.L575
.L576:
	incl	a
.L578:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L580
	jmp	.L579
.L580:
	movl	b, %eax
	movl	%eax, a
.L581:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L583
	jmp	.L578
.L583:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L584:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L587
	jmp	.L585
.L587:
	movl	a, %eax
	cmpl	b, %eax
	je	.L589
	jmp	.L588
.L589:
	incl	a
	jmp	.L587
.L588:
	incl	b
	jmp	.L584
.L585:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L590:
	cmpl	$0, a
	jne	.L592
	jmp	.L581
.L592:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L590
.L579:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L593:
	cmpl	$0, c
	jne	.L595
	jmp	.L572
.L595:
	incl	c
	jmp	.L593
.L573:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L596:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L598
	jmp	.L597
.L598:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L596
.L597:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L599:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L601
	jmp	.L600
.L601:
	incl	a
.L602:
	cmpl	$0, a
	jne	.L604
	jmp	.L603
.L604:
	decl	a
	jmp	.L602
.L603:
	incl	a
.L605:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L607
	jmp	.L606
.L607:
	movl	b, %eax
	movl	%eax, a
.L608:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L610
	jmp	.L605
.L610:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L611:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L614
	jmp	.L612
.L614:
	movl	a, %eax
	cmpl	b, %eax
	je	.L616
	jmp	.L615
.L616:
	incl	a
	jmp	.L614
.L615:
	incl	b
	jmp	.L611
.L612:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L617:
	cmpl	$0, a
	jne	.L619
	jmp	.L608
.L619:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L617
.L606:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L620:
	cmpl	$0, c
	jne	.L622
	jmp	.L599
.L622:
	incl	c
	jmp	.L620
.L600:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L623:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L625
	jmp	.L624
.L625:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L623
.L624:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L626:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L628
	jmp	.L627
.L628:
	incl	a
.L629:
	cmpl	$0, a
	jne	.L631
	jmp	.L630
.L631:
	decl	a
	jmp	.L629
.L630:
	incl	a
.L632:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L634
	jmp	.L633
.L634:
	movl	b, %eax
	movl	%eax, a
.L635:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L637
	jmp	.L632
.L637:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L638:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L641
	jmp	.L639
.L641:
	movl	a, %eax
	cmpl	b, %eax
	je	.L643
	jmp	.L642
.L643:
	incl	a
	jmp	.L641
.L642:
	incl	b
	jmp	.L638
.L639:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L644:
	cmpl	$0, a
	jne	.L646
	jmp	.L635
.L646:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L644
.L633:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L647:
	cmpl	$0, c
	jne	.L649
	jmp	.L626
.L649:
	incl	c
	jmp	.L647
.L627:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L650:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L652
	jmp	.L651
.L652:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L650
.L651:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L653:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L655
	jmp	.L654
.L655:
	incl	a
.L656:
	cmpl	$0, a
	jne	.L658
	jmp	.L657
.L658:
	decl	a
	jmp	.L656
.L657:
	incl	a
.L659:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L661
	jmp	.L660
.L661:
	movl	b, %eax
	movl	%eax, a
.L662:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L664
	jmp	.L659
.L664:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L665:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L668
	jmp	.L666
.L668:
	movl	a, %eax
	cmpl	b, %eax
	je	.L670
	jmp	.L669
.L670:
	incl	a
	jmp	.L668
.L669:
	incl	b
	jmp	.L665
.L666:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L671:
	cmpl	$0, a
	jne	.L673
	jmp	.L662
.L673:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L671
.L660:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L674:
	cmpl	$0, c
	jne	.L676
	jmp	.L653
.L676:
	incl	c
	jmp	.L674
.L654:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L677:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L679
	jmp	.L678
.L679:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L677
.L678:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L680:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L682
	jmp	.L681
.L682:
	incl	a
.L683:
	cmpl	$0, a
	jne	.L685
	jmp	.L684
.L685:
	decl	a
	jmp	.L683
.L684:
	incl	a
.L686:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L688
	jmp	.L687
.L688:
	movl	b, %eax
	movl	%eax, a
.L689:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L691
	jmp	.L686
.L691:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L692:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L695
	jmp	.L693
.L695:
	movl	a, %eax
	cmpl	b, %eax
	je	.L697
	jmp	.L696
.L697:
	incl	a
	jmp	.L695
.L696:
	incl	b
	jmp	.L692
.L693:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L698:
	cmpl	$0, a
	jne	.L700
	jmp	.L689
.L700:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L698
.L687:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L701:
	cmpl	$0, c
	jne	.L703
	jmp	.L680
.L703:
	incl	c
	jmp	.L701
.L681:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L704:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L706
	jmp	.L705
.L706:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L704
.L705:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L707:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L709
	jmp	.L708
.L709:
	incl	a
.L710:
	cmpl	$0, a
	jne	.L712
	jmp	.L711
.L712:
	decl	a
	jmp	.L710
.L711:
	incl	a
.L713:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L715
	jmp	.L714
.L715:
	movl	b, %eax
	movl	%eax, a
.L716:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L718
	jmp	.L713
.L718:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L719:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L722
	jmp	.L720
.L722:
	movl	a, %eax
	cmpl	b, %eax
	je	.L724
	jmp	.L723
.L724:
	incl	a
	jmp	.L722
.L723:
	incl	b
	jmp	.L719
.L720:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L725:
	cmpl	$0, a
	jne	.L727
	jmp	.L716
.L727:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L725
.L714:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L728:
	cmpl	$0, c
	jne	.L730
	jmp	.L707
.L730:
	incl	c
	jmp	.L728
.L708:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L731:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L733
	jmp	.L732
.L733:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L731
.L732:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L734:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L736
	jmp	.L735
.L736:
	incl	a
.L737:
	cmpl	$0, a
	jne	.L739
	jmp	.L738
.L739:
	decl	a
	jmp	.L737
.L738:
	incl	a
.L740:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L742
	jmp	.L741
.L742:
	movl	b, %eax
	movl	%eax, a
.L743:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L745
	jmp	.L740
.L745:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L746:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L749
	jmp	.L747
.L749:
	movl	a, %eax
	cmpl	b, %eax
	je	.L751
	jmp	.L750
.L751:
	incl	a
	jmp	.L749
.L750:
	incl	b
	jmp	.L746
.L747:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L752:
	cmpl	$0, a
	jne	.L754
	jmp	.L743
.L754:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L752
.L741:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L755:
	cmpl	$0, c
	jne	.L757
	jmp	.L734
.L757:
	incl	c
	jmp	.L755
.L735:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L758:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L760
	jmp	.L759
.L760:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L758
.L759:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L761:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L763
	jmp	.L762
.L763:
	incl	a
.L764:
	cmpl	$0, a
	jne	.L766
	jmp	.L765
.L766:
	decl	a
	jmp	.L764
.L765:
	incl	a
.L767:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L769
	jmp	.L768
.L769:
	movl	b, %eax
	movl	%eax, a
.L770:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L772
	jmp	.L767
.L772:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L773:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L776
	jmp	.L774
.L776:
	movl	a, %eax
	cmpl	b, %eax
	je	.L778
	jmp	.L777
.L778:
	incl	a
	jmp	.L776
.L777:
	incl	b
	jmp	.L773
.L774:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L779:
	cmpl	$0, a
	jne	.L781
	jmp	.L770
.L781:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L779
.L768:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L782:
	cmpl	$0, c
	jne	.L784
	jmp	.L761
.L784:
	incl	c
	jmp	.L782
.L762:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L785:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L787
	jmp	.L786
.L787:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L785
.L786:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L788:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L790
	jmp	.L789
.L790:
	incl	a
.L791:
	cmpl	$0, a
	jne	.L793
	jmp	.L792
.L793:
	decl	a
	jmp	.L791
.L792:
	incl	a
.L794:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L796
	jmp	.L795
.L796:
	movl	b, %eax
	movl	%eax, a
.L797:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L799
	jmp	.L794
.L799:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L800:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L803
	jmp	.L801
.L803:
	movl	a, %eax
	cmpl	b, %eax
	je	.L805
	jmp	.L804
.L805:
	incl	a
	jmp	.L803
.L804:
	incl	b
	jmp	.L800
.L801:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L806:
	cmpl	$0, a
	jne	.L808
	jmp	.L797
.L808:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L806
.L795:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L809:
	cmpl	$0, c
	jne	.L811
	jmp	.L788
.L811:
	incl	c
	jmp	.L809
.L789:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L812:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L814
	jmp	.L813
.L814:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L812
.L813:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L815:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L817
	jmp	.L816
.L817:
	incl	a
.L818:
	cmpl	$0, a
	jne	.L820
	jmp	.L819
.L820:
	decl	a
	jmp	.L818
.L819:
	incl	a
.L821:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L823
	jmp	.L822
.L823:
	movl	b, %eax
	movl	%eax, a
.L824:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L826
	jmp	.L821
.L826:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L827:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L830
	jmp	.L828
.L830:
	movl	a, %eax
	cmpl	b, %eax
	je	.L832
	jmp	.L831
.L832:
	incl	a
	jmp	.L830
.L831:
	incl	b
	jmp	.L827
.L828:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L833:
	cmpl	$0, a
	jne	.L835
	jmp	.L824
.L835:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L833
.L822:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L836:
	cmpl	$0, c
	jne	.L838
	jmp	.L815
.L838:
	incl	c
	jmp	.L836
.L816:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L839:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L841
	jmp	.L840
.L841:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L839
.L840:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L842:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L844
	jmp	.L843
.L844:
	incl	a
.L845:
	cmpl	$0, a
	jne	.L847
	jmp	.L846
.L847:
	decl	a
	jmp	.L845
.L846:
	incl	a
.L848:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L850
	jmp	.L849
.L850:
	movl	b, %eax
	movl	%eax, a
.L851:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L853
	jmp	.L848
.L853:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L854:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L857
	jmp	.L855
.L857:
	movl	a, %eax
	cmpl	b, %eax
	je	.L859
	jmp	.L858
.L859:
	incl	a
	jmp	.L857
.L858:
	incl	b
	jmp	.L854
.L855:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L860:
	cmpl	$0, a
	jne	.L862
	jmp	.L851
.L862:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L860
.L849:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L863:
	cmpl	$0, c
	jne	.L865
	jmp	.L842
.L865:
	incl	c
	jmp	.L863
.L843:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L866:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L868
	jmp	.L867
.L868:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L866
.L867:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L869:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L871
	jmp	.L870
.L871:
	incl	a
.L872:
	cmpl	$0, a
	jne	.L874
	jmp	.L873
.L874:
	decl	a
	jmp	.L872
.L873:
	incl	a
.L875:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L877
	jmp	.L876
.L877:
	movl	b, %eax
	movl	%eax, a
.L878:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L880
	jmp	.L875
.L880:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L881:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L884
	jmp	.L882
.L884:
	movl	a, %eax
	cmpl	b, %eax
	je	.L886
	jmp	.L885
.L886:
	incl	a
	jmp	.L884
.L885:
	incl	b
	jmp	.L881
.L882:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L887:
	cmpl	$0, a
	jne	.L889
	jmp	.L878
.L889:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L887
.L876:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L890:
	cmpl	$0, c
	jne	.L892
	jmp	.L869
.L892:
	incl	c
	jmp	.L890
.L870:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L893:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L895
	jmp	.L894
.L895:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L893
.L894:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L896:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L898
	jmp	.L897
.L898:
	incl	a
.L899:
	cmpl	$0, a
	jne	.L901
	jmp	.L900
.L901:
	decl	a
	jmp	.L899
.L900:
	incl	a
.L902:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L904
	jmp	.L903
.L904:
	movl	b, %eax
	movl	%eax, a
.L905:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L907
	jmp	.L902
.L907:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L908:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L911
	jmp	.L909
.L911:
	movl	a, %eax
	cmpl	b, %eax
	je	.L913
	jmp	.L912
.L913:
	incl	a
	jmp	.L911
.L912:
	incl	b
	jmp	.L908
.L909:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L914:
	cmpl	$0, a
	jne	.L916
	jmp	.L905
.L916:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L914
.L903:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L917:
	cmpl	$0, c
	jne	.L919
	jmp	.L896
.L919:
	incl	c
	jmp	.L917
.L897:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L920:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L922
	jmp	.L921
.L922:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L920
.L921:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L923:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L925
	jmp	.L924
.L925:
	incl	a
.L926:
	cmpl	$0, a
	jne	.L928
	jmp	.L927
.L928:
	decl	a
	jmp	.L926
.L927:
	incl	a
.L929:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L931
	jmp	.L930
.L931:
	movl	b, %eax
	movl	%eax, a
.L932:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L934
	jmp	.L929
.L934:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L935:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L938
	jmp	.L936
.L938:
	movl	a, %eax
	cmpl	b, %eax
	je	.L940
	jmp	.L939
.L940:
	incl	a
	jmp	.L938
.L939:
	incl	b
	jmp	.L935
.L936:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L941:
	cmpl	$0, a
	jne	.L943
	jmp	.L932
.L943:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L941
.L930:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L944:
	cmpl	$0, c
	jne	.L946
	jmp	.L923
.L946:
	incl	c
	jmp	.L944
.L924:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L947:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L949
	jmp	.L948
.L949:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L947
.L948:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L950:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L952
	jmp	.L951
.L952:
	incl	a
.L953:
	cmpl	$0, a
	jne	.L955
	jmp	.L954
.L955:
	decl	a
	jmp	.L953
.L954:
	incl	a
.L956:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L958
	jmp	.L957
.L958:
	movl	b, %eax
	movl	%eax, a
.L959:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L961
	jmp	.L956
.L961:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L962:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L965
	jmp	.L963
.L965:
	movl	a, %eax
	cmpl	b, %eax
	je	.L967
	jmp	.L966
.L967:
	incl	a
	jmp	.L965
.L966:
	incl	b
	jmp	.L962
.L963:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L968:
	cmpl	$0, a
	jne	.L970
	jmp	.L959
.L970:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L968
.L957:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L971:
	cmpl	$0, c
	jne	.L973
	jmp	.L950
.L973:
	incl	c
	jmp	.L971
.L951:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L974:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L976
	jmp	.L975
.L976:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L974
.L975:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L977:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L979
	jmp	.L978
.L979:
	incl	a
.L980:
	cmpl	$0, a
	jne	.L982
	jmp	.L981
.L982:
	decl	a
	jmp	.L980
.L981:
	incl	a
.L983:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L985
	jmp	.L984
.L985:
	movl	b, %eax
	movl	%eax, a
.L986:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L988
	jmp	.L983
.L988:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L989:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L992
	jmp	.L990
.L992:
	movl	a, %eax
	cmpl	b, %eax
	je	.L994
	jmp	.L993
.L994:
	incl	a
	jmp	.L992
.L993:
	incl	b
	jmp	.L989
.L990:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L995:
	cmpl	$0, a
	jne	.L997
	jmp	.L986
.L997:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L995
.L984:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L998:
	cmpl	$0, c
	jne	.L1000
	jmp	.L977
.L1000:
	incl	c
	jmp	.L998
.L978:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L1001:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L1003
	jmp	.L1002
.L1003:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L1001
.L1002:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L1004:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L1006
	jmp	.L1005
.L1006:
	incl	a
.L1007:
	cmpl	$0, a
	jne	.L1009
	jmp	.L1008
.L1009:
	decl	a
	jmp	.L1007
.L1008:
	incl	a
.L1010:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L1012
	jmp	.L1011
.L1012:
	movl	b, %eax
	movl	%eax, a
.L1013:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L1015
	jmp	.L1010
.L1015:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L1016:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L1019
	jmp	.L1017
.L1019:
	movl	a, %eax
	cmpl	b, %eax
	je	.L1021
	jmp	.L1020
.L1021:
	incl	a
	jmp	.L1019
.L1020:
	incl	b
	jmp	.L1016
.L1017:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L1022:
	cmpl	$0, a
	jne	.L1024
	jmp	.L1013
.L1024:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L1022
.L1011:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L1025:
	cmpl	$0, c
	jne	.L1027
	jmp	.L1004
.L1027:
	incl	c
	jmp	.L1025
.L1005:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L1028:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L1030
	jmp	.L1029
.L1030:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L1028
.L1029:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L1031:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L1033
	jmp	.L1032
.L1033:
	incl	a
.L1034:
	cmpl	$0, a
	jne	.L1036
	jmp	.L1035
.L1036:
	decl	a
	jmp	.L1034
.L1035:
	incl	a
.L1037:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L1039
	jmp	.L1038
.L1039:
	movl	b, %eax
	movl	%eax, a
.L1040:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L1042
	jmp	.L1037
.L1042:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L1043:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L1046
	jmp	.L1044
.L1046:
	movl	a, %eax
	cmpl	b, %eax
	je	.L1048
	jmp	.L1047
.L1048:
	incl	a
	jmp	.L1046
.L1047:
	incl	b
	jmp	.L1043
.L1044:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L1049:
	cmpl	$0, a
	jne	.L1051
	jmp	.L1040
.L1051:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L1049
.L1038:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L1052:
	cmpl	$0, c
	jne	.L1054
	jmp	.L1031
.L1054:
	incl	c
	jmp	.L1052
.L1032:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L1055:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L1057
	jmp	.L1056
.L1057:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L1055
.L1056:
	incl	a
	movl	b, %eax
	andl	%eax, a
.L1058:
	movl	a, %eax
	cltd
	idivl	b
	testl	%edx, %edx
	jne	.L1060
	jmp	.L1059
.L1060:
	incl	a
.L1061:
	cmpl	$0, a
	jne	.L1063
	jmp	.L1062
.L1063:
	decl	a
	jmp	.L1061
.L1062:
	incl	a
.L1064:
	movl	a, %eax
	addl	b, %eax
	testl	%eax, %eax
	jne	.L1066
	jmp	.L1065
.L1066:
	movl	b, %eax
	movl	%eax, a
.L1067:
	movl	b, %eax
	orl	a, %eax
	testl	%eax, %eax
	jne	.L1069
	jmp	.L1064
.L1069:
	movl	b, %eax
	andl	a, %eax
	movl	%eax, d
.L1070:
	movl	a, %eax
	cmpl	b, %eax
	jle	.L1073
	jmp	.L1071
.L1073:
	movl	a, %eax
	cmpl	b, %eax
	je	.L1075
	jmp	.L1074
.L1075:
	incl	a
	jmp	.L1073
.L1074:
	incl	b
	jmp	.L1070
.L1071:
	movl	b, %eax
	xorl	c, %eax
	movl	%eax, d
.L1076:
	cmpl	$0, a
	jne	.L1078
	jmp	.L1067
.L1078:
	movl	a, %eax
	cltd
	idivl	b
	movl	%edx, a
	jmp	.L1076
.L1065:
	movl	b, %eax
	movl	a, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, c
.L1079:
	cmpl	$0, c
	jne	.L1081
	jmp	.L1058
.L1081:
	incl	c
	jmp	.L1079
.L1059:
	movl	b, %eax
	notl	%eax
	movl	%eax, a
.L1082:
	movl	a, %eax
	notl	%eax
	testl	%eax, %eax
	jne	.L1084
	jmp	.L1083
.L1084:
	movl	b, %eax
	cltd
	idivl	a
	imull	c, %eax
	movl	%eax, d
	jmp	.L1082
.L1083:
	incl	a
	jmp	.L2
.L3:
	subl	$12, %esp
	pushl	d
	pushl	c
	pushl	b
	pushl	a
	pushl	$.LC1
	call	printf
	addl	$32, %esp
	movl	%eax, -4(%ebp)
	movl	$0, %eax
	leave
	ret
.Lfe1:
	.size	main,.Lfe1-main
	.comm	a,4,4
	.comm	b,4,4
	.ident	"GCC: (GNU) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)"
