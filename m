From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 08 Oct 2010 10:03:54 +0000
Subject: [lm-sensors] [PATCH] hwmon: I2C addresses are constant
Message-Id: <20101008120354.16f27752@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We can mark normal_i2c const. Almost all drivers do that already, so
fix the 3 remaining ones before they are used as (bad) examples for
new drivers.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: George Joseph <george.joseph@fairview5.com>
---
 drivers/hwmon/adt7475.c |    2 +-
 drivers/hwmon/asc7621.c |    4 ++--
 drivers/hwmon/tmp421.c  |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.36-rc7.orig/drivers/hwmon/adt7475.c	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.36-rc7/drivers/hwmon/adt7475.c	2010-10-08 11:55:04.000000000 +0200
@@ -146,7 +146,7 @@
 #define TEMP_OFFSET_REG(idx) (REG_TEMP_OFFSET_BASE + (idx))
 #define TEMP_TRANGE_REG(idx) (REG_TEMP_TRANGE_BASE + (idx))
 
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
 
 enum chips { adt7473, adt7475, adt7476, adt7490 };
 
--- linux-2.6.36-rc7.orig/drivers/hwmon/asc7621.c	2010-09-21 11:07:14.000000000 +0200
+++ linux-2.6.36-rc7/drivers/hwmon/asc7621.c	2010-10-08 11:55:27.000000000 +0200
@@ -28,7 +28,7 @@
 #include <linux/mutex.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = {
+static const unsigned short normal_i2c[] = {
 	0x2c, 0x2d, 0x2e, I2C_CLIENT_END
 };
 
@@ -52,7 +52,7 @@ struct asc7621_chip {
 	u8 company_id;
 	u8 verstep_reg;
 	u8 verstep_id;
-	unsigned short *addresses;
+	const unsigned short *addresses;
 };
 
 static struct asc7621_chip asc7621_chips[] = {
--- linux-2.6.36-rc7.orig/drivers/hwmon/tmp421.c	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.36-rc7/drivers/hwmon/tmp421.c	2010-10-08 11:54:54.000000000 +0200
@@ -36,8 +36,8 @@
 #include <linux/sysfs.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2a, 0x4c, 0x4d, 0x4e, 0x4f,
-				       I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x2a, 0x4c, 0x4d, 0x4e, 0x4f,
+					     I2C_CLIENT_END };
 
 enum chips { tmp421, tmp422, tmp423 };
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
