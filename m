From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Fri, 01 Oct 2010 11:46:50 +0000
Subject: [lm-sensors] [RFC PATCH 3/9] hwmon: lis3: Cleanup interrupt handling
Message-Id: <1285933616-16044-4-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1285933616-16044-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Irqcfg moved to chip data instead of platform data.
This simplifies access in interrupt handler little bit.

Input device open and close functions set status for
interrupt threaded handler once.

Unnecessary check for interrupt source removed since
it is enough that active interrupt line indicates that
there was an interrupt.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d.c |   37 +++++++++++++------------------------
 drivers/hwmon/lis3lv02d.h |    2 ++
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 23d47ad..483204a 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -308,10 +308,14 @@ static void lis3lv02d_joystick_open(struct input_polled_dev *pidev)
 {
 	if (lis3_dev.pm_dev)
 		pm_runtime_get_sync(lis3_dev.pm_dev);
+
+	if (lis3_dev.pdata && lis3_dev.whoami = WAI_8B && lis3_dev.idev)
+		atomic_set(&lis3_dev.wake_thread, 1);
 }
 
 static void lis3lv02d_joystick_close(struct input_polled_dev *pidev)
 {
+	atomic_set(&lis3_dev.wake_thread, 0);
 	if (lis3_dev.pm_dev)
 		pm_runtime_put(lis3_dev.pm_dev);
 }
@@ -331,8 +335,7 @@ static irqreturn_t lis302dl_interrupt(int irq, void *dummy)
 	wake_up_interruptible(&lis3_dev.misc_wait);
 	kill_fasync(&lis3_dev.async_queue, SIGIO, POLL_IN);
 out:
-	if (lis3_dev.pdata && lis3_dev.whoami = WAI_8B && lis3_dev.idev &&
-	    lis3_dev.idev->input->users)
+	if (atomic_read(&lis3_dev.wake_thread))
 		return IRQ_WAKE_THREAD;
 	return IRQ_HANDLED;
 }
@@ -363,31 +366,15 @@ static void lis302dl_interrupt_handle_click(struct lis3lv02d *lis3)
 	mutex_unlock(&lis3->mutex);
 }
 
-static void lis302dl_interrupt_handle_ff_wu(struct lis3lv02d *lis3)
-{
-	u8 wu1_src;
-	u8 wu2_src;
-
-	lis3->read(lis3, FF_WU_SRC_1, &wu1_src);
-	lis3->read(lis3, FF_WU_SRC_2, &wu2_src);
-
-	wu1_src = wu1_src & FF_WU_SRC_IA ? wu1_src : 0;
-	wu2_src = wu2_src & FF_WU_SRC_IA ? wu2_src : 0;
-
-	/* joystick poll is internally protected by the lis3->mutex. */
-	if (wu1_src || wu2_src)
-		lis3lv02d_joystick_poll(lis3_dev.idev);
-}
-
 static irqreturn_t lis302dl_interrupt_thread1_8b(int irq, void *data)
 {
 
 	struct lis3lv02d *lis3 = data;
 
-	if ((lis3->pdata->irq_cfg & LIS3_IRQ1_MASK) = LIS3_IRQ1_CLICK)
+	if ((lis3->irq_cfg & LIS3_IRQ1_MASK) = LIS3_IRQ1_CLICK)
 		lis302dl_interrupt_handle_click(lis3);
 	else
-		lis302dl_interrupt_handle_ff_wu(lis3);
+		lis3lv02d_joystick_poll(lis3_dev.idev);
 
 	return IRQ_HANDLED;
 }
@@ -397,10 +384,10 @@ static irqreturn_t lis302dl_interrupt_thread2_8b(int irq, void *data)
 
 	struct lis3lv02d *lis3 = data;
 
-	if ((lis3->pdata->irq_cfg & LIS3_IRQ2_MASK) = LIS3_IRQ2_CLICK)
+	if ((lis3->irq_cfg & LIS3_IRQ2_MASK) = LIS3_IRQ2_CLICK)
 		lis302dl_interrupt_handle_click(lis3);
 	else
-		lis302dl_interrupt_handle_ff_wu(lis3);
+		lis3lv02d_joystick_poll(lis3_dev.idev);
 
 	return IRQ_HANDLED;
 }
@@ -783,6 +770,7 @@ int lis3lv02d_init_device(struct lis3lv02d *dev)
 	}
 
 	mutex_init(&dev->mutex);
+	atomic_set(&dev->wake_thread, 0);
 
 	lis3lv02d_add_fs(dev);
 	lis3lv02d_poweron(dev);
@@ -795,14 +783,15 @@ int lis3lv02d_init_device(struct lis3lv02d *dev)
 	if (lis3lv02d_joystick_enable())
 		printk(KERN_ERR DRIVER_NAME ": joystick initialization failed\n");
 
-	/* passing in platform specific data is purely optional and only
-	 * used by the SPI transport layer at the moment */
+	/* passing in platform specific data is purely optional and
+	 * used by the SPI & I2C transport layer at the moment */
 	if (dev->pdata) {
 		struct lis3lv02d_platform_data *p = dev->pdata;
 
 		if (dev->whoami = WAI_8B)
 			lis3lv02d_8b_configure(dev, p);
 
+		dev->irq_cfg = p->irq_cfg;
 		if (p->irq_cfg)
 			dev->write(dev, CTRL_REG3, p->irq_cfg);
 	}
diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
index caf3ed1..8c19185 100644
--- a/drivers/hwmon/lis3lv02d.h
+++ b/drivers/hwmon/lis3lv02d.h
@@ -259,6 +259,8 @@ struct lis3lv02d {
 	struct fasync_struct	*async_queue; /* queue for the misc device */
 	wait_queue_head_t	misc_wait; /* Wait queue for the misc device */
 	unsigned long		misc_opened; /* bit0: whether the device is open */
+	atomic_t                wake_thread;
+	unsigned char           irq_cfg;
 
 	struct lis3lv02d_platform_data *pdata;	/* for passing board config */
 	struct mutex		mutex;     /* Serialize poll and selftest */
-- 
1.6.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
