From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:44:16 +0000
Subject: [lm-sensors] [PATCH 1/9] hwmon: checkpatch cleanup: Replace printk with pr_debug or dev_dbg as appro
Message-Id: <1363221864-15284-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Alistair John Strachan <alistair@devzero.co.uk>
Cc: Henrik Rydberg <rydberg@euromail.se>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/abituguru.c  |    2 +-
 drivers/hwmon/abituguru3.c |    2 +-
 drivers/hwmon/applesmc.c   |    2 +-
 drivers/hwmon/f71805f.c    |    3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index 6119ff8..b84f180 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -98,7 +98,7 @@
 #define ABIT_UGURU_NAME				"abituguru"
 #define ABIT_UGURU_DEBUG(level, format, arg...)				\
 	if (level <= verbose)						\
-		printk(KERN_DEBUG ABIT_UGURU_NAME ": "	format , ## arg)
+		pr_debug(format , ## arg)
 /* Macros to help calculate the sysfs_names array length */
 /*
  * sum of strlen of: in??_input\0, in??_{min,max}\0, in??_{min,max}_alarm\0,
diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index 205327d..dcce352 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -78,7 +78,7 @@
 #define ABIT_UGURU3_NAME			"abituguru3"
 #define ABIT_UGURU3_DEBUG(format, arg...)	\
 	if (verbose)				\
-		printk(KERN_DEBUG ABIT_UGURU3_NAME ": "	format , ## arg)
+		pr_debug(format , ## arg)
 
 /* Macros to help calculate the sysfs_names array length */
 #define ABIT_UGURU3_MAX_NO_SENSORS 26
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index b41baff..62c2e32 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -922,7 +922,7 @@ static void applesmc_brightness_set(struct led_classdev *led_cdev,
 	ret = queue_work(applesmc_led_wq, &backlight_work);
 
 	if (debug && (!ret))
-		printk(KERN_DEBUG "applesmc: work was already on the queue.\n");
+		dev_dbg(led_cdev->dev, "work was already on the queue.\n");
 }
 
 static ssize_t applesmc_key_count_show(struct device *dev,
diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index a981697..0c9f3da 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -1350,8 +1350,7 @@ static void f71805f_init_device(struct f71805f_data *data)
 
 	reg = f71805f_read8(data, F71805F_REG_START);
 	if ((reg & 0x41) != 0x01) {
-		printk(KERN_DEBUG DRVNAME ": Starting monitoring "
-		       "operations\n");
+		pr_debug("Starting monitoring operations\n");
 		f71805f_write8(data, F71805F_REG_START, (reg | 0x01) & ~0x40);
 	}
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
