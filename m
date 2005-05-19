From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: [PATCH 2.6] Invert as99127f beep bits in kernel space
Message-Id: <20040502155822.05b7da2a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The following patch changes the way we invert beep bits for the AS99127F
sensor chip. This chip behaves differently from the other chips in that
a disabled bit is 1, not 0. So far we didn't handle that specificity in
the w83781d driver, so it was left to user-space applications to handle
it. For the sake of uniformity, it's obviously better if it's done in
the driver instead (although the meaning of each bit is still
chip-dependant).

I already did a similar change to the 2.4 driver and the sensors
program. I don't think that many user-space application will be
affected, since most of them don't handle the beep mask as far as I can
tell.

This also close Debian bug #209299:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug 9299

Successfully tested on my AS99127F rev.1 chip. Aurelien Jarno also
checked that there were no regression on non-Asus chips.

Please apply,
thanks.

--- linux-2.6.6-rc3/drivers/i2c/chips/w83781d.c.orig	Sun May  2 13:52:29 2004
+++ linux-2.6.6-rc3/drivers/i2c/chips/w83781d.c	Sun May  2 15:09:44 2004
@@ -183,8 +183,10 @@
 #define ALARMS_FROM_REG(val)		(val)
 #define PWM_FROM_REG(val)		(val)
 #define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
-#define BEEP_MASK_FROM_REG(val)		(val)
-#define BEEP_MASK_TO_REG(val)		((val) & 0xffffff)
+#define BEEP_MASK_FROM_REG(val,type)	((type) = as99127f ? \
+					 (val) ^ 0x7fff : (val))
+#define BEEP_MASK_TO_REG(val,type)	((type) = as99127f ? \
+					 (~(val)) & 0x7fff : (val) & 0xffffff)
 
 #define BEEP_ENABLE_TO_REG(val)		((val) ? 1 : 0)
 #define BEEP_ENABLE_FROM_REG(val)	((val) ? 1 : 0)
@@ -539,14 +541,18 @@
 DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL)
 #define device_create_file_alarms(client) \
 device_create_file(&client->dev, &dev_attr_alarms);
-#define show_beep_reg(REG, reg) \
-static ssize_t show_beep_##reg (struct device *dev, char *buf) \
-{ \
-	struct w83781d_data *data = w83781d_update_device(dev); \
-	return sprintf(buf,"%ld\n", (long)BEEP_##REG##_FROM_REG(data->beep_##reg)); \
+static ssize_t show_beep_mask (struct device *dev, char *buf)
+{
+	struct w83781d_data *data = w83781d_update_device(dev);
+	return sprintf(buf, "%ld\n",
+		       (long)BEEP_MASK_FROM_REG(data->beep_mask, data->type));
+}
+static ssize_t show_beep_enable (struct device *dev, char *buf)
+{
+	struct w83781d_data *data = w83781d_update_device(dev);
+	return sprintf(buf, "%ld\n",
+		       (long)BEEP_ENABLE_FROM_REG(data->beep_enable));
 }
-show_beep_reg(ENABLE, enable);
-show_beep_reg(MASK, mask);
 
 #define BEEP_ENABLE			0	/* Store beep_enable */
 #define BEEP_MASK			1	/* Store beep_mask */
@@ -562,7 +568,7 @@
 	val = simple_strtoul(buf, NULL, 10);
 
 	if (update_mask = BEEP_MASK) {	/* We are storing beep_mask */
-		data->beep_mask = BEEP_MASK_TO_REG(val);
+		data->beep_mask = BEEP_MASK_TO_REG(val, data->type);
 		w83781d_write_value(client, W83781D_REG_BEEP_INTS1,
 				    data->beep_mask & 0xff);
 


-- 
Jean Delvare
http://khali.linux-fr.org/
