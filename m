From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH] I2C: Clean up of i2c-elektor.c build
Message-Id: <11123113922923@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11123113914006@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: frank.beesley@aeroflex.com

ChangeSet 1.2333, 2005/03/31 14:08:41-08:00, frank.beesley@aeroflex.com

[PATCH] I2C: Clean up of i2c-elektor.c build

This patch changes the flags variable type from long to unsigned long in
one function. This removes a couple of warnings from the compile
messages for elektor i2c bus driver.

Signed-off-by: Frank Beesley <frank.beesley@aeroflex.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-elektor.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	2005-03-31 15:18:01 -08:00
+++ b/drivers/i2c/busses/i2c-elektor.c	2005-03-31 15:18:01 -08:00
@@ -112,7 +112,7 @@
 static void pcf_isa_waitforpin(void) {
 	DEFINE_WAIT(wait);
 	int timeout = 2;
-	long flags;
+	unsigned long flags;
 
 	if (irq > 0) {
 		spin_lock_irqsave(&lock, flags);

