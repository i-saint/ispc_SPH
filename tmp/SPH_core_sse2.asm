	.def	 "UpdateVelocity___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>";
	.scl	2;
	.type	32;
	.endef
	.section	.rdata,"r"
	.align	16
.LCPI0_0:
	.long	3217031168              # float -1.500000e+00
                                        #  (0xbfc00000)
	.zero	12
.LCPI0_1:
	.long	3137540719              # float -2.000000e-03
                                        #  (0xbb03126f)
	.long	3137540719              # float -2.000000e-03
                                        #  (0xbb03126f)
	.long	3137540719              # float -2.000000e-03
                                        #  (0xbb03126f)
	.zero	4
.LCPI0_2:
	.long	1036831949              # float 1.000000e-01
                                        #  (0x3dcccccd)
	.zero	12
.LCPI0_3:
	.long	3173242634              # float -4.000000e-02
	.long	3173242634              # float -4.000000e-02
	.long	3173242634              # float -4.000000e-02
	.long	3173242634              # float -4.000000e-02
.LCPI0_4:
	.long	3184315597              # float -1.000000e-01
	.long	3184315597              # float -1.000000e-01
	.long	3184315597              # float -1.000000e-01
	.long	3184315597              # float -1.000000e-01
	.text
	.globl	"UpdateVelocity___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>"
	.align	16, 0x90
"UpdateVelocity___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>": # @"UpdateVelocity___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>"
# BB#0:                                 # %allocas
	pushq	%r14
	pushq	%rsi
	pushq	%rdi
	pushq	%rbp
	pushq	%rbx
	subq	$288, %rsp              # imm = 0x120
	movaps	%xmm15, 128(%rsp)       # 16-byte Spill
	movaps	%xmm14, 144(%rsp)       # 16-byte Spill
	movaps	%xmm13, 160(%rsp)       # 16-byte Spill
	movaps	%xmm12, 176(%rsp)       # 16-byte Spill
	movaps	%xmm11, 192(%rsp)       # 16-byte Spill
	movaps	%xmm10, 208(%rsp)       # 16-byte Spill
	movaps	%xmm9, 224(%rsp)        # 16-byte Spill
	movaps	%xmm8, 240(%rsp)        # 16-byte Spill
	movaps	%xmm7, 256(%rsp)        # 16-byte Spill
	movaps	%xmm6, 272(%rsp)        # 16-byte Spill
	movups	16(%rcx), %xmm0
	movaps	%xmm0, 112(%rsp)        # 16-byte Spill
	movmskps	%xmm0, %edx
	testl	%edx, %edx
	je	.LBB0_12
# BB#1:                                 # %allocas
	movq	8(%rcx), %rax
	movl	(%rcx), %ebp
	shll	$7, %r9d
	cmpl	$15, %edx
	jne	.LBB0_13
# BB#2:                                 # %all_on
	movl	%ebp, %edx
	subl	%r9d, %edx
	testl	%edx, %edx
	jle	.LBB0_12
# BB#3:                                 # %for_loop.lr.ph
	sarl	$3, %r9d
	cmpl	$129, %edx
	movl	$128, %r8d
	cmovll	%edx, %r8d
	testl	%ebp, %ebp
	jle	.LBB0_10
# BB#4:
	xorl	%edx, %edx
	jmp	.LBB0_8
	.align	16, 0x90
.LBB0_9:                                # %for_loop169.us
                                        #   Parent Loop BB0_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	%edi, %esi
	andl	$16, %esi
	movl	%ebx, %ecx
	sarl	$3, %ecx
	imull	$192, %ecx, %ecx
	movslq	%ecx, %rcx
	orq	%rsi, %rcx
	movups	(%rax,%rcx), %xmm9
	movups	32(%rax,%rcx), %xmm10
	movups	64(%rax,%rcx), %xmm11
	subps	%xmm3, %xmm10
	movaps	%xmm10, %xmm0
	mulps	%xmm0, %xmm0
	subps	%xmm1, %xmm9
	movaps	%xmm9, %xmm7
	mulps	%xmm7, %xmm7
	addps	%xmm0, %xmm7
	subps	%xmm6, %xmm11
	movaps	%xmm11, %xmm0
	mulps	%xmm0, %xmm0
	addps	%xmm7, %xmm0
	sqrtps	%xmm0, %xmm13
	xorps	%xmm7, %xmm7
	cmpltps	%xmm13, %xmm7
	movmskps	%xmm7, %ecx
	testl	%ecx, %ecx
	je	.LBB0_6
# BB#5:                                 # %safe_if_run_true.i.us
                                        #   in Loop: Header=BB0_9 Depth=2
	divps	%xmm13, %xmm11
	movaps	.LCPI0_3(%rip), %xmm0
	addps	%xmm13, %xmm0
	xorps	%xmm14, %xmm14
	minps	%xmm0, %xmm14
	mulps	.LCPI0_4(%rip), %xmm14
	mulps	%xmm14, %xmm11
	divps	%xmm13, %xmm10
	mulps	%xmm14, %xmm10
	addps	%xmm2, %xmm10
	andps	%xmm7, %xmm10
	addps	%xmm8, %xmm11
	andps	%xmm7, %xmm11
	movaps	%xmm7, %xmm15
	andnps	%xmm2, %xmm15
	movaps	%xmm7, %xmm2
	andnps	%xmm8, %xmm2
	orps	%xmm11, %xmm2
	orps	%xmm10, %xmm15
	divps	%xmm13, %xmm9
	mulps	%xmm14, %xmm9
	addps	%xmm12, %xmm9
	andps	%xmm7, %xmm9
	andnps	%xmm12, %xmm7
	orps	%xmm9, %xmm7
	movaps	%xmm2, %xmm8
	movaps	%xmm15, %xmm2
	movaps	%xmm7, %xmm12
