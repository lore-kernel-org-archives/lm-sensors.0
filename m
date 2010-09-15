From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:02:42 +0000
Subject: [lm-sensors] [patch 33/36] hwmon: (w83795) Delay reading limit
Message-Id: <20100915160242.5da97749@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Wait until we need the limit register values, instead of pre-reading
them. This saves 544 ms on modprobe on my test system. Obviously this
time is added when first running "sensors" or any other monitoring
application, but I think it is better than slowing down the boot.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:15:33.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:15:37.000000000 +0200
@@ -371,6 +371,7 @@ struct w83795_data {
 	u8 beeps[6];		/* Register value */
 
 	char valid;
+	char valid_limits;
 };
 
 /*
@@ -498,6 +499,8 @@ static void w83795_update_limits(struct
 	/* Read beep settings */
 	for (i = 0; i < ARRAY_SIZE(data->beeps); i++)
 		data->beeps[i] = w83795_read(client, W83795_REG_BEEP(i));
+
+	data->valid_limits = 1;
 }
 
 static void w83795_update_pwm_config(struct i2c_client *client)
@@ -564,6 +567,9 @@ static struct w83795_data *w83795_update
 
 	mutex_lock(&data->update_lock);
 
+	if (!data->valid_limits)
+		w83795_update_limits(client);
+
 	if (!(time_after(jiffies, data->last_updated + HZ * 2)
 	      || !data->valid))
 		goto END;
@@ -2017,7 +2023,6 @@ static int w83795_probe(struct i2c_clien
 	}
 
 	data->has_gain = w83795_read(client, W83795_REG_VMIGB_CTRL) & 0x0f;
-	w83795_update_limits(client);
 
 	/* pwm and smart fan */
 	if (data->chip_type = w83795g)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
