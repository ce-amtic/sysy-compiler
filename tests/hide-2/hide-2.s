.section .rodata

.align	4
.type	N, @object
.size	N, 4
N:
	.long	1024
__fmt_string5:	.string "%d"
__fmt_string6:	.string "%d\n"

.section .data
	.globl	A
	.data
	.align	4
	.type	A, @object
	.size	A, 4194304
A:
	.zero	4194304
	.globl	B
	.data
	.align	4
	.type	B, @object
	.size	B, 4194304
B:
	.zero	4194304
	.globl	C
	.data
	.align	4
	.type	C, @object
	.size	C, 4194304
C:
	.zero	4194304

.section .bss

.section .text
	.globl	mm
	.type	mm, @function
mm:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$176, %rsp                       # fixed frame size
	movl	$0, -4(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, %eax
	movl	%eax, -4(%rbp)                   # assign int
	movl	$0, %eax
	movl	%eax, -8(%rbp)                   # assign int
.L1:
                                             # enter while
.L2:
	movl	-4(%rbp), %r8d
	movl	%r8d, -16(%rbp)
	movl	16(%rbp), %r8d
	movl	%r8d, -20(%rbp)
	movl	-16(%rbp), %r8d
	movl	-20(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L4
	jmp	.L3
.L3:
                                             # exit while
	jmp	.L10
.L4:
	movl	$0, %eax
	movl	%eax, -8(%rbp)                   # assign int
.L5:
                                             # enter while
.L6:
	movl	-8(%rbp), %r8d
	movl	%r8d, -24(%rbp)
	movl	16(%rbp), %r8d
	movl	%r8d, -28(%rbp)
	movl	-24(%rbp), %r8d
	movl	-28(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L8
	jmp	.L7
.L7:
                                             # exit while
	jmp	.L9
.L8:
	movl	-4(%rbp), %r8d
	movl	%r8d, -32(%rbp)
	movl	-8(%rbp), %r8d
	movl	%r8d, -36(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-32(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$1024, %ecx
	movl	-36(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx             # assign pointer
	movl	$0, %eax
	movl	%eax, (%rbx)
	movl	-8(%rbp), %r8d
	movl	%r8d, -40(%rbp)
	movl	-40(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -44(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, -8(%rbp)                   # assign int
	jmp	.L5
.L9:                                         # end while
	movl	-4(%rbp), %r8d
	movl	%r8d, -48(%rbp)
	movl	-48(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -52(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -4(%rbp)                   # assign int
	jmp	.L1
.L10:                                        # end while
	movl	$0, %eax
	movl	%eax, -4(%rbp)                   # assign int
	movl	$0, %eax
	movl	%eax, -8(%rbp)                   # assign int
	movl	$0, %eax
	movl	%eax, -12(%rbp)                  # assign int
.L11:
                                             # enter while
.L12:
	movl	-12(%rbp), %r8d
	movl	%r8d, -56(%rbp)
	movl	16(%rbp), %r8d
	movl	%r8d, -60(%rbp)
	movl	-56(%rbp), %r8d
	movl	-60(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L14
	jmp	.L13
.L13:
                                             # exit while
	jmp	.L28
.L14:
	movl	$0, %eax
	movl	%eax, -4(%rbp)                   # assign int
.L15:
                                             # enter while
.L16:
	movl	-4(%rbp), %r8d
	movl	%r8d, -64(%rbp)
	movl	16(%rbp), %r8d
	movl	%r8d, -68(%rbp)
	movl	-64(%rbp), %r8d
	movl	-68(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L18
	jmp	.L17
.L17:
                                             # exit while
	jmp	.L27
.L18:
.L19:
	movl	-4(%rbp), %r8d
	movl	%r8d, -72(%rbp)
	movl	-12(%rbp), %r8d
	movl	%r8d, -76(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-72(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$1024, %ecx
	movl	-76(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	24(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -80(%rbp)
	movl	-80(%rbp), %r8d
	movl	$0, %r9d
	cmpl	%r9d, %r8d                       # if ==
	je	.L20
	jmp	.L21
.L20:
	movl	-4(%rbp), %r8d
	movl	%r8d, -84(%rbp)
	movl	-84(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -88(%rbp)
	movl	-88(%rbp), %eax
	movl	%eax, -4(%rbp)                   # assign int

	jmp	.L15
.L21:                                        # endif
	movl	$0, %eax
	movl	%eax, -8(%rbp)                   # assign int
.L22:
                                             # enter while
.L23:
	movl	-8(%rbp), %r8d
	movl	%r8d, -92(%rbp)
	movl	16(%rbp), %r8d
	movl	%r8d, -96(%rbp)
	movl	-92(%rbp), %r8d
	movl	-96(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L25
	jmp	.L24
.L24:
                                             # exit while
	jmp	.L26
.L25:
	movl	-4(%rbp), %r8d
	movl	%r8d, -100(%rbp)
	movl	-8(%rbp), %r8d
	movl	%r8d, -104(%rbp)
	movl	-4(%rbp), %r8d
	movl	%r8d, -108(%rbp)
	movl	-8(%rbp), %r8d
	movl	%r8d, -112(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-108(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$1024, %ecx
	movl	-112(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -116(%rbp)
	movl	-4(%rbp), %r8d
	movl	%r8d, -120(%rbp)
	movl	-12(%rbp), %r8d
	movl	%r8d, -124(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-120(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$1024, %ecx
	movl	-124(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	24(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -128(%rbp)
	movl	-12(%rbp), %r8d
	movl	%r8d, -132(%rbp)
	movl	-8(%rbp), %r8d
	movl	%r8d, -136(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-132(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$1024, %ecx
	movl	-136(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	32(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -140(%rbp)
	movl	-128(%rbp), %r8d
	movl	-140(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -144(%rbp)
	movl	-116(%rbp), %r8d
	movl	-144(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -148(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-100(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$1024, %ecx
	movl	-104(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx             # assign pointer
	movl	-148(%rbp), %eax
	movl	%eax, (%rbx)
	movl	-8(%rbp), %r8d
	movl	%r8d, -152(%rbp)
	movl	-152(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -156(%rbp)
	movl	-156(%rbp), %eax
	movl	%eax, -8(%rbp)                   # assign int
	jmp	.L22
.L26:                                        # end while
	movl	-4(%rbp), %r8d
	movl	%r8d, -160(%rbp)
	movl	-160(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -164(%rbp)
	movl	-164(%rbp), %eax
	movl	%eax, -4(%rbp)                   # assign int
	jmp	.L15
.L27:                                        # end while
	movl	-12(%rbp), %r8d
	movl	%r8d, -168(%rbp)
	movl	-168(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -172(%rbp)
	movl	-172(%rbp), %eax
	movl	%eax, -12(%rbp)                  # assign int
	jmp	.L11
.L28:                                        # end while
	leave
	ret

	.globl	getint
	.type	getint, @function
getint:
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
	subq	$272, %rsp                       # fixed frame size
	call	getint
	movl	%eax, -4(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, %eax
	movl	%eax, -8(%rbp)                   # assign int
	movl	$0, %eax
	movl	%eax, -12(%rbp)                  # assign int
.L29:
                                             # enter while
.L30:
	movl	-8(%rbp), %r8d
	movl	%r8d, -16(%rbp)
	movl	-4(%rbp), %r8d
	movl	%r8d, -20(%rbp)
	movl	-16(%rbp), %r8d
	movl	-20(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L32
	jmp	.L31
.L31:
                                             # exit while
	jmp	.L38
.L32:
	movl	$0, %eax
	movl	%eax, -12(%rbp)                  # assign int
.L33:
                                             # enter while
.L34:
	movl	-12(%rbp), %r8d
	movl	%r8d, -24(%rbp)
	movl	-4(%rbp), %r8d
	movl	%r8d, -28(%rbp)
	movl	-24(%rbp), %r8d
	movl	-28(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L36
	jmp	.L35
.L35:
                                             # exit while
	jmp	.L37
.L36:
	movl	-8(%rbp), %r8d
	movl	%r8d, -32(%rbp)
	movl	-12(%rbp), %r8d
	movl	%r8d, -36(%rbp)
	call	getint
	movl	%eax, -40(%rbp)
	movl	$0, %ecx
	imull	$1024, %ecx
	movl	-32(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$1024, %ecx
	movl	-36(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-40(%rbp), %eax
	leaq	A(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-12(%rbp), %r8d
	movl	%r8d, -44(%rbp)
	movl	-44(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -48(%rbp)
	movl	-48(%rbp), %eax
	movl	%eax, -12(%rbp)                  # assign int
	jmp	.L33
.L37:                                        # end while
	movl	-8(%rbp), %r8d
	movl	%r8d, -52(%rbp)
	movl	-52(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -56(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -8(%rbp)                   # assign int
	jmp	.L29
.L38:                                        # end while
	movl	$0, %eax
	movl	%eax, -8(%rbp)                   # assign int
	movl	$0, %eax
	movl	%eax, -12(%rbp)                  # assign int
.L39:
                                             # enter while
.L40:
	movl	-8(%rbp), %r8d
	movl	%r8d, -60(%rbp)
	movl	-4(%rbp), %r8d
	movl	%r8d, -64(%rbp)
	movl	-60(%rbp), %r8d
	movl	-64(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L42
	jmp	.L41
.L41:
                                             # exit while
	jmp	.L48
.L42:
	movl	$0, %eax
	movl	%eax, -12(%rbp)                  # assign int
.L43:
                                             # enter while
.L44:
	movl	-12(%rbp), %r8d
	movl	%r8d, -68(%rbp)
	movl	-4(%rbp), %r8d
	movl	%r8d, -72(%rbp)
	movl	-68(%rbp), %r8d
	movl	-72(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L46
	jmp	.L45
.L45:
                                             # exit while
	jmp	.L47
.L46:
	movl	-8(%rbp), %r8d
	movl	%r8d, -76(%rbp)
	movl	-12(%rbp), %r8d
	movl	%r8d, -80(%rbp)
	call	getint
	movl	%eax, -84(%rbp)
	movl	$0, %ecx
	imull	$1024, %ecx
	movl	-76(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$1024, %ecx
	movl	-80(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-84(%rbp), %eax
	leaq	B(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-12(%rbp), %r8d
	movl	%r8d, -88(%rbp)
	movl	-88(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -92(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, -12(%rbp)                  # assign int
	jmp	.L43
.L47:                                        # end while
	movl	-8(%rbp), %r8d
	movl	%r8d, -96(%rbp)
	movl	-96(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -100(%rbp)
	movl	-100(%rbp), %eax
	movl	%eax, -8(%rbp)                   # assign int
	jmp	.L39
.L48:                                        # end while
	movl	$0, %eax
	movl	%eax, -8(%rbp)                   # assign int
.L49:
                                             # enter while
.L50:
	movl	-8(%rbp), %r8d
	movl	%r8d, -104(%rbp)
	movl	-104(%rbp), %r8d
	movl	$5, %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L52
	jmp	.L51
.L51:
                                             # exit while
	jmp	.L53
.L52:
	movl	-4(%rbp), %r8d
	movl	%r8d, -108(%rbp)
	leaq	A(%rip), %r8
	movq	%r8, -116(%rbp)
	leaq	B(%rip), %r8
	movq	%r8, -124(%rbp)
	leaq	C(%rip), %r8
	movq	%r8, -132(%rbp)
	movq	-132(%rbp), %r8
	movq	%r8, 24(%rsp)                    # param 3
	movq	-124(%rbp), %r8
	movq	%r8, 16(%rsp)                    # param 2
	movq	-116(%rbp), %r8
	movq	%r8, 8(%rsp)                     # param 1
	movl	-108(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	mm
	movl	-4(%rbp), %r8d
	movl	%r8d, -136(%rbp)
	leaq	A(%rip), %r8
	movq	%r8, -144(%rbp)
	leaq	C(%rip), %r8
	movq	%r8, -152(%rbp)
	leaq	B(%rip), %r8
	movq	%r8, -160(%rbp)
	movq	-160(%rbp), %r8
	movq	%r8, 24(%rsp)                    # param 3
	movq	-152(%rbp), %r8
	movq	%r8, 16(%rsp)                    # param 2
	movq	-144(%rbp), %r8
	movq	%r8, 8(%rsp)                     # param 1
	movl	-136(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	mm
	movl	-8(%rbp), %r8d
	movl	%r8d, -164(%rbp)
	movl	-164(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -168(%rbp)
	movl	-168(%rbp), %eax
	movl	%eax, -8(%rbp)                   # assign int
	jmp	.L49
.L53:                                        # end while
	movl	$0, -172(%rbp)
	movl	$0, %eax
	movl	%eax, -8(%rbp)                   # assign int
.L54:
                                             # enter while
.L55:
	movl	-8(%rbp), %r8d
	movl	%r8d, -176(%rbp)
	movl	-4(%rbp), %r8d
	movl	%r8d, -180(%rbp)
	movl	-176(%rbp), %r8d
	movl	-180(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L57
	jmp	.L56
.L56:
                                             # exit while
	jmp	.L63
.L57:
	movl	$0, %eax
	movl	%eax, -12(%rbp)                  # assign int
.L58:
                                             # enter while
.L59:
	movl	-12(%rbp), %r8d
	movl	%r8d, -184(%rbp)
	movl	-4(%rbp), %r8d
	movl	%r8d, -188(%rbp)
	movl	-184(%rbp), %r8d
	movl	-188(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L61
	jmp	.L60
.L60:
                                             # exit while
	jmp	.L62
.L61:
	movl	-172(%rbp), %r8d
	movl	%r8d, -192(%rbp)
	movl	-8(%rbp), %r8d
	movl	%r8d, -196(%rbp)
	movl	-12(%rbp), %r8d
	movl	%r8d, -200(%rbp)
	movl	$0, %ecx
	imull	$1024, %ecx
	movl	-196(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$1024, %ecx
	movl	-200(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	B(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -204(%rbp)
	movl	-192(%rbp), %r8d
	movl	-204(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -208(%rbp)
	movl	-208(%rbp), %eax
	movl	%eax, -172(%rbp)                 # assign int
	movl	-12(%rbp), %r8d
	movl	%r8d, -212(%rbp)
	movl	-212(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -216(%rbp)
	movl	-216(%rbp), %eax
	movl	%eax, -12(%rbp)                  # assign int
	jmp	.L58
.L62:                                        # end while
	movl	-8(%rbp), %r8d
	movl	%r8d, -220(%rbp)
	movl	-220(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -224(%rbp)
	movl	-224(%rbp), %eax
	movl	%eax, -8(%rbp)                   # assign int
	jmp	.L54
.L63:                                        # end while
	movl	-172(%rbp), %r8d
	movl	%r8d, -228(%rbp)
	leaq	__fmt_string6(%rip), %rdi        # param 0
	movl	-228(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	movl	$0, %eax
	leave
	ret
