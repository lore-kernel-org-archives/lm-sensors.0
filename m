From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:17:50 +0000
Subject: [lm-sensors] [PATCH 05/25] i2c: Add support for Barco LTP->DVI to
Message-Id: <20051126201843.75fd91a3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Peter Korsgaard <jacmet@sunsite.dk>
Content-Disposition: inline; filename=i2c-parport-barco-ltp-dvi.patch

The following patch adds support for the Barco LTP->DVI I2C adapter to
the i2c-parport driver.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/i2c/busses/i2c-parport |    1 +
 drivers/i2c/busses/i2c-parport.h     |   12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

--- linux-2.6.15-rc2.orig/Documentation/i2c/busses/i2c-parport	2005-10-28 18:22:27.000000000 +0200
+++ linux-2.6.15-rc2/Documentation/i2c/busses/i2c-parport	2005-11-22 21:43:53.000000000 +0100
@@ -17,6 +17,7 @@
  * Velleman K8000 adapter
  * ELV adapter
  * Analog Devices evaluation boards (ADM1025, ADM1030, ADM1031, ADM1032)
+ * Barco LPT->DVI (K5800236) adapter
 
 These devices use different pinout configurations, so you have to tell
 the driver what you have, using the type module parameter. There is no
--- linux-2.6.15-rc2.orig/drivers/i2c/busses/i2c-parport.h	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/busses/i2c-parport.h	2005-11-22 21:45:06.000000000 +0100
@@ -80,6 +80,14 @@
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
 };
 
 static int type;
@@ -91,4 +99,6 @@
 	" 2 = Velleman K8000 adapter\n"
 	" 3 = ELV adapter\n"
 	" 4 = ADM1032 evaluation board\n"
-	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n");
+	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n"
+	" 6 = Barco LPT->DVI (K5800236) adapter\n"
+);

-- 
Jean Delvare
