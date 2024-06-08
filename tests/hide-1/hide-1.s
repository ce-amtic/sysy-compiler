.section .rodata

.align	4
.type	inf, @object
.size	inf, 4
inf:
	.long	1000000000

.align	4
.type	INF, @object
.size	INF, 4
INF:
	.long	1061109567

.align	4
.type	mod, @object
.size	mod, 4
mod:
	.long	998244353

.align	4
.type	maxn, @object
.size	maxn, 4
maxn:
	.long	20005
__fmt_string20:	.string "%d %d"
__fmt_string21:	.string "%d"
__fmt_string22:	.string "%d"
__fmt_string23:	.string "%d\n"

.section .data
	.globl	n
	.data
	.align	4
	.type	n, @object
	.size	n, 4
n:
	.long	0
	.globl	k
	.data
	.align	4
	.type	k, @object
	.size	k, 4
k:
	.long	0
	.globl	a
	.data
	.align	4
	.type	a, @object
	.size	a, 80020
a:
	.zero	80020
	.globl	p
	.data
	.align	4
	.type	p, @object
	.size	p, 80020
p:
	.zero	80020
	.globl	dp
	.data
	.align	4
	.type	dp, @object
	.size	dp, 3520880
dp:
	.zero	3520880
	.globl	g
	.data
	.align	4
	.type	g, @object
	.size	g, 3520880
g:
	.zero	3520880

.section .bss

.section .text

	.globl	pw
	.type	pw, @function
pw:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$112, %rsp                       # fixed frame size
.L1:
	movl	24(%rbp), %r8d
	movl	%r8d, -4(%rbp)
	movl	-4(%rbp), %eax
	testl %eax, %eax
	sete %al
	movzbl %al, %eax
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L2
	jmp	.L3
.L2:
	movl	$1, %eax
	leave
	ret
.L3:                                         # endif
.L4:
	movl	24(%rbp), %r8d
	movl	%r8d, -12(%rbp)
	movl	-12(%rbp), %r8d
	movl	$1, %r9d
	cmpl	%r9d, %r8d                       # if ==
	je	.L5
	jmp	.L6
