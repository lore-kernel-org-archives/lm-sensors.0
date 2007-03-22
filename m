From: nicolas@boichat.ch (Nicolas Boichat)
Date: Thu, 22 Mar 2007 10:07:59 +0000
Subject: [lm-sensors] [PATCH] coretemp 1/3 Add rdmsr_safe_on_cpu and
Message-Id: <4602557F.3020402@boichat.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <4600653F.8040000@assembler.cz>
In-Reply-To: <4600653F.8040000@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Hello,
>
> I will spin the new patches here, in this thread. However I dont know
> whom to address this patch - after it is well tested. Maybe I will
> convert the msr.c driver for this new calls too.
I did this conversion, both patches (coretemp 1/3 and the one below)
should go upstream together.

According to MAINTAINERS, you should cc (for this patch, and maybe the
other one too):
CPUID/MSR DRIVER
P:    H. Peter Anvin
M:    hpa at zytor.com
S:    Maintained

You might also want to cc all these people:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=B077ffb3b767c3efb44d00b998385a9cb127255c

Best regards,

Nicolas


Use safe functions provided by arch/*/lib/msr-on-cpu.c in arch/i386/kernel/=
msr.c.

Signed-off-by: Nicolas Boichat <nicolas at boichat.ch>


---

 arch/i386/kernel/msr.c |  106 ++------------------------------------------=
----
 1 files changed, 4 insertions(+), 102 deletions(-)

diff --git a/arch/i386/kernel/msr.c b/arch/i386/kernel/msr.c
index bcaa6e9..8cd0a91 100644
--- a/arch/i386/kernel/msr.c
+++ b/arch/i386/kernel/msr.c
@@ -45,104 +45,6 @@
=20
 static struct class *msr_class;
=20
-static inline int wrmsr_eio(u32 reg, u32 eax, u32 edx)
-{
-	int err;
-
-	err =3D wrmsr_safe(reg, eax, edx);
-	if (err)
-		err =3D -EIO;
-	return err;
-}
-
-static inline int rdmsr_eio(u32 reg, u32 *eax, u32 *edx)
-{
-	int err;
-
-	err =3D rdmsr_safe(reg, eax, edx);
-	if (err)
-		err =3D -EIO;
-	return err;
-}
-
-#ifdef CONFIG_SMP
-
-struct msr_command {
-	int err;
-	u32 reg;
-	u32 data[2];
-};
-
-static void msr_smp_wrmsr(void *cmd_block)
-{
-	struct msr_command *cmd =3D (struct msr_command *)cmd_block;
-
-	cmd->err =3D wrmsr_eio(cmd->reg, cmd->data[0], cmd->data[1]);
-}
-
-static void msr_smp_rdmsr(void *cmd_block)
-{
-	struct msr_command *cmd =3D (struct msr_command *)cmd_block;
-
-	cmd->err =3D rdmsr_eio(cmd->reg, &cmd->data[0], &cmd->data[1]);
-}
-
-static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
-{
-	struct msr_command cmd;
-	int ret;
-
-	preempt_disable();
-	if (cpu =3D smp_processor_id()) {
-		ret =3D wrmsr_eio(reg, eax, edx);
-	} else {
-		cmd.reg =3D reg;
-		cmd.data[0] =3D eax;
-		cmd.data[1] =3D edx;
-
-		smp_call_function_single(cpu, msr_smp_wrmsr, &cmd, 1, 1);
-		ret =3D cmd.err;
-	}
-	preempt_enable();
-	return ret;
-}
-
-static inline int do_rdmsr(int cpu, u32 reg, u32 * eax, u32 * edx)
-{
-	struct msr_command cmd;
-	int ret;
-
-	preempt_disable();
-	if (cpu =3D smp_processor_id()) {
-		ret =3D rdmsr_eio(reg, eax, edx);
-	} else {
-		cmd.reg =3D reg;
-
-		smp_call_function_single(cpu, msr_smp_rdmsr, &cmd, 1, 1);
-
-		*eax =3D cmd.data[0];
-		*edx =3D cmd.data[1];
-
-		ret =3D cmd.err;
-	}
-	preempt_enable();
-	return ret;
-}
-
-#else				/* ! CONFIG_SMP */
-
-static inline int do_wrmsr(int cpu, u32 reg, u32 eax, u32 edx)
-{
-	return wrmsr_eio(reg, eax, edx);
-}
-
-static inline int do_rdmsr(int cpu, u32 reg, u32 *eax, u32 *edx)
-{
-	return rdmsr_eio(reg, eax, edx);
-}
-
-#endif				/* ! CONFIG_SMP */
-
 static loff_t msr_seek(struct file *file, loff_t offset, int orig)
 {
 	loff_t ret =3D -EINVAL;
@@ -174,9 +76,9 @@ static ssize_t msr_read(struct file *file, char __user *=
 buf,
 		return -EINVAL;	/* Invalid chunk size */
=20
 	for (; count; count -=3D 8) {
-		err =3D do_rdmsr(cpu, reg, &data[0], &data[1]);
+		err =3D rdmsr_safe_on_cpu(cpu, reg, &data[0], &data[1]);
 		if (err)
-			return err;
+			return -EIO;
 		if (copy_to_user(tmp, &data, 8))
 			return -EFAULT;
 		tmp +=3D 2;
@@ -200,9 +102,9 @@ static ssize_t msr_write(struct file *file, const char =
__user *buf,
 	for (; count; count -=3D 8) {
 		if (copy_from_user(&data, tmp, 8))
 			return -EFAULT;
-		err =3D do_wrmsr(cpu, reg, data[0], data[1]);
+		err =3D wrmsr_safe_on_cpu(cpu, reg, data[0], data[1]);
 		if (err)
-			return err;
+			return -EIO;
 		tmp +=3D 2;
 	}
=20



