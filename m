From: Huaxu Wan <huaxu.wan@linux.intel.com>
Date: Fri, 05 Mar 2010 15:38:11 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Get TjMax value from MSR
Message-Id: <20100305153811.GB15945@owl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The MSR IA32_TEMPERATURE_TARGET contains the TjMax value after the i series
processers.

Signed-off-by: Huaxu Wan <huaxu.wan@intel.com>
---
 drivers/hwmon/coretemp.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 55122d8..6039ea5 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -241,6 +241,50 @@ static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *
 	return tjmax;
 }
 
+static int __devinit get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
+{
+	/* The 100C is default for both mobile and non mobile CPUs */
+	int err;
+	u32 eax, edx;
+	u32 val;
+
+	/* A new feature in the i series processors, the 
+	   IA32_TEMPERATURE_TARGET contains the TjMax value */
+	err = rdmsr_safe_on_cpu(id, 0x1a2, &eax, &edx);
+	if (err){
+		printk_once(KERN_WARNING DRVNAME  " : Unable to read TjMax from CPU, an"
+			" assumption value is used! \n");
+	} else {
+		val = (eax >> 16 ) & 0xff;
+		/* If the TjMax is not reasonable, an assumption value 
+		   will be used */
+		if (( val > 80) && (val < 120)){
+			printk_once(KERN_WARNING DRVNAME " : The TjMax is %d\n C", val);
+			return val * 1000;
+		}
+	}
+
+	/* For the early CPUs, an approximation is given.
+	 NOTE: the given value may not be correct. */
+	switch(c->x86_model){
+	case 0xe :
+	case 0xf :
+	case 0x16 :
+	case 0x1a :
+		printk_once(KERN_WARNING DRVNAME  " : TjMax is assumed as 100 C! \n");
+		return 100000;
+		break;
+	case 0x17 :
+	case 0x1c :		/* Atom CPUs */
+		return adjust_tjmax(c, id, dev);
+		break;
+	default :
+		printk_once(KERN_WARNING DRVNAME " : Your CPU is not support yet,"
+			"using the default TjMax: 100 C.\n");
+		return 100000;
+	}
+}
+
 static int __devinit coretemp_probe(struct platform_device *pdev)
 {
 	struct coretemp_data *data;
@@ -283,7 +327,7 @@ static int __devinit coretemp_probe(struct platform_device *pdev)
 		}
 	}
 
-	data->tjmax = adjust_tjmax(c, data->id, &pdev->dev);
+	data->tjmax = get_tjmax(c, data->id, &pdev->dev);
 	platform_set_drvdata(pdev, data);
 
 	/* read the still undocumented IA32_TEMPERATURE_TARGET it exists
-- 
1.6.3.3.363.g725cf7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
