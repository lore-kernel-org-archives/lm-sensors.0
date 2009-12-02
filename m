From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 15:29:41 +0000
Subject: [lm-sensors] [PATCH 06/11] hwmon: (adt7475) Handle alternative pin
Message-Id: <20091202162941.6b1bc56a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The TACH4 pin can be used for other functions, so fan4 may not always
be available. Likewise, the PWM2 pin can be used for ALERT output, in
which case pwm2 is not available

For the ADT7490, the +2.5 Vin pin may also be used for other
functions, in which case in0 is not available.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 drivers/hwmon/adt7475.c |  114 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 99 insertions(+), 15 deletions(-)

--- linux-2.6.32-rc8.orig/drivers/hwmon/adt7475.c	2009-12-02 14:30:53.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/adt7475.c	2009-12-02 14:31:11.000000000 +0100
@@ -80,6 +80,8 @@
 
 #define REG_EXTEND1		0x76
 #define REG_EXTEND2		0x77
+
+#define REG_CONFIG3		0x78
 #define REG_CONFIG5		0x7C
 #define REG_CONFIG4		0x7D
 
@@ -88,6 +90,10 @@
 #define REG_VTT_MIN		0x84	/* ADT7490 only */
 #define REG_VTT_MAX		0x86	/* ADT7490 only */
 
+#define CONFIG3_SMBALERT	0x01
+#define CONFIG3_THERM		0x02
+
+#define CONFIG4_PINFUNC		0x03
 #define CONFIG4_MAXDUTY		0x08
 
 #define CONFIG5_TWOSCOMP	0x01
@@ -149,6 +155,8 @@ struct adt7475_data {
 	u8 config4;
 	u8 config5;
 	u8 has_voltage;
+	u8 has_pwm2:1;
+	u8 has_fan4:1;
 	u32 alarms;
 	u16 voltage[3][6];
 	u16 temp[7][3];
@@ -1025,21 +1033,12 @@ static struct attribute *adt7475_attrs[]
 	&sensor_dev_attr_fan3_input.dev_attr.attr,
 	&sensor_dev_attr_fan3_min.dev_attr.attr,
 	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan4_input.dev_attr.attr,
-	&sensor_dev_attr_fan4_min.dev_attr.attr,
-	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
-	&sensor_dev_attr_pwm2.dev_attr.attr,
-	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
-	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
-	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
-	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
-	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm3.dev_attr.attr,
 	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
@@ -1050,12 +1049,33 @@ static struct attribute *adt7475_attrs[]
 	NULL,
 };
 
+static struct attribute *fan4_attrs[] = {
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_min.dev_attr.attr,
+	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
+	NULL
+};
+
+static struct attribute *pwm2_attrs[] = {
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
+	NULL
+};
+
 /* Attributes specific to the ADT7490 */
-static struct attribute *adt7490_attrs[] = {
+static struct attribute *in0_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
 	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+	NULL
+};
+
+static struct attribute *adt7490_attrs[] = {
 	&sensor_dev_attr_in3_input.dev_attr.attr,
 	&sensor_dev_attr_in3_max.dev_attr.attr,
 	&sensor_dev_attr_in3_min.dev_attr.attr,
@@ -1072,6 +1092,9 @@ static struct attribute *adt7490_attrs[]
 };
 
 static struct attribute_group adt7475_attr_group = { .attrs = adt7475_attrs };
