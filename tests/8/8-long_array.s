.section .rodata

.align	4
.type	N, @object
.size	N, 4
N:
	.long	10000
__fmt_string5:	.string "%d\n"
__fmt_string6:	.string "%d\n"
__fmt_string7:	.string "%d\n"
__fmt_string8:	.string "%d\n"

.section .data

.section .bss

.section .text

	.globl	long_array
	.type	long_array, @function
long_array:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$120352, %rsp                    # fixed frame size
	movl	$0, -120004(%rbp)
.L1:
                                             # enter while
.L2:
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120008(%rbp)
	movl	-120008(%rbp), %r8d
	movl	$10000, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L4
	jmp	.L3
.L3:
                                             # exit while
	jmp	.L5
.L4:
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120012(%rbp)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120016(%rbp)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120020(%rbp)
	movl	-120016(%rbp), %r8d
	movl	-120020(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -120024(%rbp)
	movl	-120024(%rbp), %eax
	movl	$10, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -120028(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120012(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-120028(%rbp), %eax
	leaq	-40000(%rbp, %rcx, 4), %rbx      # assign int_array
	movl	%eax, (%rbx)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120032(%rbp)
	movl	-120032(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120036(%rbp)
	movl	-120036(%rbp), %eax
	movl	%eax, -120004(%rbp)              # assign int
	jmp	.L1
.L5:                                         # end while
	movl	$0, %eax
	movl	%eax, -120004(%rbp)              # assign int
.L6:
                                             # enter while
.L7:
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120040(%rbp)
	movl	-120040(%rbp), %r8d
	movl	$10000, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L9
	jmp	.L8
.L8:
                                             # exit while
	jmp	.L10
.L9:
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120044(%rbp)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120048(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120048(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-40000(%rbp, %rcx, 4), %eax
	movl	%eax, -120052(%rbp)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120056(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120056(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-40000(%rbp, %rcx, 4), %eax
	movl	%eax, -120060(%rbp)
	movl	-120052(%rbp), %r8d
	movl	-120060(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -120064(%rbp)
	movl	-120064(%rbp), %eax
	movl	$10, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -120068(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120044(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-120068(%rbp), %eax
	leaq	-80000(%rbp, %rcx, 4), %rbx      # assign int_array
	movl	%eax, (%rbx)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120072(%rbp)
	movl	-120072(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120076(%rbp)
	movl	-120076(%rbp), %eax
	movl	%eax, -120004(%rbp)              # assign int
	jmp	.L6
.L10:                                        # end while
	movl	$0, %eax
	movl	%eax, -120004(%rbp)              # assign int
.L11:
                                             # enter while
.L12:
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120080(%rbp)
	movl	-120080(%rbp), %r8d
	movl	$10000, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L14
	jmp	.L13
.L13:
                                             # exit while
	jmp	.L15
.L14:
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120084(%rbp)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120088(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120088(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-80000(%rbp, %rcx, 4), %eax
	movl	%eax, -120092(%rbp)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120096(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120096(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-80000(%rbp, %rcx, 4), %eax
	movl	%eax, -120100(%rbp)
	movl	-120092(%rbp), %r8d
	movl	-120100(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -120104(%rbp)
	movl	-120104(%rbp), %eax
	movl	$100, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -120108(%rbp)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120112(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120112(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-40000(%rbp, %rcx, 4), %eax
	movl	%eax, -120116(%rbp)
	movl	-120108(%rbp), %r8d
	movl	-120116(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120120(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120084(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-120120(%rbp), %eax
	leaq	-120000(%rbp, %rcx, 4), %rbx     # assign int_array
	movl	%eax, (%rbx)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120124(%rbp)
	movl	-120124(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120128(%rbp)
	movl	-120128(%rbp), %eax
	movl	%eax, -120004(%rbp)              # assign int
	jmp	.L11
.L15:                                        # end while
	movl	$0, -120132(%rbp)
	movl	$0, %eax
	movl	%eax, -120004(%rbp)              # assign int
.L16:
                                             # enter while
.L17:
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120136(%rbp)
	movl	-120136(%rbp), %r8d
	movl	$10000, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L19
	jmp	.L18
.L18:
                                             # exit while
	jmp	.L46
.L19:
.L20:
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120140(%rbp)
	movl	-120140(%rbp), %r8d
	movl	$10, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L21
	jmp	.L22
.L21:
	movl	-120132(%rbp), %r8d
	movl	%r8d, -120144(%rbp)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120148(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120148(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-120000(%rbp, %rcx, 4), %eax
	movl	%eax, -120152(%rbp)
	movl	-120144(%rbp), %r8d
	movl	-120152(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120156(%rbp)
	movl	-120156(%rbp), %eax
	movl	$1333, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -120160(%rbp)
	movl	-120160(%rbp), %eax
	movl	%eax, -120132(%rbp)              # assign int
	movl	-120132(%rbp), %r8d
	movl	%r8d, -120164(%rbp)
	leaq	__fmt_string5(%rip), %rdi        # param 0
	movl	-120164(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	jmp	.L45
.L22:
.L23:
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120168(%rbp)
	movl	-120168(%rbp), %r8d
	movl	$20, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L24
	jmp	.L30
.L24:
	movl	$5000, -120172(%rbp)
.L25:
                                             # enter while
.L26:
	movl	-120172(%rbp), %r8d
	movl	%r8d, -120176(%rbp)
	movl	-120176(%rbp), %r8d
	movl	$10000, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L28
	jmp	.L27
.L27:
                                             # exit while
	jmp	.L29
.L28:
	movl	-120132(%rbp), %r8d
	movl	%r8d, -120180(%rbp)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120184(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120184(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-120000(%rbp, %rcx, 4), %eax
	movl	%eax, -120188(%rbp)
	movl	-120180(%rbp), %r8d
	movl	-120188(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120192(%rbp)
	movl	-120172(%rbp), %r8d
	movl	%r8d, -120196(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120196(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-40000(%rbp, %rcx, 4), %eax
	movl	%eax, -120200(%rbp)
	movl	-120192(%rbp), %r8d
	movl	-120200(%rbp), %r9d
	subl	%r9d, %r8d
	movl	%r8d, -120204(%rbp)
	movl	-120204(%rbp), %eax
	movl	%eax, -120132(%rbp)              # assign int
	movl	-120172(%rbp), %r8d
	movl	%r8d, -120208(%rbp)
	movl	-120208(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120212(%rbp)
	movl	-120212(%rbp), %eax
	movl	%eax, -120172(%rbp)              # assign int
	jmp	.L25
.L29:                                        # end while
	movl	-120132(%rbp), %r8d
	movl	%r8d, -120216(%rbp)
	leaq	__fmt_string6(%rip), %rdi        # param 0
	movl	-120216(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	jmp	.L44
.L30:
.L31:
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120220(%rbp)
	movl	-120220(%rbp), %r8d
	movl	$30, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L32
	jmp	.L42
.L32:
	movl	$5000, -120224(%rbp)
.L33:
                                             # enter while
.L34:
	movl	-120224(%rbp), %r8d
	movl	%r8d, -120228(%rbp)
	movl	-120228(%rbp), %r8d
	movl	$10000, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L36
	jmp	.L35
.L35:
                                             # exit while
	jmp	.L41
.L36:
.L37:
	movl	-120224(%rbp), %r8d
	movl	%r8d, -120232(%rbp)
	movl	-120232(%rbp), %r8d
	movl	$2233, %r9d
	cmpl	%r9d, %r8d                       # if >
	jg	.L38
	jmp	.L39
.L38:
	movl	-120132(%rbp), %r8d
	movl	%r8d, -120236(%rbp)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120240(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120240(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-80000(%rbp, %rcx, 4), %eax
	movl	%eax, -120244(%rbp)
	movl	-120236(%rbp), %r8d
	movl	-120244(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120248(%rbp)
	movl	-120224(%rbp), %r8d
	movl	%r8d, -120252(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120252(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-40000(%rbp, %rcx, 4), %eax
	movl	%eax, -120256(%rbp)
	movl	-120248(%rbp), %r8d
	movl	-120256(%rbp), %r9d
	subl	%r9d, %r8d
	movl	%r8d, -120260(%rbp)
	movl	-120260(%rbp), %eax
	movl	%eax, -120132(%rbp)              # assign int
	movl	-120224(%rbp), %r8d
	movl	%r8d, -120264(%rbp)
	movl	-120264(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120268(%rbp)
	movl	-120268(%rbp), %eax
	movl	%eax, -120224(%rbp)              # assign int
	jmp	.L40
.L39:
	movl	-120132(%rbp), %r8d
	movl	%r8d, -120272(%rbp)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120276(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120276(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-40000(%rbp, %rcx, 4), %eax
	movl	%eax, -120280(%rbp)
	movl	-120272(%rbp), %r8d
	movl	-120280(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120284(%rbp)
	movl	-120224(%rbp), %r8d
	movl	%r8d, -120288(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120288(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-120000(%rbp, %rcx, 4), %eax
	movl	%eax, -120292(%rbp)
	movl	-120284(%rbp), %r8d
	movl	-120292(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120296(%rbp)
	movl	-120296(%rbp), %eax
	movl	$13333, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -120300(%rbp)
	movl	-120300(%rbp), %eax
	movl	%eax, -120132(%rbp)              # assign int
	movl	-120224(%rbp), %r8d
	movl	%r8d, -120304(%rbp)
	movl	-120304(%rbp), %r8d
	movl	$2, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120308(%rbp)
	movl	-120308(%rbp), %eax
	movl	%eax, -120224(%rbp)              # assign int
.L40:
	jmp	.L33
.L41:                                        # end while
	movl	-120132(%rbp), %r8d
	movl	%r8d, -120312(%rbp)
	leaq	__fmt_string7(%rip), %rdi        # param 0
	movl	-120312(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	jmp	.L43
.L42:
	movl	-120132(%rbp), %r8d
	movl	%r8d, -120316(%rbp)
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120320(%rbp)
	movl	$0, %ecx
	imull	$10000, %ecx
	movl	-120320(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-120000(%rbp, %rcx, 4), %eax
	movl	%eax, -120324(%rbp)
	movl	16(%rbp), %r8d
	movl	%r8d, -120328(%rbp)
	movl	-120324(%rbp), %r8d
	movl	-120328(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -120332(%rbp)
	movl	-120316(%rbp), %r8d
	movl	-120332(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120336(%rbp)
	movl	-120336(%rbp), %eax
	movl	$99988, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -120340(%rbp)
	movl	-120340(%rbp), %eax
	movl	%eax, -120132(%rbp)              # assign int
.L43:
.L44:
.L45:
	movl	-120004(%rbp), %r8d
	movl	%r8d, -120344(%rbp)
	movl	-120344(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120348(%rbp)
	movl	-120348(%rbp), %eax
	movl	%eax, -120004(%rbp)              # assign int
	jmp	.L16
.L46:                                        # end while
	movl	-120132(%rbp), %r8d
	movl	%r8d, -120352(%rbp)
	movl	-120352(%rbp), %eax
	leave
	ret

	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp                        # fixed frame size
	movq	$9, 0(%rsp)                      # param 0
	call	long_array
	movl	%eax, -4(%rbp)
	leaq	__fmt_string8(%rip), %rdi        # param 0
	movl	-4(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	movl	$0, %eax
	leave
	ret
