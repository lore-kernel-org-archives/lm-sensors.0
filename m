From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Sep 2010 01:52:29 +0000
Subject: [lm-sensors] [PATCH v3 6/7] hwmon: (lm90) Add support for extra
Message-Id: <1284601950-7381-7-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/lm90            |    9 +++--
 Documentation/hwmon/sysfs-interface |    7 ++++
 drivers/hwmon/lm90.c                |   65 +++++++++++++++++++++++++++++++---
 3 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90
index d5ce9f4..bc2c2b4 100644
--- a/Documentation/hwmon/lm90
+++ b/Documentation/hwmon/lm90
@@ -101,10 +101,11 @@ well as the temperature of up to one external diode. It is compatible
 with many other devices, many of which are supported by this driver.
 
 Note that there is no easy way to differentiate between the MAX6657,
-MAX6658 and MAX6659 variants. The extra address and features of the
-MAX6659 are not supported by this driver. The MAX6680 and MAX6681 only
-differ in their pinout, therefore they obviously can't (and don't need to)
-be distinguished.
+MAX6658 and MAX6659 variants. The extra features of the MAX6659 are only
+supported by this driver if the chip is located at address 0x4d or 0x4e,
+or if the chip type is explicitly selected as max6659.
+The MAX6680 and MAX6681 only differ in their pinout, therefore they obviously
+can't (and don't need to) be distinguished.
 
 The specificity of this family of chipsets over the ADM1021/LM84
 family is that it features critical limits with hysteresis, and an
diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index 22843cb..4c73f3d 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -317,6 +317,13 @@ temp[1-*]_emergency
 		Unit: millidegree Celsius
 		RW
 
+temp[1-*]_emergency_hyst
+		Temperature hysteresis value for emergency limit.
+		Unit: millidegree Celsius
+		Must be reported as an absolute temperature, NOT a delta
+		from the emergency value.
+		RW
+
 temp[1-*]_lcrit	Temperature critical min value, typically lower than
 		corresponding temp_min values.
 		Unit: millidegree Celsius
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 68ee8f7..de54481 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -28,9 +28,11 @@
  * This driver also supports the MAX6657, MAX6658 and MAX6659 sensor
  * chips made by Maxim. These chips are similar to the LM86.
  * Note that there is no easy way to differentiate between the three
- * variants. The extra address and features of the MAX6659 are not
- * supported by this driver. These chips lack the remote temperature
- * offset feature.
+ * variants. We use the device address to detect MAX6659, which will result
+ * in a detection as max6657 if it is on address 0x4c. The extra address
+ * and features of the MAX6659 are only supported if the chip is configured
+ * explicitly as max6659, or if its address is not 0x4c.
+ * These chips lack the remote temperature offset feature.
  *
  * This driver also supports the MAX6646, MAX6647, MAX6648, MAX6649 and
  * MAX6692 chips made by Maxim.  These are again similar to the LM86,
@@ -138,6 +140,10 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
 /* MAX6646/6647/6649/6657/6658/6659 registers */
 
 #define MAX6657_REG_R_LOCAL_TEMPL	0x11
+#define MAX6659_REG_R_REMOTE_EMERG	0x16
+#define MAX6659_REG_W_REMOTE_EMERG	0x16
+#define MAX6659_REG_R_LOCAL_EMERG	0x17
+#define MAX6659_REG_W_LOCAL_EMERG	0x17
 
 /*
  * Device flags
@@ -147,6 +153,7 @@ enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
 #define LM90_HAVE_OFFSET	(1 << 1) /* temperature offset register	*/
 #define LM90_HAVE_LOCAL_EXT	(1 << 2) /* extended local temperature	*/
 #define LM90_HAVE_REM_LIMIT_EXT	(1 << 3) /* extended remote limit	*/
+#define LM90_HAVE_EMERGENCY	(1 << 4) /* 3rd upper (emergency) limit	*/
 
 /*
  * Functions declaration
@@ -213,10 +220,12 @@ struct lm90_data {
 	u8 alert_alarms;	/* Which alarm bits trigger ALERT# */
 
 	/* registers values */
