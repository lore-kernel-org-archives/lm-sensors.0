From: Bernhard Seibold <bernhard@seibold.ws>
Date: Mon, 03 Sep 2007 21:38:14 +0000
Subject: Re: [lm-sensors] k8temp, BE-2350 CPU
Message-Id: <1188855494.15869.12.camel@klappe.intranet>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-hVOnQ+SJcEZ9iSD/yRIx"
List-Id: <lm-sensors.vger.kernel.org>
References: <46BAABD3.5000103@assembler.cz>
In-Reply-To: <46BAABD3.5000103@assembler.cz>
To: lm-sensors@vger.kernel.org


--=-hVOnQ+SJcEZ9iSD/yRIx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

On Mo, 2007-09-03 at 12:36 +0200, Rudolf Marek wrote:
> Sooo... the 49 needs to be substracted even from the LSB bits! Does it 
> really work then ;) ? If so then cool,

Seems to works on my Brisbane BE-2350, the reported temperatures look
reasonable.

> For the CPUID range of revF I would suggest to check the
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/33610.pdf
> 
> Page 7, I think you may use > operator in IF to check if CPUID is bigger 
> or equal than first CPUID of the revF series.

Thanks, that's what I was looking for.

I revised my patch to use the CPUID model to determine the CPU revision.

The patch now uses a function pointer for the selected conversion
formula. Not sure if you'll like it, but to me it looks better than
using "if" and a macro.

Regards,
Bernhard

--=-hVOnQ+SJcEZ9iSD/yRIx
Content-Disposition: attachment; filename=k8temp_brisbane_support.patch
Content-Type: text/x-patch; name=k8temp_brisbane_support.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux/drivers/hwmon/k8temp.c	2007-09-03 17:43:00.000000000 +0200
+++ linux/drivers/hwmon/k8temp.c	2007-09-03 23:24:40.000000000 +0200
@@ -32,7 +32,6 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 
-#define TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
 #define REG_TEMP	0xe4
 #define SEL_PLACE	0x40
 #define SEL_CORE	0x04
@@ -47,6 +46,7 @@ struct k8temp_data {
 	/* registers values */
 	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
 	u32 temp[2][2];		/* core, place */
+	u32 (*convert)(u32);
 };
 
 static struct k8temp_data *k8temp_update_device(struct device *dev)
@@ -94,6 +94,16 @@ static struct k8temp_data *k8temp_update
 	return data;
 }
 
+static u32 convert_rev_f(u32 val)
+{
+	return (((((val) >> 16) & 0xff) - 49) * 1000);
+}
+
+static u32 convert_rev_g(u32 val)
+{
+	return (((((val) >> 14) & 0x3ff) - 49) * 250);
+}
+
 /*
  * Sysfs stuff
  */
@@ -116,8 +126,8 @@ static ssize_t show_temp(struct device *
 	int place = attr->index;
 	struct k8temp_data *data = k8temp_update_device(dev);
 
-	return sprintf(buf, "%d\n",
-		       TEMP_FROM_REG(data->temp[core][place]));
+	u32 temp = data->convert(data->temp[core][place]);
+	return sprintf(buf, "%d\n", temp);
 }
 
 /* core, place */
@@ -142,10 +152,15 @@ static int __devinit k8temp_probe(struct
 	u8 scfg;
 	u32 temp;
 	struct k8temp_data *data;
-	u32 cpuid = cpuid_eax(1);
+	struct cpuinfo_x86 *c = cpu_data;
+
+	if (c->x86 != 15) {
+		err = -ENODEV;
+		goto exit;
+	}
 
 	/* this feature should be available since SH-C0 core */
-	if ((cpuid == 0xf40) || (cpuid == 0xf50) || (cpuid == 0xf51)) {
+	if (c->x86_model < 6 && c->x86_mask < 8) {
 		err = -ENODEV;
 		goto exit;
 	}
@@ -155,6 +170,12 @@ static int __devinit k8temp_probe(struct
 		goto exit;
 	}
 
+	if (c->x86_model < 96) {			/* up to core F */
+		data->convert = &convert_rev_f;
+	} else {
+		data->convert = &convert_rev_g;
+	}
+		
 	pci_read_config_byte(pdev, REG_TEMP, &scfg);
 	scfg &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
 	pci_write_config_byte(pdev, REG_TEMP, scfg);

--=-hVOnQ+SJcEZ9iSD/yRIx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-hVOnQ+SJcEZ9iSD/yRIx--

