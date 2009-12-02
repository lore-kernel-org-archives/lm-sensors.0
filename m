From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 15:43:36 +0000
Subject: [lm-sensors] [PATCH 11/11] hwmon: (adt7475) Add VID support for the
Message-Id: <20091202164336.65552fe3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The ADT7476 has 5 dedicated pins for VID input, and the +12V input can
optionally be used as a 6th VID pin. Add support for VID input.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 Documentation/hwmon/adt7475 |    2 -
 drivers/hwmon/Kconfig       |    1 
 drivers/hwmon/adt7475.c     |   66 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 65 insertions(+), 4 deletions(-)

--- linux-2.6.32-rc8.orig/Documentation/hwmon/adt7475	2009-12-02 14:31:43.000000000 +0100
+++ linux-2.6.32-rc8/Documentation/hwmon/adt7475	2009-12-02 15:22:05.000000000 +0100
@@ -70,7 +70,7 @@ ADT7475:
 
 ADT7476:
   * 5 voltage inputs
-  * VID support (not implemented)
+  * VID support
 
 ADT7490:
   * 6 voltage inputs
--- linux-2.6.32-rc8.orig/drivers/hwmon/Kconfig	2009-12-02 14:31:43.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/Kconfig	2009-12-02 15:22:05.000000000 +0100
@@ -207,6 +207,7 @@ config SENSORS_ADT7473
 config SENSORS_ADT7475
 	tristate "Analog Devices ADT7473, ADT7475, ADT7476 and ADT7490"
 	depends on I2C && EXPERIMENTAL
+	select HWMON_VID
 	help
 	  If you say yes here you get support for the Analog Devices
 	  ADT7473, ADT7475, ADT7476 and ADT7490 hardware monitoring
--- linux-2.6.32-rc8.orig/drivers/hwmon/adt7475.c	2009-12-02 14:31:43.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/adt7475.c	2009-12-02 15:36:26.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 
 /* Indexes for the sysfs hooks */
@@ -110,6 +111,7 @@
 
 #define CONFIG5_TWOSCOMP	0x01
 #define CONFIG5_TEMPOFFSET	0x02
+#define CONFIG5_VIDGPIO		0x10	/* ADT7476 only */
 
 /* ADT7475 Settings */
 
@@ -171,6 +173,7 @@ struct adt7475_data {
 	u8 bypass_attn;		/* Bypass voltage attenuator */
 	u8 has_pwm2:1;
 	u8 has_fan4:1;
+	u8 has_vid:1;
 	u32 alarms;
 	u16 voltage[3][6];
 	u16 temp[7][3];
@@ -179,6 +182,9 @@ struct adt7475_data {
 	u8 range[3];
 	u8 pwmctl[3];
 	u8 pwmchan[3];
+
+	u8 vid;
+	u8 vrm;
 };
 
 static struct i2c_driver adt7475_driver;
@@ -864,6 +870,35 @@ static ssize_t set_pwm_at_crit(struct de
 	return count;
 }
 
+static ssize_t show_vrm(struct device *dev, struct device_attribute *devattr,
+			char *buf)
+{
+	struct adt7475_data *data = dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", (int)data->vrm);
+}
+
+static ssize_t set_vrm(struct device *dev, struct device_attribute *devattr,
+		       const char *buf, size_t count)
+{
+	struct adt7475_data *data = dev_get_drvdata(dev);
+	long val;
+
+	if (strict_strtol(buf, 10, &val))
+		return -EINVAL;
+	if (val < 0 || val > 255)
+		return -EINVAL;
+	data->vrm = val;
+
+	return count;
+}
+
+static ssize_t show_vid(struct device *dev, struct device_attribute *devattr,
+			char *buf)
+{
+	struct adt7475_data *data = adt7475_update_device(dev);
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+}
+
 static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_voltage, NULL, INPUT, 0);
 static SENSOR_DEVICE_ATTR_2(in0_max, S_IRUGO | S_IWUSR, show_voltage,
 			    set_voltage, MAX, 0);