-	s8 temp8[4];	/* 0: local low limit
+	s8 temp8[6];	/* 0: local low limit
 			   1: local high limit
 			   2: local critical limit
-			   3: remote critical limit */
+			   3: remote critical limit
+			   4: local emergency limit (max6659 only)
+			   5: remote emergency limit (max6659 only) */
 	s16 temp11[5];	/* 0: remote input
 			   1: remote low limit
 			   2: remote high limit
@@ -381,11 +390,13 @@ static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
 static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
 			 const char *buf, size_t count)
 {
-	static const u8 reg[4] = {
+	static const u8 reg[6] = {
 		LM90_REG_W_LOCAL_LOW,
 		LM90_REG_W_LOCAL_HIGH,
 		LM90_REG_W_LOCAL_CRIT,
 		LM90_REG_W_REMOTE_CRIT,
+		MAX6659_REG_W_LOCAL_EMERG,
+		MAX6659_REG_W_REMOTE_EMERG,
 	};
 
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -608,6 +619,30 @@ static const struct attribute_group lm90_group = {
 	.attrs = lm90_attributes,
 };
 
+/*
+ * Additional attributes for devices with emergency sensors
+ */
+static SENSOR_DEVICE_ATTR(temp1_emergency, S_IWUSR | S_IRUGO, show_temp8,
+	set_temp8, 4);
+static SENSOR_DEVICE_ATTR(temp2_emergency, S_IWUSR | S_IRUGO, show_temp8,
+	set_temp8, 5);
+static SENSOR_DEVICE_ATTR(temp1_emergency_hyst, S_IRUGO, show_temphyst,
+			  NULL, 4);
+static SENSOR_DEVICE_ATTR(temp2_emergency_hyst, S_IRUGO, show_temphyst,
+			  NULL, 5);
+
+static struct attribute *lm90_emergency_attributes[] = {
+	&sensor_dev_attr_temp1_emergency.dev_attr.attr,
+	&sensor_dev_attr_temp2_emergency.dev_attr.attr,
+	&sensor_dev_attr_temp1_emergency_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp2_emergency_hyst.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group lm90_emergency_group = {
+	.attrs = lm90_emergency_attributes,
+};
+
 /* pec used for ADM1032 only */
 static ssize_t show_pec(struct device *dev, struct device_attribute *dummy,
 			char *buf)
@@ -826,6 +861,9 @@ static int lm90_detect(struct i2c_client *new_client,
 
 static void lm90_remove_files(struct i2c_client *client, struct lm90_data *data)
 {
+	if (data->flags & LM90_HAVE_EMERGENCY)
+		sysfs_remove_group(&client->dev.kobj,
+				   &lm90_emergency_group);
 	if (data->flags & LM90_HAVE_OFFSET)
 		device_remove_file(&client->dev,
 				   &sensor_dev_attr_temp2_offset.dev_attr);
@@ -881,6 +919,9 @@ static int lm90_probe(struct i2c_client *new_client,
 	    && data->kind != max6646 && data->kind != max6680)
 		data->flags |= LM90_HAVE_REM_LIMIT_EXT;
 
+	if (data->kind = max6659)
+		data->flags |= LM90_HAVE_EMERGENCY;
+
 	/* Initialize the LM90 chip */
 	lm90_init_client(new_client);
 
@@ -899,6 +940,12 @@ static int lm90_probe(struct i2c_client *new_client,
 		if (err)
 			goto exit_remove_files;
 	}
+	if (data->flags & LM90_HAVE_EMERGENCY) {
+		err = sysfs_create_group(&new_client->dev.kobj,
+					 &lm90_emergency_group);
+		if (err)
+			goto exit_remove_files;
+	}
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -1082,6 +1129,12 @@ static struct lm90_data *lm90_update_device(struct device *dev)
 					  &l) = 0)
 				data->temp11[3] = (h << 8) | l;
 		}
+		if (data->flags & LM90_HAVE_EMERGENCY) {
+			lm90_read_reg(client, MAX6659_REG_R_LOCAL_EMERG,
+				      &data->temp8[4]);
+			lm90_read_reg(client, MAX6659_REG_R_REMOTE_EMERG,
+				      &data->temp8[5]);
+		}
 		lm90_read_reg(client, LM90_REG_R_STATUS, &data->alarms);
 
 		/* Re-enable ALERT# output if it was originally enabled and
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
