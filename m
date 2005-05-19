From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: RFC PATCH update via686a DIV_TO_REG to return error
Message-Id: <djas31ljne3adsttsb6819i1ijeut47js2@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Old behaviour: accept fan_div - 1, 2, 4 or 8; default 2

This changes DIV_TO_REG to instead report an error when user-space 
try set invalid fan divisor.

Patch compile tested, few times as I created a warning that 
needed stomping.

Queries
I'm demonstrating a method to keep scaling / valid numbers up near 
top of source with similar stuff.  Not sure if it needed or wanted?

Adjust fan limits required?

Cheers,
Grant.

--- linux-2.6.11-mm4/drivers/i2c/chips/via686a.c	2005-03-17 07:56:48.000000000 +1100
+++ linux-2.6.11-mm4x/drivers/i2c/chips/via686a.c	2005-03-21 12:54:07.000000000 +1100
@@ -297,7 +297,18 @@
 #define ALARMS_FROM_REG(val) (val)
 
 #define DIV_FROM_REG(val) (1 << (val))
-#define DIV_TO_REG(val) ((val)=8?3:(val)=4?2:(val)=1?0:1)
+
+static inline int DIV_TO_REG(long v)
+{
+	switch (v) {
+	case 1: return 0;
+	case 2: return 1;
+	case 4: return 2;
+	case 8: return 3;
+	default: return -1;
+	}
+}
+#define DIV_VALID_NR		"1, 2, 4, or 8"
 
 /* For the VIA686A, we need to keep some data in memory.
    The structure is dynamically allocated, at the same time when a new
@@ -510,9 +521,15 @@
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	int val = simple_strtol(buf, NULL, 10);
+	int tmp, val = simple_strtol(buf, NULL, 10);
+
+	if ((tmp = DIV_TO_REG(val)) < 0) {
+		dev_err(&client->dev, "fan_div value %d not supported. "
+				"Choose one of " DIV_VALID_NR "!\n", val);
+		 return -EINVAL;
+	}
 	int old = via686a_read_value(client, VIA686A_REG_FANDIV);
-	data->fan_div[nr] = DIV_TO_REG(val);
+	data->fan_div[nr] = tmp;
 	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
 	via686a_write_value(client, VIA686A_REG_FANDIV, old);
 	return count;
