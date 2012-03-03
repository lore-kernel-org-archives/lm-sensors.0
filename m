From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Mar 2012 21:27:22 +0000
Subject: [lm-sensors] [PATCH 2/3] sensord: Fold get_features() into do_features()
Message-Id: <20120303222722.5f9b2fee@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There is no rationale for having separate functions, both are static
and called only once. do_features() is calling helper functions to get
values it doesn't use and passes to get_features() directly. Having a
single function is more efficient and allows for per-action
optimizations.
---
 prog/sensord/sense.c |   63 +++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

--- lm-sensors.orig/prog/sensord/sense.c	2012-03-02 20:56:17.000000000 +0100
+++ lm-sensors/prog/sensord/sense.c	2012-03-03 19:07:43.591734400 +0100
@@ -82,13 +82,21 @@ static int get_flag(const sensors_chip_n
 	return (int) (val + 0.5);
 }
 
-static int get_features(const sensors_chip_name *chip,
-			const FeatureDescriptor *feature, int action,
-			char *label, int alrm, int beep)
+static int do_features(const sensors_chip_name *chip,
+		       const FeatureDescriptor *feature, int action)
 {
-	int i, ret;
+	char *label;
+	const char *formatted;
+	int i, alrm, beep, ret;
 	double val[MAX_DATA];
 
+	/* If only scanning, take a quick exit if alarm is off */
+	alrm = get_flag(chip, feature->alarmNumber);
+	if (alrm = -1)
+		return -1;
+	if (action = DO_SCAN && !alrm)
+		return 0;
+
 	for (i = 0; feature->dataNumbers[i] >= 0; i++) {
 		ret = sensors_get_value(chip, feature->dataNumbers[i],
 					val + i);
@@ -101,6 +109,7 @@ static int get_features(const sensors_ch
 		}
 	}
 
+	/* For RRD, we don't need anything else */
 	if (action = DO_RRD) {
 		if (feature->rrd) {
 			const char *rrded = feature->rrd(val);
@@ -110,40 +119,24 @@ static int get_features(const sensors_ch
 			 */
 			strcat(strcat (rrdBuff, ":"), rrded ? rrded : "U");
 		}
-	} else {
-		const char *formatted = feature->format(val, alrm, beep);
-
-		if (!formatted) {
-			sensorLog(LOG_ERR, "Error formatting sensor data");
-			return -1;
-		}
 
-		if (action = DO_READ) {
-			sensorLog(LOG_INFO, "  %s: %s", label, formatted);
-		} else {
-			sensorLog(LOG_ALERT, "Sensor alarm: Chip %s: %s: %s",
-				  chipName(chip), label, formatted);
-		}
-	}
-	return 0;
-}
-
-static int do_features(const sensors_chip_name *chip,
-		       const FeatureDescriptor *feature, int action)
-{
-	char *label;
-	int alrm, beep, ret;
-
-	alrm = get_flag(chip, feature->alarmNumber);
-	if (alrm = -1)
-		return -1;
-	else if (action = DO_SCAN && !alrm)
 		return 0;
+	}
 
+	/* For scanning and logging, we need extra information */
 	beep = get_flag(chip, feature->beepNumber);
 	if (beep = -1)
 		return -1;
 
+	formatted = feature->format(val, alrm, beep);
+	if (!formatted) {
+		sensorLog(LOG_ERR, "Error formatting sensor data");
+		return -1;
+	}
+
+	/* FIXME: It would be more efficient to store the label at
+	 * initialization time.
+	 */
 	label = sensors_get_label(chip, feature->feature);
 	if (!label) {
 		sensorLog(LOG_ERR, "Error getting sensor label: %s/%s",
@@ -151,11 +144,15 @@ static int do_features(const sensors_chi
 		return -1;
 	}
 
-	ret = get_features(chip, feature, action, label, alrm, beep);
+	if (action = DO_READ)
+		sensorLog(LOG_INFO, "  %s: %s", label, formatted);
+	else
+		sensorLog(LOG_ALERT, "Sensor alarm: Chip %s: %s: %s",
+			  chipName(chip), label, formatted);
 
 	free(label);
 
-	return ret;
+	return 0;
 }
 
 static int doKnownChip(const sensors_chip_name *chip,

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
