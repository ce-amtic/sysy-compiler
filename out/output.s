.section .rodata
__fmt_string0:	.string "%d\n"

.section .data

.section .bss

.section .text

	.globl	exgcd
	.type	exgcd, @function
exgcd:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$128, %rsp                       # fixed frame size
.L1:
	movl	24(%rbp), %r8d
	movl	%r8d, -4(%rbp)
	movl	-4(%rbp), %r8d
	movl	$0, %r9d
	cmpl	%r9d, %r8d                       # if ==
	je	.L2
	jmp	.L3
.L2:
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	32(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx             # assign pointer
	movl	$1, %eax
	movl	%eax, (%rbx)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx             # assign pointer
	movl	$0, %eax
	movl	%eax, (%rbx)
	movl	16(%rbp), %r8d
	movl	%r8d, -8(%rbp)
	movl	-8(%rbp), %eax
	leave
	ret
	jmp	.L4
.L3:
	movl	24(%rbp), %r8d
	movl	%r8d, -12(%rbp)
	movl	16(%rbp), %r8d
	movl	%r8d, -16(%rbp)
	movl	24(%rbp), %r8d
	movl	%r8d, -20(%rbp)
	movl	-16(%rbp), %eax
	movl	-20(%rbp), %r9d
	cltd
	idivl	%r9d
	movl	%edx, -24(%rbp)
	movq	32(%rbp), %r8
	movq	%r8, -32(%rbp)
	movq	40(%rbp), %r8
	movq	%r8, -40(%rbp)
	movq	-40(%rbp), %r8
	movq	%r8, 24(%rsp)                    # param 3
	movq	-32(%rbp), %r8
	movq	%r8, 16(%rsp)                    # param 2
	movl	-24(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 8(%rsp)                     # param 1
	movl	-12(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	exgcd
	movl	%eax, -44(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	32(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -48(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -52(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	32(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx             # assign pointer
	movl	-52(%rbp), %eax
	movl	%eax, (%rbx)
	movl	-48(%rbp), %r8d
	movl	%r8d, -56(%rbp)
	movl	16(%rbp), %r8d
	movl	%r8d, -60(%rbp)
	movl	24(%rbp), %r8d
	movl	%r8d, -64(%rbp)
	movl	-60(%rbp), %eax
	movl	-64(%rbp), %r9d
	cltd
	idivl	%r9d
	movl	%eax, -68(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -72(%rbp)
	movl	-68(%rbp), %r8d
	movl	-72(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -76(%rbp)
	movl	-56(%rbp), %r8d
	movl	-76(%rbp), %r9d
	subl	%r9d, %r8d
	movl	%r8d, -80(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx             # assign pointer
	movl	-80(%rbp), %eax
	movl	%eax, (%rbx)
	movl	-44(%rbp), %r8d
	movl	%r8d, -84(%rbp)
	movl	-84(%rbp), %eax
	leave
	ret
.L4:

	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$112, %rsp                       # fixed frame size
	movl	$7, -4(%rbp)
	movl	$15, -8(%rbp)
	movl	$1, -12(%rbp)
	movl	$1, -16(%rbp)
	movl	-4(%rbp), %r8d
	movl	%r8d, -20(%rbp)
	movl	-8(%rbp), %r8d
	movl	%r8d, -24(%rbp)
	leaq	-12(%rbp), %r8
	movq	%r8, -32(%rbp)
	leaq	-16(%rbp), %r8
	movq	%r8, -40(%rbp)
	movq	-40(%rbp), %r8
	movq	%r8, 24(%rsp)                    # param 3
	movq	-32(%rbp), %r8
	movq	%r8, 16(%rsp)                    # param 2
	movl	-24(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 8(%rsp)                     # param 1
	movl	-20(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	exgcd
	movl	%eax, -44(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movl	-12(%rbp, %rcx, 4), %eax
	movl	%eax, -48(%rbp)
	movl	-8(%rbp), %r8d
	movl	%r8d, -52(%rbp)
	movl	-48(%rbp), %eax
	movl	-52(%rbp), %r9d
	cltd
	idivl	%r9d
	movl	%edx, -56(%rbp)
	movl	-8(%rbp), %r8d
	movl	%r8d, -60(%rbp)
	movl	-56(%rbp), %r8d
	movl	-60(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -64(%rbp)
	movl	-8(%rbp), %r8d
	movl	%r8d, -68(%rbp)
	movl	-64(%rbp), %eax
	movl	-68(%rbp), %r9d
	cltd
	idivl	%r9d
	movl	%edx, -72(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movl	-72(%rbp), %eax
	leaq	-12(%rbp, %rcx, 4), %rbx         # assign int_array
	movl	%eax, (%rbx)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movl	-12(%rbp, %rcx, 4), %eax
	movl	%eax, -76(%rbp)
	leaq	__fmt_string0(%rip), %rdi        # param 0
	movl	-76(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	movl	$0, %eax
	leave
	ret
