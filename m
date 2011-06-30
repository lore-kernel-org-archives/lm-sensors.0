From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 30 Jun 2011 14:17:17 +0000
Subject: [lm-sensors] [PATCH] hwmon: (via-cputemp) Add VID reporting support
Message-Id: <20110630161717.76f5082b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At least VIA family 6 model D CPU report the VID settings in a MSR,
so expose the value to user-space. Not sure about model A.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/Kconfig       |    1 
 drivers/hwmon/via-cputemp.c |   44 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 5 deletions(-)

--- linux-3.0-rc5.orig/drivers/hwmon/via-cputemp.c	2011-06-30 14:33:47.000000000 +0200
+++ linux-3.0-rc5/drivers/hwmon/via-cputemp.c	2011-06-30 14:34:46.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/sysfs.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
@@ -48,8 +49,10 @@ enum { SHOW_TEMP, SHOW_LABEL, SHOW_NAME
 struct via_cputemp_data {
 	struct device *hwmon_dev;
 	const char *name;
+	u8 vrm;
 	u32 id;
-	u32 msr;
+	u32 msr_temp;
+	u32 msr_vid;
 };
 
 /*
@@ -77,13 +80,27 @@ static ssize_t show_temp(struct device *
 	u32 eax, edx;
 	int err;
 
-	err = rdmsr_safe_on_cpu(data->id, data->msr, &eax, &edx);
+	err = rdmsr_safe_on_cpu(data->id, data->msr_temp, &eax, &edx);
 	if (err)
 		return -EAGAIN;
 
 	return sprintf(buf, "%lu\n", ((unsigned long)eax & 0xffffff) * 1000);
 }
 
+static ssize_t show_cpu_vid(struct device *dev,
+			    struct device_attribute *devattr, char *buf)
+{
+	struct via_cputemp_data *data = dev_get_drvdata(dev);
+	u32 eax, edx;
+	int err;
+
+	err = rdmsr_safe_on_cpu(data->id, data->msr_vid, &eax, &edx);
+	if (err)
+		return -EAGAIN;
+
+	return sprintf(buf, "%d\n", vid_from_reg(~edx & 0x7f, data->vrm));
+}
+
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
 			  SHOW_TEMP);
 static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
@@ -100,6 +117,9 @@ static const struct attribute_group via_
 	.attrs = via_cputemp_attributes,
 };
 
+/* Optional attributes */
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_cpu_vid, NULL);
+
 static int __devinit via_cputemp_probe(struct platform_device *pdev)
 {
 	struct via_cputemp_data *data;
@@ -122,11 +142,12 @@ static int __devinit via_cputemp_probe(s
 		/* C7 A */
 	case 0xD:
 		/* C7 D */
-		data->msr = 0x1169;
+		data->msr_temp = 0x1169;
+		data->msr_vid = 0x198;
 		break;
 	case 0xF:
 		/* Nano */
-		data->msr = 0x1423;
+		data->msr_temp = 0x1423;
 		break;
 	default:
 		err = -ENODEV;
@@ -134,7 +155,7 @@ static int __devinit via_cputemp_probe(s
 	}
 
 	/* test if we can access the TEMPERATURE MSR */
-	err = rdmsr_safe_on_cpu(data->id, data->msr, &eax, &edx);
+	err = rdmsr_safe_on_cpu(data->id, data->msr_temp, &eax, &edx);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Unable to access TEMPERATURE MSR, giving up\n");
@@ -147,6 +168,15 @@ static int __devinit via_cputemp_probe(s
 	if (err)
 		goto exit_free;
 
+	if (data->msr_vid)
+		data->vrm = vid_which_vrm();
+
+	if (data->vrm) {
+		err = device_create_file(&pdev->dev, &dev_attr_cpu0_vid);
+		if (err)
+			goto exit_remove;
+	}
+
 	data->hwmon_dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
@@ -158,6 +188,8 @@ static int __devinit via_cputemp_probe(s
 	return 0;
 
 exit_remove:
+	if (data->vrm)
+		device_remove_file(&pdev->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&pdev->dev.kobj, &via_cputemp_group);
 exit_free:
 	platform_set_drvdata(pdev, NULL);
@@ -171,6 +203,8 @@ static int __devexit via_cputemp_remove(
 	struct via_cputemp_data *data = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	if (data->vrm)
+		device_remove_file(&pdev->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&pdev->dev.kobj, &via_cputemp_group);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
--- linux-3.0-rc5.orig/drivers/hwmon/Kconfig	2011-06-30 14:33:47.000000000 +0200
+++ linux-3.0-rc5/drivers/hwmon/Kconfig	2011-06-30 14:34:46.000000000 +0200
@@ -1162,6 +1162,7 @@ config SENSORS_TWL4030_MADC
 config SENSORS_VIA_CPUTEMP
 	tristate "VIA CPU temperature sensor"
 	depends on X86
+	select HWMON_VID
 	help
 	  If you say yes here you get support for the temperature
 	  sensor inside your CPU. Supported are all known variants of


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
