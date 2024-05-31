.section .rodata

.section .data

.section .bss

.section .text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$3, %eax
	leave
	ret

