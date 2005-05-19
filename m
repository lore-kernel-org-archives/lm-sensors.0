From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <cea361lpcdgb1virtkmk24f66hoovkaiod@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
In-Reply-To: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Sat, 16 Apr 2005 03:36:44 +1000, Grant Coady <grant_lkml@dodo.com.au> wrote:

Here is round two, modified for most of your comments.

Re: set_fan_min, it may be all I've done is needlessly shift the 
decision point, so I changed it to match your algo.

I fully agree on the reporting messages, they were geared to my 
testing.

Changed the fan measurement logic to remove use of local variable.

I'm less happy about changing the fan clock divider in low speed 
limit alarm mode,  I'll need to try it out on adm9240 driver before 
changing algorithm elsewhere.

Compile tested.

Signed-off-by: Grant Coady <gcoady@gmail.com>


# lm87.c |  116 +++++++++++++++++++++++++++++++++++++----------------------------
# 1 files changed, 67 insertions(+), 49 deletions(-)

--- linux-2.6.12-rc2-mm3/drivers/i2c/chips/lm87.c	2005-04-11 20:54:56.000000000 +1000
+++ linux-2.6.12-rc2-mm3h/drivers/i2c/chips/lm87.c	2005-04-17 10:05:04.000000000 +1000
@@ -405,63 +405,68 @@ static DEVICE_ATTR(fan##offset##_input, 
 show_fan(1);
 show_fan(2);
 
-static void set_fan_min(struct device *dev, const char *buf, int nr)
+/* write new fan_div: callers must hold data->update_lock */
+static void lm87_write_fan_div(struct i2c_client *client, int nr, u8 fan_div)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm87_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	u8 reg, old;
+	u8 shift = (nr + 2) << 1; /* nr 0,1 -> 4,6 bit shift count */
 
-	down(&data->update_lock);
-	data->fan_min[nr] = FAN_TO_REG(val,
-			    FAN_DIV_FROM_REG(data->fan_div[nr]));
-	lm87_write_value(client, LM87_REG_FAN_MIN(nr), data->fan_min[nr]);
-	up(&data->update_lock);
+	reg = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
+	old = (reg >> shift) & 3;
+	reg &= ~(3 << shift);
+	reg |= fan_div << shift;
+	lm87_write_value(client, LM87_REG_VID_FAN_DIV, reg);
+	dev_dbg(&client->dev, "fan%d clock divider changed from %u to %u\n",
+					nr + 1, 1 << old, 1 << fan_div);
 }
 
-/* Note: we save and restore the fan minimum here, because its value is
-   determined in part by the fan clock divider.  This follows the principle
-   of least suprise; the user doesn't expect the fan minimum to change just
-   because the divider changed. */
-static ssize_t set_fan_div(struct device *dev, const char *buf,
-		size_t count, int nr)
+/* set fan low speed limit
+ * 
+ * # if user selects a valid fan low speed limit the driver enables low
+ *   fan speed limit alarm and selects a fan clock divider to suit the 
+ *   low speed limit point
+ *
+ * # if user selects a value too low to measure, disable fan low speed 
+ *   limit alarm mode, this will also enable automatic fan clock divider
+ *   adjustment in the fan speed measurement code */
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
-
-	switch (val) {
-	case 1: data->fan_div[nr] = 0; break;
-	case 2: data->fan_div[nr] = 1; break;
-	case 4: data->fan_div[nr] = 2; break;
-	case 8: data->fan_div[nr] = 3; break;
-	default:
-		up(&data->update_lock);
-		return -EINVAL;
-	}
 
-	reg = lm87_read_value(client, LM87_REG_VID_FAN_DIV);
-	switch (nr) {
-	case 0:
-	    reg = (reg & 0xCF) | (data->fan_div[0] << 4);
-	    break;
-	case 1:
-	    reg = (reg & 0x3F) | (data->fan_div[1] << 6);
-	    break;
+	if (val < 1350000U / (8 * 254)) {
+		if (data->fan_min[nr] < 255) { /* only report on change */
+			data->fan_min[nr] = 255;
+			dev_dbg(&client->dev, "fan%d low speed limit disabled\n",
+					nr + 1);
+		}
+	} else {
+		/* calculate optimum fan clock divider to suit new fan_min */
+		unsigned int new_min = 1350000U / val;
+		u8 new_div = 0;
+
+		while (new_min > 192 && new_div < 3) {
+			new_div++;
+			new_min >>= 1;
+		}
+		
+		if (data->fan_min[nr] = 255) { /* only report on change */
+			dev_dbg(&client->dev, "fan%d low speed limit enabled\n",
+					 nr + 1);
+		}
+		data->fan_min[nr] = new_min;
+		
+		if (data->fan_div[nr] != new_div) {
+			data->fan_div[nr] = new_div;
+			lm87_write_fan_div(client, nr, new_div);
+		}
 	}
-	lm87_write_value(client, LM87_REG_VID_FAN_DIV, reg);
-
-	data->fan_min[nr] = FAN_TO_REG(min, val);
 	lm87_write_value(client, LM87_REG_FAN_MIN(nr),
 			 data->fan_min[nr]);
 	up(&data->update_lock);
-
-	return count;
 }
 
 #define set_fan(offset) \
@@ -471,15 +476,10 @@ static ssize_t set_fan##offset##_min(str
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
 
@@ -767,6 +767,24 @@ static struct lm87_data *lm87_update_dev
 			} else {
 				data->fan[i] = lm87_read_value(client,
 					       LM87_REG_FAN(i));
+
+				/* adjust fan clock divider for best fan 
+				 * speed measurement resolution while
+				 * low fan speed limit alarm disabled */
+				if (data->fan_min[i] = 255) {
+					if (data->fan[i] > 192 &&
+						data->fan_div[i] < 3) {
+						data->fan_div[i]++;
+						lm87_write_fan_div(client, i,
+							data->fan_div[i]);
+					}
+					if (data->fan[i] < 96 &&
+						data->fan_div[i] > 0) {
+						data->fan_div[i]--;
+						lm87_write_fan_div(client, i,
+							data->fan_div[i]);
+					}
+				}
 				data->fan_min[i] = lm87_read_value(client,
 						   LM87_REG_FAN_MIN(i));
 			}
