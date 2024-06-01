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
	subq	$32, %rsp                        # fixed frame size
	movl	$1, -4(%rbp)
	movl	$2, -8(%rbp)
	movl	-4(%rbp), %r8d
	movl	%r8d, -12(%rbp)
	movl	-8(%rbp), %r8d
	movl	%r8d, -16(%rbp)
	movl	-12(%rbp), %r8d
	movl	-16(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -20(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -24(%rbp)
	leaq	__fmt_string0(%rip), %rdi        # param 0
	movl	-24(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	movl	$0, %eax
	leave
	ret
