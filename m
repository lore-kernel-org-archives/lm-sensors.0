From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 26 Oct 2009 20:57:57 +0000
Subject: [lm-sensors] [PATCH v2 6/6] sensord: Break long lines in doChips()
Message-Id: <20091026205757.GG4725@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch breaks long lines in function doChips().
---

 prog/sensord/sense.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: sensors/prog/sensord/sense.c
=================================--- sensors.orig/prog/sensord/sense.c	2009-10-26 21:32:05.000000000 +0100
+++ sensors/prog/sensord/sense.c	2009-10-26 21:32:23.000000000 +0100
@@ -209,17 +209,18 @@
 
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
-
 	return ret;
 }
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
