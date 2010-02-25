From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 25 Feb 2010 08:02:43 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (it87) Validate auto pwm settings
Message-Id: <20100225090243.2d5b7cd8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Before switching to automatic fan control mode, make sure that all the
trip points make sense. Otherwise, the control loop could lead to
weird fan behavior.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/it87 |    4 ++++
 drivers/hwmon/it87.c     |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

--- linux-2.6.33-rc8.orig/Documentation/hwmon/it87	2010-02-22 08:38:21.000000000 +0100
+++ linux-2.6.33-rc8/Documentation/hwmon/it87	2010-02-22 11:33:48.000000000 +0100
@@ -177,3 +177,7 @@ between trip point N and trip point N+1
 the one of trip point N. The automatic control mode is less flexible
 than the manual control mode, but it reacts faster, is more robust and
 doesn't use CPU cycles.
+
+Trip points must be set properly before switching to automatic fan speed
+control mode. The driver will perform basic integrity checks before
+actually switching to automatic control mode.
--- linux-2.6.33-rc8.orig/drivers/hwmon/it87.c	2010-02-22 11:09:33.000000000 +0100
+++ linux-2.6.33-rc8/drivers/hwmon/it87.c	2010-02-23 21:31:57.000000000 +0100
@@ -719,6 +719,32 @@ static ssize_t set_fan_div(struct device
 	mutex_unlock(&data->update_lock);
 	return count;
 }
+
+/* Returns 0 if OK, -EINVAL otherwise */
+static int check_trip_points(struct device *dev, int nr)
+{
+	const struct it87_data *data = dev_get_drvdata(dev);
+	int i, err = 0;
+
+	if (has_old_autopwm(data)) {
+		for (i = 0; i < 3; i++) {
+			if (data->auto_temp[nr][i] > data->auto_temp[nr][i + 1])
+				err = -EINVAL;
+		}
+		for (i = 0; i < 2; i++) {
+			if (data->auto_pwm[nr][i] > data->auto_pwm[nr][i + 1])
+				err = -EINVAL;
+		}
+	}
+
+	if (err) {
+		dev_err(dev, "Inconsistent trip points, not switching to "
+			"automatic mode\n");
+		dev_err(dev, "Adjust the trip points and try again\n");
+	}
+	return err;
+}
+
 static ssize_t set_pwm_enable(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -731,6 +757,12 @@ static ssize_t set_pwm_enable(struct dev
 	if (strict_strtol(buf, 10, &val) < 0 || val < 0 || val > 2)
 		return -EINVAL;
 
+	/* Check trip points before switching to automatic mode */
+	if (val = 2) {
+		if (check_trip_points(dev, nr) < 0)
+			return -EINVAL;
+	}
+
 	mutex_lock(&data->update_lock);
 
 	if (val = 0) {

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
