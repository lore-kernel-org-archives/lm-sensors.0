From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: [PATCH 2.6] I2C: Fix a common race condition in hardware monitoring
Message-Id: <20050328131326.4eb2973d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Greg,

Grant Coady noticed that most hardware monitoring drivers are exposed to
a race condition when one writes to the sysfs files they create. While
the read calls properly request a lock on the internal data, write calls
manipulate the internal data without proper locking. This big patch
fixes that by adding locking wherever needed.

Affected drivers: adm1021, adm1025, asb100, ds1621, fscher, fscpos,
gl518sm, gl520sm, it87, lm63, lm75, lm77, lm78, lm80, lm83, lm87, lm90,
lm92, max1619, pc87360, pcf8591, sis5595, smsc47m1, via686a, w83627hf
and w83781d

The adm1026, adm1031 and lm85 were already locking on write calls, but
held the lock for code that did not require it, so they have been
modified too.

The smsc47b397 and w83l785ts drivers were not affected, because they are
read-only.

The patch should apply just fine on top of your stack, provided that you
applied all previous patches in order (in particular, there is one lm87
indentation patch which is needed).

Thanks.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/adm1021.c linux-2.6.1=
2-rc1-mm3/drivers/i2c/chips/adm1021.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/adm1021.c	2005-03-28 09:57:=
20.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/adm1021.c	2005-03-28 10:10:12.00=
0000000 +0200
@@ -165,8 +165,10 @@
 	struct adm1021_data *data =3D i2c_get_clientdata(client);	\
 	int temp =3D simple_strtoul(buf, NULL, 10);		\
 								\
+	down(&data->update_lock);				\
 	data->value =3D TEMP_TO_REG(temp);			\
 	adm1021_write_value(client, reg, data->value);		\
+	up(&data->update_lock);					\
 	return count;						\
 }
 set(temp_max, ADM1021_REG_TOS_W);
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/adm1025.c linux-2.6.1=
2-rc1-mm3/drivers/i2c/chips/adm1025.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/adm1025.c	2005-03-28 09:56:=
09.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/adm1025.c	2005-03-28 10:10:12.00=
0000000 +0200
@@ -206,9 +206,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct adm1025_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_min[offset] =3D IN_TO_REG(val, in_scale[offset]); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MIN(offset), \
 				  data->in_min[offset]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_in##offset##_max(struct device *dev, const char *buf, \
@@ -217,9 +220,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct adm1025_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_max[offset] =3D IN_TO_REG(val, in_scale[offset]); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MAX(offset), \
 				  data->in_max[offset]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(in##offset##_min, S_IWUSR | S_IRUGO, \
@@ -240,9 +246,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct adm1025_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->temp_min[offset-1] =3D TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_LOW(offset-1), \
 				  data->temp_min[offset-1]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_temp##offset##_max(struct device *dev, const char *buf,=
 \
@@ -251,9 +260,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct adm1025_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->temp_max[offset-1] =3D TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_HIGH(offset-1), \
 				  data->temp_max[offset-1]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/adm1026.c linux-2.6.1=
2-rc1-mm3/drivers/i2c/chips/adm1026.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/adm1026.c	2005-03-26 06:59:=
33.000000000 +0100
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/adm1026.c	2005-03-28 10:14:48.00=
0000000 +0200
@@ -726,10 +726,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->in_min[nr] =3D INS_TO_REG(nr, val);
 	adm1026_write_value(client, ADM1026_REG_IN_MIN[nr], data->in_min[nr]);
 	up(&data->update_lock);
@@ -745,10 +744,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->in_max[nr] =3D INS_TO_REG(nr, val);
 	adm1026_write_value(client, ADM1026_REG_IN_MAX[nr], data->in_max[nr]);
 	up(&data->update_lock);
@@ -818,10 +816,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->in_min[16] =3D INS_TO_REG(16, val + NEG12_OFFSET);
 	adm1026_write_value(client, ADM1026_REG_IN_MIN[16], data->in_min[16]);
 	up(&data->update_lock);
@@ -837,10 +834,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->in_max[16] =3D INS_TO_REG(16, val+NEG12_OFFSET);
 	adm1026_write_value(client, ADM1026_REG_IN_MAX[16], data->in_max[16]);
 	up(&data->update_lock);
@@ -873,10 +869,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->fan_min[nr] =3D FAN_TO_REG(val, data->fan_div[nr]);
 	adm1026_write_value(client, ADM1026_REG_FAN_MIN(nr),
 		data->fan_min[nr]);
@@ -1009,10 +1004,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->temp_min[nr] =3D TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_MIN[nr],
 		data->temp_min[nr]);
@@ -1029,10 +1023,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->temp_max[nr] =3D TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_MAX[nr],
 		data->temp_max[nr]);
@@ -1083,10 +1076,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->temp_offset[nr] =3D TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_OFFSET[nr],
 		data->temp_offset[nr]);
@@ -1136,10 +1128,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->temp_tmin[nr] =3D TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_TMIN[nr],
 		data->temp_tmin[nr]);
@@ -1190,9 +1181,8 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
-	val =3D simple_strtol(buf, NULL, 10);
 	if ((val =3D 1) || (val=3D0)) {
 		down(&data->update_lock);
 		data->config1 =3D (data->config1 & ~CFG1_THERM_HOT) | (val << 4);
@@ -1223,10 +1213,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->temp_crit[nr] =3D TEMP_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_TEMP_THERM[nr],
 		data->temp_crit[nr]);
@@ -1261,10 +1250,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->analog_out =3D DAC_TO_REG(val);
 	adm1026_write_value(client, ADM1026_REG_DAC, data->analog_out);
 	up(&data->update_lock);
@@ -1317,11 +1305,10 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
 	unsigned long mask;
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->alarm_mask =3D val & 0x7fffffff;
 	mask =3D data->alarm_mask
 		| (data->gpio_mask & 0x10000 ? 0x80000000 : 0);
@@ -1354,11 +1341,10 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
 	long   gpio;
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->gpio =3D val & 0x1ffff;
 	gpio =3D data->gpio;
 	adm1026_write_value(client, ADM1026_REG_GPIO_STATUS_0_7,gpio & 0xff);
@@ -1383,11 +1369,10 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
 	long   mask;
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->gpio_mask =3D val & 0x1ffff;
 	mask =3D data->gpio_mask;
 	adm1026_write_value(client, ADM1026_REG_GPIO_MASK_0_7,mask & 0xff);
