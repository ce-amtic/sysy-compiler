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
.L1:
	movl	24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -4(%rbp)
	subq	$12, %rsp                        # align stack
	movl	-4(%rbp), %r8d
	movl	$0, %r9d
	cmpl	%r9d, %r8d		               # if ==
	je	.L2
	jmp	.L3
.L2:
                                             # enter block
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	32(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx		     # assign pointer
	movl	$1, %eax
	movl	%eax, (%rbx)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx		     # assign pointer
	movl	$0, %eax
	movl	%eax, (%rbx)
	movl	16(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -20(%rbp)
	movl	-20(%rbp), %eax
	leave
	ret

	addq	$4, %rsp		                 # exiting block, restore %rsp
	jmp	.L4
.L3:
                                             # enter block
	movl	24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -20(%rbp)
	movl	16(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -24(%rbp)
	movl	24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -28(%rbp)
	movl	-24(%rbp), %eax
	movl	-28(%rbp), %r9d
	cltd
	idivl	%r9d
	subq	$4, %rsp
	movl	%edx, -32(%rbp)
	subq	$8, %rsp
	movq	32(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp
	movq	40(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 3
	movq	-48(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 2
	movq	-40(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 1
	movl	-32(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 0
	movl	-20(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	call	exgcd

	addq	$32, %rsp
	subq	$4, %rsp
	movl	%eax, -52(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	32(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -56(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -60(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	32(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx		     # assign pointer
	movl	-60(%rbp), %eax
	movl	%eax, (%rbx)
	movl	-56(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -64(%rbp)
	movl	16(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -68(%rbp)
	movl	24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -72(%rbp)
	movl	-68(%rbp), %eax
	movl	-72(%rbp), %r9d
	cltd
	idivl	%r9d
	subq	$4, %rsp
	movl	%eax, -76(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -80(%rbp)
	movl	-76(%rbp), %r8d
	movl	-80(%rbp), %r9d
	imull	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -84(%rbp)
	movl	-64(%rbp), %r8d
	movl	-84(%rbp), %r9d
	subl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -88(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx		     # assign pointer
	movl	-88(%rbp), %eax
	movl	%eax, (%rbx)
	movl	-52(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -92(%rbp)
	movl	-92(%rbp), %eax
	leave
	ret

	addq	$76, %rsp		                # exiting block, restore %rsp
.L4:
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$4, %rsp
	movl	$7, -4(%rbp)
	subq	$4, %rsp
	movl	$15, -8(%rbp)
	subq	$4, %rsp
	movl	$1, -12(%rbp)
	subq	$4, %rsp
	movl	$1, -16(%rbp)
	movl	-4(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -20(%rbp)
	movl	-8(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -24(%rbp)
	subq	$8, %rsp
	leaq	-12(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp
	leaq	-16(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp                         # align stack
	subq	$8, %rsp		                 # param 3
	movq	-40(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 2
	movq	-32(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 1
	movl	-24(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 0
	movl	-20(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	call	exgcd

	addq	$32, %rsp
	subq	$4, %rsp
	movl	%eax, -52(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movl	-12(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -56(%rbp)
	movl	-8(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -60(%rbp)
	movl	-56(%rbp), %eax
	movl	-60(%rbp), %r9d
	cltd
	idivl	%r9d
	subq	$4, %rsp
	movl	%edx, -64(%rbp)
	movl	-8(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -68(%rbp)
	movl	-64(%rbp), %r8d
	movl	-68(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -72(%rbp)
	movl	-8(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -76(%rbp)
	movl	-72(%rbp), %eax
	movl	-76(%rbp), %r9d
	cltd
	idivl	%r9d
	subq	$4, %rsp
	movl	%edx, -80(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movl	-80(%rbp), %eax
	leaq	-12(%rbp, %rcx, 4), %rbx		 # assign int_array
	movl	%eax, (%rbx)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movl	-12(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -84(%rbp)
	subq	$12, %rsp                        # align stack
	leaq	__fmt_string0(%rip), %rdi		# printf
	movl	-84(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi
	call	printf
	movl	$0, %eax
	leave
	ret

