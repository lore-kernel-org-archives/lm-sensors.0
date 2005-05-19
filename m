From: nacc@us.ibm.com (Nishanth Aravamudan)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH 11/20] i2c/i2c-elektor: remove
Message-Id: <20050202192407.GN2546@us.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Hello,

Please consider applying.

Description: Replace deprecated interruptible_sleep_on_timeout() with direct
wait-queue usage. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/drivers/i2c/busses/i2c-elektor.c	2005-01-24 09:28:30.000000000 -0800
+++ 2.6.11-rc2-kj/drivers/i2c/busses/i2c-elektor.c	2005-01-27 11:34:43.000000000 -0800
@@ -110,7 +110,7 @@ static int pcf_isa_getclock(void *data)
 }
 
 static void pcf_isa_waitforpin(void) {
-
+	DEFINE_WAIT(wait);
 	int timeout = 2;
 	long flags;
 
@@ -118,14 +118,15 @@ static void pcf_isa_waitforpin(void) {
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
