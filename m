From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:57:12 +0000
Subject: [lm-sensors] [patch 15/36] hwmon: (w83795) Clean up probe function
Message-Id: <20100915155712.32461d3c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* The data structure is zalloc'd, so no need to set individual fields
  to 0 explicitly.
* Refactor the handling of pins that can be used for either
  temperature or voltage monitoring.
* Misc other clean-ups.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   91 +++++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 57 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:12:51.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:12:53.000000000 +0200
@@ -1844,6 +1844,26 @@ static int device_remove_file_wrapper(st
 	return 0;
 }
 
+/* Check pins that can be used for either temperature or voltage monitoring */
+static void w83795_apply_temp_config(struct w83795_data *data, u8 config,
+				     int temp_chan, int in_chan)
+{
+	/* config is a 2-bit value */
+	switch (config) {
+	case 0x2: /* Voltage monitoring */
+		data->has_in |= 1 << in_chan;
+		break;
+	case 0x1: /* Thermal diode */
+		if (temp_chan >= 4)
+			break;
+		data->temp_mode |= 1 << temp_chan;
+		/* fall through */
+	case 0x3: /* Thermistor */
+		data->has_temp |= 1 << temp_chan;
+		break;
+	}
+}
+
 static int w83795_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -1851,7 +1871,7 @@ static int w83795_probe(struct i2c_clien
 	u8 tmp;
 	struct device *dev = &client->dev;
 	struct w83795_data *data;
-	int err = 0;
+	int err;
 
 	data = kzalloc(sizeof(struct w83795_data), GFP_KERNEL);
 	if (!data) {
@@ -1867,68 +1887,26 @@ static int w83795_probe(struct i2c_clien
 	/* Initialize the chip */
 	w83795_init_client(client);
 
-	data->has_in = w83795_read(client, W83795_REG_VOLT_CTRL1);
-	data->has_in |= w83795_read(client, W83795_REG_VOLT_CTRL2) << 8;
-	/* VSEN11-9 not for 795adg */
-	if (data->chip_type = w83795adg)
-		data->has_in &= 0xf8ff;
-	data->has_fan = w83795_read(client, W83795_REG_FANIN_CTRL1);
-	data->has_fan |= w83795_read(client, W83795_REG_FANIN_CTRL2) << 8;
+	/* Check which voltages and fans are present */
+	data->has_in = w83795_read(client, W83795_REG_VOLT_CTRL1)
+		     | (w83795_read(client, W83795_REG_VOLT_CTRL2) << 8);
+	data->has_fan = w83795_read(client, W83795_REG_FANIN_CTRL1)
+		      | (w83795_read(client, W83795_REG_FANIN_CTRL2) << 8);
 
-	/* VDSEN12-17 and TR1-6, TD1-4 use same register */
+	/* Check which analog temperatures and extra voltages are present */
 	tmp = w83795_read(client, W83795_REG_TEMP_CTRL1);
 	if (tmp & 0x20)
 		data->enable_dts = 1;
-	else
-		data->enable_dts = 0;
-	data->has_temp = 0;
-	data->temp_mode = 0;
-	if (tmp & 0x08) {
-		if (tmp & 0x04)
-			data->has_temp |= 0x20;
-		else
-			data->has_in |= 0x10000;
-	}
-	if (tmp & 0x02) {
-		if (tmp & 0x01)
-			data->has_temp |= 0x10;
-		else
-			data->has_in |= 0x8000;
-	}
+	w83795_apply_temp_config(data, (tmp >> 2) & 0x3, 5, 16);
+	w83795_apply_temp_config(data, tmp & 0x3, 4, 15);
 	tmp = w83795_read(client, W83795_REG_TEMP_CTRL2);
-	if (tmp & 0x40) {
-		data->has_temp |= 0x08;
-		if (!(tmp & 0x80))
-			data->temp_mode |= 0x08;
-	} else if (tmp & 0x80) {
-		data->has_in |= 0x100000;
-	}
-	if (tmp & 0x10) {
-		data->has_temp |= 0x04;
-		if (!(tmp & 0x20))
-			data->temp_mode |= 0x04;
-	} else if (tmp & 0x20) {
-		data->has_in |= 0x80000;
-	}
-	if (tmp & 0x04) {
-		data->has_temp |= 0x02;
-		if (!(tmp & 0x08))
-			data->temp_mode |= 0x02;
-	} else if (tmp & 0x08) {
-		data->has_in |= 0x40000;
-	}
-	if (tmp & 0x01) {
-		data->has_temp |= 0x01;
-		if (!(tmp & 0x02))
-			data->temp_mode |= 0x01;
-	} else if (tmp & 0x02) {
-		data->has_in |= 0x20000;
-	}
+	w83795_apply_temp_config(data, tmp >> 6, 3, 20);
+	w83795_apply_temp_config(data, (tmp >> 4) & 0x3, 2, 19);
+	w83795_apply_temp_config(data, (tmp >> 2) & 0x3, 1, 18);
+	w83795_apply_temp_config(data, tmp & 0x3, 0, 17);
 
 	/* Check DTS enable status */
-	if (data->enable_dts = 0) {
-		data->has_dts = 0;
-	} else {
+	if (data->enable_dts) {
 		if (1 & w83795_read(client, W83795_REG_DTSC))
 			data->enable_dts |= 2;
 		data->has_dts = w83795_read(client, W83795_REG_DTSE);
@@ -2017,7 +1995,6 @@ static int w83795_probe(struct i2c_clien
 		data->has_pwm = 2;
 	data->pwm_fcms[0] = w83795_read(client, W83795_REG_FCMS1);
 	data->pwm_fcms[1] = w83795_read(client, W83795_REG_FCMS2);
-	/* w83795adg only support pwm2-0 */
 	for (i = 0; i < W83795_REG_TEMP_NUM; i++)
 		data->pwm_tfmr[i] = w83795_read(client, W83795_REG_TFMR(i));
 	data->pwm_fomc = w83795_read(client, W83795_REG_FOMC);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
