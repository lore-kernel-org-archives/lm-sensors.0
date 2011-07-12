From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 12 Jul 2011 15:41:31 +0000
Subject: [lm-sensors] [PATCH 06/15] hwmon: (pmbus) Support reading and
Message-Id: <1310485300-2168-7-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some PMBus devices use non-standard registers for some of the sensors and/or
limits. To support such devices, add code to support reading and writing of word
size registers in device specific code.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/pmbus.h      |    4 +++
 drivers/hwmon/pmbus/pmbus_core.c |   50 ++++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index cc5b6a2..d631cae 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -286,6 +286,9 @@ struct pmbus_driver_info {
 	 * necessary.
 	 */
 	int (*read_byte_data)(struct i2c_client *client, int page, int reg);
+	int (*read_word_data)(struct i2c_client *client, int page, int reg);
+	int (*write_word_data)(struct i2c_client *client, int page, int reg,
+			       u16 word);
 	/*
 	 * The identify function determines supported PMBus functionality.
 	 * This function is only necessary if a chip driver supports multiple
@@ -299,6 +302,7 @@ struct pmbus_driver_info {
 
 int pmbus_set_page(struct i2c_client *client, u8 page);
 int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg);
+int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg, u16 word);
 int pmbus_read_byte_data(struct i2c_client *client, u8 page, u8 reg);
 void pmbus_clear_faults(struct i2c_client *client);
 bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 8ff7ebf..abdc3a3 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -175,8 +175,7 @@ static int pmbus_write_byte(struct i2c_client *client, u8 page, u8 value)
 	return i2c_smbus_write_byte(client, value);
 }
 
-static int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg,
-				 u16 word)
+int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg, u16 word)
 {
 	int rv;
 
@@ -186,6 +185,28 @@ static int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg,
 
 	return i2c_smbus_write_word_data(client, reg, word);
 }
+EXPORT_SYMBOL_GPL(pmbus_write_word_data);
+
+/*
+ * _pmbus_write_word_data() is similar to pmbus_write_word_data(), but checks if
+ * a device specific mapping funcion exists and calls it if necessary.
+ */
+static int _pmbus_write_word_data(struct i2c_client *client, int page, int reg,
+				  u16 word)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	const struct pmbus_driver_info *info = data->info;
+	int status;
+
+	if (info->write_word_data) {
+		status = info->write_word_data(client, page, reg, word);
+		if (status != -ENODATA)
+			return status;
+	}
+	if (reg >= PMBUS_VIRT_BASE)
+		return -EINVAL;
+	return pmbus_write_word_data(client, page, reg, word);
+}
 
 int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg)
 {
@@ -199,6 +220,24 @@ int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg)
 }
 EXPORT_SYMBOL_GPL(pmbus_read_word_data);
 
+/*
+ * _pmbus_read_word_data() is similar to pmbus_read_word_data(), but checks if
+ * a device specific mapping funcion exists and calls it if necessary.
+ */
+static int _pmbus_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	const struct pmbus_driver_info *info = data->info;
+	int status;
+
+	if (info->read_word_data) {
+		status = info->read_word_data(client, page, reg);
+		if (status != -ENODATA)
+			return status;
+	}
+	return pmbus_read_word_data(client, page, reg);
+}
+
 int pmbus_read_byte_data(struct i2c_client *client, u8 page, u8 reg)
 {
 	int rv;
@@ -350,8 +389,9 @@ static struct pmbus_data *pmbus_update_device(struct device *dev)
 
 			if (!data->valid || sensor->update)
 				sensor->data
-				    = pmbus_read_word_data(client, sensor->page,
-							   sensor->reg);
+				    = _pmbus_read_word_data(client,
+							    sensor->page,
+							    sensor->reg);
 		}
 		pmbus_clear_faults(client);
 		data->last_updated = jiffies;
@@ -722,7 +762,7 @@ static ssize_t pmbus_set_sensor(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	regval = pmbus_data2reg(data, sensor->class, val);
-	ret = pmbus_write_word_data(client, sensor->page, sensor->reg, regval);
+	ret = _pmbus_write_word_data(client, sensor->page, sensor->reg, regval);
 	if (ret < 0)
 		rv = ret;
 	else
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
