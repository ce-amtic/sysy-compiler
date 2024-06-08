.section .rodata

.align	4
.type	N, @object
.size	N, 4
N:
	.long	100005
__fmt_string5:	.string "%d"
__fmt_string6:	.string "%d\n"

.section .data

.section .bss

.section .text

	.globl	read
	.type	read, @function
read:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp                        # fixed frame size
	movl	$0, -4(%rbp)
	leaq	-4(%rbp), %r8
	movq	%r8, -12(%rbp)
	leaq	__fmt_string5(%rip), %rdi        # param 0
	movq	-12(%rbp), %rsi                  # param 1
	call	scanf
	movl	-4(%rbp), %r8d
	movl	%r8d, -16(%rbp)
	movl	-16(%rbp), %eax
	leave
	ret

	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$800224, %rsp                    # fixed frame size
	movl	$0, -4(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -12(%rbp)
	call	read
	movl	%eax, -800056(%rbp)
	movl	-800056(%rbp), %eax
	movl	%eax, -4(%rbp)                   # assign int
	call	read
	movl	%eax, -800060(%rbp)
	movl	-800060(%rbp), %eax
	movl	%eax, -8(%rbp)                   # assign int
	movl	$1, -800064(%rbp)
.L1:
                                             # enter while
.L2:
	movl	-800064(%rbp), %r8d
	movl	%r8d, -800068(%rbp)
	movl	-4(%rbp), %r8d
	movl	%r8d, -800072(%rbp)
	movl	-800068(%rbp), %r8d
	movl	-800072(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <=
	jle	.L4
	jmp	.L3
.L3:
                                             # exit while
	jmp	.L5
.L4:
	movl	-800064(%rbp), %r8d
	movl	%r8d, -800076(%rbp)
	movl	$0, %ecx
	imull	$100005, %ecx
	movl	-800076(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	$0, %eax
	leaq	-800052(%rbp, %rcx, 4), %rbx     # assign int_array
	movl	%eax, (%rbx)
	movl	-800064(%rbp), %r8d
	movl	%r8d, -800080(%rbp)
	movl	-800080(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -800084(%rbp)
	movl	-800084(%rbp), %eax
	movl	%eax, -800064(%rbp)              # assign int
	jmp	.L1
.L5:                                         # end while
	movl	$2, %eax
	movl	%eax, -800064(%rbp)              # assign int
.L6:
                                             # enter while
.L7:
	movl	-800064(%rbp), %r8d
	movl	%r8d, -800088(%rbp)
	movl	-800088(%rbp), %r8d
	movl	$100005, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L9
	jmp	.L8
.L8:
                                             # exit while
	jmp	.L22
.L9:
.L10:
	movl	-800064(%rbp), %r8d
	movl	%r8d, -800092(%rbp)
	movl	$0, %ecx
	imull	$100005, %ecx
	movl	-800092(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-800052(%rbp, %rcx, 4), %eax
	movl	%eax, -800096(%rbp)
	movl	-800096(%rbp), %eax
	testl %eax, %eax
	sete %al
	movzbl %al, %eax
	movl	%eax, -800100(%rbp)
	movl	-800100(%rbp), %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L11
	jmp	.L12
.L11:
	movl	-12(%rbp), %r8d
	movl	%r8d, -800104(%rbp)
	movl	-800104(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -800108(%rbp)
	movl	-800108(%rbp), %eax
	movl	%eax, -12(%rbp)                  # assign int
	movl	-12(%rbp), %r8d
	movl	%r8d, -800112(%rbp)
	movl	-800064(%rbp), %r8d
	movl	%r8d, -800116(%rbp)
	movl	$0, %ecx
	imull	$100005, %ecx
	movl	-800112(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-800116(%rbp), %eax
	leaq	-400032(%rbp, %rcx, 4), %rbx     # assign int_array
	movl	%eax, (%rbx)
.L12:                                        # endif
	movl	$1, -800120(%rbp)
.L13:
                                             # enter while
.L14:
	movl	-800120(%rbp), %r8d
	movl	%r8d, -800124(%rbp)
	movl	-12(%rbp), %r8d
	movl	%r8d, -800128(%rbp)
	movl	-800124(%rbp), %r8d
	movl	-800128(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <=
	jle	.L15
	jmp	.L16
.L15:
	movl	-800064(%rbp), %r8d
	movl	%r8d, -800132(%rbp)
	movl	-800120(%rbp), %r8d
	movl	%r8d, -800136(%rbp)
	movl	$0, %ecx
	imull	$100005, %ecx
	movl	-800136(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-400032(%rbp, %rcx, 4), %eax
	movl	%eax, -800140(%rbp)
	movl	-800132(%rbp), %r8d
	movl	-800140(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -800144(%rbp)
	movl	-800144(%rbp), %r8d
	movl	$100005, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L17
	jmp	.L16
.L16:
                                             # exit while
	jmp	.L21
.L17:
	movl	-800064(%rbp), %r8d
	movl	%r8d, -800148(%rbp)
	movl	-800120(%rbp), %r8d
	movl	%r8d, -800152(%rbp)
	movl	$0, %ecx
	imull	$100005, %ecx
	movl	-800152(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-400032(%rbp, %rcx, 4), %eax
	movl	%eax, -800156(%rbp)
	movl	-800148(%rbp), %r8d
	movl	-800156(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -800160(%rbp)
	movl	$0, %ecx
	imull	$100005, %ecx
	movl	-800160(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	$1, %eax
	leaq	-800052(%rbp, %rcx, 4), %rbx     # assign int_array
	movl	%eax, (%rbx)
.L18:
	movl	-800064(%rbp), %r8d
	movl	%r8d, -800164(%rbp)
	movl	-800120(%rbp), %r8d
	movl	%r8d, -800168(%rbp)
	movl	$0, %ecx
	imull	$100005, %ecx
	movl	-800168(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-400032(%rbp, %rcx, 4), %eax
	movl	%eax, -800172(%rbp)
	movl	-800164(%rbp), %eax
	movl	-800172(%rbp), %r9d
	cltd
	idivl	%r9d
	movl	%edx, -800176(%rbp)
	movl	-800176(%rbp), %r8d
	movl	$0, %r9d
	cmpl	%r9d, %r8d                       # if ==
	je	.L19
	jmp	.L20
.L19:

	jmp	.L21
.L20:                                        # endif
	movl	-800120(%rbp), %r8d
	movl	%r8d, -800180(%rbp)
	movl	-800180(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -800184(%rbp)
	movl	-800184(%rbp), %eax
	movl	%eax, -800120(%rbp)              # assign int
	jmp	.L13
.L21:                                        # end while
	movl	-800064(%rbp), %r8d
	movl	%r8d, -800188(%rbp)
	movl	-800188(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -800192(%rbp)
	movl	-800192(%rbp), %eax
	movl	%eax, -800064(%rbp)              # assign int
	jmp	.L6
.L22:                                        # end while
.L23:
                                             # enter while
.L24:
	movl	-8(%rbp), %r8d
	movl	%r8d, -800196(%rbp)
	movl	-800196(%rbp), %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L26
	jmp	.L25
.L25:
                                             # exit while
	jmp	.L27
.L26:
	call	read
	movl	%eax, -800200(%rbp)
	movl	-800200(%rbp), %r8d
	movl	%r8d, -800204(%rbp)
	movl	$0, %ecx
	imull	$100005, %ecx
	movl	-800204(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-400032(%rbp, %rcx, 4), %eax
	movl	%eax, -800208(%rbp)
	leaq	__fmt_string6(%rip), %rdi        # param 0
	movl	-800208(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	movl	-8(%rbp), %r8d
	movl	%r8d, -800212(%rbp)
	movl	-800212(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -800216(%rbp)
	movl	-800216(%rbp), %eax
	movl	%eax, -8(%rbp)                   # assign int
	jmp	.L23
.L27:                                        # end while
	leave
	ret
