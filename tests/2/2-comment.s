.section .rodata

.section .data

.section .bss

.section .text

	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$0, %rsp                         # fixed frame size
	movl	$3, %eax
	leave
	ret