+static struct attribute_group fan4_attr_group = { .attrs = fan4_attrs };
+static struct attribute_group pwm2_attr_group = { .attrs = pwm2_attrs };
+static struct attribute_group in0_attr_group = { .attrs = in0_attrs };
 static struct attribute_group adt7490_attr_group = { .attrs = adt7490_attrs };
 
 static int adt7475_detect(struct i2c_client *client, int kind,
@@ -1115,13 +1138,20 @@ static void adt7475_remove_files(struct
 	sysfs_remove_group(&client->dev.kobj, &adt7475_attr_group);
 	if (data->has_voltage & 0x39)
 		sysfs_remove_group(&client->dev.kobj, &adt7490_attr_group);
+	if (data->has_fan4)
+		sysfs_remove_group(&client->dev.kobj, &fan4_attr_group);
+	if (data->has_pwm2)
+		sysfs_remove_group(&client->dev.kobj, &pwm2_attr_group);
+	if (data->has_voltage & (1 << 0))
+		sysfs_remove_group(&client->dev.kobj, &in0_attr_group);
 }
 
 static int adt7475_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct adt7475_data *data;
-	int i, ret = 0;
+	int i, ret = 0, revision;
+	u8 config3;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (data = NULL)
@@ -1133,10 +1163,36 @@ static int adt7475_probe(struct i2c_clie
 	/* Initialize device-specific values */
 	switch (id->driver_data) {
 	case adt7490:
-		data->has_voltage = 0x3f;	/* in0 to in5 */
+		data->has_voltage = 0x3e;	/* in1 to in5 */
+		revision = adt7475_read(REG_DEVID2) & 0x03;
 		break;
 	default:
 		data->has_voltage = 0x06;	/* in1, in2 */
+		revision = adt7475_read(REG_DEVID2) & 0x07;
+	}
+
+	config3 = adt7475_read(REG_CONFIG3);
+	/* Pin PWM2 may alternatively be used for ALERT output */
+	if (!(config3 & CONFIG3_SMBALERT))
+		data->has_pwm2 = 1;
+	/* Meaning of this bit is inverted for the ADT7473-1 */
+	if (id->driver_data = adt7473 && revision >= 1)
+		data->has_pwm2 = !data->has_pwm2;
+
+	data->config4 = adt7475_read(REG_CONFIG4);
+	/* Pin TACH4 may alternatively be used for THERM */
+	if ((data->config4 & CONFIG4_PINFUNC) = 0x0)
+		data->has_fan4 = 1;
+
+	/* THERM configuration is more complex on the ADT7490, because 2
+	   different pins (TACH4 and +2.5 Vin) can be used for this function */
+	if (id->driver_data = adt7490) {
+		if ((data->config4 & CONFIG4_PINFUNC) = 0x1 &&
+		    !(config3 & CONFIG3_THERM))
+			data->has_fan4 = 1;
+		if (!(config3 & CONFIG3_THERM) ||
+		    (data->config4 & CONFIG4_PINFUNC) = 0x1)
+			data->has_voltage |= (1 << 0);		/* in0 */
 	}
 
 	/* Call adt7475_read_pwm for all pwm's as this will reprogram any
@@ -1155,6 +1211,23 @@ static int adt7475_probe(struct i2c_clie
 			goto eremove;
 	}
 
+	/* Features that can be disabled individually */
+	if (data->has_fan4) {
+		ret = sysfs_create_group(&client->dev.kobj, &fan4_attr_group);
+		if (ret)
+			goto eremove;
+	}
+	if (data->has_pwm2) {
+		ret = sysfs_create_group(&client->dev.kobj, &pwm2_attr_group);
+		if (ret)
+			goto eremove;
+	}
+	if (data->has_voltage & (1 << 0)) {
+		ret = sysfs_create_group(&client->dev.kobj, &in0_attr_group);
+		if (ret)
+			goto eremove;
+	}
+
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		ret = PTR_ERR(data->hwmon_dev);
@@ -1293,13 +1366,19 @@ static struct adt7475_data *adt7475_upda
 				((ext >> 4) & 3);
 		}
 
-		for (i = 0; i < ADT7475_TACH_COUNT; i++)
+		for (i = 0; i < ADT7475_TACH_COUNT; i++) {
+			if (i = 3 && !data->has_fan4)
+				continue;
 			data->tach[INPUT][i]  				adt7475_read_word(client, TACH_REG(i));
+		}
 
 		/* Updated by hw when in auto mode */
-		for (i = 0; i < ADT7475_PWM_COUNT; i++)
+		for (i = 0; i < ADT7475_PWM_COUNT; i++) {
+			if (i = 1 && !data->has_pwm2)
+				continue;
 			data->pwm[INPUT][i] = adt7475_read(PWM_REG(i));
+		}
 
 		data->measure_updated = jiffies;
 	}
@@ -1340,11 +1419,16 @@ static struct adt7475_data *adt7475_upda
 		}
 		adt7475_read_hystersis(client);
 
-		for (i = 0; i < ADT7475_TACH_COUNT; i++)
+		for (i = 0; i < ADT7475_TACH_COUNT; i++) {
+			if (i = 3 && !data->has_fan4)
+				continue;
 			data->tach[MIN][i]  				adt7475_read_word(client, TACH_MIN_REG(i));
+		}
 
 		for (i = 0; i < ADT7475_PWM_COUNT; i++) {
+			if (i = 1 && !data->has_pwm2)
+				continue;
 			data->pwm[MAX][i] = adt7475_read(PWM_MAX_REG(i));
 			data->pwm[MIN][i] = adt7475_read(PWM_MIN_REG(i));
 			/* Set the channel and control information */

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
