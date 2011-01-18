From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 18 Jan 2011 17:54:12 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (lm93) Add support for LM94
Message-Id: <1295375190-3477-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds basic support for LM94 to the LM93 driver. LM94 specific
sensors and features are not supported.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: Add additional MFR_ID value 0x7a for LM94

 Documentation/hwmon/lm93 |    7 +++++++
 drivers/hwmon/lm93.c     |   21 +++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/lm93 b/Documentation/hwmon/lm93
index 7a10616..f3b2ad2 100644
--- a/Documentation/hwmon/lm93
+++ b/Documentation/hwmon/lm93
@@ -6,6 +6,10 @@ Supported chips:
     Prefix 'lm93'
     Addresses scanned: I2C 0x2c-0x2e
     Datasheet: http://www.national.com/ds.cgi/LM/LM93.pdf
+  * National Semiconductor LM94
+    Prefix 'lm94'
+    Addresses scanned: I2C 0x2c-0x2e
+    Datasheet: http://www.national.com/ds.cgi/LM/LM94.pdf
 
 Authors:
 	Mark M. Hoffman <mhoffman@lightlink.com>
@@ -56,6 +60,9 @@ previous motherboard management ASICs and uses some of the LM85's features
 for dynamic Vccp monitoring and PROCHOT. It is designed to monitor a dual
 processor Xeon class motherboard with a minimum of external components.
 
+LM94 is also supported in LM93 compatible mode. Extra sensors and features of
+LM94 are not supported.
+
 
 User Interface
 --------------
diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index c9ed14e..f8c5b13 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -135,6 +135,11 @@
 #define LM93_MFR_ID		0x73
 #define LM93_MFR_ID_PROTOTYPE	0x72
 
+/* LM94 REGISTER VALUES */
+#define LM94_MFR_ID_2		0x7a
+#define LM94_MFR_ID		0x79
+#define LM94_MFR_ID_PROTOTYPE	0x78
+
 /* SMBus capabilities */
 #define LM93_SMBUS_FUNC_FULL (I2C_FUNC_SMBUS_BYTE_DATA | \
 		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BLOCK_DATA)
@@ -2504,6 +2509,7 @@ static int lm93_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	int mfr, ver;
+	const char *name;
 
 	if (!i2c_check_functionality(adapter, LM93_SMBUS_FUNC_MIN))
 		return -ENODEV;
@@ -2517,13 +2523,23 @@ static int lm93_detect(struct i2c_client *client, struct i2c_board_info *info)
 	}
 
 	ver = lm93_read_byte(client, LM93_REG_VER);
-	if (ver != LM93_MFR_ID && ver != LM93_MFR_ID_PROTOTYPE) {
+	switch (ver) {
+	case LM93_MFR_ID:
+	case LM93_MFR_ID_PROTOTYPE:
+		name = "lm93";
+		break;
+	case LM94_MFR_ID_2:
+	case LM94_MFR_ID:
+	case LM94_MFR_ID_PROTOTYPE:
+		name = "lm94";
+		break;
+	default:
 		dev_dbg(&adapter->dev,
 			"detect failed, bad version id 0x%02x!\n", ver);
 		return -ENODEV;
 	}
 
-	strlcpy(info->type, "lm93", I2C_NAME_SIZE);
+	strlcpy(info->type, name, I2C_NAME_SIZE);
 	dev_dbg(&adapter->dev,"loading %s at %d,0x%02x\n",
 		client->name, i2c_adapter_id(client->adapter),
 		client->addr);
@@ -2602,6 +2618,7 @@ static int lm93_remove(struct i2c_client *client)
 
 static const struct i2c_device_id lm93_id[] = {
 	{ "lm93", 0 },
+	{ "lm94", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm93_id);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
