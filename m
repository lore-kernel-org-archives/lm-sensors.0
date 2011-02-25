From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 25 Feb 2011 18:57:26 +0000
Subject: [lm-sensors] [PATCH v4 4/4] hwmon: (lm85) Add support for EMC6D103S
Message-Id: <1298660246-6484-5-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

EMC6D103S is similar to EMC6D103, only it does not support registers 62[5:7],
6D[0:7], and 6E[0:7]. Register respective sysfs attributes and update affected
registers for all other chips only.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/lm85 |   12 +++++++-
 drivers/hwmon/lm85.c     |   75 +++++++++++++++++++++++++++++++--------------
 2 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/Documentation/hwmon/lm85 b/Documentation/hwmon/lm85
index 239258a..7c49fea 100644
--- a/Documentation/hwmon/lm85
+++ b/Documentation/hwmon/lm85
@@ -26,6 +26,14 @@ Supported chips:
     Prefix: 'emc6d102'
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
     Datasheet: http://www.smsc.com/main/catalog/emc6d102.html
+  * SMSC EMC6D103
+    Prefix: 'emc6d103'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: http://www.smsc.com/main/catalog/emc6d103.html
+  * SMSC EMC6D103S
+    Prefix: 'emc6d103s'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: http://www.smsc.com/main/catalog/emc6d103s.html
 
 Authors:
         Philip Pokorny <ppokorny@penguincomputing.com>,
@@ -122,9 +130,11 @@ to be register compatible. The EMC6D100 offers all the features of the
 EMC6D101 plus additional voltage monitoring and system control features.
 Unfortunately it is not possible to distinguish between the package
 versions on register level so these additional voltage inputs may read
-zero. The EMC6D102 features addtional ADC bits thus extending precision
+zero. EMC6D102 and EMC6D103 feature additional ADC bits thus extending precision
 of voltage and temperature channels.
 
+SMSC EMC6D103S is similar to EMC6D103, but does not support pwm#_auto_pwm_minctl
+and temp#_auto_temp_off.
 
 Hardware Configurations
 -----------------------
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index fbb5189..cf47e6e 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -41,7 +41,7 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 enum chips {
 	any_chip, lm85b, lm85c,
 	adm1027, adt7463, adt7468,
-	emc6d100, emc6d102, emc6d103
+	emc6d100, emc6d102, emc6d103, emc6d103s
 };
 
 /* The LM85 registers */