.L5:
	movl	16(%rbp), %r8d
	movl	%r8d, -16(%rbp)
	movl	-16(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -20(%rbp)
	movl	-20(%rbp), %eax
	leave
	ret
.L6:                                         # endif
	movl	16(%rbp), %r8d
	movl	%r8d, -24(%rbp)
	movl	24(%rbp), %r8d
	movl	%r8d, -28(%rbp)
	movl	-28(%rbp), %eax
	movl	$2, %r9d
	cltd
	idivl	%r9d
	movl	%eax, -32(%rbp)
	movl	-32(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 8(%rsp)                     # param 1
	movl	-24(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	pw
	movl	%eax, -36(%rbp)
.L7:
	movl	24(%rbp), %r8d
	movl	%r8d, -40(%rbp)
	movl	-40(%rbp), %eax
	movl	$2, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -44(%rbp)
	movl	-44(%rbp), %r8d
	movl	$1, %r9d
	cmpl	%r9d, %r8d                       # if ==
	je	.L8
	jmp	.L9
.L8:
	movl	-36(%rbp), %r8d
	movl	%r8d, -48(%rbp)
	movl	-36(%rbp), %r8d
	movl	%r8d, -52(%rbp)
	movl	-48(%rbp), %r8d
	movl	-52(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -56(%rbp)
	movl	-56(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -60(%rbp)
	movl	16(%rbp), %r8d
	movl	%r8d, -64(%rbp)
	movl	-60(%rbp), %r8d
	movl	-64(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -68(%rbp)
	movl	-68(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -72(%rbp)
	movl	-72(%rbp), %eax
	leave
	ret
.L9:                                         # endif
	movl	-36(%rbp), %r8d
	movl	%r8d, -76(%rbp)
	movl	-36(%rbp), %r8d
	movl	%r8d, -80(%rbp)
	movl	-76(%rbp), %r8d
	movl	-80(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -84(%rbp)
	movl	-84(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -88(%rbp)
	movl	-88(%rbp), %eax
	leave
	ret

	.globl	min
	.type	min, @function
min:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp                        # fixed frame size
.L10:
	movl	16(%rbp), %r8d
	movl	%r8d, -4(%rbp)
	movl	24(%rbp), %r8d
	movl	%r8d, -8(%rbp)
	movl	-4(%rbp), %r8d
	movl	-8(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L11
	jmp	.L12
.L11:
	movl	16(%rbp), %r8d
	movl	%r8d, -12(%rbp)
	movl	-12(%rbp), %eax
	leave
	ret
	jmp	.L13
.L12:
	movl	24(%rbp), %r8d
	movl	%r8d, -16(%rbp)
	movl	-16(%rbp), %eax
	leave
	ret
.L13:

	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$832, %rsp                       # fixed frame size
	leaq	n(%rip), %r8
	movq	%r8, -8(%rbp)
	leaq	k(%rip), %r8
	movq	%r8, -16(%rbp)
	leaq	__fmt_string20(%rip), %rdi       # param 0
	movq	-8(%rbp), %rsi                   # param 1
	movq	-16(%rbp), %rdx                  # param 2
	call	scanf
	movl	$1, -20(%rbp)
.L14:
                                             # enter while
.L15:
	movl	$1, %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L17
	jmp	.L16
.L16:
                                             # exit while
	jmp	.L21
.L17:
.L18:
	movl	-20(%rbp), %r8d
	movl	%r8d, -24(%rbp)
	leaq	n(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -28(%rbp)
	movl	-24(%rbp), %r8d
	movl	-28(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if >
	jg	.L19
	jmp	.L20
.L19:

	jmp	.L21
.L20:                                        # endif
	movl	-20(%rbp), %r8d
	movl	%r8d, -32(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-32(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	a(%rip), %r9
	leaq	(%r9, %rcx, 4), %r8
	movq	%r8, -40(%rbp)
	leaq	__fmt_string21(%rip), %rdi       # param 0
	movq	-40(%rbp), %rsi                  # param 1
	call	scanf
	movl	-20(%rbp), %r8d
	movl	%r8d, -44(%rbp)
	movl	-44(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -48(%rbp)
	movl	-48(%rbp), %eax
	movl	%eax, -20(%rbp)                  # assign int
	jmp	.L14
.L21:                                        # end while
	movl	$1, %eax
	movl	%eax, -20(%rbp)                  # assign int
.L22:
                                             # enter while
.L23:
	movl	$1, %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L25
	jmp	.L24
.L24:
                                             # exit while
	jmp	.L29
.L25:
.L26:
	movl	-20(%rbp), %r8d
	movl	%r8d, -52(%rbp)
	leaq	n(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -56(%rbp)
	movl	-52(%rbp), %r8d
	movl	-56(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if >
	jg	.L27
	jmp	.L28
.L27:

	jmp	.L29
.L28:                                        # endif
	movl	-20(%rbp), %r8d
	movl	%r8d, -60(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-60(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	p(%rip), %r9
	leaq	(%r9, %rcx, 4), %r8
	movq	%r8, -68(%rbp)
	leaq	__fmt_string22(%rip), %rdi       # param 0
	movq	-68(%rbp), %rsi                  # param 1
	call	scanf
	movl	-20(%rbp), %r8d
	movl	%r8d, -72(%rbp)
	movl	-72(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -76(%rbp)
	movl	-76(%rbp), %eax
	movl	%eax, -20(%rbp)                  # assign int
	jmp	.L22
.L29:                                        # end while
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movl	$1, %eax
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	$1, %eax
	movl	%eax, -20(%rbp)                  # assign int
.L30:
                                             # enter while
.L31:
	movl	$1, %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L33
	jmp	.L32
.L32:
                                             # exit while
	jmp	.L45
.L33:
.L34:
	movl	-20(%rbp), %r8d
	movl	%r8d, -80(%rbp)
	leaq	n(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -84(%rbp)
	movl	-80(%rbp), %r8d
	movl	-84(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if >
	jg	.L35
	jmp	.L36
.L35:

	jmp	.L45
.L36:                                        # endif
	movl	-20(%rbp), %r8d
	movl	%r8d, -88(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-88(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	$0, %eax
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-20(%rbp), %r8d
	movl	%r8d, -92(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -96(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-96(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	p(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -100(%rbp)
	movl	$1, %r8d
	movl	-100(%rbp), %r9d
	subl	%r9d, %r8d
	movl	%r8d, -104(%rbp)
	movl	-104(%rbp), %r8d
	movl	$998244353, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -108(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -112(%rbp)
	movl	-112(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -116(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-116(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -120(%rbp)
	movl	-108(%rbp), %r8d
	movl	-120(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -124(%rbp)
	movl	-124(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -128(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-92(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp), %eax
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	$1, -132(%rbp)
.L37:
                                             # enter while
.L38:
	movl	$1, %r8d
	cmpl	$0, %r8d                         # if != 0
	jne	.L40
	jmp	.L39
.L39:
                                             # exit while
	jmp	.L44
.L40:
.L41:
	movl	-132(%rbp), %r8d
	movl	%r8d, -136(%rbp)
	leaq	k(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -140(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -144(%rbp)
	movl	-144(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -148(%rbp)
	movl	-148(%rbp), %eax
	movl	$2, %r9d
	cltd
	idivl	%r9d
	movl	%eax, -152(%rbp)
	movl	-152(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 8(%rsp)                     # param 1
	movl	-140(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	min
	movl	%eax, -156(%rbp)
	movl	-136(%rbp), %r8d
	movl	-156(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if >
	jg	.L42
	jmp	.L43
.L42:

	jmp	.L44
.L43:                                        # endif
	movl	-20(%rbp), %r8d
	movl	%r8d, -160(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -164(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -168(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -172(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-168(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-172(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -176(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -180(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-180(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	p(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -184(%rbp)
	movl	$1, %r8d
	movl	-184(%rbp), %r9d
	subl	%r9d, %r8d
	movl	%r8d, -188(%rbp)
	movl	-188(%rbp), %r8d
	movl	$998244353, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -192(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -196(%rbp)
	movl	-196(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -200(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -204(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-200(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-204(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -208(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -212(%rbp)
	movl	-212(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -216(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -220(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-216(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-220(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -224(%rbp)
	movl	-208(%rbp), %r8d
	movl	-224(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -228(%rbp)
	movl	-192(%rbp), %r8d
	movl	-228(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -232(%rbp)
	movl	-232(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -236(%rbp)
	movl	-176(%rbp), %r8d
	movl	-236(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -240(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-160(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-164(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-240(%rbp), %eax
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-20(%rbp), %r8d
	movl	%r8d, -244(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -248(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -252(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -256(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-252(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-256(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -260(%rbp)
	movl	-260(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -264(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-244(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-248(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-264(%rbp), %eax
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-20(%rbp), %r8d
	movl	%r8d, -268(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -272(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -276(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -280(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-276(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-280(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -284(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -288(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-288(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	p(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -292(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -296(%rbp)
	movl	-296(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -300(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -304(%rbp)
	movl	-304(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -308(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-300(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-308(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -312(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -316(%rbp)
	movl	-316(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -320(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -324(%rbp)
	movl	-324(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -328(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-320(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-328(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -332(%rbp)
	movl	$1, %r8d
	movl	-332(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -336(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -340(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-340(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	a(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -344(%rbp)
	movl	-336(%rbp), %r8d
	movl	-344(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -348(%rbp)
	movl	-348(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -352(%rbp)
	movl	-312(%rbp), %r8d
	movl	-352(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -356(%rbp)
	movl	-292(%rbp), %r8d
	movl	-356(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -360(%rbp)
	movl	-360(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -364(%rbp)
	movl	-284(%rbp), %r8d
	movl	-364(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -368(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-268(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-272(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-368(%rbp), %eax
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-20(%rbp), %r8d
	movl	%r8d, -372(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -376(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -380(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -384(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-380(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-384(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -388(%rbp)
	movl	-388(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -392(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-372(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-376(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-392(%rbp), %eax
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-20(%rbp), %r8d
	movl	%r8d, -396(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -400(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -404(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -408(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-404(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-408(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -412(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -416(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-416(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	p(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -420(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -424(%rbp)
	movl	-424(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -428(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -432(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-428(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-432(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -436(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -440(%rbp)
	movl	-440(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -444(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -448(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-444(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-448(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -452(%rbp)
	movl	$1, %r8d
	movl	-452(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -456(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -460(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-460(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	a(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -464(%rbp)
	movl	-456(%rbp), %r8d
	movl	-464(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -468(%rbp)
	movl	-468(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -472(%rbp)
	movl	-436(%rbp), %r8d
	movl	-472(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -476(%rbp)
	movl	-420(%rbp), %r8d
	movl	-476(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -480(%rbp)
	movl	-480(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -484(%rbp)
	movl	-412(%rbp), %r8d
	movl	-484(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -488(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-396(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-400(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-488(%rbp), %eax
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-20(%rbp), %r8d
	movl	%r8d, -492(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -496(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -500(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -504(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-500(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-504(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -508(%rbp)
	movl	-508(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -512(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-492(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-496(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-512(%rbp), %eax
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-20(%rbp), %r8d
	movl	%r8d, -516(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -520(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -524(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -528(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-524(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-528(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -532(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -536(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-536(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	p(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -540(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -544(%rbp)
	movl	-544(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -548(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -552(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-548(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-552(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -556(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -560(%rbp)
	movl	-560(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -564(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -568(%rbp)
	movl	-568(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -572(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-564(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-572(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -576(%rbp)
	movl	-556(%rbp), %r8d
	movl	-576(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -580(%rbp)
	movl	-540(%rbp), %r8d
	movl	-580(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -584(%rbp)
	movl	-584(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -588(%rbp)
	movl	-532(%rbp), %r8d
	movl	-588(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -592(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-516(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-520(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-592(%rbp), %eax
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-20(%rbp), %r8d
	movl	%r8d, -596(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -600(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -604(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -608(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-604(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-608(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -612(%rbp)
	movl	-612(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -616(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-596(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-600(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-616(%rbp), %eax
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-20(%rbp), %r8d
	movl	%r8d, -620(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -624(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -628(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -632(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-628(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-632(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -636(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -640(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-640(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	p(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -644(%rbp)
	movl	$1, %r8d
	movl	-644(%rbp), %r9d
	subl	%r9d, %r8d
	movl	%r8d, -648(%rbp)
	movl	-648(%rbp), %r8d
	movl	$998244353, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -652(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -656(%rbp)
	movl	-656(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -660(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -664(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-660(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-664(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -668(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -672(%rbp)
	movl	-672(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -676(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -680(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-676(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-680(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -684(%rbp)
	movl	-668(%rbp), %r8d
	movl	-684(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -688(%rbp)
	movl	-652(%rbp), %r8d
	movl	-688(%rbp), %r9d
	imull	%r9d, %r8d
	movl	%r8d, -692(%rbp)
	movl	-692(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -696(%rbp)
	movl	-636(%rbp), %r8d
	movl	-696(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -700(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-620(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-624(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-700(%rbp), %eax
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-20(%rbp), %r8d
	movl	%r8d, -704(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -708(%rbp)
	movl	-20(%rbp), %r8d
	movl	%r8d, -712(%rbp)
	movl	-132(%rbp), %r8d
	movl	%r8d, -716(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-712(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-716(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -720(%rbp)
	movl	-720(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -724(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-704(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-708(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-724(%rbp), %eax
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx             # assign int_array
	movl	%eax, (%rbx)
	movl	-132(%rbp), %r8d
	movl	%r8d, -728(%rbp)
	movl	-728(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -732(%rbp)
	movl	-732(%rbp), %eax
	movl	%eax, -132(%rbp)                 # assign int
	jmp	.L37
.L44:                                        # end while
	movl	-20(%rbp), %r8d
	movl	%r8d, -736(%rbp)
	movl	-736(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -740(%rbp)
	movl	-740(%rbp), %eax
	movl	%eax, -20(%rbp)                  # assign int
	jmp	.L30
.L45:                                        # end while
	leaq	n(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -744(%rbp)
	leaq	k(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -748(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-744(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-748(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -752(%rbp)
	leaq	n(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -756(%rbp)
	leaq	k(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -760(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-756(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-760(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	g(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -764(%rbp)
	movl	-752(%rbp), %r8d
	movl	-764(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -768(%rbp)
	movl	-768(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -772(%rbp)
	movq	$998244351, 8(%rsp)              # param 1
	movl	-772(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	pw
	movl	%eax, -776(%rbp)
	leaq	n(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -780(%rbp)
	leaq	k(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -784(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-780(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-784(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -788(%rbp)
	leaq	n(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -792(%rbp)
	leaq	k(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -796(%rbp)
	movl	$0, %ecx
	imull	$20005, %ecx
	movl	-792(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$22, %ecx
	movl	-796(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	leaq	dp(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -800(%rbp)
	movl	-788(%rbp), %r8d
	movl	-800(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -804(%rbp)
	movl	-804(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	movl	%edx, -808(%rbp)
	leaq	__fmt_string23(%rip), %rdi       # param 0
	movl	-808(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	movl	$0, %eax
	leave
	ret
