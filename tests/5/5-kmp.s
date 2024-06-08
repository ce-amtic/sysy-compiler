.section .rodata
__fmt_string0:	.string "%c"
__fmt_string1:	.string "%d\n"

.section .data

.section .bss

.section .text
	.globl	get_next
	.type	get_next, @function
get_next:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$80, %rsp                        # fixed frame size
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	24(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx             # assign pointer
	movl	$-1, %eax
	movl	%eax, (%rbx)
	movl	$0, -4(%rbp)
	movl	$-1, -8(%rbp)
.L1:
                                             # enter while
.L2:
	movl	-4(%rbp), %r8d
	movl	%r8d, -12(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-12(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -16(%rbp)
	movl	-16(%rbp), %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L4
	jmp	.L3
.L3:
                                             # exit while
	jmp	.L10
.L4:
.L5:
	movl	-8(%rbp), %r8d
	movl	%r8d, -20(%rbp)
	movl	-20(%rbp), %r8d
	movl	$-1, %r9d
	cmpl	%r9d, %r8d                       # if ==
	je	.L7
	jmp	.L6
.L6:
	movl	-4(%rbp), %r8d
	movl	%r8d, -24(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-24(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -28(%rbp)
	movl	-8(%rbp), %r8d
	movl	%r8d, -32(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-32(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -36(%rbp)
	movl	-28(%rbp), %r8d
	movl	-36(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if ==
	je	.L7
	jmp	.L8
.L7:
	movl	-8(%rbp), %r8d
	movl	%r8d, -40(%rbp)
	movl	-40(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -44(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, -8(%rbp)                   # assign int
	movl	-4(%rbp), %r8d
	movl	%r8d, -48(%rbp)
	movl	-48(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -52(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -4(%rbp)                   # assign int
	movl	-4(%rbp), %r8d
	movl	%r8d, -56(%rbp)
	movl	-8(%rbp), %r8d
	movl	%r8d, -60(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-56(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	24(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx             # assign pointer
	movl	-60(%rbp), %eax
	movl	%eax, (%rbx)
	jmp	.L9
.L8:
	movl	-8(%rbp), %r8d
	movl	%r8d, -64(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-64(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	24(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -68(%rbp)
	movl	-68(%rbp), %eax
	movl	%eax, -8(%rbp)                   # assign int
.L9:
	jmp	.L1
.L10:                                        # end while
	leave
	ret

	.globl	KMP
	.type	KMP, @function
KMP:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16512, %rsp                     # fixed frame size
	movq	16(%rbp), %r8
	movq	%r8, -16392(%rbp)
	leaq	-16384(%rbp), %r8
	movq	%r8, -16400(%rbp)
	movq	-16400(%rbp), %r8
	movq	%r8, 8(%rsp)                     # param 1
	movq	-16392(%rbp), %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	get_next
	movl	$0, -16404(%rbp)
	movl	$0, -16408(%rbp)
.L11:
                                             # enter while
.L12:
	movl	-16408(%rbp), %r8d
	movl	%r8d, -16412(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-16412(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	24(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -16416(%rbp)
	movl	-16416(%rbp), %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L14
	jmp	.L13
.L13:
                                             # exit while
	jmp	.L25
.L14:
.L15:
	movl	-16404(%rbp), %r8d
	movl	%r8d, -16420(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-16420(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -16424(%rbp)
	movl	-16408(%rbp), %r8d
	movl	%r8d, -16428(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-16428(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	24(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -16432(%rbp)
	movl	-16424(%rbp), %r8d
	movl	-16432(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if ==
	je	.L16
	jmp	.L20
.L16:
	movl	-16404(%rbp), %r8d
	movl	%r8d, -16436(%rbp)
	movl	-16436(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -16440(%rbp)
	movl	-16440(%rbp), %eax
	movl	%eax, -16404(%rbp)               # assign int
	movl	-16408(%rbp), %r8d
	movl	%r8d, -16444(%rbp)
	movl	-16444(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -16448(%rbp)
	movl	-16448(%rbp), %eax
	movl	%eax, -16408(%rbp)               # assign int
.L17:
	movl	-16404(%rbp), %r8d
	movl	%r8d, -16452(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-16452(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -16456(%rbp)
	movl	-16456(%rbp), %eax
	testl %eax, %eax
	sete %al
	movzbl %al, %eax
	movl	%eax, -16460(%rbp)
	movl	-16460(%rbp), %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L18
	jmp	.L19
.L18:
	movl	-16408(%rbp), %r8d
	movl	%r8d, -16464(%rbp)
	movl	-16464(%rbp), %eax
	leave
	ret
.L19:                                        # endif
	jmp	.L24
.L20:
	movl	-16404(%rbp), %r8d
	movl	%r8d, -16468(%rbp)
	movl	$0, %ecx
	imull	$4096, %ecx
	movl	-16468(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-16384(%rbp, %rcx, 4), %eax
	movl	%eax, -16472(%rbp)
	movl	-16472(%rbp), %eax
	movl	%eax, -16404(%rbp)               # assign int
.L21:
	movl	-16404(%rbp), %r8d
	movl	%r8d, -16476(%rbp)
	movl	-16476(%rbp), %r8d
	movl	$-1, %r9d
	cmpl	%r9d, %r8d                       # if ==
	je	.L22
	jmp	.L23
.L22:
	movl	-16404(%rbp), %r8d
	movl	%r8d, -16480(%rbp)
	movl	-16480(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -16484(%rbp)
	movl	-16484(%rbp), %eax
	movl	%eax, -16404(%rbp)               # assign int
	movl	-16408(%rbp), %r8d
	movl	%r8d, -16488(%rbp)
	movl	-16488(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -16492(%rbp)
	movl	-16492(%rbp), %eax
	movl	%eax, -16408(%rbp)               # assign int
.L23:                                        # endif
.L24:
	jmp	.L11
.L25:                                        # end while
	movl	$-1, %eax
	leave
	ret

	.globl	read_str
	.type	read_str, @function
read_str:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp                        # fixed frame size
	movl	$0, -4(%rbp)
.L26:
                                             # enter while
.L27:
	movl	$1, %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L29
	jmp	.L28
.L28:
                                             # exit while
	jmp	.L33
.L29:
	movl	-4(%rbp), %r8d
	movl	%r8d, -8(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-8(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %r8
	movq	%r8, -16(%rbp)
	leaq	__fmt_string0(%rip), %rdi        # param 0
	movq	-16(%rbp), %rsi                  # param 1
	call	scanf
.L30:
	movl	-4(%rbp), %r8d
	movl	%r8d, -20(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-20(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %r8d
	movl	$10, %r9d
	cmpl	%r9d, %r8d                       # if ==
	je	.L31
	jmp	.L32
.L31:

	jmp	.L33
.L32:                                        # endif
	movl	-4(%rbp), %r8d
	movl	%r8d, -28(%rbp)
	movl	-28(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -32(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -4(%rbp)                   # assign int
	jmp	.L26
.L33:                                        # end while
	movl	-4(%rbp), %r8d
	movl	%r8d, -36(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-36(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx             # assign pointer
	movl	$0, %eax
	movl	%eax, (%rbx)
	movl	-4(%rbp), %r8d
	movl	%r8d, -40(%rbp)
	movl	-40(%rbp), %eax
	leave
	ret

	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32832, %rsp                     # fixed frame size
	leaq	-16384(%rbp), %r8
	movq	%r8, -32776(%rbp)
	movq	-32776(%rbp), %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	read_str
	movl	%eax, -32780(%rbp)
	leaq	-32768(%rbp), %r8
	movq	%r8, -32788(%rbp)
	movq	-32788(%rbp), %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	read_str
	movl	%eax, -32792(%rbp)
	leaq	-16384(%rbp), %r8
	movq	%r8, -32800(%rbp)
	leaq	-32768(%rbp), %r8
	movq	%r8, -32808(%rbp)
	movq	-32808(%rbp), %r8
	movq	%r8, 8(%rsp)                     # param 1
	movq	-32800(%rbp), %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	KMP
	movl	%eax, -32812(%rbp)
	leaq	__fmt_string1(%rip), %rdi        # param 0
	movl	-32812(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	movl	$8, %eax
	leave
	ret
