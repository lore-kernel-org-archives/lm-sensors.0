From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 May 2015 23:14:56 +0000
Subject: [lm-sensors] [PATCH] hwmon: (tmp401) Do not auto-detect chip on I2C address 0x37
Message-Id: <1432768496-14647-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I2C address 0x37 may be used by EEPROMs, which can result in false
positives. Do not attempt to detect a chip at this address.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/tmp401 | 2 +-
 drivers/hwmon/tmp401.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/tmp401 b/Documentation/hwmon/tmp401
index 8eb88e974055..711f75e189eb 100644
--- a/Documentation/hwmon/tmp401
+++ b/Documentation/hwmon/tmp401
@@ -20,7 +20,7 @@ Supported chips:
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp432.html
   * Texas Instruments TMP435
     Prefix: 'tmp435'
-    Addresses scanned: I2C 0x37, 0x48 - 0x4f
+    Addresses scanned: I2C 0x48 - 0x4f
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp435.html
 
 Authors:
diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index 99664ebc738d..ccf4cffe0ee1 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -44,7 +44,7 @@
 #include <linux/sysfs.h>
 
 /* Addresses to scan */
-static const unsigned short normal_i2c[] = { 0x37, 0x48, 0x49, 0x4a, 0x4c, 0x4d,
+static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c, 0x4d,
 	0x4e, 0x4f, I2C_CLIENT_END };
 
 enum chips { tmp401, tmp411, tmp431, tmp432, tmp435 };
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
