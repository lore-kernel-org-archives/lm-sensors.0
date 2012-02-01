From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:03 +0000
Subject: [lm-sensors] [PATCH 15/24] hwmon: (via-cputemp) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-16-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Harald Welte <laforge@gnumonks.org>
---
 drivers/hwmon/via-cputemp.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index 8eac67d..19d8f71 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -49,7 +49,6 @@ enum { SHOW_TEMP, SHOW_LABEL, SHOW_NAME };
 struct via_cputemp_data {
 	struct device *hwmon_dev;
 	const char *name;
-	u8 vrm;
 	u32 id;
 	u32 msr_temp;
 	u32 msr_vid;
@@ -98,7 +97,7 @@ static ssize_t show_cpu_vid(struct device *dev,
 	if (err)
 		return -EAGAIN;
 
-	return sprintf(buf, "%d\n", vid_from_reg(~edx & 0x7f, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(~edx & 0x7f));
 }
 
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
@@ -143,7 +142,8 @@ static int __devinit via_cputemp_probe(struct platform_device *pdev)
 	case 0xD:
 		/* C7 D */
 		data->msr_temp = 0x1169;
-		data->msr_vid = 0x198;
+		if (vid_which_vrm() > 0)
+			data->msr_vid = 0x198;
 		break;
 	case 0xF:
 		/* Nano */
@@ -168,10 +168,7 @@ static int __devinit via_cputemp_probe(struct platform_device *pdev)
 	if (err)
 		goto exit_free;
 
-	if (data->msr_vid)
-		data->vrm = vid_which_vrm();
-
-	if (data->vrm) {
+	if (data->msr_vid) {
 		err = device_create_file(&pdev->dev, &dev_attr_cpu0_vid);
 		if (err)
 			goto exit_remove;
@@ -188,8 +185,7 @@ static int __devinit via_cputemp_probe(struct platform_device *pdev)
 	return 0;
 
 exit_remove:
-	if (data->vrm)
-		device_remove_file(&pdev->dev, &dev_attr_cpu0_vid);
+	device_remove_file(&pdev->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&pdev->dev.kobj, &via_cputemp_group);
 exit_free:
 	platform_set_drvdata(pdev, NULL);
@@ -203,8 +199,7 @@ static int __devexit via_cputemp_remove(struct platform_device *pdev)
 	struct via_cputemp_data *data = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	if (data->vrm)
-		device_remove_file(&pdev->dev, &dev_attr_cpu0_vid);
+	device_remove_file(&pdev->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&pdev->dev.kobj, &via_cputemp_group);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