@@ -1411,11 +1396,11 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
=20
 	if (data->pwm1.enable =3D 1) {
+		int val =3D simple_strtol(buf, NULL, 10);
+
 		down(&data->update_lock);
-		val =3D simple_strtol(buf, NULL, 10);
 		data->pwm1.pwm =3D PWM_TO_REG(val);
 		adm1026_write_value(client, ADM1026_REG_PWM, data->pwm1.pwm);
 		up(&data->update_lock);
@@ -1432,10 +1417,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->pwm1.auto_pwm_min =3D SENSORS_LIMIT(val,0,255);
 	if (data->pwm1.enable =3D 2) { /* apply immediately */
 		data->pwm1.pwm =3D PWM_TO_REG((data->pwm1.pwm & 0x0f) |
@@ -1459,10 +1443,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1026_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	int val =3D simple_strtol(buf, NULL, 10);
 	int     old_enable;
=20
-	val =3D simple_strtol(buf, NULL, 10);
 	if ((val >=3D 0) && (val < 3)) {
 		down(&data->update_lock);
 		old_enable =3D data->pwm1.enable;
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/adm1031.c linux-2.6.1=
2-rc1-mm3/drivers/i2c/chips/adm1031.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/adm1031.c	2005-03-26 06:59:=
33.000000000 +0100
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/adm1031.c	2005-03-28 10:32:00.00=
0000000 +0200
@@ -254,7 +254,7 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1031_data *data =3D i2c_get_clientdata(client);
-	int val;
+	int val =3D simple_strtol(buf, NULL, 10);
 	u8 reg;
 	int ret;
 	u8 old_fan_mode;
@@ -262,7 +262,6 @@
 	old_fan_mode =3D data->conf1;
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 =09
 	if ((ret =3D get_fan_auto_nearest(data, nr, val, data->conf1, &reg))) {
 		up(&data->update_lock);
@@ -327,10 +326,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1031_data *data =3D i2c_get_clientdata(client);
-	int val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->auto_temp[nr] =3D AUTO_TEMP_MIN_TO_REG(val, data->auto_temp[nr]);
 	adm1031_write_value(client, ADM1031_REG_AUTO_TEMP(nr),
 			    data->auto_temp[nr]);
@@ -348,10 +346,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1031_data *data =3D i2c_get_clientdata(client);
-	int val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->temp_max[nr] =3D AUTO_TEMP_MAX_TO_REG(val, data->auto_temp[nr], dat=
a->pwm[nr]);
 	adm1031_write_value(client, ADM1031_REG_AUTO_TEMP(nr),
 			    data->temp_max[nr]);
@@ -404,10 +401,10 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1031_data *data =3D i2c_get_clientdata(client);
-	int val;
+	int val =3D simple_strtol(buf, NULL, 10);
 	int reg;
+
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	if ((data->conf1 & ADM1031_CONF1_AUTO_MODE) &&=20
 	    (((val>>4) & 0xf) !=3D 5)) {
 		/* In automatic mode, the only PWM accepted is 33% */
@@ -511,10 +508,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1031_data *data =3D i2c_get_clientdata(client);
-	int val;
+	int val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	if (val) {
 		data->fan_min[nr] =3D=20
 			FAN_TO_REG(val, FAN_DIV_FROM_REG(data->fan_div[nr]));
@@ -530,12 +526,11 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct adm1031_data *data =3D i2c_get_clientdata(client);
-	int val;
+	int val =3D simple_strtol(buf, NULL, 10);
 	u8 tmp;
-	int old_div =3D FAN_DIV_FROM_REG(data->fan_div[nr]);
+	int old_div;
 	int new_min;
=20
-	val =3D simple_strtol(buf, NULL, 10);
 	tmp =3D val =3D 8 ? 0xc0 :
 	      val =3D 4 ? 0x80 :
 	      val =3D 2 ? 0x40 :=09
@@ -543,7 +538,9 @@
 	      0xff;
 	if (tmp =3D 0xff)
 		return -EINVAL;
+=09
 	down(&data->update_lock);
+	old_div =3D FAN_DIV_FROM_REG(data->fan_div[nr]);
 	data->fan_div[nr] =3D (tmp & 0xC0) | (0x3f & data->fan_div[nr]);
 	new_min =3D data->fan_min[nr] * old_div /=20
 		FAN_DIV_FROM_REG(data->fan_div[nr]);
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/asb100.c linux-2.6.12=
-rc1-mm3/drivers/i2c/chips/asb100.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/asb100.c	2005-03-28 09:57:2=
0.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/asb100.c	2005-03-28 10:37:10.000=
000000 +0200
@@ -246,9 +246,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct asb100_data *data =3D i2c_get_clientdata(client); \
 	unsigned long val =3D simple_strtoul(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_##reg[nr] =3D IN_TO_REG(val); \
 	asb100_write_value(client, ASB100_REG_IN_##REG(nr), \
 		data->in_##reg[nr]); \
+	up(&data->update_lock); \
 	return count; \
 }
=20
@@ -329,8 +332,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct asb100_data *data =3D i2c_get_clientdata(client);
 	u32 val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	asb100_write_value(client, ASB100_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -343,11 +349,14 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct asb100_data *data =3D i2c_get_clientdata(client);
-	unsigned long min =3D FAN_FROM_REG(data->fan_min[nr],
-			DIV_FROM_REG(data->fan_div[nr]));
+	unsigned long min;
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
 	int reg;
 =09
+	down(&data->update_lock);
+
+	min =3D FAN_FROM_REG(data->fan_min[nr],
+			DIV_FROM_REG(data->fan_div[nr]));
 	data->fan_div[nr] =3D DIV_TO_REG(val);
=20
 	switch(nr) {
@@ -373,6 +382,9 @@
 	data->fan_min[nr]  		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	asb100_write_value(client, ASB100_REG_FAN_MIN(nr), data->fan_min[nr]);
+
+	up(&data->update_lock);
+
 	return count;
 }
=20
@@ -450,6 +462,8 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct asb100_data *data =3D i2c_get_clientdata(client); \
 	unsigned long val =3D simple_strtoul(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	switch (nr) { \
 	case 1: case 2: \
 		data->reg[nr] =3D LM75_TEMP_TO_REG(val); \
@@ -460,6 +474,7 @@
 	} \
 	asb100_write_value(client, ASB100_REG_TEMP_##REG(nr+1), \
 			data->reg[nr]); \
+	up(&data->update_lock); \
 	return count; \
 }
=20
@@ -560,9 +575,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct asb100_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->pwm &=3D 0x80; /* keep the enable bit */
 	data->pwm |=3D (0x0f & ASB100_PWM_TO_REG(val));
 	asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -578,9 +596,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct asb100_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->pwm &=3D 0x0f; /* keep the duty cycle bits */
 	data->pwm |=3D (val ? 0x80 : 0x00);
 	asb100_write_value(client, ASB100_REG_PWM1, data->pwm);
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/ds1621.c linux-2.6.12=
-rc1-mm3/drivers/i2c/chips/ds1621.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/ds1621.c	2005-03-28 09:57:2=
0.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/ds1621.c	2005-03-28 10:10:12.000=
000000 +0200
@@ -153,8 +153,12 @@
 {									\
 	struct i2c_client *client =3D to_i2c_client(dev);			\
 	struct ds1621_data *data =3D ds1621_update_client(dev);		\
-	data->value =3D LM75_TEMP_TO_REG(simple_strtoul(buf, NULL, 10));	\
+	u16 val =3D LM75_TEMP_TO_REG(simple_strtoul(buf, NULL, 10));	\
+									\
+	down(&data->update_lock);					\
+	data->value =3D val;						\
 	ds1621_write_value(client, reg, data->value);			\
+	up(&data->update_lock);						\
 	return count;							\
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/fscher.c linux-2.6.12=
-rc1-mm3/drivers/i2c/chips/fscher.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/fscher.c	2005-03-28 09:57:2=
0.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/fscher.c	2005-03-28 10:44:19.000=
000000 +0200
@@ -464,9 +464,11 @@
 {
 	/* bits 0..1, 3..7 reserved =3D> mask with 0x04 */ =20
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0x04;
+=09
+	down(&data->update_lock);
 	data->fan_status[FAN_INDEX_FROM_NUM(nr)] &=3D ~v;
-
 	fscher_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -480,9 +482,11 @@
 		       const char *buf, size_t count, int nr, int reg)
 {
 	unsigned long v =3D simple_strtoul(buf, NULL, 10);
-	data->fan_min[FAN_INDEX_FROM_NUM(nr)] =3D v > 0xff ? 0xff : v;
=20
+	down(&data->update_lock);
+	data->fan_min[FAN_INDEX_FROM_NUM(nr)] =3D v > 0xff ? 0xff : v;
 	fscher_write_value(client, reg, data->fan_min[FAN_INDEX_FROM_NUM(nr)]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -507,11 +511,14 @@
 		return -EINVAL;
 	}
=20
+	down(&data->update_lock);
+
 	/* bits 2..7 reserved =3D> mask with 0x03 */
 	data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] &=3D ~0x03;
 	data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] |=3D v;
=20
 	fscher_write_value(client, reg, data->fan_ripple[FAN_INDEX_FROM_NUM(nr)]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -537,9 +544,11 @@
 {
 	/* bits 2..7 reserved, 0 read only =3D> mask with 0x02 */ =20
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0x02;
-	data->temp_status[TEMP_INDEX_FROM_NUM(nr)] &=3D ~v;
=20
+	down(&data->update_lock);
+	data->temp_status[TEMP_INDEX_FROM_NUM(nr)] &=3D ~v;
 	fscher_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -592,9 +601,11 @@
 {
 	/* bits 1..7 reserved =3D> mask with 0x01 */ =20
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0x01;
-	data->global_control &=3D ~v;
=20
+	down(&data->update_lock);
+	data->global_control &=3D ~v;
 	fscher_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -612,10 +623,12 @@
 {
 	/* bits 0..3 reserved =3D> mask with 0xf0 */ =20
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0xf0;
+
+	down(&data->update_lock);
 	data->watchdog[2] &=3D ~0xf0;
 	data->watchdog[2] |=3D v;
-
 	fscher_write_value(client, reg, data->watchdog[2]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -630,9 +643,11 @@
 {
 	/* bits 0, 2..7 reserved =3D> mask with 0x02 */ =20
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0x02;
-	data->watchdog[1] &=3D ~v;
=20
+	down(&data->update_lock);
+	data->watchdog[1] &=3D ~v;
 	fscher_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -645,9 +660,12 @@
 static ssize_t set_watchdog_preset(struct i2c_client *client, struct fsche=
r_data *data,
 				   const char *buf, size_t count, int nr, int reg)
 {
-	data->watchdog[0] =3D simple_strtoul(buf, NULL, 10) & 0xff;
-
+	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0xff;
+=09
+	down(&data->update_lock);
+	data->watchdog[0] =3D v;
 	fscher_write_value(client, reg, data->watchdog[0]);
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/fscpos.c linux-2.6.12=
-rc1-mm3/drivers/i2c/chips/fscpos.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/fscpos.c	2005-03-28 09:57:2=
0.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/fscpos.c	2005-03-28 10:47:49.000=
000000 +0200
@@ -206,11 +206,13 @@
 		return -EINVAL;
 	}
 =09
+	down(&data->update_lock);
 	/* bits 2..7 reserved =3D> mask with 0x03 */
 	data->fan_ripple[nr - 1] &=3D ~0x03;
 	data->fan_ripple[nr - 1] |=3D v;
 =09
 	fscpos_write_value(client, reg, data->fan_ripple[nr - 1]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -228,8 +230,10 @@
 	if (v < 0) v =3D 0;
 	if (v > 255) v =3D 255;
=20
+	down(&data->update_lock);
 	data->pwm[nr - 1] =3D v;
 	fscpos_write_value(client, reg, data->pwm[nr - 1]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -271,10 +275,12 @@
 {
 	/* bits 0..3 reserved =3D> mask with 0xf0 */
 	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0xf0;
+
+	down(&data->update_lock);
 	data->wdog_control &=3D ~0xf0;
 	data->wdog_control |=3D v;
-=09
 	fscpos_write_value(client, reg, data->wdog_control);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -296,9 +302,10 @@
 		return -EINVAL;
 	}
=20
+	down(&data->update_lock);
 	data->wdog_state &=3D ~v;
-=09
 	fscpos_write_value(client, reg, v);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -310,9 +317,12 @@
 static ssize_t set_wdog_preset(struct i2c_client *client, struct fscpos_da=
ta
 				*data, const char *buf,	size_t count, int reg)
 {
-	data->wdog_preset =3D simple_strtoul(buf, NULL, 10) & 0xff;
-=09
+	unsigned long v =3D simple_strtoul(buf, NULL, 10) & 0xff;
+
+	down(&data->update_lock);
+	data->wdog_preset =3D v;
 	fscpos_write_value(client, reg, data->wdog_preset);
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/gl518sm.c linux-2.6.1=
2-rc1-mm3/drivers/i2c/chips/gl518sm.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/gl518sm.c	2005-03-28 09:57:=
20.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/gl518sm.c	2005-03-28 10:10:12.00=
0000000 +0200
@@ -211,8 +211,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);			\
 	struct gl518_data *data =3D i2c_get_clientdata(client);		\
 	long val =3D simple_strtol(buf, NULL, 10);			\
+									\
+	down(&data->update_lock);					\
 	data->value =3D type##_TO_REG(val);				\
 	gl518_write_value(client, reg, data->value);			\
+	up(&data->update_lock);						\
 	return count;							\
 }
=20
@@ -222,11 +225,15 @@
 {									\
 	struct i2c_client *client =3D to_i2c_client(dev);			\
 	struct gl518_data *data =3D i2c_get_clientdata(client);		\
-	int regvalue =3D gl518_read_value(client, reg);			\
+	int regvalue;							\
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);		\
+									\
+	down(&data->update_lock);					\
+	regvalue =3D gl518_read_value(client, reg);			\
 	data->value =3D type##_TO_REG(val);				\
 	regvalue =3D (regvalue & ~mask) | (data->value << shift);		\
 	gl518_write_value(client, reg, regvalue);			\
+	up(&data->update_lock);						\
 	return count;							\
 }
=20
@@ -255,9 +262,12 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct gl518_data *data =3D i2c_get_clientdata(client);
-	int regvalue =3D gl518_read_value(client, GL518_REG_FAN_LIMIT);
+	int regvalue;
+	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	data->fan_min[0] =3D FAN_TO_REG(simple_strtoul(buf, NULL, 10),
+	down(&data->update_lock);
+	regvalue =3D gl518_read_value(client, GL518_REG_FAN_LIMIT);
+	data->fan_min[0] =3D FAN_TO_REG(val,
 		DIV_FROM_REG(data->fan_div[0]));
 	regvalue =3D (regvalue & 0x00ff) | (data->fan_min[0] << 8);
 	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
@@ -270,6 +280,7 @@
 	data->beep_mask &=3D data->alarm_mask;
 	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -277,9 +288,12 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct gl518_data *data =3D i2c_get_clientdata(client);
-	int regvalue =3D gl518_read_value(client, GL518_REG_FAN_LIMIT);
+	int regvalue;
+	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
-	data->fan_min[1] =3D FAN_TO_REG(simple_strtoul(buf, NULL, 10),
+	down(&data->update_lock);
+	regvalue =3D gl518_read_value(client, GL518_REG_FAN_LIMIT);
+	data->fan_min[1] =3D FAN_TO_REG(val,
 		DIV_FROM_REG(data->fan_div[1]));
 	regvalue =3D (regvalue & 0xff00) | data->fan_min[1];
 	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
@@ -292,6 +306,7 @@
 	data->beep_mask &=3D data->alarm_mask;
 	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
=20
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/gl520sm.c linux-2.6.1=
2-rc1-mm3/drivers/i2c/chips/gl520sm.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/gl520sm.c	2005-03-28 09:57:=
20.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/gl520sm.c	2005-03-28 12:07:15.00=
0000000 +0200
@@ -301,6 +301,8 @@
 	long v =3D simple_strtol(buf, NULL, 10);
 	u8 r;
=20
+	down(&data->update_lock);
+
 	if (n =3D 0)
 		r =3D VDD_TO_REG(v);
 	else
@@ -313,6 +315,7 @@
 	else
 		gl520_write_value(client, reg, r);
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -326,6 +329,8 @@
 	else
 		r =3D IN_TO_REG(v);
=20
+	down(&data->update_lock);
+
 	data->in_max[n] =3D r;
=20
 	if (n < 4)
@@ -333,6 +338,7 @@
 	else
 		gl520_write_value(client, reg, r);
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -363,8 +369,10 @@
 static ssize_t set_fan_min(struct i2c_client *client, struct gl520_data *d=
ata, const char *buf, size_t count, int n, int reg)
 {
 	unsigned long v =3D simple_strtoul(buf, NULL, 10);
-	u8 r =3D FAN_TO_REG(v, data->fan_div[n - 1]);
+	u8 r;
=20
+	down(&data->update_lock);
+	r =3D FAN_TO_REG(v, data->fan_div[n - 1]);
 	data->fan_min[n - 1] =3D r;
=20
 	if (n =3D 1)
@@ -380,6 +388,7 @@
 	data->beep_mask &=3D data->alarm_mask;
 	gl520_write_value(client, GL520_REG_BEEP_MASK, data->beep_mask);
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -398,6 +407,7 @@
 		return -EINVAL;
 	}
=20
+	down(&data->update_lock);
 	data->fan_div[n - 1] =3D r;
=20
 	if (n =3D 1)
@@ -405,6 +415,7 @@
 	else
 		gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x30) |=
 (r << 4));
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -412,9 +423,10 @@
 {
 	u8 r =3D simple_strtoul(buf, NULL, 10)?1:0;
=20
+	down(&data->update_lock);
 	data->fan_off =3D r;
 	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x0c) | =
(r << 2));
-
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -439,22 +451,22 @@
 static ssize_t set_temp_max(struct i2c_client *client, struct gl520_data *=
data, const char *buf, size_t count, int n, int reg)
 {
 	long v =3D simple_strtol(buf, NULL, 10);
-	u8 r =3D TEMP_TO_REG(v);
-
-	data->temp_max[n - 1] =3D r;
-	gl520_write_value(client, reg, r);
=20
+	down(&data->update_lock);
+	data->temp_max[n - 1] =3D TEMP_TO_REG(v);;
+	gl520_write_value(client, reg, data->temp_max[n - 1]);
+	up(&data->update_lock);
 	return count;
 }
=20
 static ssize_t set_temp_max_hyst(struct i2c_client *client, struct gl520_d=
ata *data, const char *buf, size_t count, int n, int reg)
 {
 	long v =3D simple_strtol(buf, NULL, 10);
-	u8 r =3D TEMP_TO_REG(v);
-
-	data->temp_max_hyst[n - 1] =3D r;
-	gl520_write_value(client, reg, r);
=20
+	down(&data->update_lock);
+	data->temp_max_hyst[n - 1] =3D TEMP_TO_REG(v);
+	gl520_write_value(client, reg, data->temp_max_hyst[n - 1]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -477,19 +489,22 @@
 {
 	u8 r =3D simple_strtoul(buf, NULL, 10)?0:1;
=20
+	down(&data->update_lock);
 	data->beep_enable =3D !r;
 	gl520_write_value(client, reg, (gl520_read_value(client, reg) & ~0x04) | =
(r << 2));
-
+	up(&data->update_lock);
 	return count;
 }
=20
 static ssize_t set_beep_mask(struct i2c_client *client, struct gl520_data =
*data, const char *buf, size_t count, int n, int reg)
 {
-	u8 r =3D simple_strtoul(buf, NULL, 10) & data->alarm_mask;
-
+	u8 r =3D simple_strtoul(buf, NULL, 10);
+=09
+	down(&data->update_lock);
+	r &=3D data->alarm_mask;
 	data->beep_mask =3D r;
 	gl520_write_value(client, reg, r);
-
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/it87.c linux-2.6.12-r=
c1-mm3/drivers/i2c/chips/it87.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/it87.c	2005-03-28 09:57:20.=
000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/it87.c	2005-03-28 12:08:49.00000=
0000 +0200
@@ -265,9 +265,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] =3D IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MIN(nr),=20
 			data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_in_max(struct device *dev, const char *buf,=20
@@ -276,9 +279,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] =3D IN_TO_REG(val);
 	it87_write_value(client, IT87_REG_VIN_MAX(nr),=20
 			data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -356,8 +362,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_high[nr] =3D TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_min(struct device *dev, const char *buf,=20
@@ -366,8 +375,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_low[nr] =3D TEMP_TO_REG(val);
 	it87_write_value(client, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_temp_offset(offset)					\
@@ -408,9 +420,11 @@
 static ssize_t show_sensor(struct device *dev, char *buf, int nr)
 {
 	struct it87_data *data =3D it87_update_device(dev);
-	if (data->sensor & (1 << nr))
+	u8 reg =3D data->sensor; /* In case the value is updated while we use it =
*/
+=09
+	if (reg & (1 << nr))
 		return sprintf(buf, "3\n");  /* thermal diode */
-	if (data->sensor & (8 << nr))
+	if (reg & (8 << nr))
 		return sprintf(buf, "2\n");  /* thermistor */
 	return sprintf(buf, "0\n");      /* disabled */
 }
@@ -421,6 +435,8 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
+	down(&data->update_lock);
+
 	data->sensor &=3D ~(1 << nr);
 	data->sensor &=3D ~(8 << nr);
 	/* 3 =3D thermal diode; 2 =3D thermistor; 0 =3D disabled */
@@ -428,9 +444,12 @@
 	    data->sensor |=3D 1 << nr;
 	else if (val =3D 2)
 	    data->sensor |=3D 8 << nr;
-	else if (val !=3D 0)
+	else if (val !=3D 0) {
+		up(&data->update_lock);
 		return -EINVAL;
+	}
 	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
+	up(&data->update_lock);
 	return count;
 }
 #define show_sensor_offset(offset)					\
@@ -484,8 +503,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_fan_div(struct device *dev, const char *buf,=20
@@ -495,7 +517,10 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
 	int i, min[3];
-	u8 old =3D it87_read_value(client, IT87_REG_FAN_DIV);
+	u8 old;
+
+	down(&data->update_lock);
+	old =3D it87_read_value(client, IT87_REG_FAN_DIV);
=20
 	for (i =3D 0; i < 3; i++)
 		min[i] =3D FAN_FROM_REG(data->fan_min[i], DIV_FROM_REG(data->fan_div[i])=
);
@@ -522,6 +547,7 @@
 		data->fan_min[i]=FAN_TO_REG(min[i], DIV_FROM_REG(data->fan_div[i]));
 		it87_write_value(client, IT87_REG_FAN_MIN(i), data->fan_min[i]);
 	}
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_pwm_enable(struct device *dev, const char *buf,
@@ -531,6 +557,8 @@
 	struct it87_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
=20
+	down(&data->update_lock);
+
 	if (val =3D 0) {
 		int tmp;
 		/* make sure the fan is on when in on/off mode */
@@ -545,9 +573,12 @@
 		it87_write_value(client, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
 		/* set saved pwm value, clear FAN_CTLX PWM mode bit */
 		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_c=
tl[nr]));
-	} else
+	} else {
+		up(&data->update_lock);
 		return -EINVAL;
+	}
=20
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_pwm(struct device *dev, const char *buf,
@@ -560,10 +591,11 @@
 	if (val < 0 || val > 255)
 		return -EINVAL;
=20
+	down(&data->update_lock);
 	data->manual_pwm_ctl[nr] =3D val;
 	if (data->fan_main_ctrl & (1 << nr))
 		it87_write_value(client, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_c=
tl[nr]));
-
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm63.c linux-2.6.12-r=
c1-mm3/drivers/i2c/chips/lm63.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm63.c	2005-03-28 09:56:09.=
000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/lm63.c	2005-03-28 10:10:12.00000=
0000 +0200
@@ -191,11 +191,14 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm63_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan1_low =3D FAN_TO_REG(val);
 	i2c_smbus_write_byte_data(client, LM63_REG_TACH_LIMIT_LSB,
 				  data->fan1_low & 0xFF);
 	i2c_smbus_write_byte_data(client, LM63_REG_TACH_LIMIT_MSB,
 				  data->fan1_low >> 8);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -217,10 +220,12 @@
 		return -EPERM;
=20
 	val =3D simple_strtoul(buf, NULL, 10);
+	down(&data->update_lock);
 	data->pwm1_value =3D val <=3D 0 ? 0 :
 			   val >=3D 255 ? 2 * data->pwm1_freq :
 			   (val * data->pwm1_freq * 2 + 127) / 255;
 	i2c_smbus_write_byte_data(client, LM63_REG_PWM_VALUE, data->pwm1_value);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -256,8 +261,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct lm63_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->value =3D TEMP8_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
+	up(&data->update_lock); \
 	return count; \
 }
 #define set_temp11(value, reg_msb, reg_lsb) \
@@ -267,9 +275,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct lm63_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->value =3D TEMP11_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg_msb, data->value >> 8); \
 	i2c_smbus_write_byte_data(client, reg_lsb, data->value & 0xff); \
+	up(&data->update_lock); \
 	return count; \
 }
 set_temp8(temp1_high, LM63_REG_LOCAL_HIGH);
@@ -292,10 +303,14 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm63_data *data =3D i2c_get_clientdata(client);
-	int hyst =3D TEMP8_FROM_REG(data->temp2_crit) -
-		   simple_strtol(buf, NULL, 10);
+	long val =3D simple_strtol(buf, NULL, 10);
+	long hyst;
+
+	down(&data->update_lock);
+	hyst =3D TEMP8_FROM_REG(data->temp2_crit) - val;
 	i2c_smbus_write_byte_data(client, LM63_REG_REMOTE_TCRIT_HYST,
 				  HYST_TO_REG(hyst));
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm75.c linux-2.6.12-r=
c1-mm3/drivers/i2c/chips/lm75.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm75.c	2005-03-28 09:56:09.=
000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/lm75.c	2005-03-28 10:10:12.00000=
0000 +0200
@@ -90,8 +90,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);		\
 	struct lm75_data *data =3D i2c_get_clientdata(client);	\
 	int temp =3D simple_strtoul(buf, NULL, 10);		\
+								\
+	down(&data->update_lock);				\
 	data->value =3D LM75_TEMP_TO_REG(temp);			\
 	lm75_write_value(client, reg, data->value);		\
+	up(&data->update_lock);					\
 	return count;						\
 }
 set(temp_max, LM75_REG_TEMP_OS);
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm77.c linux-2.6.12-r=
c1-mm3/drivers/i2c/chips/lm77.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm77.c	2005-03-28 09:56:09.=
000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/lm77.c	2005-03-28 12:11:00.00000=
0000 +0200
@@ -138,8 +138,12 @@
 {										\
 	struct i2c_client *client =3D to_i2c_client(dev);				\
 	struct lm77_data *data =3D i2c_get_clientdata(client);			\
-	data->value =3D simple_strtoul(buf, NULL, 10);				\
+	long val =3D simple_strtoul(buf, NULL, 10);				\
+										\
+	down(&data->update_lock);						\
+	data->value =3D val;				\
 	lm77_write_value(client, reg, LM77_TEMP_TO_REG(data->value));		\
+	up(&data->update_lock);							\
 	return count;								\
 }
=20
@@ -152,9 +156,13 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm77_data *data =3D i2c_get_clientdata(client);
-	data->temp_hyst =3D data->temp_crit - simple_strtoul(buf, NULL, 10);
+	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp_hyst =3D data->temp_crit - val;
 	lm77_write_value(client, LM77_REG_TEMP_HYST,
 			 LM77_TEMP_TO_REG(data->temp_hyst));
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -163,13 +171,18 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm77_data *data =3D i2c_get_clientdata(client);
-	int oldcrithyst =3D data->temp_crit - data->temp_hyst;
-	data->temp_crit =3D simple_strtoul(buf, NULL, 10);
+	long val =3D simple_strtoul(buf, NULL, 10);
+	int oldcrithyst;
+=09
+	down(&data->update_lock);
+	oldcrithyst =3D data->temp_crit - data->temp_hyst;
+	data->temp_crit =3D val;
 	data->temp_hyst =3D data->temp_crit - oldcrithyst;
 	lm77_write_value(client, LM77_REG_TEMP_CRIT,
 			 LM77_TEMP_TO_REG(data->temp_crit));
 	lm77_write_value(client, LM77_REG_TEMP_HYST,
 			 LM77_TEMP_TO_REG(data->temp_hyst));
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm78.c linux-2.6.12-r=
c1-mm3/drivers/i2c/chips/lm78.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm78.c	2005-03-28 09:56:09.=
000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/lm78.c	2005-03-28 10:10:12.00000=
0000 +0200
@@ -200,8 +200,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm78_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] =3D IN_TO_REG(val);
 	lm78_write_value(client, LM78_REG_IN_MIN(nr), data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -211,8 +214,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm78_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] =3D IN_TO_REG(val);
 	lm78_write_value(client, LM78_REG_IN_MAX(nr), data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
 =09
@@ -275,8 +281,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm78_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_over =3D TEMP_TO_REG(val);
 	lm78_write_value(client, LM78_REG_TEMP_OVER, data->temp_over);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -291,8 +300,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm78_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_hyst =3D TEMP_TO_REG(val);
 	lm78_write_value(client, LM78_REG_TEMP_HYST, data->temp_hyst);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -323,8 +335,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm78_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	lm78_write_value(client, LM78_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -343,10 +358,14 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm78_data *data =3D i2c_get_clientdata(client);
-	unsigned long min =3D FAN_FROM_REG(data->fan_min[nr],
-			DIV_FROM_REG(data->fan_div[nr]));
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
-	int reg =3D lm78_read_value(client, LM78_REG_VID_FANDIV);
+	unsigned long min;
+	u8 reg;
+
+	down(&data->update_lock);
+	min =3D FAN_FROM_REG(data->fan_min[nr],
+			   DIV_FROM_REG(data->fan_div[nr]));
+
 	switch (val) {
 	case 1: data->fan_div[nr] =3D 0; break;
 	case 2: data->fan_div[nr] =3D 1; break;
@@ -355,9 +374,11 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		up(&data->update_lock);
 		return -EINVAL;
 	}
=20
+	reg =3D lm78_read_value(client, LM78_REG_VID_FANDIV);
 	switch (nr) {
 	case 0:
 		reg =3D (reg & 0xcf) | (data->fan_div[nr] << 4);
@@ -367,9 +388,12 @@
 		break;
 	}
 	lm78_write_value(client, LM78_REG_VID_FANDIV, reg);
+
 	data->fan_min[nr]  		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	lm78_write_value(client, LM78_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
+
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm80.c linux-2.6.12-r=
c1-mm3/drivers/i2c/chips/lm80.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm80.c	2005-03-28 09:56:09.=
000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/lm80.c	2005-03-28 10:10:12.00000=
0000 +0200
@@ -190,8 +190,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct lm80_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock);\
 	data->value =3D IN_TO_REG(val); \
 	lm80_write_value(client, reg, data->value); \
+	up(&data->update_lock);\
 	return count; \
 }
 set_in(min0, in_min[0], LM80_REG_IN_MIN(0));
@@ -237,8 +240,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct lm80_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtoul(buf, NULL, 10); \
+ \
+	down(&data->update_lock);\
 	data->value =3D FAN_TO_REG(val, DIV_FROM_REG(data->div)); \
 	lm80_write_value(client, reg, data->value); \
+	up(&data->update_lock);\
 	return count; \
 }
 set_fan(min1, fan_min[0], LM80_REG_FAN_MIN(1), fan_div[0]);
@@ -253,15 +259,14 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm80_data *data =3D i2c_get_clientdata(client);
-	unsigned long min, val;
+	unsigned long min, val =3D simple_strtoul(buf, NULL, 10);
 	u8 reg;
=20
 	/* Save fan_min */
+	down(&data->update_lock);
 	min =3D FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
=20
-	val =3D simple_strtoul(buf, NULL, 10);
-
 	switch (val) {
 	case 1: data->fan_div[nr] =3D 0; break;
 	case 2: data->fan_div[nr] =3D 1; break;
@@ -270,6 +275,7 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		up(&data->update_lock);
 		return -EINVAL;
 	}
=20
@@ -280,6 +286,7 @@
 	/* Restore fan_min */
 	data->fan_min[nr] =3D FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	lm80_write_value(client, LM80_REG_FAN_MIN(nr + 1), data->fan_min[nr]);
+	up(&data->update_lock);
=20
 	return count;
 }
@@ -317,8 +324,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct lm80_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtoul(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->value =3D TEMP_LIMIT_TO_REG(val); \
 	lm80_write_value(client, reg, data->value); \
+	up(&data->update_lock); \
 	return count; \
 }
 set_temp(hot_max, temp_hot_max, LM80_REG_TEMP_HOT_MAX);
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm83.c linux-2.6.12-r=
c1-mm3/drivers/i2c/chips/lm83.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm83.c	2005-03-28 09:56:09.=
000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/lm83.c	2005-03-28 10:10:12.00000=
0000 +0200
@@ -177,8 +177,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct lm83_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->value =3D TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
+	up(&data->update_lock); \
 	return count; \
 }
 set_temp(high1, temp_high[0], LM83_REG_W_LOCAL_HIGH);
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm85.c linux-2.6.12-r=
c1-mm3/drivers/i2c/chips/lm85.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm85.c	2005-03-26 07:00:03.=
000000000 +0100
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/lm85.c	2005-03-28 12:30:06.00000=
0000 +0200
@@ -416,10 +416,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int	val;
+	long val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->fan_min[nr] =3D FAN_TO_REG(val);
 	lm85_write_value(client, LM85_REG_FAN_MIN(nr), data->fan_min[nr]);
 	up(&data->update_lock);
@@ -499,10 +498,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int	val;
+	long val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->pwm[nr] =3D PWM_TO_REG(val);
 	lm85_write_value(client, LM85_REG_PWM(nr), data->pwm[nr]);
 	up(&data->update_lock);
@@ -560,10 +558,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int	val;
+	long val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->in_min[nr] =3D INS_TO_REG(nr, val);
 	lm85_write_value(client, LM85_REG_IN_MIN(nr), data->in_min[nr]);
 	up(&data->update_lock);
@@ -579,10 +576,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int	val;
+	long val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->in_max[nr] =3D INS_TO_REG(nr, val);
 	lm85_write_value(client, LM85_REG_IN_MAX(nr), data->in_max[nr]);
 	up(&data->update_lock);
@@ -643,10 +639,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int	val;
+	long val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->temp_min[nr] =3D TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_TEMP_MIN(nr), data->temp_min[nr]);
 	up(&data->update_lock);
@@ -662,10 +657,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int	val;
+	long val =3D simple_strtol(buf, NULL, 10);=09
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->temp_max[nr] =3D TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_TEMP_MAX(nr), data->temp_max[nr]);
 	up(&data->update_lock);
@@ -718,10 +712,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	long val =3D simple_strtol(buf, NULL, 10);  =20
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->autofan[nr].config =3D (data->autofan[nr].config & (~0xe0))
 		| ZONE_TO_REG(val) ;
 	lm85_write_value(client, LM85_REG_AFAN_CONFIG(nr),
@@ -739,10 +732,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	long val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->autofan[nr].min_pwm =3D PWM_TO_REG(val);
 	lm85_write_value(client, LM85_REG_AFAN_MINPWM(nr),
 		data->autofan[nr].min_pwm);
@@ -759,10 +751,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	long val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->autofan[nr].min_off =3D val;
 	lm85_write_value(client, LM85_REG_AFAN_SPIKE1, data->smooth[0]
 		| data->syncpwm3
@@ -783,10 +774,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	long val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->autofan[nr].freq =3D FREQ_TO_REG(val);
 	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 		(data->zone[nr].range << 4)
@@ -865,10 +855,10 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int    min, val;
+	int min;
+	long val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	min =3D TEMP_FROM_REG(data->zone[nr].limit);
 	data->zone[nr].off_desired =3D TEMP_TO_REG(val);
 	data->zone[nr].hyst =3D HYST_TO_REG(min - val);
@@ -895,10 +885,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int    val;
+	long val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->zone[nr].limit =3D TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_AFAN_LIMIT(nr),
 		data->zone[nr].limit);
@@ -939,11 +928,11 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int    min, val;
+	int min;
+	long val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
 	min =3D TEMP_FROM_REG(data->zone[nr].limit);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->zone[nr].max_desired =3D TEMP_TO_REG(val);
 	data->zone[nr].range =3D RANGE_TO_REG(
 		val - min);
@@ -963,10 +952,9 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm85_data *data =3D i2c_get_clientdata(client);
-	int     val;
+	long val =3D simple_strtol(buf, NULL, 10);
=20
 	down(&data->update_lock);
-	val =3D simple_strtol(buf, NULL, 10);
 	data->zone[nr].critical =3D TEMP_TO_REG(val);
 	lm85_write_value(client, LM85_REG_AFAN_CRITICAL(nr),
 		data->zone[nr].critical);
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm87.c linux-2.6.12-r=
c1-mm3/drivers/i2c/chips/lm87.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm87.c	2005-03-28 09:56:09.=
000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/lm87.c	2005-03-28 10:10:12.00000=
0000 +0200
@@ -252,9 +252,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] =3D IN_TO_REG(val, data->in_scale[nr]);
 	lm87_write_value(client, nr<6 ? LM87_REG_IN_MIN(nr) :
 			 LM87_REG_AIN_MIN(nr-6), data->in_min[nr]);
+	up(&data->update_lock);
 }
=20
 static void set_in_max(struct device *dev, const char *buf, int nr)
@@ -262,9 +265,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] =3D IN_TO_REG(val, data->in_scale[nr]);
 	lm87_write_value(client, nr<6 ? LM87_REG_IN_MAX(nr) :
 			 LM87_REG_AIN_MAX(nr-6), data->in_max[nr]);
+	up(&data->update_lock);
 }
=20
 #define set_in(offset) \
@@ -320,8 +326,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_low[nr] =3D TEMP_TO_REG(val);
 	lm87_write_value(client, LM87_REG_TEMP_LOW[nr], data->temp_low[nr]);
+	up(&data->update_lock);
 }
=20
 static void set_temp_high(struct device *dev, const char *buf, int nr)
@@ -329,8 +338,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_high[nr] =3D TEMP_TO_REG(val);
 	lm87_write_value(client, LM87_REG_TEMP_HIGH[nr], data->temp_high[nr]);
+	up(&data->update_lock);
 }
=20
 #define set_temp(offset) \
@@ -398,9 +410,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val,
 			    FAN_DIV_FROM_REG(data->fan_div[nr]));
 	lm87_write_value(client, LM87_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 }
=20
 /* Note: we save and restore the fan minimum here, because its value is
@@ -413,16 +428,21 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
-	unsigned long min =3D FAN_FROM_REG(data->fan_min[nr],
-			    FAN_DIV_FROM_REG(data->fan_div[nr]));
+	unsigned long min;
 	u8 reg;
=20
+	down(&data->update_lock);
+	min =3D FAN_FROM_REG(data->fan_min[nr],
+			   FAN_DIV_FROM_REG(data->fan_div[nr]));
+
 	switch (val) {
 	case 1: data->fan_div[nr] =3D 0; break;
 	case 2: data->fan_div[nr] =3D 1; break;
 	case 4: data->fan_div[nr] =3D 2; break;
 	case 8: data->fan_div[nr] =3D 3; break;
-	default: return -EINVAL;
+	default:
+		up(&data->update_lock);
+		return -EINVAL;
 	}
=20
 	reg =3D lm87_read_value(client, LM87_REG_VID_FAN_DIV);
@@ -439,6 +459,8 @@
 	data->fan_min[nr] =3D FAN_TO_REG(min, val);
 	lm87_write_value(client, LM87_REG_FAN_MIN(nr),
 			 data->fan_min[nr]);
+	up(&data->update_lock);
+
 	return count;
 }
=20
@@ -499,8 +521,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm87_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->aout =3D AOUT_TO_REG(val);
 	lm87_write_value(client, LM87_REG_AOUT, data->aout);
+	up(&data->update_lock);
 	return count;
 }
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm90.c linux-2.6.12-r=
c1-mm3/drivers/i2c/chips/lm90.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm90.c	2005-03-28 09:56:09.=
000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/lm90.c	2005-03-28 10:10:12.00000=
0000 +0200
@@ -239,11 +239,14 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct lm90_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	if (data->kind =3D adt7461) \
 		data->value =3D TEMP1_TO_REG_ADT7461(val); \
 	else \
 		data->value =3D TEMP1_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
+	up(&data->update_lock); \
 	return count; \
 }
 #define set_temp2(value, regh, regl) \
@@ -253,12 +256,15 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct lm90_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	if (data->kind =3D adt7461) \
 		data->value =3D TEMP2_TO_REG_ADT7461(val); \
 	else \
 		data->value =3D TEMP2_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, regh, data->value >> 8); \
 	i2c_smbus_write_byte_data(client, regl, data->value & 0xff); \
+	up(&data->update_lock); \
 	return count; \
 }
 set_temp1(temp_low1, LM90_REG_W_LOCAL_LOW);
@@ -283,10 +289,14 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm90_data *data =3D i2c_get_clientdata(client);
-	int hyst =3D TEMP1_FROM_REG(data->temp_crit1) -
-		   simple_strtol(buf, NULL, 10);
+	long val =3D simple_strtol(buf, NULL, 10);
+	long hyst;
+
+	down(&data->update_lock);
+	hyst =3D TEMP1_FROM_REG(data->temp_crit1) - val;
 	i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
 				  HYST_TO_REG(hyst));
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm92.c linux-2.6.12-r=
c1-mm3/drivers/i2c/chips/lm92.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/lm92.c	2005-03-28 09:56:09.=
000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/lm92.c	2005-03-28 10:10:12.00000=
0000 +0200
@@ -157,8 +157,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct lm92_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->value =3D TEMP_TO_REG(val); \
 	i2c_smbus_write_word_data(client, reg, swab16(data->value)); \
+	up(&data->update_lock); \
 	return count; \
 }
 set_temp(temp1_crit, LM92_REG_TEMP_CRIT);
@@ -189,10 +192,13 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct lm92_data *data =3D i2c_get_clientdata(client);
-	data->temp1_hyst =3D TEMP_FROM_REG(data->temp1_crit) -
-			   simple_strtol(buf, NULL, 10);
+	long val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp1_hyst =3D TEMP_FROM_REG(data->temp1_crit) - val;
 	i2c_smbus_write_word_data(client, LM92_REG_TEMP_HYST,
 				  swab16(TEMP_TO_REG(data->temp1_hyst)));
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/max1619.c linux-2.6.1=
2-rc1-mm3/drivers/i2c/chips/max1619.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/max1619.c	2005-03-28 09:57:=
20.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/max1619.c	2005-03-28 10:10:12.00=
0000000 +0200
@@ -141,8 +141,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct max1619_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->value =3D TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
+	up(&data->update_lock); \
 	return count; \
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/pc87360.c linux-2.6.1=
2-rc1-mm3/drivers/i2c/chips/pc87360.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/pc87360.c	2005-03-28 09:56:=
09.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/pc87360.c	2005-03-28 10:10:12.00=
0000000 +0200
@@ -259,6 +259,7 @@
 	struct pc87360_data *data =3D i2c_get_clientdata(client);
 	long fan_min =3D simple_strtol(buf, NULL, 10);
=20
+	down(&data->update_lock);
 	fan_min =3D FAN_TO_REG(fan_min, FAN_DIV_FROM_REG(data->fan_status[nr]));
=20
 	/* If it wouldn't fit, change clock divisor */
@@ -275,6 +276,7 @@
 	/* Write new divider, preserve alarm bits */
 	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_FAN_STATUS(nr),
 			    data->fan_status[nr] & 0xF9);
