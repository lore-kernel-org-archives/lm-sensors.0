From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 09 May 2012 02:31:54 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (it87) Make temp3 attribute conditional for IT8782F and IT8783F
Message-Id: <1336530714-26615-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On IT8782F and IT8783F, temp3 is only supported if UART6 is disabled.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |   92 +++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 47dbb2c..1aaa382 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -218,6 +218,7 @@ static const u8 IT87_REG_FANX_MIN[]	= { 0x1b, 0x1c, 0x1d, 0x85, 0x87 };
 
 #define IT87_REG_VIN_ENABLE    0x50
 #define IT87_REG_TEMP_ENABLE   0x51
+#define IT87_REG_TEMP_EXTRA    0x55
 #define IT87_REG_BEEP_ENABLE   0x5c
 
 #define IT87_REG_CHIPID        0x58
@@ -238,6 +239,7 @@ struct it87_sio_data {
 	u8 skip_vid;
 	u8 skip_fan;
 	u8 skip_pwm;
+	u8 skip_temp;
 };
 
 /*
@@ -262,6 +264,7 @@ struct it87_data {
 	u8 has_fan;		/* Bitfield, fans enabled */
 	u16 fan[5];		/* Register values, possibly combined */
 	u16 fan_min[5];		/* Register values, possibly combined */
+	u8 has_temp;		/* Bitfield, temp sensors enabled */
 	s8 temp[3];		/* Register value */
 	s8 temp_high[3];	/* Register value */
 	s8 temp_low[3];		/* Register value */
@@ -1438,23 +1441,37 @@ static const struct attribute_group it87_group_in[9] = {
 	{ .attrs = it87_attributes_in[8] },
 };
 
-static struct attribute *it87_attributes[] = {
+static struct attribute *it87_attributes_temp[3][6] = {
+{
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp2_input.dev_attr.attr,
-	&sensor_dev_attr_temp3_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp2_max.dev_attr.attr,
-	&sensor_dev_attr_temp3_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
-	&sensor_dev_attr_temp2_min.dev_attr.attr,
-	&sensor_dev_attr_temp3_min.dev_attr.attr,
 	&sensor_dev_attr_temp1_type.dev_attr.attr,
-	&sensor_dev_attr_temp2_type.dev_attr.attr,
-	&sensor_dev_attr_temp3_type.dev_attr.attr,
 	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
+	NULL
+} , {
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_type.dev_attr.attr,
 	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
+	NULL
+} , {
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_type.dev_attr.attr,
 	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
+	NULL
+} };
+
+static const struct attribute_group it87_group_temp[3] = {
+	{ .attrs = it87_attributes_temp[0] },
+	{ .attrs = it87_attributes_temp[1] },
+	{ .attrs = it87_attributes_temp[2] },
+};
 
+static struct attribute *it87_attributes[] = {
 	&dev_attr_alarms.attr,
 	&sensor_dev_attr_intrusion0_alarm.dev_attr.attr,
 	&dev_attr_name.attr,
@@ -1477,15 +1494,10 @@ static struct attribute *it87_attributes_in_beep[] = {
 	NULL
 };
 
-static struct attribute *it87_attributes_beep[] = {
+static struct attribute *it87_attributes_temp_beep[] = {
 	&sensor_dev_attr_temp1_beep.dev_attr.attr,
 	&sensor_dev_attr_temp2_beep.dev_attr.attr,
 	&sensor_dev_attr_temp3_beep.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group it87_group_beep = {
-	.attrs = it87_attributes_beep,
 };
 
 static struct attribute *it87_attributes_fan16[5][3+1] = { {
@@ -1787,6 +1799,14 @@ static int __init it87_find(unsigned short *address,
 			sio_data->skip_in |= (1 << 7);
 		}
 
+		/*
+		 * No temp3 if UART6 is enabled and the temp3 source is TEMPIN3.
+		 * We can not read the temp3 source here, so skip_temp is
+		 * preliminary.
+		 */
+		if (uart6)
+			sio_data->skip_temp |= (1 << 2);
+
 		if (reg2C & (1 << 0))
 			sio_data->internal |= (1 << 0);
 		if (reg2C & (1 << 1))
@@ -1866,9 +1886,15 @@ static int __init it87_find(unsigned short *address,
 		 * On IT8782F, UART6 pins overlap with VIN5, VIN6, and VIN7.
 		 * While VIN7 can be routed to the internal voltage divider,
 		 * VIN5 and VIN6 are not available if UART6 is enabled.
+		 *
+		 * Also, temp3 is not available if UART6 is enabled and TEMPIN3
+		 * is the temperature source. Since we can not read the
+		 * temperature source here, skip_temp is preliminary.
 		 */
-		if (uart6)
+		if (uart6) {
 			sio_data->skip_in |= (1 << 5) | (1 << 6);
+			sio_data->skip_temp |= (1 << 2);
+		}
 
 		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
 	}
@@ -1913,8 +1939,11 @@ static void it87_remove_files(struct device *dev)
 			sysfs_remove_file(&dev->kobj,
 					  it87_attributes_in_beep[i]);
 	}
-	if (sio_data->beep_pin)
-		sysfs_remove_group(&dev->kobj, &it87_group_beep);
+	for (i = 0; i < 3; i++) {
+		sysfs_remove_group(&dev->kobj, &it87_group_temp[i]);
+		sysfs_remove_file(&dev->kobj,
+				  it87_attributes_temp_beep[i]);
+	}
 	for (i = 0; i < 5; i++) {
 		if (!(data->has_fan & (1 << i)))
 			continue;
@@ -2007,6 +2036,11 @@ static int __devinit it87_probe(struct platform_device *pdev)
 			data->in_scaled |= (1 << 7);	/* in7 is VCCH5V */
 	}
 
+	data->has_temp = 0x07;
+	if (sio_data->skip_temp &&
+	    !(it87_read_value(data, IT87_REG_TEMP_EXTRA) & 0x80))
+		data->has_temp &= ~sio_data->skip_temp;
+
 	/* Initialize the IT87 chip */
 	it87_init_device(pdev);
 
@@ -2025,16 +2059,24 @@ static int __devinit it87_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = sysfs_create_group(&dev->kobj, &it87_group);
-	if (err)
-		goto ERROR4;
-
-	if (sio_data->beep_pin) {
-		err = sysfs_create_group(&dev->kobj, &it87_group_beep);
+	for (i = 0; i < 3; i++) {
+		if (!(data->has_temp & (1 << i)))
+			continue;
+		err = sysfs_create_group(&dev->kobj, &it87_group_temp[i]);
 		if (err)
 			goto ERROR4;
+		if (sio_data->beep_pin) {
+			err = sysfs_create_file(&dev->kobj,
+						it87_attributes_temp_beep[i]);
+			if (err)
+				goto ERROR4;
+		}
 	}
 
+	err = sysfs_create_group(&dev->kobj, &it87_group);
+	if (err)
+		goto ERROR4;
+
 	/* Do not create fan files for disabled fans */
 	fan_group = it87_get_fan_group(data);
 	fan_beep_need_rw = 1;
@@ -2380,6 +2422,8 @@ static struct it87_data *it87_update_device(struct device *dev)
 			}
 		}
 		for (i = 0; i < 3; i++) {
+			if (!(data->has_temp & (1 << i)))
+				continue;
 			data->temp[i]  				it87_read_value(data, IT87_REG_TEMP(i));
 			data->temp_high[i] -- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
