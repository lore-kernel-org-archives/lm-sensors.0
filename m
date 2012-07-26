From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jul 2012 20:18:43 +0000
Subject: [lm-sensors] [PATCH 2/2 v2] hwmon: (jc42) Don't reset hysteresis on device removal
Message-Id: <20120726221843.38f3aaf2@endymion.delvare>
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
Changes since v1:
* Fix |-for-& thinko.
* Use the new definition of JC42_CFG_HYST_MASK, makes the code more
  readable.

 drivers/hwmon/jc42.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- linux-3.5.orig/drivers/hwmon/jc42.c	2012-07-26 22:04:46.911073234 +0200
+++ linux-3.5/drivers/hwmon/jc42.c	2012-07-26 22:11:44.918891533 +0200
@@ -534,9 +534,16 @@ static int jc42_remove(struct i2c_client
 	struct jc42_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &jc42_group);
-	if (data->config != data->orig_config)
-		i2c_smbus_write_word_swapped(client, JC42_REG_CONFIG,
-					     data->orig_config);
+
+	/* Restore original configuration except hysteresis */
+	if ((data->config & ~JC42_CFG_HYST_MASK) !+	    (data->orig_config & ~JC42_CFG_HYST_MASK)) {
+		int config;
+
+		config = (data->orig_config & ~JC42_CFG_HYST_MASK)
+		  | (data->config & JC42_CFG_HYST_MASK);
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
