From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 11 May 2009 16:01:11 +0000
Subject: [lm-sensors] [PATCH v2 2/7] sensord: Introduce struct
Message-Id: <20090511160111.GC17530@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Introduce struct sensord_args.

This structure encapsulate all the variables holding the commandline
arguments. So we get rid of plenty of extern variables. This reduces
namespace collisions and unifies access.

Changes in v2:

Removed needless intitialization in sensord_args.
---

 args.c    |   85 +++++++++++++++++++++++++++++---------------------------------
 args.h    |   30 +++++++++++++++++++++
 rrd.c     |   49 ++++++++++++++++++++---------------
 sense.c   |    6 ++--
 sensord.c |   47 ++++++++++++++++++----------------
 sensord.h |   16 -----------
 6 files changed, 128 insertions(+), 105 deletions(-)

Index: quilt-sensors/prog/sensord/args.h
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-sensors/prog/sensord/args.h	2009-04-26 20:17:18.000000000 +0200
@@ -0,0 +1,30 @@
+#ifndef SENSORD_ARGS_H
+#define SENSORD_ARGS_H
+
+#include <lib/sensors.h>
+
+#define MAX_CHIP_NAMES 32
+
+struct sensord_arguments {
+	int isDaemon;
+	const char *cfgFile;
+	const char *pidFile;
+	const char *rrdFile;
+	const char *cgiDir;
+	int scanTime;
+	int logTime;
+	int rrdTime;
+	int rrdNoAverage;
+	int syslogFacility;
+	int doScan;
+	int doSet;
+	int doCGI;
+	int doLoad;
+	int debug;
+	sensors_chip_name chipNames[MAX_CHIP_NAMES];
+	int numChipNames;
+};
+
+extern struct sensord_arguments sensord_args;
+
+#endif	/* SENSORD_ARGS_H */
Index: quilt-sensors/prog/sensord/args.c
=================================--- quilt-sensors.orig/prog/sensord/args.c	2009-04-22 21:21:46.000000000 +0200
+++ quilt-sensors/prog/sensord/args.c	2009-04-26 20:39:57.000000000 +0200
@@ -27,27 +27,18 @@
 #include <getopt.h>
 #include <syslog.h>
 
+#include "args.h"
 #include "sensord.h"
 #include "lib/error.h"
 #include "version.h"
 
