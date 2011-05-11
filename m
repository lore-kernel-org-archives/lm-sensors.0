From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 11 May 2011 13:48:59 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110511134859.GA24405@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 11, 2011 at 02:43:35PM +0200, Luca Tettamanti wrote:
> Jeff's CPU does indeed lack lahf (see cpuinfo), so the driver should not
> unconditionally use the intruction.
> The driver should check X86_FEATURE_LAHF_LM or use use a different
> method to read EFLAFS (pushf?).

The driver uses lahf to copy the lowest byte of EFLAGS to eax, then
shifts it to right and test the lowest bit (CF).
Using pushf instead we get the whole EFLAGS and test the lowest bit.
Does it make sense? Someone should double check the patch, I don't trust
my assembly skills ;)

diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
index d72433f..3554d10 100644
--- a/drivers/char/i8k.c
+++ b/drivers/char/i8k.c
@@ -139,8 +139,8 @@ static int i8k_smm(struct smm_regs *regs)
 		"movl %%edi,20(%%rax)\n\t"
 		"popq %%rdx\n\t"
 		"movl %%edx,0(%%rax)\n\t"
-		"lahf\n\t"
-		"shrl $8,%%eax\n\t"
+		"pusfh\n\t"
+		"popl %%eax\n\t"
 		"andl $1,%%eax\n"
 		:"=a"(rc)
 		:    "a"(regs)


Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
