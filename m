From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: [PATCH 2.6] I2C: update the lm83 driver
Message-Id: <20040809195310.0f55025a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040808221739.07e433f9.khali@linux-fr.org>
In-Reply-To: <20040808221739.07e433f9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Same player shoot again, 256 is not 0xFF but 0x100... Shame on me. Since
both TEMP_FROM_REG and TEMP_TO_REG had the same error, it wouldn't show,
until I happened to re-read the code. Sorry for the noise. So this patch
replaces the previous one.

----------------------------

This is an update to the Linux 2.6 lm83 hardware monitoring driver.

* Follow the sysfs interface naming conventions.
* Fix the "force" module parameter.
* Fix limit settings checks.
* Driver is no longer tagged experimental.

These changes are the result of me finally succeeding in getting my
LM83 evaluation board to work. If there are norms and standards about
how evaluation boards can be wired, I guess I did not respect any of
them, but it works ;)

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali at linux-fr dot org>

diff -ruN linux-2.6.8-rc2/drivers/i2c/chips.orig/Kconfig linux-2.6.8-rc2/drivers/i2c/chips/Kconfig
--- linux-2.6.8-rc2/drivers/i2c/chips.orig/Kconfig	2004-07-21 20:02:28.000000000 +0200
+++ linux-2.6.8-rc2/drivers/i2c/chips/Kconfig	2004-08-08 21:45:49.000000000 +0200
@@ -149,7 +149,7 @@
 
 config SENSORS_LM83
 	tristate "National Semiconductor LM83"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor
diff -ruN linux-2.6.8-rc2/drivers/i2c/chips.orig/lm83.c linux-2.6.8-rc2/drivers/i2c/chips/lm83.c
--- linux-2.6.8-rc2/drivers/i2c/chips.orig/lm83.c	2004-07-19 21:49:04.000000000 +0200
+++ linux-2.6.8-rc2/drivers/i2c/chips/lm83.c	2004-08-08 21:39:28.000000000 +0200
@@ -83,8 +83,10 @@
  * The LM83 uses signed 8-bit values.
  */
 
-#define TEMP_FROM_REG(val)	((val > 127 ? val-256 : val) * 1000)
-#define TEMP_TO_REG(val)	((val < 0 ? val+256 : val) / 1000)
+#define TEMP_FROM_REG(val)	(((val) > 127 ? (val) - 0x100 : (val)) * 1000)
+#define TEMP_TO_REG(val)	((val) <= -50000 ? -50 + 0x100 : (val) >= 127000 ? 127 : \
+				 (val) > -500 ? ((val)+500) / 1000 : \
+				 ((val)-500) / 1000 + 0x100)
 
 static const u8 LM83_REG_R_TEMP[] = {
 	LM83_REG_R_LOCAL_TEMP,
@@ -178,7 +180,7 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm83_data *data = i2c_get_clientdata(client); \
-	data->value = TEMP_TO_REG(simple_strtoul(buf, NULL, 10)); \
+	data->value = TEMP_TO_REG(simple_strtol(buf, NULL, 10)); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
 	return count; \
 }
@@ -206,8 +208,11 @@
     set_temp_high3);
 static DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp_high4,
     set_temp_high4);
-static DEVICE_ATTR(temp_crit, S_IWUSR | S_IRUGO, show_temp_crit,
+static DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL);
+static DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp_crit, NULL);
+static DEVICE_ATTR(temp3_crit, S_IWUSR | S_IRUGO, show_temp_crit,
     set_temp_crit);
+static DEVICE_ATTR(temp4_crit, S_IRUGO, show_temp_crit, NULL);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /*
@@ -259,6 +264,11 @@
 	 * means that the driver was loaded with the force parameter and a
 	 * given kind of chip is requested, so both the detection and the
 	 * identification steps are skipped. */
+
+	/* Default to an LM83 if forced */
+	if (kind = 0)
+		kind = lm83;
+
 	if (kind < 0) { /* detection */
 		if (((i2c_smbus_read_byte_data(new_client, LM83_REG_R_STATUS1)
 		    & 0xA8) != 0x00) ||
@@ -322,7 +332,10 @@
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_temp3_max);
 	device_create_file(&new_client->dev, &dev_attr_temp4_max);
-	device_create_file(&new_client->dev, &dev_attr_temp_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp2_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp3_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp4_crit);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;


-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
