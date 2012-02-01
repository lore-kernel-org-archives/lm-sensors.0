From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:06 +0000
Subject: [lm-sensors] [PATCH 18/24] hwmon: (w83627hf) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-19-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627hf.c |   37 ++++++++-----------------------------
 1 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 5ce54a2..14d1f0a 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -387,7 +387,6 @@ struct w83627hf_data {
 	u16 sens[3];		/* 1 = pentium diode; 2 = 3904 diode;
 				 * 4 = thermistor
 				 */
-	u8 vrm;
 	u8 vrm_ovt;		/* Register value, 627THF/637HF/687THF only */
 };
 
@@ -730,33 +729,11 @@ static ssize_t
 show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 
 static ssize_t
-show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct w83627hf_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
-}
-static ssize_t
-store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct w83627hf_data *data = dev_get_drvdata(dev);
-	unsigned long val;
-	int err;
-
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-	data->vrm = val;
-
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
-
-static ssize_t
 show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
@@ -1458,10 +1435,8 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 
 	if (data->type != w83697hf && data->vid != 0xff) {
 		/* Convert VID to voltage based on VRM */
-		data->vrm = vid_which_vrm();
-
-		if ((err = device_create_file(dev, &dev_attr_cpu0_vid))
-		 || (err = device_create_file(dev, &dev_attr_vrm)))
+		err = device_create_file(dev, &dev_attr_cpu0_vid);
+		if (err < 0)
 			goto ERROR4;
 	}
 
@@ -1677,7 +1652,9 @@ static void __devinit w83627hf_init_device(struct platform_device *pdev)
 	w83627hf_write_value(data, W83781D_REG_I2C_ADDR, force_i2c);
 
 	/* Read VID only once */
-	if (type = w83627hf || type = w83637hf) {
+	if (vid_which_vrm() = 0) {
+		data->vid = 0xff;
+	} else if (type = w83627hf || type = w83637hf) {
 		int lo = w83627hf_read_value(data, W83781D_REG_VID_FANDIV);
 		int hi = w83627hf_read_value(data, W83781D_REG_CHIPID);
 		data->vid = (lo & 0x0f) | ((hi & 0x01) << 4);
@@ -1685,6 +1662,8 @@ static void __devinit w83627hf_init_device(struct platform_device *pdev)
 		data->vid = w83627thf_read_gpio5(pdev);
 	} else if (type = w83687thf) {
 		data->vid = w83687thf_read_vid(pdev);
+	} else {
+		data->vid = 0xff;
 	}
 
 	/* Read VRM & OVT Config only once */
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
