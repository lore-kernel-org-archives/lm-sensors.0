From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 12 May 2014 09:44:51 +0000
Subject: [lm-sensors] [PATCH] hwmon: (emc1403) Fix resource leak on module unload
Message-Id: <20140512114451.3cb890c6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit 454aee17f claims to convert driver emc1403 to use
devm_hwmon_device_register_with_groups, however the patch itself makes
use of hwmon_device_register_with_groups instead. As the driver remove
function was still dropped, the hwmon device is no longer unregistered
on driver removal, leading to a resource leak.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 454aee17f hwmon: (emc1403) Convert to use devm_hwmon_device_register_with_groups
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org [3.13+]
---
 drivers/hwmon/emc1403.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-3.15-rc5.orig/drivers/hwmon/emc1403.c	2014-03-31 05:40:15.000000000 +0200
+++ linux-3.15-rc5/drivers/hwmon/emc1403.c	2014-05-12 10:48:29.300740205 +0200
@@ -355,9 +355,9 @@ static int emc1403_probe(struct i2c_clie
 	if (id->driver_data)
 		data->groups[1] = &emc1404_group;
 
-	hwmon_dev = hwmon_device_register_with_groups(&client->dev,
-						      client->name, data,
-						      data->groups);
+	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
+							   client->name, data,
+							   data->groups);
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
 


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
