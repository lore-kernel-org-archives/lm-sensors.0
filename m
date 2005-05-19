From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH] i2c/i2c-elektor: remove interruptible_sleep_on_timeout()
Message-Id: <11123113893610@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11123113891852@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: domen@coderock.org

ChangeSet 1.2323, 2005/03/31 14:05:31-08:00, domen@coderock.org

[PATCH] i2c/i2c-elektor: remove interruptible_sleep_on_timeout() usage

Replace deprecated interruptible_sleep_on_timeout() with direct
wait-queue usage. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-elektor.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	2005-03-31 15:19:14 -08:00
+++ b/drivers/i2c/busses/i2c-elektor.c	2005-03-31 15:19:14 -08:00
@@ -110,7 +110,7 @@
 }
 
 static void pcf_isa_waitforpin(void) {
-
+	DEFINE_WAIT(wait);
 	int timeout = 2;
 	long flags;
 
@@ -118,14 +118,15 @@
 		spin_lock_irqsave(&lock, flags);
 		if (pcf_pending = 0) {
 			spin_unlock_irqrestore(&lock, flags);
-			if (interruptible_sleep_on_timeout(&pcf_wait,
-								timeout*HZ)) {
+			prepare_to_wait(&pcf_wait, &wait, TASK_INTERRUPTIBLE);
+			if (schedule_timeout(timeout*HZ)) {
 				spin_lock_irqsave(&lock, flags);
 				if (pcf_pending = 1) {
 					pcf_pending = 0;
 				}
 				spin_unlock_irqrestore(&lock, flags);
 			}
+			finish_wait(&pcf_wait, &wait);
 		} else {
 			pcf_pending = 0;
 			spin_unlock_irqrestore(&lock, flags);

