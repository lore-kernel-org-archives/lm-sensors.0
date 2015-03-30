From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Mar 2015 06:33:41 +0000
Subject: [lm-sensors] [PATCH 01/15] hwmon: (it87) Fix pwm frequency display for chips with newer pwm control
Message-Id: <1427697235-23566-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On chips with newer pwm control, the pwm frequency divider is 256
instead of 128. Since the base pwm frequency remained the same, the actual
pwm frequency is half of what it used to be with the older pwm control
mechanism.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index ab12dc2eb896..7ab5bd026e91 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -502,15 +502,25 @@ static int DIV_TO_REG(int val)
 }
 #define DIV_FROM_REG(val) (1 << (val))
 
+/*
+ * pwm base frequencies. The frequency has to be divided by either 128 or 256,
+ * depending on the chip type, to calculate the actual pwm frequency.
+ *
+ * Some of the chip datasheets suggest a base frequency of 51kHz instead
+ * of 750kHz for the slowest base frequency, resulting in a pwm frequency
+ * of 200Hz. Sometimes both pwm frequency select registers are affected,
+ * sometimes just one. It is unknown if this is a datasheet error or real,
+ * so this is ignored for now.
+ */
 static const unsigned int pwm_freq[8] = {
-	48000000 / 128,
-	24000000 / 128,
-	12000000 / 128,
-	8000000 / 128,
-	6000000 / 128,
-	3000000 / 128,
-	1500000 / 128,
-	750000 / 128,
+	48000000,
+	24000000,
+	12000000,
+	8000000,
+	6000000,
+	3000000,
+	1500000,
+	750000,
 };
 
 static int it87_probe(struct platform_device *pdev);
@@ -828,8 +838,11 @@ static ssize_t show_pwm_freq(struct device *dev, struct device_attribute *attr,
 {
 	struct it87_data *data = it87_update_device(dev);
 	int index = (data->fan_ctl >> 4) & 0x07;
+	unsigned int freq;
 
-	return sprintf(buf, "%u\n", pwm_freq[index]);
+	freq = pwm_freq[index] / has_newer_autopwm(data) ? 256 : 128;
+
+	return sprintf(buf, "%u\n", freq);
 }
 
 static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
@@ -1051,6 +1064,9 @@ static ssize_t set_pwm_freq(struct device *dev,
 	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
+	val = clamp_val(val, 0, 1000000);
+	val *= has_newer_autopwm(data) ? 256 : 128;
+
 	/* Search for the nearest available frequency */
 	for (i = 0; i < 7; i++) {
 		if (val > (pwm_freq[i] + pwm_freq[i+1]) / 2)
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
