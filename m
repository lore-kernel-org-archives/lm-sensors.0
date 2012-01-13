From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jan 2012 14:56:38 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm63) Fix incorrect comment about I2C address
Message-Id: <20120113155638.59a29b52@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

What was true of the LM63 doesn't apply to the LM64.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm63.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-3.3-rc0.orig/drivers/hwmon/lm63.c	2012-01-13 14:07:43.000000000 +0100
+++ linux-3.3-rc0/drivers/hwmon/lm63.c	2012-01-13 15:54:39.000000000 +0100
@@ -51,7 +51,10 @@
 
 /*
  * Addresses to scan
- * Address is fully defined internally and cannot be changed.
+ * Address is fully defined internally and cannot be changed except for
+ * LM64 which has one pin dedicated to address selection.
+ * LM63 and LM96163 have address 0x4c.
+ * LM64 can have address 0x18 or 0x4e.
  */
 
 static const unsigned short normal_i2c[] = { 0x18, 0x4c, 0x4e, I2C_CLIENT_END };


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
