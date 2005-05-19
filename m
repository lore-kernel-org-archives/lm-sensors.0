From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A common problem for end users is setting the fan clock divider for 
correct operation.  This patch removes fan_div sysfs write accessor 
and implements an automatic fan clock divider selection strategy.

Two states are possible: if the user specifies a valid minimum low 
speed alarm limit that will set an appropriate fan clock divider, 
otherwise the driver will seek to a fan clock divider that gives 
best resolution for current fan speed.

The auto fan clock divider algorithm received extensive testing 
in the adm9240 driver port, this patch is compile tested but needs 
hardware test.

Testing: something like this script can be used to verify operation:

#!/bin/bash
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
		echo "$fan_min" > "$minpath"
		sleep 2
		read fan < $fanpath
		(( fan_min=($fan_min * $step + 50) / 100 ))
		(( fan_min=(($fan_min + 50) / 100) * 100 ))
	done
	fan_min=$upper
	while test $fan_min -gt $lower; do
		echo "$fan_min" > "$minpath"
		sleep 2
		read fan < $fanpath
		(( fan_min=($fan_min * 100 + $step / 2) / $step ))
		(( fan_min=(($fan_min + 50) / 100) * 100 ))
	done
}
test_cycle

Signed-off-by: Grant Coady <gcoady@gmail.com>

---


 lm87.c |  107 ++++++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 60 insertions(+), 47 deletions(-)

--- linux-2.6.12-rc2-mm3/drivers/i2c/chips/lm87.c	2005-04-11 20:54:56.000000000 +1000
+++ linux-2.6.12-rc2-mm3h/drivers/i2c/chips/lm87.c	2005-04-15 23:29:37.000000000 +1000
@@ -405,63 +405,62 @@ static DEVICE_ATTR(fan##offset##_input, 
 show_fan(1);
 show_fan(2);
 
-static void set_fan_min(struct device *dev, const char *buf, int nr)
+/* write new fan_div: callers must hold data->update_lock */
+static void lm87_write_fan_div(struct i2c_client *client, int nr, u8 fan_div)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm87_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	u8 reg, old, shf = (nr + 2) << 1;
 
-	down(&data->update_lock);
-	data->fan_min[nr] = FAN_TO_REG(val,
-			    FAN_DIV_FROM_REG(data->fan_div[nr]));
-	lm87_write_value(client, LM87_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	reg = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
+	old = (reg >> shf) & 3;
+	reg &= ~(3 << shf);
+	reg |= fan_div << shf;
+	lm87_write_value(client, LM87_REG_VID_FAN_DIV, reg);
+	dev_dbg(&client->dev, "autoX fan%u old %u new %u   fan_div changed\n",
+			nr + 1, 1 << old, 1 << fan_div);
 }
 
-/* Note: we save and restore the fan minimum here, because its value is
-   determined in part by the fan clock divider.  This follows the principle
-   of least suprise; the user doesn't expect the fan minimum to change just
-   because the divider changed. */
-static ssize_t set_fan_div(struct device *dev, const char *buf,
-		size_t count, int nr)
+/* automatic fan clock divider selection when user sets fan_min */
+static void set_fan_min(struct device *dev, const char *buf, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
-	unsigned long min;
-	u8 reg;
 
 	down(&data->update_lock);
-	min = FAN_FROM_REG(data->fan_min[nr],
-			   FAN_DIV_FROM_REG(data->fan_div[nr]));
 
-	switch (val) {
-	case 1: data->fan_div[nr] = 0; break;
-	case 2: data->fan_div[nr] = 1; break;
-	case 4: data->fan_div[nr] = 2; break;
-	case 8: data->fan_div[nr] = 3; break;
-	default:
-		up(&data->update_lock);
-		return -EINVAL;
-	}
+	dev_dbg(&client->dev, "auto? fan%u div %u min %3u val %5ld spd %u\n",
+			nr + 1, 1 << data->fan_div[nr],
+			data->fan_min[nr],val,data->fan[nr]);
+
+	if (val <= 1350000 / (8 * 254)) {
+		data->fan_min[nr] = 255; /* too low, disable alarm */
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
 
-	reg = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
-	switch (nr) {
-	case 0:
-	    reg = (reg & 0xCF) | (data->fan_div[0] << 4);
-	    break;
-	case 1:
-	    reg = (reg & 0x3F) | (data->fan_div[1] << 6);
-	    break;
+		data->fan_min[nr] = new_min;
+
+		if (new_div != data->fan_div[nr]) {
+			data->fan_div[nr] = new_div;
+			lm87_write_fan_div(client, nr, new_div);
+		}
 	}
-	lm87_write_value(client, LM87_REG_VID_FAN_DIV, reg);
 
-	data->fan_min[nr] = FAN_TO_REG(min, val);
 	lm87_write_value(client, LM87_REG_FAN_MIN(nr),
 			 data->fan_min[nr]);
 	up(&data->update_lock);
-
-	return count;
 }
 
 #define set_fan(offset) \
@@ -471,15 +470,10 @@ static ssize_t set_fan##offset##_min(str
 	set_fan_min(dev, buf, offset-1); \
 	return count; \
 } \
-static ssize_t set_fan##offset##_div(struct device *dev, const char *buf, \
-		size_t count) \
-{ \
-	return set_fan_div(dev, buf, count, offset-1); \
-} \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
 		show_fan##offset##_min, set_fan##offset##_min); \
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
-		show_fan##offset##_div, set_fan##offset##_div);
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO, \
+		show_fan##offset##_div, NULL);
 set_fan(1);
 set_fan(2);
 
@@ -767,6 +761,25 @@ static struct lm87_data *lm87_update_dev
 			} else {
 				data->fan[i] = lm87_read_value(client,
 					       LM87_REG_FAN(i));
+
+				/* if fan_min off: auto fan clock divider */
+				if (data->fan_min[i] = 255) {
+					int x = 0;
+
+					if (data->fan[i] > 192 &&
+						data->fan_div[i] < 3) {
+						x++;
+					}
+					if (data->fan[i] < 96 &&
+						data->fan_div[i] > 0) {
+						x--;
+					}
+					if (x != 0) {
+						data->fan_div[i] += x;
+						lm87_write_fan_div(client, i,
+							data->fan_div[i]);
+					}
+				}
 				data->fan_min[i] = lm87_read_value(client,
 						   LM87_REG_FAN_MIN(i));
 			}
