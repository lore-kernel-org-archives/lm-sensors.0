From: jchapman@katalix.com (James Chapman)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH: 2.6.11-rc5] i2c chips: add adt7461 support to lm90 driver
Message-Id: <4223513F.4030403@katalix.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@stimpy.netroedge.com
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org

Add ADT7461 (temperature sensor) support to LM90 driver.

Signed-off-by: James Chapman <jchapman@katalix.com>





-------------- next part --------------
diff -Nru a/drivers/i2c/chips/lm90.c b/drivers/i2c/chips/lm90.c
--- a/drivers/i2c/chips/lm90.c	2005-02-27 13:24:11 +00:00
+++ b/drivers/i2c/chips/lm90.c	2005-02-27 13:24:11 +00:00
@@ -85,7 +85,7 @@
  * Insmod parameters
  */
 
-SENSORS_INSMOD_5(lm90, adm1032, lm99, lm86, max6657);
+SENSORS_INSMOD_6(lm90, adm1032, lm99, lm86, max6657, adt7461);
 
 /*
  * The LM90 registers
@@ -386,7 +386,10 @@
 			 && (reg_config1 & 0x3F) = 0x00
 			 && reg_convrate <= 0x0A) {
 				kind = adm1032;
-			}
+			} else
+			if (address = 0x4c
+			 && chip_id = 0x51) /* ADT7461 */
+				kind = adt7461;
 		} else
 		if (man_id = 0x4D) { /* Maxim */
 			/*
@@ -423,6 +426,8 @@
 		name = "lm86";
 	} else if (kind = max6657) {
 		name = "max6657";
+	} else if (kind = adt7461) {
+		name = "adt7461";
 	}
 
 	/* We can fill in the remaining client fields */




