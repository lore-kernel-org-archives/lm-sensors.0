From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jul 2012 12:57:45 +0000
Subject: [lm-sensors] [PATCH] hwmon: (jc42) Don't reset hysteresis on device removal
Message-Id: <20120726145745.0bc82f8d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Restoring the configuration register on device removal has the side
effect of also resetting the hysteresis value. This is inconsistent as
the other limits are not reset, only hysteresis. So, following the
principle of least surprise, preserve the hysteresis value when
restoring the configuration register.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>
---
Note: this would be more readable if JC42_CFG_HYST_MASK was the mask
_before_ shifting instead of after shifting. Guenter, do you want me
to send a separate patch doing that, or do you like it the way it is?

Alternatively we could invert the logic and only restore the
JC42_CFG_SHUTDOWN bit. As this bit and the two hysteresis bits are the
only ones the driver touches, this is equivalent. I don't know if
there is an intent to ever have the jc42 driver touch any other bit in
the configuration register. Guenter, I am leaving the decision up to
you.

 drivers/hwmon/jc42.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- linux-3.5.orig/drivers/hwmon/jc42.c	2012-07-25 15:33:28.000000000 +0200
+++ linux-3.5/drivers/hwmon/jc42.c	2012-07-26 14:51:32.609121347 +0200
@@ -535,9 +535,18 @@ static int jc42_remove(struct i2c_client
 	struct jc42_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &jc42_group);
-	if (data->config != data->orig_config)
-		i2c_smbus_write_word_swapped(client, JC42_REG_CONFIG,
-					     data->orig_config);
+
+	/* Restore original configuration except hysteresis */
+	if ((data->config & ~(JC42_CFG_HYST_MASK << JC42_CFG_HYST_SHIFT)) !+	    (data->orig_config &
+	     ~(JC42_CFG_HYST_MASK << JC42_CFG_HYST_SHIFT))) {
+		int config = data->orig_config;
+
+		config &= ~(JC42_CFG_HYST_MASK << JC42_CFG_HYST_SHIFT);
+		config |= data->config |
+			  (JC42_CFG_HYST_MASK << JC42_CFG_HYST_SHIFT);
+		i2c_smbus_write_word_swapped(client, JC42_REG_CONFIG, config);
+	}
 	return 0;
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
