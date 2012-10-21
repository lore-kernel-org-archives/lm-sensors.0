From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 21 Oct 2012 17:53:11 +0000
Subject: [lm-sensors] [PATCH 4/8] hwmon: (it87) Introduce support for tempX_offset sysfs attribute
Message-Id: <1350841995-5748-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 82f7924..f2245b5 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -216,6 +216,8 @@ static const u8 IT87_REG_FANX_MIN[]	= { 0x1b, 0x1c, 0x1d, 0x85, 0x87 };
 #define IT87_REG_TEMP_HIGH(nr) (0x40 + (nr) * 2)
 #define IT87_REG_TEMP_LOW(nr)  (0x41 + (nr) * 2)
 
+#define IT87_REG_TEMP_OFFSET(nr)	(0x55 + (1 << ((nr) - 1)))
+
 #define IT87_REG_VIN_ENABLE    0x50
 #define IT87_REG_TEMP_ENABLE   0x51
 #define IT87_REG_TEMP_EXTRA    0x55
@@ -263,7 +265,7 @@ struct it87_data {
 	u16 fan[5];		/* Register values, possibly combined */
 	u16 fan_min[5];		/* Register values, possibly combined */
 	u8 has_temp;		/* Bitfield, temp sensors enabled */
-	s8 temp[3][3];		/* [nr][0]=temp, [1]=min, [2]=max */
+	s8 temp[3][4];		/* [nr][0]=temp, [1]=min, [2]=max, [3]=offset */
 	u8 sensor;		/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
@@ -540,8 +542,10 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 	data->temp[nr][index] = TEMP_TO_REG(val);
 	it87_write_value(data,
 			 index = 1 ? IT87_REG_TEMP_LOW(nr)
-				    : IT87_REG_TEMP_HIGH(nr),
+				    : index = 2 ? IT87_REG_TEMP_HIGH(nr)
+						 : IT87_REG_TEMP_OFFSET(nr),
 			 data->temp[nr][index]);
+	data->valid = 0;
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -549,12 +553,15 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
 static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGOWU, show_temp, set_temp, 0, 1);
 static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGOWU, show_temp, set_temp, 0, 2);
+static SENSOR_DEVICE_ATTR_2(temp1_offset, S_IRUGOWU, show_temp, set_temp, 0, 3);
 static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 1, 0);
 static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGOWU, show_temp, set_temp, 1, 1);
 static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGOWU, show_temp, set_temp, 1, 2);
+static SENSOR_DEVICE_ATTR_2(temp2_offset, S_IRUGOWU, show_temp, set_temp, 1, 3);
 static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 2, 0);
 static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGOWU, show_temp, set_temp, 2, 1);
 static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGOWU, show_temp, set_temp, 2, 2);
+static SENSOR_DEVICE_ATTR_2(temp3_offset, S_IRUGOWU, show_temp, set_temp, 2, 3);
 
 static ssize_t show_type(struct device *dev, struct device_attribute *attr,
 			 char *buf)
@@ -1376,11 +1383,12 @@ static const struct attribute_group it87_group_in[9] = {
 	{ .attrs = it87_attributes_in[8] },
 };
 
-static struct attribute *it87_attributes_temp[3][6] = {
+static struct attribute *it87_attributes_temp[3][7] = {
 {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_offset.dev_attr.attr,
 	&sensor_dev_attr_temp1_type.dev_attr.attr,
 	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
 	NULL
@@ -1388,6 +1396,7 @@ static struct attribute *it87_attributes_temp[3][6] = {
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
 	&sensor_dev_attr_temp2_type.dev_attr.attr,
 	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
 	NULL
@@ -1395,6 +1404,7 @@ static struct attribute *it87_attributes_temp[3][6] = {
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_offset.dev_attr.attr,
 	&sensor_dev_attr_temp3_type.dev_attr.attr,
 	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
 	NULL
@@ -2360,6 +2370,8 @@ static struct it87_data *it87_update_device(struct device *dev)
 				it87_read_value(data, IT87_REG_TEMP_LOW(i));
 			data->temp[i][2]  				it87_read_value(data, IT87_REG_TEMP_HIGH(i));
+			data->temp[i][3] +				it87_read_value(data, IT87_REG_TEMP_OFFSET(i));
 		}
 
 		/* Newer chips don't have clock dividers */
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
