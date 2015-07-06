From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 06 Jul 2015 15:54:20 +0000
Subject: [lm-sensors] [PATCH 1/5] hwmon: (adm1275) Use BIT macro
Message-Id: <1436198064-23678-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use BIT macro to simplify adding new bit masks.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/adm1275.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 60aad9570f01..d34ba4f10c30 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
+#include <linux/bitops.h>
 #include "pmbus.h"
 
 enum chips { adm1075, adm1275, adm1276 };
@@ -30,28 +31,28 @@ enum chips { adm1075, adm1275, adm1276 };
 #define ADM1275_PEAK_VOUT		0xd2
 #define ADM1275_PMON_CONFIG		0xd4
 
-#define ADM1275_VIN_VOUT_SELECT		(1 << 6)
-#define ADM1275_VRANGE			(1 << 5)
-#define ADM1075_IRANGE_50		(1 << 4)
-#define ADM1075_IRANGE_25		(1 << 3)
-#define ADM1075_IRANGE_MASK		((1 << 3) | (1 << 4))
+#define ADM1275_VIN_VOUT_SELECT		BIT(6)
+#define ADM1275_VRANGE			BIT(5)
+#define ADM1075_IRANGE_50		BIT(4)
+#define ADM1075_IRANGE_25		BIT(3)
+#define ADM1075_IRANGE_MASK		(BIT(3) | BIT(4))
 
 #define ADM1275_IOUT_WARN2_LIMIT	0xd7
 #define ADM1275_DEVICE_CONFIG		0xd8
 
-#define ADM1275_IOUT_WARN2_SELECT	(1 << 4)
+#define ADM1275_IOUT_WARN2_SELECT	BIT(4)
 
 #define ADM1276_PEAK_PIN		0xda
 
-#define ADM1275_MFR_STATUS_IOUT_WARN2	(1 << 0)
+#define ADM1275_MFR_STATUS_IOUT_WARN2	BIT(0)
 
 #define ADM1075_READ_VAUX		0xdd
 #define ADM1075_VAUX_OV_WARN_LIMIT	0xde
 #define ADM1075_VAUX_UV_WARN_LIMIT	0xdf
 #define ADM1075_VAUX_STATUS		0xf6
 
-#define ADM1075_VAUX_OV_WARN		(1<<7)
-#define ADM1075_VAUX_UV_WARN		(1<<6)
+#define ADM1075_VAUX_OV_WARN		BIT(7)
+#define ADM1075_VAUX_UV_WARN		BIT(6)
 
 struct adm1275_data {
 	int id;
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
