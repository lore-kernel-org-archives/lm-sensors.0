From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 16 Jan 2009 15:52:31 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (ds1621) Ensure 10 ms delay between
Message-Id: <20090116165231.31070870@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The DS1621 datasheet says that we should leave 10 ms between register
writes. Let the driver make sure that we don't write too fast.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/ds1621.c |   28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

--- linux-2.6.29-rc1.orig/drivers/hwmon/ds1621.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc1/drivers/hwmon/ds1621.c	2009-01-15 17:16:20.000000000 +0100
@@ -31,6 +31,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/delay.h>
 #include "lm75.h"
 
 /* Addresses to scan */
@@ -76,6 +77,7 @@ struct ds1621_data {
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
+	unsigned long last_written;	/* In jiffies */
 
 	u16 temp[3];			/* Register values, word */
 	u8 conf;			/* Register encoding, combined */
@@ -122,15 +124,33 @@ static int ds1621_read_value(struct i2c_
 
 static int ds1621_write_value(struct i2c_client *client, u8 reg, u16 value)
 {
+	struct ds1621_data *data = i2c_get_clientdata(client);
+	int ret;
+
+	/* The datasheet specifies that there should always be at least
+	   10 ms between writes */
+	if (time_before(jiffies, data->last_written + msecs_to_jiffies(10))) {
+		dev_dbg(&client->dev,
+			"Must wait a bit before we can write again\n");
+		msleep(10);
+	}
+
 	if (reg = DS1621_REG_CONF)
-		return i2c_smbus_write_byte_data(client, reg, value);
+		ret = i2c_smbus_write_byte_data(client, reg, value);
 	else
-		return i2c_smbus_write_word_data(client, reg, swab16(value));
+		ret = i2c_smbus_write_word_data(client, reg, swab16(value));
+
+	data->last_written = jiffies;
+	return ret;
 }
 
 static void ds1621_init_client(struct i2c_client *client)
 {
-	int reg = ds1621_read_value(client, DS1621_REG_CONF);
+	struct ds1621_data *data = i2c_get_clientdata(client);
+	int reg;
+
+	data->last_written = jiffies;
+	reg = ds1621_read_value(client, DS1621_REG_CONF);
 	/* switch to continuous conversion mode */
 	reg &= ~ DS1621_REG_CONFIG_1SHOT;
 
@@ -160,7 +180,7 @@ static ssize_t set_temp(struct device *d
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct i2c_client *client = to_i2c_client(dev);
-	struct ds1621_data *data = ds1621_update_client(dev);
+	struct ds1621_data *data = i2c_get_clientdata(client);
 	u16 val = LM75_TEMP_TO_REG(simple_strtol(buf, NULL, 10));
 
 	mutex_lock(&data->update_lock);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
