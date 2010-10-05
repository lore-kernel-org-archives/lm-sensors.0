From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 05 Oct 2010 11:31:03 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (pcf8591) Register as a hwmon device
Message-Id: <20101005133103.772a1d3a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Register PCF8591 devices as hwmon devices. There's little point in
implementing the standard sysfs interface if we don't register it in
a way libsensors will pick it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/hwmon/pcf8591.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- linux-2.6.36-rc6.orig/drivers/hwmon/pcf8591.c	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.36-rc6/drivers/hwmon/pcf8591.c	2010-10-05 13:03:39.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
+#include <linux/hwmon.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
@@ -71,6 +72,7 @@ MODULE_PARM_DESC(input_mode,
 #define REG_TO_SIGNED(reg)	(((reg) & 0x80)?((reg) - 256):(reg))
 
 struct pcf8591_data {
+	struct device *hwmon_dev;
 	struct mutex update_lock;
 
 	u8 control;
@@ -221,6 +223,12 @@ static int pcf8591_probe(struct i2c_clie
 			goto exit_sysfs_remove;
 	}
 
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto exit_sysfs_remove;
+	}
+
 	return 0;
 
 exit_sysfs_remove:
@@ -234,6 +242,9 @@ exit:
 
 static int pcf8591_remove(struct i2c_client *client)
 {
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group_opt);
 	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group);
 	kfree(i2c_get_clientdata(client));


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
