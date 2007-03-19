From: nicolas@boichat.ch (Nicolas Boichat)
Date: Mon, 19 Mar 2007 03:58:51 +0000
Subject: [lm-sensors] coretemp - take3
Message-Id: <45FE0A7B.3030000@boichat.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <45FDC7A4.9070601@assembler.cz>
In-Reply-To: <45FDC7A4.9070601@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Rudolf Marek wrote:
> Hello all,
>
> I'm CCing all interested parties, if some isn't please tell!
>
> On URL bellow is current version of coretemp driver.
>
> http://ssh.cz/~ruik/patches/
>
> I do not own this CPU (happy user of overclocked Opteron ;) So it would be great
> if someone can give it testing.  We need to test:
>
> CONFIG_SMP y/n
> CONFIG_CPU_HOTPLUG y/n
> and also for x86_64 and i386 builds.
>
> What was fixed? I fixed the issues Jean pointed out, I created separate patch
> for ...msr_safe stuff.
>   
In arch/i386/lib/msr-on-cpu.c, I'm not sure if you really need to create
2 versions of the functions (safe and unsafe). Anyway, no one uses these
functions in the kernel yet, so I think you can simply convert them to
safe versions.

Also, in __wrmsr_on_cpu_safe:
rv->err = wrmsr_safe(rv->msr_no, &rv->l, &rv->h);

should be:
rv->err = wrmsr_safe(rv->msr_no, rv->l, rv->h);
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019169.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019175.html
>
> All is only compile tested (I tried SMP y/n with hotplug Y on x86_64)!
> And considering late hours spent with this I would be careful ;)
>
> Reviews/comments/testing welcome! 
Just before you published your versions of the patches, I had another
version ready and tested on x86 (at least the read function), that
doesn't create two version of each function. I attached the patch here.
I you prefer your version, I'll test it.

I have another patch removing redundant functions in
arch/i386/kernel/msr.c, using the new functions in
arch/i386/lib/msr-on-cpu.c, I'll publish it here if you prefer my
version, otherwise I'll adapt it to your prototypes.

Best regards,

Nicolas


Use safe versions (i.e. return error code) of rdmsr and wrmsr in
arch/i386/lib/msr-on-cpu.c and arch/x86_64/lib/msr-on-cpu.c.

Signed-off-by: Nicolas Boichat <nicolas at boichat.ch>

---

 arch/i386/lib/msr-on-cpu.c |   47 ++++++++++++++++++++++++++++----------------
 include/asm-i386/msr.h     |   13 +++++++-----
 include/asm-x86_64/msr.h   |   14 +++++++------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/arch/i386/lib/msr-on-cpu.c b/arch/i386/lib/msr-on-cpu.c
index 1c46bda..be672df 100644
--- a/arch/i386/lib/msr-on-cpu.c
+++ b/arch/i386/lib/msr-on-cpu.c
@@ -3,55 +3,68 @@
 #include <linux/smp.h>
 #include <asm/msr.h>
 
-struct msr_info {
+struct msr_command {
+	int err;
 	u32 msr_no;
 	u32 l, h;
 };
 
-static void __rdmsr_on_cpu(void *info)
+static void __rdmsr_on_cpu(void *command)
 {
-	struct msr_info *rv = info;
+	struct msr_command *rv = command;
 
-	rdmsr(rv->msr_no, rv->l, rv->h);
+	rv->err = rdmsr_safe(rv->msr_no, &rv->l, &rv->h);
 }
 
-void rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
+int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 {
+	int ret;
+
 	preempt_disable();
 	if (smp_processor_id() = cpu)
-		rdmsr(msr_no, *l, *h);
+		ret = rdmsr_safe(msr_no, l, h);
 	else {
-		struct msr_info rv;
+		struct msr_command rv;
 
 		rv.msr_no = msr_no;
-		smp_call_function_single(cpu, __rdmsr_on_cpu, &rv, 0, 1);
-		*l = rv.l;
-		*h = rv.h;
+		ret = smp_call_function_single(cpu, __rdmsr_on_cpu, &rv, 0, 1);
+		if (!ret) {
+			*l = rv.l;
+			*h = rv.h;
+			ret = rv.err;
+		}
 	}
 	preempt_enable();
+	return ret;
 }
 
-static void __wrmsr_on_cpu(void *info)
+static void __wrmsr_on_cpu(void *command)
 {
-	struct msr_info *rv = info;
+	struct msr_command *rv = command;
 
-	wrmsr(rv->msr_no, rv->l, rv->h);
+	rv->err = wrmsr_safe(rv->msr_no, rv->l, rv->h);
 }
 
-void wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
+int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 {
+	int ret;
+
 	preempt_disable();
 	if (smp_processor_id() = cpu)
-		wrmsr(msr_no, l, h);
+		ret = wrmsr_safe(msr_no, l, h);
 	else {
-		struct msr_info rv;
+		struct msr_command rv;
 
 		rv.msr_no = msr_no;
 		rv.l = l;
 		rv.h = h;
-		smp_call_function_single(cpu, __wrmsr_on_cpu, &rv, 0, 1);
+		ret = smp_call_function_single(cpu, __wrmsr_on_cpu, &rv, 0, 1);
+		if (!ret) {
+			ret = rv.err;
+		}
 	}
 	preempt_enable();
+	return ret;
 }
 
 EXPORT_SYMBOL(rdmsr_on_cpu);
diff --git a/include/asm-i386/msr.h b/include/asm-i386/msr.h
index ec3b680..8caec04 100644
--- a/include/asm-i386/msr.h
+++ b/include/asm-i386/msr.h
@@ -4,6 +4,7 @@
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #else
+#include <linux/errno.h>
 
 /*
  * Access to machine-specific registers (available on 586 and better only)
@@ -84,16 +85,16 @@ static inline void wrmsrl (unsigned long msr, unsigned long long val)
 #endif	/* !CONFIG_PARAVIRT */
 
 #ifdef CONFIG_SMP
-void rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
-void wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
+int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
+int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 #else  /*  CONFIG_SMP  */
-static inline void rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
+static inline int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 {
-	rdmsr(msr_no, *l, *h);
+	return rdmsr_safe(msr_no, l, h);
 }
-static inline void wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
+static inline int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 {
-	wrmsr(msr_no, l, h);
+	return wrmsr_safe(msr_no, l, h);
 }
 #endif  /*  CONFIG_SMP  */
 
diff --git a/include/asm-x86_64/msr.h b/include/asm-x86_64/msr.h
index 902f9a5..789d23c 100644
--- a/include/asm-x86_64/msr.h
+++ b/include/asm-x86_64/msr.h
@@ -2,6 +2,8 @@
 #define X86_64_MSR_H 1
 
 #ifndef __ASSEMBLY__
+#include <linux/errno.h>
+
 /*
  * Access to machine-specific registers (available on 586 and better only)
  * Note: the rd* operations modify the parameters directly (without using
@@ -161,16 +163,16 @@ static inline unsigned int cpuid_edx(unsigned int op)
 #define MSR_IA32_UCODE_REV		0x8b
 
 #ifdef CONFIG_SMP
-void rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
-void wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
+int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
+int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 #else  /*  CONFIG_SMP  */
-static inline void rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
+static inline int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 {
-	rdmsr(msr_no, *l, *h);
+	return rdmsr_safe(msr_no, l, h);
 }
-static inline void wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
+static inline int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 {
-	wrmsr(msr_no, l, h);
+	return wrmsr_safe(msr_no, l, h);
 }
 #endif  /*  CONFIG_SMP  */
 