@@ -1007,6 +1042,9 @@ static SENSOR_DEVICE_ATTR_2(pwm3_auto_po
 static DEVICE_ATTR(pwm_use_point2_pwm_at_crit, S_IWUSR | S_IRUGO,
 		   show_pwm_at_crit, set_pwm_at_crit);
 
+static DEVICE_ATTR(vrm, S_IWUSR | S_IRUGO, show_vrm, set_vrm);
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+
 static struct attribute *adt7475_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_max.dev_attr.attr,
@@ -1119,6 +1157,12 @@ static struct attribute *in5_attrs[] = {
 	NULL
 };
 
+static struct attribute *vid_attrs[] = {
+	&dev_attr_cpu0_vid.attr,
+	&dev_attr_vrm.attr,
+	NULL
+};
+
 static struct attribute_group adt7475_attr_group = { .attrs = adt7475_attrs };
 static struct attribute_group fan4_attr_group = { .attrs = fan4_attrs };
 static struct attribute_group pwm2_attr_group = { .attrs = pwm2_attrs };
@@ -1126,6 +1170,7 @@ static struct attribute_group in0_attr_g
 static struct attribute_group in3_attr_group = { .attrs = in3_attrs };
 static struct attribute_group in4_attr_group = { .attrs = in4_attrs };
 static struct attribute_group in5_attr_group = { .attrs = in5_attrs };
+static struct attribute_group vid_attr_group = { .attrs = vid_attrs };
 
 static int adt7475_detect(struct i2c_client *client, int kind,
 			  struct i2c_board_info *info)
@@ -1180,6 +1225,8 @@ static void adt7475_remove_files(struct
 		sysfs_remove_group(&client->dev.kobj, &in4_attr_group);
 	if (data->has_voltage & (1 << 5))
 		sysfs_remove_group(&client->dev.kobj, &in5_attr_group);
+	if (data->has_vid)
+		sysfs_remove_group(&client->dev.kobj, &vid_attr_group);
 }
 
 static int adt7475_probe(struct i2c_client *client,
@@ -1247,11 +1294,14 @@ static int adt7475_probe(struct i2c_clie
 			data->has_voltage |= (1 << 0);		/* in0 */
 	}
 
-	/* On the ADT7476, the +12V input pin may instead be used as VID5 */
+	/* On the ADT7476, the +12V input pin may instead be used as VID5,
+	   and VID pins may alternatively be used as GPIO */
 	if (id->driver_data = adt7476) {
 		u8 vid = adt7475_read(REG_VID);
 		if (!(vid & VID_VIDSEL))
 			data->has_voltage |= (1 << 4);		/* in4 */
+
+		data->has_vid = !(adt7475_read(REG_CONFIG5) & CONFIG5_VIDGPIO);
 	}
 
 	/* Voltage attenuators can be bypassed, globally or individually */
@@ -1304,6 +1354,12 @@ static int adt7475_probe(struct i2c_clie
 		if (ret)
 			goto eremove;
 	}
+	if (data->has_vid) {
+		data->vrm = vid_which_vrm();
+		ret = sysfs_create_group(&client->dev.kobj, &vid_attr_group);
+		if (ret)
+			goto eremove;
+	}
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1314,11 +1370,12 @@ static int adt7475_probe(struct i2c_clie
 	dev_info(&client->dev, "%s device, revision %d\n",
 		 names[id->driver_data], revision);
 	if ((data->has_voltage & 0x11) || data->has_fan4 || data->has_pwm2)
-		dev_info(&client->dev, "Optional features:%s%s%s%s\n",
+		dev_info(&client->dev, "Optional features:%s%s%s%s%s\n",
 			 (data->has_voltage & (1 << 0)) ? " in0" : "",
 			 (data->has_voltage & (1 << 4)) ? " in4" : "",
 			 data->has_fan4 ? " fan4" : "",
-			 data->has_pwm2 ? " pwm2" : "");
+			 data->has_pwm2 ? " pwm2" : "",
+			 data->has_vid ? " vid" : "");
 	if (data->bypass_attn)
 		dev_info(&client->dev, "Bypassing attenuators on:%s%s%s%s\n",
 			 (data->bypass_attn & (1 << 0)) ? " in0" : "",
@@ -1472,6 +1529,9 @@ static struct adt7475_data *adt7475_upda
 			data->pwm[INPUT][i] = adt7475_read(PWM_REG(i));
 		}
 
+		if (data->has_vid)
+			data->vid = adt7475_read(REG_VID) & 0x3f;
+
 		data->measure_updated = jiffies;
 	}
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