.LBB0_6:                                # %ComputeParticleInteraction___vyf<3>vyf<3>REFvyf<3>.exit.us
                                        #   in Loop: Header=BB0_9 Depth=2
	addl	$16, %edi
	addl	$4, %ebx
	cmpl	%ebp, %ebx
	jl	.LBB0_9
# BB#7:                                 # %for_exit170.us
                                        #   in Loop: Header=BB0_8 Depth=1
	movaps	%xmm8, %xmm3
	movhlps	%xmm3, %xmm3            # xmm3 = xmm3[1,1]
	addps	%xmm8, %xmm3
	movaps	%xmm12, %xmm1
	movhlps	%xmm1, %xmm1            # xmm1 = xmm1[1,1]
	addps	%xmm12, %xmm1
	pshufd	$1, %xmm1, %xmm6        # xmm6 = xmm1[1,0,0,0]
	addss	%xmm1, %xmm6
	pshufd	$1, %xmm3, %xmm1        # xmm1 = xmm3[1,0,0,0]
	mulss	%xmm5, %xmm5
	movaps	64(%rsp), %xmm0         # 16-byte Reload
	mulss	%xmm0, %xmm0
	addss	%xmm5, %xmm0
	movaps	80(%rsp), %xmm7         # 16-byte Reload
	mulss	%xmm7, %xmm7
	addss	%xmm0, %xmm7
	movss	44(%rsp), %xmm5         # 4-byte Reload
	addss	%xmm6, %xmm5
	movaps	%xmm2, %xmm0
	movhlps	%xmm0, %xmm0            # xmm0 = xmm0[1,1]
	addss	%xmm3, %xmm1
	movss	%xmm5, %xmm4
	addps	%xmm2, %xmm0
	pshufd	$1, %xmm0, %xmm2        # xmm2 = xmm0[1,0,0,0]
	addss	%xmm0, %xmm2
	movaps	48(%rsp), %xmm5         # 16-byte Reload
	addss	%xmm2, %xmm5
	movlhps	%xmm4, %xmm5            # xmm5 = xmm5[0],xmm4[0]
	movaps	96(%rsp), %xmm2         # 16-byte Reload
	addss	%xmm1, %xmm2
	xorps	%xmm0, %xmm0
	sqrtss	%xmm7, %xmm0
	incl	%edx
	cmpl	%r8d, %edx
	shufps	$-30, %xmm4, %xmm5      # xmm5 = xmm5[2,0],xmm4[2,3]
	shufps	$48, %xmm5, %xmm2       # xmm2 = xmm2[0,0],xmm5[3,0]
	movdqa	%xmm0, %xmm1
	addss	.LCPI0_0(%rip), %xmm1
	shufps	$-124, %xmm2, %xmm5     # xmm5 = xmm5[0,1],xmm2[0,2]
	xorps	%xmm2, %xmm2
	minss	%xmm1, %xmm2
	pshufd	$0, %xmm0, %xmm0        # xmm0 = xmm0[0,0,0,0]
	movaps	112(%rsp), %xmm6        # 16-byte Reload
	movaps	%xmm6, %xmm1
	divps	%xmm0, %xmm1
	movaps	%xmm1, %xmm0
	mulps	.LCPI0_1(%rip), %xmm0
	xorps	%xmm3, %xmm3
	subss	%xmm2, %xmm3
	mulss	.LCPI0_2(%rip), %xmm3
	pshufd	$0, %xmm3, %xmm4        # xmm4 = xmm3[0,0,0,0]
	mulps	%xmm1, %xmm4
	addps	%xmm5, %xmm4
	addps	%xmm0, %xmm4
	movss	%xmm4, (%r14)
	pshufd	$1, %xmm4, %xmm0        # xmm0 = xmm4[1,0,0,0]
	movss	%xmm0, (%r11)
	movaps	%xmm4, %xmm0
	movhlps	%xmm0, %xmm0            # xmm0 = xmm0[1,1]
	movss	%xmm0, (%r10)
	je	.LBB0_12
.LBB0_8:                                # %for_loop169.lr.ph.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_9 Depth 2
	movl	%edx, %ecx
	sarl	$3, %ecx
	addl	%r9d, %ecx
	movslq	%ecx, %rcx
	leaq	(%rcx,%rcx,2), %rbx
	shlq	$6, %rbx
	addq	%rax, %rbx
	movl	%edx, %esi
	andl	$7, %esi
	xorl	%edi, %edi
	movss	(%rbx,%rsi,4), %xmm7
	movdqa	%xmm7, 64(%rsp)         # 16-byte Spill
	leaq	160(%rbx,%rsi,4), %r10
	movss	%xmm7, %xmm6
	movss	32(%rbx,%rsi,4), %xmm5
	movaps	%xmm5, %xmm1
	movlhps	%xmm6, %xmm1            # xmm1 = xmm1[0],xmm6[0]
	shufps	$-30, %xmm6, %xmm1      # xmm1 = xmm1[2,0],xmm6[2,3]
	movss	64(%rbx,%rsi,4), %xmm2
	movdqa	%xmm2, 80(%rsp)         # 16-byte Spill
	pshufd	$0, %xmm2, %xmm6        # xmm6 = xmm2[0,0,0,0]
	shufps	$48, %xmm1, %xmm2       # xmm2 = xmm2[0,0],xmm1[3,0]
	movss	160(%rbx,%rsi,4), %xmm0
	movaps	%xmm0, 96(%rsp)         # 16-byte Spill
	movss	128(%rbx,%rsi,4), %xmm0
	movaps	%xmm0, 48(%rsp)         # 16-byte Spill
	leaq	128(%rbx,%rsi,4), %r11
	leaq	96(%rbx,%rsi,4), %r14
	shufps	$-124, %xmm2, %xmm1     # xmm1 = xmm1[0,1],xmm2[0,2]
	movaps	%xmm1, 112(%rsp)        # 16-byte Spill
	pshufd	$0, %xmm5, %xmm3        # xmm3 = xmm5[0,0,0,0]
	pshufd	$0, %xmm7, %xmm1        # xmm1 = xmm7[0,0,0,0]
	movss	96(%rbx,%rsi,4), %xmm0
	movss	%xmm0, 44(%rsp)         # 4-byte Spill
	xorl	%ebx, %ebx
	xorps	%xmm12, %xmm12
	xorps	%xmm2, %xmm2
	xorps	%xmm8, %xmm8
	jmp	.LBB0_9
