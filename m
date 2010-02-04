From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Thu, 04 Feb 2010 08:24:04 +0000
Subject: [lm-sensors] [PATCH 2/6] lis3: Separate configuration function for
Message-Id: <1265271848-26559-3-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1265271848-26559-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1265271848-26559-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel@tremplin-utc.net
Cc: pavel@ucw.cz, daniel@caiaq.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Separate configuration function for 8 bit version of the chip.
This way generic part of the init function stays little bit
more readable.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d.c |   45 ++++++++++++++++++++++++++-------------------
 1 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index b2f2277..99fd45d 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -521,6 +521,30 @@ int lis3lv02d_remove_fs(struct lis3lv02d *lis3)
 }
 EXPORT_SYMBOL_GPL(lis3lv02d_remove_fs);
 
+static void lis3lv02d_8b_configure(struct lis3lv02d *dev,
+				struct lis3lv02d_platform_data *p)
+{
+	if (p->click_flags) {
+		dev->write(dev, CLICK_CFG, p->click_flags);
+		dev->write(dev, CLICK_TIMELIMIT, p->click_time_limit);
+		dev->write(dev, CLICK_LATENCY, p->click_latency);
+		dev->write(dev, CLICK_WINDOW, p->click_window);
+		dev->write(dev, CLICK_THSZ, p->click_thresh_z & 0xf);
+		dev->write(dev, CLICK_THSY_X,
+			(p->click_thresh_x & 0xf) |
+			(p->click_thresh_y << 4));
+	}
+
+	if (p->wakeup_flags) {
+		dev->write(dev, FF_WU_CFG_1, p->wakeup_flags);
+		dev->write(dev, FF_WU_THS_1, p->wakeup_thresh & 0x7f);
+		/* default to 2.5ms for now */
+		dev->write(dev, FF_WU_DURATION_1, 1);
+		/* enable high pass filter for both free-fall units */
+		dev->write(dev, CTRL_REG2, HP_FF_WU1 | HP_FF_WU2);
+	}
+}
+
 /*
  * Initialise the accelerometer and the various subsystems.
  * Should be rather independent of the bus system.
@@ -567,25 +591,8 @@ int lis3lv02d_init_device(struct lis3lv02d *dev)
 	if (dev->pdata) {
 		struct lis3lv02d_platform_data *p = dev->pdata;
 
-		if (p->click_flags && (dev->whoami = WAI_8B)) {
-			dev->write(dev, CLICK_CFG, p->click_flags);
-			dev->write(dev, CLICK_TIMELIMIT, p->click_time_limit);
-			dev->write(dev, CLICK_LATENCY, p->click_latency);
-			dev->write(dev, CLICK_WINDOW, p->click_window);
-			dev->write(dev, CLICK_THSZ, p->click_thresh_z & 0xf);
-			dev->write(dev, CLICK_THSY_X,
-					(p->click_thresh_x & 0xf) |
-					(p->click_thresh_y << 4));
-		}
-
-		if (p->wakeup_flags && (dev->whoami = WAI_8B)) {
-			dev->write(dev, FF_WU_CFG_1, p->wakeup_flags);
-			dev->write(dev, FF_WU_THS_1, p->wakeup_thresh & 0x7f);
-			/* default to 2.5ms for now */
-			dev->write(dev, FF_WU_DURATION_1, 1);
-			/* enable high pass filter for both free-fall units */
-			dev->write(dev, CTRL_REG2, HP_FF_WU1 | HP_FF_WU2);
-		}
+		if (dev->whoami = WAI_8B)
+			lis3lv02d_8b_configure(dev, p);
 
 		if (p->irq_cfg)
 			dev->write(dev, CTRL_REG3, p->irq_cfg);
-- 
1.6.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