+	up(&data->update_lock);
=20
 	return count;
 }
@@ -336,10 +338,13 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct pc87360_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->pwm[offset-1] =3D PWM_TO_REG(val, \
 			      FAN_CONFIG_INVERT(data->fan_conf, offset-1)); \
 	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(offset-1), \
 			    data->pwm[offset-1]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(pwm##offset, S_IWUSR | S_IRUGO, \
@@ -378,9 +383,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct pc87360_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_min[offset] =3D IN_TO_REG(val, data->in_vref); \
 	pc87360_write_value(data, LD_IN, offset, PC87365_REG_IN_MIN, \
 			    data->in_min[offset]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_in##offset##_max(struct device *dev, const char *buf, \
@@ -389,10 +397,13 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct pc87360_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_max[offset] =3D IN_TO_REG(val, \
 			       data->in_vref); \
 	pc87360_write_value(data, LD_IN, offset, PC87365_REG_IN_MAX, \
 			    data->in_max[offset]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
@@ -451,9 +462,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct pc87360_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_min[offset+7] =3D IN_TO_REG(val, data->in_vref); \
 	pc87360_write_value(data, LD_IN, offset+7, PC87365_REG_TEMP_MIN, \
 			    data->in_min[offset+7]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_temp##offset##_max(struct device *dev, const char *buf,=
 \
@@ -462,9 +476,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct pc87360_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_max[offset+7] =3D IN_TO_REG(val, data->in_vref); \
 	pc87360_write_value(data, LD_IN, offset+7, PC87365_REG_TEMP_MAX, \
 			    data->in_max[offset+7]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_temp##offset##_crit(struct device *dev, const char *buf=
, \
@@ -473,9 +490,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct pc87360_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->in_crit[offset-4] =3D IN_TO_REG(val, data->in_vref); \
 	pc87360_write_value(data, LD_IN, offset+7, PC87365_REG_TEMP_CRIT, \
 			    data->in_crit[offset-4]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
@@ -552,9 +572,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct pc87360_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->temp_min[offset-1] =3D TEMP_TO_REG(val); \
 	pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_MIN, \
 			    data->temp_min[offset-1]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_temp##offset##_max(struct device *dev, const char *buf,=
 \
@@ -563,9 +586,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct pc87360_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->temp_max[offset-1] =3D TEMP_TO_REG(val); \
 	pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_MAX, \
 			    data->temp_max[offset-1]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static ssize_t set_temp##offset##_crit(struct device *dev, const char *buf=
, \
@@ -574,9 +600,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev); \
 	struct pc87360_data *data =3D i2c_get_clientdata(client); \
 	long val =3D simple_strtol(buf, NULL, 10); \
+ \
+	down(&data->update_lock); \
 	data->temp_crit[offset-1] =3D TEMP_TO_REG(val); \
 	pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_CRIT, \
 			    data->temp_crit[offset-1]); \
+	up(&data->update_lock); \
 	return count; \
 } \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/pcf8591.c linux-2.6.1=
2-rc1-mm3/drivers/i2c/chips/pcf8591.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/pcf8591.c	2005-03-28 09:57:=
20.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/pcf8591.c	2005-03-28 12:34:18.00=
0000000 +0200
@@ -144,11 +144,15 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct pcf8591_data *data =3D i2c_get_clientdata(client);
-	if (simple_strtoul(buf, NULL, 10))
+	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	if (val)
 		data->control |=3D PCF8591_CONTROL_AOEF;
 	else
 		data->control &=3D ~PCF8591_CONTROL_AOEF;
 	i2c_smbus_write_byte(client, data->control);
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/sis5595.c linux-2.6.1=
2-rc1-mm3/drivers/i2c/chips/sis5595.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/sis5595.c	2005-03-28 09:57:=
20.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/sis5595.c	2005-03-28 12:35:12.00=
0000000 +0200
@@ -232,8 +232,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] =3D IN_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_IN_MIN(nr), data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -243,8 +246,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] =3D IN_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_IN_MAX(nr), data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -305,8 +311,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_over =3D TEMP_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_TEMP_OVER, data->temp_over);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -321,8 +330,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
 	long val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_hyst =3D TEMP_TO_REG(val);
 	sis5595_write_value(client, SIS5595_REG_TEMP_HYST, data->temp_hyst);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -353,8 +365,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	sis5595_write_value(client, SIS5595_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -373,10 +388,15 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct sis5595_data *data =3D i2c_get_clientdata(client);
-	unsigned long min =3D FAN_FROM_REG(data->fan_min[nr],
-			DIV_FROM_REG(data->fan_div[nr]));
+	unsigned long min;
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
-	int reg =3D sis5595_read_value(client, SIS5595_REG_FANDIV);
+	int reg;
+
+	down(&data->update_lock);
+	min =3D FAN_FROM_REG(data->fan_min[nr],
+			DIV_FROM_REG(data->fan_div[nr]));
+	reg =3D sis5595_read_value(client, SIS5595_REG_FANDIV);
+
 	switch (val) {
 	case 1: data->fan_div[nr] =3D 0; break;
 	case 2: data->fan_div[nr] =3D 1; break;
@@ -385,6 +405,7 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		up(&data->update_lock);
 		return -EINVAL;
 	}
 =09
@@ -400,6 +421,7 @@
 	data->fan_min[nr]  		FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	sis5595_write_value(client, SIS5595_REG_FAN_MIN(nr), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/smsc47m1.c linux-2.6.=
12-rc1-mm3/drivers/i2c/chips/smsc47m1.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/smsc47m1.c	2005-03-28 09:56=
:09.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/smsc47m1.c	2005-03-28 10:10:12.0=
00000000 +0200
@@ -195,16 +195,20 @@
 {
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct smsc47m1_data *data =3D i2c_get_clientdata(client);
+	long rpmdiv, val =3D simple_strtol(buf, NULL, 10);
=20
-	long rpmdiv =3D simple_strtol(buf, NULL, 10)
-		    * DIV_FROM_REG(data->fan_div[nr]);
+	down(&data->update_lock);
+	rpmdiv =3D val * DIV_FROM_REG(data->fan_div[nr]);
=20
-	if (983040 > 192 * rpmdiv || 2 * rpmdiv > 983040)
+	if (983040 > 192 * rpmdiv || 2 * rpmdiv > 983040) {
+		up(&data->update_lock);
 		return -EINVAL;
+	}
=20
 	data->fan_preload[nr] =3D 192 - ((983040 + rpmdiv / 2) / rpmdiv);
 	smsc47m1_write_value(client, SMSC47M1_REG_FAN_PRELOAD(nr),
 			     data->fan_preload[nr]);
+	up(&data->update_lock);
=20
 	return count;
 }
@@ -224,12 +228,16 @@
=20
 	if (new_div =3D old_div) /* No change */
 		return count;
+
+	down(&data->update_lock);
 	switch (new_div) {
 	case 1: data->fan_div[nr] =3D 0; break;
 	case 2: data->fan_div[nr] =3D 1; break;
 	case 4: data->fan_div[nr] =3D 2; break;
 	case 8: data->fan_div[nr] =3D 3; break;
-	default: return -EINVAL;
+	default:
+		up(&data->update_lock);
+		return -EINVAL;
 	}
=20
 	tmp =3D smsc47m1_read_value(client, SMSC47M1_REG_FANDIV) & 0x0F;
@@ -242,6 +250,7 @@
 	data->fan_preload[nr] =3D SENSORS_LIMIT(tmp, 0, 191);
 	smsc47m1_write_value(client, SMSC47M1_REG_FAN_PRELOAD(nr),
 			     data->fan_preload[nr]);
+	up(&data->update_lock);
=20
 	return count;
 }
@@ -257,11 +266,13 @@
 	if (val < 0 || val > 255)
 		return -EINVAL;
=20
+	down(&data->update_lock);
 	data->pwm[nr] &=3D 0x81; /* Preserve additional bits */
 	data->pwm[nr] |=3D PWM_TO_REG(val);
-
 	smsc47m1_write_value(client, SMSC47M1_REG_PWM(nr),
 			     data->pwm[nr]);
+	up(&data->update_lock);
+
 	return count;
 }
