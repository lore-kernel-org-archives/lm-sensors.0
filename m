From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 15 Jun 2009 07:49:52 +0000
Subject: [lm-sensors] [PATCH 5/5] sensord: Refactoring of file
Message-Id: <20090615074952.GI4667@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch does some refactoring of functions doKnownChip() and doChips().

* doKnownChip() is a huge function with deep indentation
levels. Splitting this funcion up into smaller ones makes code much
more readable.

* Break long line in doChips().
---

 sense.c |  204 ++++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 123 insertions(+), 81 deletions(-)

Index: sensors/prog/sensord/sense.c
=================================--- sensors.orig/prog/sensord/sense.c	2009-06-14 14:22:15.000000000 +0200
+++ sensors/prog/sensord/sense.c	2009-06-14 15:51:29.000000000 +0200
@@ -47,7 +47,7 @@
 {
 	const char *adapter;
 
-	sensorLog(LOG_INFO, "Chip: %s", chipName (chip));
+	sensorLog(LOG_INFO, "Chip: %s", chipName(chip));
 	adapter = sensors_get_adapter_name(&chip->bus);
 	if (adapter)
 		sensorLog(LOG_INFO, "Adapter: %s", adapter);
@@ -55,92 +55,132 @@
 	return 0;
 }
 
