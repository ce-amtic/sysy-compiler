.section .rodata
__fmt_string0:	.string "%d\n"

.section .data

.section .bss

.section .text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movl	$1, -32(%rbp)
	movl	$2, -28(%rbp)
	movl	$3, -24(%rbp)
	movl	$4, -20(%rbp)
	movl	$0, -16(%rbp)
	movl	$0, -12(%rbp)
	movl	$7, -8(%rbp)
	movl	$0, -4(%rbp)
	subq	$4, %rsp
	movl	$3, -36(%rbp)
	subq	$32, %rsp
	movl	$0, -68(%rbp)
	movl	$0, -64(%rbp)
	movl	$0, -60(%rbp)
	movl	$0, -56(%rbp)
	movl	$0, -52(%rbp)
	movl	$0, -48(%rbp)
	movl	$0, -44(%rbp)
	movl	$0, -40(%rbp)
	subq	$32, %rsp
	movl	$1, -100(%rbp)
	movl	$2, -96(%rbp)
	movl	$3, -92(%rbp)
	movl	$4, -88(%rbp)
	movl	$5, -84(%rbp)
	movl	$6, -80(%rbp)
	movl	$7, -76(%rbp)
	movl	$8, -72(%rbp)
	movl	$6, %ecx
	movslq	%ecx, %rcx
	subq	$32, %rsp
	movl	$1, -132(%rbp)
	movl	$2, -128(%rbp)
	movl	$3, -124(%rbp)
	movl	$0, -120(%rbp)
	movl	$5, -116(%rbp)
	movl	$0, -112(%rbp)
	movl	$7, -108(%rbp)
	movl	$8, -104(%rbp)
	movl	$5, %ecx
	movslq	%ecx, %rcx
	movl	-132(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -136(%rbp)
	movl	$5, %ecx
	movslq	%ecx, %rcx
	movl	-100(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -140(%rbp)
	subq	$32, %rsp
	movl	-136(%rbp), %eax
	movl	%eax, -172(%rbp)
	movl	-140(%rbp), %eax
	movl	%eax, -168(%rbp)
	movl	$3, -164(%rbp)
	movl	$4, -160(%rbp)
	movl	$5, -156(%rbp)
	movl	$6, -152(%rbp)
	movl	$7, -148(%rbp)
	movl	$8, -144(%rbp)
	movl	$7, %ecx
	movslq	%ecx, %rcx
	movl	-172(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -176(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movl	-172(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -180(%rbp)
	movl	-176(%rbp), %r8d
	movl	-180(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -184(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movl	-172(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -188(%rbp)
	movl	-184(%rbp), %r8d
	movl	-188(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -192(%rbp)
	movl	$6, %ecx
	movslq	%ecx, %rcx
	movl	-132(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -196(%rbp)
	movl	-192(%rbp), %r8d
	movl	-196(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -200(%rbp)
	subq	$8, %rsp                         # align stack
	leaq	__fmt_string0(%rip), %rdi		# printf
	movl	-200(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi
	call	printf
	movl	$0, %eax
	leave
	ret

