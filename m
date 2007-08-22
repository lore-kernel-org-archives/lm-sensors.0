From: Boleslaw Ciesielski <bolek-sensors@curl.com>
Date: Wed, 22 Aug 2007 01:29:05 +0000
Subject: [lm-sensors] Backporting coretemp and w83793 to 2.6.18
Message-Id: <46CB9161.5090408@curl.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040708090107040506060101"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708090107040506060101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am new to this list and hopefully this is not too stupid...

I have this new server based on the Asus DSBF-DE/SAS motherboard and a
pair of Xeons 5355. I want to run CentOS 5.0 (RHEL 5 clone) on it.
CentOS 5.0 is based on the 2.6.18 kernel and as such has drivers for
everything *except* for the sensors. The motherboard uses 83793 chip.

So, I wanted to backport the w83793 and coretemp drivers to 2.6.18
kernel. I took the source from 2.6.22.3 for these two and tried to
compile them for 2.6.18.

The w83793 compiles and loads as is, without any changes.

coretemp required some changes related to msr so I just restored the
code that was in there when coretemp was floating around as a patch
before it made it to the kernel. See the attached patch for detail.

Anyway, with those changes both coretemp and w83793 compile and load. I
also copied sensors.conf from 2.10.4 and ran "sensors -s". However,
neither is providing any data. Output looks like this:

$ sensors
coretemp-isa-0000
Adapter: ISA adapter

coretemp-isa-0001
Adapter: ISA adapter

coretemp-isa-0002
Adapter: ISA adapter

coretemp-isa-0003
Adapter: ISA adapter

coretemp-isa-0004
Adapter: ISA adapter

coretemp-isa-0005
Adapter: ISA adapter

coretemp-isa-0006
Adapter: ISA adapter

coretemp-isa-0007
Adapter: ISA adapter

w83793-i2c-0-2f
Adapter: SMBus I801 adapter at 1100


$

Am I missing something obvious? I did verify that I can get good sensor 
reading on this motherboard using Fedora 7 and 2.6.22 kernel but that's 
not what I want to run in production.

Any help will be appreciated.

Thanks,

Bolek


--------------040708090107040506060101
Content-Type: text/x-patch;
 name="coretemp-2.6.18.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="coretemp-2.6.18.patch"

--- /tmp/linux-2.6.22.3/drivers/hwmon/coretemp.c	2007-08-15 12:25:39.000000000 -0400
+++ drivers/hwmon/coretemp.c	2007-08-21 20:50:38.000000000 -0400
@@ -36,6 +36,71 @@
 #include <asm/msr.h>
 #include <asm/processor.h>
 
+/*
+   Following part ripped from the msr.c. It should be merged with generic MSR
+   infrastructure (once ready)
+*/
+
+static inline int rdmsr_eio(u32 reg, u32 *eax, u32 *edx)
+{
+	int err;
+
+	err = rdmsr_safe(reg, eax, edx);
+	if (err)
+		err = -EIO;
+	return err;
+}
+
+#ifdef CONFIG_SMP
+
+struct msr_command {
+	int cpu;
+	int err;
+	u32 reg;
+	u32 data[2];
+};
+
+static void msr_smp_rdmsr(void *cmd_block)
+{
+	struct msr_command *cmd = (struct msr_command *)cmd_block;
+
+	if (cmd->cpu == smp_processor_id())
+		cmd->err = rdmsr_eio(cmd->reg, &cmd->data[0], &cmd->data[1]);
+}
+
+static inline int msr_read(int cpu, u32 reg, u32 * eax, u32 * edx)
+{
+	struct msr_command cmd;
+	int ret;
+
+	preempt_disable();
+	if (cpu == smp_processor_id()) {
+		ret = rdmsr_eio(reg, eax, edx);
+	} else {
+		cmd.cpu = cpu;
+		cmd.reg = reg;
+
+		smp_call_function(msr_smp_rdmsr, &cmd, 1, 1);
+
+		*eax = cmd.data[0];
+		*edx = cmd.data[1];
+
+		ret = cmd.err;
+	}
+	preempt_enable();
+	return ret;
+}
+
+#else				/* ! CONFIG_SMP */
+
+static inline int msr_read(int cpu, u32 reg, u32 *eax, u32 *edx)
+{
+	return rdmsr_eio(reg, eax, edx);
+}
+
+#endif				/* ! CONFIG_SMP */
+
+
 #define DRVNAME	"coretemp"
 
 typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_LABEL, SHOW_NAME } SHOW;
@@ -132,7 +197,7 @@
 		u32 eax, edx;
 
 		data->valid = 0;
-		rdmsr_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
+		msr_read(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
 		data->alarm = (eax >> 5) & 1;
 		/* update only if data has been valid */
 		if (eax & 0x80000000) {
@@ -169,7 +234,7 @@
 	data->tjmax = 100000;
 
 	/* test if we can access the THERM_STATUS MSR */
-	err = rdmsr_safe_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
+	err = msr_read(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Unable to access THERM_STATUS MSR, giving up\n");
@@ -183,7 +248,7 @@
 
 	if ((c->x86_model == 0xe) && (c->x86_mask < 0xc)) {
 		/* check for microcode update */
-		rdmsr_on_cpu(data->id, MSR_IA32_UCODE_REV, &eax, &edx);
+		msr_read(data->id, MSR_IA32_UCODE_REV, &eax, &edx);
 		if (edx < 0x39) {
 			err = -ENODEV;
 			dev_err(&pdev->dev,
@@ -200,7 +265,7 @@
 
 	if (((c->x86_model == 0xf) && (c->x86_mask > 3)) ||
 		(c->x86_model == 0xe))  {
-		err = rdmsr_safe_on_cpu(data->id, 0xee, &eax, &edx);
+		err = msr_read(data->id, 0xee, &eax, &edx);
 		if (err) {
 			dev_warn(&pdev->dev,
 				 "Unable to access MSR 0xEE, Tjmax left at %d "
@@ -216,7 +281,7 @@
 	   bit 50 of MSR_IA32_PLATFORM_ID should be 0.
 	*/
 
-	rdmsr_safe_on_cpu(data->id, MSR_IA32_PLATFORM_ID, &eax, &edx);
+	msr_read(data->id, MSR_IA32_PLATFORM_ID, &eax, &edx);
 
 	if ((c->x86_model == 0xf) && (!(edx & 0x00040000))) {
 		dev_warn(&pdev->dev, "Using undocumented features, absolute "
@@ -339,11 +404,9 @@
 
 	switch (action) {
 	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
 		coretemp_device_add(cpu);
 		break;
 	case CPU_DEAD:
-	case CPU_DEAD_FROZEN:
 		coretemp_device_remove(cpu);
 		break;
 	}


--------------040708090107040506060101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040708090107040506060101--
