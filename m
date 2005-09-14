From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 14 Sep 2005 00:50:34 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: adm9240 updates
Message-Id: <cslei1dpij6dbpghepu0na965d9rtfig63@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


hwmon: adm9240 update 2/3: cleanups

make SCALE function return zero for zero input,
remove i2c read/write wrapper interface,
change kmalloc + memset to kzalloc 

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm9240.c |   94 ++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 46 insertions(+), 48 deletions(-)

--- linux-2.6.14-rc1b/drivers/hwmon/adm9240.c-whitespace	2005-09-14 07:10:45.000000000 +1000
+++ linux-2.6.14-rc1b/drivers/hwmon/adm9240.c	2005-09-14 07:26:43.000000000 +1000
@@ -81,6 +81,8 @@
 /* generalised scaling with integer rounding */
 static inline int SCALE(long val, int mul, int div)
 {
+	if (val = 0)
+		return 0;
 	if (val < 0)
 		return (val * mul - div / 2) / div;
 	else
@@ -170,17 +172,6 @@
 	u8 vrm;			/* --	vrm set on startup, no accessor */
 };
 
-/* i2c byte read/write interface */
-static int adm9240_read_value(struct i2c_client *client, u8 reg)
-{
-	return i2c_smbus_read_byte_data(client, reg);
-}
-
-static int adm9240_write_value(struct i2c_client *client, u8 reg, u8 value)
-{
-	return i2c_smbus_write_byte_data(client, reg, value);
-}
-
 /*** sysfs accessors ***/
 
 /* temperature */
@@ -207,7 +198,7 @@
 								\
 	down(&data->update_lock);				\
 	data->value = TEMP_TO_REG(temp);			\
-	adm9240_write_value(client, reg, data->value);		\
+	i2c_smbus_write_byte_data(client, reg, data->value);	\
 	up(&data->update_lock);					\
 	return count;						\
 }
@@ -249,7 +240,8 @@
 
 	down(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val, nr);
-	adm9240_write_value(client, ADM9240_REG_IN_MIN(nr), data->in_min[nr]);
+	i2c_smbus_write_byte_data(client, ADM9240_REG_IN_MIN(nr),
+			data->in_min[nr]);
 	up(&data->update_lock);
 	return count;
 }
@@ -263,7 +255,8 @@
 
 	down(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val, nr);
-	adm9240_write_value(client, ADM9240_REG_IN_MAX(nr), data->in_max[nr]);
+	i2c_smbus_write_byte_data(client, ADM9240_REG_IN_MAX(nr),
+			data->in_max[nr]);
 	up(&data->update_lock);
 	return count;
 }
@@ -341,11 +334,11 @@
 {
 	u8 reg, old, shift = (nr + 2) * 2;
 
-	reg = adm9240_read_value(client, ADM9240_REG_VID_FAN_DIV);
+	reg = i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
 	old = (reg >> shift) & 3;
 	reg &= ~(3 << shift);
 	reg |= (fan_div << shift);
-	adm9240_write_value(client, ADM9240_REG_VID_FAN_DIV, reg);
+	i2c_smbus_write_byte_data(client, ADM9240_REG_VID_FAN_DIV, reg);
 	dev_dbg(&client->dev, "fan%d clock divider changed from %u "
 			"to %u\n", nr + 1, 1 << old, 1 << fan_div);
 }
@@ -406,7 +399,7 @@
 		data->fan_div[nr] = new_div;
 		adm9240_write_fan_div(client, nr, new_div);
 	}
-	adm9240_write_value(client, ADM9240_REG_FAN_MIN(nr),
+	i2c_smbus_write_byte_data(client, ADM9240_REG_FAN_MIN(nr),
 			data->fan_min[nr]);
 
 	up(&data->update_lock);
@@ -483,7 +476,7 @@
 
 	down(&data->update_lock);
 	data->aout = AOUT_TO_REG(val);
-	adm9240_write_value(client, ADM9240_REG_ANALOG_OUT, data->aout);
+	i2c_smbus_write_byte_data(client, ADM9240_REG_ANALOG_OUT, data->aout);
 	up(&data->update_lock);
 	return count;
 }
@@ -497,7 +490,8 @@
 	unsigned long val = simple_strtol(buf, NULL, 10);
 
 	if (val = 1) {
-		adm9240_write_value(client, ADM9240_REG_CHASSIS_CLEAR, 0x80);
+		i2c_smbus_write_byte_data(client,
+				ADM9240_REG_CHASSIS_CLEAR, 0x80);
 		dev_dbg(&client->dev, "chassis intrusion latch cleared\n");
 	}
 	return count;
