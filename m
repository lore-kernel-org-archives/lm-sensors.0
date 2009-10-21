From: "Hans-Frieder Vogt" <hfvogt@gmx.net>
Date: Wed, 21 Oct 2009 21:08:06 +0000
Subject: Re: [lm-sensors] [PATCH] AGAIN: support for AMD 10H and 11H
Message-Id: <200910212308.06184.hfvogt@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200910041951.16102.hfvogt@gmx.net>
In-Reply-To: <200910041951.16102.hfvogt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Thank you. It seems AMD fixed that. Maybe we would need to avoid the goto.
> >  	if (!data->valid
> >  	    || time_after(jiffies, data->last_updated + HZ)) {
> > +		if (boot_cpu_data.x86 > 0xf) {
> > +			pci_read_config_dword(pdev, REG_TCTL,
> > +					      &data->temp[0][0]);
> > +			goto update_done;
> > +		}
> 
> Hm goto can be used only to jump to error paths.
> 
> > +
> > +	if ((boot_cpu_data.x86 = 0x10) && (model = 2)) {
> > +		/*
> > +		 * AMD 10H cpus rev. B report Inaccurate Temperature
> > +		 * Measurement :
> > +		 * http://www.amd.com/us-
> > en/assets/content_type/white_papers_and_tech_docs/41322.pdf
> > +		 *     Errata #319
> > +		 */
> > +		dev_err(&pdev->dev, "Reported temperature may be inconsistent, "
> > +			"therefore rejected here - see erratum #319\n");
> 
> Maybe the message could be - Erratum #319 detected, refusing to load.
> 
> > +		err = -ENODEV;
> 
> Thank you
> 
> Rudolf

thanks for your comments, Rudolf. Here is an updated patch that is a bit more 
structured and only uses gotos for error paths.


Signed-off-by: Hans-Frieder Vogt <hfvogt@gmx.net>
---
 drivers/hwmon/k8temp.c |  133 
++++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 82 insertions(+), 51 deletions(-)

--- a/drivers/hwmon/k8temp.c	2009-03-24 21:08:16.000000000 +0100
+++ b/drivers/hwmon/k8temp.c	2009-10-21 18:43:54.720019815 +0200
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
@@ -62,30 +71,35 @@ static struct k8temp_data *k8temp_update
 
 	if (!data->valid
 	    || time_after(jiffies, data->last_updated + HZ)) {
-		pci_read_config_byte(pdev, REG_TEMP, &tmp);
-		tmp &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
-		pci_write_config_byte(pdev, REG_TEMP, tmp);
-		pci_read_config_dword(pdev, REG_TEMP, &data->temp[0][0]);
-
-		if (data->sensorsp & SEL_PLACE) {
-			tmp |= SEL_PLACE;	/* Select sensor 1, core0 */
+		if (boot_cpu_data.x86 > 0xf) {
+			pci_read_config_dword(pdev, REG_TCTL,
+					      &data->temp[0][0]);
+		} else {
+			pci_read_config_byte(pdev, REG_TEMP, &tmp);
+			tmp &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
 			pci_write_config_byte(pdev, REG_TEMP, tmp);
-			pci_read_config_dword(pdev, REG_TEMP,
-					      &data->temp[0][1]);
-		}
-
-		if (data->sensorsp & SEL_CORE) {
-			tmp &= ~SEL_PLACE;	/* Select sensor 0, core1 */
-			tmp |= SEL_CORE;
-			pci_write_config_byte(pdev, REG_TEMP, tmp);
-			pci_read_config_dword(pdev, REG_TEMP,
-					      &data->temp[1][0]);
+			pci_read_config_dword(pdev, REG_TEMP, &data->temp[0][0]);
 
 			if (data->sensorsp & SEL_PLACE) {
-				tmp |= SEL_PLACE;	/* Select sensor 1, core1 */
+				tmp |= SEL_PLACE;	/* Select sensor 1, core0 */
+				pci_write_config_byte(pdev, REG_TEMP, tmp);
+				pci_read_config_dword(pdev, REG_TEMP,
+						      &data->temp[0][1]);
+			}
+
+			if (data->sensorsp & SEL_CORE) {
+				tmp &= ~SEL_PLACE;	/* Select sensor 0, core1 */
+				tmp |= SEL_CORE;
 				pci_write_config_byte(pdev, REG_TEMP, tmp);
 				pci_read_config_dword(pdev, REG_TEMP,
-						      &data->temp[1][1]);
+						      &data->temp[1][0]);
+
+				if (data->sensorsp & SEL_PLACE) {
+					tmp |= SEL_PLACE;	/* Select sensor 1, core1 */
+					pci_write_config_byte(pdev, REG_TEMP, tmp);
+					pci_read_config_dword(pdev, REG_TEMP,
+							      &data->temp[1][1]);
+				}
 			}
 		}
 
@@ -123,7 +137,7 @@ static ssize_t show_temp(struct device *
 	if (data->swap_core_select)
 		core = core ? 0 : 1;
 
-	temp = TEMP_FROM_REG(data->temp[core][place]) + data->temp_offset;
+	temp = temp_from_reg(data->temp[core][place]) + data->temp_offset;
 
 	return sprintf(buf, "%d\n", temp);
 }
@@ -138,6 +152,8 @@ static DEVICE_ATTR(name, S_IRUGO, show_n
 
 static struct pci_device_id k8temp_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_11H_NB_MISC) },
 	{ 0 },
 };
 
@@ -189,41 +205,56 @@ static int __devinit k8temp_probe(struct
 			data->temp_offset = 21000;
 		}
 
-		break;
-	}
+		pci_read_config_byte(pdev, REG_TEMP, &scfg);
+		scfg &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
+		pci_write_config_byte(pdev, REG_TEMP, scfg);
+		pci_read_config_byte(pdev, REG_TEMP, &scfg);
 
