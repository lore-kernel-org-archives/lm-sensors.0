From: Carsten Emde <Carsten.Emde@osadl.org>
Date: Fri, 07 May 2010 13:29:28 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Get TjMax value from
Message-Id: <4BE415B8.1010400@osadl.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090109080908080504090509"
List-Id: <lm-sensors.vger.kernel.org>
References: <20100507095945.GB12190@owl>
In-Reply-To: <20100507095945.GB12190@owl>
To: Huaxu Wan <huaxu.wan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Huaxu Wan <huaxu.wan@intel.com>

This is a multi-part message in MIME format.
--------------090109080908080504090509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Huaxu,

> The MSR IA32_TEMPERATURE_TARGET contains the TjMax value in the newer
> processers.
I took the liberty to make some very minor changes to your patch:
- Unified and adapted messages and comments
- Added a definition of MSR_IA32_TEMPERATURE_TARGET to the arch header
- Replaced 0x1a2 by MSR_IA32_TEMPERATURE_TARGET
- Applied changes suggested by checkpatch

Hope you like it.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

--------------090109080908080504090509
Content-Type: text/x-patch;
 name="coretemp-add-tjmax-method-for-i-series-processors.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="coretemp-add-tjmax-method-for-i-series-processors.patch"

---
 arch/x86/include/asm/msr-index.h |    3 ++
 drivers/hwmon/coretemp.c         |   54 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 4 deletions(-)

Index: head/arch/x86/include/asm/msr-index.h
===================================================================
--- head.orig/arch/x86/include/asm/msr-index.h
+++ head/arch/x86/include/asm/msr-index.h
@@ -277,6 +277,9 @@
 #define MSR_IA32_MCG_EIP		0x00000189
 #define MSR_IA32_MCG_RESERVED		0x0000018a
 
+/* Specific to i series processors */
+#define MSR_IA32_TEMPERATURE_TARGET	0x000001a2
+
 /* Pentium IV performance counter MSRs */
 #define MSR_P4_BPU_PERFCTR0		0x00000300
 #define MSR_P4_BPU_PERFCTR1		0x00000301
Index: head/drivers/hwmon/coretemp.c
===================================================================
--- head.orig/drivers/hwmon/coretemp.c
+++ head/drivers/hwmon/coretemp.c
@@ -153,7 +153,8 @@ static struct coretemp_data *coretemp_up
 	return data;
 }
 
-static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
+static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
+				  struct device *dev)
 {
 	/* The 100C is default for both mobile and non mobile CPUs */
 
@@ -241,6 +242,51 @@ static int __devinit adjust_tjmax(struct
 	return tjmax;
 }
 
+static int __devinit get_tjmax(struct cpuinfo_x86 *c, u32 id,
+			       struct device *dev)
+{
+	int err;
+	u32 eax, edx;
+	u32 val;
+
+	err = rdmsr_safe_on_cpu(id, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
+	if (err)
+		dev_warn(dev, "Unable to read TjMax from CPU.\n");
+	else {
+		val = (eax >> 16) & 0xff;
+		if (val > 80 && val < 120) {
+			dev_info(dev, "TjMax is %dC.\n", val);
+			return val * 1000;
+		} else {
+			dev_warn(dev, "TjMax of %dC not plausible,"
+			    " using 100C instead." , val);
+			return 100000;
+		}
+	}
+
+	/*
+	 * An assumption is made for early CPUs and unreadable MSR.
+	 * NOTE: the given value may not be correct.
+	 */
+	switch (c->x86_model) {
+	case 0x0e:
+	case 0x0f:
+	case 0x16:
+	case 0x1a:
+		dev_warn(dev, "TjMax is assumed as 100C!\n");
+		return 100000;
+		break;
+	case 0x17:
+	case 0x1c: /* Atom CPUs */
+		return adjust_tjmax(c, id, dev);
+		break;
+	default:
+		dev_warn(dev, "CPU (model=0x%x) is not supported yet,"
+		    " using default TjMax of 100C.\n", c->x86_model);
+		return 100000;
+	}
+}
+
 static int __devinit coretemp_probe(struct platform_device *pdev)
 {
 	struct coretemp_data *data;
@@ -283,14 +329,14 @@ static int __devinit coretemp_probe(stru
 		}
 	}
 
-	data->tjmax = adjust_tjmax(c, data->id, &pdev->dev);
+	data->tjmax = get_tjmax(c, data->id, &pdev->dev);
 	platform_set_drvdata(pdev, data);
 
 	/* read the still undocumented IA32_TEMPERATURE_TARGET it exists
 	   on older CPUs but not in this register, Atoms don't have it either */
-
 	if ((c->x86_model > 0xe) && (c->x86_model != 0x1c)) {
-		err = rdmsr_safe_on_cpu(data->id, 0x1a2, &eax, &edx);
+		err = rdmsr_safe_on_cpu(data->id, MSR_IA32_TEMPERATURE_TARGET,
+		     &eax, &edx);
 		if (err) {
 			dev_warn(&pdev->dev, "Unable to read"
 					" IA32_TEMPERATURE_TARGET MSR\n");

--------------090109080908080504090509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090109080908080504090509--
