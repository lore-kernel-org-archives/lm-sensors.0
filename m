From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Wed, 11 Jun 2008 19:20:59 +0000
Subject: [lm-sensors] [PATCH] thmc50: add support for critical temperature
Message-Id: <20080611212059.90f95f30.krzysztof.h1@poczta.fm>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch add critical temperature limits to
the driver. These limits are read only.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This feature has been requested by Jean Delvare.

diff -urp linux-old/drivers/hwmon/thmc50.c linux-new/drivers/hwmon/thmc50.c
--- linux-old/drivers/hwmon/thmc50.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-new/drivers/hwmon/thmc50.c	2008-06-11 21:08:28.353747656 +0200
@@ -55,8 +55,11 @@ I2C_CLIENT_MODULE_PARM(adm1022_temp3, "L
 static const u8 THMC50_REG_TEMP[] = { 0x27, 0x26, 0x20 };
 static const u8 THMC50_REG_TEMP_MIN[] = { 0x3A, 0x38, 0x2C };
 static const u8 THMC50_REG_TEMP_MAX[] = { 0x39, 0x37, 0x2B };
+static const u8 THMC50_REG_TEMP_CRITICAL[] = { 0x13, 0x14, 0x14 };
+static const u8 THMC50_REG_TEMP_DEFAULT[] = { 0x17, 0x18, 0x18 };
 
 #define THMC50_REG_CONF_nFANOFF			0x20
+#define THMC50_REG_CONF_PROGRAMMED		0x08
 
 /* Each client has this additional data */
 struct thmc50_data {
@@ -73,6 +76,7 @@ struct thmc50_data {
 	s8 temp_input[3];
 	s8 temp_max[3];
 	s8 temp_min[3];
+	s8 temp_critical[3];
 	u8 analog_out;
 	u8 alarms;
 };
@@ -186,6 +190,15 @@ static ssize_t set_temp_max(struct devic
 	return count;
 }
 
+static ssize_t show_temp_critical(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	int nr = to_sensor_dev_attr(attr)->index;
+	struct thmc50_data *data = thmc50_update_device(dev);
+	return sprintf(buf, "%d\n", data->temp_critical[nr] * 1000);
+}
+
 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
@@ -201,7 +214,9 @@ static SENSOR_DEVICE_ATTR(temp##offset##
 static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
 			show_temp_min, set_temp_min, offset - 1);	\
 static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
-			show_temp_max, set_temp_max, offset - 1);
+			show_temp_max, set_temp_max, offset - 1);	\
+static SENSOR_DEVICE_ATTR(temp##offset##_critical, S_IRUGO,		\
+			show_temp_critical, NULL, offset - 1);
 
 temp_reg(1);
 temp_reg(2);
@@ -221,10 +236,12 @@ static struct attribute *thmc50_attribut
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_critical.dev_attr.attr,
 	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_critical.dev_attr.attr,
 	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_fault.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
@@ -241,6 +258,7 @@ static struct attribute *temp3_attribute
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_min.dev_attr.attr,
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_critical.dev_attr.attr,
 	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_fault.dev_attr.attr,
 	NULL
@@ -430,6 +448,10 @@ static struct thmc50_data *thmc50_update
 
 		int temps = data->has_temp3 ? 3 : 2;
 		int i;
+		int prog = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
+
+		prog &= THMC50_REG_CONF_PROGRAMMED;
+
 		for (i = 0; i < temps; i++) {
 			data->temp_input[i] = i2c_smbus_read_byte_data(client,
 						THMC50_REG_TEMP[i]);
@@ -437,6 +459,10 @@ static struct thmc50_data *thmc50_update
 						THMC50_REG_TEMP_MAX[i]);
 			data->temp_min[i] = i2c_smbus_read_byte_data(client,
 						THMC50_REG_TEMP_MIN[i]);
+			data->temp_critical[i] +				i2c_smbus_read_byte_data(client,
+					prog ? THMC50_REG_TEMP_CRITICAL[i]
+					     : THMC50_REG_TEMP_DEFAULT[i]);
 		}
 		data->analog_out  		    i2c_smbus_read_byte_data(client, THMC50_REG_ANALOG_OUT);

----------------------------------------------------------------------
Tania telefonia internetowa!
Sprawdz >>>  http://link.interia.pl/f1e2e


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
