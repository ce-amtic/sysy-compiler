.section .rodata
__fmt_string0:	.string "%d\n"

.section .data
	.globl	a0
	.data
	.align	4
	.type	a0, @object
	.size	a0, 12
a0:
	.zero	12
	.globl	b0
	.data
	.align	4
	.type	b0, @object
	.size	b0, 16
b0:
	.zero	4
	.long	1
	.zero	8
	.globl	c0
	.data
	.align	4
	.type	c0, @object
	.size	c0, 28
c0:
	.long	2
	.long	8
	.long	6
	.long	3
	.long	9
	.long	1
	.long	5
	.globl	d0
	.data
	.align	4
	.type	d0, @object
	.size	d0, 44
d0:
	.zero	44
	.globl	e0
	.data
	.align	4
	.type	e0, @object
	.size	e0, 8
e0:
	.long	22
	.long	33
	.globl	f0
	.data
	.align	4
	.type	f0, @object
	.size	f0, 24
f0:
	.zero	24
	.globl	g0
	.data
	.align	4
	.type	g0, @object
	.size	g0, 36
g0:
	.long	85
	.zero	4
	.long	1
	.long	29
	.zero	20
	.globl	scj82c9s0j
	.data
	.align	4
	.type	scj82c9s0j, @object
	.size	scj82c9s0j, 4
scj82c9s0j:
	.long	9
	.globl	a
	.data
	.align	4
	.type	a, @object
	.size	a, 60
a:
	.zero	60
	.globl	b
	.data
	.align	4
	.type	b, @object
	.size	b, 60
b:
	.zero	60
	.globl	c
	.data
	.align	4
	.type	c, @object
	.size	c, 60
c:
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.long	8
	.long	9
	.long	10
	.long	11
	.long	12
	.long	13
	.long	14
	.long	15
	.globl	d
	.data
	.align	4
	.type	d, @object
	.size	d, 60
d:
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.long	8
	.long	9
	.long	10
	.long	11
	.long	12
	.long	13
	.long	14
	.long	15
	.globl	e
	.data
	.align	4
	.type	e, @object
	.size	e, 60
e:
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.long	8
	.long	9
	.long	10
	.long	11
	.long	12
	.long	13
	.long	14
	.long	15
	.globl	f
	.data
	.align	4
	.type	f, @object
	.size	f, 20
f:
	.zero	20
	.globl	g
	.data
	.align	4
	.type	g, @object
	.size	g, 60
g:
	.long	1
	.long	2
	.long	3
	.long	4
	.zero	8
	.long	7
	.zero	8
	.long	10
	.long	11
	.long	12
	.zero	12
	.globl	h
	.data
	.align	4
	.type	h, @object
	.size	h, 12
h:
	.zero	12
	.globl	i
	.data
	.align	4
	.type	i, @object
	.size	i, 96
i:
	.long	1
	.long	2
	.long	3
	.long	4
	.zero	32
	.long	5
	.zero	140

.section .bss

.section .text

	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp                        # fixed frame size
	movl	$2, %ecx
	movslq	%ecx, %rcx
	leaq	c0(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -4(%rbp)
	movl	$3, %ecx
	movslq	%ecx, %rcx
	leaq	g0(%rip), %r8
	leaq	(%r8, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -8(%rbp)
	movl	-4(%rbp), %r8d
	movl	-8(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -12(%rbp)
	leaq	scj82c9s0j(%rip), %rbx
	movl	0(%rbx), %r8d
	movl	%r8d, -16(%rbp)
	movl	-12(%rbp), %r8d
	movl	-16(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -20(%rbp)
	leaq	__fmt_string0(%rip), %rdi        # param 0
	movl	-20(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	movl	$5, %eax
	leave
	ret
