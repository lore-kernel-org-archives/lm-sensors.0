From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Oct 2008 14:17:30 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adt7473) Fix voltage conversion
Message-Id: <20081021161730.2a6ddb72@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

Back in April 2008, Paulius Zaleckas posted a patch fixing the voltage
conversion routines of the adt7473 hwmon driver [1]. I reviewed it and
asked for a cleaned up version [2] but Paulius never replied and the
patch was lost. Still, I think this was a good patch so I just did the
cleanup work and am going to push the patch to Linus in the next days.

Can you please review and ack the patch below? I tested it on an
emulated chip and it seems to work fine.

Thanks.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022942.html
[2] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022972.html

* * * * *

Fix voltage conversion routines. Based on an earlier patch from
Paulius Zaleckas.

According to the datasheet voltage is scaled with resistors and
value 192 is nominal voltage. 0 is 0V.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Cc: Darrick J. Wong <djwong@us.ibm.com>
---
 drivers/hwmon/adt7473.c |   29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

--- linux-2.6.28-rc0.orig/drivers/hwmon/adt7473.c	2008-10-10 09:27:55.000000000 +0200
+++ linux-2.6.28-rc0/drivers/hwmon/adt7473.c	2008-10-21 14:38:29.000000000 +0200
@@ -319,35 +319,24 @@ out:
 }
 
 /*
- * On this chip, voltages are given as a count of steps between a minimum
- * and maximum voltage, not a direct voltage.
+ * Conversions
  */
-static const int volt_convert_table[][2] = {
-	{2997, 3},
-	{4395, 4},
+
+/* IN are scaled acording to built-in resistors */
+static const int adt7473_scaling[] = {  /* .001 Volts */
+	2250, 3300
 };
+#define SCALE(val, from, to)	(((val) * (to) + ((from) / 2)) / (from))
 
 static int decode_volt(int volt_index, u8 raw)
 {
-	int cmax = volt_convert_table[volt_index][0];
-	int cmin = volt_convert_table[volt_index][1];
-	return ((raw * (cmax - cmin)) / 255) + cmin;
+	return SCALE(raw, 192, adt7473_scaling[volt_index]);
 }
 
 static u8 encode_volt(int volt_index, int cooked)
 {
-	int cmax = volt_convert_table[volt_index][0];
-	int cmin = volt_convert_table[volt_index][1];
-	u8 x;
-
-	if (cooked > cmax)
-		cooked = cmax;
-	else if (cooked < cmin)
-		cooked = cmin;
-
-	x = ((cooked - cmin) * 255) / (cmax - cmin);
-
-	return x;
+	int raw = SCALE(cooked, adt7473_scaling[volt_index], 192);
+	return SENSORS_LIMIT(raw, 0, 255);
 }
 
 static ssize_t show_volt_min(struct device *dev,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