.LBB0_10:                               # %for_exit170.preheader
	notl	%edx
	cmpl	$-130, %edx
	movl	$-129, %r8d
	cmovgl	%edx, %r8d
	notl	%r8d
	xorl	%edx, %edx
	xorps	%xmm0, %xmm0
	movss	.LCPI0_0(%rip), %xmm8
	movaps	.LCPI0_1(%rip), %xmm9
	movss	.LCPI0_2(%rip), %xmm3
	.align	16, 0x90
.LBB0_11:                               # %for_exit170
                                        # =>This Inner Loop Header: Depth=1
	movl	%edx, %ecx
	sarl	$3, %ecx
	addl	%r9d, %ecx
	movslq	%ecx, %rcx
	leaq	(%rcx,%rcx,2), %rsi
	shlq	$6, %rsi
	addq	%rax, %rsi
	movl	%edx, %ecx
	andl	$7, %ecx
	movss	32(%rsi,%rcx,4), %xmm4
	incl	%edx
	movss	(%rsi,%rcx,4), %xmm7
	movss	%xmm7, %xmm6
	movaps	%xmm4, %xmm1
	mulss	%xmm1, %xmm1
	mulss	%xmm7, %xmm7
	cmpl	%edx, %r8d
	addss	%xmm1, %xmm7
	movss	64(%rsi,%rcx,4), %xmm2
	movaps	%xmm2, %xmm1
	mulss	%xmm1, %xmm1
	addss	%xmm7, %xmm1
	xorps	%xmm7, %xmm7
	sqrtss	%xmm1, %xmm7
	movlhps	%xmm6, %xmm4            # xmm4 = xmm4[0],xmm6[0]
	shufps	$-30, %xmm6, %xmm4      # xmm4 = xmm4[2,0],xmm6[2,3]
	shufps	$48, %xmm4, %xmm2       # xmm2 = xmm2[0,0],xmm4[3,0]
	movss	96(%rsi,%rcx,4), %xmm6
	addss	%xmm0, %xmm6
	shufps	$-124, %xmm2, %xmm4     # xmm4 = xmm4[0,1],xmm2[0,2]
	movss	%xmm6, %xmm5
	movss	128(%rsi,%rcx,4), %xmm6
	addss	%xmm0, %xmm6
	movlhps	%xmm5, %xmm6            # xmm6 = xmm6[0],xmm5[0]
	shufps	$-30, %xmm5, %xmm6      # xmm6 = xmm6[2,0],xmm5[2,3]
	movss	160(%rsi,%rcx,4), %xmm1
	addss	%xmm0, %xmm1
	shufps	$48, %xmm6, %xmm1       # xmm1 = xmm1[0,0],xmm6[3,0]
	shufps	$-124, %xmm1, %xmm6     # xmm6 = xmm6[0,1],xmm1[0,2]
	pshufd	$0, %xmm7, %xmm2        # xmm2 = xmm7[0,0,0,0]
	movaps	%xmm4, %xmm1
	divps	%xmm2, %xmm1
	addss	%xmm8, %xmm7
	xorps	%xmm5, %xmm5
	minss	%xmm7, %xmm5
	movaps	%xmm1, %xmm7
	mulps	%xmm9, %xmm7
	xorps	%xmm2, %xmm2
	subss	%xmm5, %xmm2
	mulss	%xmm3, %xmm2
	pshufd	$0, %xmm2, %xmm5        # xmm5 = xmm2[0,0,0,0]
	mulps	%xmm1, %xmm5
	addps	%xmm6, %xmm5
	addps	%xmm7, %xmm5
	movss	%xmm5, 96(%rsi,%rcx,4)
	pshufd	$1, %xmm5, %xmm1        # xmm1 = xmm5[1,0,0,0]
	movss	%xmm1, 128(%rsi,%rcx,4)
	movaps	%xmm5, %xmm1
	movhlps	%xmm1, %xmm1            # xmm1 = xmm1[1,1]
	movss	%xmm1, 160(%rsi,%rcx,4)
	movaps	%xmm4, %xmm6
	jne	.LBB0_11
.LBB0_12:                               # %for_exit
	movaps	272(%rsp), %xmm6        # 16-byte Reload
	movaps	256(%rsp), %xmm7        # 16-byte Reload
	movaps	240(%rsp), %xmm8        # 16-byte Reload
	movaps	224(%rsp), %xmm9        # 16-byte Reload
	movaps	208(%rsp), %xmm10       # 16-byte Reload
	movaps	192(%rsp), %xmm11       # 16-byte Reload
	movaps	176(%rsp), %xmm12       # 16-byte Reload
	movaps	160(%rsp), %xmm13       # 16-byte Reload
	movaps	144(%rsp), %xmm14       # 16-byte Reload
	movaps	128(%rsp), %xmm15       # 16-byte Reload
	addq	$288, %rsp              # imm = 0x120
	popq	%rbx
	popq	%rbp
	popq	%rdi
	popq	%rsi
	popq	%r14
	ret
