From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC PATCH remove DIV_TO_REG in gl518sm.c
Message-Id: <r90v31h9f0fsleb2eld6fgpghpl4aig075@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <st1s31h4ugdd8gq5d6p22mjhson8ahnf9t@4ax.com>
In-Reply-To: <st1s31h4ugdd8gq5d6p22mjhson8ahnf9t@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 21 Mar 2005 10:10:24 +0100 (CET), "Jean Delvare" <khali@linux-fr.org> wrote:
>Look at these two lines:
>
>set_bits(DIV, fan_div1, fan_div[0], GL518_REG_MISC, 0xc0, 6);
>set_bits(DIV, fan_div2, fan_div[1], GL518_REG_MISC, 0x30, 4);
>
Greetings,
Perhaps this is better?
Dunno if I want to play with adjusting fan_min, stuff in there 
I'd rather not fool with today.
Grant.

This patch updates gl518sm to report an error when user-space tries 
to set an invalid fan divsor.  Due to the nature of the source I did 
not attempt to adjust fan_min when fan_div is changed.

Required unrolling two macros, then inserting the update, compile 
tested, no warnings.

Signed-off-by: Grant Coady <gcoady@gmail.com>

--- linux-2.6.12-rc1-mm1/drivers/i2c/chips/gl518sm.c	2005-03-22 11:53:28.000000000 +1100
+++ linux-2.6.12-rc1-mm1x/drivers/i2c/chips/gl518sm.c	2005-03-22 13:12:07.000000000 +1100
@@ -109,7 +109,6 @@
 #define VDD_TO_REG(val)		(SENSORS_LIMIT((((val)*4+47)/95),0,255))
 #define VDD_FROM_REG(val)	(((val)*95+2)/4)
 
-#define DIV_TO_REG(val)		((val)=4?2:(val)=2?1:(val)=1?0:3)
 #define DIV_FROM_REG(val)	(1 << (val))
 
 #define BEEP_MASK_TO_REG(val)	((val) & 0x7f & data->alarm_mask)
@@ -238,8 +237,6 @@
 set(TEMP, temp_max1, temp_max, GL518_REG_TEMP_MAX);
 set(TEMP, temp_hyst1, temp_hyst, GL518_REG_TEMP_HYST);
 set_bits(BOOL, fan_auto1, fan_auto1, GL518_REG_MISC, 0x08, 3);
-set_bits(DIV, fan_div1, fan_div[0], GL518_REG_MISC, 0xc0, 6);
-set_bits(DIV, fan_div2, fan_div[1], GL518_REG_MISC, 0x30, 4);
 set_low(VDD, in_min0, voltage_min[0], GL518_REG_VDD_LIMIT);
 set_low(IN, in_min1, voltage_min[1], GL518_REG_VIN1_LIMIT);
 set_low(IN, in_min2, voltage_min[2], GL518_REG_VIN2_LIMIT);
@@ -251,6 +248,56 @@
 set_bits(BOOL, beep_enable, beep_enable, GL518_REG_CONF, 0x04, 2);
 set(BEEP_MASK, beep_mask, beep_mask, GL518_REG_ALARM);
 
+static ssize_t set_fan_div1(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl518_data *data = i2c_get_clientdata(client);
+	int regvalue = gl518_read_value(client, 0x0f);
+	unsigned long val = simple_strtoul(buf, ((void *)0), 10);
+
+	switch (val) {
+	case 1: val=0; break;
+	case 2: val=1; break;
+	case 4: val=2; break;
+	case 8: val=3; break;
+	default:
+		dev_err(&client->dev, "fan_div value %ld not supported. "
+				"Choose one of 1, 2, 4, or 8!\n", val);
+		return -EINVAL;
+	}
+	data->fan_div[0] = val;
+
+	regvalue = (regvalue & ~0xc0) | (data->fan_div[0] << 6);
+	gl518_write_value(client, 0x0f, regvalue);
+
+	return count;
+}
+
+static ssize_t set_fan_div2(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl518_data *data = i2c_get_clientdata(client);
+	int regvalue = gl518_read_value(client, 0x0f);
+	unsigned long val = simple_strtoul(buf, ((void *)0), 10);
+
+	switch (val) {
+	case 1: val=0; break;
+	case 2: val=1; break;
+	case 4: val=2; break;
+	case 8: val=3; break;
+	default:
+		dev_err(&client->dev, "fan_div value %ld not supported. "
+				"Choose one of 1, 2, 4, or 8!\n", val);
+		return -EINVAL;
+	}
+	data->fan_div[1] = val;
+
+	regvalue = (regvalue & ~0x30) | (data->fan_div[1] << 4);
+	gl518_write_value(client, 0x0f, regvalue);
+
+	return count;
+}
+
 static ssize_t set_fan_min1(struct device *dev, const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
