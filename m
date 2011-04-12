From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Tue, 12 Apr 2011 19:34:39 +0000
Subject: [lm-sensors] [PATCH v2 4/4] hwmon: (sht15) add support for CRC
Message-Id: <1302636879-16615-5-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jerome Oufella <jerome.oufella@savoirfairelinux.com>

The sht15 sensor allows validating exchanges to and from the device
using a crc8 function. An utility function to reverse a byte has also
been added.

Signed-off-by: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
---
 Documentation/hwmon/sht15 |    9 ++-
 drivers/hwmon/sht15.c     |  192 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/sht15.h     |    2 +
 3 files changed, 183 insertions(+), 20 deletions(-)

diff --git a/Documentation/hwmon/sht15 b/Documentation/hwmon/sht15
index a9e36e3..d0403f5 100644
--- a/Documentation/hwmon/sht15
+++ b/Documentation/hwmon/sht15
@@ -5,6 +5,7 @@ Authors:
   * Wouter Horre
   * Jonathan Cameron
   * Vivien Didelot <vivien.didelot@savoirfairelinux.com>
+  * Jerome Oufella <jerome.oufella@savoirfairelinux.com>
 
 Supported chips:
   * Sensirion SHT10
@@ -44,11 +45,17 @@ measurement and decrease power consumption, while loosing on precision.
 Some options may be set directly in the sht15_platform_data structure
 or via sysfs attributes.
 
-Note: The regulator supply name is set to "vcc".
+Notes:
+  * The regulator supply name is set to "vcc".
+  * If a CRC validation fails, a soft reset command is sent, which resets
+    status register to its hardware default value, but the driver will try to
+    restore the previous device configuration.
 
 Platform data
 -------------
 
+* checksum:
+  set it to true to enable CRC validation of the readings (default to false).
 * no_otp_reload:
   flag to indicate not to reload from OTP (default to false).
 * low_resolution:
diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 77d25d3..1fb9588 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -2,6 +2,7 @@
  * sht15.c - support for the SHT15 Temperature and Humidity Sensor
  *
  * Portions Copyright (c) 2010-2011 Savoir-faire Linux Inc.
+ *          Jerome Oufella <jerome.oufella@savoirfairelinux.com>
  *          Vivien Didelot <vivien.didelot@savoirfairelinux.com>
  *
  * Copyright (c) 2009 Jonathan Cameron
@@ -78,6 +79,42 @@ static const struct sht15_temppair temppoints[] = {
 	{ 5000000, -40100 },
 };
 
