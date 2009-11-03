From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 03 Nov 2009 20:04:07 +0000
Subject: [lm-sensors] [PATCH v3 8/8] sensord: Break long lines in doChips()
Message-Id: <20091103200407.GJ4724@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch breaks long lines in function doChips().

Changes in v3:

* Use return to leave the loop.
---
 prog/sensord/sense.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: sensors/prog/sensord/sense.c
=================================--- sensors.orig/prog/sensord/sense.c	2009-10-31 20:53:26.000000000 +0100
+++ sensors/prog/sensord/sense.c	2009-10-31 21:03:47.000000000 +0100
@@ -219,17 +219,18 @@
 
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
+				return ret;
 		}
 	}
-
 	return ret;
 }
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
