From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:58:18 +0000
Subject: [lm-sensors] [patch 20/36] hwmon: (w83795) Properly handle negative
Message-Id: <20100915155818.258554db@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The temperature registers hold regular 2's complement values, no need
to add any arithmetics.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:13:50.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:13:52.000000000 +0200
@@ -295,7 +295,7 @@ static inline long temp_from_reg(s8 reg)
 
 static inline s8 temp_to_reg(long val, s8 min, s8 max)
 {
-	return SENSORS_LIMIT((val < 0 ? -val : val) / 1000, min, max);
+	return SENSORS_LIMIT(val / 1000, min, max);
 }
 
 static const u16 pwm_freq_cksel0[16] = {
@@ -364,7 +364,7 @@ struct w83795_data {
 	u16 fan_min[14];	/* Register value combine */
 
 	u8 has_temp;		/* Enable monitor temp6-1 or not */
-	u8 temp[6][5];		/* current, crit, crit_hyst, warn, warn_hyst */
+	s8 temp[6][5];		/* current, crit, crit_hyst, warn, warn_hyst */
 	u8 temp_read_vrlsb[6];
 	u8 temp_mode;		/* bit 0: TR mode, bit 1: TD mode */
 	u8 temp_src[3];		/* Register value */
@@ -373,9 +373,9 @@ struct w83795_data {
 				 * bit 0: =1 enable, =0 disable,
 				 * bit 1: =1 AMD SB-TSI, =0 Intel PECI */
 	u8 has_dts;		/* Enable monitor DTS temp */
-	u8 dts[8];		/* Register value */
+	s8 dts[8];		/* Register value */
 	u8 dts_read_vrlsb[8];	/* Register value */
-	u8 dts_ext[4];		/* Register value */
+	s8 dts_ext[4];		/* Register value */
 
 	u8 has_pwm;		/* 795g supports 8 pwm, 795adg only supports 2,
 				 * no config register, only affected by chip
@@ -1170,13 +1170,11 @@ show_temp(struct device *dev, struct dev
 	int nr = sensor_attr->nr;
 	int index = sensor_attr->index;
 	struct w83795_data *data = w83795_update_device(dev);
-	long temp = temp_from_reg(data->temp[index][nr] & 0x7f);
+	long temp = temp_from_reg(data->temp[index][nr]);
 
 	if (TEMP_READ = nr)
 		temp += ((data->temp_read_vrlsb[index] >> VRLSB_SHIFT) & 0x03)
 			* 250;
-	if (data->temp[index][nr] & 0x80)
-		temp = -temp;
 	return sprintf(buf, "%ld\n", temp);
 }
 
@@ -1235,11 +1233,9 @@ show_dts(struct device *dev, struct devi
 	    to_sensor_dev_attr_2(attr);
 	int index = sensor_attr->index;
 	struct w83795_data *data = w83795_update_device(dev);
-	long temp = temp_from_reg(data->dts[index] & 0x7f);
+	long temp = temp_from_reg(data->dts[index]);
 
 	temp += ((data->dts_read_vrlsb[index] >> VRLSB_SHIFT) & 0x03) * 250;
-	if (data->dts[index] & 0x80)
-		temp = -temp;
 	return sprintf(buf, "%ld\n", temp);
 }
 
@@ -1251,10 +1247,8 @@ show_dts_ext(struct device *dev, struct
 	int nr = sensor_attr->nr;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83795_data *data = i2c_get_clientdata(client);
-	long temp = temp_from_reg(data->dts_ext[nr] & 0x7f);
+	long temp = temp_from_reg(data->dts_ext[nr]);
 
-	if (data->dts_ext[nr] & 0x80)
-		temp = -temp;
 	return sprintf(buf, "%ld\n", temp);
 }
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
