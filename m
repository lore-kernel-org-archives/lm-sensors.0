From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Date: Tue, 07 Jul 2009 09:42:06 +0000
Subject: [lm-sensors] [PATCH] hwmon: k8temp.c Add support for AMD 11h
Message-Id: <1246959006.3001.7.camel@hpdv5.satnam>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2009-07-06 at 18:44 +0200, Rudolf Marek wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi all,
> 
> It seems mine emails are arriving multiple times. I'm sorry about that. Axel, is
> it doing mine ISP?
> 
> 
> > I totally agree with you that's why I removed the support for 10h as per
> > your suggestion.
> 
> 
> Ok fine.
> 
> > 
> >> I'm perfectly fine if you come up with a patch for fam 11h because the Errata 
> > is still waiting for your approval.
> 
> Aha sorry I forgot about this one. Please can you re-structure it so there are
> not a goto's I think kernel codingstyle allows them only for error paths.
> 

Ok, I also removed goto and here is updated patch :

[PATCH] hwmon: k8temp.c Add support for AMD 11h

Added AMD 11h support in k8temp. Thanks to Rudolf Marek for help.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 drivers/hwmon/Kconfig  |    4 +-
 drivers/hwmon/k8temp.c |   75 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2d50166..e7b4941 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -200,11 +200,11 @@ config SENSORS_ADT7475
 	  will be called adt7475.
 
 config SENSORS_K8TEMP
-	tristate "AMD Athlon64/FX or Opteron temperature sensor"
+	tristate "AMD Athlon64/FX or Opteron or 11h temperature sensor"
 	depends on X86 && PCI && EXPERIMENTAL
 	help
 	  If you say yes here you get support for the temperature
-	  sensor(s) inside your CPU. Supported is whole AMD K8
+	  sensor(s) inside your CPU. Supported is whole AMD K8 and 11h
 	  microarchitecture. Please note that you will need at least
 	  lm-sensors 2.10.1 for proper userspace support.
 
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 1fe9951..f91da26 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -1,5 +1,6 @@
 /*
  * k8temp.c - Linux kernel module for hardware monitoring
+ *	      for AMD K8 and 11h
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
@@ -52,42 +53,61 @@ struct k8temp_data {
 	u32 temp_offset;
 };
 
-static struct k8temp_data *k8temp_update_device(struct device *dev)
+static inline unsigned long temp_from_reg(unsigned long val)
+{
+	if (boot_cpu_data.x86 > 0xf)
+		return (val >> 21) * 125;
+	else
+		return (((val >> 16) & 0xff) - 49) * 1000;
+}
+
+static void update_11h_temp(struct pci_dev *pdev, struct k8temp_data *data)
+{
+	pci_read_config_dword(pdev, REG_TCTL, &data->temp[0][0]);
+}
+
+static void update_k8_temp(struct pci_dev *pdev, struct k8temp_data *data)
 {
-	struct k8temp_data *data = dev_get_drvdata(dev);
-	struct pci_dev *pdev = to_pci_dev(dev);
 	u8 tmp;
 
-	mutex_lock(&data->update_lock);
+	pci_read_config_byte(pdev, REG_TEMP, &tmp);
+	tmp &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
+	pci_write_config_byte(pdev, REG_TEMP, tmp);
+	pci_read_config_dword(pdev, REG_TEMP, &data->temp[0][0]);
 
-	if (!data->valid
-	    || time_after(jiffies, data->last_updated + HZ)) {
-		pci_read_config_byte(pdev, REG_TEMP, &tmp);
-		tmp &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
+	if (data->sensorsp & SEL_PLACE) {
+		tmp |= SEL_PLACE;		/* Select sensor 1, core0 */
 		pci_write_config_byte(pdev, REG_TEMP, tmp);
-		pci_read_config_dword(pdev, REG_TEMP, &data->temp[0][0]);
+		pci_read_config_dword(pdev, REG_TEMP, &data->temp[0][1]);
+	}
+
+	if (data->sensorsp & SEL_CORE) {
+		tmp &= ~SEL_PLACE;		/* Select sensor 0, core1 */
+		tmp |= SEL_CORE;
+		pci_write_config_byte(pdev, REG_TEMP, tmp);
+		pci_read_config_dword(pdev, REG_TEMP, &data->temp[1][0]);
 
 		if (data->sensorsp & SEL_PLACE) {
-			tmp |= SEL_PLACE;	/* Select sensor 1, core0 */
+			tmp |= SEL_PLACE;	/* Select sensor 1, core1 */
 			pci_write_config_byte(pdev, REG_TEMP, tmp);
 			pci_read_config_dword(pdev, REG_TEMP,
-					      &data->temp[0][1]);
+					      &data->temp[1][1]);
 		}
+	}
+}
 
-		if (data->sensorsp & SEL_CORE) {
-			tmp &= ~SEL_PLACE;	/* Select sensor 0, core1 */
-			tmp |= SEL_CORE;
-			pci_write_config_byte(pdev, REG_TEMP, tmp);
-			pci_read_config_dword(pdev, REG_TEMP,
-					      &data->temp[1][0]);
-
-			if (data->sensorsp & SEL_PLACE) {
-				tmp |= SEL_PLACE;	/* Select sensor 1, core1 */
-				pci_write_config_byte(pdev, REG_TEMP, tmp);
-				pci_read_config_dword(pdev, REG_TEMP,
-						      &data->temp[1][1]);
-			}
-		}
+static struct k8temp_data *k8temp_update_device(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct k8temp_data *data = dev_get_drvdata(dev);
+
+	mutex_lock(&data->update_lock);
+
+	if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
+		if (boot_cpu_data.x86 > 0xf)
+			update_11h_temp(pdev, data);
+		else
+			update_k8_temp(pdev, data);
 
 		data->last_updated = jiffies;
 		data->valid = 1;
@@ -123,7 +143,7 @@ static ssize_t show_temp(struct device *dev,
 	if (data->swap_core_select)
 		core = core ? 0 : 1;
 
-	temp = TEMP_FROM_REG(data->temp[core][place]) + data->temp_offset;
+	temp = temp_from_reg(data->temp[core][place]) + data->temp_offset;
 
 	return sprintf(buf, "%d\n", temp);
 }
@@ -138,6 +158,7 @@ static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
 static struct pci_device_id k8temp_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_11H_NB_MISC) },
 	{ 0 },
 };
 
-- 
1.6.0.6



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
