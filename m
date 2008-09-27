From: Henrik Rydberg <rydberg@euromail.se>
Date: Sat, 27 Sep 2008 15:28:12 +0000
Subject: [lm-sensors] [PATCH] hwmon: applesmc: Lighter wait mechanism,
Message-Id: <48DE510C.3030203@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org, Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

The read fail ratio is sensitive to the delay between the first byte
written and the first byte read; apparently the sensors cannot be
rushed. Increasing the minimum wait time, without changing the total
wait time, improves the fail ratio from a 8% chance that any of the
sensors fails in one read, down to 0.4%, on a Macbook Air. On a
Macbook Pro 3,1, the effect is even more apparent. By reducing the
number of status polls, the ratio is further improved to below
0.1%. Finally, increasing the total wait time brings the fail ratio
down to virtually zero.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
Tested-by: Bob McElrath <bob@mcelrath.org>
---
 drivers/hwmon/applesmc.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 321dc82..c6b9ecf 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -49,6 +49,9 @@

 #define APPLESMC_MAX_DATA_LENGTH 32

+#define APPLESMC_MIN_WAIT	0x0040
+#define APPLESMC_MAX_WAIT	0x8000
+
 #define APPLESMC_STATUS_MASK	0x0f
 #define APPLESMC_READ_CMD	0x10
 #define APPLESMC_WRITE_CMD	0x11
@@ -172,25 +175,25 @@ static unsigned int key_at_index;
 static struct workqueue_struct *applesmc_led_wq;

 /*
- * __wait_status - Wait up to 10ms for the status port to get a certain value
+ * __wait_status - Wait up to 32ms for the status port to get a certain value
  * (masked with 0x0f), returning zero if the value is obtained.  Callers must
  * hold applesmc_lock.
  */
 static int __wait_status(u8 val)
 {
-	unsigned int i;
+	int us;

 	val = val & APPLESMC_STATUS_MASK;

-	for (i = 0; i < 1000; i++) {
+	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
+		udelay(us);
 		if ((inb(APPLESMC_CMD_PORT) & APPLESMC_STATUS_MASK) = val) {
 			if (debug)
 				printk(KERN_DEBUG
-						"Waited %d us for status %x\n",
-						i*10, val);
+					"Waited %d us for status %x\n",
+					2 * us - APPLESMC_MIN_WAIT, val);
 			return 0;
 		}
-		udelay(10);
 	}

 	printk(KERN_WARNING "applesmc: wait status failed: %x != %x\n",
@@ -206,13 +209,12 @@ static int __wait_status(u8 val)
  */
 static int send_command(u8 cmd)
 {
-	int i;
-	for (i = 0; i < 1000; i++) {
+	int us;
+	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
 		outb(cmd, APPLESMC_CMD_PORT);
-		udelay(5);
+		udelay(us);
 		if ((inb(APPLESMC_CMD_PORT) & APPLESMC_STATUS_MASK) = 0x0c)
 			return 0;
-		udelay(5);
 	}
 	printk(KERN_WARNING "applesmc: command failed: %x -> %x\n",
 		cmd, inb(APPLESMC_CMD_PORT));
-- 
1.5.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
