From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Sep 2009 18:02:46 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm85) Don't bind to Winbond/Nuvoton
Message-Id: <20090912200246.0f7ecb8d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The Winbond/Nuvoton WPCD377I is the reduced version of a Super-I/O
which emulates the National Semiconductor LM96000 hardware monitoring
chips, but without the hardware monitoring part. Instead of plain
disabling the emulation, the vendor left the emulated chip visible,
but all monitored values are always zero. This is rather confusing for
the users. So detect this case and refuse to bind to such fake chips.

This fixes lm-sensors ticket #2182:
http://www.lm-sensors.org/ticket/2182

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- linux-2.6.31.orig/drivers/hwmon/lm85.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.31/drivers/hwmon/lm85.c	2009-09-12 19:34:43.000000000 +0200
@@ -75,6 +75,8 @@ I2C_CLIENT_INSMOD_7(lm85b, lm85c, adm102
 #define	LM85_VERSTEP_GENERIC2		0x70
 #define	LM85_VERSTEP_LM85C		0x60
 #define	LM85_VERSTEP_LM85B		0x62
+#define	LM85_VERSTEP_LM96000_1		0x68
+#define	LM85_VERSTEP_LM96000_2		0x69
 #define	LM85_VERSTEP_ADM1027		0x60
 #define	LM85_VERSTEP_ADT7463		0x62
 #define	LM85_VERSTEP_ADT7463C		0x6A
@@ -1133,6 +1135,26 @@ static void lm85_init_client(struct i2c_
 		dev_warn(&client->dev, "Device is not ready\n");
 }
 
+static int lm85_is_fake(struct i2c_client *client)
+{
+	/*
+	 * Differenciate between real LM96000 and Winbond WPCD377I. The latter
+	 * emulate the former except that it has no hardware monitoring function
+	 * so the readings are always 0.
+	 */
+	int i;
+	u8 in_temp, fan;
+
+	for (i = 0; i < 8; i++) {
+		in_temp = i2c_smbus_read_byte_data(client, 0x20 + i);
+		fan = i2c_smbus_read_byte_data(client, 0x28 + i);
+		if (in_temp != 0x00 || fan != 0xff)
+			return 0;
+	}
+
+	return 1;
+}
+
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int lm85_detect(struct i2c_client *client, int kind,
 		       struct i2c_board_info *info)
@@ -1173,6 +1195,16 @@ static int lm85_detect(struct i2c_client
 			case LM85_VERSTEP_LM85B:
 				kind = lm85b;
 				break;
+			case LM85_VERSTEP_LM96000_1:
+			case LM85_VERSTEP_LM96000_2:
+				/* Check for Winbond WPCD377I */
+				if (lm85_is_fake(client)) {
+					dev_dbg(&adapter->dev,
+						"Found Winbond WPCD377I, "
+						"ignoring\n");
+					return -ENODEV;
+				}
+				break;
 			}
 		} else if (company = LM85_COMPANY_ANALOG_DEV) {
 			switch (verstep) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