.LBB0_13:                               # %some_on
	movl	%ebp, %edx
	subl	%r9d, %edx
	testl	%edx, %edx
	jle	.LBB0_12
# BB#14:                                # %for_loop491.lr.ph
	sarl	$3, %r9d
	xorps	%xmm0, %xmm0
	cmpl	$129, %edx
	movl	$128, %r8d
	cmovll	%edx, %r8d
	testl	%ebp, %ebp
	jle	.LBB0_21
# BB#15:
	movdqa	112(%rsp), %xmm1        # 16-byte Reload
	pcmpeqd	%xmm0, %xmm1
	pcmpeqd	%xmm0, %xmm0
	pxor	%xmm1, %xmm0
	movdqa	%xmm0, (%rsp)           # 16-byte Spill
	xorl	%edx, %edx
	jmp	.LBB0_19
	.align	16, 0x90
.LBB0_20:                               # %for_loop654.us
                                        #   Parent Loop BB0_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	%edi, %esi
	andl	$16, %esi
	movl	%ebx, %ecx
	sarl	$3, %ecx
	imull	$192, %ecx, %ecx
	movslq	%ecx, %rcx
	orq	%rsi, %rcx
	movups	(%rax,%rcx), %xmm11
	movups	32(%rax,%rcx), %xmm12
	movups	64(%rax,%rcx), %xmm13
	subps	%xmm8, %xmm12
	movaps	%xmm12, %xmm2
	mulps	%xmm2, %xmm2
	subps	%xmm9, %xmm11
	movaps	%xmm11, %xmm1
	mulps	%xmm1, %xmm1
	addps	%xmm2, %xmm1
	subps	%xmm5, %xmm13
	movaps	%xmm13, %xmm2
	mulps	%xmm2, %xmm2
	addps	%xmm1, %xmm2
	sqrtps	%xmm2, %xmm15
	xorps	%xmm2, %xmm2
	cmpltps	%xmm15, %xmm2
	andps	112(%rsp), %xmm2        # 16-byte Folded Reload
	movmskps	%xmm2, %ecx
	testl	%ecx, %ecx
	je	.LBB0_17
# BB#16:                                # %safe_if_run_true.i1227.us
                                        #   in Loop: Header=BB0_20 Depth=2
	divps	%xmm15, %xmm13
	movaps	.LCPI0_3(%rip), %xmm3
	addps	%xmm15, %xmm3
	xorps	%xmm1, %xmm1
	minps	%xmm3, %xmm1
	mulps	.LCPI0_4(%rip), %xmm1
	mulps	%xmm1, %xmm13
	divps	%xmm15, %xmm12
	mulps	%xmm1, %xmm12
	addps	%xmm0, %xmm12
	andps	%xmm2, %xmm12
	addps	%xmm10, %xmm13
	andps	%xmm2, %xmm13
	movaps	%xmm2, %xmm3
	andnps	%xmm0, %xmm3
	movaps	%xmm2, %xmm0
	andnps	%xmm10, %xmm0
	orps	%xmm13, %xmm0
	orps	%xmm12, %xmm3
	divps	%xmm15, %xmm11
	mulps	%xmm1, %xmm11
	addps	%xmm14, %xmm11
	andps	%xmm2, %xmm11
	andnps	%xmm14, %xmm2
	orps	%xmm11, %xmm2
	movaps	%xmm0, %xmm10
	movaps	%xmm3, %xmm0
	movaps	%xmm2, %xmm14
.LBB0_17:                               # %ComputeParticleInteraction___vyf<3>vyf<3>REFvyf<3>.exit1228.us
                                        #   in Loop: Header=BB0_20 Depth=2
	addl	$16, %edi
	addl	$4, %ebx
	cmpl	%ebp, %ebx
	jl	.LBB0_20