+static int get_alarm(const sensors_chip_name *chip,
+		     const FeatureDescriptor *feature)
+{
+	double val;
+	int ret;
+
+	if (feature->alarmNumber = -1)
+		return 0;
+
+	ret = sensors_get_value(chip, feature->alarmNumber, &val);
+	if (ret) {
+		sensorLog(LOG_ERR, "Error getting sensor data: %s/#%d: %s",
+			  chip->prefix, feature->alarmNumber,
+			  sensors_strerror(ret));
+		return -1;
+	}
+
+	return (int) (val + 0.5);
+}
+
+static int get_beep(const sensors_chip_name *chip,
+		    const FeatureDescriptor *feature)
+{
+	double val;
+	int ret;
+
+	if (feature->beepNumber = -1)
+		return 0;
+
+	ret = sensors_get_value(chip, feature->beepNumber, &val);
+	if (ret) {
+		sensorLog(LOG_ERR, "Error getting sensor data: %s/#%d: %s",
+			  chip->prefix, feature->beepNumber,
+			  sensors_strerror(ret));
+		return -1;
+	}
+
+	return (int) (val + 0.5);
+}
+
+static int get_features(const sensors_chip_name *chip,
+			const FeatureDescriptor *feature, int action,
+			char *label, int alarm, int beep)
+{
+	int i, ret;
+	double val[MAX_DATA];
+
+	for (i = 0; feature->dataNumbers[i] >= 0; i++) {
+		ret = sensors_get_value(chip, feature->dataNumbers[i],
+					val + i);
+		if (ret) {
+			sensorLog(LOG_ERR,
+				  "Error getting sensor data: %s/#%d: %s",
+				  chip->prefix, feature->dataNumbers[i],
+				  sensors_strerror(ret));
+			return -1;
+		}
+	}
+
+	if (action = DO_RRD) {
+		if (feature->rrd) {
+			const char *rrded = feature->rrd(val);
+
+			strcat(strcat (rrdBuff, ":"), rrded ? rrded : "U");
+		}
+	} else {
+		const char *formatted = feature->format(val, alarm, beep);
+
+		if (!formatted)
+			return -1;
+
+		if (action = DO_READ) {
+			sensorLog(LOG_INFO, "  %s: %s", label, formatted);
+		} else {
+			sensorLog(LOG_ALERT, "Sensor alarm: Chip %s: %s: %s",
+				  chipName(chip), label, formatted);
+		}
+	}
+	return 0;
+}
+
+static int do_features(const sensors_chip_name *chip,
+		       const FeatureDescriptor *feature, int action)
+{
+	char *label;
+	int alarm, beep, ret;
+
+	label = sensors_get_label(chip, feature->feature);
+	if (!label) {
+		sensorLog(LOG_ERR, "Error getting sensor label: %s/%s",
+			  chip->prefix, feature->feature->name);
+		return -1;
+	}
+
+	alarm = get_alarm(chip, feature);
+	if (alarm = -1)
+		return -1;
+
+	beep = get_beep(chip, feature);
+	if (beep = -1)
+		return -1;
+
+	ret = get_features(chip, feature, action, label, alarm, beep);
+	if (ret) {
+		return -1;
+	}
+
+	return 0;
+}
+
 static int doKnownChip(const sensors_chip_name *chip,
 		       const ChipDescriptor *descriptor, int action)
 {
 	const FeatureDescriptor *features = descriptor->features;
-	int index0, subindex;
-	int ret = 0;
-	double tmp;
+	const FeatureDescriptor *feature;
+	int i, ret;
 
 	if (action = DO_READ)
 		ret = idChip(chip);
-	for (index0 = 0; (ret = 0) && features[index0].format; ++ index0) {
-		const FeatureDescriptor *feature = features + index0;
-		int alarm, beep;
-		char *label = NULL;
 
-		if (!(label = sensors_get_label(chip, feature->feature))) {
-			sensorLog(LOG_ERR,
-				  "Error getting sensor label: %s/%s",
-				  chip->prefix, feature->feature->name);
-			ret = 22;
-		} else {
-			double values[MAX_DATA];
+	for (i = 0; features[i].format; i++) {
 
-			alarm = 0;
-			if (!ret && feature->alarmNumber != -1) {
-				if ((ret = sensors_get_value(chip,
-							     feature->alarmNumber,
-							     &tmp))) {
-					sensorLog(LOG_ERR,
-						  "Error getting sensor data: %s/#%d: %s",
-						  chip->prefix,
-						  feature->alarmNumber,
-						  sensors_strerror(ret));
-					ret = 20;
-				} else {
-					alarm = (int) (tmp + 0.5);
-				}
-			}
-			if ((action = DO_SCAN) && !alarm)
-				continue;
-
-			beep = 0;
-			if (!ret && feature->beepNumber != -1) {
-				if ((ret = sensors_get_value(chip,
-							     feature->beepNumber,
-							     &tmp))) {
-					sensorLog(LOG_ERR,
-						  "Error getting sensor data: %s/#%d: %s",
-						  chip->prefix,
-						  feature->beepNumber,
-						  sensors_strerror(ret));
-					ret = 21;
-				} else {
-					beep = (int) (tmp + 0.5);
-				}
-			}
-
-			for (subindex = 0; !ret &&
-				     (feature->dataNumbers[subindex] >= 0); ++ subindex) {
-				if ((ret = sensors_get_value(chip, feature->dataNumbers[subindex], values + subindex))) {
-					sensorLog(LOG_ERR, "Error getting sensor data: %s/#%d: %s", chip->prefix, feature->dataNumbers[subindex], sensors_strerror(ret));
-					ret = 23;
-				}
-			}
-			if (ret = 0) {
-				if (action = DO_RRD) { // arse = "N:"
-					if (feature->rrd) {
-						const char *rrded = feature->rrd (values);
-						strcat(strcat (rrdBuff, ":"),
-						       rrded ? rrded : "U");
-					}
-				} else {
-					const char *formatted = feature->format (values, alarm, beep);
-					if (formatted) {
-						if (action = DO_READ) {
-							sensorLog(LOG_INFO, "  %s: %s", label, formatted);
-						} else {
-							sensorLog(LOG_ALERT, "Sensor alarm: Chip %s: %s: %s", chipName(chip), label, formatted);
-						}
-					}
-				}
-			}
-		}
-		if (label)
-			free(label);
+		feature  = features + i;
+		do_features(chip, feature, action);
 	}
+
 	return ret;
 }
 
@@ -187,14 +227,16 @@
 
 static int doChips(int action)
 {
-	const sensors_chip_name *chip;
+	const sensors_chip_name *chip, *chip_arg;
 	int i, j, ret = 0;
 
-	for (j = 0; (ret = 0) && (j < sensord_args.numChipNames); ++ j) {
+	for (j = 0; j < sensord_args.numChipNames; j++) {
+		chip_arg = &sensord_args.chipNames[j];
 		i = 0;
-		while ((ret = 0) &&
-		       ((chip = sensors_get_detected_chips(&sensord_args.chipNames[j], &i)) != NULL)) {
+		while ((chip = sensors_get_detected_chips(chip_arg, &i))) {
 			ret = doChip(chip, action);
+			if (ret)
+				break;
 		}
 	}
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
