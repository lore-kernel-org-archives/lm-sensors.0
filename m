From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:00 +0000
Subject: [lm-sensors] [PATCH 06/82] hwmon: (adm1029) Fix multi-line comments
Message-Id: <1327017376-20466-7-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Corentin Labbe <corentin.labbe@geomatys.fr>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1029.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index d789c33..0c513dc 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -240,9 +240,9 @@ static ssize_t set_fan_div(struct device *dev,
 }
 
 /*
-Access rights on sysfs, S_IRUGO stand for Is Readable by User, Group and Others
-			S_IWUSR stand for Is Writable by User
-*/
+ * Access rights on sysfs. S_IRUGO: Is Readable by User, Group and Others
+ *			   S_IWUSR: Is Writable by User.
+ */
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
@@ -303,7 +303,8 @@ static int adm1029_detect(struct i2c_client *client,
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	/* ADM1029 doesn't have CHIP ID, check just MAN ID
+	/*
+	 * ADM1029 doesn't have CHIP ID, check just MAN ID
 	 * For better detection we check also ADM1029_TEMP_DEVICES_INSTALLED,
 	 * ADM1029_REG_NB_FAN_SUPPORT and compare it with possible values
 	 * documented
@@ -321,8 +322,10 @@ static int adm1029_detect(struct i2c_client *client,
 		return -ENODEV;
 
 	if ((chip_id & 0xF0) != 0x00) {
-		/* There are no "official" CHIP ID, so actually
-		 * we use Major/Minor revision for that */
+		/*
+		 * There are no "official" CHIP ID, so actually
+		 * we use Major/Minor revision for that
+		 */
 		pr_info("adm1029: Unknown major revision %x, "
 			"please let us know\n", chip_id);
 		return -ENODEV;
@@ -407,8 +410,8 @@ static int adm1029_remove(struct i2c_client *client)
 }
 
 /*
-function that update the status of the chips (temperature for example)
-*/
+ * function that update the status of the chips (temperature for example)
+ */
 static struct adm1029_data *adm1029_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -451,8 +454,8 @@ static struct adm1029_data *adm1029_update_device(struct device *dev)
 }
 
 /*
-	Common module stuff
-*/
+ * Common module stuff
+ */
 static int __init sensors_adm1029_init(void)
 {
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
