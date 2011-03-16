From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed, 16 Mar 2011 18:44:10 +0000
Subject: [lm-sensors] [RFC PATCH 3/3] hwmon: sht15: add support for writing
Message-Id: <1300301050-15529-4-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support to change options on the SHT15 device, such as:
* The measurement resolution through temp_resolution sysfs attribute;
* The heater usage through the heater_enable sysfs attribute;
* The usage of reload from OTP through the otp_reload sysfs attribute.

It also fixes CRC calculation:
CRC calculation now initializes the CRC register with the value of the
lower nibble of the value of the status register, as described in the
SHT1x CRC calculation technical note.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Reviewed-by: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
To: lm-sensors@lm-sensors.org
Cc: khali@linux-fr.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/hwmon/sht15.c |  185 +++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 164 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 62a1a03..49dfd32 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -13,9 +13,9 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Default resolution only (14bit temp, 12bit humidity)
+ * Resolution can be changed via the temp_resolution sysfs attribute
  * Checksum validation can be enabled via the checksumming sysfs attribute
- * Heater not enabled.
+ * Heater can be enabled via the heater_enable sysfs attribute
  * Timings are all conservative.
  *
  * Data sheet available (1/2009) at
@@ -46,6 +46,7 @@
 #define SHT15_MEASURE_RH	0x05
 #define SHT15_SOFT_RESET	0x1E
 #define SHT15_READ_STATUS	0x07
+#define SHT15_WRITE_STATUS	0x06
 
 #define SHT15_READING_NOTHING	0
 #define SHT15_READING_TEMP	1
@@ -195,17 +196,20 @@ static u8 reverse(u8 byte)
 
 /**
  * sht15_crc8() - compute crc8
- * @data:	sht15 retrieved data
+ * @data:	sht15 specific data
+ * @value:	sht15 retrieved data
  *
  * This implements section 2 of the crc data sheet
  */
-static u8 sht15_crc8(const unsigned char *data, unsigned char len)
+static u8 sht15_crc8(struct sht15_data *data,
+		const unsigned char *value,
+		unsigned char len)
 {
-	unsigned char crc = 0;
+	unsigned char crc = reverse(data->val_status & 0x0F);
 
 	while (len--) {
-		crc = sht15_crc8_table[*data ^ crc];
-		data++;
+		crc = sht15_crc8_table[*value ^ crc];
+		value++;
 	}
 
 	return crc;
@@ -360,6 +364,40 @@ static inline void sht15_soft_reset(struct sht15_data *data)
 }
 
 /**
+ * sht15_send_status() - write the status register byte
+ * @data:	sht15 specific data
+ * @feature:	the option to update the status register with.
+ * @value:	the value to set.
+ *
+ * As described in figure 14 and table 5 of the data sheet.
+ */
+
+static int sht15_send_status(struct sht15_data *data, u8 feature, int value)
+{
+	int ret;
+	u8 status;
+
+	status = data->val_status;
+	if (value)
+		status |= feature;
+	else
+		status &= ~feature;
+
+	ret = sht15_send_cmd(data, SHT15_WRITE_STATUS);
+	if (ret)
+		return ret;
+	gpio_direction_output(data->pdata->gpio_data, 1);
+	ndelay(SHT15_TSU);
+	sht15_send_byte(data, status);
+	ret = sht15_wait_for_response(data);
+	if (ret)
+		return ret;
+	/* Needed for the next CRC calculation */
+	sht15_apply_status(data, status);
+	return 0;
+}
+
+/**
  * sht15_update_status() - get the status register from device
  * @data:	device instance specific data.
  *
@@ -382,7 +420,7 @@ static int sht15_update_status(struct sht15_data *data)
 		dev_checksum = reverse(sht15_read_byte(data));
 		checksum_values[0] = SHT15_READ_STATUS;
 		checksum_values[1] = status;
-		data->checksum_ok = (sht15_crc8(checksum_values, 2) = dev_checksum);
+		data->checksum_ok = (sht15_crc8(data, checksum_values, 2) = dev_checksum);
 	}
 
 	sht15_end_transmission(data);
@@ -489,6 +527,7 @@ error_ret:
 static inline int sht15_calc_temp(struct sht15_data *data)
 {
 	int d1 = temppoints[0].d1;
+	int d2 = (data->temp_resolution = 14) ? 10 : 40;
 	int i;
 
 	for (i = ARRAY_SIZE(temppoints) - 1; i > 0; i--)
@@ -501,7 +540,7 @@ static inline int sht15_calc_temp(struct sht15_data *data)
 			break;
 		}
 
-	return data->val_temp*10 + d1;
+	return data->val_temp * d2 + d1;
 }
 
 /**
@@ -510,20 +549,33 @@ static inline int sht15_calc_temp(struct sht15_data *data)
  *
  * This is the temperature compensated version as per section 4.2 of
  * the data sheet.
- **/
+ *
+ * The sensor is assumed to be V3, which is compatible with V4.
+ * Humidity conversion coefficients are shown in table 7 of the data sheet.
+ */
 static inline int sht15_calc_humid(struct sht15_data *data)
 {
 	int RHlinear; /* milli percent */
 	int temp = sht15_calc_temp(data);
+	int c2, c3;
+	int t2;
 
 	const int c1 = -4;
-	const int c2 = 40500; /* x 10 ^ -6 */
-	const int c3 = -28; /* x10 ^ -7 */
 
-	RHlinear = c1*1000
-		+ c2 * data->val_humid/1000
-		+ (data->val_humid * data->val_humid * c3)/10000;
-	return (temp - 25000) * (10000 + 80 * data->val_humid)
+	if (data->humidity_resolution = 12) {
+		c2 = 40500; /* x 10 ^ -6 */
+		c3 = -28; /* x 10 ^ -7 */
+		t2 = 80;
+	} else {
+		c2 = 648000; /* x 10 ^ -6 */
+		c3 = -7200; /* x 10 ^ -7 */
+		t2 = 1280;
+	}
+
+	RHlinear = c1 * 1000
+		+ c2 * data->val_humid / 1000
+		+ (data->val_humid * data->val_humid * c3) / 10000;
+	return (temp - 25000) * (10000 + t2 * data->val_humid)
 		/ 1000000 + RHlinear;
 }
 
