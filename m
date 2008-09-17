From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 17 Sep 2008 22:23:41 +0000
Subject: [lm-sensors] [PATCH 3/5] hwmon: applesmc: Prolong status wait
Message-Id: <48D1836D.9060106@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

The time to wait for a status change while reading or writing to the
SMC ports is a balance between read reliability and system
performance. The current setting yields rougly three errors in a
thousand when simultaneously reading three different temperature
values on a Macbook Air. This patch increases the setting to a value
yielding roughly one error in ten thousand, with no noticable system
performance degradation.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index b06b8e0..091338c 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -163,7 +163,7 @@ static unsigned int key_at_index;
 static struct workqueue_struct *applesmc_led_wq;

 /*
- * __wait_status - Wait up to 2ms for the status port to get a certain value
+ * __wait_status - Wait up to 10ms for the status port to get a certain value
  * (masked with 0x0f), returning zero if the value is obtained.  Callers must
  * hold applesmc_lock.
  */
@@ -173,7 +173,7 @@ static int __wait_status(u8 val)

 	val = val & APPLESMC_STATUS_MASK;

-	for (i = 0; i < 200; i++) {
+	for (i = 0; i < 1000; i++) {
 		if ((inb(APPLESMC_CMD_PORT) & APPLESMC_STATUS_MASK) = val) {
 			if (debug)
 				printk(KERN_DEBUG
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
