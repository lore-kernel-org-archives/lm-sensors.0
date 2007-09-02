From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Sep 2007 20:17:16 +0000
Subject: [lm-sensors] [PATCH 4/7] libsensors4: Renumber the features linearly
Message-Id: <20070902221716.44fa795d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Renumber the features linearly, so that feature number N is at
position N in the array. This allows for O(1) look-ups, as opposed
to O(N) before. This makes sensors_lookup_feature_nr() 2.4 times
faster in my real-world tests, resulting in a 6% performance boost
on average in the runtime part of "sensors".

---
 lib/access.c |    8 ++------
 lib/sysfs.c  |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

--- lm-sensors-3.orig/lib/sysfs.c	2007-09-02 16:17:16.000000000 +0200
+++ lm-sensors-3/lib/sysfs.c	2007-09-02 16:17:52.000000000 +0200
@@ -178,6 +178,21 @@ static int sensors_read_dynamic_chip(sen
 		}
 	}
 
+	/* Renumber the features linearly, so that feature number N is at
+	   position N in the array. This allows for O(1) look-ups. */
+	for (i = 0; i < fnum; i++) {
+		int j, old;
+
+		old = dyn_features[i].data.number;
+		dyn_features[i].data.number = i;
+		for (j = i + 1;
+		     j < fnum && dyn_features[j].data.mapping != SENSORS_NO_MAPPING;
+		     j++) {
+			if (dyn_features[j].data.mapping = old)
+				dyn_features[j].data.mapping = i;
+		}
+	}
+
 	chip->feature = dyn_features;
 
 exit_free:
--- lm-sensors-3.orig/lib/access.c	2007-09-02 16:17:16.000000000 +0200
+++ lm-sensors-3/lib/access.c	2007-09-02 16:17:52.000000000 +0200
@@ -92,15 +92,11 @@ sensors_for_all_config_chips(const senso
 const sensors_chip_feature *sensors_lookup_feature_nr(const sensors_chip_name *chip,
 						      int feature)
 {
-	int i, j;
-	const sensors_chip_feature *features;
+	int i;
 
 	for (i = 0; i < sensors_proc_chips_count; i++)
 		if (sensors_match_chip(&sensors_proc_chips[i].chip, chip)) {
-			features = sensors_proc_chips[i].feature;
-			for (j = 0; features[j].data.name; j++)
-				if (features[j].data.number = feature)
-					return features + j;
+			return sensors_proc_chips[i].feature + feature;
 		}
 	return NULL;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
