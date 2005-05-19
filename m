From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH 2.6] w83781d fan_div code refactoring
Message-Id: <20040317220839.373babf0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> This tends to increase the size of the three set_store_regs_fan_div
> functions, and I am considering refactoring them at some point. Later
> though.

Here is the promised refactoring. Tested on my AS99127F rev.1, seems to
work. As for the previous patch, there is a part that I cannot test with
the AS99127F, so additional testing is welcome.

I agree this makes the code slightly less readable, but this saves 60
lines of code (1754 bytes, around 3% of the driver total), and is
actually far less complex that I first feared.

While testing, I found a corner case that isn't handled properly. It
doesn't seem to be handled by the lm78 and the asb100 either. Setting
fanN_div before ever reading from the chip or setting fanN_min will make
use of fanN_min while it was never initialized.

Mark, can you confirm this behavior with your asb100 driver? Maybe I
missed something...

While a corner case, we better fix it quickly since it is very likely to
happen. We used to set fan divisors before fan mins in sensors.conf
because setting fan divisors was breaking fan mins, and this will
trigger the bug, since we invite users to run "sensors -s" prior to
running "sensors".

This patch doesn't address the issue. I plan to submit a cross-driver
patch later for this instead.

I can think of three ways to solve the issue and would like to hear
opinions about which we should use:

1* In the driver's init function, read fan_mins from the chip so they
are initialized.

2* In the store_fan_div function, call update_device.

3* In the store_fan_div function, if data->valid = 0, read the fan_min
from the chip.

Each method introduces a slowdown at some point. #1 slows the module
loading, #2 slows the first "sensors -s", #3 slows setting fan divisors
(each time). Additionally, #1 and #3 can be said to break the caching
mechanism we implement in each chip driver.

I think I would go for #1, but have no strong preference actually.

Anyway, here's the refactoring patch. Greg, is this acceptable?

Thanks.

--- linux-2.6.5-rc1/drivers/i2c/chips/w83781d.c.orig	Tue Mar 16 21:43:43 2004
+++ linux-2.6.5-rc1/drivers/i2c/chips/w83781d.c	Tue Mar 16 22:34:08 2004
@@ -620,7 +620,7 @@
    least suprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
 static ssize_t
-store_regs_fan_div_1(struct device *dev, const char *buf, size_t count)
+store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83781d_data *data = i2c_get_clientdata(client);
@@ -628,92 +628,28 @@
 	u8 reg;
 
 	/* Save fan_min */
-	min = FAN_FROM_REG(data->fan_min[0],
-			   DIV_FROM_REG(data->fan_div[0]));
+	min = FAN_FROM_REG(data->fan_min[nr],
+			   DIV_FROM_REG(data->fan_div[nr]));
 
-	data->fan_div[0] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
+	data->fan_div[nr] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
 				      data->type);
 
-	reg = w83781d_read_value(client, W83781D_REG_VID_FANDIV) & 0xcf;
-	reg |= (data->fan_div[0] & 0x03) << 4;
-	w83781d_write_value(client, W83781D_REG_VID_FANDIV, reg);
+	reg = (w83781d_read_value(client, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
+	       & (nr=0 ? 0xcf : 0x3f))
+	    | ((data->fan_div[nr] & 0x03) << (nr=0 ? 4 : 6));
+	w83781d_write_value(client, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
 
 	/* w83781d and as99127f don't have extended divisor bits */
 	if (data->type != w83781d && data->type != as99127f) {
-		reg = w83781d_read_value(client, W83781D_REG_VBAT) & 0xdf;
-		reg |= (data->fan_div[0] & 0x04) << 3;
+		reg = (w83781d_read_value(client, W83781D_REG_VBAT)
+		       & ~(1 << (5 + nr)))
+		    | ((data->fan_div[nr] & 0x04) << (3 + nr));
 		w83781d_write_value(client, W83781D_REG_VBAT, reg);
 	}
 
 	/* Restore fan_min */
-	data->fan_min[0] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[0]));
-	w83781d_write_value(client, W83781D_REG_FAN_MIN(1), data->fan_min[0]);
-
-	return count;
-}
-
-static ssize_t
-store_regs_fan_div_2(struct device *dev, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-	unsigned long min;
-	u8 reg;
-
-	/* Save fan_min */
-	min = FAN_FROM_REG(data->fan_min[1],
-			   DIV_FROM_REG(data->fan_div[1]));
-
-	data->fan_div[1] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
-				      data->type);
-
-	reg = w83781d_read_value(client, W83781D_REG_VID_FANDIV) & 0x3f;
-	reg |= (data->fan_div[1] & 0x03) << 6;
-	w83781d_write_value(client, W83781D_REG_VID_FANDIV, reg);
-
-	/* w83781d and as99127f don't have extended divisor bits */
-	if (data->type != w83781d && data->type != as99127f) {
-		reg = w83781d_read_value(client, W83781D_REG_VBAT) & 0xbf;
-		reg |= (data->fan_div[1] & 0x04) << 4;
-		w83781d_write_value(client, W83781D_REG_VBAT, reg);
-	}
-
-	/* Restore fan_min */
-	data->fan_min[1] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[1]));
-	w83781d_write_value(client, W83781D_REG_FAN_MIN(2), data->fan_min[1]);
-
-	return count;
-}
-
-static ssize_t
-store_regs_fan_div_3(struct device *dev, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct w83781d_data *data = i2c_get_clientdata(client);
-	unsigned long min;
-	u8 reg;
-
-	/* Save fan_min */
-	min = FAN_FROM_REG(data->fan_min[2],
-			   DIV_FROM_REG(data->fan_div[2]));
-
-	data->fan_div[2] = DIV_TO_REG(simple_strtoul(buf, NULL, 10),
-				      data->type);
-
-	reg = w83781d_read_value(client, W83781D_REG_PIN) & 0x3f;
-	reg |= (data->fan_div[2] & 0x03) << 6;
-	w83781d_write_value(client, W83781D_REG_PIN, reg);
-
-	/* w83781d and as99127f don't have extended divisor bits */
-	if (data->type != w83781d && data->type != as99127f) {
-		reg = w83781d_read_value(client, W83781D_REG_VBAT) & 0x7f;
-		reg |= (data->fan_div[2] & 0x04) << 5;
-		w83781d_write_value(client, W83781D_REG_VBAT, reg);
-	}
-
-	/* Restore fan_min */
-	data->fan_min[2] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[2]));
-	w83781d_write_value(client, W83781D_REG_FAN_MIN(3), data->fan_min[2]);
+	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
+	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr+1), data->fan_min[nr]);
 
 	return count;
 }
@@ -722,6 +658,10 @@
 static ssize_t show_regs_fan_div_##offset (struct device *dev, char *buf) \
 { \
 	return show_fan_div_reg(dev, buf, offset); \
+} \
+static ssize_t store_regs_fan_div_##offset (struct device *dev, const char *buf, size_t count) \
+{ \
+	return store_fan_div_reg(dev, buf, count, offset - 1); \
 } \
 static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, show_regs_fan_div_##offset, store_regs_fan_div_##offset)
 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
