From: nacc@us.ibm.com (Nishanth Aravamudan)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH 12/20] i2c/i2c-ite: remove interruptible_sleep_on_timeout()
Message-Id: <20050202192900.GO2546@us.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Hello,

Please consider applying.

Description: Replace deprecated interruptible_sleep_on_timeout() with direct
wait-queue usage. Patch is compile-tested, sort of; the driver does not build in
vanilla kernel either, but I don't seem to add any warnings..

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/drivers/i2c/busses/i2c-ite.c	2005-01-24 09:28:30.000000000 -0800
+++ 2.6.11-rc2-kj/drivers/i2c/busses/i2c-ite.c	2005-01-27 11:37:59.000000000 -0800
@@ -40,6 +40,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/wait.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 
@@ -107,7 +108,7 @@ static int iic_ite_getclock(void *data)
  * IIC controller interrupts.
  */
 static void iic_ite_waitforpin(void) {
-
+   DEFINE_WAIT(wait);
    int timeout = 2;
    long flags;
 
@@ -121,13 +122,15 @@ static void iic_ite_waitforpin(void) {
 	spin_lock_irqsave(&lock, flags);
 	if (iic_pending = 0) {
 		spin_unlock_irqrestore(&lock, flags);
-		if (interruptible_sleep_on_timeout(&iic_wait, timeout*HZ)) {
+		prepare_to_wait(&iic_wait, &wait, TASK_INTERRUPTIBLE);
+		if (schedule_timeout(timeout*HZ)) {
 			spin_lock_irqsave(&lock, flags);
 			if (iic_pending = 1) {
 				iic_pending = 0;
 			}
 			spin_unlock_irqrestore(&lock, flags);
 		}
+		finish_wait(&iic_wait, &wait);
 	} else {
 		iic_pending = 0;
 		spin_unlock_irqrestore(&lock, flags);
