From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <ee554114ks8v2d7vc84ntceo9eof76hoo9@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,

On Thu, 24 Mar 2005 10:17:37 +0100 (CET), "Jean Delvare" <khali@linux-fr.org> wrote:

>I have a disconnected via686 chip at home, I'll give a try to your patch
>this evening.

okay, here are changes as requested, compile tested :)

Cheers,
Grant.


This patch for via686a driver updates set_fan_div

Added: Reports error when given invalid values for new fan divisor.
Updating fan divisor is skipped when no change to reduce i2c bus traffic.
The fan speed minimum limit is adjusted to suit new divisor so not to 
confuse user.
Driver now holds update_lock during the read, update, write cycle.

Signed-off-by: Grant Coady <gcoady@gmail.com>

--- linux-2.6.12-rc1-mm1/drivers/i2c/chips/via686a.c	2005-03-23 06:34:26.000000000 +1100
+++ linux-2.6.12-rc1-mm1x/drivers/i2c/chips/via686a.c	2005-03-24 21:09:52.000000000 +1100
@@ -297,7 +297,6 @@
 #define ALARMS_FROM_REG(val) (val)
 
 #define DIV_FROM_REG(val) (1 << (val))
-#define DIV_TO_REG(val) ((val)=8?3:(val)=4?2:(val)=1?0:1)
 
 /* For the VIA686A, we need to keep some data in memory.
    The structure is dynamically allocated, at the same time when a new
@@ -506,15 +505,46 @@
 	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr+1), data->fan_min[nr]);
 	return count;
 }
+
+/*
+ * Set fan divisor.  Reports error when invalid divisor value requested.
+ * Skip update when no change in divisor to reduce i2c bus traffic, and
+ * adjust fan_min to match the new divisor providing 'least astonishment'.
+ */
 static ssize_t set_fan_div(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
-	int old = via686a_read_value(client, VIA686A_REG_FANDIV);
-	data->fan_div[nr] = DIV_TO_REG(val);
+	u8 new, old;
+	unsigned long min;
+
+	switch (val) {
+	case 1: new = 0; break;
+	case 2: new = 1; break;
+	case 4: new = 2; break;
+	case 8: new = 3; break;
+	default:
+		dev_err(&client->dev, "fan_div value %d not supported. "
+				"Choose one of 1, 2, 4, or 8!\n", val);
+		return -EINVAL;
+	}
+	if (new = data->fan_div[nr])
+		goto exit;
+	
+	down(&data->update_lock);
+
+	old = via686a_read_value(client, VIA686A_REG_FANDIV);
+	min = FAN_FROM_REG(data->fan_min[nr], 
+					DIV_FROM_REG(data->fan_div[nr]));
+	data->fan_div[nr] = new;
 	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
 	via686a_write_value(client, VIA686A_REG_FANDIV, old);
+	data->fan_min[nr] = FAN_TO_REG(min, DIV_FROM_REG(data->fan_div[nr]));
+	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr + 1),
+					data->fan_min[nr]);
+	up(&data->update_lock);
+exit:
 	return count;
 }
 
