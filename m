From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: [PATCH 2.6] Enable changing fan_divs in lm80 driver
Message-Id: <20040404230032.3f256372.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

For some reason the original lm80 driver in 2.6 cannot set fan_divs
(while the 2.4 driver could). This patch brings support back. It was
lightly tested by one user.

This patch also suggests some code cleanups (fan code refactoring). I'll
send a different patch later for these.

Please apply,
thanks.

--- linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm80.c.orig	Sat Apr  3 12:01:39 2004
+++ linux-2.6.5-rc3-mm4/drivers/i2c/chips/lm80.c	Sun Apr  4 12:13:57 2004
@@ -44,10 +44,9 @@
 #define LM80_REG_IN_MIN(nr)		(0x2b + (nr) * 2)
 #define LM80_REG_IN(nr)			(0x20 + (nr))
 
-#define LM80_REG_FAN1_MIN		0x3c
-#define LM80_REG_FAN2_MIN		0x3d
 #define LM80_REG_FAN1			0x28
 #define LM80_REG_FAN2			0x29
+#define LM80_REG_FAN_MIN(nr)		(0x3b + (nr))
 
 #define LM80_REG_TEMP			0x27
 #define LM80_REG_TEMP_HOT_MAX		0x38
@@ -250,8 +249,46 @@
 	lm80_write_value(client, reg, data->value); \
 	return count; \
 }
-set_fan(min1, fan_min[0], LM80_REG_FAN1_MIN, fan_div[0]);
-set_fan(min2, fan_min[1], LM80_REG_FAN2_MIN, fan_div[1]);
+set_fan(min1, fan_min[0], LM80_REG_FAN_MIN(1), fan_div[0]);
+set_fan(min2, fan_min[1], LM80_REG_FAN_MIN(2), fan_div[1]);
+
+/* Note: we save and restore the fan minimum here, because its value is
+   determined in part by the fan divisor.  This follows the principle of
+   least suprise; the user doesn't expect the fan minimum to change just
+   because the divisor changed. */
+static ssize_t set_fan_div(struct device *dev, const char *buf,
+	size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm80_data *data = i2c_get_clientdata(client);
+	unsigned long min;
+	u8 reg;
+
+	/* Save fan_min */
+	min = FAN_FROM_REG(data->fan_min[nr],
+			   DIV_FROM_REG(data->fan_div[nr]));
+
+	data->fan_div[nr] = DIV_TO_REG(simple_strtoul(buf, NULL, 10));
+
+	reg = (lm80_read_value(client, LM80_REG_FANDIV) & ~(3 << (2 * (nr + 1))))
+	    | (data->fan_div[nr] << (2 * (nr + 1)));
+	lm80_write_value(client, LM80_REG_FANDIV, reg);
+
+	/* Restore fan_min */
+	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
+	lm80_write_value(client, LM80_REG_FAN_MIN(nr + 1), data->fan_min[nr]);
+
+	return count;
+}
+
+#define set_fan_div(number) \
+static ssize_t set_fan_div##number(struct device *dev, const char *buf, \
+	size_t count) \
+{ \
+	return set_fan_div(dev, buf, count, number - 1); \
+}
+set_fan_div(1);
+set_fan_div(2);
 
 static ssize_t show_temp_input1(struct device *dev, char *buf)
 {
@@ -319,8 +356,8 @@
     set_fan_min2);
 static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input1, NULL);
 static DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input2, NULL);
-static DEVICE_ATTR(fan1_div, S_IRUGO, show_fan_div1, NULL);
-static DEVICE_ATTR(fan2_div, S_IRUGO, show_fan_div2, NULL);
+static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, show_fan_div1, set_fan_div1);
+static DEVICE_ATTR(fan2_div, S_IWUSR | S_IRUGO, show_fan_div2, set_fan_div2);
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
 static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_hot_max,
     set_temp_hot_max);
@@ -401,6 +438,10 @@
 	/* Initialize the LM80 chip */
 	lm80_init_client(new_client);
 
+	/* A few vars need to be filled upon startup */
+	data->fan_min[0] = lm80_read_value(new_client, LM80_REG_FAN_MIN(1));
+	data->fan_min[1] = lm80_read_value(new_client, LM80_REG_FAN_MIN(2));
+
 	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_in0_min);
 	device_create_file(&new_client->dev, &dev_attr_in1_min);
@@ -504,10 +545,10 @@
 		}
 		data->fan[0] = lm80_read_value(client, LM80_REG_FAN1);
 		data->fan_min[0] -		    lm80_read_value(client, LM80_REG_FAN1_MIN);
+		    lm80_read_value(client, LM80_REG_FAN_MIN(1));
 		data->fan[1] = lm80_read_value(client, LM80_REG_FAN2);
 		data->fan_min[1] -		    lm80_read_value(client, LM80_REG_FAN2_MIN);
+		    lm80_read_value(client, LM80_REG_FAN_MIN(2));
 
 		data->temp  		    (lm80_read_value(client, LM80_REG_TEMP) << 8) |


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
