From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:38 +0000
Subject: [lm-sensors] [PATCH] hwmon: it87 use u8 for vrm
Message-Id: <11365852581582@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: it87 use u8 for vrm

VRM values fit in u8 by design now.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit a7be58a126d4cd9f0588df23f58796ed996c1835
tree 26d0556bee4b8c241702fb9b49ea1936fc70ee4d
parent 734a12a36676ad3b9418fa5a829c518afec02b8a
author Jean Delvare <khali at linux-fr.org> Sun, 18 Dec 2005 16:40:14 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:26 -0800

 drivers/hwmon/it87.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 29b74a8..0da7c9c 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -213,7 +213,7 @@ struct it87_data {
 	u8 sensor;		/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
-	int vrm;
+	u8 vrm;
 	u32 alarms;		/* Register encoding, combined */
 	u8 fan_main_ctrl;	/* Register value */
 	u8 manual_pwm_ctl[3];   /* manual PWM value set by user */
@@ -669,7 +669,7 @@ static ssize_t
 show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf, "%ld\n", (long) data->vrm);
+	return sprintf(buf, "%u\n", data->vrm);
 }
 static ssize_t
 store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)


