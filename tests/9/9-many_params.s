.section .rodata
__fmt_string0:	.string "%d"
__fmt_string1:	.string "%d\n"

.section .data

.section .bss

.section .text
	.globl	sort
	.type	sort, @function
sort:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$4, %rsp
	movl	$0, -4(%rbp)
.L1:
                                             # enter while
                                             # enter block
.L2:
	movl	-4(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -8(%rbp)
	movl	24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -12(%rbp)
	movl	-12(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -16(%rbp)
	movl	-8(%rbp), %r8d
	movl	-16(%rbp), %r9d
	cmpl	%r9d, %r8d		               # if <
	jl	.L4
	jmp	.L3
.L3:
                                             # exit while
	addq	$12, %rsp
	jmp	.L13
.L4:
	movl	-4(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -20(%rbp)
	movl	-20(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -24(%rbp)
.L5:
                                             # enter while
                                             # enter block
.L6:
	movl	-24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -28(%rbp)
	movl	24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -32(%rbp)
	movl	-28(%rbp), %r8d
	movl	-32(%rbp), %r9d
	cmpl	%r9d, %r8d		               # if <
	jl	.L8
	jmp	.L7
.L7:
                                             # exit while
	addq	$8, %rsp
	jmp	.L12
.L8:
.L9:
	movl	-4(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -36(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-36(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -40(%rbp)
	movl	-24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -44(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-44(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -48(%rbp)
	movl	-40(%rbp), %r8d
	movl	-48(%rbp), %r9d
	cmpl	%r9d, %r8d		               # if <
	jl	.L10
	jmp	.L11
.L10:
                                             # enter block
	movl	-4(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -52(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-52(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -56(%rbp)
	movl	-4(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -60(%rbp)
	movl	-24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -64(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-64(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -68(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-60(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx		     # assign pointer
	movl	-68(%rbp), %eax
	movl	%eax, (%rbx)
	movl	-24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -72(%rbp)
	movl	-56(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -76(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-72(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx		     # assign pointer
	movl	-76(%rbp), %eax
	movl	%eax, (%rbx)
	addq	$28, %rsp		                # exiting block, restore %rsp
.L11:		                                # endif
	movl	-24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -52(%rbp)
	movl	-52(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -56(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -24(%rbp)		          # assign int
	addq	$32, %rsp		                # exiting block, restore %rsp
	jmp	.L5
.L12:		                                # end while
	movl	-4(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -28(%rbp)
	movl	-28(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -32(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -4(%rbp)		           # assign int
	addq	$28, %rsp		                # exiting block, restore %rsp
	jmp	.L1
.L13:		                                # end while
	leave
	ret

	.globl	param32_rec
	.type	param32_rec, @function
param32_rec:
	pushq	%rbp
	movq	%rsp, %rbp
.L14:
	movl	16(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -4(%rbp)
	subq	$12, %rsp                        # align stack
	movl	-4(%rbp), %r8d
	movl	$0, %r9d
	cmpl	%r9d, %r8d		               # if ==
	je	.L15
	jmp	.L16
.L15:
                                             # enter block
	movl	24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -20(%rbp)
	movl	-20(%rbp), %eax
	leave
	ret

	addq	$4, %rsp		                 # exiting block, restore %rsp
	jmp	.L17
.L16:
                                             # enter block
	movl	16(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -20(%rbp)
	movl	-20(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -24(%rbp)
	movl	24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -28(%rbp)
	movl	32(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -32(%rbp)
	movl	-28(%rbp), %r8d
	movl	-32(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -36(%rbp)
	movl	-36(%rbp), %eax
	movl	$998244353, %r9d
	cltd
	idivl	%r9d
	subq	$4, %rsp
	movl	%edx, -40(%rbp)
	movl	40(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -44(%rbp)
	movl	48(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -48(%rbp)
	movl	56(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -52(%rbp)
	movl	64(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -56(%rbp)
	movl	72(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -60(%rbp)
	movl	80(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -64(%rbp)
	movl	88(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -68(%rbp)
	movl	96(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -72(%rbp)
	movl	104(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -76(%rbp)
	movl	112(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -80(%rbp)
	movl	120(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -84(%rbp)
	movl	128(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -88(%rbp)
	movl	136(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -92(%rbp)
	movl	144(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -96(%rbp)
	movl	152(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -100(%rbp)
	movl	160(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -104(%rbp)
	movl	168(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -108(%rbp)
	movl	176(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -112(%rbp)
	movl	184(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -116(%rbp)
	movl	192(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -120(%rbp)
	movl	200(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -124(%rbp)
	movl	208(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -128(%rbp)
	movl	216(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -132(%rbp)
	movl	224(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -136(%rbp)
	movl	232(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -140(%rbp)
	movl	240(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -144(%rbp)
	movl	248(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -148(%rbp)
	movl	256(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -152(%rbp)
	movl	264(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -156(%rbp)
	subq	$4, %rsp                         # align stack
	subq	$8, %rsp		                 # param 31
	movq	$0, (%rsp)
	subq	$8, %rsp		                 # param 30
	movl	-156(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 29
	movl	-152(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 28
	movl	-148(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 27
	movl	-144(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 26
	movl	-140(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 25
	movl	-136(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 24
	movl	-132(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 23
	movl	-128(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 22
	movl	-124(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 21
	movl	-120(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 20
	movl	-116(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 19
	movl	-112(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 18
	movl	-108(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 17
	movl	-104(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 16
	movl	-100(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 15
	movl	-96(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 14
	movl	-92(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 13
	movl	-88(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 12
	movl	-84(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 11
	movl	-80(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 10
	movl	-76(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 9
	movl	-72(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 8
	movl	-68(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 7
	movl	-64(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 6
	movl	-60(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 5
	movl	-56(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 4
	movl	-52(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 3
	movl	-48(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 2
	movl	-44(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 1
	movl	-40(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 0
	movl	-24(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	call	param32_rec

	addq	$256, %rsp
	subq	$4, %rsp
	movl	%eax, -164(%rbp)
	movl	-164(%rbp), %eax
	leave
	ret

	addq	$148, %rsp		               # exiting block, restore %rsp
.L17:
	.globl	param32_arr
	.type	param32_arr, @function
param32_arr:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -4(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -8(%rbp)
	movl	-4(%rbp), %r8d
	movl	-8(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -12(%rbp)
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -16(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	24(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -20(%rbp)
	movl	-16(%rbp), %r8d
	movl	-20(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -24(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	24(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -28(%rbp)
	movl	-24(%rbp), %r8d
	movl	-28(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -32(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -36(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	32(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -40(%rbp)
	movl	-36(%rbp), %r8d
	movl	-40(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -44(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	32(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -48(%rbp)
	movl	-44(%rbp), %r8d
	movl	-48(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -52(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -56(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -60(%rbp)
	movl	-56(%rbp), %r8d
	movl	-60(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -64(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	40(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -68(%rbp)
	movl	-64(%rbp), %r8d
	movl	-68(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -72(%rbp)
	movl	-72(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -76(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	48(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -80(%rbp)
	movl	-76(%rbp), %r8d
	movl	-80(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -84(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	48(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -88(%rbp)
	movl	-84(%rbp), %r8d
	movl	-88(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -92(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -96(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	56(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -100(%rbp)
	movl	-96(%rbp), %r8d
	movl	-100(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -104(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	56(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -108(%rbp)
	movl	-104(%rbp), %r8d
	movl	-108(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -112(%rbp)
	movl	-112(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -116(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	64(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -120(%rbp)
	movl	-116(%rbp), %r8d
	movl	-120(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -124(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	64(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -128(%rbp)
	movl	-124(%rbp), %r8d
	movl	-128(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -132(%rbp)
	movl	-132(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -136(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	72(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -140(%rbp)
	movl	-136(%rbp), %r8d
	movl	-140(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -144(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	72(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -148(%rbp)
	movl	-144(%rbp), %r8d
	movl	-148(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -152(%rbp)
	movl	-152(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -156(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	80(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -160(%rbp)
	movl	-156(%rbp), %r8d
	movl	-160(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -164(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	80(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -168(%rbp)
	movl	-164(%rbp), %r8d
	movl	-168(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -172(%rbp)
	movl	-172(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -176(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	88(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -180(%rbp)
	movl	-176(%rbp), %r8d
	movl	-180(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -184(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	88(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -188(%rbp)
	movl	-184(%rbp), %r8d
	movl	-188(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -192(%rbp)
	movl	-192(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -196(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	96(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -200(%rbp)
	movl	-196(%rbp), %r8d
	movl	-200(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -204(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	96(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -208(%rbp)
	movl	-204(%rbp), %r8d
	movl	-208(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -212(%rbp)
	movl	-212(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -216(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	104(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -220(%rbp)
	movl	-216(%rbp), %r8d
	movl	-220(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -224(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	104(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -228(%rbp)
	movl	-224(%rbp), %r8d
	movl	-228(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -232(%rbp)
	movl	-232(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -236(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	112(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -240(%rbp)
	movl	-236(%rbp), %r8d
	movl	-240(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -244(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	112(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -248(%rbp)
	movl	-244(%rbp), %r8d
	movl	-248(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -252(%rbp)
	movl	-252(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -256(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	120(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -260(%rbp)
	movl	-256(%rbp), %r8d
	movl	-260(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -264(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	120(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -268(%rbp)
	movl	-264(%rbp), %r8d
	movl	-268(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -272(%rbp)
	movl	-272(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -276(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	128(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -280(%rbp)
	movl	-276(%rbp), %r8d
	movl	-280(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -284(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	128(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -288(%rbp)
	movl	-284(%rbp), %r8d
	movl	-288(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -292(%rbp)
	movl	-292(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -296(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	136(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -300(%rbp)
	movl	-296(%rbp), %r8d
	movl	-300(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -304(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	136(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -308(%rbp)
	movl	-304(%rbp), %r8d
	movl	-308(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -312(%rbp)
	movl	-312(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -316(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	144(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -320(%rbp)
	movl	-316(%rbp), %r8d
	movl	-320(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -324(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	144(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -328(%rbp)
	movl	-324(%rbp), %r8d
	movl	-328(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -332(%rbp)
	movl	-332(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -336(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	152(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -340(%rbp)
	movl	-336(%rbp), %r8d
	movl	-340(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -344(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	152(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -348(%rbp)
	movl	-344(%rbp), %r8d
	movl	-348(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -352(%rbp)
	movl	-352(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -356(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	160(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -360(%rbp)
	movl	-356(%rbp), %r8d
	movl	-360(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -364(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	160(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -368(%rbp)
	movl	-364(%rbp), %r8d
	movl	-368(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -372(%rbp)
	movl	-372(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -376(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	168(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -380(%rbp)
	movl	-376(%rbp), %r8d
	movl	-380(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -384(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	168(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -388(%rbp)
	movl	-384(%rbp), %r8d
	movl	-388(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -392(%rbp)
	movl	-392(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -396(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	176(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -400(%rbp)
	movl	-396(%rbp), %r8d
	movl	-400(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -404(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	176(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -408(%rbp)
	movl	-404(%rbp), %r8d
	movl	-408(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -412(%rbp)
	movl	-412(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -416(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	184(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -420(%rbp)
	movl	-416(%rbp), %r8d
	movl	-420(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -424(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	184(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -428(%rbp)
	movl	-424(%rbp), %r8d
	movl	-428(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -432(%rbp)
	movl	-432(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -436(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	192(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -440(%rbp)
	movl	-436(%rbp), %r8d
	movl	-440(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -444(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	192(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -448(%rbp)
	movl	-444(%rbp), %r8d
	movl	-448(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -452(%rbp)
	movl	-452(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -456(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	200(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -460(%rbp)
	movl	-456(%rbp), %r8d
	movl	-460(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -464(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	200(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -468(%rbp)
	movl	-464(%rbp), %r8d
	movl	-468(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -472(%rbp)
	movl	-472(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -476(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	208(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -480(%rbp)
	movl	-476(%rbp), %r8d
	movl	-480(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -484(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	208(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -488(%rbp)
	movl	-484(%rbp), %r8d
	movl	-488(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -492(%rbp)
	movl	-492(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -496(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	216(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -500(%rbp)
	movl	-496(%rbp), %r8d
	movl	-500(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -504(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	216(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -508(%rbp)
	movl	-504(%rbp), %r8d
	movl	-508(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -512(%rbp)
	movl	-512(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -516(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	224(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -520(%rbp)
	movl	-516(%rbp), %r8d
	movl	-520(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -524(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	224(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -528(%rbp)
	movl	-524(%rbp), %r8d
	movl	-528(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -532(%rbp)
	movl	-532(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -536(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	232(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -540(%rbp)
	movl	-536(%rbp), %r8d
	movl	-540(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -544(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	232(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -548(%rbp)
	movl	-544(%rbp), %r8d
	movl	-548(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -552(%rbp)
	movl	-552(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -556(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	240(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -560(%rbp)
	movl	-556(%rbp), %r8d
	movl	-560(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -564(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	240(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -568(%rbp)
	movl	-564(%rbp), %r8d
	movl	-568(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -572(%rbp)
	movl	-572(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -576(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	248(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -580(%rbp)
	movl	-576(%rbp), %r8d
	movl	-580(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -584(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	248(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -588(%rbp)
	movl	-584(%rbp), %r8d
	movl	-588(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -592(%rbp)
	movl	-592(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -596(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	256(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -600(%rbp)
	movl	-596(%rbp), %r8d
	movl	-600(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -604(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	256(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -608(%rbp)
	movl	-604(%rbp), %r8d
	movl	-608(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -612(%rbp)
	movl	-612(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -616(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	264(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -620(%rbp)
	movl	-616(%rbp), %r8d
	movl	-620(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -624(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	264(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	subq	$4, %rsp
	movl	%eax, -628(%rbp)
	movl	-624(%rbp), %r8d
	movl	-628(%rbp), %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -632(%rbp)
	movl	-632(%rbp), %eax
	movl	%eax, -12(%rbp)		          # assign int
	movl	-12(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -636(%rbp)
	movl	-636(%rbp), %eax
	leave
	ret

	.globl	param16
	.type	param16, @function
param16:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	16(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -4(%rbp)
	movl	24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -8(%rbp)
	movl	32(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -12(%rbp)
	movl	40(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -16(%rbp)
	movl	48(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -20(%rbp)
	movl	56(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -24(%rbp)
	movl	64(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -28(%rbp)
	movl	72(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -32(%rbp)
	movl	80(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -36(%rbp)
	movl	88(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -40(%rbp)
	movl	96(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -44(%rbp)
	movl	104(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -48(%rbp)
	movl	112(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -52(%rbp)
	movl	120(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -56(%rbp)
	movl	128(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -60(%rbp)
	movl	136(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -64(%rbp)
	subq	$64, %rsp
	movl	-4(%rbp), %eax
	movl	%eax, -128(%rbp)
	movl	-8(%rbp), %eax
	movl	%eax, -124(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -120(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -116(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -112(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -108(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -104(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -100(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -96(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, -92(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, -88(%rbp)
	movl	-48(%rbp), %eax
	movl	%eax, -84(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -80(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -76(%rbp)
	movl	-60(%rbp), %eax
	movl	%eax, -72(%rbp)
	movl	-64(%rbp), %eax
	movl	%eax, -68(%rbp)
	subq	$8, %rsp
	leaq	-128(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp                         # align stack
	subq	$8, %rsp		                 # param 1
	movq	$16, (%rsp)
	subq	$8, %rsp		                 # param 0
	movq	-136(%rbp), %r8
	movq	%r8, (%rsp)
	call	sort

	addq	$16, %rsp
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -148(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -152(%rbp)
	movl	$2, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -156(%rbp)
	movl	$3, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -160(%rbp)
	movl	$4, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -164(%rbp)
	movl	$5, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -168(%rbp)
	movl	$6, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -172(%rbp)
	movl	$7, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -176(%rbp)
	movl	$8, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -180(%rbp)
	movl	$9, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -184(%rbp)
	movl	$10, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -188(%rbp)
	movl	$11, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -192(%rbp)
	movl	$12, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -196(%rbp)
	movl	$13, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -200(%rbp)
	movl	$14, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -204(%rbp)
	movl	$15, %ecx
	movslq	%ecx, %rcx
	movl	-128(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -208(%rbp)
	movl	16(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -212(%rbp)
	movl	24(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -216(%rbp)
	movl	32(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -220(%rbp)
	movl	40(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -224(%rbp)
	movl	48(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -228(%rbp)
	movl	56(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -232(%rbp)
	movl	64(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -236(%rbp)
	movl	72(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -240(%rbp)
	movl	80(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -244(%rbp)
	movl	88(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -248(%rbp)
	movl	96(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -252(%rbp)
	movl	104(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -256(%rbp)
	movl	112(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -260(%rbp)
	movl	120(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -264(%rbp)
	movl	128(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -268(%rbp)
	movl	136(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -272(%rbp)
	subq	$8, %rsp		                 # param 31
	movl	-272(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 30
	movl	-268(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 29
	movl	-264(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 28
	movl	-260(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 27
	movl	-256(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 26
	movl	-252(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 25
	movl	-248(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 24
	movl	-244(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 23
	movl	-240(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 22
	movl	-236(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 21
	movl	-232(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 20
	movl	-228(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 19
	movl	-224(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 18
	movl	-220(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 17
	movl	-216(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 16
	movl	-212(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 15
	movl	-208(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 14
	movl	-204(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 13
	movl	-200(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 12
	movl	-196(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 11
	movl	-192(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 10
	movl	-188(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 9
	movl	-184(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 8
	movl	-180(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 7
	movl	-176(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 6
	movl	-172(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 5
	movl	-168(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 4
	movl	-164(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 3
	movl	-160(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 2
	movl	-156(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 1
	movl	-152(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 0
	movl	-148(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	call	param32_rec

	addq	$256, %rsp
	subq	$4, %rsp
	movl	%eax, -276(%rbp)
	movl	-276(%rbp), %eax
	leave
	ret

	.globl	getint
	.type	getint, @function
getint:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$4, %rsp
	movl	$0, -4(%rbp)
	leaq	-4(%rbp), %r8
	subq	$8, %rsp
	movq	%r8, -12(%rbp)
	subq	$4, %rsp                         # align stack
	leaq	__fmt_string0(%rip), %rdi		# scanf
	movq	-12(%rbp), %rsi
	call	scanf
	movl	-4(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -20(%rbp)
	movl	-20(%rbp), %eax
	leave
	ret

	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	call	getint
	subq	$4, %rsp
	movl	%eax, -4(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -20(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -36(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -52(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -68(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -84(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -100(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -116(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -132(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -148(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -164(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -180(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -196(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -212(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -228(%rbp)
	subq	$12, %rsp                        # align stack
	call	getint
	subq	$4, %rsp
	movl	%eax, -244(%rbp)
	subq	$12, %rsp                        # align stack
	subq	$8, %rsp		                 # param 15
	movl	-244(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 14
	movl	-228(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 13
	movl	-212(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 12
	movl	-196(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 11
	movl	-180(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 10
	movl	-164(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 9
	movl	-148(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 8
	movl	-132(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 7
	movl	-116(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 6
	movl	-100(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 5
	movl	-84(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 4
	movl	-68(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 3
	movl	-52(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 2
	movl	-36(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 1
	movl	-20(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 0
	movl	-4(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, (%rsp)
	call	param16

	addq	$128, %rsp
	subq	$4, %rsp
	movl	%eax, -260(%rbp)
	subq	$256, %rsp
	movl	-260(%rbp), %eax
	movl	%eax, -516(%rbp)
	movl	$8848, -512(%rbp)
	movl	$0, -508(%rbp)
	movl	$0, -504(%rbp)
	movl	$0, -500(%rbp)
	movl	$0, -496(%rbp)
	movl	$0, -492(%rbp)
	movl	$0, -488(%rbp)
	movl	$0, -484(%rbp)
	movl	$0, -480(%rbp)
	movl	$0, -476(%rbp)
	movl	$0, -472(%rbp)
	movl	$0, -468(%rbp)
	movl	$0, -464(%rbp)
	movl	$0, -460(%rbp)
	movl	$0, -456(%rbp)
	movl	$0, -452(%rbp)
	movl	$0, -448(%rbp)
	movl	$0, -444(%rbp)
	movl	$0, -440(%rbp)
	movl	$0, -436(%rbp)
	movl	$0, -432(%rbp)
	movl	$0, -428(%rbp)
	movl	$0, -424(%rbp)
	movl	$0, -420(%rbp)
	movl	$0, -416(%rbp)
	movl	$0, -412(%rbp)
	movl	$0, -408(%rbp)
	movl	$0, -404(%rbp)
	movl	$0, -400(%rbp)
	movl	$0, -396(%rbp)
	movl	$0, -392(%rbp)
	movl	$0, -388(%rbp)
	movl	$0, -384(%rbp)
	movl	$0, -380(%rbp)
	movl	$0, -376(%rbp)
	movl	$0, -372(%rbp)
	movl	$0, -368(%rbp)
	movl	$0, -364(%rbp)
	movl	$0, -360(%rbp)
	movl	$0, -356(%rbp)
	movl	$0, -352(%rbp)
	movl	$0, -348(%rbp)
	movl	$0, -344(%rbp)
	movl	$0, -340(%rbp)
	movl	$0, -336(%rbp)
	movl	$0, -332(%rbp)
	movl	$0, -328(%rbp)
	movl	$0, -324(%rbp)
	movl	$0, -320(%rbp)
	movl	$0, -316(%rbp)
	movl	$0, -312(%rbp)
	movl	$0, -308(%rbp)
	movl	$0, -304(%rbp)
	movl	$0, -300(%rbp)
	movl	$0, -296(%rbp)
	movl	$0, -292(%rbp)
	movl	$0, -288(%rbp)
	movl	$0, -284(%rbp)
	movl	$0, -280(%rbp)
	movl	$0, -276(%rbp)
	movl	$0, -272(%rbp)
	movl	$0, -268(%rbp)
	movl	$0, -264(%rbp)
	subq	$4, %rsp
	movl	$1, -520(%rbp)
.L18:
                                             # enter while
                                             # enter block
.L19:
	movl	-520(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -524(%rbp)
	subq	$4, %rsp                         # align stack
	movl	-524(%rbp), %r8d
	movl	$32, %r9d
	cmpl	%r9d, %r8d		               # if <
	jl	.L21
	jmp	.L20
.L20:
                                             # exit while
	addq	$8, %rsp
	jmp	.L22
.L21:
	movl	-520(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -532(%rbp)
	movl	-520(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -536(%rbp)
	movl	-536(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -540(%rbp)
	movl	$0, %ecx
	imull	$32, %ecx
	movl	-540(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-516(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -544(%rbp)
	movl	-544(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -548(%rbp)
	movl	$0, %ecx
	imull	$32, %ecx
	movl	-532(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-548(%rbp), %eax
	leaq	-516(%rbp, %rcx, 4), %rbx		# assign int_array
	movl	%eax, (%rbx)
	movl	-520(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -552(%rbp)
	movl	-520(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -556(%rbp)
	movl	-556(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -560(%rbp)
	movl	$0, %ecx
	imull	$32, %ecx
	movl	-560(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$0, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-516(%rbp, %rcx, 4), %eax
	subq	$4, %rsp
	movl	%eax, -564(%rbp)
	movl	-564(%rbp), %r8d
	movl	$2, %r9d
	subl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -568(%rbp)
	movl	$0, %ecx
	imull	$32, %ecx
	movl	-552(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$2, %ecx
	movl	$1, %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-568(%rbp), %eax
	leaq	-516(%rbp, %rcx, 4), %rbx		# assign int_array
	movl	%eax, (%rbx)
	movl	-520(%rbp), %r8d
	subq	$4, %rsp
	movl	%r8d, -572(%rbp)
	movl	-572(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	subq	$4, %rsp
	movl	%r8d, -576(%rbp)
	movl	-576(%rbp), %eax
	movl	%eax, -520(%rbp)		         # assign int
	addq	$56, %rsp		                # exiting block, restore %rsp
	jmp	.L18
.L22:		                                # end while
	movl	$0, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -528(%rbp)
	movl	$2, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -536(%rbp)
	movl	$4, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -544(%rbp)
	movl	$6, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -552(%rbp)
	movl	$8, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -560(%rbp)
	movl	$10, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -568(%rbp)
	movl	$12, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -576(%rbp)
	movl	$14, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -584(%rbp)
	movl	$16, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -592(%rbp)
	movl	$18, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -600(%rbp)
	movl	$20, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -608(%rbp)
	movl	$22, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -616(%rbp)
	movl	$24, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -624(%rbp)
	movl	$26, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -632(%rbp)
	movl	$28, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -640(%rbp)
	movl	$30, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -648(%rbp)
	movl	$32, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -656(%rbp)
	movl	$34, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -664(%rbp)
	movl	$36, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -672(%rbp)
	movl	$38, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -680(%rbp)
	movl	$40, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -688(%rbp)
	movl	$42, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -696(%rbp)
	movl	$44, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -704(%rbp)
	movl	$46, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -712(%rbp)
	movl	$48, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -720(%rbp)
	movl	$50, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -728(%rbp)
	movl	$52, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -736(%rbp)
	movl	$54, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -744(%rbp)
	movl	$56, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -752(%rbp)
	movl	$58, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -760(%rbp)
	movl	$60, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -768(%rbp)
	movl	$62, %ecx
	movslq	%ecx, %rcx
	leaq	-516(%rbp, %rcx, 4), %rbx
	subq	$8, %rsp
	movq	%rbx, -776(%rbp)
	subq	$8, %rsp                         # align stack
	subq	$8, %rsp		                 # param 31
	movq	-776(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 30
	movq	-768(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 29
	movq	-760(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 28
	movq	-752(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 27
	movq	-744(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 26
	movq	-736(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 25
	movq	-728(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 24
	movq	-720(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 23
	movq	-712(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 22
	movq	-704(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 21
	movq	-696(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 20
	movq	-688(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 19
	movq	-680(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 18
	movq	-672(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 17
	movq	-664(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 16
	movq	-656(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 15
	movq	-648(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 14
	movq	-640(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 13
	movq	-632(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 12
	movq	-624(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 11
	movq	-616(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 10
	movq	-608(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 9
	movq	-600(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 8
	movq	-592(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 7
	movq	-584(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 6
	movq	-576(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 5
	movq	-568(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 4
	movq	-560(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 3
	movq	-552(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 2
	movq	-544(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 1
	movq	-536(%rbp), %r8
	movq	%r8, (%rsp)
	subq	$8, %rsp		                 # param 0
	movq	-528(%rbp), %r8
	movq	%r8, (%rsp)
	call	param32_arr

	addq	$256, %rsp
	subq	$4, %rsp
	movl	%eax, -788(%rbp)
	subq	$12, %rsp                        # align stack
	leaq	__fmt_string1(%rip), %rdi		# printf
	movl	-788(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi
	call	printf
	movl	$0, %eax
	leave
	ret

