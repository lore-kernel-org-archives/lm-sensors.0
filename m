From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 03 Dec 2007 22:23:21 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (lm85) Return standard values in
Message-Id: <20071203232321.0c9f38ff@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The values returned by the lm85 driver in pwmN_enable sysfs files do
not match the standard. Fix that.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- linux-2.6.24-rc3.orig/drivers/hwmon/lm85.c	2007-12-03 17:34:54.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/lm85.c	2007-12-03 18:02:57.000000000 +0100
@@ -515,10 +515,21 @@ static ssize_t show_pwm_enable(struct de
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	int	pwm_zone;
+	int pwm_zone, enable;
 
 	pwm_zone = ZONE_FROM_REG(data->autofan[nr].config);
-	return sprintf(buf,"%d\n", (pwm_zone != 0 && pwm_zone != -1) );
+	switch (pwm_zone) {
+	case -1:	/* PWM is always at 100% */
+		enable = 0;
+		break;
+	case 0:		/* PWM is always at 0% */
+	case -2:	/* PWM responds to manual control */
+		enable = 1;
+		break;
+	default:	/* PWM in automatic mode */
+		enable = 2;
+	}
+	return sprintf(buf, "%d\n", enable);
 }
 
 #define show_pwm_reg(offset)						\


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
