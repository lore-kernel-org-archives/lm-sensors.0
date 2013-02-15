From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 15 Feb 2013 16:57:14 +0000
Subject: [lm-sensors] [PATCH 5/9] hwmon: (adt7410) Add device table entry for the adt7420
Message-Id: <1360947438-2550-5-git-send-email-lars@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

The adt7420 is software compatible to the adt7410.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/hwmon/Kconfig   | 4 ++--
 drivers/hwmon/adt7410.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 52d5174..89ac1cb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -180,11 +180,11 @@ config SENSORS_ADM9240
 	  will be called adm9240.
 
 config SENSORS_ADT7410
-	tristate "Analog Devices ADT7410"
+	tristate "Analog Devices ADT7410/ADT7420"
 	depends on I2C
 	help
 	  If you say yes here you get support for the Analog Devices
-	  ADT7410 temperature monitoring chip.
+	  ADT7410 and ADT7420 temperature monitoring chips.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called adt7410.
diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index 99f6d32..99a7290 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -407,6 +407,7 @@ static int adt7410_remove(struct i2c_client *client)
 
 static const struct i2c_device_id adt7410_ids[] = {
 	{ "adt7410", adt7410, },
+	{ "adt7420", adt7410, },
 	{ /* LIST END */ }
 };
 MODULE_DEVICE_TABLE(i2c, adt7410_ids);
@@ -455,5 +456,5 @@ static struct i2c_driver adt7410_driver = {
 module_i2c_driver(adt7410_driver);
 
 MODULE_AUTHOR("Hartmut Knaack");
-MODULE_DESCRIPTION("ADT7410 driver");
+MODULE_DESCRIPTION("ADT7410/ADT7420 driver");
 MODULE_LICENSE("GPL");
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
