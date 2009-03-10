From: Andre Prendel <andre_prendel@gmx.de>
Date: Tue, 10 Mar 2009 08:30:14 +0000
Subject: [lm-sensors] [PATCH] sensord: Remove leading whitespaces in empty
Message-Id: <20090310083014.GA5543@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

as you noticed about my last patch series, there were some whitespaces
in the code. Unfortunately quilt complains only about trailing
whitespaces, not leading ones in empty lines. So there are some ones left.

With this patch we get rid of the remaining ones.

Andre

--
 args.c  |    8 ++++----
 chips.c |    6 +++---
 rrd.c   |   14 +++++++-------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff -ur quilt-sensors/prog/sensord/args.c sensors-whitespace/prog/sensord/args.c
--- quilt-sensors/prog/sensord/args.c	2009-03-09 16:26:22.000000000 +0100
+++ sensors-whitespace/prog/sensord/args.c	2009-03-09 23:49:06.000000000 +0100
@@ -257,13 +257,13 @@
 			"Error: Incompatible --set and --alarm-scan.\n");
 		return -1;
 	}
-  
+
 	if (rrdFile && doSet) {
 		fprintf(stderr,
 			"Error: Incompatible --set and --rrd-file.\n");
 		return -1;
 	}
-  
+
 	if (doScan && rrdFile) {
 		fprintf(stderr,
 			"Error: Incompatible --rrd-file and --alarm-scan.\n");
@@ -275,13 +275,13 @@
 			"Error: Incompatible --rrd-cgi without --rrd-file.\n");
 		return -1;
 	}
-  
+
 	if (rrdFile && !rrdTime) {
 		fprintf(stderr,
 			"Error: Incompatible --rrd-file without --rrd-interval.\n");
 		return -1;
 	}
-  
+
 	if (!logTime && !scanTime && !rrdFile) {
 		fprintf(stderr,
 			"Error: No logging, alarm or RRD scanning.\n");
diff -ur quilt-sensors/prog/sensord/chips.c sensors-whitespace/prog/sensord/chips.c
--- quilt-sensors/prog/sensord/chips.c	2009-03-09 16:26:22.000000000 +0100
+++ sensors-whitespace/prog/sensord/chips.c	2009-03-09 23:49:33.000000000 +0100
@@ -157,7 +157,7 @@
 	} else {
 		voltage->format = fmtVolt_2;
 	}
-  
+
 	/* terminate the list */
 	voltage->dataNumbers[pos] = -1;
 
@@ -213,7 +213,7 @@
 	} else {
 		temperature->format = fmtTemp_only;
 	}
-  
+
 	/* terminate the list */
 	temperature->dataNumbers[pos] = -1;
 
@@ -265,7 +265,7 @@
 	} else {
 		fan->format = fmtFan_only;
 	}
-  
+
 	/* terminate the list */
 	fan->dataNumbers[pos] = -1;
 
diff -ur quilt-sensors/prog/sensord/rrd.c sensors-whitespace/prog/sensord/rrd.c
--- quilt-sensors/prog/sensord/rrd.c	2009-03-09 16:26:23.000000000 +0100
+++ sensors-whitespace/prog/sensord/rrd.c	2009-03-09 23:51:05.000000000 +0100
@@ -23,7 +23,7 @@
 
 /*
  * RRD is the Round Robin Database
- * 
+ *
  * Get this package from:
  *   http://people.ee.ethz.ch/~oetiker/webtools/rrdtool/
  *
@@ -87,7 +87,7 @@
 {
 	char *buffer = rrdLabels[index0];
 	int i, j, okay;
-  
+
 	i = 0;
 	/* contrain raw label to [A-Za-z0-9_] */
 	while ((i < RAW_LABEL_LENGTH) && rawLabel[i]) {
@@ -243,7 +243,7 @@
 {
 	int ret = 0;
 	struct stat tmp;
-  
+
 	sensorLog(LOG_DEBUG, "sensor RRD init");
 	if (stat(rrdFile, &tmp)) {
 		if (errno = ENOENT) {
@@ -252,7 +252,7 @@
 			const char *argv[6 + MAX_RRD_SENSORS] = {
 				"sensord", rrdFile, "-s", stepBuff
 			};
-      
+
 			sensorLog(LOG_INFO, "creating round robin database");
 			num = rrdGetSensors(argv + argc);
 			if (num = 0) {
@@ -286,7 +286,7 @@
 		}
 	}
 	sensorLog(LOG_DEBUG, "sensor RRD inited");
-  
+
 	return ret;
 }
 
@@ -450,7 +450,7 @@
 		}
 	}
 	sensorLog(LOG_DEBUG, "sensor rrd updated");
-  
+
 	return ret;
 }
 
@@ -480,6 +480,6 @@
 	}
 	printf("<p>\n<small><b>sensord</b> by <a href=\"mailto:merlin@merlin.org\">Merlin Hughes</a>, all credit to the <a href=\"http://www.lm-sensors.org/\">lm_sensors</a> crew.</small>\n</p>\n");
 	printf("</BODY>\n</HTML>\n");
-  
+
 	return ret;
 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
