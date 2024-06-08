.section .rodata

.align	4
.type	a, @object
.size	a, 32
a:
	.long	1
	.long	2
	.long	3
	.long	4
	.zero	8
	.long	7
	.zero	4
__fmt_string11:	.string "%d\n"

.section .data

.section .bss

.section .text

	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$176, %rsp                       # fixed frame size
	movl	$3, -4(%rbp)
	movl	$0, -36(%rbp)
	movl	$0, -32(%rbp)
	movl	$0, -28(%rbp)
	movl	$0, -24(%rbp)
	movl	$0, -20(%rbp)
	movl	$0, -16(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, -8(%rbp)
	movl	$1, -68(%rbp)
	movl	$2, -64(%rbp)
	movl	$3, -60(%rbp)
	movl	$4, -56(%rbp)
	movl	$5, -52(%rbp)
	movl	$6, -48(%rbp)
	movl	$7, -44(%rbp)
	movl	$8, -40(%rbp)
	movl	$6, %ecx
	movslq	%ecx, %rcx
	movl	$1, -100(%rbp)
	movl	$2, -96(%rbp)
	movl	$3, -92(%rbp)
	movl	$0, -88(%rbp)
	movl	$5, -84(%rbp)
	movl	$0, -80(%rbp)
	movl	$7, -76(%rbp)
	movl	$8, -72(%rbp)
	movl	$5, %ecx
	movslq	%ecx, %rcx
	movl	-100(%rbp, %rcx, 4), %eax
	movl	%eax, -104(%rbp)
	movl	$5, %ecx
	movslq	%ecx, %rcx
	movl	-68(%rbp, %rcx, 4), %eax
	movl	%eax, -108(%rbp)
	movl	-104(%rbp), %eax
	movl	%eax, -140(%rbp)
	movl	-108(%rbp), %eax
	movl	%eax, -136(%rbp)
	movl	$3, -132(%rbp)
	movl	$4, -128(%rbp)
	movl	$5, -124(%rbp)
	movl	$6, -120(%rbp)
	movl	$7, -116(%rbp)
	movl	$8, -112(%rbp)
	movl	$7, %ecx
	movslq	%ecx, %rcx
	movl	-140(%rbp, %rcx, 4), %eax
	movl	%eax, -144(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movl	-140(%rbp, %rcx, 4), %eax
	movl	%eax, -148(%rbp)
	movl	-144(%rbp), %r8d
	movl	-148(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -152(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movl	-140(%rbp, %rcx, 4), %eax
	movl	%eax, -156(%rbp)
	movl	-152(%rbp), %r8d
	movl	-156(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -160(%rbp)
	movl	$6, %ecx
	movslq	%ecx, %rcx
	movl	-100(%rbp, %rcx, 4), %eax
	movl	%eax, -164(%rbp)
	movl	-160(%rbp), %r8d
	movl	-164(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -168(%rbp)
	leaq	__fmt_string11(%rip), %rdi       # param 0
	movl	-168(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	movl	$0, %eax
	leave
	ret
