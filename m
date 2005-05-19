From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <l3p341d5p143b56bhpmnpjpuitqpm2l532@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

On Wed, 23 Mar 2005 20:32:26 +0100, Jean Delvare <khali@linux-fr.org> wrote:

>> I'm thinking that there is a very small window between reading 
>> a register, modifying some bits and writing it back out, where 
>> another process also does it.  Say SMP and one CPU update fan_div1
>> while other update fan_div2 -- adm1026 has eight of these over 
>> two bytes to potentially interfere with each other.  
>
>Correct, you convinced me.
>

Okay, appended is via686a as it was the cleanest conversion to new 
set fan_div with the suggested locking.  This patch has twice been 
proposed for comment.  Hopefully a little better each time.  

Next step is to force a delay before driver can reacquire the lock 
to guarantee any particular driver cannot DoS the i2c bus.  Then 
I would feel much more at ease with system operation.

Cheers,
Grant.

This patch updates via686a to report an error when an unsupported 
set fan_div value is requested, the patch also skipd update where 
there is no change and takes the update_lock during the read, 
update, write chips register cycle.

Compile tested.  No hardware for functional test.

Signed-of-by: Grant Coady <gcoady@gmail.com>


--- linux-2.6.12-rc1-mm1/drivers/i2c/chips/via686a.c	2005-03-23 06:34:26.000000000 +1100
+++ linux-2.6.12-rc1-mm1x/drivers/i2c/chips/via686a.c	2005-03-24 08:41:21.000000000 +1100
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
+ * DIV_TO_REG subsumed into this function
+ * Add error reporting for invalid fan divisor input
+ * Skip updating when no change in divisor
+ * Adjust fan_min to match new divisor
+ */
+
 static ssize_t set_fan_div(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	int new, val = simple_strtol(buf, NULL, 10);
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
 	int old = via686a_read_value(client, VIA686A_REG_FANDIV);
-	data->fan_div[nr] = DIV_TO_REG(val);
+	long min = FAN_FROM_REG(data->fan_min[nr], 
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
 
