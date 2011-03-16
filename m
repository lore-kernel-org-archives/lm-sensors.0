From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed, 16 Mar 2011 18:44:09 +0000
Subject: [lm-sensors] [RFC PATCH 2/3] hwmon: sht15: add support for reading
Message-Id: <1300301050-15529-3-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support to read the sht15 status register. Explicitly:
* The measurement resolution through the temp_resolution and
  humidity_resolution sysfs attributes;
* An end of battery indicator through the battery_alarm sysfs attribute;
* Embedded heater support using the heater_enable sysfs attribute;
* Reload from OTP available through the otp_reload sysfs attribute.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Reviewed-by: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
To: lm-sensors@lm-sensors.org
Cc: khali@linux-fr.org
---
 drivers/hwmon/sht15.c |  168 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 167 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 83822a6..62a1a03 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -3,6 +3,7 @@
  *
  * Portions Copyright (c) 2010-2011 Savoir-faire Linux Inc.
  *          Jerome Oufella <jerome.oufella@savoirfairelinux.com>
+ *          Vivien Didelot <vivien.didelot@savoirfairelinux.com>
  *
  * Copyright (c) 2009 Jonathan Cameron
  *
@@ -14,7 +15,6 @@
  *
  * Default resolution only (14bit temp, 12bit humidity)
  * Checksum validation can be enabled via the checksumming sysfs attribute
- * Ignoring battery status.
  * Heater not enabled.
  * Timings are all conservative.
  *
@@ -45,6 +45,7 @@
 #define SHT15_MEASURE_TEMP	0x03
 #define SHT15_MEASURE_RH	0x05
 #define SHT15_SOFT_RESET	0x1E
+#define SHT15_READ_STATUS	0x07
 
 #define SHT15_READING_NOTHING	0
 #define SHT15_READING_TEMP	1
@@ -58,6 +59,12 @@
 /* Min timings in msecs */
 #define SHT15_TSRST		11	/* soft reset time */
 
