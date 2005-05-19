From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PATCH 2.6] I2C: Fix macro calls in chip drivers
Message-Id: <20040825224408.67c8d4bd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I noticed that some I2C chip drivers (all written or reviewed by me, I
feel ashamed to say) misuse macros. Passing function calls
(simple_strtol in this case) to macros evaluating their argument up to 4
times is certainly not wise and obviously performs poorly. It is not
critical in that it happens only when writing to the chips (setting
limits), which doesn't happen that often. However I'd say it's worth
fixing.

Thus, the patch below fixes that, by moving the function calls outside
of the macro calls.

Thanks.

Signed-off-by: Jean Delvare <khali at linux-fr dot org>

diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/adm1025.c linux-2.6.9-rc1/drivers/i2c/chips/adm1025.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/adm1025.c	2004-08-24 18:42:46.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/adm1025.c	2004-08-24 19:34:03.000000000 +0200
@@ -212,8 +212,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct adm1025_data *data = i2c_get_clientdata(client); \
-	data->in_min[offset] = IN_TO_REG(simple_strtol(buf, NULL, 10), \
-			       in_scale[offset]); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->in_min[offset] = IN_TO_REG(val, in_scale[offset]); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MIN(offset), \
 				  data->in_min[offset]); \
 	return count; \
@@ -223,8 +223,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct adm1025_data *data = i2c_get_clientdata(client); \
-	data->in_max[offset] = IN_TO_REG(simple_strtol(buf, NULL, 10), \
-			       in_scale[offset]); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->in_max[offset] = IN_TO_REG(val, in_scale[offset]); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MAX(offset), \
 				  data->in_max[offset]); \
 	return count; \
@@ -246,7 +246,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct adm1025_data *data = i2c_get_clientdata(client); \
-	data->temp_min[offset-1] = TEMP_TO_REG(simple_strtol(buf, NULL, 10)); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->temp_min[offset-1] = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_LOW(offset-1), \
 				  data->temp_min[offset-1]); \
 	return count; \
@@ -256,7 +257,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct adm1025_data *data = i2c_get_clientdata(client); \
-	data->temp_max[offset-1] = TEMP_TO_REG(simple_strtol(buf, NULL, 10)); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->temp_max[offset-1] = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_HIGH(offset-1), \
 				  data->temp_max[offset-1]); \
 	return count; \
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/gl518sm.c linux-2.6.9-rc1/drivers/i2c/chips/gl518sm.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/gl518sm.c	2004-08-21 12:20:41.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/gl518sm.c	2004-08-24 19:44:40.000000000 +0200
@@ -217,7 +217,8 @@
 {									\
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct gl518_data *data = i2c_get_clientdata(client);		\
-	data->value = type##_TO_REG(simple_strtol(buf, NULL, 10));	\
+	long val = simple_strtol(buf, NULL, 10);			\
+	data->value = type##_TO_REG(val);				\
 	gl518_write_value(client, reg, data->value);			\
 	return count;							\
 }
@@ -229,7 +230,8 @@
 	struct i2c_client *client = to_i2c_client(dev);			\
 	struct gl518_data *data = i2c_get_clientdata(client);		\
 	int regvalue = gl518_read_value(client, reg);			\
-	data->value = type##_TO_REG(simple_strtoul(buf, NULL, 10));	\
+	unsigned long val = simple_strtoul(buf, NULL, 10);		\
+	data->value = type##_TO_REG(val);				\
 	regvalue = (regvalue & ~mask) | (data->value << shift);		\
 	gl518_write_value(client, reg, regvalue);			\
 	return count;							\
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/lm80.c linux-2.6.9-rc1/drivers/i2c/chips/lm80.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/lm80.c	2004-08-21 12:20:41.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/lm80.c	2004-08-24 19:41:08.000000000 +0200
@@ -262,14 +262,15 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm80_data *data = i2c_get_clientdata(client);
-	unsigned long min;
+	unsigned long min, val;
 	u8 reg;
 
 	/* Save fan_min */
 	min = FAN_FROM_REG(data->fan_min[nr],
 			   DIV_FROM_REG(data->fan_div[nr]));
 
-	data->fan_div[nr] = DIV_TO_REG(simple_strtoul(buf, NULL, 10));
+	val = simple_strtoul(buf, NULL, 10);
+	data->fan_div[nr] = DIV_TO_REG(val);
 
 	reg = (lm80_read_value(client, LM80_REG_FANDIV) & ~(3 << (2 * (nr + 1))))
 	    | (data->fan_div[nr] << (2 * (nr + 1)));
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/lm83.c linux-2.6.9-rc1/drivers/i2c/chips/lm83.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/lm83.c	2004-08-24 18:42:46.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/lm83.c	2004-08-24 19:39:16.000000000 +0200
@@ -180,7 +180,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm83_data *data = i2c_get_clientdata(client); \
-	data->value = TEMP_TO_REG(simple_strtol(buf, NULL, 10)); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->value = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
 	return count; \
 }
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/lm90.c linux-2.6.9-rc1/drivers/i2c/chips/lm90.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/lm90.c	2004-08-21 12:33:19.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/lm90.c	2004-08-24 19:37:50.000000000 +0200
@@ -214,7 +214,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm90_data *data = i2c_get_clientdata(client); \
-	data->value = TEMP1_TO_REG(simple_strtol(buf, NULL, 10)); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->value = TEMP1_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
 	return count; \
 }
@@ -224,7 +225,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm90_data *data = i2c_get_clientdata(client); \
-	data->value = TEMP2_TO_REG(simple_strtol(buf, NULL, 10)); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->value = TEMP2_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, regh, data->value >> 8); \
 	i2c_smbus_write_byte_data(client, regl, data->value & 0xff); \
 	return count; \
diff -ru linux-2.6.9-rc1/drivers/i2c/chips.orig/max1619.c linux-2.6.9-rc1/drivers/i2c/chips/max1619.c
--- linux-2.6.9-rc1/drivers/i2c/chips.orig/max1619.c	2004-08-21 12:20:41.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/max1619.c	2004-08-24 19:34:41.000000000 +0200
@@ -145,7 +145,8 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct max1619_data *data = i2c_get_clientdata(client); \
-	data->value = TEMP_TO_REG(simple_strtol(buf, NULL, 10)); \
+	long val = simple_strtol(buf, NULL, 10); \
+	data->value = TEMP_TO_REG(val); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
 	return count; \
 }


-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
