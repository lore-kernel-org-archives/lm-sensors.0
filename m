From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 11 May 2009 16:04:01 +0000
Subject: [lm-sensors] [PATCH v2 4/7] sensord: Refactoring of parseChips()
Message-Id: <20090511160401.GE17530@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Did some refactoring in parseChips(). This fixes some deep indentation
levels.

Changes in v2:

Make condition (are there chips arguments?) easier to read.
Removed withspace (coding style).
---

 args.c |   39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

Index: quilt-sensors/prog/sensord/args.c
=================================--- quilt-sensors.orig/prog/sensord/args.c	2009-04-26 21:19:41.000000000 +0200
+++ quilt-sensors/prog/sensord/args.c	2009-04-26 21:21:49.000000000 +0200
@@ -231,33 +231,34 @@
 
 int parseChips(int argc, char **argv)
 {
-	if (optind = argc) {
+	int i, n = argc - optind, err;
+
+	if (n = 0) {
 		sensord_args.chipNames[0].prefix  			SENSORS_CHIP_NAME_PREFIX_ANY;
 		sensord_args.chipNames[0].bus.type = SENSORS_BUS_TYPE_ANY;
 		sensord_args.chipNames[0].bus.nr = SENSORS_BUS_NR_ANY;
 		sensord_args.chipNames[0].addr = SENSORS_CHIP_NAME_ADDR_ANY;
 		sensord_args.numChipNames = 1;
-	} else {
-		int i, n = argc - optind, err;
-		if (n > MAX_CHIP_NAMES) {
-			fprintf(stderr, "Too many chip names.\n");
-			return -1;
-		}
-		for (i = 0; i < n; ++ i) {
-			char *arg = argv[optind + i];
 
-			err = sensors_parse_chip_name(arg,
-						      sensord_args.chipNames +
-						      i);
-			if (err) {
-				fprintf(stderr,
-					"Invalid chip name `%s': %s\n", arg,
-					sensors_strerror(err));
-				return -1;
-			}
+		return 0;
+	}
+
+	if (n > MAX_CHIP_NAMES) {
+		fprintf(stderr, "Too many chip names.\n");
+		return -1;
+	}
+	for (i = 0; i < n; ++i) {
+		char *arg = argv[optind + i];
+
+		err = sensors_parse_chip_name(arg, sensord_args.chipNames + i);
+		if (err) {
+			fprintf(stderr,	"Invalid chip name `%s': %s\n", arg,
+				sensors_strerror(err));
+			return -1;
 		}
-		sensord_args.numChipNames = n;
 	}
+	sensord_args.numChipNames = n;
+
 	return 0;
 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
