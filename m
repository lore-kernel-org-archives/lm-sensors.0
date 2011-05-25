From: =?ISO-8859-1?Q?Per_Dal=E9n?= <per.dalen@appeartv.com>
Date: Wed, 25 May 2011 17:48:06 +0000
Subject: [lm-sensors] [PATCH] MAX6642: Better detection schema
Message-Id: <4DDD40D6.8050101@appeartv.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Made the improvement for the detection schema suggested by Guenter Roeck.
---
Check for non-existing registers, registers 0x04, 0x06 and 0xff, which
are supported by other Maxim chips. Reading such registers returns the
previously read value.

Signed-off-by: Per Dalen <per.dalen@appeartv.com>
---

diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
index 0f9fc40..69c7f9e 100644
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

@@ -126,14 +134,16 @@ static int max6642_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	u8 reg_config, reg_status, man_id;
+	u8 reg_config, reg_status, man_id, dummy_reg1, dummy_reg2;

 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;

 	/* identification */
 	man_id = i2c_smbus_read_byte_data(client, MAX6642_REG_R_MAN_ID);
-	if (man_id != 0x4D)
+	dummy_reg1 = i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_1);
+	if ((man_id != 0x4D) &&
+	    (man_id != dummy_reg1))
 		return -ENODEV;

 	/*
@@ -142,9 +152,13 @@ static int max6642_detect(struct i2c_client *client,
 	 * zero in the status register.
 	 */
 	reg_config = i2c_smbus_read_byte_data(client, MAX6642_REG_R_CONFIG);
+	dummy_reg1 = i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_2);
 	reg_status = i2c_smbus_read_byte_data(client, MAX6642_REG_R_STATUS);
-	if (((reg_config & 0x0f) != 0x00) ||
-	    ((reg_status & 0x2b) != 0x00))
+	dummy_reg2 = i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_3);
+	if ((reg_config & 0x0f) != 0x00 ||
+	    (reg_status & 0x2b) != 0x00 ||
+	    reg_config != dummy_reg1 ||
+	    reg_status != dummy_reg2)
 		return -ENODEV;

 	strlcpy(info->type, "max6642", I2C_NAME_SIZE);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
