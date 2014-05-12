From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 19:01:44 +0000
Subject: [lm-sensors] [PATCH 2/9] hwmon: (emc1403) Convert to use regmap
Message-Id: <1399921311-9524-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to regmap to be able to use its register caching mechanism.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc1403.c | 115 ++++++++++++++++++++++++++----------------------
 1 file changed, 62 insertions(+), 53 deletions(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 0bb0bab..613bc49 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -18,9 +18,6 @@
  * with this program; if not, write to the Free Software Foundation, Inc.,
  * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- * TODO
- *	-	cache alarm and critical limit registers
  */
 
 #include <linux/module.h>
@@ -32,7 +29,7 @@
 #include <linux/err.h>
 #include <linux/sysfs.h>
 #include <linux/mutex.h>
-#include <linux/jiffies.h>
+#include <linux/regmap.h>
 
 #define THERMAL_PID_REG		0xfd
 #define THERMAL_SMSC_ID_REG	0xfe
@@ -41,15 +38,9 @@
 enum emc1403_chip { emc1402, emc1403, emc1404 };
 
 struct thermal_data {
-	struct i2c_client *client;
-	const struct attribute_group *groups[4];
+	struct regmap *regmap;
 	struct mutex mutex;
-	/*
-	 * Cache the hyst value so we don't keep re-reading it. In theory
-	 * we could cache it forever as nobody else should be writing it.
-	 */
-	u8 cached_hyst;
-	unsigned long hyst_valid;
+	const struct attribute_group *groups[4];
 };
 
 static ssize_t show_temp(struct device *dev,
@@ -57,12 +48,13 @@ static ssize_t show_temp(struct device *dev,
 {
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
 	struct thermal_data *data = dev_get_drvdata(dev);
+	unsigned int val;
 	int retval;
 
-	retval = i2c_smbus_read_byte_data(data->client, sda->index);
+	retval = regmap_read(data->regmap, sda->index, &val);
 	if (retval < 0)
 		return retval;
-	return sprintf(buf, "%d000\n", retval);
+	return sprintf(buf, "%d000\n", val);
 }
 
 static ssize_t show_bit(struct device *dev,
@@ -70,9 +62,10 @@ static ssize_t show_bit(struct device *dev,
 {
 	struct sensor_device_attribute_2 *sda = to_sensor_dev_attr_2(attr);
 	struct thermal_data *data = dev_get_drvdata(dev);
+	unsigned int val;
 	int retval;
 
-	retval = i2c_smbus_read_byte_data(data->client, sda->nr);
+	retval = regmap_read(data->regmap, sda->nr, &val);
 	if (retval < 0)
 		return retval;
 	return sprintf(buf, "%d\n", !!(retval & sda->index));
@@ -88,8 +81,8 @@ static ssize_t store_temp(struct device *dev,
 
 	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
-	retval = i2c_smbus_write_byte_data(data->client, sda->index,
-					DIV_ROUND_CLOSEST(val, 1000));
+	retval = regmap_write(data->regmap, sda->index,
+			      DIV_ROUND_CLOSEST(val, 1000));
 	if (retval < 0)
 		return retval;
 	return count;
@@ -100,28 +93,17 @@ static ssize_t store_bit(struct device *dev,
 {
 	struct sensor_device_attribute_2 *sda = to_sensor_dev_attr_2(attr);
 	struct thermal_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	unsigned long val;
 	int retval;
 
 	if (kstrtoul(buf, 10, &val))
 		return -EINVAL;
 
-	mutex_lock(&data->mutex);
-	retval = i2c_smbus_read_byte_data(client, sda->nr);
+	retval = regmap_update_bits(data->regmap, sda->nr, sda->index,
+				    val ? sda->index : 0);
 	if (retval < 0)
-		goto fail;
-
-	retval &= ~sda->index;
-	if (val)
-		retval |= sda->index;
-
-	retval = i2c_smbus_write_byte_data(client, sda->index, retval);
-	if (retval = 0)
-		retval = count;
-fail:
-	mutex_unlock(&data->mutex);
-	return retval;
+		return retval;
+	return count;
 }
 
 static ssize_t show_hyst(struct device *dev,
@@ -129,22 +111,20 @@ static ssize_t show_hyst(struct device *dev,
 {
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
 	struct thermal_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
+	struct regmap *regmap = data->regmap;
+	unsigned int limit;
+	unsigned int hyst;
 	int retval;
-	int hyst;
 
-	retval = i2c_smbus_read_byte_data(client, sda->index);
+	retval = regmap_read(regmap, sda->index, &limit);
 	if (retval < 0)
 		return retval;
 
-	if (time_after(jiffies, data->hyst_valid)) {
-		hyst = i2c_smbus_read_byte_data(client, 0x21);
-		if (hyst < 0)
-			return retval;
-		data->cached_hyst = hyst;
-		data->hyst_valid = jiffies + HZ;
-	}
-	return sprintf(buf, "%d000\n", retval - data->cached_hyst);
+	retval = regmap_read(regmap, 0x21, &hyst);
+	if (retval < 0)
+		return retval;
+
+	return sprintf(buf, "%d000\n", limit - hyst);
 }
 
 static ssize_t store_hyst(struct device *dev,
@@ -152,7 +132,8 @@ static ssize_t store_hyst(struct device *dev,
 {
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
 	struct thermal_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
+	struct regmap *regmap = data->regmap;
+	unsigned int limit;
 	int retval;
 	int hyst;
 	unsigned long val;
@@ -161,23 +142,20 @@ static ssize_t store_hyst(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&data->mutex);
-	retval = i2c_smbus_read_byte_data(client, sda->index);
+	retval = regmap_read(regmap, sda->index, &limit);
 	if (retval < 0)
 		goto fail;
 
-	hyst = retval * 1000 - val;
+	hyst = limit * 1000 - val;
 	hyst = DIV_ROUND_CLOSEST(hyst, 1000);
 	if (hyst < 0 || hyst > 255) {
 		retval = -ERANGE;
 		goto fail;
 	}
 
-	retval = i2c_smbus_write_byte_data(client, 0x21, hyst);
-	if (retval = 0) {
+	retval = regmap_write(regmap, 0x21, hyst);
+	if (retval = 0)
 		retval = count;
-		data->cached_hyst = hyst;
-		data->hyst_valid = jiffies + HZ;
-	}
 fail:
 	mutex_unlock(&data->mutex);
 	return retval;
@@ -356,6 +334,35 @@ static int emc1403_detect(struct i2c_client *client,
 	return 0;
 }
 
+static bool emc1403_regmap_is_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case 0x00:	/* internal diode high byte */
+	case 0x01:	/* external diode 1 high byte */
+	case 0x02:	/* status */
+	case 0x10:	/* external diode 1 low byte */
+	case 0x1b:	/* external diode fault */
+	case 0x23:	/* external diode 2 high byte */
+	case 0x24:	/* external diode 2 low byte */
+	case 0x29:	/* internal diode low byte */
+	case 0x2a:	/* externl diode 3 high byte */
+	case 0x2b:	/* external diode 3 low byte */
+	case 0x35:	/* high limit status */
+	case 0x36:	/* low limit status */
+	case 0x37:	/* therm limit status */
+		return true;
+	default:
+		return false;
+	}
+}
+
+static struct regmap_config emc1403_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = emc1403_regmap_is_volatile,
+};
+
 static int emc1403_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -367,9 +374,11 @@ static int emc1403_probe(struct i2c_client *client,
 	if (data = NULL)
 		return -ENOMEM;
 
-	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &emc1403_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
 	mutex_init(&data->mutex);
-	data->hyst_valid = jiffies - 1;		/* Expired */
 
 	switch (id->driver_data) {
 	case emc1404:
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
