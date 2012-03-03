From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Mar 2012 21:25:36 +0000
Subject: [lm-sensors] [PATCH 1/3] sensord: Fix memory leaks revealed by valgrind
Message-Id: <20120303222536.10db6cae@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The leak in daemonize() is harmless, we're about to exit anyway. Fix
it still to make valgrind happy.

The leak in do_features() is real, as the function is called
periodically by the daemon, for all actions. If the intervals at set
low and the system has many sensors, the leak could be significant,
maybe 150 kB/day.
---
 prog/sensord/sense.c   |   22 +++++++++++++---------
 prog/sensord/sensord.c |    6 +++++-
 2 files changed, 18 insertions(+), 10 deletions(-)

--- lm-sensors.orig/prog/sensord/sensord.c	2009-06-20 11:58:07.000000000 +0200
+++ lm-sensors/prog/sensord/sensord.c	2012-03-02 20:30:48.050146653 +0100
@@ -204,7 +204,11 @@ static void daemonize(void)
 	} else if (pid != 0) {
 		fprintf(file, "%d\n", pid);
 		fclose(file);
-		unloadLib();
+
+		freeChips();
+		if (unloadLib())
+			exit(EXIT_FAILURE);
+
 		exit(EXIT_SUCCESS);
 	}
 
--- lm-sensors.orig/prog/sensord/sense.c	2009-11-05 10:20:28.000000000 +0100
+++ lm-sensors/prog/sensord/sense.c	2012-03-02 20:56:17.677852135 +0100
@@ -132,14 +132,7 @@ static int do_features(const sensors_chi
 		       const FeatureDescriptor *feature, int action)
 {
 	char *label;
-	int alrm, beep;
-
-	label = sensors_get_label(chip, feature->feature);
-	if (!label) {
-		sensorLog(LOG_ERR, "Error getting sensor label: %s/%s",
-			  chip->prefix, feature->feature->name);
-		return -1;
-	}
+	int alrm, beep, ret;
 
 	alrm = get_flag(chip, feature->alarmNumber);
 	if (alrm = -1)
@@ -151,7 +144,18 @@ static int do_features(const sensors_chi
 	if (beep = -1)
 		return -1;
 
-	return get_features(chip, feature, action, label, alrm, beep);
+	label = sensors_get_label(chip, feature->feature);
+	if (!label) {
+		sensorLog(LOG_ERR, "Error getting sensor label: %s/%s",
+			  chip->prefix, feature->feature->name);
+		return -1;
+	}
+
+	ret = get_features(chip, feature, action, label, alrm, beep);
+
+	free(label);
+
+	return ret;
 }
 
 static int doKnownChip(const sensors_chip_name *chip,

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
