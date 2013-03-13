From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Mar 2013 23:58:39 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (pmbus/lm25066) Report VAUX as vmon
Message-Id: <1363219122-27226-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So far the driver reported the voltage on VAUX as "vout2". This was not
entirely appropriate as it is not an output voltage, and complicates
the code. Use the new virtual "VMON" register set and report the voltage
as "vmon" instead.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm25066   |   16 ++++-----
 drivers/hwmon/pmbus/lm25066.c |   73 ++++++++++++-----------------------------
 2 files changed, 29 insertions(+), 60 deletions(-)

diff --git a/Documentation/hwmon/lm25066 b/Documentation/hwmon/lm25066
index 26025e4..2bc5ba6 100644
--- a/Documentation/hwmon/lm25066
+++ b/Documentation/hwmon/lm25066
@@ -60,14 +60,14 @@ in1_max			Maximum input voltage.
 in1_min_alarm		Input voltage low alarm.
 in1_max_alarm		Input voltage high alarm.
 
-in2_label		"vout1"
-in2_input		Measured output voltage.
-in2_average		Average measured output voltage.
-in2_min			Minimum output voltage.
-in2_min_alarm		Output voltage low alarm.
-
-in3_label		"vout2"
-in3_input		Measured voltage on vaux pin
+in2_label		"vmon"
+in2_input		Measured voltage on VAUX pin
+
+in3_label		"vout1"
+in3_input		Measured output voltage.
+in3_average		Average measured output voltage.
+in3_min			Minimum output voltage.
+in3_min_alarm		Output voltage low alarm.
 
 curr1_label		"iin"
 curr1_input		Measured input current.
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index c299392..5489d70 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -2,6 +2,7 @@
  * Hardware monitoring driver for LM25066 / LM5064 / LM5066
  *
  * Copyright (c) 2011 Ericsson AB.
+ * Copyright (c) 2013 Guenter Roeck
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -56,42 +57,27 @@ static int lm25066_read_word_data(struct i2c_client *client, int page, int reg)
 	const struct lm25066_data *data = to_lm25066_data(info);
 	int ret;
 
-	if (page > 1)
-		return -ENXIO;
-
-	/* Map READ_VAUX into READ_VOUT register on page 1 */
-	if (page = 1) {
-		switch (reg) {
-		case PMBUS_READ_VOUT:
-			ret = pmbus_read_word_data(client, 0,
-						   LM25066_READ_VAUX);
-			if (ret < 0)
-				break;
-			/* Adjust returned value to match VOUT coefficients */
-			switch (data->id) {
-			case lm25066:
-				/* VOUT: 4.54 mV VAUX: 283.2 uV LSB */
-				ret = DIV_ROUND_CLOSEST(ret * 2832, 45400);
-				break;
-			case lm5064:
-				/* VOUT: 4.53 mV VAUX: 700 uV LSB */
-				ret = DIV_ROUND_CLOSEST(ret * 70, 453);
-				break;
-			case lm5066:
-				/* VOUT: 2.18 mV VAUX: 725 uV LSB */
-				ret = DIV_ROUND_CLOSEST(ret * 725, 2180);
-				break;
-			}
+	switch (reg) {
+	case PMBUS_VIRT_READ_VMON:
+		ret = pmbus_read_word_data(client, 0, LM25066_READ_VAUX);
+		if (ret < 0)
+			break;
+		/* Adjust returned value to match VIN coefficients */
+		switch (data->id) {
+		case lm25066:
+			/* VIN: 4.54 mV VAUX: 283.2 uV LSB */
+			ret = DIV_ROUND_CLOSEST(ret * 2832, 45400);
+			break;
+		case lm5064:
+			/* VIN: 4.53 mV VAUX: 700 uV LSB */
+			ret = DIV_ROUND_CLOSEST(ret * 70, 453);
 			break;
-		default:
-			/* No other valid registers on page 1 */
-			ret = -ENXIO;
+		case lm5066:
+			/* VIN: 2.18 mV VAUX: 725 uV LSB */
+			ret = DIV_ROUND_CLOSEST(ret * 725, 2180);
 			break;
 		}
-		goto done;
-	}
-
-	switch (reg) {
+		break;
 	case PMBUS_READ_IIN:
 		ret = pmbus_read_word_data(client, 0, LM25066_MFR_READ_IIN);
 		break;
@@ -128,7 +114,6 @@ static int lm25066_read_word_data(struct i2c_client *client, int page, int reg)
 		ret = -ENODATA;
 		break;
 	}
-done:
 	return ret;
 }
 
@@ -137,9 +122,6 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 {
 	int ret;
 
-	if (page > 1)
-		return -ENXIO;
-
 	switch (reg) {
 	case PMBUS_IIN_OC_WARN_LIMIT:
 		ret = pmbus_write_word_data(client, 0,
@@ -161,17 +143,6 @@ static int lm25066_write_word_data(struct i2c_client *client, int page, int reg,
 	return ret;
 }
 
-static int lm25066_write_byte(struct i2c_client *client, int page, u8 value)
-{
-	if (page > 1)
-		return -ENXIO;
-
-	if (page <= 0)
-		return pmbus_write_byte(client, page, value);
-
-	return 0;
-}
-
 static int lm25066_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -195,7 +166,7 @@ static int lm25066_probe(struct i2c_client *client,
 	data->id = id->driver_data;
 	info = &data->info;
 
-	info->pages = 2;
+	info->pages = 1;
 	info->format[PSC_VOLTAGE_IN] = direct;
 	info->format[PSC_VOLTAGE_OUT] = direct;
 	info->format[PSC_CURRENT_IN] = direct;
@@ -206,14 +177,12 @@ static int lm25066_probe(struct i2c_client *client,
 	info->b[PSC_TEMPERATURE] = 0;
 	info->R[PSC_TEMPERATURE] = 0;
 
-	info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT
+	info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VMON | PMBUS_HAVE_VOUT
 	  | PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_PIN | PMBUS_HAVE_IIN
 	  | PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
-	info->func[1] = PMBUS_HAVE_VOUT;
 
 	info->read_word_data = lm25066_read_word_data;
 	info->write_word_data = lm25066_write_word_data;
-	info->write_byte = lm25066_write_byte;
 
 	switch (id->driver_data) {
 	case lm25066:
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
