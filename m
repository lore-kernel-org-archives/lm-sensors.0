From: domen@coderock.org (domen@coderock.org)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [patch 1/2] i2c/i2c-elektor: remove interruptible_sleep_on_timeout()
Message-Id: <20050306104147.183E21F1F0@trashy.coderock.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Replace deprecated interruptible_sleep_on_timeout() with direct
wait-queue usage. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/i2c/busses/i2c-elektor.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/i2c/busses/i2c-elektor.c~int_sleep_on-drivers_i2c_busses_i2c-elektor drivers/i2c/busses/i2c-elektor.c
--- kj/drivers/i2c/busses/i2c-elektor.c~int_sleep_on-drivers_i2c_busses_i2c-elektor	2005-03-05 16:12:06.000000000 +0100
+++ kj-domen/drivers/i2c/busses/i2c-elektor.c	2005-03-05 16:12:06.000000000 +0100
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
_
