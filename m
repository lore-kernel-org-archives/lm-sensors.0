From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Apr 2008 18:05:20 +0000
Subject: [lm-sensors] [PATCH 09/10] hwmon: (lm85) Select the closest PWM
Message-Id: <20080412200520.2485fd30@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The LM85 and compatible chips only support 8 arbitrary PWM frequencies.
The algorithm to pick one of them based on the user input is not
optimum. Improve it to always pick the closest supported frequency.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
The new algorithm is exactly the same as the one used in
RANGE_TO_REG().

 drivers/hwmon/lm85.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c	2008-04-03 18:16:31.000000000 +0200
+++ linux-2.6.25-rc8/drivers/hwmon/lm85.c	2008-04-03 18:45:54.000000000 +0200
@@ -202,10 +202,18 @@ static int FREQ_TO_REG(int freq)
 
 	if (freq >= lm85_freq_map[7])
 		return 7;
-	for (i = 0; i < 7; ++i)
-		if (freq <= lm85_freq_map[i])
-			break;
-	return i;
+
+	/* Find the closest match */
+	for (i = 6; i >= 0; --i) {
+		if (freq >= lm85_freq_map[i]) {
+			if ((lm85_freq_map[i + 1] - freq) <
+					(freq - lm85_freq_map[i]))
+				return i + 1;
+			return i;
+		}
+	}
+
+	return 0;
 }
 #define FREQ_FROM_REG(val)	lm85_freq_map[(val) & 0x07]
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
