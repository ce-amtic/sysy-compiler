.section .rodata
__fmt_string0:	.string "%d\n"
__fmt_string1:	.string "%d\n"

.section .data

.section .bss

.section .text

	.globl	MAX
	.type	MAX, @function
MAX:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp                        # fixed frame size
.L1:
	movl	16(%rbp), %r8d
	movl	%r8d, -4(%rbp)
	movl	24(%rbp), %r8d
	movl	%r8d, -8(%rbp)
	movl	-4(%rbp), %r8d
	movl	-8(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if ==
	je	.L2
	jmp	.L3
.L2:
	movl	16(%rbp), %r8d
	movl	%r8d, -12(%rbp)
	movl	-12(%rbp), %eax
	leave
	ret
	jmp	.L8
.L3:
.L4:
	movl	16(%rbp), %r8d
	movl	%r8d, -16(%rbp)
	movl	24(%rbp), %r8d
	movl	%r8d, -20(%rbp)
	movl	-16(%rbp), %r8d
	movl	-20(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if >
	jg	.L5
	jmp	.L6
.L5:
	movl	16(%rbp), %r8d
	movl	%r8d, -24(%rbp)
	movl	-24(%rbp), %eax
	leave
	ret
	jmp	.L7
.L6:
	movl	24(%rbp), %r8d
	movl	%r8d, -28(%rbp)
	movl	-28(%rbp), %eax
	leave
	ret
.L7:
.L8:

	.globl	max_sum_nonadjacent
	.type	max_sum_nonadjacent, @function
max_sum_nonadjacent:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$176, %rsp                       # fixed frame size
	movl	$0, -64(%rbp)
	movl	$0, -60(%rbp)
	movl	$0, -56(%rbp)
	movl	$0, -52(%rbp)
	movl	$0, -48(%rbp)
	movl	$0, -44(%rbp)
	movl	$0, -40(%rbp)
	movl	$0, -36(%rbp)
	movl	$0, -32(%rbp)
	movl	$0, -28(%rbp)
	movl	$0, -24(%rbp)
	movl	$0, -20(%rbp)
	movl	$0, -16(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -68(%rbp)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movl	-68(%rbp), %eax
	leaq	-64(%rbp, %rcx, 4), %rbx         # assign int_array
	movl	%eax, (%rbx)
	movl	$0, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -72(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -76(%rbp)
	movl	-76(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 8(%rsp)                     # param 1
	movl	-72(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	MAX
	movl	%eax, -80(%rbp)
	movl	$1, %ecx
	movslq	%ecx, %rcx
	movl	-80(%rbp), %eax
	leaq	-64(%rbp, %rcx, 4), %rbx         # assign int_array
	movl	%eax, (%rbx)
	movl	$2, -84(%rbp)
.L9:
                                             # enter while
.L10:
	movl	-84(%rbp), %r8d
	movl	%r8d, -88(%rbp)
	movl	24(%rbp), %r8d
	movl	%r8d, -92(%rbp)
	movl	-88(%rbp), %r8d
	movl	-92(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <
	jl	.L12
	jmp	.L11
.L11:
                                             # exit while
	jmp	.L13
.L12:
	movl	-84(%rbp), %r8d
	movl	%r8d, -96(%rbp)
	movl	-84(%rbp), %r8d
	movl	%r8d, -100(%rbp)
	movl	-100(%rbp), %r8d
	movl	$2, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -104(%rbp)
	movl	$0, %ecx
	imull	$16, %ecx
	movl	-104(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-64(%rbp, %rcx, 4), %eax
	movl	%eax, -108(%rbp)
	movl	-84(%rbp), %r8d
	movl	%r8d, -112(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-112(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -116(%rbp)
	movl	-108(%rbp), %r8d
	movl	-116(%rbp), %r9d
	addl	%r9d, %r8d
	movl	%r8d, -120(%rbp)
	movl	-84(%rbp), %r8d
	movl	%r8d, -124(%rbp)
	movl	-124(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -128(%rbp)
	movl	$0, %ecx
	imull	$16, %ecx
	movl	-128(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-64(%rbp, %rcx, 4), %eax
	movl	%eax, -132(%rbp)
	movl	-132(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 8(%rsp)                     # param 1
	movl	-120(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	MAX
	movl	%eax, -136(%rbp)
	movl	$0, %ecx
	imull	$16, %ecx
	movl	-96(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-136(%rbp), %eax
	leaq	-64(%rbp, %rcx, 4), %rbx         # assign int_array
	movl	%eax, (%rbx)
	movl	-84(%rbp), %r8d
	movl	%r8d, -140(%rbp)
	movl	-140(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -144(%rbp)
	movl	-144(%rbp), %eax
	movl	%eax, -84(%rbp)                  # assign int
	jmp	.L9
.L13:                                        # end while
	movl	24(%rbp), %r8d
	movl	%r8d, -148(%rbp)
	movl	-148(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -152(%rbp)
	movl	$0, %ecx
	imull	$16, %ecx
	movl	-152(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-64(%rbp, %rcx, 4), %eax
	movl	%eax, -156(%rbp)
	movl	-156(%rbp), %eax
	leave
	ret

	.globl	longest_common_subseq
	.type	longest_common_subseq, @function
longest_common_subseq:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$1200, %rsp                      # fixed frame size
	movl	$0, -1024(%rbp)
	movl	$0, -1020(%rbp)
	movl	$0, -1016(%rbp)
	movl	$0, -1012(%rbp)
	movl	$0, -1008(%rbp)
	movl	$0, -1004(%rbp)
	movl	$0, -1000(%rbp)
	movl	$0, -996(%rbp)
	movl	$0, -992(%rbp)
	movl	$0, -988(%rbp)
	movl	$0, -984(%rbp)
	movl	$0, -980(%rbp)
	movl	$0, -976(%rbp)
	movl	$0, -972(%rbp)
	movl	$0, -968(%rbp)
	movl	$0, -964(%rbp)
	movl	$0, -960(%rbp)
	movl	$0, -956(%rbp)
	movl	$0, -952(%rbp)
	movl	$0, -948(%rbp)
	movl	$0, -944(%rbp)
	movl	$0, -940(%rbp)
	movl	$0, -936(%rbp)
	movl	$0, -932(%rbp)
	movl	$0, -928(%rbp)
	movl	$0, -924(%rbp)
	movl	$0, -920(%rbp)
	movl	$0, -916(%rbp)
	movl	$0, -912(%rbp)
	movl	$0, -908(%rbp)
	movl	$0, -904(%rbp)
	movl	$0, -900(%rbp)
	movl	$0, -896(%rbp)
	movl	$0, -892(%rbp)
	movl	$0, -888(%rbp)
	movl	$0, -884(%rbp)
	movl	$0, -880(%rbp)
	movl	$0, -876(%rbp)
	movl	$0, -872(%rbp)
	movl	$0, -868(%rbp)
	movl	$0, -864(%rbp)
	movl	$0, -860(%rbp)
	movl	$0, -856(%rbp)
	movl	$0, -852(%rbp)
	movl	$0, -848(%rbp)
	movl	$0, -844(%rbp)
	movl	$0, -840(%rbp)
	movl	$0, -836(%rbp)
	movl	$0, -832(%rbp)
	movl	$0, -828(%rbp)
	movl	$0, -824(%rbp)
	movl	$0, -820(%rbp)
	movl	$0, -816(%rbp)
	movl	$0, -812(%rbp)
	movl	$0, -808(%rbp)
	movl	$0, -804(%rbp)
	movl	$0, -800(%rbp)
	movl	$0, -796(%rbp)
	movl	$0, -792(%rbp)
	movl	$0, -788(%rbp)
	movl	$0, -784(%rbp)
	movl	$0, -780(%rbp)
	movl	$0, -776(%rbp)
	movl	$0, -772(%rbp)
	movl	$0, -768(%rbp)
	movl	$0, -764(%rbp)
	movl	$0, -760(%rbp)
	movl	$0, -756(%rbp)
	movl	$0, -752(%rbp)
	movl	$0, -748(%rbp)
	movl	$0, -744(%rbp)
	movl	$0, -740(%rbp)
	movl	$0, -736(%rbp)
	movl	$0, -732(%rbp)
	movl	$0, -728(%rbp)
	movl	$0, -724(%rbp)
	movl	$0, -720(%rbp)
	movl	$0, -716(%rbp)
	movl	$0, -712(%rbp)
	movl	$0, -708(%rbp)
	movl	$0, -704(%rbp)
	movl	$0, -700(%rbp)
	movl	$0, -696(%rbp)
	movl	$0, -692(%rbp)
	movl	$0, -688(%rbp)
	movl	$0, -684(%rbp)
	movl	$0, -680(%rbp)
	movl	$0, -676(%rbp)
	movl	$0, -672(%rbp)
	movl	$0, -668(%rbp)
	movl	$0, -664(%rbp)
	movl	$0, -660(%rbp)
	movl	$0, -656(%rbp)
	movl	$0, -652(%rbp)
	movl	$0, -648(%rbp)
	movl	$0, -644(%rbp)
	movl	$0, -640(%rbp)
	movl	$0, -636(%rbp)
	movl	$0, -632(%rbp)
	movl	$0, -628(%rbp)
	movl	$0, -624(%rbp)
	movl	$0, -620(%rbp)
	movl	$0, -616(%rbp)
	movl	$0, -612(%rbp)
	movl	$0, -608(%rbp)
	movl	$0, -604(%rbp)
	movl	$0, -600(%rbp)
	movl	$0, -596(%rbp)
	movl	$0, -592(%rbp)
	movl	$0, -588(%rbp)
	movl	$0, -584(%rbp)
	movl	$0, -580(%rbp)
	movl	$0, -576(%rbp)
	movl	$0, -572(%rbp)
	movl	$0, -568(%rbp)
	movl	$0, -564(%rbp)
	movl	$0, -560(%rbp)
	movl	$0, -556(%rbp)
	movl	$0, -552(%rbp)
	movl	$0, -548(%rbp)
	movl	$0, -544(%rbp)
	movl	$0, -540(%rbp)
	movl	$0, -536(%rbp)
	movl	$0, -532(%rbp)
	movl	$0, -528(%rbp)
	movl	$0, -524(%rbp)
	movl	$0, -520(%rbp)
	movl	$0, -516(%rbp)
	movl	$0, -512(%rbp)
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
	movl	$0, -260(%rbp)
	movl	$0, -256(%rbp)
	movl	$0, -252(%rbp)
	movl	$0, -248(%rbp)
	movl	$0, -244(%rbp)
	movl	$0, -240(%rbp)
	movl	$0, -236(%rbp)
	movl	$0, -232(%rbp)
	movl	$0, -228(%rbp)
	movl	$0, -224(%rbp)
	movl	$0, -220(%rbp)
	movl	$0, -216(%rbp)
	movl	$0, -212(%rbp)
	movl	$0, -208(%rbp)
	movl	$0, -204(%rbp)
	movl	$0, -200(%rbp)
	movl	$0, -196(%rbp)
	movl	$0, -192(%rbp)
	movl	$0, -188(%rbp)
	movl	$0, -184(%rbp)
	movl	$0, -180(%rbp)
	movl	$0, -176(%rbp)
	movl	$0, -172(%rbp)
	movl	$0, -168(%rbp)
	movl	$0, -164(%rbp)
	movl	$0, -160(%rbp)
	movl	$0, -156(%rbp)
	movl	$0, -152(%rbp)
	movl	$0, -148(%rbp)
	movl	$0, -144(%rbp)
	movl	$0, -140(%rbp)
	movl	$0, -136(%rbp)
	movl	$0, -132(%rbp)
	movl	$0, -128(%rbp)
	movl	$0, -124(%rbp)
	movl	$0, -120(%rbp)
	movl	$0, -116(%rbp)
	movl	$0, -112(%rbp)
	movl	$0, -108(%rbp)
	movl	$0, -104(%rbp)
	movl	$0, -100(%rbp)
	movl	$0, -96(%rbp)
	movl	$0, -92(%rbp)
	movl	$0, -88(%rbp)
	movl	$0, -84(%rbp)
	movl	$0, -80(%rbp)
	movl	$0, -76(%rbp)
	movl	$0, -72(%rbp)
	movl	$0, -68(%rbp)
	movl	$0, -64(%rbp)
	movl	$0, -60(%rbp)
	movl	$0, -56(%rbp)
	movl	$0, -52(%rbp)
	movl	$0, -48(%rbp)
	movl	$0, -44(%rbp)
	movl	$0, -40(%rbp)
	movl	$0, -36(%rbp)
	movl	$0, -32(%rbp)
	movl	$0, -28(%rbp)
	movl	$0, -24(%rbp)
	movl	$0, -20(%rbp)
	movl	$0, -16(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	movl	$0, -1028(%rbp)
	movl	$0, -1032(%rbp)
	movl	$1, %eax
	movl	%eax, -1028(%rbp)                # assign int
.L14:
                                             # enter while
.L15:
	movl	-1028(%rbp), %r8d
	movl	%r8d, -1036(%rbp)
	movl	24(%rbp), %r8d
	movl	%r8d, -1040(%rbp)
	movl	-1036(%rbp), %r8d
	movl	-1040(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <=
	jle	.L17
	jmp	.L16
.L16:
                                             # exit while
	jmp	.L27
.L17:
	movl	$1, %eax
	movl	%eax, -1032(%rbp)                # assign int
.L18:
                                             # enter while
.L19:
	movl	-1032(%rbp), %r8d
	movl	%r8d, -1044(%rbp)
	movl	40(%rbp), %r8d
	movl	%r8d, -1048(%rbp)
	movl	-1044(%rbp), %r8d
	movl	-1048(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if <=
	jle	.L21
	jmp	.L20
.L20:
                                             # exit while
	jmp	.L26
.L21:
.L22:
	movl	-1028(%rbp), %r8d
	movl	%r8d, -1052(%rbp)
	movl	-1052(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -1056(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-1056(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	16(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -1060(%rbp)
	movl	-1032(%rbp), %r8d
	movl	%r8d, -1064(%rbp)
	movl	-1064(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -1068(%rbp)
	movl	$0, %ecx
	imull	$-1, %ecx
	movl	-1068(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	32(%rbp), %r9
	leaq	(%r9, %rcx, 4), %rbx
	movl	(%rbx), %eax
	movl	%eax, -1072(%rbp)
	movl	-1060(%rbp), %r8d
	movl	-1072(%rbp), %r9d
	cmpl	%r9d, %r8d                       # if ==
	je	.L23
	jmp	.L24
.L23:
	movl	-1028(%rbp), %r8d
	movl	%r8d, -1076(%rbp)
	movl	-1032(%rbp), %r8d
	movl	%r8d, -1080(%rbp)
	movl	-1028(%rbp), %r8d
	movl	%r8d, -1084(%rbp)
	movl	-1084(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -1088(%rbp)
	movl	-1032(%rbp), %r8d
	movl	%r8d, -1092(%rbp)
	movl	-1092(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -1096(%rbp)
	movl	$0, %ecx
	imull	$16, %ecx
	movl	-1088(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$16, %ecx
	movl	-1096(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-1024(%rbp, %rcx, 4), %eax
	movl	%eax, -1100(%rbp)
	movl	-1100(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -1104(%rbp)
	movl	$0, %ecx
	imull	$16, %ecx
	movl	-1076(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$16, %ecx
	movl	-1080(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-1104(%rbp), %eax
	leaq	-1024(%rbp, %rcx, 4), %rbx       # assign int_array
	movl	%eax, (%rbx)
	jmp	.L25
.L24:
	movl	-1028(%rbp), %r8d
	movl	%r8d, -1108(%rbp)
	movl	-1032(%rbp), %r8d
	movl	%r8d, -1112(%rbp)
	movl	-1028(%rbp), %r8d
	movl	%r8d, -1116(%rbp)
	movl	-1116(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -1120(%rbp)
	movl	-1032(%rbp), %r8d
	movl	%r8d, -1124(%rbp)
	movl	$0, %ecx
	imull	$16, %ecx
	movl	-1120(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$16, %ecx
	movl	-1124(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-1024(%rbp, %rcx, 4), %eax
	movl	%eax, -1128(%rbp)
	movl	-1028(%rbp), %r8d
	movl	%r8d, -1132(%rbp)
	movl	-1032(%rbp), %r8d
	movl	%r8d, -1136(%rbp)
	movl	-1136(%rbp), %r8d
	movl	$1, %r9d
	subl	%r9d, %r8d
	movl	%r8d, -1140(%rbp)
	movl	$0, %ecx
	imull	$16, %ecx
	movl	-1132(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$16, %ecx
	movl	-1140(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-1024(%rbp, %rcx, 4), %eax
	movl	%eax, -1144(%rbp)
	movl	-1144(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 8(%rsp)                     # param 1
	movl	-1128(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	MAX
	movl	%eax, -1148(%rbp)
	movl	$0, %ecx
	imull	$16, %ecx
	movl	-1108(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$16, %ecx
	movl	-1112(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-1148(%rbp), %eax
	leaq	-1024(%rbp, %rcx, 4), %rbx       # assign int_array
	movl	%eax, (%rbx)
.L25:
	movl	-1032(%rbp), %r8d
	movl	%r8d, -1152(%rbp)
	movl	-1152(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -1156(%rbp)
	movl	-1156(%rbp), %eax
	movl	%eax, -1032(%rbp)                # assign int
	jmp	.L18
.L26:                                        # end while
	movl	-1028(%rbp), %r8d
	movl	%r8d, -1160(%rbp)
	movl	-1160(%rbp), %r8d
	movl	$1, %r9d
	addl	%r9d, %r8d
	movl	%r8d, -1164(%rbp)
	movl	-1164(%rbp), %eax
	movl	%eax, -1028(%rbp)                # assign int
	jmp	.L14
.L27:                                        # end while
	movl	24(%rbp), %r8d
	movl	%r8d, -1168(%rbp)
	movl	40(%rbp), %r8d
	movl	%r8d, -1172(%rbp)
	movl	$0, %ecx
	imull	$16, %ecx
	movl	-1168(%rbp), %r8d
	addl	%r8d, %ecx
	imull	$16, %ecx
	movl	-1172(%rbp), %r8d
	addl	%r8d, %ecx
	movslq	%ecx, %rcx
	movl	-1024(%rbp, %rcx, 4), %eax
	movl	%eax, -1176(%rbp)
	movl	-1176(%rbp), %eax
	leave
	ret

	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$176, %rsp                       # fixed frame size
	movl	$8, -60(%rbp)
	movl	$7, -56(%rbp)
	movl	$4, -52(%rbp)
	movl	$1, -48(%rbp)
	movl	$2, -44(%rbp)
	movl	$7, -40(%rbp)
	movl	$0, -36(%rbp)
	movl	$1, -32(%rbp)
	movl	$9, -28(%rbp)
	movl	$3, -24(%rbp)
	movl	$4, -20(%rbp)
	movl	$8, -16(%rbp)
	movl	$3, -12(%rbp)
	movl	$7, -8(%rbp)
	movl	$0, -4(%rbp)
	movl	$3, -112(%rbp)
	movl	$9, -108(%rbp)
	movl	$7, -104(%rbp)
	movl	$1, -100(%rbp)
	movl	$4, -96(%rbp)
	movl	$2, -92(%rbp)
	movl	$4, -88(%rbp)
	movl	$3, -84(%rbp)
	movl	$6, -80(%rbp)
	movl	$8, -76(%rbp)
	movl	$0, -72(%rbp)
	movl	$1, -68(%rbp)
	movl	$5, -64(%rbp)
	leaq	-60(%rbp), %r8
	movq	%r8, -120(%rbp)
	movq	$15, 8(%rsp)                     # param 1
	movq	-120(%rbp), %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	max_sum_nonadjacent
	movl	%eax, -124(%rbp)
	leaq	__fmt_string0(%rip), %rdi        # param 0
	movl	-124(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	leaq	-60(%rbp), %r8
	movq	%r8, -132(%rbp)
	leaq	-112(%rbp), %r8
	movq	%r8, -140(%rbp)
	movq	$13, 24(%rsp)                    # param 3
	movq	-140(%rbp), %r8
	movq	%r8, 16(%rsp)                    # param 2
	movq	$15, 8(%rsp)                     # param 1
	movq	-132(%rbp), %r8
	movq	%r8, 0(%rsp)                     # param 0
	call	longest_common_subseq
	movl	%eax, -144(%rbp)
	leaq	__fmt_string1(%rip), %rdi        # param 0
	movl	-144(%rbp), %r8d
	movsxd	%r8d, %r8
	movq	%r8, %rsi                        # param 1
	call	printf
	movl	$0, %eax
	leave
	ret
