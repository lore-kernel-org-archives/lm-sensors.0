From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 05 Jun 2013 21:33:16 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1021) Strengthen chip detection for LM84 and MAX1617
Message-Id: <1370467996-27091-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On a system with both MAX1617A and JC42 sensors, JC42 sensors can be misdetected
as LM84. Strengthen detection sufficiently enough to avoid this misdetection at
least in some cases. Code follows example in sensors-detect script.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Still pretty weak detection. Any suggestions for improvements are welcome.

 drivers/hwmon/adm1021.c |   36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 7e76922..8b342b8 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -344,13 +344,35 @@ static int adm1021_detect(struct i2c_client *client,
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
+		int lte, rte, lhi, rhi, llo;
+
+		/* extra checks for LM84 and MAX1617 to avoid misdetections */
+
+		lte = i2c_smbus_read_byte_data(client, 0x00);
+		rte = i2c_smbus_read_byte_data(client, 0x01);
+		lhi = i2c_smbus_read_byte_data(client, 0x05);
+		rhi = i2c_smbus_read_byte_data(client, 0x07);
+		llo = i2c_smbus_read_byte_data(client, 0x06);
+
+		if (lte = rte && lte = lhi && lte = rhi && lte = llo)
+			return -ENODEV;
+		if ((lte & 0x80) || (rte & 0x80) || (lhi & 0x80)
+		    || (rhi & 0x80))
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
