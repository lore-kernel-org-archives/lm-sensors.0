From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 09 Jan 2006 21:43:08 +0000
Subject: [lm-sensors] [PATCH 01/11] hwmon: Fix negative temperature readings
Message-Id: <20060109224308.5b1637ba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-lm77-negative-temp-fix.patch

Fix negative temperature readings in lm77 driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Michael Renzmann <mrenzmann at otaku42.de>
---
 drivers/hwmon/lm77.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.15-rc6.orig/drivers/hwmon/lm77.c	2005-12-19 20:15:58.000000000 +0100
+++ linux-2.6.15-rc6/drivers/hwmon/lm77.c	2005-12-20 19:44:11.000000000 +0100
@@ -87,15 +87,15 @@
 
 /* In the temperature registers, the low 3 bits are not part of the
    temperature values; they are the status bits. */
-static inline u16 LM77_TEMP_TO_REG(int temp)
+static inline s16 LM77_TEMP_TO_REG(int temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM77_TEMP_MIN, LM77_TEMP_MAX);
-	return (u16)((ntemp / 500) * 8);
+	return (ntemp / 500) * 8;
 }
 
-static inline int LM77_TEMP_FROM_REG(u16 reg)
+static inline int LM77_TEMP_FROM_REG(s16 reg)
 {
-	return ((int)reg / 8) * 500;
+	return (reg / 8) * 500;
 }
 
 /* sysfs stuff */

-- 
Jean Delvare

