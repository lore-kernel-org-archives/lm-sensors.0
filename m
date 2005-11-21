From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 21 Nov 2005 21:26:40 +0000
Subject: [lm-sensors] [PATCH] Support for Barco LTP->DVI parport I2C adapter
Message-Id: <87oe4d4uit.fsf@48ers.dk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

The following patch adds support for the Barco LTP->DVI I2C adapter to
the i2c-parport driver.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

diff -urpN linux-2.6.14.2.orig/Documentation/i2c/busses/i2c-parport linux-2.6.14.2/Documentation/i2c/busses/i2c-parport
--- linux-2.6.14.2.orig/Documentation/i2c/busses/i2c-parport	2005-11-21 17:51:26.000000000 +0100
+++ linux-2.6.14.2/Documentation/i2c/busses/i2c-parport	2005-11-21 17:54:37.000000000 +0100
@@ -17,6 +17,7 @@ It currently supports the following devi
  * Velleman K8000 adapter
  * ELV adapter
  * Analog Devices evaluation boards (ADM1025, ADM1030, ADM1031, ADM1032)
+ * Barco LPT->DVI (K5800236) adapter
 
 These devices use different pinout configurations, so you have to tell
 the driver what you have, using the type module parameter. There is no
diff -urpN linux-2.6.14.2.orig/drivers/i2c/busses/i2c-parport.h linux-2.6.14.2/drivers/i2c/busses/i2c-parport.h
--- linux-2.6.14.2.orig/drivers/i2c/busses/i2c-parport.h	2005-11-21 17:51:51.000000000 +0100
+++ linux-2.6.14.2/drivers/i2c/busses/i2c-parport.h	2005-11-21 17:55:01.000000000 +0100
@@ -80,6 +80,15 @@ static struct adapter_parm adapter_parm[
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
 	},
+	/* type 6: Barco LPT->DVI (K5800236) adapter */
+	{
+		.setsda	= { 0x02, DATA, 1 },
+		.setscl	= { 0x01, DATA, 1 },
+		.getsda	= { 0x20, STAT, 0 },
+		.getscl	= { 0x40, STAT, 0 },
+		.init	= { 0xfc, DATA, 0 },
+	},
+
 };
 
 static int type;
@@ -91,4 +100,5 @@ MODULE_PARM_DESC(type,
 	" 2 = Velleman K8000 adapter\n"
 	" 3 = ELV adapter\n"
 	" 4 = ADM1032 evaluation board\n"
-	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n");
+	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n"
+	" 6 = Barco LPT->DVI (K5800236) adapter\n");


-- 
Bye, Peter Korsgaard
