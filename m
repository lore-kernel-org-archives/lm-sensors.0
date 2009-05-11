From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 11 May 2009 16:00:23 +0000
Subject: [lm-sensors] [PATCH v2 1/7] sensord: Remove commandline interface.
Message-Id: <20090511160022.GB17530@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Remove the hidden commandline interface of sensord.

Sensord can be invoked as an console application. Therefor a link
named sensors pointing to sensord is needed. That is very
intransparent and IMO useless. Printing sensor values to console is
done by the sensors tool.

Changes in v2:

Remove references to isDaemon.
Rename daemonShortOptions to shortOptions and daemonLongOptions to
longOptions.
Remove commandline flags doScan and doSet. They are needless without
the CLI.
Cleanup main().

Jean, there is some more useless stuff after the removal of the CLI
(e.g. the DO_SET action in doChip). I would prefer first to get this
series applied and remove the remaining stuff in further patches. Is
this OK for you?
---

 args.c    |   69 ++++++++------------------------------------------------------
 sensord.c |   23 +++++++-------------
 sensord.h |    2 -
 3 files changed, 17 insertions(+), 77 deletions(-)

Index: quilt-sensors/prog/sensord/args.c
=================================--- quilt-sensors.orig/prog/sensord/args.c	2009-04-20 19:51:41.000000000 +0200
+++ quilt-sensors/prog/sensord/args.c	2009-04-20 20:56:54.000000000 +0200
@@ -43,8 +43,6 @@
 int rrdTime = 5 * 60;
 int rrdNoAverage = 0;
 int syslogFacility = LOG_LOCAL4;
-int doScan = 0;
-int doSet = 0;
 int doCGI = 0;
 int doLoad = 0;
 int debug = 0;
@@ -127,22 +125,9 @@
 	"the RRD file configuration must EXACTLY match the sensors that are used. If\n"
 	"your configuration changes, delete the old RRD file and restart sensord.\n";
 
-static const char *appSyntax -	"  -a, --alarm-scan          -- only scan for alarms\n"
-	"  -s, --set                 -- execute set statements (root only)\n"
-	"  -r, --rrd-file <file>     -- only update RRD file\n"
-	"  -c, --config-file <file>  -- configuration file\n"
-	"  -d, --debug               -- display some debug information\n"
-	"  -v, --version             -- display version and exit\n"
-	"  -h, --help                -- display help and exit\n"
-	"\n"
-	"Specify the filename `-' to read the config file from stdin.\n"
-	"\n"
-	"If no chips are specified, all chip info will be printed.\n";
-
-static const char *daemonShortOptions = "i:l:t:Tf:r:c:p:advhg:";
+static const char *shortOptions = "i:l:t:Tf:r:c:p:advhg:";
 
-static const struct option daemonLongOptions[] = {
+static const struct option longOptions[] = {
 	{ "interval", required_argument, NULL, 'i' },
 	{ "log-interval", required_argument, NULL, 'l' },
 	{ "rrd-interval", required_argument, NULL, 't' },
@@ -159,28 +144,16 @@
 	{ NULL, 0, NULL, 0 }
 };
 
-static const char *appShortOptions = "asr:c:dvh";
-
-static const struct option appLongOptions[] = {
-	{ "alarm-scan", no_argument, NULL, 'a' },
-	{ "set", no_argument, NULL, 's' },
-	{ "rrd-file", required_argument, NULL, 'r' },
-	{ "config-file", required_argument, NULL, 'c' },
-	{ "debug", no_argument, NULL, 'd' },
-	{ "version", no_argument, NULL, 'v' },
-	{ "help", no_argument, NULL, 'h' },
-	{ NULL, 0, NULL, 0 }
-};
-
 int parseArgs(int argc, char **argv)
 {
 	int c;
-	const char *shortOptions;
-	const struct option *longOptions;
 
 	isDaemon = (argv[0][strlen (argv[0]) - 1] = 'd');
-	shortOptions = isDaemon ? daemonShortOptions : appShortOptions;
-	longOptions = isDaemon ? daemonLongOptions : appLongOptions;
+	if (!isDaemon) {
+		fprintf(stderr, "Sensord no longer runs as an commandline"
+			" application.\n");
+		return -1;
+	}
 
 	while ((c = getopt_long(argc, argv, shortOptions, longOptions, NULL))
 	       != EOF) {
@@ -205,13 +178,7 @@
 				return -1;
 			break;
 		case 'a':
-			if (isDaemon)
-				doLoad = 1;
-			else
-				doScan = 1;
-			break;
-		case 's':
-			doSet = 1;
+			doLoad = 1;
 			break;
 		case 'c':
 			sensorsCfgFile = optarg;
@@ -235,7 +202,7 @@
 			break;
 		case 'h':
 			printf("Syntax: %s {options} {chips}\n%s", argv[0],
-			       isDaemon ? daemonSyntax : appSyntax);
+			       daemonSyntax);
 			exit(EXIT_SUCCESS);
 			break;
 		case ':':
@@ -252,24 +219,6 @@
 		}
 	}
 
-	if (doScan && doSet) {
-		fprintf(stderr,
-			"Error: Incompatible --set and --alarm-scan.\n");
-		return -1;
-	}
-
-	if (rrdFile && doSet) {
-		fprintf(stderr,
-			"Error: Incompatible --set and --rrd-file.\n");
-		return -1;
-	}
-
-	if (doScan && rrdFile) {
-		fprintf(stderr,
-			"Error: Incompatible --rrd-file and --alarm-scan.\n");
-		return -1;
-	}
-
 	if (doCGI && !rrdFile) {
 		fprintf(stderr,
 			"Error: Incompatible --rrd-cgi without --rrd-file.\n");
Index: quilt-sensors/prog/sensord/sensord.c
=================================--- quilt-sensors.orig/prog/sensord/sensord.c	2009-04-20 20:38:05.000000000 +0200
+++ quilt-sensors/prog/sensord/sensord.c	2009-04-20 20:39:24.000000000 +0200
@@ -212,27 +212,20 @@
 	if (loadLib(sensorsCfgFile))
 		exit(EXIT_FAILURE);
 
-	if (isDaemon)
-		openLog();
-	if (rrdFile)
+	openLog();
+
+	if (rrdFile) {
 		ret = rrdInit();
+		if (ret)
+			exit(EXIT_FAILURE);
+	}
 
-	if (ret) {
-	} else if (doCGI) {
+	if (doCGI) {
 		ret = rrdCGI();
-	} else if (isDaemon) {
+	} else {
 		daemonize();
 		ret = sensord();
 		undaemonize();
-	} else {
-		if (doSet)
-			ret = setChips();
-		else if (doScan)
-			ret = scanChips();
-		else if (rrdFile)
-			ret = rrdUpdate();
-		else
-			ret = readChips();
 	}
 
 	if (unloadLib())
Index: quilt-sensors/prog/sensord/sensord.h
=================================--- quilt-sensors.orig/prog/sensord/sensord.h	2009-04-20 20:57:24.000000000 +0200
+++ quilt-sensors/prog/sensord/sensord.h	2009-04-20 21:32:47.000000000 +0200
@@ -37,8 +37,6 @@
 extern int rrdTime;
 extern int rrdNoAverage;
 extern int syslogFacility;
-extern int doScan;
-extern int doSet;
 extern int doCGI;
 extern int doLoad;
 extern int debug;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
