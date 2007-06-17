From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Jun 2007 14:09:12 +0000
Subject: [lm-sensors] [PATCH] hwmon/w83627ehf: Preserve speed reading when
Message-Id: <20070617160912.1717d208@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The w83627ehf driver changes the fan clock divider automatically when
a new min fan speed is set. It is supposed to preserve the fan speed
reading while doing so, bug doesn't really. Fix it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- linux-2.6.22-rc5.orig/drivers/hwmon/w83627ehf.c	2007-06-16 23:02:58.000000000 +0200
+++ linux-2.6.22-rc5/drivers/hwmon/w83627ehf.c	2007-06-17 15:46:59.000000000 +0200
@@ -716,10 +716,15 @@ store_fan_min(struct device *dev, struct
 	/* Write both the fan clock divider (if it changed) and the new
 	   fan min (unconditionally) */
 	if (new_div != data->fan_div[nr]) {
-		if (new_div > data->fan_div[nr])
-			data->fan[nr] >>= (data->fan_div[nr] - new_div);
-		else
-			data->fan[nr] <<= (new_div - data->fan_div[nr]);
+		/* Preserve the fan speed reading */
+		if (data->fan[nr] != 0xff) {
+			if (new_div > data->fan_div[nr])
+				data->fan[nr] >>= new_div - data->fan_div[nr];
+			else if (data->fan[nr] & 0x80)
+				data->fan[nr] = 0xff;
+			else
+				data->fan[nr] <<= data->fan_div[nr] - new_div;
+		}
 
 		dev_dbg(dev, "fan%u clock divider changed from %u to %u\n",
 			nr + 1, div_from_reg(data->fan_div[nr]),


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
