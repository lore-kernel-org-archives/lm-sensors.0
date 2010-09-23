From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 23 Sep 2010 05:58:33 +0000
Subject: [lm-sensors] [PATCH v2] lis3: Fix Oops with NULL platform data
Message-Id: <s5heiclngqe.wl%tiwai@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>, =?UTF-8?B?w4lyaWM=?= Piel <Eric.Piel@tremplin-utc.net>, Guenter Roeck <guenter.roeck@ericsson.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

The recent addition of threaded irq handler causes a NULL dereference
when used with hp_accel driver, which has NULL pdata.

Acked-by: Samu Onkalo <samu.p.onkalo@nokia.com>
Acked-by: Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: <stable@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
For 2.6.35/36 kernel

v1->v2
  NULL-check in caller of request_threaded_irq() instead of checking in
  threaded irq handler

 drivers/hwmon/lis3lv02d.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 5e15967..0a24177 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -301,7 +301,7 @@ static irqreturn_t lis302dl_interrupt(int irq, void *dummy)
 	wake_up_interruptible(&lis3_dev.misc_wait);
 	kill_fasync(&lis3_dev.async_queue, SIGIO, POLL_IN);
 out:
-	if (lis3_dev.whoami = WAI_8B && lis3_dev.idev &&
+	if (lis3_dev.pdata && lis3_dev.whoami = WAI_8B && lis3_dev.idev &&
 	    lis3_dev.idev->input->users)
 		return IRQ_WAKE_THREAD;
 	return IRQ_HANDLED;
@@ -742,7 +742,7 @@ int lis3lv02d_init_device(struct lis3lv02d *dev)
 	 * io-apic is not configurable (and generates a warning) but I keep it
 	 * in case of support for other hardware.
 	 */
-	if (dev->whoami = WAI_8B)
+	if (dev->pdata && dev->whoami = WAI_8B)
 		thread_fn = lis302dl_interrupt_thread1_8b;
 	else
 		thread_fn = NULL;
-- 
1.7.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
