.section .rodata
__fmt_string0:	.string "%d %d\n"
__fmt_string1:	.string "%d\n"
__fmt_string2:	.string "%d %d\n"

.section .data
	.globl	a
	.data
	.align	4
	.type	a, @object
	.size	a, 4
a:
	.long	-1
	.globl	b
	.data
	.align	4
	.type	b, @object
	.size	b, 4
b:
	.long	1

.section .bss

.section .text

	.globl	inc_a
	.type	inc_a, @function
inc_a:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp                        # fixed frame size
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -4(%rbp)
	movl	-4(%rbp), %r8d
	movl	%r8d, -8(%rbp)
	movl	-8(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -12(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)                   # assign int
	movl	-4(%rbp), %r8d
	movl	%r8d, -16(%rbp)
	movl	-16(%rbp), %eax
	leaq	a(%rip), %rbx                    # assign int
	movl	%eax, (%rbx)
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -20(%rbp)
	movl	-20(%rbp), %eax
	leave
	ret

	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$96, %rsp                        # fixed frame size
	movl	$5, -4(%rbp)
.L1:
                                             # enter while
.L2:
	movl	-4(%rbp), %r8d
	movl	%r8d, -8(%rbp)
	movl	-8(%rbp), %r8d
	movl	$0, %r9d
	cmpl	%r9d, %r8d                       # if >=
	jge	.L4
	jmp	.L3
.L3:
                                             # exit while
	jmp	.L16
.L4:
.L5:
	call	inc_a
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L6
	jmp	.L9
.L6:
	call	inc_a
	movl	%eax, -16(%rbp)
	movl	-16(%rbp), %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L7
	jmp	.L9
.L7:
	call	inc_a
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L8
	jmp	.L9
.L8:
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -24(%rbp)
	leaq	b(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -28(%rbp)
	leaq	__fmt_string0(%rip), %rdi        # param 0
	movl	-24(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	movl	-28(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rdx                        # param 2
	call	printf
.L9:                                         # endif
.L10:
	call	inc_a
	movl	%eax, -32(%rbp)
	movl	-32(%rbp), %r8d
	movl	$14, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L13
	jmp	.L11
.L11:
	call	inc_a
	movl	%eax, -36(%rbp)
	movl	-36(%rbp), %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L12
	jmp	.L14
.L12:
	call	inc_a
	movl	%eax, -40(%rbp)
	call	inc_a
	movl	%eax, -44(%rbp)
	movl	-40(%rbp), %r8d
	movl	-44(%rbp), %r9d
	subl	%r9d, %r8d
	movl	%r8d, -48(%rbp)
	movl	-48(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -52(%rbp)
	movl	-52(%rbp), %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L13
	jmp	.L14
.L13:
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -56(%rbp)
	leaq	__fmt_string1(%rip), %rdi        # param 0
	movl	-56(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	leaq	b(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -60(%rbp)
	movl	-60(%rbp), %r8d
	movl	$2, %r9d
	imull	%r9d, %r8d
	movl	%r8d, -64(%rbp)
	movl	-64(%rbp), %eax
	leaq	b(%rip), %rbx                    # assign int
	movl	%eax, (%rbx)
	jmp	.L15
.L14:
	call	inc_a
	movl	%eax, -68(%rbp)
.L15:
	movl	-4(%rbp), %r8d
	movl	%r8d, -72(%rbp)
	movl	-72(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -76(%rbp)
	movl	-76(%rbp), %eax
	movl	%eax, -4(%rbp)                   # assign int
	jmp	.L1
.L16:                                        # end while
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -80(%rbp)
	leaq	b(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -84(%rbp)
	leaq	__fmt_string2(%rip), %rdi        # param 0
	movl	-80(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	movl	-84(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rdx                        # param 2
	call	printf
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -88(%rbp)
	movl	-88(%rbp), %eax
	leave
	ret