=20
@@ -276,11 +287,12 @@
 	if (val !=3D 0 && val !=3D 1)
 		return -EINVAL;
=20
+	down(&data->update_lock);
 	data->pwm[nr] &=3D 0xFE; /* preserve the other bits */
 	data->pwm[nr] |=3D !val;
-
 	smsc47m1_write_value(client, SMSC47M1_REG_PWM(nr),
 			     data->pwm[nr]);
+	up(&data->update_lock);
=20
 	return count;
 }
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/via686a.c linux-2.6.1=
2-rc1-mm3/drivers/i2c/chips/via686a.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/via686a.c	2005-03-28 09:57:=
20.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/via686a.c	2005-03-28 10:10:12.00=
0000000 +0200
@@ -363,9 +363,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct via686a_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_min[nr] =3D IN_TO_REG(val,nr);
 	via686a_write_value(client, VIA686A_REG_IN_MIN(nr),=20
 			data->in_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_in_max(struct device *dev, const char *buf,=20
@@ -373,9 +376,12 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct via686a_data *data =3D i2c_get_clientdata(client);
 	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->in_max[nr] =3D IN_TO_REG(val,nr);
 	via686a_write_value(client, VIA686A_REG_IN_MAX(nr),=20
 			data->in_max[nr]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_in_offset(offset)					\
@@ -434,8 +440,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct via686a_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_over[nr] =3D TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr=
]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_hyst(struct device *dev, const char *buf,=20
@@ -443,8 +452,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct via686a_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->temp_hyst[nr] =3D TEMP_TO_REG(val);
 	via686a_write_value(client, VIA686A_REG_TEMP_HYST(nr), data->temp_hyst[nr=
]);
+	up(&data->update_lock);
 	return count;
 }
 #define show_temp_offset(offset)					\
@@ -502,8 +514,11 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct via686a_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	up(&data->update_lock);
 	return count;
 }
 static ssize_t set_fan_div(struct device *dev, const char *buf,=20
@@ -511,10 +526,14 @@
 	struct i2c_client *client =3D to_i2c_client(dev);
 	struct via686a_data *data =3D i2c_get_clientdata(client);
 	int val =3D simple_strtol(buf, NULL, 10);
-	int old =3D via686a_read_value(client, VIA686A_REG_FANDIV);
+	int old;
+
+	down(&data->update_lock);
+	old =3D via686a_read_value(client, VIA686A_REG_FANDIV);
 	data->fan_div[nr] =3D DIV_TO_REG(val);
 	old =3D (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
 	via686a_write_value(client, VIA686A_REG_FANDIV, old);
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/w83627hf.c linux-2.6.=
12-rc1-mm3/drivers/i2c/chips/w83627hf.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/w83627hf.c	2005-03-28 09:57=
:20.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/w83627hf.c	2005-03-28 10:10:12.0=
00000000 +0200
@@ -354,10 +354,13 @@
 	u32 val; \
 	 \
 	val =3D simple_strtoul(buf, NULL, 10); \
+	 \
+	down(&data->update_lock); \
 	data->in_##reg[nr] =3D IN_TO_REG(val); \
 	w83627hf_write_value(client, W83781D_REG_IN_##REG(nr), \
 			    data->in_##reg[nr]); \
 	 \
+	up(&data->update_lock); \
 	return count; \
 }
 store_in_reg(MIN, min)
@@ -442,6 +445,9 @@
 	u32 val;
=20
 	val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+=09
 	if ((data->vrm_ovt & 0x01) &&
 		(w83627thf =3D data->type || w83637hf =3D data->type))
=20
@@ -452,6 +458,7 @@
 		data->in_min[0] =3D IN_TO_REG(val);
=20
 	w83627hf_write_value(client, W83781D_REG_IN_MIN(0), data->in_min[0]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -463,6 +470,9 @@
 	u32 val;
=20
 	val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+
 	if ((data->vrm_ovt & 0x01) &&
 		(w83627thf =3D data->type || w83637hf =3D data->type))
 	=09
@@ -473,6 +483,7 @@
 		data->in_max[0] =3D IN_TO_REG(val);
=20
 	w83627hf_write_value(client, W83781D_REG_IN_MAX(0), data->in_max[0]);
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -508,11 +519,14 @@
 	u32 val;
=20
 	val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr - 1]  	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr=
 - 1]));
 	w83627hf_write_value(client, W83781D_REG_FAN_MIN(nr),
 			    data->fan_min[nr - 1]);
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -574,6 +588,8 @@
 	 \
 	val =3D simple_strtoul(buf, NULL, 10); \
 	 \
