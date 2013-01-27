From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 27 Jan 2013 02:17:43 +0000
Subject: [lm-sensors] [PATCH 09/13] hwmon: (pmbus) Add function to clear sensor cache
Message-Id: <1359253067-11644-10-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

For PMBus chips, modifying one limit register may affect other limits.
Since limits are all cached in the PMBus core driver, related changes
are not reflected in reported limits.

Introduce function to clear the attribute cache. After calling this function,
the core pmbus driver re-reads all cached values.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus.h      |    1 +
 drivers/hwmon/pmbus/pmbus_core.c |    8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 164d177..fa9beb3 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -369,6 +369,7 @@ struct pmbus_driver_info {
 
 /* Function declarations */
 
+void pmbus_clear_cache(struct i2c_client *client);
 int pmbus_set_page(struct i2c_client *client, u8 page);
 int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg);
 int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg, u16 word);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 3b5c24d..32f4530 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -113,6 +113,14 @@ struct pmbus_data {
 	u8 currpage;
 };
 
+void pmbus_clear_cache(struct i2c_client *client)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	data->valid = false;
+}
+EXPORT_SYMBOL_GPL(pmbus_clear_cache);
+
 int pmbus_set_page(struct i2c_client *client, u8 page)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
