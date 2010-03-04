From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 04 Mar 2010 13:26:31 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (tmp421) Fix temperature conversions
Message-Id: <20100304142631.1044370f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The low bits of temperature registers are status bits, they must be
masked out before converting the register values to temperatures.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Andre Prendel <andre.prendel@gmx.de>
Cc: stable@kernel.org
---
 drivers/hwmon/tmp421.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.34-rc0.orig/drivers/hwmon/tmp421.c	2010-03-04 14:05:09.000000000 +0100
+++ linux-2.6.34-rc0/drivers/hwmon/tmp421.c	2010-03-04 14:13:27.000000000 +0100
@@ -80,14 +80,16 @@ struct tmp421_data {
 
 static int temp_from_s16(s16 reg)
 {
-	int temp = reg;
+	/* Mask out status bits */
+	int temp = reg & ~0xf;
 
 	return (temp * 1000 + 128) / 256;
 }
 
 static int temp_from_u16(u16 reg)
 {
-	int temp = reg;
+	/* Mask out status bits */
+	int temp = reg & ~0xf;
 
 	/* Add offset for extended temperature range. */
 	temp -= 64 * 256;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