+	down(&data->update_lock); \
+	 \
 	if (nr >=3D 2) {	/* TEMP2 and TEMP3 */ \
 		data->temp_##reg##_add[nr-2] =3D LM75_TEMP_TO_REG(val); \
 		w83627hf_write_value(client, W83781D_REG_TEMP_##REG(nr), \
@@ -584,6 +600,7 @@
 			data->temp_##reg); \
 	} \
 	 \
+	up(&data->update_lock); \
 	return count; \
 }
 store_temp_reg(OVER, max);
@@ -692,6 +709,8 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
+	down(&data->update_lock);
+
 	if (update_mask =3D BEEP_MASK) {	/* We are storing beep_mask */
 		data->beep_mask =3D BEEP_MASK_TO_REG(val);
 		w83627hf_write_value(client, W83781D_REG_BEEP_INTS1,
@@ -708,6 +727,7 @@
 	w83627hf_write_value(client, W83781D_REG_BEEP_INTS2,
 			    val2 | data->beep_enable << 7);
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -752,12 +772,15 @@
 	struct w83627hf_data *data =3D i2c_get_clientdata(client);
 	unsigned long min;
 	u8 reg;
+	unsigned long val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
=20
 	/* Save fan_min */
 	min =3D FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
=20
-	data->fan_div[nr] =3D DIV_TO_REG(simple_strtoul(buf, NULL, 10));
+	data->fan_div[nr] =3D DIV_TO_REG(val);
=20
 	reg =3D (w83627hf_read_value(client, nr=3D2 ? W83781D_REG_PIN : W83781D_R=
EG_VID_FANDIV)
 	       & (nr=3D0 ? 0xcf : 0x3f))
@@ -773,6 +796,7 @@
 	data->fan_min[nr] =3D FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	w83627hf_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]=
);
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -815,6 +839,8 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
+	down(&data->update_lock);
+
 	if (data->type =3D w83627thf) {
 		/* bits 0-3 are reserved  in 627THF */
 		data->pwm[nr - 1] =3D PWM_TO_REG(val) & 0xf0;
@@ -830,6 +856,7 @@
 				     data->pwm[nr - 1]);
 	}
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -871,6 +898,8 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
+	down(&data->update_lock);
+
 	switch (val) {
 	case 1:		/* PII/Celeron diode */
 		tmp =3D w83627hf_read_value(client, W83781D_REG_SCFG1);
@@ -903,6 +932,7 @@
 		break;
 	}