# BB#18:                                # %for_exit655.us
                                        #   in Loop: Header=BB0_19 Depth=1
	movaps	(%rsp), %xmm4           # 16-byte Reload
	andps	%xmm4, %xmm10
	movaps	%xmm10, %xmm2
	movhlps	%xmm2, %xmm2            # xmm2 = xmm2[1,1]
	addps	%xmm10, %xmm2
	andps	%xmm4, %xmm14
	movaps	%xmm14, %xmm3
	movhlps	%xmm3, %xmm3            # xmm3 = xmm3[1,1]
	addps	%xmm14, %xmm3
	pshufd	$1, %xmm3, %xmm1        # xmm1 = xmm3[1,0,0,0]
	pshufd	$1, %xmm2, %xmm8        # xmm8 = xmm2[1,0,0,0]
	movaps	16(%rsp), %xmm5         # 16-byte Reload
	mulss	%xmm5, %xmm5
	mulss	%xmm7, %xmm7
	addss	%xmm5, %xmm7
	movaps	64(%rsp), %xmm5         # 16-byte Reload
	mulss	%xmm5, %xmm5
	addss	%xmm7, %xmm5
	andps	%xmm4, %xmm0
	addss	%xmm3, %xmm1
	movaps	%xmm0, %xmm3
	movhlps	%xmm3, %xmm3            # xmm3 = xmm3[1,1]
	addss	%xmm2, %xmm8
	addps	%xmm0, %xmm3
	incl	%edx
	movss	44(%rsp), %xmm0         # 4-byte Reload
	addss	%xmm1, %xmm0
	movss	%xmm0, %xmm6
	xorps	%xmm0, %xmm0
	sqrtss	%xmm5, %xmm0
	movaps	80(%rsp), %xmm2         # 16-byte Reload
	addss	%xmm8, %xmm2
	pshufd	$1, %xmm3, %xmm1        # xmm1 = xmm3[1,0,0,0]
	addss	%xmm3, %xmm1
	movaps	48(%rsp), %xmm5         # 16-byte Reload
	addss	%xmm1, %xmm5
	cmpl	%r8d, %edx
	movlhps	%xmm6, %xmm5            # xmm5 = xmm5[0],xmm6[0]
	shufps	$-30, %xmm6, %xmm5      # xmm5 = xmm5[2,0],xmm6[2,3]
	shufps	$48, %xmm5, %xmm2       # xmm2 = xmm2[0,0],xmm5[3,0]
	movdqa	%xmm0, %xmm1
	addss	.LCPI0_0(%rip), %xmm1
	shufps	$-124, %xmm2, %xmm5     # xmm5 = xmm5[0,1],xmm2[0,2]
	xorps	%xmm2, %xmm2
	minss	%xmm1, %xmm2
	pshufd	$0, %xmm0, %xmm0        # xmm0 = xmm0[0,0,0,0]
	movaps	96(%rsp), %xmm4         # 16-byte Reload
	movaps	%xmm4, %xmm1
	divps	%xmm0, %xmm1
	movaps	%xmm1, %xmm0
	mulps	.LCPI0_1(%rip), %xmm0
	xorps	%xmm3, %xmm3
	subss	%xmm2, %xmm3
	mulss	.LCPI0_2(%rip), %xmm3
	pshufd	$0, %xmm3, %xmm6        # xmm6 = xmm3[0,0,0,0]
	mulps	%xmm1, %xmm6
	addps	%xmm5, %xmm6
	addps	%xmm0, %xmm6
	movss	%xmm6, (%r14)
	pshufd	$1, %xmm6, %xmm0        # xmm0 = xmm6[1,0,0,0]
	movss	%xmm0, (%r11)
	movaps	%xmm6, %xmm0
	movhlps	%xmm0, %xmm0            # xmm0 = xmm0[1,1]
	movss	%xmm0, (%r10)
	je	.LBB0_12
.LBB0_19:                               # %for_loop654.lr.ph.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_20 Depth 2
	movl	%edx, %ecx
	sarl	$3, %ecx
	addl	%r9d, %ecx
	movslq	%ecx, %rcx
	leaq	(%rcx,%rcx,2), %rbx
	shlq	$6, %rbx
	addq	%rax, %rbx
	movl	%edx, %esi
	andl	$7, %esi
	xorps	%xmm14, %xmm14
	xorl	%edi, %edi
	movss	(%rbx,%rsi,4), %xmm7
	leaq	160(%rbx,%rsi,4), %r10
	movss	%xmm7, %xmm4
	movss	32(%rbx,%rsi,4), %xmm3
	movaps	%xmm3, 16(%rsp)         # 16-byte Spill
	movaps	%xmm3, %xmm0
	movlhps	%xmm4, %xmm0            # xmm0 = xmm0[0],xmm4[0]
	shufps	$-30, %xmm4, %xmm0      # xmm0 = xmm0[2,0],xmm4[2,3]
	movss	64(%rbx,%rsi,4), %xmm1
	movdqa	%xmm1, 64(%rsp)         # 16-byte Spill
	pshufd	$0, %xmm1, %xmm5        # xmm5 = xmm1[0,0,0,0]
	shufps	$48, %xmm0, %xmm1       # xmm1 = xmm1[0,0],xmm0[3,0]
	movss	160(%rbx,%rsi,4), %xmm2
	movaps	%xmm2, 80(%rsp)         # 16-byte Spill
	movss	128(%rbx,%rsi,4), %xmm2
	movaps	%xmm2, 48(%rsp)         # 16-byte Spill
	leaq	128(%rbx,%rsi,4), %r11
	leaq	96(%rbx,%rsi,4), %r14
	shufps	$-124, %xmm1, %xmm0     # xmm0 = xmm0[0,1],xmm1[0,2]
	movaps	%xmm0, 96(%rsp)         # 16-byte Spill
	pshufd	$0, %xmm3, %xmm8        # xmm8 = xmm3[0,0,0,0]
	pshufd	$0, %xmm7, %xmm9        # xmm9 = xmm7[0,0,0,0]
	movss	96(%rbx,%rsi,4), %xmm0
	movss	%xmm0, 44(%rsp)         # 4-byte Spill
	xorl	%ebx, %ebx
	xorps	%xmm0, %xmm0
	xorps	%xmm10, %xmm10
	jmp	.LBB0_20
.LBB0_21:                               # %for_exit655.preheader
	notl	%edx
	cmpl	$-130, %edx
	movl	$-129, %r8d
	cmovgl	%edx, %r8d
	notl	%r8d
	xorl	%edx, %edx
	xorps	%xmm0, %xmm0
	movss	.LCPI0_0(%rip), %xmm8
	movaps	.LCPI0_1(%rip), %xmm9
	movss	.LCPI0_2(%rip), %xmm3
	.align	16, 0x90
