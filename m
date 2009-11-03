From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Tue, 03 Nov 2009 12:09:43 +0000
Subject: [lm-sensors] [RFC PATCH 08/10] lis3: Sysfs entry for setting chip
Message-Id: <1257250185-7929-9-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It is possible to read position information at the chip measurement
rate via sysfs. This patch adds possibility to configure chip
measurement rate.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 48 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 5b39257..be2eb97 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -133,6 +133,37 @@ static int lis3lv02d_get_odr(void)
 	return val;
 }
 
+static int lis3lv02d_set_odr(int rate)
+{
+	u8 ctrl;
+	int i, len, shift;
+	int *rates;
+	int ret = -EINVAL;
+
+	lis3_dev.read(&lis3_dev, CTRL_REG1, &ctrl);
+
+	if (lis3_dev.whoami = WAI_12B) {
+		len = sizeof(lis3_12_rates);
+		rates = lis3_12_rates;
+		shift = 4;
+		ctrl &= ~(CTRL1_DF0 | CTRL1_DF1);
+	} else {
+		len = sizeof(lis3_8_rates);
+		rates = lis3_8_rates;
+		shift = 7;
+		ctrl &= ~CTRL1_DR;
+	}
+
+	for (i = 0; i < len; i++)
+		if (rates[i] = rate) {
+			lis3_dev.write(&lis3_dev,
+				CTRL_REG1, ctrl | (i << shift));
+			ret = 0;
+			break;
+		}
+	return ret;
+}
+
 static int lis3lv02d_selftest(struct lis3lv02d *lis3, s16 results[3])
 {
 	u8 reg;
@@ -427,9 +458,25 @@ static ssize_t lis3lv02d_rate_show(struct device *dev,
 	return sprintf(buf, "%d\n", lis3lv02d_get_odr());
 }
 
+static ssize_t lis3lv02d_rate_set(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	unsigned long rate;
+
+	if (strict_strtoul(buf, 0, &rate))
+		return -EINVAL;
+
+	if (lis3lv02d_set_odr(rate))
+		return -EINVAL;
+
+	return count;
+}
+
 static DEVICE_ATTR(selftest, S_IRUGO, lis3lv02d_selftest_show, NULL);
 static DEVICE_ATTR(position, S_IRUGO, lis3lv02d_position_show, NULL);
-static DEVICE_ATTR(rate, S_IRUGO, lis3lv02d_rate_show, NULL);
+static DEVICE_ATTR(rate, S_IRUGO | S_IWUSR, lis3lv02d_rate_show,
+					    lis3lv02d_rate_set);
 
 static struct attribute *lis3lv02d_attributes[] = {
 	&dev_attr_selftest.attr,
-- 
1.5.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
