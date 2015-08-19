From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Aug 2015 16:06:14 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (ltc2978) Add polling for chips requiring it
Message-Id: <1440000375-3036-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Michael Jones <mike@proclivis.com>

Some of the LTC chips supported by this driver have to be polled
to ensure that they are ready to accept commands.

Signed-off-by: Michael Jones <mike@proclivis.com>
[Guenter Roeck: simplifications and formatting changes]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/ltc2978.c | 111 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 101 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 60fe8f9839d3..f1c69c9de849 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2011 Ericsson AB.
  * Copyright (c) 2013, 2014, 2015 Guenter Roeck
+ * Copyright (c) 2015 Linear Technology
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -15,6 +16,8 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -32,6 +35,7 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
 #define LTC2978_MFR_VIN_PEAK		0xde
 #define LTC2978_MFR_TEMPERATURE_PEAK	0xdf
 #define LTC2978_MFR_SPECIAL_ID		0xe7	/* Undocumented on LTC3882 */
+#define LTC2978_MFR_COMMON		0xef
 
 /* LTC2974, LTC2975, LCT2977, LTC2980, LTC2978, and LTM2987 */
 #define LTC2978_MFR_VOUT_MIN		0xfb
@@ -82,6 +86,11 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
 #define LTC3880_NUM_PAGES		2
 #define LTC3883_NUM_PAGES		1
 
