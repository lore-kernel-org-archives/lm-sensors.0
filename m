From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH 2.6] Setting w83781d fan_div preserves fan_min
Message-Id: <20040314174331.60dd549e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch makes the w83781d driver preserve fan_min settings when the
user changes fan_divs. This isn't done "by default" because the actual
fan min value (in RPMs) depends on both the fan_min register and the
fan_div register. Only two drivers handle it properly at the moment as
far as I know (lm78 and asb100). Several other drivers would need to be
fixed the same way, but well, once at a time ;)

Tested on my AS99127F rev.1.

Credits go to Philip Pokorny, since I think I remember he is the one who
introduced the method in the lm78 driver in the first place.

This tends to increase the size of the three set_store_regs_fan_div
functions, and I am considering refactoring them at some point. Later
though.

Please apply, thanks.

diff -ruN linux-2.6.4+i2c/drivers/i2c/chips.orig/w83781d.c linux-2.6.4+i2c/drivers/i2c/chips/w83781d.c
--- linux-2.6.4+i2c/drivers/i2c/chips.orig/w83781d.c	Sat Mar 13 18:44:30 2004
+++ linux-2.6.4+i2c/drivers/i2c/chips/w83781d.c	Sun Mar 14 14:24:26 2004
@@ -619,12 +619,21 @@
 		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
 }
 
+/* Note: we save and restore the fan minimum here, because its value is
+   determined in part by the fan divisor.  This follows the principle of
+   least suprise; the user doesn't expect the fan minimum to change just
+   because the divisor changed. */
 static ssize_t
 store_regs_fan_div_1(struct device *dev, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	u32 reg;
+	unsigned long min;
+	u8 reg;
+
+	/* Save fan_min */
+	min = FAN_FROM_REG(data->fan_min[0],
+			   DIV_FROM_REG(data->fan_div[0]));
 
 	data->fan_div[0] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
 				      data->type);
@@ -640,6 +649,10 @@
 		w83781d_write_value(client, W83781D_REG_VBAT, reg);
 	}
 
+	/* Restore fan_min */
+	data->fan_min[0] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[0]));
+	w83781d_write_value(client, W83781D_REG_FAN_MIN(1), data->fan_min[0]);
+
 	return count;
 }
 
@@ -648,7 +661,12 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	u32 reg;
+	unsigned long min;
+	u8 reg;
+
+	/* Save fan_min */
+	min = FAN_FROM_REG(data->fan_min[1],
+			   DIV_FROM_REG(data->fan_div[1]));
 
 	data->fan_div[1] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
 				      data->type);
@@ -664,6 +682,10 @@
 		w83781d_write_value(client, W83781D_REG_VBAT, reg);
 	}
 
+	/* Restore fan_min */
+	data->fan_min[1] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[1]));
+	w83781d_write_value(client, W83781D_REG_FAN_MIN(2), data->fan_min[1]);
+
 	return count;
 }
 
@@ -672,7 +694,12 @@
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	u32 reg;
+	unsigned long min;
+	u8 reg;
+
+	/* Save fan_min */
+	min = FAN_FROM_REG(data->fan_min[2],
+			   DIV_FROM_REG(data->fan_div[2]));
 
 	data->fan_div[2] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
 				      data->type);
@@ -687,6 +714,10 @@
 		reg |= (data->fan_div[2] & 0x04) << 5;
 		w83781d_write_value(client, W83781D_REG_VBAT, reg);
 	}
+
+	/* Restore fan_min */
+	data->fan_min[2] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[2]));
+	w83781d_write_value(client, W83781D_REG_FAN_MIN(3), data->fan_min[2]);
 
 	return count;
 }


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
