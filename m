From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [PATCH 2.6] add alternate VCORE calculations for w83627thf and
Message-Id: <20040606025430.GC10118@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg:

This can wait until after 2.6.7.  It applies to 2.6.7-rc2.

* * * * *

This patch adds support for the alternate in0/VCORE calculation which is
available for 2 of 4 chips this driver supports.  It also fixes a minor
bug in the standard voltage input calculation.  Please apply.

--- linux-2.6.7-rc2/drivers/i2c/chips/w83627hf.c.orig	2004-06-05 15:03:18.732383525 -0400
+++ linux-2.6.7-rc2/drivers/i2c/chips/w83627hf.c	2004-06-05 22:02:58.935212457 -0400
@@ -199,7 +199,7 @@
 #define W83627THF_REG_PWM2		0x03	/* 697HF and 637HF too */
 #define W83627THF_REG_PWM3		0x11	/* 637HF too */
 
-#define W83627THF_REG_VRM_OVT_CFG 	0x18	/* 637HF too, unused yet */
+#define W83627THF_REG_VRM_OVT_CFG 	0x18	/* 637HF too */
 
 static const u8 regpwm_627hf[] = { W83627HF_REG_PWM1, W83627HF_REG_PWM2 };
 static const u8 regpwm[] = { W83627THF_REG_PWM1, W83627THF_REG_PWM2,
@@ -222,7 +222,7 @@
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
 #define IN_TO_REG(val)  (SENSORS_LIMIT((((val) + 8)/16),0,255))
-#define IN_FROM_REG(val) ((val) * 16 + 5)
+#define IN_FROM_REG(val) ((val) * 16)
 
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
@@ -312,6 +312,7 @@
 				   Default = 3435.
 				   Other Betas unimplemented */
 	u8 vrm;
+	u8 vrm_ovt;		/* Register value, 627thf & 637hf only */
 };
 
 
@@ -391,7 +392,6 @@
 sysfs_in_reg_offset(min, offset) \
 sysfs_in_reg_offset(max, offset)
 
-sysfs_in_offsets(0)
 sysfs_in_offsets(1)
 sysfs_in_offsets(2)
 sysfs_in_offsets(3)
@@ -401,6 +401,89 @@
 sysfs_in_offsets(7)
 sysfs_in_offsets(8)
 
+/* use a different set of functions for in0 */
+static ssize_t show_in_0(struct w83627hf_data *data, char *buf, u8 reg)
+{
+	long in0;
+
+	if ((data->vrm_ovt & 0x01) &&
+		(w83627thf = data->type || w83637hf = data->type))
+
+		/* use VRM9 calculation */
+		in0 = (long)((reg * 488 + 70000 + 50) / 100);
+	else
+		/* use VRM8 (standard) calculation */
+		in0 = (long)IN_FROM_REG(reg);
+
+	return sprintf(buf,"%ld\n", in0);
+}
+
+static ssize_t show_regs_in_0(struct device *dev, char *buf)
+{
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return show_in_0(data, buf, data->in[0]);
+}
+
+static ssize_t show_regs_in_min0(struct device *dev, char *buf)
+{
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return show_in_0(data, buf, data->in_min[0]);
+}
+
+static ssize_t show_regs_in_max0(struct device *dev, char *buf)
+{
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return show_in_0(data, buf, data->in_max[0]);
+}
+
+static ssize_t store_regs_in_min0(struct device *dev,
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83627hf_data *data = i2c_get_clientdata(client);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10);
+	if ((data->vrm_ovt & 0x01) &&
+		(w83627thf = data->type || w83637hf = data->type))
+
+		/* use VRM9 calculation */
+		data->in_min[0] = (u8)(((val * 100) - 70000 + 244) / 488);
+	else
+		/* use VRM8 (standard) calculation */
+		data->in_min[0] = IN_TO_REG(val);
+
+	w83627hf_write_value(client, W83781D_REG_IN_MIN(0), data->in_min[0]);
+	return count;
+}
+
+static ssize_t store_regs_in_max0(struct device *dev,
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83627hf_data *data = i2c_get_clientdata(client);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10);
+	if ((data->vrm_ovt & 0x01) &&
+		(w83627thf = data->type || w83637hf = data->type))
+		
+		/* use VRM9 calculation */
+		data->in_max[0] = (u8)(((val * 100) - 70000 + 244) / 488);
+	else
+		/* use VRM8 (standard) calculation */
+		data->in_max[0] = IN_TO_REG(val);
+
+	w83627hf_write_value(client, W83781D_REG_IN_MAX(0), data->in_max[0]);
+	return count;
+}
+
+static DEVICE_ATTR(in0_input, S_IRUGO, show_regs_in_0, NULL)
+static DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR,
+	show_regs_in_min0, store_regs_in_min0)
+static DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR,
+	show_regs_in_max0, store_regs_in_max0)
+
 #define device_create_file_in(client, offset) \
 do { \
 device_create_file(&client->dev, &dev_attr_in##offset##_input); \
@@ -1191,6 +1274,11 @@
 		data->vid = w83627thf_read_gpio5(client) & 0x1f;
 	}
 
+	/* Read VRM & OVT Config only once */
+	if (w83627thf = data->type || w83637hf = data->type)
+		data->vrm_ovt = 
+			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
+
 	/* Convert VID to voltage based on default VRM */
 	data->vrm = DEFAULT_VRM;
 	if (type != w83697hf)


-- 
Mark M. Hoffman
mhoffman@lightlink.com
