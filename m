From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: RFC PATCH adm1026: add auto-fan_div
Message-Id: <rgou519s7v8cpfb3rvr7lpk7vhd932mbom@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 14 Apr 2005 21:03:31 -0700, Philip Pokorny <ppokorny@penguincomputing.com> wrote:

>Go ahead and work up the patch for the adm1026.  I'd like to review it, 
>but since it's fresh in your mind, have at it.
>
Here 'tis:

Remove:
	set_fan_div
	unused macros and a function

Changed:
	fan_div stored as 0..3 instead of 1, 2, 4, 8

Added:
	fan_div value set from set_fan_min
	fan_div adjustment in measurement section
	fan_div writer
	debug reports fan_min decision (auto/limit mode) and 
		fan_div changes

Compile tested, unable to perform hardware testing.
This script exercises the thing:

#!/bin/bash
#
# test auto fan clock divider adjustment
#
# Copyright (C) 2005 Grant Coady <gcoady@gmail.com>
#
# GPLv2 per linux/COPYING by reference
#
minpath="/sys/bus/i2c/devices/0-002d/fan1_min"
fanpath="/sys/bus/i2c/devices/0-002d/fan1_input"
read fan < $fanpath
lower00
upper500000
fan_min3
step0
#
function test_cycle ()
{
        fan_min=$lower
        while test $fan_min -lt $upper; do
                ww_adm9240
                echo "$fan_min" > "$minpath"
                sleep 2
                read fan < $fanpath
                (( fan_min=($fan_min * $step + 50) / 100 ))
                (( fan_min=(($fan_min + 50) / 100) * 100 ))
        done
        fan_min=$upper
        while test $fan_min -gt $lower; do
                ww_adm9240
                echo "$fan_min" > "$minpath"
                sleep 2
                read fan < $fanpath
                (( fan_min=($fan_min * 100 + $step / 2) / $step ))
                (( fan_min=(($fan_min + 50) / 100) * 100 ))
        done
}
test_cycle

Needs an Ack from Philip.

Signed-off-by: Grant Coady <gcoady@gmail.com>


# adm1026.c |  150 ++++++++++++++++++++++++++++++++------------------------------
# 1 files changed, 78 insertions(+), 72 deletions(-)
--- linux-2.6.12-rc2-mm3/drivers/i2c/chips/adm1026.c	2005-04-11 20:54:56.000000000 +1000
+++ linux-2.6.12-rc2-mm3i/drivers/i2c/chips/adm1026.c	2005-04-15 15:43:41.000000000 +1000
@@ -132,6 +132,7 @@
 #define ADM1026_REG_FAN_MIN(nr) (0x60 + (nr))
 #define ADM1026_REG_FAN_DIV_0_3 0x02
 #define ADM1026_REG_FAN_DIV_4_7 0x03
+#define ADM1026_REG_FAN_DIV(nr)	(0x02 + (nr))
 
 #define ADM1026_REG_DAC  0x04
 #define ADM1026_REG_PWM  0x05
@@ -200,12 +201,8 @@
  *   and we assume a 2 pulse-per-rev fan tach signal
  *      22500 kHz * 60 (sec/min) * 2 (pulse) / 2 (pulse/rev) = 1350000
  */
-#define FAN_TO_REG(val,div)  ((val)<=0 ? 0xff : SENSORS_LIMIT(1350000/((val)*\
-	(div)),1,254)) 
 #define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=0xff ? 0 : 1350000/((val)*\
 	(div)))
-#define DIV_FROM_REG(val) (1<<(val))
-#define DIV_TO_REG(val) ((val)>=8 ? 3 : (val)>=4 ? 2 : (val)>=2 ? 1 : 0)
 
 /* Temperature is reported in 1 degC increments */
 #define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)+((val)<0 ? -500 : 500))/1000,\
@@ -304,6 +301,8 @@
 static void adm1026_fixup_gpio(struct i2c_client *client); 
 static struct adm1026_data *adm1026_update_device(struct device *dev);
 static void adm1026_init_client(struct i2c_client *client);
+static void adm1026_write_fan_div(struct i2c_client *client,
+		int nr, u8 fan_div);
 
 
 static struct i2c_driver adm1026_driver = {
@@ -452,7 +451,7 @@
 	value = adm1026_read_value(client, ADM1026_REG_FAN_DIV_0_3) |
 		(adm1026_read_value(client, ADM1026_REG_FAN_DIV_4_7) << 8);
 	for (i = 0;i <= 7;++i) {
-		data->fan_div[i] = DIV_FROM_REG(value & 0x03);
+		data->fan_div[i] = value & 0x03;
 		value >>= 2;
 	}
 }
@@ -585,6 +584,26 @@
 		for (i = 0;i <= 7;++i) {
 			data->fan[i]  			    adm1026_read_value(client, ADM1026_REG_FAN(i));
+
+			/* if fan_min off: auto fan clock divider adjust */
+			if (data->fan_min[i] = 255) {
+				int x = 0;
+
+				if (data->fan[i] > 192 &&
+						data->fan_div[i] < 3) {
+					x++;
+				}
+				if (data->fan[i] < 96 &&
+						data->fan_div[i] > 0) {
+					x--;
+				}
+				if (x != 0) {
+					data->fan_div[i] += x;
+					adm1026_write_fan_div(client, i,
+							data->fan_div[i]);
+				}
+			}
+
 		}
 
 		for (i = 0;i <= 2;++i) {
@@ -638,7 +657,7 @@
 		for (i = 0;i <= 7;++i) {
 			data->fan_min[i] = adm1026_read_value(client, 
 				ADM1026_REG_FAN_MIN(i));
-			data->fan_div[i] = DIV_FROM_REG(value & 0x03);
+			data->fan_div[i] = value & 0x03;
 			value >>= 2;
 		}
 
@@ -856,25 +875,53 @@
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr],
-		data->fan_div[nr]));
+		1 << data->fan_div[nr]));
 }
 static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
