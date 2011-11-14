From: <Yuantian.Tang@freescale.com>
Date: Mon, 14 Nov 2011 08:45:48 +0000
Subject: [lm-sensors] [PATCH V2] hwmon: (pmbus) Fix two issues
Message-Id: <1321260348-12341-1-git-send-email-Yuantian.Tang@freescale.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Tang Yuantian <B29983@freescale.com>

1. For PMBus device, we should use i2c_smbus_read_i2c_block_data
to read block data.
2. Skip first byte when comparing device id string.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
V2:
	- modified description.
	- modified the issue 2.

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
branch: master
test platform: P1022DS

 drivers/hwmon/pmbus/zl6100.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
index 2bc9800..7bd9e99 100644
--- a/drivers/hwmon/pmbus/zl6100.c
+++ b/drivers/hwmon/pmbus/zl6100.c
@@ -42,6 +42,8 @@ struct zl6100_data {
 
 #define ZL6100_WAIT_TIME		1000	/* uS	*/
 
+#define ZL6100_ID_LEN			16		/* device id length */
+
 static ushort delay = ZL6100_WAIT_TIME;
 module_param(delay, ushort, 0644);
 MODULE_PARM_DESC(delay, "Delay between chip accesses in uS");
@@ -139,16 +141,17 @@ static int zl6100_probe(struct i2c_client *client,
 	int ret;
 	struct zl6100_data *data;
 	struct pmbus_driver_info *info;
-	u8 device_id[I2C_SMBUS_BLOCK_MAX + 1];
+	u8 device_id[ZL6100_ID_LEN + 1];
 	const struct i2c_device_id *mid;
 
 	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_READ_BYTE_DATA
-				     | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA |
+				     I2C_FUNC_SMBUS_READ_I2C_BLOCK))
 		return -ENODEV;
 
-	ret = i2c_smbus_read_block_data(client, ZL6100_DEVICE_ID,
-					device_id);
+	ret = i2c_smbus_read_i2c_block_data(client, ZL6100_DEVICE_ID,
+					ZL6100_ID_LEN, device_id);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to read device ID\n");
 		return ret;
@@ -158,7 +161,7 @@ static int zl6100_probe(struct i2c_client *client,
 
 	mid = NULL;
 	for (mid = zl6100_id; mid->name[0]; mid++) {
-		if (!strncasecmp(mid->name, device_id, strlen(mid->name)))
+		if (!strncasecmp(mid->name, &device_id[1], strlen(mid->name)))
 			break;
 	}
 	if (!mid->name[0]) {
-- 
1.6.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
