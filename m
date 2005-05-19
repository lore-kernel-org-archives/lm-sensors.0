From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC PATCH via686a update set_fan_div
Message-Id: <46n64155ipo0sq0tl17ddm7uhnji304c12@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Resend of patch against -mm2, compile tested.


This patch for drivers/i2c/chips/via686a driver updates set_fan_div

Added: Reports error when given invalid values for new fan divisor.
Updating fan divisor is skipped when no change to reduce i2c bus traffic.
The fan speed minimum limit is adjusted to suit new divisor so not to
confuse user.
Driver now holds update_lock during the read, update, write cycle.

Signed-off-by: Grant Coady <gcoady@gmail.com>

--- linux-2.6.12-rc1-mm2/drivers/i2c/chips/via686a.c	2005-03-23 06:34:26.000000000 +1100
+++ linux-2.6.12-rc1-mm2x/drivers/i2c/chips/via686a.c	2005-03-25 10:54:14.000000000 +1100
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
 