-	pci_read_config_byte(pdev, REG_TEMP, &scfg);
-	scfg &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
-	pci_write_config_byte(pdev, REG_TEMP, scfg);
-	pci_read_config_byte(pdev, REG_TEMP, &scfg);
-
-	if (scfg & (SEL_PLACE | SEL_CORE)) {
-		dev_err(&pdev->dev, "Configuration bit(s) stuck at 1!\n");
-		err = -ENODEV;
-		goto exit_free;
-	}
+		if (scfg & (SEL_PLACE | SEL_CORE)) {
+			dev_err(&pdev->dev, "Configuration bit(s) stuck at 1!\n");
+			err = -ENODEV;
+			goto exit_free;
+		}
 
-	scfg |= (SEL_PLACE | SEL_CORE);
-	pci_write_config_byte(pdev, REG_TEMP, scfg);
+		scfg |= (SEL_PLACE | SEL_CORE);
+		pci_write_config_byte(pdev, REG_TEMP, scfg);
 
-	/* now we know if we can change core and/or sensor */
-	pci_read_config_byte(pdev, REG_TEMP, &data->sensorsp);
+		/* now we know if we can change core and/or sensor */
+		pci_read_config_byte(pdev, REG_TEMP, &data->sensorsp);
 
-	if (data->sensorsp & SEL_PLACE) {
-		scfg &= ~SEL_CORE;	/* Select sensor 1, core0 */
-		pci_write_config_byte(pdev, REG_TEMP, scfg);
-		pci_read_config_dword(pdev, REG_TEMP, &temp);
-		scfg |= SEL_CORE;	/* prepare for next selection */
-		if (!((temp >> 16) & 0xff))	/* if temp is 0 -49C is not likely */
-			data->sensorsp &= ~SEL_PLACE;
-	}
+		if (data->sensorsp & SEL_PLACE) {
+			scfg &= ~SEL_CORE;	/* Select sensor 1, core0 */
+			pci_write_config_byte(pdev, REG_TEMP, scfg);
+			pci_read_config_dword(pdev, REG_TEMP, &temp);
+			scfg |= SEL_CORE;	/* prepare for next selection */
+			if (!((temp >> 16) & 0xff))	/* if temp is 0 -49C is not likely */
+				data->sensorsp &= ~SEL_PLACE;
+		}
 
-	if (data->sensorsp & SEL_CORE) {
-		scfg &= ~SEL_PLACE;	/* Select sensor 0, core1 */
-		pci_write_config_byte(pdev, REG_TEMP, scfg);
-		pci_read_config_dword(pdev, REG_TEMP, &temp);
-		if (!((temp >> 16) & 0xff))	/* if temp is 0 -49C is not likely */
-			data->sensorsp &= ~SEL_CORE;
+		if (data->sensorsp & SEL_CORE) {
+			scfg &= ~SEL_PLACE;	/* Select sensor 0, core1 */
+			pci_write_config_byte(pdev, REG_TEMP, scfg);
+			pci_read_config_dword(pdev, REG_TEMP, &temp);
+			if (!((temp >> 16) & 0xff))	/* if temp is 0 -49C is not likely */
+				data->sensorsp &= ~SEL_CORE;
+		}
+		break;
+	case 0x10:
+		if (model <= 2) {
+			/*
+			 * AMD 10H cpus rev. B report Inaccurate Temperature
+			 * Measurement :
+			 * http://www.amd.com/us-
en/assets/content_type/white_papers_and_tech_docs/41322.pdf
+			 *     Errata #319
+			 */
+			dev_err(&pdev->dev, "Erratum #319 detected, refusing to"
+				" load.\n");
+			err = -ENODEV;
+			goto exit_free;
+		}
+		break;
+	case 0x11:
+		break;
 	}
 
 	data->name = "k8temp";




Hans-Frieder Vogt                       e-mail: hfvogt <at> gmx .dot. net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