+/* Table from CRC datasheet, section 2.4 */
+static const u8 sht15_crc8_table[] = {
+	0,	49,	98,	83,	196,	245,	166,	151,
+	185,	136,	219,	234,	125,	76,	31,	46,
+	67,	114,	33,	16,	135,	182,	229,	212,
+	250,	203,	152,	169,	62,	15,	92,	109,
+	134,	183,	228,	213,	66,	115,	32,	17,
+	63,	14,	93,	108,	251,	202,	153,	168,
+	197,	244,	167,	150,	1,	48,	99,	82,
+	124,	77,	30,	47,	184,	137,	218,	235,
+	61,	12,	95,	110,	249,	200,	155,	170,
+	132,	181,	230,	215,	64,	113,	34,	19,
+	126,	79,	28,	45,	186,	139,	216,	233,
+	199,	246,	165,	148,	3,	50,	97,	80,
+	187,	138,	217,	232,	127,	78,	29,	44,
+	2,	51,	96,	81,	198,	247,	164,	149,
+	248,	201,	154,	171,	60,	13,	94,	111,
+	65,	112,	35,	18,	133,	180,	231,	214,
+	122,	75,	24,	41,	190,	143,	220,	237,
+	195,	242,	161,	144,	7,	54,	101,	84,
+	57,	8,	91,	106,	253,	204,	159,	174,
+	128,	177,	226,	211,	68,	117,	38,	23,
+	252,	205,	158,	175,	56,	9,	90,	107,
+	69,	116,	39,	22,	129,	176,	227,	210,
+	191,	142,	221,	236,	123,	74,	25,	40,
+	6,	55,	100,	85,	194,	243,	160,	145,
+	71,	118,	37,	20,	131,	178,	225,	208,
+	254,	207,	156,	173,	58,	11,	88,	105,
+	4,	53,	102,	87,	192,	241,	162,	147,
+	189,	140,	223,	238,	121,	72,	27,	42,
+	193,	240,	163,	146,	5,	52,	103,	86,
+	120,	73,	26,	43,	188,	141,	222,	239,
+	130,	179,	224,	209,	70,	119,	36,	21,
+	59,	10,	89,	104,	255,	206,	157,	172
+};
+
 /**
  * struct sht15_data - device instance specific data
  * @pdata:		platform data (gpio's etc).
@@ -86,6 +123,8 @@ static const struct sht15_temppair temppoints[] = {
  * @val_temp:		last temperature value read from device.
  * @val_humid:		last humidity value read from device.
  * @val_status:		last status register value read from device.
+ * @checksum_ok:	last value read from the device passed CRC validation.
+ * @checksumming:	flag used to enable the data validation with CRC.
  * @state:		state identifying the action the driver is doing.
  * @measurements_valid:	are the current stored measures valid (start condition).
  * @status_valid:	is the current stored status valid (start condition).
@@ -112,6 +151,8 @@ struct sht15_data {
 	uint16_t			val_temp;
 	uint16_t			val_humid;
 	u8				val_status;
+	bool				checksum_ok;
+	bool				checksumming;
 	enum sht15_state		state;
 	bool				measurements_valid;
 	bool				status_valid;
@@ -129,6 +170,40 @@ struct sht15_data {
 };
 
 /**
+ * sht15_reverse() - reverse a byte
+ * @byte:    byte to reverse.
+ */
+static u8 sht15_reverse(u8 byte)
+{
+	u8 i, c;
+
+	for (c = 0, i = 0; i < 8; i++)
+		c |= (!!(byte & (1 << i))) << (7 - i);
+	return c;
+}
+
+/**
+ * sht15_crc8() - compute crc8
+ * @data:	sht15 specific data.
+ * @value:	sht15 retrieved data.
+ *
+ * This implements section 2 of the CRC datasheet.
+ */
+static u8 sht15_crc8(struct sht15_data *data,
+		const u8 *value,
+		int len)
+{
+	u8 crc = sht15_reverse(data->val_status & 0x0F);
+
+	while (len--) {
+		crc = sht15_crc8_table[*value ^ crc];
+		value++;
+	}
+
+	return crc;
+}
+
+/**
  * sht15_connection_reset() - reset the comms interface
  * @data:	sht15 specific data
  *
@@ -268,6 +343,26 @@ static int sht15_soft_reset(struct sht15_data *data)
 }
 
 /**
+ * sht15_ack() - send a ack
+ * @data:	sht15 specific data.
+ *
+ * Each byte of data is acknowledged by pulling the data line
+ * low for one clock pulse.
+ */
+static void sht15_ack(struct sht15_data *data)
+{
+	gpio_direction_output(data->pdata->gpio_data, 0);
+	ndelay(SHT15_TSU);
+	gpio_set_value(data->pdata->gpio_sck, 1);
+	ndelay(SHT15_TSU);
+	gpio_set_value(data->pdata->gpio_sck, 0);
+	ndelay(SHT15_TSU);
+	gpio_set_value(data->pdata->gpio_data, 1);
+
+	gpio_direction_input(data->pdata->gpio_data);
+}
+
+/**
  * sht15_end_transmission() - notify device of end of transmission
  * @data:	device state.
  *
@@ -338,6 +433,9 @@ static int sht15_update_status(struct sht15_data *data)
 {
 	int ret = 0;
 	u8 status;
+	u8 previous_config;
+	u8 dev_checksum = 0;
+	u8 checksum_vals[2];
 	int timeout = HZ;
 
 	mutex_lock(&data->read_lock);
@@ -348,8 +446,40 @@ static int sht15_update_status(struct sht15_data *data)
 			goto error_ret;
 		status = sht15_read_byte(data);
 
+		if (data->checksumming) {
+			sht15_ack(data);
+			dev_checksum = sht15_reverse(sht15_read_byte(data));
+			checksum_vals[0] = SHT15_READ_STATUS;
+			checksum_vals[1] = status;
+			data->checksum_ok = (sht15_crc8(data, checksum_vals, 2)
+					= dev_checksum);
+		}
+
 		sht15_end_transmission(data);
 
+		/*
+		 * Perform checksum validation on the received data.
+		 * Specification mentions that in case a checksum verification
+		 * fails, a soft reset command must be sent to the device.
+		 */
+		if (data->checksumming && !data->checksum_ok) {
+			previous_config = data->val_status & 0x07;
+			ret = sht15_soft_reset(data);
+			if (ret)
+				goto error_ret;
+			if (previous_config) {
+				ret = sht15_send_status(data, previous_config);
+				if (ret) {
+					dev_err(data->dev,
+						"CRC validation failed, unable "
+						"to restore device settings\n");
+					goto error_ret;
+				}
+			}
+			ret = -EAGAIN;
+			goto error_ret;
+		}
+
 		data->val_status = status;
 		data->status_valid = true;
 		data->last_status = jiffies;
