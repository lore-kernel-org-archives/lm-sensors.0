From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:55 +0000
Subject: [lm-sensors] [PATCH 35/39] w83l785ts: Fix unchecked return status
Message-Id: <11594838712857-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Rudolf Marek <r.marek at assembler.cz>

w83l785ts: Fix unchecked return status

Fix the w83l785ts driver. Add error checking to device_create_file
and also care to destroy the files upon exit.

Signed-off-by: Rudolf Marek <r.marek at assembler.cz>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/w83l785ts.c |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index 3f2bac1..a3fcace 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -236,21 +236,30 @@ static int w83l785ts_detect(struct i2c_a
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
@@ -264,7 +273,10 @@ static int w83l785ts_detach_client(struc
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
1.4.2.1


