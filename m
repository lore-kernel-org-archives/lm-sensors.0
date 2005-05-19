From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH 2.6 sysfs names: fscher: change div to ripple
Message-Id: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

The fcsher and fscpos chips have a 'ripple' prescaler of ripples 
(pulses) per revolution of the fan. 

This small patch changes fscher to match fscpos and is compile tested

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>
---
 fscher.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.12-rc3/drivers/i2c/chips/fscher.c	2005-04-21 19:50:36.000000000 +1000
+++ linux-2.6.12-rc3b/drivers/i2c/chips/fscher.c	2005-04-25 22:34:22.000000000 +1000
@@ -195,7 +195,7 @@
 #define sysfs_fan(offset, reg_status, reg_min, reg_ripple, reg_act) \
 sysfs_rw_n(pwm,        , offset, reg_min) \
 sysfs_rw_n(fan, _status, offset, reg_status) \
-sysfs_rw_n(fan, _div   , offset, reg_ripple) \
+sysfs_rw_n(fan, _ripple   , offset, reg_ripple) \
 sysfs_ro_n(fan, _input , offset, reg_act)
 
 #define sysfs_temp(offset, reg_status, reg_act) \
@@ -243,7 +243,7 @@
 do { \
 	device_create_file(&client->dev, &dev_attr_fan##offset##_status); \
 	device_create_file(&client->dev, &dev_attr_pwm##offset); \
-	device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
+	device_create_file(&client->dev, &dev_attr_fan##offset##_ripple); \
 	device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
 } while (0)
 
@@ -495,7 +495,7 @@
 	return sprintf(buf, "%u\n", data->fan_min[FAN_INDEX_FROM_NUM(nr)]);
 }
 
-static ssize_t set_fan_div(struct i2c_client *client, struct fscher_data *data,
+static ssize_t set_fan_ripple(struct i2c_client *client, struct fscher_data *data,
 			   const char *buf, size_t count, int nr, int reg)
 {
 	/* supported values: 2, 4, 8 */
@@ -506,7 +506,7 @@
 	case 4: v = 2; break;
 	case 8: v = 3; break;
 	default:
-		dev_err(&client->dev, "fan_div value %ld not "
+		dev_err(&client->dev, "fan_ripple value %ld not "
 			 "supported. Choose one of 2, 4 or 8!\n", v);
 		return -EINVAL;
 	}
@@ -522,7 +522,7 @@
 	return count;
 }
 
-static ssize_t show_fan_div(struct fscher_data *data, char *buf, int nr)
+static ssize_t show_fan_ripple(struct fscher_data *data, char *buf, int nr)
 {
 	/* bits 2..7 reserved => mask with 0x03 */  
 	return sprintf(buf, "%u\n", 1 << (data->fan_ripple[FAN_INDEX_FROM_NUM(nr)] & 0x03));