@@ -350,6 +350,7 @@ static const struct i2c_device_id lm85_id[] = {
 	{ "emc6d101", emc6d100 },
 	{ "emc6d102", emc6d102 },
 	{ "emc6d103", emc6d103 },
+	{ "emc6d103s", emc6d103s },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm85_id);
@@ -1068,13 +1069,7 @@ static struct attribute *lm85_attributes[] = {
 	&sensor_dev_attr_pwm1_auto_pwm_min.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_pwm_min.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_pwm_min.dev_attr.attr,
-	&sensor_dev_attr_pwm1_auto_pwm_minctl.dev_attr.attr,
-	&sensor_dev_attr_pwm2_auto_pwm_minctl.dev_attr.attr,
-	&sensor_dev_attr_pwm3_auto_pwm_minctl.dev_attr.attr,
 
-	&sensor_dev_attr_temp1_auto_temp_off.dev_attr.attr,
-	&sensor_dev_attr_temp2_auto_temp_off.dev_attr.attr,
-	&sensor_dev_attr_temp3_auto_temp_off.dev_attr.attr,
 	&sensor_dev_attr_temp1_auto_temp_min.dev_attr.attr,
 	&sensor_dev_attr_temp2_auto_temp_min.dev_attr.attr,
 	&sensor_dev_attr_temp3_auto_temp_min.dev_attr.attr,
@@ -1095,6 +1090,26 @@ static const struct attribute_group lm85_group = {
 	.attrs = lm85_attributes,
 };
 
+static struct attribute *lm85_attributes_minctl[] = {
+	&sensor_dev_attr_pwm1_auto_pwm_minctl.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_pwm_minctl.dev_attr.attr,
+	&sensor_dev_attr_pwm3_auto_pwm_minctl.dev_attr.attr,
+};
+
+static const struct attribute_group lm85_group_minctl = {
+	.attrs = lm85_attributes_minctl,
+};
+
+static struct attribute *lm85_attributes_temp_off[] = {
+	&sensor_dev_attr_temp1_auto_temp_off.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_temp_off.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_temp_off.dev_attr.attr,
+};
+
+static const struct attribute_group lm85_group_temp_off = {
+	.attrs = lm85_attributes_temp_off,
+};
+
 static struct attribute *lm85_attributes_in4[] = {
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
@@ -1242,16 +1257,9 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
 		case LM85_VERSTEP_EMC6D103_A1:
 			type_name = "emc6d103";
 			break;
-		/*
-		 * Registers apparently missing in EMC6D103S/EMC6D103:A2
-		 * compared to EMC6D103:A0, EMC6D103:A1, and EMC6D102
-		 * (according to the data sheets), but used unconditionally
-		 * in the driver: 62[5:7], 6D[0:7], and 6E[0:7].
-		 * So skip EMC6D103S for now.
 		case LM85_VERSTEP_EMC6D103S:
 			type_name = "emc6d103s";
 			break;
-		 */
 		}
 	} else {
 		dev_dbg(&adapter->dev,
@@ -1267,6 +1275,10 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
 static void lm85_remove_files(struct i2c_client *client, struct lm85_data *data)
 {
 	sysfs_remove_group(&client->dev.kobj, &lm85_group);
+	if (data->type != emc6d103s) {
+		sysfs_remove_group(&client->dev.kobj, &lm85_group_minctl);
+		sysfs_remove_group(&client->dev.kobj, &lm85_group_temp_off);
+	}
 	if (!data->has_vid5)
 		sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
 	if (data->type = emc6d100)
@@ -1295,6 +1307,7 @@ static int lm85_probe(struct i2c_client *client,
 	case emc6d100:
 	case emc6d102:
 	case emc6d103:
+	case emc6d103s:
 		data->freq_map = adm1027_freq_map;
 		break;
 	default:
@@ -1312,6 +1325,17 @@ static int lm85_probe(struct i2c_client *client,
 	if (err)
 		goto err_kfree;
 
+	/* minctl and temp_off exist on all chips except emc6d103s */
+	if (data->type != emc6d103s) {
+		err = sysfs_create_group(&client->dev.kobj, &lm85_group_minctl);
+		if (err)
+			goto err_kfree;
+		err = sysfs_create_group(&client->dev.kobj,
+					 &lm85_group_temp_off);
+		if (err)
+			goto err_kfree;
+	}
+
 	/* The ADT7463/68 have an optional VRM 10 mode where pin 21 is used
 	   as a sixth digital VID input rather than an analog input. */
 	if (data->type = adt7463 || data->type = adt7468) {
@@ -1475,7 +1499,8 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 			/* More alarm bits */
 			data->alarms |= lm85_read_value(client,
 						EMC6D100_REG_ALARM3) << 16;
-		} else if (data->type = emc6d102 || data->type = emc6d103) {
+		} else if (data->type = emc6d102 || data->type = emc6d103 ||
+			   data->type = emc6d103s) {
 			/* Have to read LSB bits after the MSB ones because
 			   the reading of the MSB bits has frozen the
 			   LSBs (backward from the ADM1027).
@@ -1560,17 +1585,19 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 			}
 		}
 
-		i = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
-		data->autofan[0].min_off = (i & 0x20) != 0;
-		data->autofan[1].min_off = (i & 0x40) != 0;
-		data->autofan[2].min_off = (i & 0x80) != 0;
+		if (data->type != emc6d103s) {
+			i = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
+			data->autofan[0].min_off = (i & 0x20) != 0;
+			data->autofan[1].min_off = (i & 0x40) != 0;
+			data->autofan[2].min_off = (i & 0x80) != 0;
 
-		i = lm85_read_value(client, LM85_REG_AFAN_HYST1);
-		data->zone[0].hyst = i >> 4;
-		data->zone[1].hyst = i & 0x0f;
+			i = lm85_read_value(client, LM85_REG_AFAN_HYST1);
+			data->zone[0].hyst = i >> 4;
+			data->zone[1].hyst = i & 0x0f;
 
-		i = lm85_read_value(client, LM85_REG_AFAN_HYST2);
-		data->zone[2].hyst = i >> 4;
+			i = lm85_read_value(client, LM85_REG_AFAN_HYST2);
+			data->zone[2].hyst = i >> 4;
+		}
 
 		data->last_config = jiffies;
 	}  /* last_config */
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
