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
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -4(%rbp)
	movl	-4(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -8(%rbp)
	movl	-8(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -12(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)		           # assign int
	movl	-4(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -16(%rbp)
	movl	-16(%rbp), %eax
	leaq	a(%rip), %rbx		            # assign int
	movl	%eax, (%rbx)
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -20(%rbp)
	movl	-20(%rbp), %eax
	leave
	ret

	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$4, %rsp
	movl	$5, -4(%rbp)
.L1:
                                             # enter while
                                             # enter block
.L2:
	movl	-4(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -8(%rbp)
	subq	$8, %rsp                         # align stack
	movl	-8(%rbp), %r8d
	movl	$0, %r9d
	cmpl	%r9d, %r8d		               # if >=
	jge	.L4
	jmp	.L3
.L3:
                                             # exit while
	addq	$12, %rsp
	jmp	.L16
.L4:
.L5:
	call	inc_a
	subq	$4, %rsp
	movl	%eax, -20(%rbp)
	subq	$12, %rsp                        # align stack
	movl	-20(%rbp), %r8d
	cmpl	$0, %r8d		                 # if != 0
	jne	.L6
	jmp	.L9
.L6:
	call	inc_a
	subq	$4, %rsp
	movl	%eax, -36(%rbp)
	subq	$12, %rsp                        # align stack
	movl	-36(%rbp), %r8d
	cmpl	$0, %r8d		                 # if != 0
	jne	.L7
	jmp	.L9
.L7:
	call	inc_a
	subq	$4, %rsp
	movl	%eax, -52(%rbp)
	subq	$12, %rsp                        # align stack
	movl	-52(%rbp), %r8d
	cmpl	$0, %r8d		                 # if != 0
	jne	.L8
	jmp	.L9
.L8:
                                             # enter block
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -68(%rbp)
	leaq	b(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -72(%rbp)
	subq	$8, %rsp                         # align stack
	leaq	__fmt_string0(%rip), %rdi		# printf
	movl	-68(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi
	movl	-72(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rdx
	call	printf
	addq	$16, %rsp		                # exiting block, restore %rsp
.L9:		                                 # endif
.L10:
	call	inc_a
	subq	$4, %rsp
	movl	%eax, -68(%rbp)
	subq	$12, %rsp                        # align stack
	movl	-68(%rbp), %r8d
	movl	$14, %r9d
	cmpl	%r9d, %r8d		               # if <
	jl	.L13
	jmp	.L11
.L11:
	call	inc_a
	subq	$4, %rsp
	movl	%eax, -84(%rbp)
	subq	$12, %rsp                        # align stack
	movl	-84(%rbp), %r8d
	cmpl	$0, %r8d		                 # if != 0
	jne	.L12
	jmp	.L14
.L12:
	call	inc_a
	subq	$4, %rsp
	movl	%eax, -100(%rbp)
	subq	$12, %rsp                        # align stack
	call	inc_a
	subq	$4, %rsp
	movl	%eax, -116(%rbp)
	movl	-100(%rbp), %r8d
	movl	-116(%rbp), %r9d
	subl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -120(%rbp)
	movl	-120(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -124(%rbp)
	subq	$4, %rsp                         # align stack
	movl	-124(%rbp), %r8d
	cmpl	$0, %r8d		                 # if != 0
	jne	.L13
	jmp	.L14
.L13:
                                             # enter block
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -132(%rbp)
	subq	$12, %rsp                        # align stack
	leaq	__fmt_string1(%rip), %rdi		# printf
	movl	-132(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi
	call	printf
	leaq	b(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -148(%rbp)
	movl	-148(%rbp), %r8d
	movl	$2, %r9d
	imull	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -152(%rbp)
	movl	-152(%rbp), %eax
	leaq	b(%rip), %rbx		            # assign int
	movl	%eax, (%rbx)
	addq	$24, %rsp		                # exiting block, restore %rsp
	jmp	.L15
.L14:
                                             # enter block
	call	inc_a
	subq	$4, %rsp
	movl	%eax, -132(%rbp)
	addq	$4, %rsp		                 # exiting block, restore %rsp
.L15:
	movl	-4(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -132(%rbp)
	movl	-132(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -136(%rbp)
	movl	-136(%rbp), %eax
	movl	%eax, -4(%rbp)		           # assign int
	addq	$132, %rsp		               # exiting block, restore %rsp
	jmp	.L1
.L16:		                                # end while
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -8(%rbp)
	leaq	b(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -12(%rbp)
	subq	$4, %rsp                         # align stack
	leaq	__fmt_string2(%rip), %rdi		# printf
	movl	-8(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi
	movl	-12(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rdx
	call	printf
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -20(%rbp)
	movl	-20(%rbp), %eax
	leave
	ret

