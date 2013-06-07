From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 07 Jun 2013 15:51:20 +0000
Subject: [lm-sensors] [PATCH v2 2/2] hwmon: (adm1021) Strengthen chip detection for ADM1021, LM84 and MAX1617
Message-Id: <1370620280-32415-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On a system with both MAX1617 and JC42 sensors, JC42 sensors can be misdetected
as LM84. Strengthen detection sufficiently enough to avoid this misdetection.
Also improve detection for ADM1021.

Modeled after chip detection code in sensors-detect command.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
use defines for register addresses
strengthen detection of ADM1021 as well
explicitly check for register read errors
read and check rlo (remote low limit)
ensure that low limits are not higher than high limits
explain the various checks
use typecast to s8 instead of mask with 0x80 to identify and compare
  negative temperatures

 drivers/hwmon/adm1021.c |   61 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 08f3762..899178d 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -344,21 +344,66 @@ static int adm1021_detect(struct i2c_client *client,
 	else if (man_id = 0x41) {
 		if ((dev_id & 0xF0) = 0x30)
 			type_name = "adm1023";
-		else
+		else if ((dev_id & 0xF0) = 0x00)
 			type_name = "adm1021";
+		else
+			return -ENODEV;
 	} else if (man_id = 0x49)
 		type_name = "thmc10";
 	else if (man_id = 0x23)
 		type_name = "gl523sm";
 	else if (man_id = 0x54)
 		type_name = "mc1066";
-	/* LM84 Mfr ID in a different place, and it has more unused bits */
-	else if (conv_rate = 0x00
-		 && (config & 0x7F) = 0x00
-		 && (status & 0xAB) = 0x00)
-		type_name = "lm84";
-	else
-		type_name = "max1617";
+	else {
+		int lte, rte, lhi, rhi, llo, rlo;
+
+		/* extra checks for LM84 and MAX1617 to avoid misdetections */
+
+		/*
+		 * Both chips don't support man_id and dev_id registers,
+		 * but reads must not fail.
+		 */
+		if (man_id < 0 || dev_id < 0)
+			return -ENODEV;
+
+		lte = i2c_smbus_read_byte_data(client, ADM1021_REG_TEMP(0));
+		rte = i2c_smbus_read_byte_data(client, ADM1021_REG_TEMP(1));
+		lhi = i2c_smbus_read_byte_data(client, ADM1021_REG_TOS_R(0));
+		rhi = i2c_smbus_read_byte_data(client, ADM1021_REG_TOS_R(1));
+		llo = i2c_smbus_read_byte_data(client, ADM1021_REG_THYST_R(0));
+		rlo = i2c_smbus_read_byte_data(client, ADM1021_REG_THYST_R(1));
+
+		/* fail if any of the additional register reads failed */
+		if (llo < 0 || rlo < 0)
+			return -ENODEV;
+
+		/* fail if all registers hold the same value */
+		if (lte = rte && lte = lhi && lte = rhi && lte = llo
+		    && lte = rlo)
+			return -ENODEV;
+
+		/*
+		 * Fail for negative temperatures and negative high limits.
+		 * This check also catches read errors on the tested registers.
+		 */
+		if ((s8)lte < 0 || (s8)rte < 0 || (s8)lhi < 0 || (s8)rhi < 0)
+			return -ENODEV;
+
+		/*
+		 * LM84 Mfr ID is in a different place,
+		 * and it has more unused bits.
+		 */
+		if (conv_rate = 0x00
+		    && (config & 0x7F) = 0x00
+		    && (status & 0xAB) = 0x00) {
+			type_name = "lm84";
+		} else {
+			/* fail if low limits are larger than high limits */
+			if ((s8)llo > lhi || (s8)rlo > rhi)
+				return -ENODEV;
+			type_name = "max1617";
+		}
+	}
 
 	pr_debug("Detected chip %s at adapter %d, address 0x%02x.\n",
 		 type_name, i2c_adapter_id(adapter), client->addr);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
