From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [PATCH 2.6] I2C: Reduce it87 i2c address range
Message-Id: <20050122163704.7be2c29f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

IT87xxF chips were never seen at any other I2C address than the default
(0x2d) so I think that we could safely reduce the range of addresses the
it87 drivers accepts. Currently it accepts 0x20-0x2f, I believe that
0x28-0x2f would already be more than sufficient.

(In theory, any address is possible, so whatever range we choose is
arbitrary anyway.)

Please apply,
thanks.

Signed-off-by: Jean Delvare

--- linux-2.6.11-rc2/drivers/i2c/chips/it87.c.orig	2005-01-22 15:14:21.000000000 +0100
+++ linux-2.6.11-rc2/drivers/i2c/chips/it87.c	2005-01-22 16:25:41.000000000 +0100
@@ -2,8 +2,8 @@
     it87.c - Part of lm_sensors, Linux kernel modules for hardware
              monitoring.
 
-    Supports: IT8705F  Super I/O chip w/LPC interface
-              IT8712F  Super I/O chip w/LPC interface & SMbus
+    Supports: IT8705F  Super I/O chip w/LPC interface & SMBus
+              IT8712F  Super I/O chip w/LPC interface & SMBus
               Sis950   A clone of the IT8705F
 
     Copyright (C) 2001 Chris Gauthron <chrisg@0-in.com> 
@@ -42,10 +42,8 @@
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24,
-					0x25, 0x26, 0x27, 0x28, 0x29,
-					0x2a, 0x2b, 0x2c, 0x2d, 0x2e,
-					0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
+					0x2e, 0x2f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */


-- 
Jean Delvare
http://khali.linux-fr.org/