+/* Status Register Bits */
+#define SHT15_STATUS_BATTERY	0x40
+#define SHT15_STATUS_HEATER	0x04
+#define SHT15_STATUS_OTP_RELOAD	0x02
+#define SHT15_STATUS_RESOLUTION	0x01
+
 /**
  * struct sht15_temppair - elements of voltage dependant temp calc
  * @vdd:	supply voltage in microvolts
@@ -114,6 +121,7 @@ static const u8 sht15_crc8_table[] = {
  * @wait_queue:	wait queue for getting values from device
  * @val_temp:	last temperature value read from device
  * @val_humid: 	last humidity value read from device
+ * @val_status:	last status register value read from device
  * @checksum_ok:last value read from device passed checksum verification
  * @flag:	status flag used to identify what the last request was
  * @valid:	are the current stored values valid (start condition)
@@ -132,6 +140,11 @@ static const u8 sht15_crc8_table[] = {
  * @update_supply_work:	work struct that is used to update the supply_uV
  * @interrupt_handled:	flag used to indicate a hander has been scheduled
  * @checksumming:	flag used to indicate the data checksum must be validated
+ * @end_of_battery:	flag used to indicate the low voltage detection
+ * @heater:		flag used to indicate the heater status
+ * @no_otp_reload:	flag used to indicate no reloading from OTP
+ * @temp_resolution:	the temperature measurement resolution
+ * @humidity_resolution:    the humidity measurement resolution
  */
 struct sht15_data {
 	struct sht15_platform_data	*pdata;
@@ -139,6 +152,7 @@ struct sht15_data {
 	wait_queue_head_t		wait_queue;
 	uint16_t			val_temp;
 	uint16_t			val_humid;
+	u8				val_status;
 	u8				checksum_ok;
 	u8				flag;
 	u8				valid;
@@ -153,6 +167,11 @@ struct sht15_data {
 	struct work_struct		update_supply_work;
 	atomic_t			interrupt_handled;
 	u8				checksumming;
+	u8				end_of_battery;
+	u8				heater;
+	u8				no_otp_reload;
+	u8				temp_resolution;
+	u8				humidity_resolution;
 };
 
 static u8 sht15_read_byte(struct sht15_data *);
@@ -193,6 +212,26 @@ static u8 sht15_crc8(const unsigned char *data, unsigned char len)
 }
 
 /**
+ * sht15_apply_status() - update data attributes from the status
+ * @data:	sht15 specific data.
+ * @status:	new status to set to data.
+ */
+static void sht15_apply_status(struct sht15_data *data, u8 status)
+{
+	data->val_status = status;
+	data->end_of_battery = (status & SHT15_STATUS_BATTERY) >> 6;
+	data->heater = (status & SHT15_STATUS_HEATER) >> 2;
+	data->no_otp_reload = (status & SHT15_STATUS_OTP_RELOAD) >> 1;
+	if (status & SHT15_STATUS_RESOLUTION) {
+		data->temp_resolution = 12;
+		data->humidity_resolution = 8;
+	} else {
+		data->temp_resolution = 14;
+		data->humidity_resolution = 12;
+	}
+}
+
+/**
  * sht15_connection_reset() - reset the comms interface
  * @data:	sht15 specific data
  *
@@ -316,6 +355,49 @@ static inline void sht15_soft_reset(struct sht15_data *data)
 {
 	sht15_send_cmd(data, SHT15_SOFT_RESET);
 	msleep(SHT15_TSRST);
+	/* reset attributes with default register value */
+	sht15_apply_status(data, 0);
+}
+
+/**
+ * sht15_update_status() - get the status register from device
+ * @data:	device instance specific data.
+ *
+ * As described in figure 15 and table 5 of the data sheet.
+ */
+static int sht15_update_status(struct sht15_data *data)
+{
+	int ret;
+	u8 status;
+	u8 dev_checksum = 0;
+	u8 checksum_values[2];
+
+	ret = sht15_send_cmd(data, SHT15_READ_STATUS);
+	if (ret)
+		return ret;
+	status = sht15_read_byte(data);
+
+	if (data->checksumming) {
+		sht15_ack(data);
+		dev_checksum = reverse(sht15_read_byte(data));
+		checksum_values[0] = SHT15_READ_STATUS;
+		checksum_values[1] = status;
+		data->checksum_ok = (sht15_crc8(checksum_values, 2) = dev_checksum);
+	}
+
+	sht15_end_transmission(data);
+
+	/*
+	 *  Perform checksum validation on the received data.
+	 *  Specification mentions that in case a checksum verification fails,
+	 *  a soft reset command must be sent to the device.
+	 */
+	if (data->checksumming && !data->checksum_ok) {
+		sht15_soft_reset(data);
+		return -EAGAIN;
+	}
+	sht15_apply_status(data, status);
+	return 0;
 }
 
 /**
@@ -378,6 +460,9 @@ static int sht15_update_vals(struct sht15_data *data)
 	mutex_lock(&data->read_lock);
 	if (time_after(jiffies, data->last_updat + timeout)
 	    || !data->valid) {
+		ret = sht15_update_status(data);
+		if (ret)
+			goto error_ret;
 		data->flag = SHT15_READING_HUMID;
 		ret = sht15_update_single_val(data, SHT15_MEASURE_RH, 160);
 		if (ret)
@@ -442,6 +527,71 @@ static inline int sht15_calc_humid(struct sht15_data *data)
 		/ 1000000 + RHlinear;
 }
 
+static ssize_t sht15_show_battery(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int ret;
+	struct sht15_data *data = dev_get_drvdata(dev);
+
+	/* Technically no need to read temperature and humidity as well */
+	ret = sht15_update_vals(data);
+
+	return ret ? ret : sprintf(buf, "%d\n", data->end_of_battery);
+}
+
+static ssize_t sht15_show_heater(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int ret;
+	struct sht15_data *data = dev_get_drvdata(dev);
+
+	/* Technically no need to read temperature and humidity as well */
+	ret = sht15_update_vals(data);
+
+	return ret ? ret : sprintf(buf, "%d\n", data->heater);
+}
+
+static ssize_t sht15_show_otp_reload(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int ret;
+	struct sht15_data *data = dev_get_drvdata(dev);
+
+	/* Technically no need to read temperature and humidity as well */
+	ret = sht15_update_vals(data);
+
+	return ret ? ret : sprintf(buf, "%d\n", !(data->no_otp_reload));
+}
+
+static ssize_t sht15_show_temp_resolution(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int ret;
+	struct sht15_data *data = dev_get_drvdata(dev);
+
+	/* Technically no need to read temperature and humidity as well */
+	ret = sht15_update_vals(data);
+
+	return ret ? ret : sprintf(buf, "%d\n", data->temp_resolution);
+}
+
+static ssize_t sht15_show_humidity_resolution(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	int ret;
+	struct sht15_data *data = dev_get_drvdata(dev);
+
+	/* Technically no need to read temperature and humidity as well */
+	ret = sht15_update_vals(data);
+
+	return ret ? ret : sprintf(buf, "%d\n", data->humidity_resolution);
+}
+
 static ssize_t sht15_show_temp(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
@@ -510,6 +660,17 @@ static SENSOR_DEVICE_ATTR(temp1_input,
 static SENSOR_DEVICE_ATTR(humidity1_input,
 			  S_IRUGO, sht15_show_humidity,
 			  NULL, 0);
+static DEVICE_ATTR(battery_alarm, S_IRUGO, sht15_show_battery, NULL);
+static DEVICE_ATTR(heater_enable, S_IRUGO, sht15_show_heater, NULL);
+static DEVICE_ATTR(otp_reload, S_IRUGO, sht15_show_otp_reload, NULL);
+static DEVICE_ATTR(temp_resolution,
+		S_IRUGO,
+		sht15_show_temp_resolution,
+		NULL);
+static DEVICE_ATTR(humidity_resolution,
+		S_IRUGO,
+		sht15_show_humidity_resolution,
+		NULL);
 static DEVICE_ATTR(checksumming,
 			  S_IRUGO | S_IWUSR,
 			  sht15_show_checksum,
@@ -518,6 +679,11 @@ static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 static struct attribute *sht15_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_humidity1_input.dev_attr.attr,
+	&dev_attr_battery_alarm.attr,
+	&dev_attr_heater_enable.attr,
+	&dev_attr_otp_reload.attr,
+	&dev_attr_temp_resolution.attr,
+	&dev_attr_humidity_resolution.attr,
 	&dev_attr_checksumming.attr,
 	&dev_attr_name.attr,
 	NULL,
-- 
1.7.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
