From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 26 Jun 2006 22:14:30 +0000
Subject: [lm-sensors] [PATCH] S3C24XX: fix small bug in write
Message-Id: <20060626221430.GA4772@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This affects a few devices on i2c, where the i2c controller
on the S3C2410 simply stops working when writing to the bus.

Adding a small delay by reading the IICSTAT register 6 times
seesm to be good enough to allow the controller to continue
without stopping the bus transaction.

Signed-off-by: Ben Dooks <ben-linux at fluff.org>

diff -urpN -X ../dontdiff linux-2.6.17-git9-bjd1/drivers/i2c/busses/i2c-s3c2410.c linux-2.6.17-git9/drivers/i2c/busses/i2c-s3c2410.c
--- linux-2.6.17-git9-bjd1/drivers/i2c/busses/i2c-s3c2410.c	2006-06-18 02:49:35.000000000 +0100
+++ linux-2.6.17-git9/drivers/i2c/busses/i2c-s3c2410.c	2006-06-26 23:05:56.000000000 +0100
@@ -269,6 +269,7 @@ static int i2s_s3c_irq_nextbyte(struct s
 	unsigned long tmp;
 	unsigned char byte;
 	int ret = 0;
+	int i;
 
 	switch (i2c->state) {
 
@@ -325,6 +326,14 @@ static int i2s_s3c_irq_nextbyte(struct s
 			byte = i2c->msg->buf[i2c->msg_ptr++];
 			writeb(byte, i2c->regs + S3C2410_IICDS);
 			
+			/* sometimes write operations fail if the write is
+			 * let go too quickly, slow down the proceedings
+			 * slightly.
+			 */
+
+			for (i = 0; i < 6; i++) 
+				tmp += readl(i2c->regs + S3C2410_IICSTAT);
+
 		} else if (!is_lastmsg(i2c)) {
 			/* we need to go to the next i2c message */
 

