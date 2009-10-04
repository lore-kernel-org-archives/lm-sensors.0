From: "Hans-Frieder Vogt" <hfvogt@gmx.net>
Date: Sun, 04 Oct 2009 17:51:16 +0000
Subject: [lm-sensors] [PATCH] AGAIN: support for AMD 10H and 11H
Message-Id: <200910041951.16102.hfvogt@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

picking up the discussion that happened in May (see
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-May/025896.html
and following discussion), it seems that the decision taken at the time was a 
bit too general.
The latest revisions of the Revision Guide for AMD Family 10h processors (from 
Rev. 3.50) show that only model 'B' of the Family 10h processors is affected by 
the erratum #319 (inconsistent temperature reporting).
I have a model 'C' Family 10h processor and can confirm that the temperatures 
reported by the processor do make sense.

I suggest therefore a patch based on Jasminders proposal, slightly modified to 
exclude only the affected family 10h model 'B' processors, but accepting the 
other models (i.e. currently 'C' and 'D').
Rudolf, what do you think?

Thanks,
Hans-Frieder

Signed-off-by: Hans-Frieder Vogt <hfvogt@gmx.net>
---
 drivers/hwmon/k8temp.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

--- a/drivers/hwmon/k8temp.c	2009-01-17 18:56:04.000000000 +0100
+++ b/drivers/hwmon/k8temp.c	2009-10-04 19:10:46.873812447 +0200
@@ -1,5 +1,6 @@
 /*
  * k8temp.c - Linux kernel module for hardware monitoring
+ * for AMD K8 and derivates
  *
  * Copyright (C) 2006 Rudolf Marek <r.marek@assembler.cz>
  *
@@ -33,7 +34,7 @@
 #include <linux/mutex.h>
 #include <asm/processor.h>
 
-#define TEMP_FROM_REG(val)	(((((val) >> 16) & 0xff) - 49) * 1000)
+#define REG_TCTL	0xa4
 #define REG_TEMP	0xe4
 #define SEL_PLACE	0x40
 #define SEL_CORE	0x04
@@ -52,6 +53,14 @@ struct k8temp_data {
 	u32 temp_offset;
 };
 
+static unsigned long temp_from_reg(unsigned long val)
+{
+	if (boot_cpu_data.x86 > 0xf)
+		return ((val) >> 21) * 125;
+	else
+		return ((((val) >> 16) & 0xff) - 49) * 1000;
+}
+
 static struct k8temp_data *k8temp_update_device(struct device *dev)
 {
 	struct k8temp_data *data = dev_get_drvdata(dev);
@@ -62,6 +71,11 @@ static struct k8temp_data *k8temp_update
 
 	if (!data->valid
 	    || time_after(jiffies, data->last_updated + HZ)) {
+		if (boot_cpu_data.x86 > 0xf) {
+			pci_read_config_dword(pdev, REG_TCTL,
+					      &data->temp[0][0]);
+			goto update_done;
+		}
 		pci_read_config_byte(pdev, REG_TEMP, &tmp);
 		tmp &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
 		pci_write_config_byte(pdev, REG_TEMP, tmp);
@@ -89,6 +103,7 @@ static struct k8temp_data *k8temp_update
 			}
 		}
 
+update_done:
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -123,7 +138,7 @@ static ssize_t show_temp(struct device *
 	if (data->swap_core_select)
 		core = core ? 0 : 1;
 
-	temp = TEMP_FROM_REG(data->temp[core][place]) + data->temp_offset;
+	temp = temp_from_reg(data->temp[core][place]) + data->temp_offset;
 
 	return sprintf(buf, "%d\n", temp);
 }
@@ -138,6 +153,8 @@ static DEVICE_ATTR(name, S_IRUGO, show_n
 
 static struct pci_device_id k8temp_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_11H_NB_MISC) },
 	{ 0 },
 };
 
@@ -158,6 +175,23 @@ static int __devinit k8temp_probe(struct
 	}
 
 	model = boot_cpu_data.x86_model;
+
+	if ((boot_cpu_data.x86 = 0x10) && (model = 2)) {
+		/*
+		 * AMD 10H cpus rev. B report Inaccurate Temperature
+		 * Measurement :
+		 * http://www.amd.com/us-
en/assets/content_type/white_papers_and_tech_docs/41322.pdf
+		 *     Errata #319
+		 */
+		dev_err(&pdev->dev, "Reported temperature may be inconsistent, "
+			"therefore rejected here - see erratum #319\n");
+		err = -ENODEV;
+		goto exit_free;
+	}
+	if (boot_cpu_data.x86 > 0xf) {
+		goto probe_done;
+	}
+
 	stepping = boot_cpu_data.x86_mask;
 
 	switch (boot_cpu_data.x86) {
@@ -226,6 +260,7 @@ static int __devinit k8temp_probe(struct
 			data->sensorsp &= ~SEL_CORE;
 	}
 
+probe_done:
 	data->name = "k8temp";
 	mutex_init(&data->update_lock);
 	dev_set_drvdata(&pdev->dev, data);

Hans-Frieder Vogt                       e-mail: hfvogt <at> gmx .dot. net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