=20
+	up(&data->update_lock);
 	return count;
 }
=20
diff -ruN linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/w83781d.c linux-2.6.1=
2-rc1-mm3/drivers/i2c/chips/w83781d.c
--- linux-2.6.12-rc1-mm3/drivers/i2c/chips.orig/w83781d.c	2005-03-28 09:57:=
20.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/w83781d.c	2005-03-28 12:44:08.00=
0000000 +0200
@@ -302,9 +302,12 @@
 	u32 val; \
 	 \
 	val =3D simple_strtoul(buf, NULL, 10) / 10; \
+	 \
+	down(&data->update_lock); \
 	data->in_##reg[nr] =3D IN_TO_REG(val); \
 	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr])=
; \
 	 \
+	up(&data->update_lock); \
 	return count; \
 }
 store_in_reg(MIN, min);
@@ -369,11 +372,14 @@
 	u32 val;
=20
 	val =3D simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
 	data->fan_min[nr - 1]  	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr=
 - 1]));
 	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr),
 			    data->fan_min[nr - 1]);
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -432,6 +438,8 @@
 	 \
 	val =3D simple_strtol(buf, NULL, 10); \
 	 \
+	down(&data->update_lock); \
+	 \
 	if (nr >=3D 2) {	/* TEMP2 and TEMP3 */ \
 		data->temp_##reg##_add[nr-2] =3D LM75_TEMP_TO_REG(val); \
 		w83781d_write_value(client, W83781D_REG_TEMP_##REG(nr), \
@@ -442,6 +450,7 @@
 			data->temp_##reg); \
 	} \
 	 \
+	up(&data->update_lock); \
 	return count; \
 }
 store_temp_reg(OVER, max);
