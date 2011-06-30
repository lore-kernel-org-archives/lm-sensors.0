From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 30 Jun 2011 17:29:50 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (pmbus) Drop check for PMBus
Message-Id: <1309454993-8641-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some PMBus devices do not support the PMBus revision register, so don't check
if it exists.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus_core.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pmbus_core.c b/drivers/hwmon/pmbus_core.c
index 354770e..bd613e7 100644
--- a/drivers/hwmon/pmbus_core.c
+++ b/drivers/hwmon/pmbus_core.c
@@ -1430,12 +1430,8 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
-	/*
-	 * Bail out if status register or PMBus revision register
-	 * does not exist.
-	 */
-	if (i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE) < 0
-	    || i2c_smbus_read_byte_data(client, PMBUS_REVISION) < 0) {
+	/* Bail out if PMBus status register does not exist. */
+	if (i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE) < 0) {
 		dev_err(&client->dev,
 			"Status or revision register not found\n");
 		ret = -ENODEV;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
