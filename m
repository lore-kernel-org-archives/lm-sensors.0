From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Apr 2011 12:17:13 +0000
Subject: [lm-sensors] [PATCH] hwmon: (jc42) Change I2C detection class
Message-Id: <20110416141713.333d6e51@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

While the JC42-compatible chips are temperature sensors, I2C_CLASS_SPD
makes more sense because these chips always live on memory modules.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>
---
Guenter, what do you think?

 drivers/hwmon/jc42.c |    2 +-
 include/linux/i2c.h  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.39-rc3.orig/drivers/hwmon/jc42.c	2011-03-15 22:52:51.000000000 +0100
+++ linux-2.6.39-rc3/drivers/hwmon/jc42.c	2011-04-16 09:31:47.000000000 +0200
@@ -213,7 +213,7 @@ static const struct dev_pm_ops jc42_dev_
 
 /* This is the driver that will be inserted */
 static struct i2c_driver jc42_driver = {
-	.class		= I2C_CLASS_HWMON,
+	.class		= I2C_CLASS_SPD,
 	.driver = {
 		.name	= "jc42",
 		.pm = JC42_DEV_PM_OPS,
--- linux-2.6.39-rc3.orig/include/linux/i2c.h	2011-04-15 18:08:30.000000000 +0200
+++ linux-2.6.39-rc3/include/linux/i2c.h	2011-04-16 09:48:50.000000000 +0200
@@ -400,7 +400,7 @@ void i2c_unlock_adapter(struct i2c_adapt
 /* i2c adapter classes (bitmask) */
 #define I2C_CLASS_HWMON		(1<<0)	/* lm_sensors, ... */
 #define I2C_CLASS_DDC		(1<<3)	/* DDC bus on graphics adapters */
-#define I2C_CLASS_SPD		(1<<7)	/* SPD EEPROMs and similar */
+#define I2C_CLASS_SPD		(1<<7)	/* Memory modules */
 
 /* Internal numbers to terminate lists */
 #define I2C_CLIENT_END		0xfffeU


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
