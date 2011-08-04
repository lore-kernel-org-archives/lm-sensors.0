From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 04 Aug 2011 18:11:13 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (pmbus/lm25066) Ignore byte writes
Message-Id: <1312481473-28601-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

pmbus_clear_faults() attempts to clear faults on non-existing real pages.
As a result, the command error bit in the status register is set, and faults
are not really cleared.

All byte writes to non-zero pages are requests to clear the status register
on that page. Since non-zero pages are virtual and do not exist on the chip,
there is nothing to do, and such requests have to be ignored. This fixes
above problem.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/lm25066.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index d4bc114..ac254fb 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -161,6 +161,17 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 	return ret;
 }
 
+static int lm25066_write_byte(struct i2c_client *client, int page, u8 value)
+{
+	if (page > 1)
+		return -EINVAL;
+
+	if (page = 0)
+		return pmbus_write_byte(client, 0, value);
+
+	return 0;
+}
+
 static int lm25066_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -204,6 +215,7 @@ static int lm25066_probe(struct i2c_client *client,
 
 	info->read_word_data = lm25066_read_word_data;
 	info->write_word_data = lm25066_write_word_data;
+	info->write_byte = lm25066_write_byte;
 
 	switch (id->driver_data) {
 	case lm25066:
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
