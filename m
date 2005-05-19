From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: [PATCH] I2C update for 2.6.6
Message-Id: <10845773561456@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10845773562431@kroah.com>
References: <10845773562431@kroah.com>
In-Reply-To: <10845773562431@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1587.15.4, 2004/05/01 22:34:26-07:00, kevin@koconnor.net

[PATCH] I2C: support I2C_M_NO_RD_ACK in i2c-algo-bit

I have an I2C device (Samsung ks0127 video grabber) with a peculiar i2c
implementation.  When reading bytes, it only senses for the stop condition
in the place where the acknowledge bit should be.  So, to properly support
this device acks need to be turned off during reads.

There is an I2C_M_NO_RD_ACK bit already defined in i2c.h which appears to
be what I want.  Unfortunately it doesn't seem to be used anywhere in the
current tree.  At the end of this message is a patch to teach i2c_algo_bit
to honor the bit.


 drivers/i2c/algos/i2c-algo-bit.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
--- a/drivers/i2c/algos/i2c-algo-bit.c	Fri May 14 16:21:12 2004
+++ b/drivers/i2c/algos/i2c-algo-bit.c	Fri May 14 16:21:12 2004
@@ -381,7 +381,13 @@
 			break;
 		}
 
-		if ( count > 1 ) {		/* send ack */
+		temp++;
+		count--;
+
+		if (msg->flags & I2C_M_NO_RD_ACK)
+			continue;
+
+		if ( count > 0 ) {		/* send ack */
 			sdalo(adap);
 			DEBPROTO(printk(" Am "));
 		} else {
@@ -395,8 +401,6 @@
 		};
 		scllo(adap);
 		sdahi(adap);
-		temp++;
-		count--;
 	}
 	return rdcount;
 }

