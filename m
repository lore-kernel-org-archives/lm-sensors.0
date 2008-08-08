From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 08 Aug 2008 12:32:10 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (dme1737) Be less i2c-centric
Message-Id: <20080808143210.41e1ef55@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: Michal =?ISO-8859-1?B?TWVkdmVja/0=?= <michal-2MYblgRXpuPk1uMJSBkQmQ@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

The dme1737 driver support both LPC (ISA) and SMBus devices. At the
moment it's rather i2c-centric, and LPC variants use a fake i2c_client
for some operations.

In a near future, i2c_client will be allocated by i2c-core rather than
by the device drivers, so non-i2c drivers will not have one. As a
preparation step, change the driver code to no longer assume that
an i2c_client structure is always available. No functional change.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Juerg Haefliger <juergh@gmail.com>
---
 drivers/hwmon/dme1737.c |  226 +++++++++++++++++++++++------------------------
 1 file changed, 111 insertions(+), 115 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/dme1737.c	2008-07-07 16:31:31.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/dme1737.c	2008-07-07 17:04:01.000000000 +0200
@@ -175,11 +175,12 @@ static const u8 DME1737_BIT_ALARM_FAN[] 
  * Data structures and manipulation thereof
  * --------------------------------------------------------------------- */
 
-/* For ISA chips, we abuse the i2c_client addr and name fields. We also use
-   the driver field to differentiate between I2C and ISA chips. */
 struct dme1737_data {
-	struct i2c_client client;
+	struct i2c_client _client;	/* will go away soon */
+	struct i2c_client *client;	/* for I2C devices only */
 	struct device *hwmon_dev;
+	const char *name;
+	unsigned int addr;		/* for ISA devices only */
 
 	struct mutex update_lock;
 	int valid;			/* !=0 if following fields are valid */
@@ -512,11 +513,12 @@ static inline int PWM_OFF_TO_REG(int val
  * before calling dme1737_read or dme1737_write.
  * --------------------------------------------------------------------- */
 
-static u8 dme1737_read(struct i2c_client *client, u8 reg)
+static u8 dme1737_read(const struct dme1737_data *data, u8 reg)
 {
+	struct i2c_client *client = data->client;
 	s32 val;
 
-	if (client->driver) { /* I2C device */
+	if (client) { /* I2C device */
 		val = i2c_smbus_read_byte_data(client, reg);
 
 		if (val < 0) {
@@ -525,18 +527,19 @@ static u8 dme1737_read(struct i2c_client
 				 "maintainer.\n", reg);
 		}
 	} else { /* ISA device */
-		outb(reg, client->addr);
-		val = inb(client->addr + 1);
+		outb(reg, data->addr);
+		val = inb(data->addr + 1);
 	}
 
 	return val;
 }
 
-static s32 dme1737_write(struct i2c_client *client, u8 reg, u8 val)
+static s32 dme1737_write(const struct dme1737_data *data, u8 reg, u8 val)
 {
+	struct i2c_client *client = data->client;
 	s32 res = 0;
 
-	if (client->driver) { /* I2C device */
+	if (client) { /* I2C device */
 		res = i2c_smbus_write_byte_data(client, reg, val);
 
 		if (res < 0) {
@@ -545,8 +548,8 @@ static s32 dme1737_write(struct i2c_clie
 				 "maintainer.\n", reg);
 		}
 	} else { /* ISA device */
-		outb(reg, client->addr);
-		outb(val, client->addr + 1);
+		outb(reg, data->addr);
+		outb(val, data->addr + 1);
 	}
 
 	return res;
@@ -555,7 +558,6 @@ static s32 dme1737_write(struct i2c_clie
 static struct dme1737_data *dme1737_update_device(struct device *dev)
 {
 	struct dme1737_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	int ix;
 	u8 lsb[5];
 
@@ -563,7 +565,7 @@ static struct dme1737_data *dme1737_upda
 
 	/* Enable a Vbat monitoring cycle every 10 mins */
 	if (time_after(jiffies, data->last_vbat + 600 * HZ) || !data->valid) {
-		dme1737_write(client, DME1737_REG_CONFIG, dme1737_read(client,
+		dme1737_write(data, DME1737_REG_CONFIG, dme1737_read(data,
 						DME1737_REG_CONFIG) | 0x10);
 		data->last_vbat = jiffies;
 	}
@@ -571,7 +573,7 @@ static struct dme1737_data *dme1737_upda
 	/* Sample register contents every 1 sec */
 	if (time_after(jiffies, data->last_update + HZ) || !data->valid) {
 		if (data->type != sch5027) {
-			data->vid = dme1737_read(client, DME1737_REG_VID) &
+			data->vid = dme1737_read(data, DME1737_REG_VID) &
 				0x3f;
 		}
 
@@ -580,11 +582,11 @@ static struct dme1737_data *dme1737_upda
 			/* Voltage inputs are stored as 16 bit values even
 			 * though they have only 12 bits resolution. This is
 			 * to make it consistent with the temp inputs. */
-			data->in[ix] = dme1737_read(client,
+			data->in[ix] = dme1737_read(data,
 					DME1737_REG_IN(ix)) << 8;
-			data->in_min[ix] = dme1737_read(client,
+			data->in_min[ix] = dme1737_read(data,
 					DME1737_REG_IN_MIN(ix));
-			data->in_max[ix] = dme1737_read(client,
+			data->in_max[ix] = dme1737_read(data,
 					DME1737_REG_IN_MAX(ix));
 		}
 
@@ -595,14 +597,14 @@ static struct dme1737_data *dme1737_upda
 			 * to take advantage of implicit conversions between
 			 * register values (2's complement) and temp values
 			 * (signed decimal). */
-			data->temp[ix] = dme1737_read(client,
+			data->temp[ix] = dme1737_read(data,
 					DME1737_REG_TEMP(ix)) << 8;
-			data->temp_min[ix] = dme1737_read(client,
+			data->temp_min[ix] = dme1737_read(data,
 					DME1737_REG_TEMP_MIN(ix));
-			data->temp_max[ix] = dme1737_read(client,
+			data->temp_max[ix] = dme1737_read(data,
 					DME1737_REG_TEMP_MAX(ix));
 			if (data->type != sch5027) {
-				data->temp_offset[ix] = dme1737_read(client,
+				data->temp_offset[ix] = dme1737_read(data,
 						DME1737_REG_TEMP_OFFSET(ix));
 			}
 		}
@@ -612,7 +614,7 @@ static struct dme1737_data *dme1737_upda
 		 * which the registers are read (MSB first, then LSB) is
 		 * important! */
 		for (ix = 0; ix < ARRAY_SIZE(lsb); ix++) {
-			lsb[ix] = dme1737_read(client,
+			lsb[ix] = dme1737_read(data,
 					DME1737_REG_IN_TEMP_LSB(ix));
 		}
 		for (ix = 0; ix < ARRAY_SIZE(data->in); ix++) {
@@ -631,19 +633,19 @@ static struct dme1737_data *dme1737_upda
 			if (!(data->has_fan & (1 << ix))) {
 				continue;
 			}
-			data->fan[ix] = dme1737_read(client,
+			data->fan[ix] = dme1737_read(data,
 					DME1737_REG_FAN(ix));
-			data->fan[ix] |= dme1737_read(client,
+			data->fan[ix] |= dme1737_read(data,
 					DME1737_REG_FAN(ix) + 1) << 8;
-			data->fan_min[ix] = dme1737_read(client,
+			data->fan_min[ix] = dme1737_read(data,
 					DME1737_REG_FAN_MIN(ix));
-			data->fan_min[ix] |= dme1737_read(client,
+			data->fan_min[ix] |= dme1737_read(data,
 					DME1737_REG_FAN_MIN(ix) + 1) << 8;
-			data->fan_opt[ix] = dme1737_read(client,
+			data->fan_opt[ix] = dme1737_read(data,
 					DME1737_REG_FAN_OPT(ix));
 			/* fan_max exists only for fan[5-6] */
 			if (ix > 3) {
-				data->fan_max[ix - 4] = dme1737_read(client,
+				data->fan_max[ix - 4] = dme1737_read(data,
 					DME1737_REG_FAN_MAX(ix));
 			}
 		}
@@ -655,63 +657,63 @@ static struct dme1737_data *dme1737_upda
 			if (!(data->has_pwm & (1 << ix))) {
 				continue;
 			}
-			data->pwm[ix] = dme1737_read(client,
+			data->pwm[ix] = dme1737_read(data,
 					DME1737_REG_PWM(ix));
-			data->pwm_freq[ix] = dme1737_read(client,
+			data->pwm_freq[ix] = dme1737_read(data,
 					DME1737_REG_PWM_FREQ(ix));
 			/* pwm_config and pwm_min exist only for pwm[1-3] */
 			if (ix < 3) {
-				data->pwm_config[ix] = dme1737_read(client,
+				data->pwm_config[ix] = dme1737_read(data,
 						DME1737_REG_PWM_CONFIG(ix));
-				data->pwm_min[ix] = dme1737_read(client,
+				data->pwm_min[ix] = dme1737_read(data,
 						DME1737_REG_PWM_MIN(ix));
 			}
 		}
 		for (ix = 0; ix < ARRAY_SIZE(data->pwm_rr); ix++) {
-			data->pwm_rr[ix] = dme1737_read(client,
+			data->pwm_rr[ix] = dme1737_read(data,
 						DME1737_REG_PWM_RR(ix));
 		}
 
 		/* Thermal zone registers */
 		for (ix = 0; ix < ARRAY_SIZE(data->zone_low); ix++) {
-			data->zone_low[ix] = dme1737_read(client,
+			data->zone_low[ix] = dme1737_read(data,
 					DME1737_REG_ZONE_LOW(ix));
-			data->zone_abs[ix] = dme1737_read(client,
+			data->zone_abs[ix] = dme1737_read(data,
 					DME1737_REG_ZONE_ABS(ix));
 		}
 		if (data->type != sch5027) {
 			for (ix = 0; ix < ARRAY_SIZE(data->zone_hyst); ix++) {
-				data->zone_hyst[ix] = dme1737_read(client,
+				data->zone_hyst[ix] = dme1737_read(data,
 						DME1737_REG_ZONE_HYST(ix));
 			}
 		}
 
 		/* Alarm registers */
-		data->alarms = dme1737_read(client,
+		data->alarms = dme1737_read(data,
 						DME1737_REG_ALARM1);
 		/* Bit 7 tells us if the other alarm registers are non-zero and
 		 * therefore also need to be read */
 		if (data->alarms & 0x80) {
-			data->alarms |= dme1737_read(client,
+			data->alarms |= dme1737_read(data,
 						DME1737_REG_ALARM2) << 8;
-			data->alarms |= dme1737_read(client,
+			data->alarms |= dme1737_read(data,
 						DME1737_REG_ALARM3) << 16;
 		}
 
 		/* The ISA chips require explicit clearing of alarm bits.
 		 * Don't worry, an alarm will come back if the condition
 		 * that causes it still exists */
-		if (!client->driver) {
+		if (!data->client) {
 			if (data->alarms & 0xff0000) {
-				dme1737_write(client, DME1737_REG_ALARM3,
+				dme1737_write(data, DME1737_REG_ALARM3,
 					      0xff);
 			}
 			if (data->alarms & 0xff00) {
-				dme1737_write(client, DME1737_REG_ALARM2,
+				dme1737_write(data, DME1737_REG_ALARM2,
 					      0xff);
 			}
 			if (data->alarms & 0xff) {
-				dme1737_write(client, DME1737_REG_ALARM1,
+				dme1737_write(data, DME1737_REG_ALARM1,
 					      0xff);
 			}
 		}
@@ -770,7 +772,6 @@ static ssize_t set_in(struct device *dev
 		      const char *buf, size_t count)
 {
 	struct dme1737_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	struct sensor_device_attribute_2
 		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
@@ -781,12 +782,12 @@ static ssize_t set_in(struct device *dev
 	switch (fn) {
 	case SYS_IN_MIN:
 		data->in_min[ix] = IN_TO_REG(val, data->in_nominal[ix]);
-		dme1737_write(client, DME1737_REG_IN_MIN(ix),
+		dme1737_write(data, DME1737_REG_IN_MIN(ix),
 			      data->in_min[ix]);
 		break;
 	case SYS_IN_MAX:
 		data->in_max[ix] = IN_TO_REG(val, data->in_nominal[ix]);
-		dme1737_write(client, DME1737_REG_IN_MAX(ix),
+		dme1737_write(data, DME1737_REG_IN_MAX(ix),
 			      data->in_max[ix]);
 		break;
 	default:
@@ -850,7 +851,6 @@ static ssize_t set_temp(struct device *d
 			const char *buf, size_t count)
 {
 	struct dme1737_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	struct sensor_device_attribute_2
 		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
@@ -861,17 +861,17 @@ static ssize_t set_temp(struct device *d
 	switch (fn) {
 	case SYS_TEMP_MIN:
 		data->temp_min[ix] = TEMP_TO_REG(val);
-		dme1737_write(client, DME1737_REG_TEMP_MIN(ix),
+		dme1737_write(data, DME1737_REG_TEMP_MIN(ix),
 			      data->temp_min[ix]);
 		break;
 	case SYS_TEMP_MAX:
 		data->temp_max[ix] = TEMP_TO_REG(val);
-		dme1737_write(client, DME1737_REG_TEMP_MAX(ix),
+		dme1737_write(data, DME1737_REG_TEMP_MAX(ix),
 			      data->temp_max[ix]);
 		break;
 	case SYS_TEMP_OFFSET:
 		data->temp_offset[ix] = TEMP_TO_REG(val);
-		dme1737_write(client, DME1737_REG_TEMP_OFFSET(ix),
+		dme1737_write(data, DME1737_REG_TEMP_OFFSET(ix),
 			      data->temp_offset[ix]);
 		break;
 	default:
@@ -939,7 +939,6 @@ static ssize_t set_zone(struct device *d
 			const char *buf, size_t count)
 {
 	struct dme1737_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	struct sensor_device_attribute_2
 		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
@@ -950,37 +949,37 @@ static ssize_t set_zone(struct device *d
 	switch (fn) {
 	case SYS_ZONE_AUTO_POINT1_TEMP_HYST:
 		/* Refresh the cache */
-		data->zone_low[ix] = dme1737_read(client,
+		data->zone_low[ix] = dme1737_read(data,
 						  DME1737_REG_ZONE_LOW(ix));
 		/* Modify the temp hyst value */
 		data->zone_hyst[ix = 2] = TEMP_HYST_TO_REG(
 					TEMP_FROM_REG(data->zone_low[ix], 8) -
-					val, ix, dme1737_read(client,
+					val, ix, dme1737_read(data,
 					DME1737_REG_ZONE_HYST(ix = 2)));
-		dme1737_write(client, DME1737_REG_ZONE_HYST(ix = 2),
+		dme1737_write(data, DME1737_REG_ZONE_HYST(ix = 2),
 			      data->zone_hyst[ix = 2]);
 		break;
 	case SYS_ZONE_AUTO_POINT1_TEMP:
 		data->zone_low[ix] = TEMP_TO_REG(val);
-		dme1737_write(client, DME1737_REG_ZONE_LOW(ix),
+		dme1737_write(data, DME1737_REG_ZONE_LOW(ix),
 			      data->zone_low[ix]);
 		break;
 	case SYS_ZONE_AUTO_POINT2_TEMP:
 		/* Refresh the cache */
-		data->zone_low[ix] = dme1737_read(client,
+		data->zone_low[ix] = dme1737_read(data,
 						  DME1737_REG_ZONE_LOW(ix));
 		/* Modify the temp range value (which is stored in the upper
 		 * nibble of the pwm_freq register) */
 		data->pwm_freq[ix] = TEMP_RANGE_TO_REG(val -
 					TEMP_FROM_REG(data->zone_low[ix], 8),
-					dme1737_read(client,
+					dme1737_read(data,
 					DME1737_REG_PWM_FREQ(ix)));
-		dme1737_write(client, DME1737_REG_PWM_FREQ(ix),
+		dme1737_write(data, DME1737_REG_PWM_FREQ(ix),
 			      data->pwm_freq[ix]);
 		break;
 	case SYS_ZONE_AUTO_POINT3_TEMP:
 		data->zone_abs[ix] = TEMP_TO_REG(val);
-		dme1737_write(client, DME1737_REG_ZONE_ABS(ix),
+		dme1737_write(data, DME1737_REG_ZONE_ABS(ix),
 			      data->zone_abs[ix]);
 		break;
 	default:
@@ -1046,7 +1045,6 @@ static ssize_t set_fan(struct device *de
 		       const char *buf, size_t count)
 {
 	struct dme1737_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	struct sensor_device_attribute_2
 		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
@@ -1060,21 +1058,21 @@ static ssize_t set_fan(struct device *de
 			data->fan_min[ix] = FAN_TO_REG(val, 0);
 		} else {
 			/* Refresh the cache */
-			data->fan_opt[ix] = dme1737_read(client,
+			data->fan_opt[ix] = dme1737_read(data,
 						DME1737_REG_FAN_OPT(ix));
 			/* Modify the fan min value */
 			data->fan_min[ix] = FAN_TO_REG(val,
 					FAN_TPC_FROM_REG(data->fan_opt[ix]));
 		}
-		dme1737_write(client, DME1737_REG_FAN_MIN(ix),
+		dme1737_write(data, DME1737_REG_FAN_MIN(ix),
 			      data->fan_min[ix] & 0xff);
-		dme1737_write(client, DME1737_REG_FAN_MIN(ix) + 1,
+		dme1737_write(data, DME1737_REG_FAN_MIN(ix) + 1,
 			      data->fan_min[ix] >> 8);
 		break;
 	case SYS_FAN_MAX:
 		/* Only valid for fan[5-6] */
 		data->fan_max[ix - 4] = FAN_MAX_TO_REG(val);
-		dme1737_write(client, DME1737_REG_FAN_MAX(ix),
+		dme1737_write(data, DME1737_REG_FAN_MAX(ix),
 			      data->fan_max[ix - 4]);
 		break;
 	case SYS_FAN_TYPE:
@@ -1086,9 +1084,9 @@ static ssize_t set_fan(struct device *de
 				 val);
 			goto exit;
 		}
-		data->fan_opt[ix] = FAN_TYPE_TO_REG(val, dme1737_read(client,
+		data->fan_opt[ix] = FAN_TYPE_TO_REG(val, dme1737_read(data,
 					DME1737_REG_FAN_OPT(ix)));
-		dme1737_write(client, DME1737_REG_FAN_OPT(ix),
+		dme1737_write(data, DME1737_REG_FAN_OPT(ix),
 			      data->fan_opt[ix]);
 		break;
 	default:
@@ -1185,7 +1183,6 @@ static ssize_t set_pwm(struct device *de
 		       const char *buf, size_t count)
 {
 	struct dme1737_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
 	struct sensor_device_attribute_2
 		*sensor_attr_2 = to_sensor_dev_attr_2(attr);
 	int ix = sensor_attr_2->index;
@@ -1196,12 +1193,12 @@ static ssize_t set_pwm(struct device *de
 	switch (fn) {
 	case SYS_PWM:
 		data->pwm[ix] = SENSORS_LIMIT(val, 0, 255);
-		dme1737_write(client, DME1737_REG_PWM(ix), data->pwm[ix]);
+		dme1737_write(data, DME1737_REG_PWM(ix), data->pwm[ix]);
 		break;
 	case SYS_PWM_FREQ:
-		data->pwm_freq[ix] = PWM_FREQ_TO_REG(val, dme1737_read(client,
+		data->pwm_freq[ix] = PWM_FREQ_TO_REG(val, dme1737_read(data,
 						DME1737_REG_PWM_FREQ(ix)));
-		dme1737_write(client, DME1737_REG_PWM_FREQ(ix),
+		dme1737_write(data, DME1737_REG_PWM_FREQ(ix),
 			      data->pwm_freq[ix]);
 		break;
 	case SYS_PWM_ENABLE:
@@ -1214,7 +1211,7 @@ static ssize_t set_pwm(struct device *de
 			goto exit;
 		}
 		/* Refresh the cache */
-		data->pwm_config[ix] = dme1737_read(client,
+		data->pwm_config[ix] = dme1737_read(data,
 						DME1737_REG_PWM_CONFIG(ix));
 		if (val = PWM_EN_FROM_REG(data->pwm_config[ix])) {
 			/* Bail out if no change */
@@ -1226,14 +1223,14 @@ static ssize_t set_pwm(struct device *de
 			data->pwm_acz[ix] = PWM_ACZ_FROM_REG(
 							data->pwm_config[ix]);
 			/* Save the current ramp rate state and disable it */
-			data->pwm_rr[ix > 0] = dme1737_read(client,
+			data->pwm_rr[ix > 0] = dme1737_read(data,
 						DME1737_REG_PWM_RR(ix > 0));
 			data->pwm_rr_en &= ~(1 << ix);
 			if (PWM_RR_EN_FROM_REG(data->pwm_rr[ix > 0], ix)) {
 				data->pwm_rr_en |= (1 << ix);
 				data->pwm_rr[ix > 0] = PWM_RR_EN_TO_REG(0, ix,
 							data->pwm_rr[ix > 0]);
-				dme1737_write(client,
+				dme1737_write(data,
 					      DME1737_REG_PWM_RR(ix > 0),
 					      data->pwm_rr[ix > 0]);
 			}
@@ -1247,14 +1244,14 @@ static ssize_t set_pwm(struct device *de
 			/* Turn fan fully on */
 			data->pwm_config[ix] = PWM_EN_TO_REG(0,
 							data->pwm_config[ix]);
-			dme1737_write(client, DME1737_REG_PWM_CONFIG(ix),
+			dme1737_write(data, DME1737_REG_PWM_CONFIG(ix),
 				      data->pwm_config[ix]);
 			break;
 		case 1:
 			/* Turn on manual mode */
 			data->pwm_config[ix] = PWM_EN_TO_REG(1,
 							data->pwm_config[ix]);
-			dme1737_write(client, DME1737_REG_PWM_CONFIG(ix),
+			dme1737_write(data, DME1737_REG_PWM_CONFIG(ix),
 				      data->pwm_config[ix]);
 			/* Change permissions of pwm[ix] to read-writeable */
 			dme1737_chmod_file(dev, dme1737_pwm_chmod_attr[ix],
@@ -1269,14 +1266,14 @@ static ssize_t set_pwm(struct device *de
 			data->pwm_config[ix] = PWM_ACZ_TO_REG(
 							data->pwm_acz[ix],
 							data->pwm_config[ix]);
-			dme1737_write(client, DME1737_REG_PWM_CONFIG(ix),
+			dme1737_write(data, DME1737_REG_PWM_CONFIG(ix),
 				      data->pwm_config[ix]);
 			/* Enable PWM ramp rate if previously enabled */
 			if (data->pwm_rr_en & (1 << ix)) {
 				data->pwm_rr[ix > 0] = PWM_RR_EN_TO_REG(1, ix,
-						dme1737_read(client,
+						dme1737_read(data,
 						DME1737_REG_PWM_RR(ix > 0)));
-				dme1737_write(client,
+				dme1737_write(data,
 					      DME1737_REG_PWM_RR(ix > 0),
 					      data->pwm_rr[ix > 0]);
 			}
@@ -1286,9 +1283,9 @@ static ssize_t set_pwm(struct device *de
 	case SYS_PWM_RAMP_RATE:
 		/* Only valid for pwm[1-3] */
 		/* Refresh the cache */
-		data->pwm_config[ix] = dme1737_read(client,
+		data->pwm_config[ix] = dme1737_read(data,
 						DME1737_REG_PWM_CONFIG(ix));
-		data->pwm_rr[ix > 0] = dme1737_read(client,
+		data->pwm_rr[ix > 0] = dme1737_read(data,
 						DME1737_REG_PWM_RR(ix > 0));
 		/* Set the ramp rate value */
 		if (val > 0) {
@@ -1301,7 +1298,7 @@ static ssize_t set_pwm(struct device *de
 			data->pwm_rr[ix > 0] = PWM_RR_EN_TO_REG(val > 0, ix,
 							data->pwm_rr[ix > 0]);
 		}
-		dme1737_write(client, DME1737_REG_PWM_RR(ix > 0),
+		dme1737_write(data, DME1737_REG_PWM_RR(ix > 0),
 			      data->pwm_rr[ix > 0]);
 		break;
 	case SYS_PWM_AUTO_CHANNELS_ZONE:
@@ -1315,14 +1312,14 @@ static ssize_t set_pwm(struct device *de
 			goto exit;
 		}
 		/* Refresh the cache */
-		data->pwm_config[ix] = dme1737_read(client,
+		data->pwm_config[ix] = dme1737_read(data,
 						DME1737_REG_PWM_CONFIG(ix));
 		if (PWM_EN_FROM_REG(data->pwm_config[ix]) = 2) {
 			/* PWM is already in auto mode so update the temp
 			 * channel assignment */
 			data->pwm_config[ix] = PWM_ACZ_TO_REG(val,
 						data->pwm_config[ix]);
-			dme1737_write(client, DME1737_REG_PWM_CONFIG(ix),
+			dme1737_write(data, DME1737_REG_PWM_CONFIG(ix),
 				      data->pwm_config[ix]);
 		} else {
 			/* PWM is not in auto mode so we save the temp
@@ -1333,7 +1330,7 @@ static ssize_t set_pwm(struct device *de
 	case SYS_PWM_AUTO_PWM_MIN:
 		/* Only valid for pwm[1-3] */
 		/* Refresh the cache */
-		data->pwm_min[ix] = dme1737_read(client,
+		data->pwm_min[ix] = dme1737_read(data,
 						DME1737_REG_PWM_MIN(ix));
 		/* There are only 2 values supported for the auto_pwm_min
 		 * value: 0 or auto_point1_pwm. So if the temperature drops
@@ -1341,20 +1338,20 @@ static ssize_t set_pwm(struct device *de
 		 * off or runs at auto_point1_pwm duty-cycle. */
 		if (val > ((data->pwm_min[ix] + 1) / 2)) {
 			data->pwm_rr[0] = PWM_OFF_TO_REG(1, ix,
-						dme1737_read(client,
+						dme1737_read(data,
 						DME1737_REG_PWM_RR(0)));
 		} else {
 			data->pwm_rr[0] = PWM_OFF_TO_REG(0, ix,
-						dme1737_read(client,
+						dme1737_read(data,
 						DME1737_REG_PWM_RR(0)));
 		}
-		dme1737_write(client, DME1737_REG_PWM_RR(0),
+		dme1737_write(data, DME1737_REG_PWM_RR(0),
 			      data->pwm_rr[0]);
 		break;
 	case SYS_PWM_AUTO_POINT1_PWM:
 		/* Only valid for pwm[1-3] */
 		data->pwm_min[ix] = SENSORS_LIMIT(val, 0, 255);
-		dme1737_write(client, DME1737_REG_PWM_MIN(ix),
+		dme1737_write(data, DME1737_REG_PWM_MIN(ix),
 			      data->pwm_min[ix]);
 		break;
 	default:
@@ -1402,7 +1399,7 @@ static ssize_t show_name(struct device *
 {
 	struct dme1737_data *data = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%s\n", data->client.name);
+	return sprintf(buf, "%s\n", data->name);
 }
 
 /* ---------------------------------------------------------------------
@@ -1908,7 +1905,7 @@ static void dme1737_remove_files(struct 
 
 	sysfs_remove_group(&dev->kobj, &dme1737_group);
 
-	if (!data->client.driver) {
+	if (!data->client) {
 		sysfs_remove_file(&dev->kobj, &dev_attr_name.attr);
 	}
 }
@@ -1919,7 +1916,7 @@ static int dme1737_create_files(struct d
 	int err, ix;
 
 	/* Create a name attribute for ISA devices */
-	if (!data->client.driver &&
+	if (!data->client &&
 	    (err = sysfs_create_file(&dev->kobj, &dev_attr_name.attr))) {
 		goto exit;
 	}
@@ -2013,14 +2010,14 @@ exit:
 static int dme1737_init_device(struct device *dev)
 {
 	struct dme1737_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = &data->client;
+	struct i2c_client *client = data->client;
 	int ix;
 	u8 reg;
 
 	/* Point to the right nominal voltages array */
 	data->in_nominal = IN_NOMINAL(data->type);
 
-	data->config = dme1737_read(client, DME1737_REG_CONFIG);
+	data->config = dme1737_read(data, DME1737_REG_CONFIG);
 	/* Inform if part is not monitoring/started */
 	if (!(data->config & 0x01)) {
 		if (!force_start) {
@@ -2032,7 +2029,7 @@ static int dme1737_init_device(struct de
 
 		/* Force monitoring */
 		data->config |= 0x01;
-		dme1737_write(client, DME1737_REG_CONFIG, data->config);
+		dme1737_write(data, DME1737_REG_CONFIG, data->config);
 	}
 	/* Inform if part is not ready */
 	if (!(data->config & 0x04)) {
@@ -2041,8 +2038,8 @@ static int dme1737_init_device(struct de
 	}
 
 	/* Determine which optional fan and pwm features are enabled/present */
-	if (client->driver) {   /* I2C chip */
-		data->config2 = dme1737_read(client, DME1737_REG_CONFIG2);
+	if (client) {   /* I2C chip */
+		data->config2 = dme1737_read(data, DME1737_REG_CONFIG2);
 		/* Check if optional fan3 input is enabled */
 		if (data->config2 & 0x04) {
 			data->has_fan |= (1 << 2);
@@ -2051,7 +2048,7 @@ static int dme1737_init_device(struct de
 		/* Fan4 and pwm3 are only available if the client's I2C address
 		 * is the default 0x2e. Otherwise the I/Os associated with
 		 * these functions are used for addr enable/select. */
-		if (data->client.addr = 0x2e) {
+		if (client->addr = 0x2e) {
 			data->has_fan |= (1 << 3);
 			data->has_pwm |= (1 << 2);
 		}
@@ -2086,16 +2083,16 @@ static int dme1737_init_device(struct de
 		 (data->has_fan & (1 << 4)) ? "yes" : "no",
 		 (data->has_fan & (1 << 5)) ? "yes" : "no");
 
-	reg = dme1737_read(client, DME1737_REG_TACH_PWM);
+	reg = dme1737_read(data, DME1737_REG_TACH_PWM);
 	/* Inform if fan-to-pwm mapping differs from the default */
-	if (client->driver && reg != 0xa4) {   /* I2C chip */
+	if (client && reg != 0xa4) {   /* I2C chip */
 		dev_warn(dev, "Non-standard fan to pwm mapping: "
 			 "fan1->pwm%d, fan2->pwm%d, fan3->pwm%d, "
 			 "fan4->pwm%d. Please report to the driver "
 			 "maintainer.\n",
 			 (reg & 0x03) + 1, ((reg >> 2) & 0x03) + 1,
 			 ((reg >> 4) & 0x03) + 1, ((reg >> 6) & 0x03) + 1);
-	} else if (!client->driver && reg != 0x24) {   /* ISA chip */
+	} else if (!client && reg != 0x24) {   /* ISA chip */
 		dev_warn(dev, "Non-standard fan to pwm mapping: "
 			 "fan1->pwm%d, fan2->pwm%d, fan3->pwm%d. "
 			 "Please report to the driver maintainer.\n",
@@ -2108,7 +2105,7 @@ static int dme1737_init_device(struct de
 	 * disabled). */
 	if (!(data->config & 0x02)) {
 		for (ix = 0; ix < 3; ix++) {
-			data->pwm_config[ix] = dme1737_read(client,
+			data->pwm_config[ix] = dme1737_read(data,
 						DME1737_REG_PWM_CONFIG(ix));
 			if ((data->has_pwm & (1 << ix)) &&
 			    (PWM_EN_FROM_REG(data->pwm_config[ix]) = -1)) {
@@ -2116,8 +2113,8 @@ static int dme1737_init_device(struct de
 					 "manual mode.\n", ix + 1);
 				data->pwm_config[ix] = PWM_EN_TO_REG(1,
 							data->pwm_config[ix]);
-				dme1737_write(client, DME1737_REG_PWM(ix), 0);
-				dme1737_write(client,
+				dme1737_write(data, DME1737_REG_PWM(ix), 0);
+				dme1737_write(data,
 					      DME1737_REG_PWM_CONFIG(ix),
 					      data->pwm_config[ix]);
 			}
@@ -2210,7 +2207,8 @@ static int dme1737_i2c_detect(struct i2c
 		goto exit;
 	}
 
-	client = &data->client;
+	client = &data->_client;
+	data->client = client;
 	i2c_set_clientdata(client, data);
 	client->addr = address;
 	client->adapter = adapter;
@@ -2220,8 +2218,8 @@ static int dme1737_i2c_detect(struct i2c
 	/* A negative kind means that the driver was loaded with no force
 	 * parameter (default), so we must identify the chip. */
 	if (kind < 0) {
-		company = dme1737_read(client, DME1737_REG_COMPANY);
-		verstep = dme1737_read(client, DME1737_REG_VERSTEP);
+		company = dme1737_read(data, DME1737_REG_COMPANY);
+		verstep = dme1737_read(data, DME1737_REG_VERSTEP);
 
 		if (company = DME1737_COMPANY_SMSC &&
 		    (verstep & DME1737_VERSTEP_MASK) = DME1737_VERSTEP) {
@@ -2246,6 +2244,7 @@ static int dme1737_i2c_detect(struct i2c
 	/* Fill in the remaining client fields and put it into the global
 	 * list */
 	strlcpy(client->name, name, I2C_NAME_SIZE);
+	data->name = client->name;
 	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
@@ -2403,7 +2402,6 @@ static int __devinit dme1737_isa_probe(s
 {
 	u8 company, device;
 	struct resource *res;
-	struct i2c_client *client;
 	struct dme1737_data *data;
 	struct device *dev = &pdev->dev;
 	int err;
@@ -2422,15 +2420,13 @@ static int __devinit dme1737_isa_probe(s
 		goto exit_release_region;
 	}
 
-	client = &data->client;
-	i2c_set_clientdata(client, data);
-	client->addr = res->start;
+	data->addr = res->start;
 	platform_set_drvdata(pdev, data);
 
 	/* Skip chip detection if module is loaded with force_id parameter */
 	if (!force_id) {
-		company = dme1737_read(client, DME1737_REG_COMPANY);
-		device = dme1737_read(client, DME1737_REG_DEVICE);
+		company = dme1737_read(data, DME1737_REG_COMPANY);
+		device = dme1737_read(data, DME1737_REG_DEVICE);
 
 		if (!((company = DME1737_COMPANY_SMSC) &&
 		      (device = SCH311X_DEVICE))) {
@@ -2441,10 +2437,10 @@ static int __devinit dme1737_isa_probe(s
 	data->type = sch311x;
 
 	/* Fill in the remaining client fields and initialize the mutex */
-	strlcpy(client->name, "sch311x", I2C_NAME_SIZE);
+	data->name = "sch311x";
 	mutex_init(&data->update_lock);
 
-	dev_info(dev, "Found a SCH311x chip at 0x%04x\n", client->addr);
+	dev_info(dev, "Found a SCH311x chip at 0x%04x\n", data->addr);
 
 	/* Initialize the chip */
 	if ((err = dme1737_init_device(dev))) {
@@ -2485,7 +2481,7 @@ static int __devexit dme1737_isa_remove(
 
 	hwmon_device_unregister(data->hwmon_dev);
 	dme1737_remove_files(&pdev->dev);
-	release_region(data->client.addr, DME1737_EXTENT);
+	release_region(data->addr, DME1737_EXTENT);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
