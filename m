From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 09:21:02 +0000
Subject: [lm-sensors] [PATCH 08/10] hwmon/w83627ehf: Export the thermal
Message-Id: <20070624112102.4c309393@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for the w83627ehf thermal sensor types. I made them read-only,
as the BIOS is supposed to set them up properly. This information makes it
easier to find out which temperature channel corresponds to the CPU.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- linux-2.6.22-rc5.orig/drivers/hwmon/w83627ehf.c	2007-06-23 22:02:04.000000000 +0200
+++ linux-2.6.22-rc5/drivers/hwmon/w83627ehf.c	2007-06-23 22:13:54.000000000 +0200
@@ -272,6 +272,7 @@ struct w83627ehf_data {
 	u8 fan_min[5];
 	u8 fan_div[5];
 	u8 has_fan;		/* some fan inputs can be disabled */
+	u8 temp_type[3];
 	s8 temp1;
 	s8 temp1_max;
 	s8 temp1_max_hyst;
@@ -846,6 +847,15 @@ store_##reg(struct device *dev, struct d
 store_temp_reg(OVER, temp_max);
 store_temp_reg(HYST, temp_max_hyst);
 
+static ssize_t
+show_temp_type(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct w83627ehf_data *data = w83627ehf_update_device(dev);
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	return sprintf(buf, "%d\n", (int)data->temp_type[nr]);
+}
+
 static struct sensor_device_attribute sda_temp[] = {
 	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp1, NULL, 0),
 	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 0),
@@ -865,6 +875,9 @@ static struct sensor_device_attribute sd
 	SENSOR_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4),
 	SENSOR_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5),
 	SENSOR_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13),
+	SENSOR_ATTR(temp1_type, S_IRUGO, show_temp_type, NULL, 0),
+	SENSOR_ATTR(temp2_type, S_IRUGO, show_temp_type, NULL, 1),
+	SENSOR_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2),
 };
 
 #define show_pwm_reg(reg) \
@@ -1188,7 +1201,7 @@ static void w83627ehf_device_remove_file
 static inline void __devinit w83627ehf_init_device(struct w83627ehf_data *data)
 {
 	int i;
-	u8 tmp;
+	u8 tmp, diode;
 
 	/* Start monitoring is needed */
 	tmp = w83627ehf_read_value(data, W83627EHF_REG_CONFIG);
@@ -1210,6 +1223,15 @@ static inline void __devinit w83627ehf_i
 	tmp = w83627ehf_read_value(data, W83627EHF_REG_VBAT);
 	if (!(tmp & 0x01))
 		w83627ehf_write_value(data, W83627EHF_REG_VBAT, tmp | 0x01);
+
+	/* Get thermal sensor types */
+	diode = w83627ehf_read_value(data, W83627EHF_REG_DIODE);
+	for (i = 0; i < 3; i++) {
+		if ((tmp & (0x02 << i)))
+			data->temp_type[i] = (diode & (0x10 << i)) ? 1 : 2;
+		else
+			data->temp_type[i] = 4; /* thermistor */
+	}
 }
 
 static int __devinit w83627ehf_probe(struct platform_device *pdev)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