@@ -554,6 +563,8 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
+	down(&data->update_lock);
+
 	if (update_mask =3D BEEP_MASK) {	/* We are storing beep_mask */
 		data->beep_mask =3D BEEP_MASK_TO_REG(val, data->type);
 		w83781d_write_value(client, W83781D_REG_BEEP_INTS1,
@@ -573,6 +584,7 @@
 	w83781d_write_value(client, W83781D_REG_BEEP_INTS2,
 			    val2 | data->beep_enable << 7);
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -615,13 +627,15 @@
 	struct w83781d_data *data =3D i2c_get_clientdata(client);
 	unsigned long min;
 	u8 reg;
+	unsigned long val =3D simple_strtoul(buf, NULL, 10);
=20
+	down(&data->update_lock);
+=09
 	/* Save fan_min */
 	min =3D FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
=20
-	data->fan_div[nr] =3D DIV_TO_REG(simple_strtoul(buf, NULL, 10),
-				      data->type);
+	data->fan_div[nr] =3D DIV_TO_REG(val, data->type);
=20
 	reg =3D (w83781d_read_value(client, nr=3D2 ? W83781D_REG_PIN : W83781D_RE=
G_VID_FANDIV)
 	       & (nr=3D0 ? 0xcf : 0x3f))
@@ -640,6 +654,7 @@
 	data->fan_min[nr] =3D FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
 	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -686,9 +701,10 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
+	down(&data->update_lock);
 	data->pwm[nr - 1] =3D PWM_TO_REG(val);
 	w83781d_write_value(client, W83781D_REG_PWM(nr), data->pwm[nr - 1]);
-
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -701,6 +717,8 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
+	down(&data->update_lock);
+
 	switch (val) {
 	case 0:
 	case 1:
@@ -716,9 +734,11 @@
 		break;
=20
 	default:
+		up(&data->update_lock);
 		return -EINVAL;
 	}
=20
+	up(&data->update_lock);
 	return count;
 }
=20
@@ -780,6 +800,8 @@
=20
 	val =3D simple_strtoul(buf, NULL, 10);
=20
+	down(&data->update_lock);
+
 	switch (val) {
 	case 1:		/* PII/Celeron diode */
 		tmp =3D w83781d_read_value(client, W83781D_REG_SCFG1);
@@ -811,6 +833,7 @@
 		break;
 	}
=20
+	up(&data->update_lock);
 	return count;
 }
=20

--=20
Jean Delvare