@@ -553,6 +605,30 @@ static ssize_t sht15_show_heater(struct device *dev,
 	return ret ? ret : sprintf(buf, "%d\n", data->heater);
 }
 
+static ssize_t sht15_store_heater(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int ret;
+	struct sht15_data *data = dev_get_drvdata(dev);
+	long value;
+
+	mutex_lock(&data->read_lock);
+	if (strict_strtol(buf, 10, &value)) {
+		mutex_unlock(&data->read_lock);
+		return -EINVAL;
+	}
+
+	ret = sht15_send_status(data, SHT15_STATUS_HEATER, !!value);
+	if (ret) {
+		mutex_unlock(&data->read_lock);
+		return ret;
+	}
+
+	mutex_unlock(&data->read_lock);
+	return count;
+}
+
 static ssize_t sht15_show_otp_reload(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
@@ -566,6 +642,30 @@ static ssize_t sht15_show_otp_reload(struct device *dev,
 	return ret ? ret : sprintf(buf, "%d\n", !(data->no_otp_reload));
 }
 
+static ssize_t sht15_store_otp_reload(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int ret;
+	struct sht15_data *data = dev_get_drvdata(dev);
+	long value;
+
+	mutex_lock(&data->read_lock);
+	if (strict_strtol(buf, 10, &value)) {
+		mutex_unlock(&data->read_lock);
+		return -EINVAL;
+	}
+
+	ret = sht15_send_status(data, SHT15_STATUS_OTP_RELOAD, !value);
+	if (ret) {
+		mutex_unlock(&data->read_lock);
+		return ret;
+	}
+
+	mutex_unlock(&data->read_lock);
+	return count;
+}
+
 static ssize_t sht15_show_temp_resolution(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
@@ -579,6 +679,42 @@ static ssize_t sht15_show_temp_resolution(struct device *dev,
 	return ret ? ret : sprintf(buf, "%d\n", data->temp_resolution);
 }
 
+static ssize_t sht15_store_temp_resolution(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int ret;
+	struct sht15_data *data = dev_get_drvdata(dev);
+	long value;
+
+	mutex_lock(&data->read_lock);
+	if (strict_strtol(buf, 10, &value)) {
+		mutex_unlock(&data->read_lock);
+		return -EINVAL;
+	}
+
+	switch (value) {
+	case 14:
+		value = 0;
+		break;
+	case 12:
+		value = 1;
+		break;
+	default:
+		mutex_unlock(&data->read_lock);
+		return -EINVAL;
+	}
+
+	ret = sht15_send_status(data, SHT15_STATUS_RESOLUTION, value);
+	if (ret) {
+		mutex_unlock(&data->read_lock);
+		return ret;
+	}
+
+	mutex_unlock(&data->read_lock);
+	return count;
+}
+
 static ssize_t sht15_show_humidity_resolution(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
@@ -661,12 +797,18 @@ static SENSOR_DEVICE_ATTR(humidity1_input,
 			  S_IRUGO, sht15_show_humidity,
 			  NULL, 0);
 static DEVICE_ATTR(battery_alarm, S_IRUGO, sht15_show_battery, NULL);
-static DEVICE_ATTR(heater_enable, S_IRUGO, sht15_show_heater, NULL);
-static DEVICE_ATTR(otp_reload, S_IRUGO, sht15_show_otp_reload, NULL);
+static DEVICE_ATTR(heater_enable,
+		S_IRUGO | S_IWUSR,
+		sht15_show_heater,
+		sht15_store_heater);
+static DEVICE_ATTR(otp_reload,
+		S_IRUGO | S_IWUSR,
+		sht15_show_otp_reload,
+		sht15_store_otp_reload);
 static DEVICE_ATTR(temp_resolution,
-		S_IRUGO,
+		S_IRUGO | S_IWUSR,
 		sht15_show_temp_resolution,
-		NULL);
+		sht15_store_temp_resolution);
 static DEVICE_ATTR(humidity_resolution,
 		S_IRUGO,
 		sht15_show_humidity_resolution,
@@ -794,7 +936,7 @@ static void sht15_bh_read_data(struct work_struct *work_s)
 		checksum_values[0] = (data->flag = SHT15_READING_TEMP) ? SHT15_MEASURE_TEMP : SHT15_MEASURE_RH;
 		checksum_values[1] = (u8) (val >> 8);
 		checksum_values[2] = (u8) val;
-		data->checksum_ok = (sht15_crc8(checksum_values, 3) = dev_checksum);
+		data->checksum_ok = (sht15_crc8(data, checksum_values, 3) = dev_checksum);
 	}
 
 	/* Tell the device we are done */
@@ -868,6 +1010,7 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 	data->pdata = pdev->dev.platform_data;
 	data->supply_uV = data->pdata->supply_mv*1000;
 	data->checksumming = 1; /* Verify checksums by default */
+	data->val_status = 0;
 
 /* If a regulator is available, query what the supply voltage actually is!*/
 	data->reg = regulator_get(data->dev, "vcc");
-- 
1.7.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
