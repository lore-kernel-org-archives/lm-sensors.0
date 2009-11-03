From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 03 Nov 2009 20:03:43 +0000
Subject: [lm-sensors] [PATCH v3 7/8] sensord: Evaluate return value of
Message-Id: <20091103200343.GI4724@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Evaluate return value of idChip().

Some of the functions called from idChip() can fail which means
idChip() can return an error. Callers of idChip() should be aware of
this.
---
 prog/sensord/sense.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

Index: sensors/prog/sensord/sense.c
=================================--- sensors.orig/prog/sensord/sense.c	2009-11-03 20:20:10.000000000 +0100
+++ sensors/prog/sensord/sense.c	2009-11-03 20:28:44.000000000 +0100
@@ -45,12 +45,23 @@
 
 static int idChip(const sensors_chip_name *chip)
 {
-	const char *adapter;
+	const char *name, *adapter;
+
+	name = chipName(chip);
+	if (!name) {
+		sensorLog(LOG_ERR, "Error getting chip name");
+		return -1;
+	}
+
+	sensorLog(LOG_INFO, "Chip: %s", name);
 
-	sensorLog(LOG_INFO, "Chip: %s", chipName(chip));
 	adapter = sensors_get_adapter_name(&chip->bus);
-	if (adapter)
-		sensorLog(LOG_INFO, "Adapter: %s", adapter);
+	if (!adapter) {
+		sensorLog(LOG_ERR, "Error getting adapter name");
+		return -1;
+	}
+
+	sensorLog(LOG_INFO, "Adapter: %s", adapter);
 
 	return 0;
 }
@@ -151,8 +162,11 @@
 	const FeatureDescriptor *features = descriptor->features;
 	int i, ret = 0;
 
-	if (action = DO_READ)
+	if (action = DO_READ) {
 		ret = idChip(chip);
+		if (ret)
+			return ret;
+	}
 
 	for (i = 0; features[i].format; i++) {
 		ret = do_features(chip, features + i, action);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
