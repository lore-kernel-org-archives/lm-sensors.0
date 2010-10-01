From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Fri, 01 Oct 2010 11:46:53 +0000
Subject: [lm-sensors] [RFC PATCH 6/9] hwmon: lis3: New parameters to
Message-Id: <1285933616-16044-7-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel@tremplin-utc.net, khali@linux-fr.org, guenter.roeck@ericsson.com, kuninori.morimoto.gx@renesas.com
Cc: linux-i2c@vger.kernel.org, lm-sensors@lm-sensors.org

Added control for duration via platform data.
Added possibility to configure interrupts to trig on
both rising and falling edge. The lis3 WU unit can be
configured quite many ways and with some configurations it
is quite handy to get coordinate refresh when some
event trigs and when it reason goes away.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d.c |   21 ++++++++++++++-------
 include/linux/lis3lv02d.h |    7 ++++++-
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 81e2313..0a46a0e 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -681,6 +681,7 @@ static void lis3lv02d_8b_configure(struct lis3lv02d *dev,
 {
 	int err;
 	int ctrl2 = p->hipass_ctrl;
+	int irq_flags = IRQF_TRIGGER_RISING | IRQF_ONESHOT;
 
 	if (p->click_flags) {
 		dev->write(dev, CLICK_CFG, p->click_flags);
@@ -703,27 +704,29 @@ static void lis3lv02d_8b_configure(struct lis3lv02d *dev,
 	if (p->wakeup_flags) {
 		dev->write(dev, FF_WU_CFG_1, p->wakeup_flags);
 		dev->write(dev, FF_WU_THS_1, p->wakeup_thresh & 0x7f);
-		/* default to 2.5ms for now */
-		dev->write(dev, FF_WU_DURATION_1, 1);
+		/* pdata value + 1 to keep this backward compatible*/
+		dev->write(dev, FF_WU_DURATION_1, p->duration1 + 1);
 		ctrl2 ^= HP_FF_WU1; /* Xor to keep compatible with old pdata*/
 	}
 
 	if (p->wakeup_flags2) {
 		dev->write(dev, FF_WU_CFG_2, p->wakeup_flags2);
 		dev->write(dev, FF_WU_THS_2, p->wakeup_thresh2 & 0x7f);
-		/* default to 2.5ms for now */
-		dev->write(dev, FF_WU_DURATION_2, 1);
+		/* pdata value + 1 to keep this backward compatible*/
+		dev->write(dev, FF_WU_DURATION_2, p->duration2 + 1);
 		ctrl2 ^= HP_FF_WU2; /* Xor to keep compatible with old pdata*/
 	}
 	/* Configure hipass filters */
 	dev->write(dev, CTRL_REG2, ctrl2);
 
+	if (p->irq_flags & LIS3_IRQ2_USE_BOTH_EDGES)
+		irq_flags |= IRQF_TRIGGER_FALLING;
+
 	if (p->irq2) {
 		err = request_threaded_irq(p->irq2,
 					NULL,
 					lis302dl_interrupt_thread2_8b,
-					IRQF_TRIGGER_RISING |
-					IRQF_ONESHOT,
+					irq_flags,
 					DRIVER_NAME, &lis3_dev);
 		if (err < 0)
 			printk(KERN_ERR DRIVER_NAME
@@ -739,6 +742,7 @@ int lis3lv02d_init_device(struct lis3lv02d *dev)
 {
 	int err;
 	irq_handler_t thread_fn;
+	int irq_flags = IRQF_TRIGGER_RISING | IRQF_ONESHOT;
 
 	dev->whoami = lis3lv02d_read_8(dev, WHO_AM_I);
 
@@ -799,6 +803,9 @@ int lis3lv02d_init_device(struct lis3lv02d *dev)
 		if (dev->whoami = WAI_8B)
 			lis3lv02d_8b_configure(dev, p);
 
+		if (dev->pdata->irq_flags & LIS3_IRQ1_USE_BOTH_EDGES)
+			irq_flags |= IRQF_TRIGGER_FALLING;
+
 		dev->irq_cfg = p->irq_cfg;
 		if (p->irq_cfg)
 			dev->write(dev, CTRL_REG3, p->irq_cfg);
@@ -829,7 +836,7 @@ int lis3lv02d_init_device(struct lis3lv02d *dev)
 
 	err = request_threaded_irq(dev->irq, lis302dl_interrupt,
 				thread_fn,
-				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				irq_flags,
 				DRIVER_NAME, &lis3_dev);
 
 	if (err < 0) {
diff --git a/include/linux/lis3lv02d.h b/include/linux/lis3lv02d.h
index 0e8a346..167f947 100644
--- a/include/linux/lis3lv02d.h
+++ b/include/linux/lis3lv02d.h
@@ -36,13 +36,18 @@ struct lis3lv02d_platform_data {
 #define LIS3_IRQ_OPEN_DRAIN	(1 << 6)
 #define LIS3_IRQ_ACTIVE_LOW	(1 << 7)
 	unsigned char irq_cfg;
-
+#define LIS3_IRQ1_USE_BOTH_EDGES 1
+#define LIS3_IRQ2_USE_BOTH_EDGES 2
+	unsigned char irq_flags;
+	unsigned char duration1;
+	unsigned char duration2;
 #define LIS3_WAKEUP_X_LO	(1 << 0)
 #define LIS3_WAKEUP_X_HI	(1 << 1)
 #define LIS3_WAKEUP_Y_LO	(1 << 2)
 #define LIS3_WAKEUP_Y_HI	(1 << 3)
 #define LIS3_WAKEUP_Z_LO	(1 << 4)
 #define LIS3_WAKEUP_Z_HI	(1 << 5)
+#define LIS3_WAKEUP_AOI		(1 << 7) /* 'AND' combination of interrupts */
 	unsigned char wakeup_flags;
 	unsigned char wakeup_thresh;
 	unsigned char wakeup_flags2;
-- 
1.6.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
