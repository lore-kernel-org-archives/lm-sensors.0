From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Jul 2011 14:11:04 +0000
Subject: [lm-sensors] [PATCH v2 3/3] hwmon: (lm95241) Add support for LM95231
Message-Id: <1310047864-22691-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LM95231 is fully compatible to LM95241; only necessary change is to add
chip detection.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm95241.c |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
index 4dcc770..1a8b6b5 100644
--- a/drivers/hwmon/lm95241.c
+++ b/drivers/hwmon/lm95241.c
@@ -75,7 +75,8 @@ static const unsigned short normal_i2c[] = {
 #define TT_ON 1
 #define TT_MASK 7
 #define MANUFACTURER_ID 0x01
-#define DEFAULT_REVISION 0xA4
+#define LM95231_CHIP_ID	0xA1
+#define LM95241_CHIP_ID	0xA4
 
 static const u8 lm95241_reg_address[] = {
 	LM95241_REG_R_LOCAL_TEMPH,
@@ -332,22 +333,28 @@ static int lm95241_detect(struct i2c_client *new_client,
 	struct i2c_adapter *adapter = new_client->adapter;
 	int address = new_client->addr;
 	const char *name;
+	int mfg_id, chip_id;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	if ((i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
-	     = MANUFACTURER_ID)
-	    && (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
-		= DEFAULT_REVISION)) {
-		name = DEVNAME;
-	} else {
-		dev_dbg(&adapter->dev, "LM95241 detection failed at 0x%02x\n",
-			address);
+	mfg_id = i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID);
+	if (mfg_id != MANUFACTURER_ID)
+		return -ENODEV;
+	}
+
+	chip_id = i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID);
+	switch (chip_id) {
+	case LM95231_CHIP_ID:
+		name = "lm95231";
+		break;
+	case LM95241_CHIP_ID:
+		name = "lm95241";
+		break;
+	default:
 		return -ENODEV;
 	}
 
-	/* Fill the i2c board info */
 	strlcpy(info->type, name, I2C_NAME_SIZE);
 	return 0;
 }
@@ -423,7 +430,8 @@ static int lm95241_remove(struct i2c_client *client)
 
 /* Driver data (common to all clients) */
 static const struct i2c_device_id lm95241_id[] = {
-	{ DEVNAME, 0 },
+	{ "lm95231", 0 },
+	{ "lm95241", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm95241_id);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
