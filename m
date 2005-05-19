From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH] I2C update for 2.6.10-rc1
Message-Id: <1099977856124@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10999778554@kroah.com>
References: <10999778552595@kroah.com>
In-Reply-To: <10999778552595@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2014.1.10, 2004/11/05 13:43:41-08:00, bunk@stusta.de

[PATCH] i2c it87.c: remove an unused function

The patch below removes an unused function from drivers/i2c/chips/it87.c


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/it87.c |    7 -------
 1 files changed, 7 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2004-11-08 18:55:38 -08:00
+++ b/drivers/i2c/chips/it87.c	2004-11-08 18:55:38 -08:00
@@ -56,13 +56,6 @@
 #define PME	0x04	/* The device with the fan registers in it */
 #define	DEVID	0x20	/* Register: Device ID */
 
-static inline void
-superio_outb(int reg, int val)
-{
-	outb(reg, REG);
-	outb(val, VAL);
-}
-
 static inline int
 superio_inb(int reg)
 {

