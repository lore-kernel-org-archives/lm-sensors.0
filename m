From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 29 Jun 2008 08:19:33 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (asb100) Use generic read during
Message-Id: <20080629101933.4027f6e7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

During the detection step, we are not yet sure whether we're talking
to an ASB100 chip or not. So we should not use asb100_read_value()
and asb100_write_value(). Instead, use the generic read and write
functions: i2c_smbus_read_byte_data() and i2c_smbus_write_byte_data().

On top of being more logical, this change is also needed for upcoming
i2c changes, because asb100_read_value() requires the client data
structure to be already allocated and initialized, which will no
longer be the case during the detection step.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/asb100.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- linux-2.6.26-rc8.orig/drivers/hwmon/asb100.c	2008-06-29 08:54:23.000000000 +0200
+++ linux-2.6.26-rc8/drivers/hwmon/asb100.c	2008-06-29 09:25:33.000000000 +0200
@@ -750,8 +750,8 @@ static int asb100_detect(struct i2c_adap
 	   bank. */
 	if (kind < 0) {
 
-		int val1 = asb100_read_value(client, ASB100_REG_BANK);
-		int val2 = asb100_read_value(client, ASB100_REG_CHIPMAN);
+		int val1 = i2c_smbus_read_byte_data(client, ASB100_REG_BANK);
+		int val2 = i2c_smbus_read_byte_data(client, ASB100_REG_CHIPMAN);
 
 		/* If we're in bank 0 */
 		if ((!(val1 & 0x07)) &&
@@ -769,13 +769,14 @@ static int asb100_detect(struct i2c_adap
 
 	/* We have either had a force parameter, or we have already detected
 	   Winbond. Put it now into bank 0 and Vendor ID High Byte */
-	asb100_write_value(client, ASB100_REG_BANK,
-		(asb100_read_value(client, ASB100_REG_BANK) & 0x78) | 0x80);
+	i2c_smbus_write_byte_data(client, ASB100_REG_BANK,
+		(i2c_smbus_read_byte_data(client, ASB100_REG_BANK) & 0x78)
+		| 0x80);
 
 	/* Determine the chip type. */
 	if (kind <= 0) {
-		int val1 = asb100_read_value(client, ASB100_REG_WCHIPID);
-		int val2 = asb100_read_value(client, ASB100_REG_CHIPMAN);
+		int val1 = i2c_smbus_read_byte_data(client, ASB100_REG_WCHIPID);
+		int val2 = i2c_smbus_read_byte_data(client, ASB100_REG_CHIPMAN);
 
 		if ((val1 = 0x31) && (val2 = 0x06))
 			kind = asb100;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
