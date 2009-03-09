From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 09 Mar 2009 08:45:17 +0000
Subject: [lm-sensors] [PATCH 1/7] sensord: Coding style conversion (gnu ->
Message-Id: <20090309084517.GB4636@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix coding style in args.c

---
 prog/sensord/args.c |  462 ++++++++++++++++++++++++++--------------------------
 1 file changed, 238 insertions(+), 224 deletions(-)

--- quilt-sensors.orig/prog/sensord/args.c	2009-03-06 16:24:55.000000000 +0100
+++ quilt-sensors/prog/sensord/args.c	2009-03-07 23:06:38.000000000 +0100
@@ -51,257 +51,271 @@
 sensors_chip_name chipNames[MAX_CHIP_NAMES];
 int numChipNames = 0;
 
-static int
-parseTime
-(char *arg) {
-  char *end;
-  int value = strtoul (arg, &end, 10);
-  if ((end > arg) && (*end = 's')) {
-    ++ end;
-  } else if ((end > arg) && (*end = 'm')) {
-    value *= 60;
-    ++ end;
-  } else if ((end > arg) && (*end = 'h')) {
-    value *= 60 * 60;
-    ++ end;
-  }
-  if ((end = arg) || *end) {
-    fprintf (stderr, "Error parsing time value `%s'.\n", arg);
-    return -1;
-  }
-  return value;
+static int parseTime(char *arg)
+{
+	char *end;
+	int value = strtoul(arg, &end, 10);
+	if ((end > arg) && (*end = 's')) {
+		++ end;
+	} else if ((end > arg) && (*end = 'm')) {
+		value *= 60;
+		++ end;
+	} else if ((end > arg) && (*end = 'h')) {
+		value *= 60 * 60;
+		++ end;
+	}
+	if ((end = arg) || *end) {
+		fprintf(stderr, "Error parsing time value `%s'.\n", arg);
+		return -1;
+	}
+	return value;
 }
 
 static struct {
-  const char *name;
-  int id;
+	const char *name;
+	int id;
 } facilities[] = {
-  { "local0", LOG_LOCAL0 }, { "local1", LOG_LOCAL1 },
-  { "local2", LOG_LOCAL2 }, { "local3", LOG_LOCAL3 },
-  { "local4", LOG_LOCAL4 }, { "local5", LOG_LOCAL5 },
-  { "local6", LOG_LOCAL6 }, { "local7", LOG_LOCAL7 },
-  { "daemon", LOG_DAEMON }, { "user", LOG_USER },
-  { NULL, 0 }
+	{ "local0", LOG_LOCAL0 },
+	{ "local1", LOG_LOCAL1 },
+	{ "local2", LOG_LOCAL2 },
+	{ "local3", LOG_LOCAL3 },
+	{ "local4", LOG_LOCAL4 },
+	{ "local5", LOG_LOCAL5 },
+	{ "local6", LOG_LOCAL6 },
+	{ "local7", LOG_LOCAL7 },
+	{ "daemon", LOG_DAEMON },
+	{ "user", LOG_USER },
+	{ NULL, 0 }
 };
 
-static int
-parseFacility
-(char *arg) {
-  int i = 0;
-  while (facilities[i].name && strcasecmp (arg, facilities[i].name))
-    ++ i;
-  if (!facilities[i].name) {
-    fprintf (stderr, "Error parsing facility value `%s'.\n", arg);
-    return -1;
-  }
-  return facilities[i].id;
+static int parseFacility(char *arg)
+{
+	int i = 0;
+	while (facilities[i].name && strcasecmp(arg, facilities[i].name))
+		++ i;
+	if (!facilities[i].name) {
+		fprintf(stderr, "Error parsing facility value `%s'.\n", arg);
+		return -1;
+	}
+	return facilities[i].id;
 }
 
 static const char *daemonSyntax -  "  -i, --interval <time>     -- interval between scanning alarms (default 60s)\n"
-  "  -l, --log-interval <time> -- interval between logging sensors (default 30m)\n"
-  "  -t, --rrd-interval <time> -- interval between updating RRD file (default 5m)\n"
-  "  -T, --rrd-no-average      -- switch RRD in non-average mode\n"
-  "  -r, --rrd-file <file>     -- RRD file (default <none>)\n"
-  "  -c, --config-file <file>  -- configuration file\n"
-  "  -p, --pid-file <file>     -- PID file (default /var/run/sensord.pid)\n"
-  "  -f, --syslog-facility <f> -- syslog facility to use (default local4)\n"
-  "  -g, --rrd-cgi <img-dir>   -- output an RRD CGI script and exit\n"
-  "  -a, --load-average        -- include load average in RRD file\n"
-  "  -d, --debug               -- display some debug information\n"
-  "  -v, --version             -- display version and exit\n"
-  "  -h, --help                -- display help and exit\n"
-  "\n"
-  "Specify a value of 0 for any interval to disable that operation;\n"
-  "for example, specify --log-interval 0 to only scan for alarms."
-  "\n"
-  "Specify the filename `-' to read the config file from stdin.\n"
-  "\n"
-  "If no chips are specified, all chip info will be printed.\n"
-  "\n"
-  "If unspecified, no RRD (round robin database) is used. If specified and the\n"
-  "file does not exist, it will be created. For RRD updates to be successful,\n"
-  "the RRD file configuration must EXACTLY match the sensors that are used. If\n"
-  "your configuration changes, delete the old RRD file and restart sensord.\n";
+	"  -i, --interval <time>     -- interval between scanning alarms (default 60s)\n"
+	"  -l, --log-interval <time> -- interval between logging sensors (default 30m)\n"
+	"  -t, --rrd-interval <time> -- interval between updating RRD file (default 5m)\n"
+	"  -T, --rrd-no-average      -- switch RRD in non-average mode\n"
+	"  -r, --rrd-file <file>     -- RRD file (default <none>)\n"
+	"  -c, --config-file <file>  -- configuration file\n"
+	"  -p, --pid-file <file>     -- PID file (default /var/run/sensord.pid)\n"
+	"  -f, --syslog-facility <f> -- syslog facility to use (default local4)\n"
+	"  -g, --rrd-cgi <img-dir>   -- output an RRD CGI script and exit\n"
+	"  -a, --load-average        -- include load average in RRD file\n"
+	"  -d, --debug               -- display some debug information\n"
+	"  -v, --version             -- display version and exit\n"
+	"  -h, --help                -- display help and exit\n"
+	"\n"
+	"Specify a value of 0 for any interval to disable that operation;\n"
+	"for example, specify --log-interval 0 to only scan for alarms."
+	"\n"
+	"Specify the filename `-' to read the config file from stdin.\n"
+	"\n"
+	"If no chips are specified, all chip info will be printed.\n"
+	"\n"
+	"If unspecified, no RRD (round robin database) is used. If specified and the\n"
+	"file does not exist, it will be created. For RRD updates to be successful,\n"
+	"the RRD file configuration must EXACTLY match the sensors that are used. If\n"
+	"your configuration changes, delete the old RRD file and restart sensord.\n";
 
 static const char *appSyntax -  "  -a, --alarm-scan          -- only scan for alarms\n"
-  "  -s, --set                 -- execute set statements (root only)\n"
-  "  -r, --rrd-file <file>     -- only update RRD file\n"
-  "  -c, --config-file <file>  -- configuration file\n"
-  "  -d, --debug               -- display some debug information\n"
-  "  -v, --version             -- display version and exit\n"
-  "  -h, --help                -- display help and exit\n"
-  "\n"
-  "Specify the filename `-' to read the config file from stdin.\n"
-  "\n"
-  "If no chips are specified, all chip info will be printed.\n";
+	"  -a, --alarm-scan          -- only scan for alarms\n"
+	"  -s, --set                 -- execute set statements (root only)\n"
+	"  -r, --rrd-file <file>     -- only update RRD file\n"
+	"  -c, --config-file <file>  -- configuration file\n"
+	"  -d, --debug               -- display some debug information\n"
+	"  -v, --version             -- display version and exit\n"
+	"  -h, --help                -- display help and exit\n"
+	"\n"
+	"Specify the filename `-' to read the config file from stdin.\n"
+	"\n"
+	"If no chips are specified, all chip info will be printed.\n";
 
 static const char *daemonShortOptions = "i:l:t:Tf:r:c:p:advhg:";
 
 static const struct option daemonLongOptions[] = {
-  { "interval", required_argument, NULL, 'i' },
-  { "log-interval", required_argument, NULL, 'l' },
-  { "rrd-interval", required_argument, NULL, 't' },
-  { "rrd-no-average", no_argument, NULL, 'T' },
-  { "syslog-facility", required_argument, NULL, 'f' },
-  { "rrd-file", required_argument, NULL, 'r' },
-  { "config-file", required_argument, NULL, 'c' },
-  { "pid-file", required_argument, NULL, 'p' },
-  { "rrd-cgi", required_argument, NULL, 'g' },
-  { "load-average", no_argument, NULL, 'a' },
-  { "debug", no_argument, NULL, 'd' },
-  { "version", no_argument, NULL, 'v' },
-  { "help", no_argument, NULL, 'h' },
-  { NULL, 0, NULL, 0 }
+	{ "interval", required_argument, NULL, 'i' },
+	{ "log-interval", required_argument, NULL, 'l' },
+	{ "rrd-interval", required_argument, NULL, 't' },
+	{ "rrd-no-average", no_argument, NULL, 'T' },
+	{ "syslog-facility", required_argument, NULL, 'f' },
+	{ "rrd-file", required_argument, NULL, 'r' },
+	{ "config-file", required_argument, NULL, 'c' },
+	{ "pid-file", required_argument, NULL, 'p' },
+	{ "rrd-cgi", required_argument, NULL, 'g' },
+	{ "load-average", no_argument, NULL, 'a' },
+	{ "debug", no_argument, NULL, 'd' },
+	{ "version", no_argument, NULL, 'v' },
+	{ "help", no_argument, NULL, 'h' },
+	{ NULL, 0, NULL, 0 }
 };
 
 static const char *appShortOptions = "asr:c:dvh";
 
 static const struct option appLongOptions[] = {
-  { "alarm-scan", no_argument, NULL, 'a' },
-  { "set", no_argument, NULL, 's' },
-  { "rrd-file", required_argument, NULL, 'r' },
-  { "config-file", required_argument, NULL, 'c' },
-  { "debug", no_argument, NULL, 'd' },
-  { "version", no_argument, NULL, 'v' },
-  { "help", no_argument, NULL, 'h' },
-  { NULL, 0, NULL, 0 }
+	{ "alarm-scan", no_argument, NULL, 'a' },
+	{ "set", no_argument, NULL, 's' },
+	{ "rrd-file", required_argument, NULL, 'r' },
+	{ "config-file", required_argument, NULL, 'c' },
+	{ "debug", no_argument, NULL, 'd' },
+	{ "version", no_argument, NULL, 'v' },
+	{ "help", no_argument, NULL, 'h' },
+	{ NULL, 0, NULL, 0 }
 };
 
-int
-parseArgs
-(int argc, char **argv) {
-  int c;
-  const char *shortOptions;
-  const struct option *longOptions;
-
-  isDaemon = (argv[0][strlen (argv[0]) - 1] = 'd');
-  shortOptions = isDaemon ? daemonShortOptions : appShortOptions;
-  longOptions = isDaemon ? daemonLongOptions : appLongOptions;
-
-  while ((c = getopt_long (argc, argv, shortOptions, longOptions, NULL)) != EOF) {
-    switch(c) {
-      case 'i':
-        if ((scanTime = parseTime (optarg)) < 0)
-          return -1;
-        break;
-      case 'l':
-        if ((logTime = parseTime (optarg)) < 0)
-          return -1;
-        break;
-      case 't':
-        if ((rrdTime = parseTime (optarg)) < 0)
-          return -1;
-        break;
-      case 'T':
-        rrdNoAverage = 1;
-        break;
-      case 'f':
-        if ((syslogFacility = parseFacility (optarg)) < 0)
-          return -1;
-        break;
-      case 'a':
-        if (isDaemon)
-          doLoad = 1;
-        else
-          doScan = 1;
-        break;
-      case 's':
-        doSet = 1;
-        break;
-      case 'c':
-        sensorsCfgFile = optarg;
-        break;
-      case 'p':
-        pidFile = optarg;
-        break;
-      case 'r':
-        rrdFile = optarg;
-        break;
-      case 'd':
-        debug = 1;
-        break;
-      case 'g':
-        doCGI = 1;
-        cgiDir = optarg;
-        break;
-      case 'v':
-        printf ("sensord version %s\n", LM_VERSION);
-        exit (EXIT_SUCCESS);
-        break;
-      case 'h':
-        printf ("Syntax: %s {options} {chips}\n%s", argv[0], isDaemon ? daemonSyntax : appSyntax);
-        exit (EXIT_SUCCESS);
-        break;
-      case ':':
-      case '?':
-        printf ("Try `%s --help' for more information.\n", argv[0]);
-        return -1;
-        break;
-      default:
-        fprintf (stderr, "Internal error while parsing options.\n");
-        return -1;
-        break;
-    }
-  }
-
-  if (doScan && doSet) {
-    fprintf (stderr, "Error: Incompatible --set and --alarm-scan.\n");
-    return -1;
-  }
+int parseArgs(int argc, char **argv)
+{
+	int c;
+	const char *shortOptions;
+	const struct option *longOptions;
+
+	isDaemon = (argv[0][strlen (argv[0]) - 1] = 'd');
+	shortOptions = isDaemon ? daemonShortOptions : appShortOptions;
+	longOptions = isDaemon ? daemonLongOptions : appLongOptions;
+
+	while ((c = getopt_long(argc, argv, shortOptions, longOptions, NULL))
+	       != EOF) {
+		switch(c) {
+		case 'i':
+			if ((scanTime = parseTime(optarg)) < 0)
+				return -1;
+			break;
+		case 'l':
+			if ((logTime = parseTime(optarg)) < 0)
+				return -1;
+			break;
+		case 't':
+			if ((rrdTime = parseTime(optarg)) < 0)
+				return -1;
+			break;
+		case 'T':
+			rrdNoAverage = 1;
+			break;
+		case 'f':
+			if ((syslogFacility = parseFacility(optarg)) < 0)
+				return -1;
+			break;
+		case 'a':
+			if (isDaemon)
+				doLoad = 1;
+			else
+				doScan = 1;
+			break;
+		case 's':
+			doSet = 1;
+			break;
+		case 'c':
+			sensorsCfgFile = optarg;
+			break;
+		case 'p':
+			pidFile = optarg;
+			break;
+		case 'r':
+			rrdFile = optarg;
+			break;
+		case 'd':
+			debug = 1;
+			break;
+		case 'g':
+			doCGI = 1;
+			cgiDir = optarg;
+			break;
+		case 'v':
+			printf("sensord version %s\n", LM_VERSION);
+			exit(EXIT_SUCCESS);
+			break;
+		case 'h':
+			printf("Syntax: %s {options} {chips}\n%s", argv[0],
+			       isDaemon ? daemonSyntax : appSyntax);
+			exit(EXIT_SUCCESS);
+			break;
+		case ':':
+		case '?':
+			printf("Try `%s --help' for more information.\n",
+			       argv[0]);
+			return -1;
+			break;
+		default:
+			fprintf(stderr,
+				"Internal error while parsing options.\n");
+			return -1;
+			break;
+		}
+	}
+
+	if (doScan && doSet) {
+		fprintf(stderr,
+			"Error: Incompatible --set and --alarm-scan.\n");
+		return -1;
+	}
   
-  if (rrdFile && doSet) {
-    fprintf (stderr, "Error: Incompatible --set and --rrd-file.\n");
-    return -1;
-  }
+	if (rrdFile && doSet) {
+		fprintf(stderr,
+			"Error: Incompatible --set and --rrd-file.\n");
+		return -1;
+	}
   
-  if (doScan && rrdFile) {
-    fprintf (stderr, "Error: Incompatible --rrd-file and --alarm-scan.\n");
-    return -1;
-  }
-
-  if (doCGI && !rrdFile) {
-    fprintf (stderr, "Error: Incompatible --rrd-cgi without --rrd-file.\n");
-    return -1;
-  }
+	if (doScan && rrdFile) {
+		fprintf(stderr,
+			"Error: Incompatible --rrd-file and --alarm-scan.\n");
+		return -1;
+	}
+
+	if (doCGI && !rrdFile) {
+		fprintf(stderr,
+			"Error: Incompatible --rrd-cgi without --rrd-file.\n");
+		return -1;
+	}
   
-  if (rrdFile && !rrdTime) {
-    fprintf (stderr, "Error: Incompatible --rrd-file without --rrd-interval.\n");
-    return -1;
-  }
+	if (rrdFile && !rrdTime) {
+		fprintf(stderr,
+			"Error: Incompatible --rrd-file without --rrd-interval.\n");
+		return -1;
+	}
   
-  if (!logTime && !scanTime && !rrdFile) {
-    fprintf (stderr, "Error: No logging, alarm or RRD scanning.\n");
-    return -1;
-  }
+	if (!logTime && !scanTime && !rrdFile) {
+		fprintf(stderr,
+			"Error: No logging, alarm or RRD scanning.\n");
+		return -1;
+	}
 
-  return 0;
+	return 0;
 }
 
-int
-parseChips
-(int argc, char **argv) {
-  if (optind = argc) {
-    chipNames[0].prefix = SENSORS_CHIP_NAME_PREFIX_ANY;
-    chipNames[0].bus.type = SENSORS_BUS_TYPE_ANY;
-    chipNames[0].bus.nr = SENSORS_BUS_NR_ANY;
-    chipNames[0].addr = SENSORS_CHIP_NAME_ADDR_ANY;
-    numChipNames = 1;
-  } else {
-    int i, n = argc - optind, err;
-    if (n > MAX_CHIP_NAMES) {
-      fprintf (stderr, "Too many chip names.\n");
-      return -1;
-    }
-    for (i = 0; i < n; ++ i) {
-      char *arg = argv[optind + i];
-      if ((err = sensors_parse_chip_name (arg, chipNames + i))) {
-        fprintf (stderr, "Invalid chip name `%s': %s\n", arg, sensors_strerror (err));
-        return -1;
-      }
-    }
-    numChipNames = n;
-  }
-  return 0;
+int parseChips(int argc, char **argv)
+{
+	if (optind = argc) {
+		chipNames[0].prefix = SENSORS_CHIP_NAME_PREFIX_ANY;
+		chipNames[0].bus.type = SENSORS_BUS_TYPE_ANY;
+		chipNames[0].bus.nr = SENSORS_BUS_NR_ANY;
+		chipNames[0].addr = SENSORS_CHIP_NAME_ADDR_ANY;
+		numChipNames = 1;
+	} else {
+		int i, n = argc - optind, err;
+		if (n > MAX_CHIP_NAMES) {
+			fprintf(stderr, "Too many chip names.\n");
+			return -1;
+		}
+		for (i = 0; i < n; ++ i) {
+			char *arg = argv[optind + i];
+			if ((err = sensors_parse_chip_name(arg,
+							   chipNames + i))) {
+				fprintf(stderr,
+					"Invalid chip name `%s': %s\n", arg,
+					sensors_strerror(err));
+				return -1;
+			}
+		}
+		numChipNames = n;
+	}
+	return 0;
 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