.LBB0_22:                               # %for_exit655
                                        # =>This Inner Loop Header: Depth=1
	movl	%edx, %ecx
	sarl	$3, %ecx
	addl	%r9d, %ecx
	movslq	%ecx, %rcx
	leaq	(%rcx,%rcx,2), %rsi
	shlq	$6, %rsi
	addq	%rax, %rsi
	movl	%edx, %ecx
	andl	$7, %ecx
	movss	32(%rsi,%rcx,4), %xmm4
	incl	%edx
	movss	(%rsi,%rcx,4), %xmm7
	movss	%xmm7, %xmm6
	movaps	%xmm4, %xmm1
	mulss	%xmm1, %xmm1
	mulss	%xmm7, %xmm7
	cmpl	%edx, %r8d
	addss	%xmm1, %xmm7
	movss	64(%rsi,%rcx,4), %xmm2
	movaps	%xmm2, %xmm1
	mulss	%xmm1, %xmm1
	addss	%xmm7, %xmm1
	xorps	%xmm7, %xmm7
	sqrtss	%xmm1, %xmm7
	movlhps	%xmm6, %xmm4            # xmm4 = xmm4[0],xmm6[0]
	shufps	$-30, %xmm6, %xmm4      # xmm4 = xmm4[2,0],xmm6[2,3]
	shufps	$48, %xmm4, %xmm2       # xmm2 = xmm2[0,0],xmm4[3,0]
	movss	96(%rsi,%rcx,4), %xmm6
	addss	%xmm0, %xmm6
	shufps	$-124, %xmm2, %xmm4     # xmm4 = xmm4[0,1],xmm2[0,2]
	movss	%xmm6, %xmm5
	movss	128(%rsi,%rcx,4), %xmm6
	addss	%xmm0, %xmm6
	movlhps	%xmm5, %xmm6            # xmm6 = xmm6[0],xmm5[0]
	shufps	$-30, %xmm5, %xmm6      # xmm6 = xmm6[2,0],xmm5[2,3]
	movss	160(%rsi,%rcx,4), %xmm1
	addss	%xmm0, %xmm1
	shufps	$48, %xmm6, %xmm1       # xmm1 = xmm1[0,0],xmm6[3,0]
	shufps	$-124, %xmm1, %xmm6     # xmm6 = xmm6[0,1],xmm1[0,2]
	pshufd	$0, %xmm7, %xmm2        # xmm2 = xmm7[0,0,0,0]
	movaps	%xmm4, %xmm1
	divps	%xmm2, %xmm1
	addss	%xmm8, %xmm7
	xorps	%xmm5, %xmm5
	minss	%xmm7, %xmm5
	movaps	%xmm1, %xmm7
	mulps	%xmm9, %xmm7
	xorps	%xmm2, %xmm2
	subss	%xmm5, %xmm2
	mulss	%xmm3, %xmm2
	pshufd	$0, %xmm2, %xmm5        # xmm5 = xmm2[0,0,0,0]
	mulps	%xmm1, %xmm5
	addps	%xmm6, %xmm5
	addps	%xmm7, %xmm5
	movss	%xmm5, 96(%rsi,%rcx,4)
	pshufd	$1, %xmm5, %xmm1        # xmm1 = xmm5[1,0,0,0]
	movss	%xmm1, 128(%rsi,%rcx,4)
	movaps	%xmm5, %xmm1
	movhlps	%xmm1, %xmm1            # xmm1 = xmm1[1,1]
	movss	%xmm1, 160(%rsi,%rcx,4)
	movaps	%xmm4, %xmm6
	jne	.LBB0_22
	jmp	.LBB0_12

	.def	 "Integrate___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>";
	.scl	2;
	.type	32;
	.endef
	.globl	"Integrate___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>"
	.align	16, 0x90
"Integrate___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>": # @"Integrate___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>"
# BB#0:                                 # %allocas
	pushq	%r14
	pushq	%rsi
	pushq	%rdi
	pushq	%rbp
	pushq	%rbx
	subq	$48, %rsp
	movups	16(%rcx), %xmm0
	movmskps	%xmm0, %eax
	testl	%eax, %eax
	je	.LBB1_5
# BB#1:                                 # %allocas
	movq	8(%rcx), %rdx
	movl	(%rcx), %ecx
	shll	$7, %r9d
	subl	%r9d, %ecx
	cmpl	$15, %eax
	jne	.LBB1_6
# BB#2:                                 # %all_on
	cmpl	$128, %ecx
	movl	$128, %r8d
	cmovlel	%ecx, %r8d
	testl	%r8d, %r8d
	jle	.LBB1_5
# BB#3:                                 # %for_loop.lr.ph
	sarl	$3, %r9d
	movslq	%r9d, %rax
	leaq	(%rax,%rax,2), %rax
	shlq	$6, %rax
	addq	%rax, %rdx
	xorl	%ecx, %ecx
	xorl	%esi, %esi
	.align	16, 0x90
.LBB1_4:                                # %for_loop
                                        # =>This Inner Loop Header: Depth=1
	movl	%ecx, %edi
	andl	$16, %edi
	movl	%esi, %eax
	sarl	$3, %eax
	imull	$192, %eax, %eax
	movslq	%eax, %rbx
	orq	%rdi, %rbx
	movups	160(%rdx,%rbx), %xmm1
	movups	128(%rdx,%rbx), %xmm2
	movups	(%rdx,%rbx), %xmm4
	movups	32(%rdx,%rbx), %xmm3
	movups	64(%rdx,%rbx), %xmm0
	movups	96(%rdx,%rbx), %xmm5
	addps	%xmm4, %xmm5
	movups	%xmm5, (%rdx,%rbx)
	addps	%xmm2, %xmm3
	movups	%xmm3, 32(%rdx,%rbx)
	addps	%xmm1, %xmm0
	addl	$16, %ecx
	addl	$4, %esi
	cmpl	%r8d, %esi
	movups	%xmm0, 64(%rdx,%rbx)
	jl	.LBB1_4
