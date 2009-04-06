From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 06 Apr 2009 07:56:37 +0000
Subject: [lm-sensors] [PATCH 2/8] sensord: Fix help string
Message-Id: <20090406075637.GC4734@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Break long lines in the help string.
---

 args.c |   44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

--- quilt-sensors.orig/prog/sensord/args.c	2009-03-16 22:55:22.000000000 +0100
+++ quilt-sensors/prog/sensord/args.c	2009-03-16 23:03:45.000000000 +0100
@@ -101,31 +101,49 @@
 }
 
 static const char *daemonSyntax -	"  -i, --interval <time>     -- interval between scanning alarms (default 60s)\n"
-	"  -l, --log-interval <time> -- interval between logging sensors (default 30m)\n"
-	"  -t, --rrd-interval <time> -- interval between updating RRD file (default 5m)\n"
+	"  -i, --interval <time>     -- interval between scanning alarms"
+	"(default 60s)\n"
+
+	"  -l, --log-interval <time> -- interval between logging sensors"
+	"(default 30m)\n"
+
+	"  -t, --rrd-interval <time> -- interval between updating RRD file"
+	"(default 5m)\n"
+
 	"  -T, --rrd-no-average      -- switch RRD in non-average mode\n"
 	"  -r, --rrd-file <file>     -- RRD file (default <none>)\n"
 	"  -c, --config-file <file>  -- configuration file\n"
-	"  -p, --pid-file <file>     -- PID file (default /var/run/sensord.pid)\n"
-	"  -f, --syslog-facility <f> -- syslog facility to use (default local4)\n"
+	"  -p, --pid-file <file>     -- PID file"
+	"(default /var/run/sensord.pid)\n"
+
+	"  -f, --syslog-facility <f> -- syslog facility to use"
+	"(default local4)\n"
+
 	"  -g, --rrd-cgi <img-dir>   -- output an RRD CGI script and exit\n"
 	"  -a, --load-average        -- include load average in RRD file\n"
 	"  -d, --debug               -- display some debug information\n"
 	"  -v, --version             -- display version and exit\n"
 	"  -h, --help                -- display help and exit\n"
 	"\n"
+
 	"Specify a value of 0 for any interval to disable that operation;\n"
 	"for example, specify --log-interval 0 to only scan for alarms."
 	"\n"
-	"Specify the filename `-' to read the config file from stdin.\n"
-	"\n"
-	"If no chips are specified, all chip info will be printed.\n"
-	"\n"
-	"If unspecified, no RRD (round robin database) is used. If specified and the\n"
-	"file does not exist, it will be created. For RRD updates to be successful,\n"
-	"the RRD file configuration must EXACTLY match the sensors that are used. If\n"
-	"your configuration changes, delete the old RRD file and restart sensord.\n";
+
+	"Specify the filename `-' to read the config file from stdin.\n\n"
+	"If no chips are specified, all chip info will be printed.\n\n"
+
+	"If unspecified, no RRD (round robin database) is used."
+	" If specified and the\n"
+
+	"file does not exist, it will be created. For RRD updates to be"
+	" successful,\n"
+
+	"the RRD file configuration must EXACTLY match the sensors that are"
+	" used. If\n"
+
+	"your configuration changes, delete the old RRD file and restart"
+	" sensord.\n";
 
 static const char *daemonShortOptions = "i:l:t:Tf:r:c:p:advhg:";
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
