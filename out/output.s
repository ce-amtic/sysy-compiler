.section .rodata
__fmt_string0:	.string "%d\n"
__fmt_string1:	.string "%d %d\n"

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
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
.L1:
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -4(%rbp)
	leaq	b(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -8(%rbp)
	movl	-4(%rbp), %r8d
	movl	-8(%rbp), %r9d
	subl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -12(%rbp)
	subq	$4, %rsp                         # align stack
	movl	-12(%rbp), %r8d
	cmpl	$0, %r8d		                 # if != 0
	jne	.L3
	jmp	.L2
.L2:
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -20(%rbp)
	leaq	b(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -24(%rbp)
	movl	-20(%rbp), %r8d
	movl	-24(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -28(%rbp)
	subq	$4, %rsp                         # align stack
	movl	-28(%rbp), %r8d
	movl	$14, %r9d
	cmpl	%r9d, %r8d		               # if <
	jl	.L3
	jmp	.L4
.L3:
                                             # enter block
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -36(%rbp)
	subq	$12, %rsp                        # align stack
	leaq	__fmt_string0(%rip), %rdi		# printf
	movl	-36(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi
	call	printf
	leaq	b(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -52(%rbp)
	movl	-52(%rbp), %r8d
	movl	$2, %r9d
	imull	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -56(%rbp)
	movl	-56(%rbp), %eax
	leaq	b(%rip), %rbx		            # assign int
	movl	%eax, (%rbx)
	addq	$24, %rsp		                # exiting block, restore %rsp
.L4:		                                 # endif
	leaq	a(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -36(%rbp)
	leaq	b(%rip), %rbx
	movl	0(%rbx), %r8d
	subq	$4, %rsp
	movl	%r8d, -40(%rbp)
	subq	$8, %rsp                         # align stack
	leaq	__fmt_string1(%rip), %rdi		# printf
	movl	-36(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi
	movl	-40(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rdx
	call	printf
	movl	$0, %eax
	leave
	ret

