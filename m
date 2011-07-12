From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 12 Jul 2011 15:41:32 +0000
Subject: [lm-sensors] [PATCH 07/15] hwmon: (pmbus) Remove page count
Message-Id: <1310485300-2168-8-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some PMBus chips have non-standard sensor registers. An easy way to
support such sensors is to introduce virtual pages and map the non-standard
registers into standard registers on an extra page.

For this to work, the code verifying if the configured number of pages exists
has to be removed. Since a wrong number of pages can only be configured in a
front-end driver, this should not have a practical impact since the resulting
errors should be found during development and testing.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/pmbus_core.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index abdc3a3..85d6136 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1541,18 +1541,6 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		ret = -EINVAL;
 		goto out_data;
 	}
-	/*
-	 * Bail out if more than one page was configured, but we can not
-	 * select the highest page. This is an indication that the wrong
-	 * chip type was selected. Better bail out now than keep
-	 * returning errors later on.
-	 */
-	if (info->pages > 1 && pmbus_set_page(client, info->pages - 1) < 0) {
-		dev_err(&client->dev, "Failed to select page %d\n",
-			info->pages - 1);
-		ret = -EINVAL;
-		goto out_data;
-	}
 
 	ret = pmbus_identify_common(client, data);
 	if (ret < 0) {
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