.LBB1_5:                                # %for_exit
	addq	$48, %rsp
	popq	%rbx
	popq	%rbp
	popq	%rdi
	popq	%rsi
	popq	%r14
	ret
.LBB1_6:                                # %some_on
	cmpl	$128, %ecx
	movl	$128, %r10d
	cmovlel	%ecx, %r10d
	testl	%r10d, %r10d
	jle	.LBB1_5
# BB#7:                                 # %for_loop526.lr.ph
	sarl	$3, %r9d
	movslq	%r9d, %rcx
	leaq	(%rcx,%rcx,2), %r9
	shlq	$6, %r9
	leaq	64(%rdx,%r9), %r8
	addq	%rdx, %r9
	xorl	%r11d, %r11d
	.align	16, 0x90
.LBB1_8:                                # %for_loop526
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_17 Depth 2
                                        #     Child Loop BB1_13 Depth 2
                                        #     Child Loop BB1_9 Depth 2
	leal	(,%r11,4), %ecx
	andl	$16, %ecx
	movl	%r11d, %edx
	sarl	$3, %edx
	imull	$192, %edx, %edx
	movslq	%edx, %rdx
	orq	%rcx, %rdx
	movups	160(%r9,%rdx), %xmm1
	movups	(%r9,%rdx), %xmm4
	movups	32(%r9,%rdx), %xmm3
	movups	64(%r9,%rdx), %xmm0
	movups	96(%r9,%rdx), %xmm2
	addps	%xmm1, %xmm0
	leaq	(%r9,%rdx), %rsi
	movups	128(%r9,%rdx), %xmm1
	addps	%xmm4, %xmm2
	movl	$1, %edi
	addps	%xmm3, %xmm1
	leaq	32(%rdx), %r14
	xorl	%ebx, %ebx
	.align	16, 0x90
.LBB1_9:                                # %pl_loop.i1662
                                        #   Parent Loop BB1_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	%edi, %ebp
	andl	%eax, %ebp
	cmpl	%edi, %ebp
	jne	.LBB1_11
# BB#10:                                # %pl_dolane.i1665
                                        #   in Loop: Header=BB1_9 Depth=2
	movaps	%xmm2, 32(%rsp)
	movl	%ebx, %ecx
	movl	32(%rsp,%rcx,4), %ecx
	movl	%ecx, (%rsi,%rbx,4)
.LBB1_11:                               # %pl_loopend.i1669
                                        #   in Loop: Header=BB1_9 Depth=2
	addl	%edi, %edi
	incq	%rbx
	cmpl	$4, %ebx
	jne	.LBB1_9
# BB#12:                                # %__masked_store_32.exit1670
                                        #   in Loop: Header=BB1_8 Depth=1
	addq	%r9, %r14
	movl	$1, %esi
	xorl	%edi, %edi
	.align	16, 0x90
.LBB1_13:                               # %pl_loop.i1633
                                        #   Parent Loop BB1_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	%esi, %ebx
	andl	%eax, %ebx
	cmpl	%esi, %ebx
	jne	.LBB1_15
# BB#14:                                # %pl_dolane.i1636
                                        #   in Loop: Header=BB1_13 Depth=2
	movaps	%xmm1, 16(%rsp)
	movl	%edi, %ecx
	movl	16(%rsp,%rcx,4), %ecx
	movl	%ecx, (%r14,%rdi,4)
.LBB1_15:                               # %pl_loopend.i1640
                                        #   in Loop: Header=BB1_13 Depth=2
	addl	%esi, %esi
	incq	%rdi
	cmpl	$4, %edi
	jne	.LBB1_13
# BB#16:                                # %__masked_store_32.exit1641
                                        #   in Loop: Header=BB1_8 Depth=1
	addq	%r8, %rdx
	movl	$1, %ecx
	xorl	%esi, %esi
	.align	16, 0x90
.LBB1_17:                               # %pl_loop.i
                                        #   Parent Loop BB1_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	%ecx, %edi
	andl	%eax, %edi
	cmpl	%ecx, %edi
	jne	.LBB1_19
# BB#18:                                # %pl_dolane.i
                                        #   in Loop: Header=BB1_17 Depth=2
	movaps	%xmm0, (%rsp)
	movl	%esi, %edi
	movl	(%rsp,%rdi,4), %edi
	movl	%edi, (%rdx,%rsi,4)
.LBB1_19:                               # %pl_loopend.i
                                        #   in Loop: Header=BB1_17 Depth=2
	addl	%ecx, %ecx
	incq	%rsi
	cmpl	$4, %esi
	jne	.LBB1_17
# BB#20:                                # %__masked_store_32.exit
                                        #   in Loop: Header=BB1_8 Depth=1
	addl	$4, %r11d
	cmpl	%r10d, %r11d
	jge	.LBB1_5
	jmp	.LBB1_8

	.def	 "sphUpdate___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>";
	.scl	2;
	.type	32;
	.endef
	.globl	"sphUpdate___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>"
	.align	16, 0x90
"sphUpdate___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>": # @"sphUpdate___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>"
# BB#0:                                 # %allocas
	pushq	%r15
	pushq	%r14
	pushq	%rsi
	pushq	%rdi
	pushq	%rbx
	subq	$64, %rsp
	movaps	%xmm6, 48(%rsp)         # 16-byte Spill
	movq	%rdx, %r15
	movl	%ecx, %edi
	movq	$0, 40(%rsp)
	movaps	(%r8), %xmm6
	movmskps	%xmm6, %eax
	testl	%eax, %eax
	je	.LBB2_7