-#define MAX_CHIP_NAMES 32
-
-int isDaemon = 0;
-const char *sensorsCfgFile = NULL;
-const char *pidFile = "/var/run/sensord.pid";
-const char *rrdFile = NULL;
-const char *cgiDir = NULL;
-int scanTime = 60;
-int logTime = 30 * 60;
-int rrdTime = 5 * 60;
-int rrdNoAverage = 0;
-int syslogFacility = LOG_LOCAL4;
-int doCGI = 0;
-int doLoad = 0;
-int debug = 0;
-sensors_chip_name chipNames[MAX_CHIP_NAMES];
-int numChipNames = 0;
+struct sensord_arguments sensord_args = {
+ 	.pidFile = "/var/run/sensord.pid",
+ 	.scanTime = 60,
+ 	.logTime = 30 * 60,
+ 	.rrdTime = 5 * 60,
+ 	.syslogFacility = LOG_LOCAL4,
+};
 
 static int parseTime(char *arg)
 {
@@ -148,53 +139,54 @@
 {
 	int c;
 
-	isDaemon = (argv[0][strlen (argv[0]) - 1] = 'd');
-	if (!isDaemon) {
+	sensord_args.isDaemon = (argv[0][strlen (argv[0]) - 1] = 'd');
+	if (!sensord_args.isDaemon) {
 		fprintf(stderr, "Sensord no longer runs as an commandline"
 			" application.\n");
-		return -1;
-	}
+  		return -1;
+  	}
 
 	while ((c = getopt_long(argc, argv, shortOptions, longOptions, NULL))
 	       != EOF) {
 		switch(c) {
 		case 'i':
-			if ((scanTime = parseTime(optarg)) < 0)
+			if ((sensord_args.scanTime = parseTime(optarg)) < 0)
 				return -1;
 			break;
 		case 'l':
-			if ((logTime = parseTime(optarg)) < 0)
+			if ((sensord_args.logTime = parseTime(optarg)) < 0)
 				return -1;
 			break;
 		case 't':
-			if ((rrdTime = parseTime(optarg)) < 0)
+			if ((sensord_args.rrdTime = parseTime(optarg)) < 0)
 				return -1;
 			break;
 		case 'T':
-			rrdNoAverage = 1;
+			sensord_args.rrdNoAverage = 1;
 			break;
 		case 'f':
-			if ((syslogFacility = parseFacility(optarg)) < 0)
+			sensord_args.syslogFacility = parseFacility(optarg);
+			if (sensord_args.syslogFacility < 0)
 				return -1;
 			break;
 		case 'a':
-			doLoad = 1;
+			sensord_args.doLoad = 1;
 			break;
 		case 'c':
-			sensorsCfgFile = optarg;
+			sensord_args.cfgFile = optarg;
 			break;
 		case 'p':
-			pidFile = optarg;
+			sensord_args.pidFile = optarg;
 			break;
 		case 'r':
-			rrdFile = optarg;
+			sensord_args.rrdFile = optarg;
 			break;
 		case 'd':
-			debug = 1;
+			sensord_args.debug = 1;
 			break;
 		case 'g':
-			doCGI = 1;
-			cgiDir = optarg;
+			sensord_args.doCGI = 1;
+			sensord_args.cgiDir = optarg;
 			break;
 		case 'v':
 			printf("sensord version %s\n", LM_VERSION);
@@ -219,19 +211,20 @@
 		}
 	}
 
-	if (doCGI && !rrdFile) {
+	if (sensord_args.doCGI && !sensord_args.rrdFile) {
 		fprintf(stderr,
 			"Error: Incompatible --rrd-cgi without --rrd-file.\n");
 		return -1;
 	}
 
-	if (rrdFile && !rrdTime) {
+	if (sensord_args.rrdFile && !sensord_args.rrdTime) {
 		fprintf(stderr,
 			"Error: Incompatible --rrd-file without --rrd-interval.\n");
 		return -1;
 	}
 
-	if (!logTime && !scanTime && !rrdFile) {
+	if (!sensord_args.logTime && !sensord_args.scanTime &&
+	    !sensord_args.rrdFile) {
 		fprintf(stderr,
 			"Error: No logging, alarm or RRD scanning.\n");
 		return -1;
@@ -243,11 +236,12 @@
 int parseChips(int argc, char **argv)
 {
 	if (optind = argc) {
-		chipNames[0].prefix = SENSORS_CHIP_NAME_PREFIX_ANY;
-		chipNames[0].bus.type = SENSORS_BUS_TYPE_ANY;
-		chipNames[0].bus.nr = SENSORS_BUS_NR_ANY;
-		chipNames[0].addr = SENSORS_CHIP_NAME_ADDR_ANY;
-		numChipNames = 1;
+		sensord_args.chipNames[0].prefix +			SENSORS_CHIP_NAME_PREFIX_ANY;
+		sensord_args.chipNames[0].bus.type = SENSORS_BUS_TYPE_ANY;
+		sensord_args.chipNames[0].bus.nr = SENSORS_BUS_NR_ANY;
+		sensord_args.chipNames[0].addr = SENSORS_CHIP_NAME_ADDR_ANY;
+		sensord_args.numChipNames = 1;
 	} else {
 		int i, n = argc - optind, err;
 		if (n > MAX_CHIP_NAMES) {
@@ -256,15 +250,18 @@
 		}
 		for (i = 0; i < n; ++ i) {
 			char *arg = argv[optind + i];
-			if ((err = sensors_parse_chip_name(arg,
-							   chipNames + i))) {
+
+			err = sensors_parse_chip_name(arg,
+						      sensord_args.chipNames +
+						      i);
+			if (err) {
 				fprintf(stderr,
 					"Invalid chip name `%s': %s\n", arg,
 					sensors_strerror(err));
 				return -1;
 			}
 		}
-		numChipNames = n;
+		sensord_args.numChipNames = n;
 	}
 	return 0;
 }
Index: quilt-sensors/prog/sensord/rrd.c
=================================--- quilt-sensors.orig/prog/sensord/rrd.c	2009-04-20 19:51:41.000000000 +0200
+++ quilt-sensors/prog/sensord/rrd.c	2009-04-26 20:17:18.000000000 +0200
@@ -43,6 +43,7 @@
 
 #include <rrd.h>
 
+#include "args.h"
 #include "sensord.h"
 
 #define DO_READ 0
@@ -141,9 +142,9 @@
 	const sensors_chip_name *chip;
 	int i, j, ret = 0, num = 0;
 
-	for (j = 0; (ret = 0) && (j < numChipNames); ++ j) {
+	for (j = 0; (ret = 0) && (j < sensord_args.numChipNames); ++ j) {
 		i = 0;
-		while ((ret = 0) && ((chip = sensors_get_detected_chips(&chipNames[j], &i)) != NULL)) {
+		while ((ret = 0) && ((chip = sensors_get_detected_chips(&sensord_args.chipNames[j], &i)) != NULL)) {
 			int index0, chipindex = -1;
 
 			/* Trick: we compare addresses here. We know it works
@@ -223,8 +224,8 @@
 		 * number of seconds downtime during which average be used
 		 * instead of unknown
 		 */
-		sprintf(ptr, "DS:%s:GAUGE:%d:%s:%s", rawLabel, 5 * rrdTime,
-			min, max);
+		sprintf(ptr, "DS:%s:GAUGE:%d:%s:%s", rawLabel, 5 *
+			sensord_args.rrdTime, min, max);
 	}
 	return 0;
 }
@@ -234,7 +235,7 @@
 	int ret = 0;
 	struct ds data = { 0, argv};
 	ret = applyToFeatures(rrdGetSensors_DS, &data);
-	if (!ret && doLoad)
+	if (!ret && sensord_args.doLoad)
 		ret = rrdGetSensors_DS(&data, LOADAVG, LOAD_AVERAGE, NULL);
 	return ret ? -1 : data.num;
 }
@@ -245,12 +246,12 @@
 	struct stat tmp;
 
 	sensorLog(LOG_DEBUG, "sensor RRD init");
-	if (stat(rrdFile, &tmp)) {
+	if (stat(sensord_args.rrdFile, &tmp)) {
 		if (errno = ENOENT) {
 			char stepBuff[STEP_BUFF], rraBuff[RRA_BUFF];
 			int argc = 4, num;
 			const char *argv[6 + MAX_RRD_SENSORS] = {
-				"sensord", rrdFile, "-s", stepBuff
+				"sensord", sensord_args.rrdFile, "-s", stepBuff
 			};
 
 			sensorLog(LOG_INFO, "creating round robin database");
@@ -258,17 +259,21 @@
 			if (num = 0) {
 				sensorLog(LOG_ERR,
 					  "Error creating RRD: %s: %s",
-					  rrdFile, "No sensors detected");
+					  sensord_args.rrdFile,
+					  "No sensors detected");
 				ret = 2;
 			} else if (num < 0) {
 				ret = -num;
 			} else {
-				sprintf(stepBuff, "%d", rrdTime);
+				sprintf(stepBuff, "%d", sensord_args.rrdTime);
 				sprintf(rraBuff, "RRA:%s:%f:%d:%d",
-					rrdNoAverage?"LAST":"AVERAGE",
+					sensord_args.rrdNoAverage ? "LAST" :
+					"AVERAGE",
 					0.5 /* fraction of non-unknown samples needed per entry */,
 					1 /* samples per entry */,
-					7 * 24 * 60 * 60 / rrdTime /* 1 week */);
+					7 * 24 * 60 * 60 /
+					sensord_args.rrdTime /* 1 week */);
+
 				argc += num;
 				argv[argc ++] = rraBuff;
 				argv[argc] = NULL;
@@ -276,12 +281,13 @@
 						      (char **) /* WEAK */ argv))) {
 					sensorLog(LOG_ERR,
 						  "Error creating RRD file: %s: %s",
-						  rrdFile, rrd_get_error());
+						  sensord_args.rrdFile,
+						  rrd_get_error());
 				}
 			}
 		} else {
 			sensorLog(LOG_ERR, "Error stat()ing RRD: %s: %s",
-				  rrdFile, strerror(errno));
+				  sensord_args.rrdFile, strerror(errno));
 			ret = 1;
 		}
 	}
@@ -310,8 +316,8 @@
 	struct gr *data = (struct gr *) _data;
 	(void) label; /* no warning */
 	if (!feature || (feature->rrd && (feature->type = data->type)))
-		printf("\n\tDEF:%s=%s:%s:AVERAGE", rawLabel, rrdFile,
-		       rawLabel);
+		printf("\n\tDEF:%s=%s:%s:AVERAGE", rawLabel,
+		       sensord_args.rrdFile, rawLabel);
 	return 0;
 }
 
@@ -420,7 +426,8 @@
 int rrdUpdate(void)
 {
 	int ret = rrdChips ();
-	if (!ret && doLoad) {
+
+	if (!ret && sensord_args.doLoad) {
 		FILE *loadavg;
 		if (!(loadavg = fopen("/proc/loadavg", "r"))) {
 			sensorLog(LOG_ERR,
@@ -442,11 +449,11 @@
 	}
 	if (!ret) {
 		const char *argv[] = {
-			"sensord", rrdFile, rrdBuff, NULL
+			"sensord", sensord_args.rrdFile, rrdBuff, NULL
 		};
 		if ((ret = rrd_update(3, (char **) /* WEAK */ argv))) {
 			sensorLog(LOG_ERR, "Error updating RRD file: %s: %s",
-				  rrdFile, rrd_get_error());
+				  sensord_args.rrdFile, rrd_get_error());
 		}
 	}
 	sensorLog(LOG_DEBUG, "sensor rrd updated");
@@ -463,17 +470,17 @@
 	while (graph->type != DataType_other) {
 		printf("<H2>%s</H2>\n", graph->h2);
 		printf("<P>\n<RRD::GRAPH %s/%s.png\n\t--imginfo '<IMG SRC=" WWWDIR "/%%s WIDTH=%%lu HEIGHT=%%lu>'\n\t-a PNG\n\t-h 200 -w 800\n",
-		       cgiDir, graph->image);
+		       sensord_args.cgiDir, graph->image);
 		printf("\t--lazy\n\t-v '%s'\n\t-t '%s'\n\t-x '%s'\n\t%s",
 		       graph->axisTitle, graph->title, graph->axisDefn,
 		       graph->options);
 		if (!ret)
 			ret = applyToFeatures(rrdCGI_DEF, graph);
-		if (!ret && doLoad && graph->loadAvg)
+		if (!ret && sensord_args.doLoad && graph->loadAvg)
 			ret = rrdCGI_DEF(graph, LOADAVG, LOAD_AVERAGE, NULL);
 		if (!ret)
 			ret = applyToFeatures(rrdCGI_LINE, graph);
-		if (!ret && doLoad && graph->loadAvg)
+		if (!ret && sensord_args.doLoad && graph->loadAvg)
 			ret = rrdCGI_LINE(graph, LOADAVG, LOAD_AVERAGE, NULL);
 		printf (">\n</P>\n");
 		++ graph;
Index: quilt-sensors/prog/sensord/sensord.c
=================================--- quilt-sensors.orig/prog/sensord/sensord.c	2009-04-22 21:21:46.000000000 +0200
+++ quilt-sensors/prog/sensord/sensord.c	2009-04-26 21:02:57.000000000 +0200
@@ -33,6 +33,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
+#include "args.h"
 #include "sensord.h"
 
 static int logOpened = 0;
@@ -52,7 +53,7 @@
 	vsnprintf(buffer, LOG_BUFFER, fmt, ap);
 	buffer[LOG_BUFFER] = '\0';
 	va_end(ap);
-	if (debug || (priority < LOG_DEBUG)) {
+	if (sensord_args.debug || (priority < LOG_DEBUG)) {
 		if (logOpened) {
 			syslog(priority, "%s", buffer);
 		} else {
@@ -83,31 +84,33 @@
 	 * First RRD update at next RRD timeslot to prevent failures due
 	 * one timeslot updated twice on restart for example.
 	 */
-	int rrdValue = rrdTime - time(NULL) % rrdTime;
+	int rrdValue = sensord_args.rrdTime - time(NULL) %
+		sensord_args.rrdTime;
 
 	sensorLog(LOG_INFO, "sensord started");
 
 	while (!done) {
 		if (reload) {
-			ret = reloadLib(sensorsCfgFile);
+			ret = reloadLib(sensord_args.cfgFile);
 			if (ret)
 				sensorLog(LOG_NOTICE,
 					  "config reload error (%d)", ret);
 			reload = 0;
 		}
-		if (scanTime && (scanValue <= 0)) {
+		if (sensord_args.scanTime && (scanValue <= 0)) {
 			if ((ret = scanChips()))
 				sensorLog(LOG_NOTICE,
 					  "sensor scan error (%d)", ret);
-			scanValue += scanTime;
+			scanValue += sensord_args.scanTime;
 		}
-		if (logTime && (logValue <= 0)) {
+		if (sensord_args.logTime && (logValue <= 0)) {
 			if ((ret = readChips()))
 				sensorLog(LOG_NOTICE,
 					  "sensor read error (%d)", ret);
-			logValue += logTime;
+			logValue += sensord_args.logTime;
 		}
-		if (rrdTime && rrdFile && (rrdValue <= 0)) {
+		if (sensord_args.rrdTime && sensord_args.rrdFile &&
+		    (rrdValue <= 0)) {
 			if ((ret = rrdUpdate()))
 				sensorLog(LOG_NOTICE,
 					  "rrd update error (%d)", ret);
@@ -116,12 +119,14 @@
 			 * same method as in RRD instead of simply adding the
 			 * interval.
 			 */
-			rrdValue = rrdTime - time(NULL) % rrdTime;
+			rrdValue = sensord_args.rrdTime - time(NULL) %
+				sensord_args.rrdTime;
 		}
 		if (!done) {
-			int a = logTime ? logValue : INT_MAX;
-			int b = scanTime ? scanValue : INT_MAX;
-			int c = (rrdTime && rrdFile) ? rrdValue : INT_MAX;
+			int a = sensord_args.logTime ? logValue : INT_MAX;
+			int b = sensord_args.scanTime ? scanValue : INT_MAX;
+			int c = (sensord_args.rrdTime && sensord_args.rrdFile)
+				? rrdValue : INT_MAX;
 			int sleepTime = (a < b) ? ((a < c) ? a : c) :
 				((b < c) ? b : c);
 			sleep(sleepTime);
@@ -138,7 +143,7 @@
 
 static void openLog(void)
 {
-	openlog("sensord", 0, syslogFacility);
+	openlog("sensord", 0, sensord_args.syslogFacility);
 	logOpened = 1;
 }
 
@@ -153,16 +158,16 @@
 		exit(EXIT_FAILURE);
 	}
 
-	if (!(stat(pidFile, &fileStat)) &&
+	if (!(stat(sensord_args.pidFile, &fileStat)) &&
 	    ((!S_ISREG(fileStat.st_mode)) || (fileStat.st_size > 11))) {
 		fprintf(stderr,
 			"Error: PID file `%s' already exists and looks suspicious.\n",
-			pidFile);
+			sensord_args.pidFile);
 		exit(EXIT_FAILURE);
 	}
 
-	if (!(file = fopen(pidFile, "w"))) {
-		fprintf(stderr, "fopen(\"%s\"): %s\n", pidFile,
+	if (!(file = fopen(sensord_args.pidFile, "w"))) {
+		fprintf(stderr, "fopen(\"%s\"): %s\n", sensord_args.pidFile,
 			strerror(errno));
 		exit(EXIT_FAILURE);
 	}
@@ -197,7 +202,7 @@
 
 static void undaemonize(void)
 {
-	unlink(pidFile);
+	unlink(sensord_args.pidFile);
 	closelog();
 }
 
@@ -209,18 +214,18 @@
 	    parseChips(argc, argv))
 		exit(EXIT_FAILURE);
 
-	if (loadLib(sensorsCfgFile))
+	if (loadLib(sensord_args.cfgFile))
 		exit(EXIT_FAILURE);
 
 	openLog();
 
-	if (rrdFile) {
+	if (sensord_args.rrdFile) {
 		ret = rrdInit();
 		if (ret)
 			exit(EXIT_FAILURE);
 	}
 
-	if (doCGI) {
+	if (sensord_args.doCGI) {
 		ret = rrdCGI();
 	} else {
 		daemonize();
Index: quilt-sensors/prog/sensord/sense.c
=================================--- quilt-sensors.orig/prog/sensord/sense.c	2009-04-20 19:51:41.000000000 +0200
+++ quilt-sensors/prog/sensord/sense.c	2009-04-26 20:17:18.000000000 +0200
@@ -26,6 +26,7 @@
 #include <string.h>
 #include <syslog.h>
 
+#include "args.h"
 #include "sensord.h"
 #include "lib/error.h"
 
@@ -189,11 +190,10 @@
 	const sensors_chip_name *chip;
 	int i, j, ret = 0;
 
-	for (j = 0; (ret = 0) && (j < numChipNames); ++ j) {
+	for (j = 0; (ret = 0) && (j < sensord_args.numChipNames); ++ j) {
 		i = 0;
 		while ((ret = 0) &&
-		       ((chip = sensors_get_detected_chips(&chipNames[j], &i))
-			!= NULL)) {
+		       ((chip = sensors_get_detected_chips(&sensord_args.chipNames[j], &i)) != NULL)) {
 			ret = doChip(chip, action);
 		}
 	}
Index: quilt-sensors/prog/sensord/sensord.h
=================================--- quilt-sensors.orig/prog/sensord/sensord.h	2009-04-22 21:21:46.000000000 +0200
+++ quilt-sensors/prog/sensord/sensord.h	2009-04-26 21:04:40.000000000 +0200
@@ -27,22 +27,6 @@
 
 /* from args.c */
 
-extern int isDaemon;
-extern const char *sensorsCfgFile;
-extern const char *pidFile;
-extern const char *rrdFile;
-extern const char *cgiDir;
-extern int scanTime;
-extern int logTime;
-extern int rrdTime;
-extern int rrdNoAverage;
-extern int syslogFacility;
-extern int doCGI;
-extern int doLoad;
-extern int debug;
-extern sensors_chip_name chipNames[];
-extern int numChipNames;
-
 extern int parseArgs(int argc, char **argv);
 extern int parseChips(int argc, char **argv);
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
