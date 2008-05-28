From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 May 2008 15:04:39 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (lm90) Support the extra resolution
Message-Id: <20080528170439.30470a4f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The Maxim MAX6657, MAX6658 and MAX6659 have extra resolution bits for
the local temperature measurement. Let the lm90 driver read them and
export them to user-space.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
The patch is bigger than one would think, because some re-indexing of
the 8-bit temperature values was needed.

 Documentation/hwmon/lm90 |   10 +++++---
 drivers/hwmon/lm90.c     |   54 ++++++++++++++++++++++++++++------------------
 2 files changed, 39 insertions(+), 25 deletions(-)

--- linux-2.6.26-rc4.orig/drivers/hwmon/lm90.c	2008-05-27 21:50:38.000000000 +0200
+++ linux-2.6.26-rc4/drivers/hwmon/lm90.c	2008-05-27 23:24:22.000000000 +0200
@@ -149,6 +149,10 @@ I2C_CLIENT_INSMOD_7(lm90, adm1032, lm99,
 #define LM90_REG_R_TCRIT_HYST		0x21
 #define LM90_REG_W_TCRIT_HYST		0x21
 
+/* MAX6657-specific registers */
+
+#define MAX6657_REG_R_LOCAL_TEMPL	0x11
+
 /*
  * Conversions and various macros
  * For local temperatures and limits, critical limits and the hysteresis
@@ -219,15 +223,15 @@ struct lm90_data {
 	int kind;
 
 	/* registers values */
-	s8 temp8[5];	/* 0: local input
-			   1: local low limit
-			   2: local high limit
-			   3: local critical limit
-			   4: remote critical limit */
-	s16 temp11[4];	/* 0: remote input
+	s8 temp8[4];	/* 0: local low limit
+			   1: local high limit
+			   2: local critical limit
+			   3: remote critical limit */
+	s16 temp11[5];	/* 0: remote input
 			   1: remote low limit
 			   2: remote high limit
-			   3: remote offset (except max6657) */
+			   3: remote offset (except max6657)
+			   4: local input */
 	u8 temp_hyst;
 	u8 alarms; /* bitvector */
 };
@@ -265,7 +269,7 @@ static ssize_t set_temp8(struct device *
 		data->temp8[nr] = TEMP1_TO_REG_ADT7461(val);
 	else
 		data->temp8[nr] = TEMP1_TO_REG(val);
-	i2c_smbus_write_byte_data(client, reg[nr - 1], data->temp8[nr]);
+	i2c_smbus_write_byte_data(client, reg[nr], data->temp8[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -327,7 +331,7 @@ static ssize_t set_temphyst(struct devic
 	long hyst;
 
 	mutex_lock(&data->update_lock);
-	hyst = TEMP1_FROM_REG(data->temp8[3]) - val;
+	hyst = TEMP1_FROM_REG(data->temp8[2]) - val;
 	i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
 				  HYST_TO_REG(hyst));
 	mutex_unlock(&data->update_lock);
@@ -351,23 +355,23 @@ static ssize_t show_alarm(struct device 
 	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
 }
 
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp8, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp11, NULL, 4);
 static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp8,
-	set_temp8, 1);
+	set_temp8, 0);
 static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp11,
 	set_temp11, 1);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp8,
-	set_temp8, 2);
+	set_temp8, 1);
 static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp11,
 	set_temp11, 2);
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp8,
-	set_temp8, 3);
+	set_temp8, 2);
 static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp8,
-	set_temp8, 4);
+	set_temp8, 3);
 static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temphyst,
-	set_temphyst, 3);
-static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temphyst, NULL, 4);
+	set_temphyst, 2);
+static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temphyst, NULL, 3);
 static SENSOR_DEVICE_ATTR(temp2_offset, S_IWUSR | S_IRUGO, show_temp11,
 	set_temp11, 3);
 
@@ -772,13 +776,21 @@ static struct lm90_data *lm90_update_dev
 		u8 h, l;
 
 		dev_dbg(&client->dev, "Updating lm90 data.\n");
-		lm90_read_reg(client, LM90_REG_R_LOCAL_TEMP, &data->temp8[0]);
-		lm90_read_reg(client, LM90_REG_R_LOCAL_LOW, &data->temp8[1]);
-		lm90_read_reg(client, LM90_REG_R_LOCAL_HIGH, &data->temp8[2]);
-		lm90_read_reg(client, LM90_REG_R_LOCAL_CRIT, &data->temp8[3]);
-		lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT, &data->temp8[4]);
+		lm90_read_reg(client, LM90_REG_R_LOCAL_LOW, &data->temp8[0]);
+		lm90_read_reg(client, LM90_REG_R_LOCAL_HIGH, &data->temp8[1]);
+		lm90_read_reg(client, LM90_REG_R_LOCAL_CRIT, &data->temp8[2]);
+		lm90_read_reg(client, LM90_REG_R_REMOTE_CRIT, &data->temp8[3]);
 		lm90_read_reg(client, LM90_REG_R_TCRIT_HYST, &data->temp_hyst);
 
+		if (data->kind = max6657) {
+			lm90_read16(client, LM90_REG_R_LOCAL_TEMP,
+				    MAX6657_REG_R_LOCAL_TEMPL,
+				    &data->temp11[4]);
+		} else {
+			if (lm90_read_reg(client, LM90_REG_R_LOCAL_TEMP,
+					  &h) = 0)
+				data->temp11[4] = h << 8;
+		}
 		lm90_read16(client, LM90_REG_R_REMOTE_TEMPH,
 			    LM90_REG_R_REMOTE_TEMPL, &data->temp11[0]);
 
--- linux-2.6.26-rc4.orig/Documentation/hwmon/lm90	2008-05-27 20:00:36.000000000 +0200
+++ linux-2.6.26-rc4/Documentation/hwmon/lm90	2008-05-27 21:53:06.000000000 +0200
@@ -86,9 +86,8 @@ family is that it features critical limi
 increased resolution of the remote temperature measurement.
 
 The different chipsets of the family are not strictly identical, although
-very similar. This driver doesn't handle any specific feature for now,
-with the exception of SMBus PEC. For reference, here comes a non-exhaustive
-list of specific features:
+very similar. For reference, here comes a non-exhaustive list of specific
+features:
 
 LM90:
   * Filter and alert configuration register at 0xBF.
@@ -114,9 +113,11 @@ ADT7461:
   * Lower resolution for remote temperature
 
 MAX6657 and MAX6658:
+  * Better local resolution
   * Remote sensor type selection
 
 MAX6659:
+  * Better local resolution
   * Selectable address
   * Second critical temperature limit
   * Remote sensor type selection
@@ -127,7 +128,8 @@ MAX6680 and MAX6681:
 
 All temperature values are given in degrees Celsius. Resolution
 is 1.0 degree for the local temperature, 0.125 degree for the remote
-temperature.
+temperature, except for the MAX6657, MAX6658 and MAX6659 which have a
+resolution of 0.125 degree for both temperatures.
 
 Each sensor has its own high and low limits, plus a critical limit.
 Additionally, there is a relative hysteresis value common to both critical


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