+#define LTC_POLL_TIMEOUT		100	/* in milli-seconds */
+
+#define LTC_NOT_BUSY			BIT(5)
+#define LTC_NOT_PENDING			BIT(4)
+
 /*
  * LTC2978 clears peak data whenever the CLEAR_FAULTS command is executed, which
  * happens pretty much each time chip data is updated. Raw peak data therefore
@@ -105,8 +114,81 @@ struct ltc2978_data {
 #define to_ltc2978_data(x)  container_of(x, struct ltc2978_data, info)
 
 #define FEAT_CLEAR_PEAKS	BIT(0)
+#define FEAT_NEEDS_POLLING	BIT(1)
 
 #define has_clear_peaks(d)	((d)->features & FEAT_CLEAR_PEAKS)
+#define needs_polling(d)	((d)->features & FEAT_NEEDS_POLLING)
+
+static int ltc_wait_ready(struct i2c_client *client)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(LTC_POLL_TIMEOUT);
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct ltc2978_data *data = to_ltc2978_data(info);
+	int status;
+	u8 mask;
+
+	if (!needs_polling(data))
+		return 0;
+
+	/*
+	 * LTC3883 does not support LTC_NOT_PENDING, even though
+	 * the datasheet claims that it does.
+	 */
+	mask = LTC_NOT_BUSY;
+	if (data->id != ltc3883)
+		mask |= LTC_NOT_PENDING;
+
+	do {
+		status = pmbus_read_byte_data(client, 0, LTC2978_MFR_COMMON);
+		if (status = -EBADMSG || status = -ENXIO) {
+			/* PEC error or NACK: chip may be busy, try again */
+			usleep_range(50, 100);
+			continue;
+		}
+		if (status < 0)
+			return status;
+
+		if ((status & mask) = mask)
+			return 0;
+
+		usleep_range(50, 100);
+	} while (time_before(jiffies, timeout));
+
+	return -ETIMEDOUT;
+}
+
+static int ltc_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	ret = ltc_wait_ready(client);
+	if (ret < 0)
+		return ret;
+
+	return pmbus_read_word_data(client, page, reg);
+}
+
+static int ltc_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	ret = ltc_wait_ready(client);
+	if (ret < 0)
+		return ret;
+
+	return pmbus_read_byte_data(client, page, reg);
+}
+
+static int ltc_write_byte(struct i2c_client *client, int page, u8 byte)
+{
+	int ret;
+
+	ret = ltc_wait_ready(client);
+	if (ret < 0)
+		return ret;
+
+	return pmbus_write_byte(client, page, byte);
+}
 
 static inline int lin11_to_val(int data)
 {
@@ -126,7 +208,7 @@ static int ltc_get_max(struct ltc2978_data *data, struct i2c_client *client,
 {
 	int ret;
 
-	ret = pmbus_read_word_data(client, page, reg);
+	ret = ltc_read_word_data(client, page, reg);
 	if (ret >= 0) {
 		if (lin11_to_val(ret) > lin11_to_val(*pmax))
 			*pmax = ret;
@@ -140,7 +222,7 @@ static int ltc_get_min(struct ltc2978_data *data, struct i2c_client *client,
 {
 	int ret;
 
-	ret = pmbus_read_word_data(client, page, reg);
+	ret = ltc_read_word_data(client, page, reg);
 	if (ret >= 0) {
 		if (lin11_to_val(ret) < lin11_to_val(*pmin))
 			*pmin = ret;
@@ -162,7 +244,7 @@ static int ltc2978_read_word_data_common(struct i2c_client *client, int page,
 				  &data->vin_max);
 		break;
 	case PMBUS_VIRT_READ_VOUT_MAX:
-		ret = pmbus_read_word_data(client, page, LTC2978_MFR_VOUT_PEAK);
+		ret = ltc_read_word_data(client, page, LTC2978_MFR_VOUT_PEAK);
 		if (ret >= 0) {
 			/*
 			 * VOUT is 16 bit unsigned with fixed exponent,
@@ -184,6 +266,9 @@ static int ltc2978_read_word_data_common(struct i2c_client *client, int page,
 		ret = 0;
 		break;
 	default:
+		ret = ltc_wait_ready(client);
+		if (ret < 0)
+			return ret;
 		ret = -ENODATA;
 		break;
 	}
@@ -202,7 +287,7 @@ static int ltc2978_read_word_data(struct i2c_client *client, int page, int reg)
 				  &data->vin_min);
 		break;
 	case PMBUS_VIRT_READ_VOUT_MIN:
-		ret = pmbus_read_word_data(client, page, LTC2978_MFR_VOUT_MIN);
+		ret = ltc_read_word_data(client, page, LTC2978_MFR_VOUT_MIN);
 		if (ret >= 0) {
 			/*
 			 * VOUT_MIN is known to not be supported on some lots
@@ -353,9 +438,9 @@ static int ltc2978_clear_peaks(struct ltc2978_data *data,
 	int ret;
 
 	if (has_clear_peaks(data))
-		ret = pmbus_write_byte(client, 0, LTC3880_MFR_CLEAR_PEAKS);
+		ret = ltc_write_byte(client, 0, LTC3880_MFR_CLEAR_PEAKS);
 	else
-		ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
+		ret = ltc_write_byte(client, page, PMBUS_CLEAR_FAULTS);
 
 	return ret;
 }
@@ -403,6 +488,9 @@ static int ltc2978_write_word_data(struct i2c_client *client, int page,
 		ret = ltc2978_clear_peaks(data, client, page);
 		break;
 	default:
+		ret = ltc_wait_ready(client);
+		if (ret < 0)
+			return ret;
 		ret = -ENODATA;
 		break;
 	}
@@ -530,6 +618,9 @@ static int ltc2978_probe(struct i2c_client *client,
 
 	info = &data->info;
 	info->write_word_data = ltc2978_write_word_data;
+	info->write_byte = ltc_write_byte;
+	info->read_word_data = ltc_read_word_data;
+	info->read_byte_data = ltc_read_byte_data;
 
 	data->vin_min = 0x7bff;
 	data->vin_max = 0x7c00;
@@ -588,7 +679,7 @@ static int ltc2978_probe(struct i2c_client *client,
 	case ltc3880:
 	case ltc3887:
 	case ltm4676:
-		data->features |= FEAT_CLEAR_PEAKS;
+		data->features |= FEAT_CLEAR_PEAKS | FEAT_NEEDS_POLLING;
 		info->read_word_data = ltc3880_read_word_data;
 		info->pages = LTC3880_NUM_PAGES;
 		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
@@ -603,7 +694,7 @@ static int ltc2978_probe(struct i2c_client *client,
 		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 		break;
 	case ltc3882:
-		data->features |= FEAT_CLEAR_PEAKS;
+		data->features |= FEAT_CLEAR_PEAKS | FEAT_NEEDS_POLLING;
 		info->read_word_data = ltc3880_read_word_data;
 		info->pages = LTC3880_NUM_PAGES;
 		info->func[0] = PMBUS_HAVE_VIN
@@ -618,7 +709,7 @@ static int ltc2978_probe(struct i2c_client *client,
 		  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
 		break;
 	case ltc3883:
-		data->features |= FEAT_CLEAR_PEAKS;
+		data->features |= FEAT_CLEAR_PEAKS | FEAT_NEEDS_POLLING;
 		info->read_word_data = ltc3883_read_word_data;
 		info->pages = LTC3883_NUM_PAGES;
 		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
@@ -629,7 +720,7 @@ static int ltc2978_probe(struct i2c_client *client,
 		  | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
 		break;
 	case ltc3886:
-		data->features |= FEAT_CLEAR_PEAKS;
+		data->features |= FEAT_CLEAR_PEAKS | FEAT_NEEDS_POLLING;
 		info->read_word_data = ltc3883_read_word_data;
 		info->pages = LTC3880_NUM_PAGES;
 		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
