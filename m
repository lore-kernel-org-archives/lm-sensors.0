From: domen@coderock.org (domen@coderock.org)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [patch 2/2] i2c/i2c-ite: remove interruptible_sleep_on_timeout()
Message-Id: <20050306104150.AB27D1F1F0@trashy.coderock.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Replace deprecated interruptible_sleep_on_timeout() with direct
wait-queue usage. Patch is compile-tested, sort of; the driver does not build in
vanilla kernel either, but I don't seem to add any warnings..

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/i2c/busses/i2c-ite.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff -puN drivers/i2c/busses/i2c-ite.c~int_sleep_on-drivers_i2c_busses_i2c-ite drivers/i2c/busses/i2c-ite.c
--- kj/drivers/i2c/busses/i2c-ite.c~int_sleep_on-drivers_i2c_busses_i2c-ite	2005-03-05 16:12:07.000000000 +0100
+++ kj-domen/drivers/i2c/busses/i2c-ite.c	2005-03-05 16:12:07.000000000 +0100
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
_
