From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 15:40:14 +0000
Subject: [lm-sensors] [PATCH 04/11] hwmon: it87 use u8 for vrm
Message-Id: <20051218164014.3ecbb76b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-it87-vrm-fits-in-u8.patch

VRM values fit in u8 by design now.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/it87.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc5.orig/drivers/hwmon/it87.c	2005-12-18 08:52:25.000000000 +0100
+++ linux-2.6.15-rc5/drivers/hwmon/it87.c	2005-12-18 09:56:43.000000000 +0100
@@ -213,7 +213,7 @@
 	u8 sensor;		/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
-	int vrm;
+	u8 vrm;
 	u32 alarms;		/* Register encoding, combined */
 	u8 fan_main_ctrl;	/* Register value */
 	u8 manual_pwm_ctl[3];   /* manual PWM value set by user */
@@ -669,7 +669,7 @@
 show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
+	return sprintf(buf, "%u\n", data->vrm);
 }
 static ssize_t
 store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)

-- 
Jean Delvare

