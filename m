From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Oct 2007 10:25:46 +0000
Subject: [lm-sensors] [PATCH] hwmon/lm78 and w83781d: Probe fewer I2C
Message-Id: <20071007122546.3f8b4d18@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We've never seen any device supported by the lm78 or w83781d driver
at addresses 0x20-0x27, so let's stop probing these addresses. Extra
probes cost time, and have potential for confusing or misdetecting
other I2C devices.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/lm78    |    4 ++--
 Documentation/hwmon/w83781d |    6 +++---
 drivers/hwmon/lm78.c        |    6 ++----
 drivers/hwmon/w83781d.c     |    7 +++----
 4 files changed, 10 insertions(+), 13 deletions(-)

--- linux-2.6.23-rc9.orig/drivers/hwmon/w83781d.c	2007-10-06 09:48:14.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/w83781d.c	2007-10-07 12:12:22.000000000 +0200
@@ -54,9 +54,8 @@
 static struct platform_device *pdev;
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25,
-					0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b,
-					0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
+				       0x2e, 0x2f, I2C_CLIENT_END };
 static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
@@ -1113,7 +1112,7 @@ w83781d_detect(struct i2c_adapter *adapt
 			kind = w83783s;
 		else if (val1 = 0x21 && vendid = winbond)
 			kind = w83627hf;
-		else if (val1 = 0x31 && address >= 0x28)
+		else if (val1 = 0x31)
 			kind = as99127f;
 		else {
 			if (kind = 0)
--- linux-2.6.23-rc9.orig/drivers/hwmon/lm78.c	2007-10-06 23:49:31.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/lm78.c	2007-10-07 12:10:54.000000000 +0200
@@ -37,10 +37,8 @@
 static struct platform_device *pdev;
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24,
-					0x25, 0x26, 0x27, 0x28, 0x29,
-					0x2a, 0x2b, 0x2c, 0x2d, 0x2e,
-					0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
+				       0x2e, 0x2f, I2C_CLIENT_END };
 static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
--- linux-2.6.23-rc9.orig/Documentation/hwmon/lm78	2007-10-06 23:49:31.000000000 +0200
+++ linux-2.6.23-rc9/Documentation/hwmon/lm78	2007-10-07 12:11:50.000000000 +0200
@@ -4,12 +4,12 @@ Kernel driver lm78
 Supported chips:
   * National Semiconductor LM78 / LM78-J
     Prefix: 'lm78'
-    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
+    Addresses scanned: I2C 0x28 - 0x2f, ISA 0x290 (8 I/O ports)
     Datasheet: Publicly available at the National Semiconductor website
                http://www.national.com/
   * National Semiconductor LM79
     Prefix: 'lm79'
-    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
+    Addresses scanned: I2C 0x28 - 0x2f, ISA 0x290 (8 I/O ports)
     Datasheet: Publicly available at the National Semiconductor website
                http://www.national.com/
 
--- linux-2.6.23-rc9.orig/Documentation/hwmon/w83781d	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.23-rc9/Documentation/hwmon/w83781d	2007-10-07 12:11:31.000000000 +0200
@@ -4,11 +4,11 @@ Kernel driver w83781d
 Supported chips:
   * Winbond W83781D
     Prefix: 'w83781d'
-    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
+    Addresses scanned: I2C 0x28 - 0x2f, ISA 0x290 (8 I/O ports)
     Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/w83781d.pdf
   * Winbond W83782D
     Prefix: 'w83782d'
-    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
+    Addresses scanned: I2C 0x28 - 0x2f, ISA 0x290 (8 I/O ports)
     Datasheet: http://www.winbond.com/PDF/sheet/w83782d.pdf
   * Winbond W83783S
     Prefix: 'w83783s'
@@ -16,7 +16,7 @@ Supported chips:
     Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/w83783s.pdf
   * Winbond W83627HF
     Prefix: 'w83627hf'
-    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
+    Addresses scanned: I2C 0x28 - 0x2f, ISA 0x290 (8 I/O ports)
     Datasheet: http://www.winbond.com/PDF/sheet/w83627hf.pdf
   * Asus AS99127F
     Prefix: 'as99127f'


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
