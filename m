From: Chris Verges <kg4ysn@gmail.com>
Date: Mon, 24 Dec 2012 08:11:09 +0000
Subject: [lm-sensors] [PATCH 1/1] lm73: added 'update_interval' attribute
Message-Id: <1356336669-18722-1-git-send-email-kg4ysn@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The LM73 supports four A/D conversion resolutions.  The default used by
the existing lm73 driver is the chip's default, 11-bit (0.25 C/LSB).
This patch enables changing of this resolution from userspace via the
temp1_update_interval attribute.

To change the resolution, write the maximum conversion time as specified
in the LM73 datasheet for the resolution desired:

   echo 14  > temp1_update_interval;   # 11-bit, 0.25 C/LSB
   echo 28  > temp1_update_interval;   # 12-bit, 0.125 C/LSB
   echo 56  > temp1_update_interval;   # 13-bit, 0.0625 C/LSB
   echo 112 > temp1_update_interval;   # 14-bit, 0.03125 C/LSB

In essence, the user can trade off conversion time for increased
precision.

Signed-off-by: Chris Verges <kg4ysn@gmail.com>
---
 drivers/hwmon/lm73.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 7272176..e6c1e05 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -39,6 +39,17 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
 #define LM73_TEMP_MIN		(-40)
 #define LM73_TEMP_MAX		150
 
+#define LM73_CTRL_RES_OFFSET	(5)
+#define LM73_CTRL_RES_SIZE	(2)
+#define LM73_CTRL_RES_MASK	((1 << LM73_CTRL_RES_SIZE) - 1)
+
+static long lm73_valid_convrates[] = {
+	14,	/* 11-bits (0.25000 C/LSB): RES1 Bit = 0, RES0 Bit = 0 */
+	28,	/* 12-bits (0.12500 C/LSB): RES1 Bit = 0, RES0 Bit = 1 */
+	56,	/* 13-bits (0.06250 C/LSB): RES1 Bit = 1, RES0 Bit = 0 */
+	112,	/* 14-bits (0.03125 C/LSB): RES1 Bit = 1, RES0 Bit = 1 */
+};
+
 /*-----------------------------------------------------------------------*/
 
 
@@ -79,6 +90,58 @@ static ssize_t show_temp(struct device *dev, struct device_attribute *da,
 	return scnprintf(buf, PAGE_SIZE, "%d\n", temp);
 }
 
+static ssize_t set_convrate(struct device *dev, struct device_attribute *da,
+			    const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	long convrate;
+	uint32_t ctrl;
+	u8 res_bits = 0;
+	u8 value;
+	u32 err;
+
+	int status = kstrtol(buf, 10, &convrate);
+	if (status < 0)
+		return status;
+
+	/* Validate the accepted conversion rate */
+	while (res_bits < ARRAY_SIZE(lm73_valid_convrates) && lm73_valid_convrates[res_bits] != convrate)
+		res_bits++;
+
+	if (res_bits >= ARRAY_SIZE(lm73_valid_convrates))
+		return -EINVAL;
+
+	/* Read existing control value */
+	ctrl = i2c_smbus_read_byte_data(client, attr->index);
+	if (ctrl < 0)
+		return ctrl;
+
+	/* Write value */
+	value = ctrl;
+	value &= ~(LM73_CTRL_RES_MASK << LM73_CTRL_RES_OFFSET);
+	value |= ((res_bits & LM73_CTRL_RES_MASK) << LM73_CTRL_RES_OFFSET);
+	err = i2c_smbus_write_byte_data(client, attr->index, value);
+	return (err < 0) ? err : count;
+}
+
+static ssize_t show_convrate(struct device *dev, struct device_attribute *da,
+			     char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	uint32_t ctrl;
+	u8 res_bits = 0;
+
+	/* Read existing control value */
+	ctrl = i2c_smbus_read_byte_data(client, attr->index);
+	if (ctrl < 0)
+		return ctrl;
+
+	res_bits = (ctrl & ~LM73_CTRL_RES_MASK) >> LM73_CTRL_RES_OFFSET;
+	return scnprintf(buf, PAGE_SIZE, "%u\n", res_bits);
+}
+
 
 /*-----------------------------------------------------------------------*/
 
@@ -90,13 +153,15 @@ static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
 			show_temp, set_temp, LM73_REG_MIN);
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
 			show_temp, NULL, LM73_REG_INPUT);
+static SENSOR_DEVICE_ATTR(temp1_update_interval, S_IWUSR | S_IRUGO,
+			show_convrate, set_convrate, LM73_REG_CTRL);
 
 
 static struct attribute *lm73_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
-
+	&sensor_dev_attr_temp1_update_interval.dev_attr.attr,
 	NULL
 };
 
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