# BB#1:                                 # %allocas
	leaq	40(%rsp), %r14
	movq	%r14, %rcx
	movl	$32, %edx
	movl	$16, %r8d
	cmpl	$15, %eax
	jne	.LBB2_8
# BB#2:                                 # %all_on.i102
	callq	ISPCAlloc
	movl	%edi, (%rax)
	movq	%r15, 8(%rax)
	movl	%edi, %ecx
	sarl	$31, %ecx
	shrl	$25, %ecx
	addl	%edi, %ecx
	pcmpeqd	%xmm6, %xmm6
.LBB2_3:                                # %all_on.i102
	movdqu	%xmm6, 16(%rax)
	movl	%ecx, %r8d
	sarl	$7, %r8d
	andl	$-128, %ecx
	movl	%edi, %esi
	subl	%ecx, %esi
	leaq	"UpdateVelocity___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>"(%rip), %rdx
	testl	%esi, %esi
	setg	%cl
	movzbl	%cl, %ebx
	addl	%r8d, %ebx
	movq	%r14, %rcx
	movq	%rax, %r8
	movl	%ebx, %r9d
	callq	ISPCLaunch
	movq	40(%rsp), %rcx
	testq	%rcx, %rcx
	je	.LBB2_5
# BB#4:                                 # %call_sync
	callq	ISPCSync
	movq	$0, 40(%rsp)
.LBB2_5:                                # %post_sync
	leaq	40(%rsp), %rsi
	movq	%rsi, %rcx
	movl	$32, %edx
	movl	$16, %r8d
	callq	ISPCAlloc
	movl	%edi, (%rax)
	movq	%r15, 8(%rax)
	movdqu	%xmm6, 16(%rax)
	leaq	"Integrate___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>"(%rip), %rdx
	movq	%rsi, %rcx
	movq	%rax, %r8
	movl	%ebx, %r9d
	callq	ISPCLaunch
	movq	40(%rsp), %rcx
	testq	%rcx, %rcx
	je	.LBB2_7
# BB#6:                                 # %call_sync34
	callq	ISPCSync
	movq	$0, 40(%rsp)
.LBB2_7:                                # %post_sync39
	movaps	48(%rsp), %xmm6         # 16-byte Reload
	addq	$64, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r14
	popq	%r15
	ret
.LBB2_8:                                # %some_on.i
	callq	ISPCAlloc
	movl	%edi, (%rax)
	movq	%r15, 8(%rax)
	movl	%edi, %ecx
	sarl	$31, %ecx
	shrl	$25, %ecx
	addl	%edi, %ecx
	jmp	.LBB2_3

	.def	 sphUpdate;
	.scl	2;
	.type	32;
	.endef
	.globl	sphUpdate
	.align	16, 0x90
sphUpdate:                              # @sphUpdate
# BB#0:                                 # %allocas
	pushq	%r15
	pushq	%r14
	pushq	%rsi
	pushq	%rdi
	pushq	%rbx
	subq	$64, %rsp
	movaps	%xmm6, 48(%rsp)         # 16-byte Spill
	movq	%rdx, %r15
	movl	%ecx, %edi
	movq	$0, 40(%rsp)
	leaq	40(%rsp), %r14
	movq	%r14, %rcx
	movl	$32, %edx
	movl	$16, %r8d
	callq	ISPCAlloc
	movl	%edi, (%rax)
	movq	%r15, 8(%rax)
	movl	%edi, %ecx
	sarl	$31, %ecx
	shrl	$25, %ecx
	addl	%edi, %ecx
	pcmpeqd	%xmm6, %xmm6
	movdqu	%xmm6, 16(%rax)
	movl	%ecx, %r8d
	sarl	$7, %r8d
	andl	$-128, %ecx
	movl	%edi, %esi
	subl	%ecx, %esi
	leaq	"UpdateVelocity___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>"(%rip), %rdx
	testl	%esi, %esi
	setg	%cl
	movzbl	%cl, %ebx
	addl	%r8d, %ebx
	movq	%r14, %rcx
	movq	%rax, %r8
	movl	%ebx, %r9d
	callq	ISPCLaunch
	movq	40(%rsp), %rcx
	testq	%rcx, %rcx
	je	.LBB3_2
# BB#1:                                 # %call_sync
	callq	ISPCSync
	movq	$0, 40(%rsp)
.LBB3_2:                                # %post_sync
	leaq	40(%rsp), %rsi
	movq	%rsi, %rcx
	movl	$32, %edx
	movl	$16, %r8d
	callq	ISPCAlloc
	movl	%edi, (%rax)
	movq	%r15, 8(%rax)
	movdqu	%xmm6, 16(%rax)
	leaq	"Integrate___uniun<s[soa<8>Particle]<soa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>fsoa<8>f>>"(%rip), %rdx
	movq	%rsi, %rcx
	movq	%rax, %r8
	movl	%ebx, %r9d
	callq	ISPCLaunch
	movq	40(%rsp), %rcx
	testq	%rcx, %rcx
	je	.LBB3_4
# BB#3:                                 # %call_sync34
	callq	ISPCSync
	movq	$0, 40(%rsp)
.LBB3_4:                                # %post_sync39
	movaps	48(%rsp), %xmm6         # 16-byte Reload
	addq	$64, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r14
	popq	%r15
	ret

	.data
	.globl	SPH_FLUID_BLOCK_SIZE    # @SPH_FLUID_BLOCK_SIZE
	.align	4
SPH_FLUID_BLOCK_SIZE:
	.long	128                     # 0x80


