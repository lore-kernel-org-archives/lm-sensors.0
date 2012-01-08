From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 18:34:18 +0000
Subject: [lm-sensors] [PATCH 15/17 v2] hwmon: (adm1029) fix checkpatch issues
Message-Id: <1326047660-20539-15-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fixed:
ERROR: space prohibited after that open parenthesis '('
#81: FILE: adm1029.c:81:
+#define DIV_FROM_REG(val)	( 1 << (((val) >> 6) - 1))

WARNING: simple_strtol is obsolete, use kstrtol instead
#203: FILE: adm1029.c:203:
+	long val = simple_strtol(buf, NULL, 10);

ERROR: do not use assignment in if condition
#358: FILE: adm1029.c:358:
+	if ((err = sysfs_create_group(&client->dev.kobj, &adm1029_group)))

total: 2 errors, 1 warnings, 469 lines checked

adm1029.c has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.
Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/adm1029.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 0b8a3b1..47cbd09 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -78,7 +78,7 @@ static const unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
 
 #define TEMP_FROM_REG(val)	((val) * 1000)
 
-#define DIV_FROM_REG(val)	( 1 << (((val) >> 6) - 1))
+#define DIV_FROM_REG(val)	(1 << (((val) >> 6) - 1))
 
 /* Registers to be checked by adm1029_update_device() */
 static const u8 ADM1029_REG_TEMP[] = {
@@ -200,8 +200,11 @@ static ssize_t set_fan_div(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adm1029_data *data = i2c_get_clientdata(client);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	long val = simple_strtol(buf, NULL, 10);
 	u8 reg;
+	long val;
+	int ret = kstrtol(buf, 10, &val);
+	if (ret < 0)
+		return ret;
 
 	mutex_lock(&data->update_lock);
 
@@ -355,7 +357,8 @@ static int adm1029_probe(struct i2c_client *client,
 	}
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &adm1029_group)))
+	err = sysfs_create_group(&client->dev.kobj, &adm1029_group);
+	if (err)
 		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
