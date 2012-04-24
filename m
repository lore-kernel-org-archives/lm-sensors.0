From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Apr 2012 03:36:56 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (ntc_thermistor) Optimize and fix build warning
Message-Id: <1335238619-25745-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following build warning is seen in some configurations:

drivers/hwmon/ntc_thermistor.c: In function 'ntc_show_temp':
drivers/hwmon/ntc_thermistor.c:293: warning: 'temp' may be used uninitialized in this function

Fix the problem by re-arranging the code to overload return values with error
codes, and by avoiding error returns whenever possible.

Specifically,

Simplify lookup_comp() to not return an error. Instead, return i_low = i_high
if there is an exact match, or if the ohm value is outside the lookup table
range.

Modify get_temp_mC() to not return an error. Since it only returns an error
after lookup_comp() returned an error, this is quite straightforward after above
change.

Separate ntc_thermistor_read() into a function to read the resistor value (which
can return an error), and the call to get_temp_mC() which doesn't. Call the
functions directly from ntc_show_temp().

Code was tested using a test program, comparing the result of the old and new
versions of get_temp_mC() for resistor values between 0 and 2,000,000 ohm.

As a side effect, this patch reduces code size by approximately 400 bytes on
x86_64.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Donggeun Kim <dg77.kim@samsung.com>
---
 drivers/hwmon/ntc_thermistor.c |  164 +++++++++++++++++++--------------------
 1 files changed, 80 insertions(+), 84 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 9b382ec..d06e354 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -134,8 +134,7 @@ static inline u64 div64_u64_safe(u64 dividend, u64 divisor)
 	return div64_u64(dividend, divisor);
 }
 
