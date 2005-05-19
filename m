From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH] i2c/i2c-ite: remove interruptible_sleep_on_timeout() usage
Message-Id: <11123113891852@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050331232230.GA2614@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: domen@coderock.org

ChangeSet 1.2322, 2005/03/31 14:05:14-08:00, domen@coderock.org

[PATCH] i2c/i2c-ite: remove interruptible_sleep_on_timeout() usage

Replace deprecated interruptible_sleep_on_timeout() with direct
wait-queue usage. Patch is compile-tested, sort of; the driver does not build in
vanilla kernel either, but I don't seem to add any warnings..

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-ite.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ite.c b/drivers/i2c/busses/i2c-ite.c
--- a/drivers/i2c/busses/i2c-ite.c	2005-03-31 15:19:21 -08:00
+++ b/drivers/i2c/busses/i2c-ite.c	2005-03-31 15:19:21 -08:00
@@ -40,6 +40,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/wait.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 
@@ -107,7 +108,7 @@
  * IIC controller interrupts.
  */
 static void iic_ite_waitforpin(void) {
-
+   DEFINE_WAIT(wait);
    int timeout = 2;
    long flags;
 
@@ -121,13 +122,15 @@
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