@@ -372,6 +502,7 @@ static int sht15_measurement(struct sht15_data *data,
 			     int timeout_msecs)
 {
 	int ret;
+	u8 previous_config;
 
 	ret = sht15_send_cmd(data, command);
 	if (ret)
@@ -395,6 +526,29 @@ static int sht15_measurement(struct sht15_data *data,
 		sht15_connection_reset(data);
 		return -ETIME;
 	}
+
+	/*
+	 *  Perform checksum validation on the received data.
+	 *  Specification mentions that in case a checksum verification fails,
+	 *  a soft reset command must be sent to the device.
+	 */
+	if (data->checksumming && !data->checksum_ok) {
+		previous_config = data->val_status & 0x07;
+		ret = sht15_soft_reset(data);
+		if (ret)
+			return ret;
+		if (previous_config) {
+			ret = sht15_send_status(data, previous_config);
+			if (ret) {
+				dev_err(data->dev,
+					"CRC validation failed, unable "
+					"to restore device settings\n");
+				return ret;
+			}
+		}
+		return -EAGAIN;
+	}
+
 	return 0;
 }
 
@@ -635,28 +789,11 @@ static irqreturn_t sht15_interrupt_fired(int irq, void *d)
 	return IRQ_HANDLED;
 }
 
-/**
- * sht15_ack() - Send an ack to the device
- *
- * Each byte of data is acknowledged by pulling the data line
- * low for one clock pulse.
- */
-static void sht15_ack(struct sht15_data *data)
-{
-	gpio_direction_output(data->pdata->gpio_data, 0);
-	ndelay(SHT15_TSU);
-	gpio_set_value(data->pdata->gpio_sck, 1);
-	ndelay(SHT15_TSU);
-	gpio_set_value(data->pdata->gpio_sck, 0);
-	ndelay(SHT15_TSU);
-	gpio_set_value(data->pdata->gpio_data, 1);
-
-	gpio_direction_input(data->pdata->gpio_data);
-}
-
 static void sht15_bh_read_data(struct work_struct *work_s)
 {
 	uint16_t val = 0;
+	u8 dev_checksum = 0;
+	u8 checksum_vals[3];
 	struct sht15_data *data
 		= container_of(work_s, struct sht15_data,
 			       read_work);
@@ -681,6 +818,21 @@ static void sht15_bh_read_data(struct work_struct *work_s)
 	sht15_ack(data);
 	val |= sht15_read_byte(data);
 
+	if (data->checksumming) {
+		/*
+		 * Ask the device for a checksum and read it back.
+		 * Note: the device sends the checksum byte reversed.
+		 */
+		sht15_ack(data);
+		dev_checksum = sht15_reverse(sht15_read_byte(data));
+		checksum_vals[0] = (data->state = SHT15_READING_TEMP) ?
+			SHT15_MEASURE_TEMP : SHT15_MEASURE_RH;
+		checksum_vals[1] = (u8) (val >> 8);
+		checksum_vals[2] = (u8) val;
+		data->checksum_ok
+			= (sht15_crc8(data, checksum_vals, 3) = dev_checksum);
+	}
+
 	/* Tell the device we are done */
 	sht15_end_transmission(data);
 
@@ -754,6 +906,8 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 	}
 	data->pdata = pdev->dev.platform_data;
 	data->supply_uV = data->pdata->supply_mv * 1000;
+	if (data->pdata->checksum)
+		data->checksumming = true;
 	if (data->pdata->no_otp_reload)
 		status |= SHT15_STATUS_NO_OTP_RELOAD;
 	if (data->pdata->low_resolution)
diff --git a/include/linux/sht15.h b/include/linux/sht15.h
index d836ca6..f85c7c5 100644
--- a/include/linux/sht15.h
+++ b/include/linux/sht15.h
@@ -19,6 +19,7 @@
  * @gpio_sck:		no. of gpio to which the data clock is connected.
  * @supply_mv:		supply voltage in mv. Overridden by regulator if
  *			available.
+ * @checksum:		flag to indicate the checksum should be validated.
  * @no_otp_reload:	flag to indicate no reload from OTP.
  * @low_resolution:	flag to indicate the temp/humidity resolution to use.
  */
@@ -26,6 +27,7 @@ struct sht15_platform_data {
 	int gpio_data;
 	int gpio_sck;
 	int supply_mv;
+	bool checksum;
 	bool no_otp_reload;
 	bool low_resolution;
 };
-- 
1.7.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