-static unsigned int get_ohm_of_thermistor(struct ntc_data *data,
-		unsigned int uV)
+static int get_ohm_of_thermistor(struct ntc_data *data, unsigned int uV)
 {
 	struct ntc_thermistor_platform_data *pdata = data->pdata;
 	u64 mV = uV / 1000;
@@ -146,12 +145,12 @@ static unsigned int get_ohm_of_thermistor(struct ntc_data *data,
 
 	if (mV = 0) {
 		if (pdata->connect = NTC_CONNECTED_POSITIVE)
-			return UINT_MAX;
+			return INT_MAX;
 		return 0;
 	}
 	if (mV >= pmV)
 		return (pdata->connect = NTC_CONNECTED_POSITIVE) ?
-			0 : UINT_MAX;
+			0 : INT_MAX;
 
 	if (pdata->connect = NTC_CONNECTED_POSITIVE && puO = 0)
 		N = div64_u64_safe(pdO * (pmV - mV), mV);
@@ -163,113 +162,109 @@ static unsigned int get_ohm_of_thermistor(struct ntc_data *data,
 	else
 		N = div64_u64_safe(pdO * puO * mV, pdO * (pmV - mV) - puO * mV);
 
-	return (unsigned int) N;
+	if (N > INT_MAX)
+		N = INT_MAX;
+	return N;
 }
 
-static int lookup_comp(struct ntc_data *data,
-		unsigned int ohm, int *i_low, int *i_high)
+static void lookup_comp(struct ntc_data *data, unsigned int ohm,
+			int *i_low, int *i_high)
 {
-	int start, end, mid = -1;
+	int start, end, mid;
+
+	/*
+	 * Handle special cases: Resistance is higher than or equal to
+	 * resistance in first table entry, or resistance is lower or equal
+	 * to resistance in last table entry.
+	 * In these cases, return i_low = i_high, either pointing to the
+	 * beginning or to the end of the table depending on the condition.
+	 */
+	if (ohm >= data->comp[0].ohm) {
+		*i_low = 0;
+		*i_high = 0;
+		return;
+	}
+	if (ohm <= data->comp[data->n_comp - 1].ohm) {
+		*i_low = data->n_comp - 1;
+		*i_high = data->n_comp - 1;
+		return;
+	}
 
 	/* Do a binary search on compensation table */
 	start = 0;
 	end = data->n_comp;
-
-	while (end > start) {
+	while (start < end) {
 		mid = start + (end - start) / 2;
-		if (data->comp[mid].ohm < ohm)
+		/*
+		 * start <= mid < end
+		 * data->comp[start].ohm > ohm >= data->comp[end].ohm
+		 *
+		 * We could check for "ohm = data->comp[mid].ohm" here, but
+		 * that is a quite unlikely condition, and we would have to
+		 * check again after updating start. Check it at the end instead
+		 * for simplicity.
+		 */
+		if (ohm >= data->comp[mid].ohm) {
 			end = mid;
-		else if (data->comp[mid].ohm > ohm)
-			start = mid + 1;
-		else
-			break;
-	}
-
-	if (mid = 0) {
-		if (data->comp[mid].ohm > ohm) {
-			*i_high = mid;
-			*i_low = mid + 1;
-			return 0;
-		} else {
-			*i_low = mid;
-			*i_high = -1;
-			return -EINVAL;
-		}
-	}
-	if (mid = (data->n_comp - 1)) {
-		if (data->comp[mid].ohm <= ohm) {
-			*i_low = mid;
-			*i_high = mid - 1;
-			return 0;
 		} else {
-			*i_low = -1;
-			*i_high = mid;
-			return -EINVAL;
+			start = mid + 1;
+			/*
+			 * ohm >= data->comp[start].ohm might be true here,
+			 * since we set start to mid + 1. In that case, we are
+			 * done. We could keep going, but the condition is quite
+			 * likely to occur, so it is worth checking for it.
+			 */
+			if (ohm >= data->comp[start].ohm)
+				end = start;
 		}
+		/*
+		 * start <= end
+		 * data->comp[start].ohm >= ohm >= data->comp[end].ohm
+		 */
 	}
-
-	if (data->comp[mid].ohm <= ohm) {
-		*i_low = mid;
-		*i_high = mid - 1;
-	} else {
-		*i_low = mid + 1;
-		*i_high = mid;
-	}
-
-	return 0;
+	/*
+	 * start = end
+	 * ohm >= data->comp[end].ohm
+	 */
+	*i_low = end;
+	if (ohm = data->comp[end].ohm)
+		*i_high = end;
+	else
+		*i_high = end - 1;
 }
 
-static int get_temp_mC(struct ntc_data *data, unsigned int ohm, int *temp)
+static int get_temp_mC(struct ntc_data *data, unsigned int ohm)
 {
 	int low, high;
-	int ret;
+	int temp;
 
-	ret = lookup_comp(data, ohm, &low, &high);
-	if (ret) {
+	lookup_comp(data, ohm, &low, &high);
+	if (low = high) {
 		/* Unable to use linear approximation */
-		if (low != -1)
-			*temp = data->comp[low].temp_C * 1000;
-		else if (high != -1)
-			*temp = data->comp[high].temp_C * 1000;
-		else
-			return ret;
+		temp = data->comp[low].temp_C * 1000;
 	} else {
-		*temp = data->comp[low].temp_C * 1000 +
+		temp = data->comp[low].temp_C * 1000 +
 			((data->comp[high].temp_C - data->comp[low].temp_C) *
 			 1000 * ((int)ohm - (int)data->comp[low].ohm)) /
 			((int)data->comp[high].ohm - (int)data->comp[low].ohm);
 	}
-
-	return 0;
+	return temp;
 }
 
-static int ntc_thermistor_read(struct ntc_data *data, int *temp)
+static int ntc_thermistor_get_ohm(struct ntc_data *data)
 {
-	int ret;
-	int read_ohm, read_uV;
-	unsigned int ohm = 0;
-
-	if (data->pdata->read_ohm) {
-		read_ohm = data->pdata->read_ohm();
-		if (read_ohm < 0)
-			return read_ohm;
-		ohm = (unsigned int)read_ohm;
-	}
+	int read_uV;
+
+	if (data->pdata->read_ohm)
+		return data->pdata->read_ohm();
 
 	if (data->pdata->read_uV) {
 		read_uV = data->pdata->read_uV();
 		if (read_uV < 0)
 			return read_uV;
-		ohm = get_ohm_of_thermistor(data, (unsigned int)read_uV);
+		return get_ohm_of_thermistor(data, read_uV);
 	}
-
-	ret = get_temp_mC(data, ohm, temp);
-	if (ret) {
-		dev_dbg(data->dev, "Sensor reading function not available.\n");
-		return ret;
-	}
-
-	return 0;
+	return -EINVAL;
 }
 
 static ssize_t ntc_show_name(struct device *dev,
@@ -290,12 +285,13 @@ static ssize_t ntc_show_temp(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct ntc_data *data = dev_get_drvdata(dev);
-	int temp, ret;
+	int ohm;
+
+	ohm = ntc_thermistor_get_ohm(data);
+	if (ohm < 0)
+		return ohm;
 
-	ret = ntc_thermistor_read(data, &temp);
-	if (ret)
-		return ret;
-	return sprintf(buf, "%d\n", temp);
+	return sprintf(buf, "%d\n", get_temp_mC(data, ohm));
 }
 
 static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, ntc_show_type, NULL, 0);
-- 
1.7.9.48.g85da4d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