@@ -518,11 +512,10 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct adm9240_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(*data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct adm9240_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
@@ -538,7 +531,7 @@
 	if (kind < 0) {
 
 		/* verify chip: reg address should match i2c address */
-		if (adm9240_read_value(new_client, ADM9240_REG_I2C_ADDR)
+		if (i2c_smbus_read_byte_data(new_client, ADM9240_REG_I2C_ADDR)
 				!= address) {
 			dev_err(&adapter->dev, "detect fail: address match, "
 					"0x%02x\n", address);
@@ -546,8 +539,8 @@
 		}
 
 		/* check known chip manufacturer */
-		man_id = adm9240_read_value(new_client, ADM9240_REG_MAN_ID);
-
+		man_id = i2c_smbus_read_byte_data(new_client,
+				ADM9240_REG_MAN_ID);
 		if (man_id = 0x23) {
 			kind = adm9240;
 		} else if (man_id = 0xda) {
@@ -561,7 +554,8 @@
 		}
 
 		/* successful detect, print chip info */
-		die_rev = adm9240_read_value(new_client, ADM9240_REG_DIE_REV);
+		die_rev = i2c_smbus_read_byte_data(new_client,
+				ADM9240_REG_DIE_REV);
 		dev_info(&adapter->dev, "found %s revision %u\n",
 				man_id = 0x23 ? "ADM9240" :
 				man_id = 0xda ? "DS1780" : "LM81", die_rev);
@@ -659,8 +653,8 @@
 static void adm9240_init_client(struct i2c_client *client)
 {
 	struct adm9240_data *data = i2c_get_clientdata(client);
-	u8 conf = adm9240_read_value(client, ADM9240_REG_CONFIG);
-	u8 mode = adm9240_read_value(client, ADM9240_REG_TEMP_CONF) & 3;
+	u8 conf = i2c_smbus_read_byte_data(client, ADM9240_REG_CONFIG);
+	u8 mode = i2c_smbus_read_byte_data(client, ADM9240_REG_TEMP_CONF) & 3;
 
 	data->vrm = vid_which_vrm(); /* need this to report vid as mV */
 
@@ -677,18 +671,22 @@
 
 		for (i = 0; i < 6; i++)
 		{
-			adm9240_write_value(client,
+			i2c_smbus_write_byte_data(client,
 					ADM9240_REG_IN_MIN(i), 0);
-			adm9240_write_value(client,
+			i2c_smbus_write_byte_data(client,
 					ADM9240_REG_IN_MAX(i), 255);
 		}
-		adm9240_write_value(client, ADM9240_REG_FAN_MIN(0), 255);
-		adm9240_write_value(client, ADM9240_REG_FAN_MIN(1), 255);
-		adm9240_write_value(client, ADM9240_REG_TEMP_HIGH, 127);
-		adm9240_write_value(client, ADM9240_REG_TEMP_HYST, 127);
+		i2c_smbus_write_byte_data(client,
+				ADM9240_REG_FAN_MIN(0), 255);
+		i2c_smbus_write_byte_data(client,
+				ADM9240_REG_FAN_MIN(1), 255);
+		i2c_smbus_write_byte_data(client,
+				ADM9240_REG_TEMP_HIGH, 127);
+		i2c_smbus_write_byte_data(client,
+				ADM9240_REG_TEMP_HYST, 127);
 
 		/* start measurement cycle */
-		adm9240_write_value(client, ADM9240_REG_CONFIG, 1);
+		i2c_smbus_write_byte_data(client, ADM9240_REG_CONFIG, 1);
 
 		dev_info(&client->dev, "cold start: config was 0x%02x "
 				"mode %u\n", conf, mode);
@@ -709,25 +707,25 @@
 
 		for (i = 0; i < 6; i++) /* read voltages */
 		{
-			data->in[i] = adm9240_read_value(client,
+			data->in[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_IN(i));
 		}
-		data->alarms = adm9240_read_value(client,
+		data->alarms = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_INT(0)) |
-					adm9240_read_value(client,
+					i2c_smbus_read_byte_data(client,
 					ADM9240_REG_INT(1)) << 8;
 
 		/* read temperature: assume temperature changes less than
 		 * 0.5'C per two measurement cycles thus ignore possible
 		 * but unlikely aliasing error on lsb reading. --Grant */
-		data->temp = ((adm9240_read_value(client,
+		data->temp = ((i2c_smbus_read_byte_data(client,
 					ADM9240_REG_TEMP) << 8) |
-					adm9240_read_value(client,
+					i2c_smbus_read_byte_data(client,
 					ADM9240_REG_TEMP_CONF)) / 128;
 
 		for (i = 0; i < 2; i++) /* read fans */
 		{
-			data->fan[i] = adm9240_read_value(client,
+			data->fan[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_FAN(i));
 
 			/* adjust fan clock divider on overflow */
@@ -752,30 +750,30 @@
 
 		for (i = 0; i < 6; i++)
 		{
-			data->in_min[i] = adm9240_read_value(client,
+			data->in_min[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_IN_MIN(i));
-			data->in_max[i] = adm9240_read_value(client,
+			data->in_max[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_IN_MAX(i));
 		}
 		for (i = 0; i < 2; i++)
 		{
-			data->fan_min[i] = adm9240_read_value(client,
+			data->fan_min[i] = i2c_smbus_read_byte_data(client,
 					ADM9240_REG_FAN_MIN(i));
 		}
-		data->temp_high = adm9240_read_value(client,
+		data->temp_high = i2c_smbus_read_byte_data(client,
 				ADM9240_REG_TEMP_HIGH);
-		data->temp_hyst = adm9240_read_value(client,
+		data->temp_hyst = i2c_smbus_read_byte_data(client,
 				ADM9240_REG_TEMP_HYST);
 
 		/* read fan divs and 5-bit VID */
-		i = adm9240_read_value(client, ADM9240_REG_VID_FAN_DIV);
+		i = i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
 		data->fan_div[0] = (i >> 4) & 3;
 		data->fan_div[1] = (i >> 6) & 3;
 		data->vid = i & 0x0f;
-		data->vid |= (adm9240_read_value(client,
+		data->vid |= (i2c_smbus_read_byte_data(client,
 					ADM9240_REG_VID4) & 1) << 4;
 		/* read analog out */
-		data->aout = adm9240_read_value(client,
+		data->aout = i2c_smbus_read_byte_data(client,
 				ADM9240_REG_ANALOG_OUT);
 
 		data->last_updated_config = jiffies;
