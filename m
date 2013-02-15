From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 15 Feb 2013 16:57:13 +0000
Subject: [lm-sensors] [PATCH 4/9] hwmon: (adt7410) Use I2C_ADDRS helper macro
Message-Id: <1360947438-2550-4-git-send-email-lars@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

Use the I2C_ADDRS macro to initialize the I2C device's address_list. Doing so
saves a few lines of boilerplate code.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/hwmon/adt7410.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index 4ae16e0..99f6d32 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -78,10 +78,6 @@ enum adt7410_type {		/* keep sorted in alphabetical order */
 	adt7410,
 };
 
-/* Addresses scanned */
-static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
-					I2C_CLIENT_END };
-
 static const u8 ADT7410_REG_TEMP[4] = {
 	ADT7410_TEMPERATURE,		/* input */
 	ADT7410_T_ALARM_HIGH,		/* high */
@@ -453,7 +449,7 @@ static struct i2c_driver adt7410_driver = {
 	.probe		= adt7410_probe,
 	.remove		= adt7410_remove,
 	.id_table	= adt7410_ids,
-	.address_list	= normal_i2c,
+	.address_list	= I2C_ADDRS(0x48, 0x49, 0x4a, 0x4b),
 };
 
 module_i2c_driver(adt7410_driver);
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
