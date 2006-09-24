From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Sep 2006 19:23:26 +0000
Subject: [lm-sensors] [PATCH 19/23] w83l785ts: Fix unchecked return status
Message-Id: <20060924212326.f391f226.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at assembler.cz>
Content-Disposition: inline; filename=hwmon-unchecked-return-status-fixes-w83l785ts.patch

w83l785ts: Fix unchecked return status

Fix the w83l785ts driver. Add error checking to device_create_file
and also care to destroy the files upon exit.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/w83l785ts.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

--- linux-2.6.18.orig/drivers/hwmon/w83l785ts.c	2006-09-21 21:25:05.000000000 +0200
+++ linux-2.6.18/drivers/hwmon/w83l785ts.c	2006-09-23 12:04:17.000000000 +0200
@@ -236,21 +236,30 @@
 	 * Nothing yet, assume it is already started.
 	 */
 
+	err = device_create_file(&new_client->dev,
+				 &sensor_dev_attr_temp1_input.dev_attr);
+	if (err)
+		goto exit_remove;
+
+	err = device_create_file(&new_client->dev,
+				 &sensor_dev_attr_temp1_max.dev_attr);
+	if (err)
+		goto exit_remove;
+
 	/* Register sysfs hooks */
 	data->class_dev = hwmon_device_register(&new_client->dev);
 	if (IS_ERR(data->class_dev)) {
 		err = PTR_ERR(data->class_dev);
-		goto exit_detach;
+		goto exit_remove;
 	}
 
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp1_input.dev_attr);
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp1_max.dev_attr);
-
 	return 0;
 
-exit_detach:
+exit_remove:
+	device_remove_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_input.dev_attr);
+	device_remove_file(&new_client->dev,
+			   &sensor_dev_attr_temp1_max.dev_attr);
 	i2c_detach_client(new_client);
 exit_free:
 	kfree(data);
@@ -264,7 +273,10 @@
 	int err;
 
 	hwmon_device_unregister(data->class_dev);
-
+	device_remove_file(&client->dev,
+			   &sensor_dev_attr_temp1_input.dev_attr);
+	device_remove_file(&client->dev,
+			   &sensor_dev_attr_temp1_max.dev_attr);
 	if ((err = i2c_detach_client(client)))
 		return err;
 

-- 
Jean Delvare

