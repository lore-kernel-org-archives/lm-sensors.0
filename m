From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Feb 2006 22:13:48 +0000
Subject: [lm-sensors] [PATCH 02/11] w83781d: Use real-time status registers
Message-Id: <20060205231348.1e273c69.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-w83781d-real-time-alarms.patch

Use the real-time status registers of the Winbond W83782D, W83783S and
W83627HF chips, instead of the interrupt status registers. Interrupts
cannot be trusted at least for voltage inputs, as they are two-times
triggers (as opposed to comparator mode, which we want.) The w83627hf
driver was fixed in a similar way some times ago.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/w83781d.c |   43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

--- linux-2.6.16-rc2.orig/drivers/hwmon/w83781d.c	2006-02-05 21:09:41.000000000 +0100
+++ linux-2.6.16-rc2/drivers/hwmon/w83781d.c	2006-02-05 21:10:17.000000000 +0100
@@ -95,11 +95,16 @@
 						     (0x39)))
 
 #define W83781D_REG_CONFIG		0x40
+
+/* Interrupt status (W83781D, AS99127F) */
 #define W83781D_REG_ALARM1		0x41
 #define W83781D_REG_ALARM2		0x42
-#define W83781D_REG_ALARM3		0x450	/* not on W83781D */
 
-#define W83781D_REG_IRQ			0x4C
+/* Real-time status (W83782D, W83783S, W83627HF) */
+#define W83782D_REG_ALARM1		0x459
+#define W83782D_REG_ALARM2		0x45A
+#define W83782D_REG_ALARM3		0x45B
+
 #define W83781D_REG_BEEP_CONFIG		0x4D
 #define W83781D_REG_BEEP_INTS1		0x56
 #define W83781D_REG_BEEP_INTS2		0x57
@@ -1513,15 +1518,6 @@
 					W83781D_REG_TEMP3_CONFIG, tmp & 0xfe);
 			}
 		}
-
-		if (type != w83781d) {
-			/* enable comparator mode for temp2 and temp3 so
-			   alarm indication will work correctly */
-			i = w83781d_read_value(client, W83781D_REG_IRQ);
-			if (!(i & 0x40))
-				w83781d_write_value(client, W83781D_REG_IRQ,
-						    i | 0x40);
-		}
 	}
 
 	/* Start monitoring */
@@ -1612,14 +1608,25 @@
 			data->fan_div[1] |= (i >> 4) & 0x04;
 			data->fan_div[2] |= (i >> 5) & 0x04;
 		}
-		data->alarms -		    w83781d_read_value(client,
-				       W83781D_REG_ALARM1) +
-		    (w83781d_read_value(client, W83781D_REG_ALARM2) << 8);
 		if ((data->type = w83782d) || (data->type = w83627hf)) {
-			data->alarms |-			    w83781d_read_value(client,
-					       W83781D_REG_ALARM3) << 16;
+			data->alarms = w83781d_read_value(client,
+						W83782D_REG_ALARM1)
+				     | (w83781d_read_value(client,
+						W83782D_REG_ALARM2) << 8)
+				     | (w83781d_read_value(client,
+						W83782D_REG_ALARM3) << 16);
+		} else if (data->type = w83783s) {
+			data->alarms = w83781d_read_value(client,
+						W83782D_REG_ALARM1)
+				     | (w83781d_read_value(client,
+						W83782D_REG_ALARM2) << 8);
+		} else {
+			/* No real-time status registers, fall back to
+			   interrupt status registers */
+			data->alarms = w83781d_read_value(client,
+						W83781D_REG_ALARM1)
+				     | (w83781d_read_value(client,
+						W83781D_REG_ALARM2) << 8);
 		}
 		i = w83781d_read_value(client, W83781D_REG_BEEP_INTS2);
 		data->beep_enable = i >> 7;

-- 
Jean Delvare

