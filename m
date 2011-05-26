From: =?UTF-8?B?UGVyIERhbMOpbg==?= <per.dalen@appeartv.com>
Date: Thu, 26 May 2011 13:08:53 +0000
Subject: [lm-sensors] [PATCH v2] MAX6642: Better detection schema
Message-Id: <4DDE50E5.5040902@appeartv.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Changed according to the suggestions from Guenter Roeck:

* Check the manufacturer ID directly. Fastens the test if it's not a
Maxim chip.
* Read the other non-existing registers after the manufacturer ID.

---
Check for non-existing registers, registers 0x04, 0x06 and 0xff, which
are supported by other Maxim chips. Reading such registers returns the
previously read value.

Signed-off-by: Per Dalen <per.dalen@appeartv.com>
---

diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
index 0f9fc40..565b507 100644
--- a/drivers/hwmon/max6642.c
+++ b/drivers/hwmon/max6642.c
@@ -64,6 +64,14 @@ static const unsigned short normal_i2c[] = {
 #define MAX6642_REG_W_REMOTE_HIGH	0x0D

 /*
+ * Registers for detection tests, these registers isn't pressent and
+ * will only show the last valid register read.
+ */
+#define MAX6642_REG_R_DUMMY_1          0x04
+#define MAX6642_REG_R_DUMMY_2          0x06
+#define MAX6642_REG_R_DUMMY_3          0xFF
+
+/*
  * Conversions
  */

@@ -126,7 +134,7 @@ static int max6642_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	u8 reg_config, reg_status, man_id;
+	u8 reg_config, reg_status, man_id, dummy_reg;

 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -136,6 +144,19 @@ static int max6642_detect(struct i2c_client *client,
 	if (man_id != 0x4D)
 		return -ENODEV;

+	/* sanity check */
+	dummy_reg = i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_1);
+	if (dummy_reg != 0x4D)
+		return -ENODEV;
+
+	dummy_reg = i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_2);
+	if (dummy_reg != 0x4D)
+		return -ENODEV;
+
+	dummy_reg = i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_3);
+	if (dummy_reg != 0x4D)
+		return -ENODEV;
+
 	/*
 	 * We read the config and status register, the 4 lower bits in the
 	 * config register should be zero and bit 5, 3, 1 and 0 should be

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