-		data->fan_div[nr]));
+		1 << data->fan_div[nr]));
 }
 static ssize_t set_fan_min(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1026_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	unsigned long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->fan_min[nr] = FAN_TO_REG(val, data->fan_div[nr]);
-	adm1026_write_value(client, ADM1026_REG_FAN_MIN(nr),
-		data->fan_min[nr]);
+
+	dev_dbg(&client->dev, "auto? fan%u div %u min %3u val %5ld spd %u\n",
+			nr + 1, 1 << data->fan_div[nr],
+			data->fan_min[nr],val,data->fan[nr]);
+
+	if (val <= 1350000 / (8 * 254)) {
+		data->fan_min[nr] = 255; /* too low, disable alarm */
+
+		dev_dbg(&client->dev, "auto! fan%u div %u min %3u too low\n",
+				nr + 1, 1 << data->fan_div[nr],
+				data->fan_min[nr]);
+	} else {
+		/* calculate optimum fan clock divider to suit fan_min */
+		unsigned int new_min = 1350000U / val;
+		u8 new_div = 0;
+
+		while (new_min > 192 && new_div < 3) {
+			new_div++;
+			new_min++;
+			new_min >>= 1;
+		}
+		dev_dbg(&client->dev, "auto- fan%u div %u min %3u\n",
+				nr + 1, 1 << new_div, new_min);
+
+		data->fan_min[nr] = new_min;
+		if (new_div != data->fan_div[nr]) {
+			data->fan_div[nr] = new_div;
+			adm1026_write_fan_div(client, nr, new_div);
+		}
+	}
+
 	up(&data->update_lock);
 	return count;
 }
@@ -906,64 +953,28 @@
 fan_offset(7);
 fan_offset(8);
 
-/* Adjust fan_min to account for new fan divisor */
-static void fixup_fan_min(struct device *dev, int fan, int old_div)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
-	int    new_min;
-	int    new_div = data->fan_div[fan];
-
-	/* 0 and 0xff are special.  Don't adjust them */
-	if (data->fan_min[fan] = 0 || data->fan_min[fan] = 0xff) {
-		return;
-	}
-
-	new_min = data->fan_min[fan] * old_div / new_div;
-	new_min = SENSORS_LIMIT(new_min, 1, 254);
-	data->fan_min[fan] = new_min;
-	adm1026_write_value(client, ADM1026_REG_FAN_MIN(fan), new_min);
+/* write new fan_div, callers must hold data->update_lock */
+static void adm1026_write_fan_div(struct i2c_client *client,
+		int nr, u8 fan_div)
+{
+	u8 reg, old;
+	u8 sel = (nr >> 2) & 1;
+	u8 shf = (nr & 3) * 2;
+
+	reg = adm1026_read_value(client, ADM1026_REG_FAN_DIV(sel));
+	old = (reg >> shf) & 3;
+	reg &= ~(0x03 << shf);
+	reg |= fan_div << shf;
+	adm1026_write_value(client, ADM1026_REG_FAN_DIV(sel), reg);
+	dev_dbg(&client->dev, "autoX fan%u old %u new %u   fan_div changed\n",
+			nr + 1, 1 << old, 1 << fan_div);
 }
 
-/* Now add fan_div read/write functions */
+/* Now add fan_div read function */
 static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
-	return sprintf(buf,"%d\n", data->fan_div[nr]);
-}
-static ssize_t set_fan_div(struct device *dev, const char *buf,
-		size_t count, int nr)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
-	int    val,orig_div,new_div,shift;
-
-	val = simple_strtol(buf, NULL, 10);
-	new_div = DIV_TO_REG(val); 
-	if (new_div = 0) {
-		return -EINVAL;
-	}
-	down(&data->update_lock);
-	orig_div = data->fan_div[nr];
-	data->fan_div[nr] = DIV_FROM_REG(new_div);
-
-	if (nr < 4) { /* 0 <= nr < 4 */
-		shift = 2 * nr;
-		adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
-			((DIV_TO_REG(orig_div) & (~(0x03 << shift))) |
-			(new_div << shift)));
-	} else { /* 3 < nr < 8 */
-		shift = 2 * (nr - 4);
-		adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
-			((DIV_TO_REG(orig_div) & (~(0x03 << (2 * shift)))) |
-			(new_div << shift)));
-	}
-
-	if (data->fan_div[nr] != orig_div) {
-		fixup_fan_min(dev,nr,orig_div);
-	}
-	up(&data->update_lock);
-	return count;
+	return sprintf(buf,"%d\n", 1 << data->fan_div[nr]);
 }
 
 #define fan_offset_div(offset)                                          \
@@ -971,13 +982,8 @@
 {                                                                       \
 	return show_fan_div(dev, buf, offset - 1);                      \
 }                                                                       \
-static ssize_t set_fan_##offset##_div (struct device *dev,              \
-	const char *buf, size_t count)                                  \
-{                                                                       \
-	return set_fan_div(dev, buf, count, offset - 1);                \
-}                                                                       \
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,                \
-		show_fan_##offset##_div, set_fan_##offset##_div);
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO,		                \
+		show_fan_##offset##_div, NULL);
 
 fan_offset_div(1);
 fan_offset_div(2);
