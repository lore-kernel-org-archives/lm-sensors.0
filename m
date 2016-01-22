From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 22 Jan 2016 17:57:21 +0000
Subject: [lm-sensors] [PATCH v2] rtc: rtc-ds1307: add temperature sensor support for ds3231
Message-Id: <1453485441-11667-1-git-send-email-akinobu.mita@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rtc-linux@googlegroups.com
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org

DS3231 has the temperature registers with a resolution of 0.25
degree celsius.  This enables to get the value through hwmon.

	# cat /sys/class/i2c-adapter/i2c-2/2-0068/hwmon/hwmon0/temp1_input
	21000

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org
---
* v2
- convert to use hwmon framework, suggested by Alexandre Belloni

 drivers/rtc/rtc-ds1307.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index aa705bb..e0d4ce5 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -19,6 +19,9 @@
 #include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/delay.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 
 /*
  * We can't determine type by probing, but if we expect pre-Linux code
@@ -75,6 +78,7 @@ enum ds_type {
 #	define DS1337_BIT_nEOSC		0x80
 #	define DS1339_BIT_BBSQI		0x20
 #	define DS3231_BIT_BBSQW		0x40 /* same as BBSQI */
+#	define DS3231_BIT_CONV		0x20
 #	define DS1337_BIT_RS2		0x10
 #	define DS1337_BIT_RS1		0x08
 #	define DS1337_BIT_INTCN		0x04
@@ -89,6 +93,7 @@ enum ds_type {
 #	define DS1340_BIT_OSF		0x80
 #define DS1337_REG_STATUS	0x0f
 #	define DS1337_BIT_OSF		0x80
+#	define DS3231_BIT_BSY		0x04
 #	define DS1337_BIT_A2I		0x02
 #	define DS1337_BIT_A1I		0x01
 #define DS1339_REG_ALARM1_SECS	0x07
@@ -851,6 +856,121 @@ out:
 	return;
 }
 
+/*----------------------------------------------------------------------*/
+
+#if IS_ENABLED(CONFIG_HWMON)
+
+/*
+ * Temperature sensor support for ds3231 devices.
+ */
+
+#define DS3231_REG_TEMPERATURE	0x11
+
+static ssize_t ds3231_hwmon_show_temp(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct ds1307	*ds1307 = dev_get_drvdata(dev);
+	struct i2c_client *client = ds1307->client;
+	u8 temp_buf[2];
+	s16 temp;
+	int control;
+	int status;
+	s32 ret;
+	unsigned long timeout;
+
+	status = i2c_smbus_read_byte_data(client, DS1337_REG_STATUS);
+	if (status < 0)
+		return status;
+
+	/*
+	 * Start user-initiated temperature conversion
+	 */
+	if (!(status & DS3231_BIT_BSY)) {
+		struct mutex	*lock = &ds1307->rtc->ops_lock;
+
+		mutex_lock(lock);
+
+		control = i2c_smbus_read_byte_data(client, DS1337_REG_CONTROL);
+		if (control < 0) {
+			mutex_unlock(lock);
+			return control;
+		}
+		ret = i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL,
+						control | DS3231_BIT_CONV);
+		if (ret)
+			return ret;
+
+		mutex_unlock(lock);
+
+		/*
+		 * A user-initiated temperature conversion does not affect
+		 * the BSY bit for approximately 2ms.
+		 */
+		usleep_range(2000, 3000);
+	}
+
+	/*
+	 * Wait until the conversion is finished
+	 */
+	timeout = jiffies + HZ;
+
+	do {
+		control = i2c_smbus_read_byte_data(client, DS1337_REG_CONTROL);
+		if (control < 0)
+			return control;
+		if (!(control & DS3231_BIT_CONV))
+			break;
+		if (time_after(jiffies, timeout))
+			return -EIO;
+		usleep_range(2000, 3000);
+	} while (1);
+
+	ret = ds1307->read_block_data(ds1307->client, DS3231_REG_TEMPERATURE,
+					sizeof(temp_buf), temp_buf);
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(temp_buf))
+		return -EIO;
+
+	/*
+	 * Temperature is represented as a 10-bit code with a resolution of
+	 * 0.25 degree celsius and encoded in two's complement format.
+	 */
+	temp = (temp_buf[0] << 8) | temp_buf[1];
+	temp >>= 6;
+
+	return sprintf(buf, "%d\n", temp * 250);
+}
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ds3231_hwmon_show_temp,
+			NULL, 0);
+
+static struct attribute *ds3231_hwmon_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ds3231_hwmon);
+
+static int ds1307_hwmon_register(struct ds1307 *ds1307)
+{
+	if (ds1307->type != ds_3231)
+		return 0;
+
+	devm_hwmon_device_register_with_groups(&ds1307->client->dev,
+						ds1307->client->name,
+						ds1307, ds3231_hwmon_groups);
+
+	return 0;
+}
+
+#else
+
+static int ds1307_hwmon_register(struct ds1307 *ds1307)
+{
+	return 0;
+}
+
+#endif
+
 static int ds1307_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -1191,6 +1311,8 @@ read_rtc:
 		}
 	}
 
+	ds1307_hwmon_register(ds1307);
+
 	return 0;
 
 exit:
-- 
2.5.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
