From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH] I2C fixes for 2.6.10-rc2
Message-Id: <11018600193456@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11018600191194@kroah.com>
References: <20041119220001.GB15956@kroah.com>
In-Reply-To: <20041119220001.GB15956@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2223.2.6, 2004/11/24 14:26:15-08:00, aris@cathedrallabs.org

[PATCH] [2/2] i2c-elektor: adding missing casts

[I2C] i2c-elektor: adding missing casts

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-elektor.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	2004-11-30 16:00:59 -08:00
+++ b/drivers/i2c/busses/i2c-elektor.c	2004-11-30 16:00:59 -08:00
@@ -80,10 +80,10 @@
 		break;
 	case 2: /* double mapped I/O needed for UP2000 board,
                    I don't know why this... */
-		writeb(val, address);
+		writeb(val, (void *)address);
 		/* fall */
 	case 1: /* memory mapped I/O */
-		writeb(val, address);
+		writeb(val, (void *)address);
 		break;
 	}
 }
@@ -91,7 +91,7 @@
 static int pcf_isa_getbyte(void *data, int ctl)
 {
 	int address = ctl ? (base + 1) : base;
-	int val = mmapped ? readb(address) : inb(address);
+	int val = mmapped ? readb((void *)address) : inb(address);
 
 	pr_debug("i2c-elektor: Read 0x%X 0x%02X\n", address, val);
 

