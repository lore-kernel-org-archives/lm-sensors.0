From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 06 Apr 2009 07:56:18 +0000
Subject: [lm-sensors] [PATCH 1/8] sensord: Remove commandline interface.
Message-Id: <20090406075618.GB4734@ubuntu>
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
---

 args.c |   38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

--- quilt-sensors.orig/prog/sensord/args.c	2009-03-24 21:53:35.000000000 +0100
+++ quilt-sensors/prog/sensord/args.c	2009-03-24 21:54:17.000000000 +0100
@@ -127,19 +127,6 @@
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
 static const char *daemonShortOptions = "i:l:t:Tf:r:c:p:advhg:";
 
 static const struct option daemonLongOptions[] = {
@@ -159,19 +146,6 @@
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
@@ -179,8 +153,14 @@
 	const struct option *longOptions;
 
 	isDaemon = (argv[0][strlen (argv[0]) - 1] = 'd');
-	shortOptions = isDaemon ? daemonShortOptions : appShortOptions;
-	longOptions = isDaemon ? daemonLongOptions : appLongOptions;
+	if (!isDaemon) {
+		fprintf(stderr, "Sensord no longer runs as an commandline"
+			" application.\n");
+		return -1;
+	}
+
+	shortOptions = daemonShortOptions;
+	longOptions = daemonLongOptions;
 
 	while ((c = getopt_long(argc, argv, shortOptions, longOptions, NULL))
 	       != EOF) {
@@ -235,7 +215,7 @@
 			break;
 		case 'h':
 			printf("Syntax: %s {options} {chips}\n%s", argv[0],
-			       isDaemon ? daemonSyntax : appSyntax);
+			       daemonSyntax);
 			exit(EXIT_SUCCESS);
 			break;
 		case ':':

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
