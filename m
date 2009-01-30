From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Jan 2009 17:56:27 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (ds1621) Avoid unneeded register
Message-Id: <20090130185627.09933f51@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Register access over SMBus isn't cheap, so avoid register access where
possible:
* Only write back the configuration register if it changed.
* Don't refresh the register cache when we don't have to.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/hwmon/ds1621.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- linux-2.6.29-rc2.orig/drivers/hwmon/ds1621.c	2009-01-28 10:04:25.000000000 +0100
+++ linux-2.6.29-rc2/drivers/hwmon/ds1621.c	2009-01-28 10:06:50.000000000 +0100
@@ -101,17 +101,20 @@ static int ds1621_write_temp(struct i2c_
 
 static void ds1621_init_client(struct i2c_client *client)
 {
-	int reg = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
+	u8 conf, new_conf;
+
+	new_conf = conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
 	/* switch to continuous conversion mode */
-	reg &= ~ DS1621_REG_CONFIG_1SHOT;
+	new_conf &= ~DS1621_REG_CONFIG_1SHOT;
 
 	/* setup output polarity */
 	if (polarity = 0)
-		reg &= ~DS1621_REG_CONFIG_POLARITY;
+		new_conf &= ~DS1621_REG_CONFIG_POLARITY;
 	else if (polarity = 1)
-		reg |= DS1621_REG_CONFIG_POLARITY;
+		new_conf |= DS1621_REG_CONFIG_POLARITY;
 	
-	i2c_smbus_write_byte_data(client, DS1621_REG_CONF, reg);
+	if (conf != new_conf)
+		i2c_smbus_write_byte_data(client, DS1621_REG_CONF, new_conf);
 	
 	/* start conversion */
 	i2c_smbus_write_byte(client, DS1621_COM_START);
@@ -170,7 +173,7 @@ static ssize_t set_temp(struct device *d
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
