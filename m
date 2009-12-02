From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 15:29:02 +0000
Subject: [lm-sensors] [PATCH 05/11] hwmon: (adt7475) Move sysfs files
Message-Id: <20091202162902.12c31cc9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move sysfs files removal to a separate function. The code is common to
the device probing error path and the standard device removal path. As
it will grow with future driver development, this avoids code
duplication.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 drivers/hwmon/adt7475.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- linux-2.6.32-rc8.orig/drivers/hwmon/adt7475.c	2009-12-02 13:27:55.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/adt7475.c	2009-12-02 13:34:48.000000000 +0100
@@ -1109,6 +1109,14 @@ static int adt7475_detect(struct i2c_cli
 	return 0;
 }
 
+static void adt7475_remove_files(struct i2c_client *client,
+				 struct adt7475_data *data)
+{
+	sysfs_remove_group(&client->dev.kobj, &adt7475_attr_group);
+	if (data->has_voltage & 0x39)
+		sysfs_remove_group(&client->dev.kobj, &adt7490_attr_group);
+}
+
 static int adt7475_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1156,9 +1164,7 @@ static int adt7475_probe(struct i2c_clie
 	return 0;
 
 eremove:
-	sysfs_remove_group(&client->dev.kobj, &adt7475_attr_group);
-	if (data->has_voltage & 0x39)
-		sysfs_remove_group(&client->dev.kobj, &adt7490_attr_group);
+	adt7475_remove_files(client, data);
 efree:
 	kfree(data);
 	return ret;
@@ -1169,9 +1175,7 @@ static int adt7475_remove(struct i2c_cli
 	struct adt7475_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &adt7475_attr_group);
-	if (data->has_voltage & 0x39)
-		sysfs_remove_group(&client->dev.kobj, &adt7490_attr_group);
+	adt7475_remove_files(client, data);
 	kfree(data);
 
 	return 0;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
