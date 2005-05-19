From: aurel32@debian.org (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: sensord: rrd database and timeslots
Message-Id: <20040501105746.GA6332@pc.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040421222823.GA14256@pc.aurel32.private>
In-Reply-To: <20040421222823.GA14256@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It seems that the points of view on this problem are very different. 
Some of us say that the values should be averaged, some other says they
should not.

That's why I propose a new patch that let the user choice if the values
are average or not. Please also not that with this patch the timeslots
are not faked anymore.

Please give me your comments!

Bye,
Aurelien


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN lm_sensors2.orig/prog/sensord/args.c lm_sensors2/prog/sensord/args.c
--- lm_sensors2.orig/prog/sensord/args.c	2002-07-31 16:20:29.000000000 +0200
+++ lm_sensors2/prog/sensord/args.c	2004-05-01 12:44:10.000000000 +0200
@@ -39,6 +39,7 @@
 int scanTime = 60;
 int logTime = 30 * 60;
 int rrdTime = 5 * 60;
+int rrdNoAverage = 0;
 int syslogFacility = LOG_LOCAL4;
 int doScan = 0;
 int doSet = 0;
@@ -98,6 +99,7 @@
   "  -i, --interval <time>     -- interval between scanning alarms (default 60s)\n"
   "  -l, --log-interval <time> -- interval between logging sensors (default 30m)\n"
   "  -t, --rrd-interval <time> -- interval between updating RRD file (default 5m)\n"
+  "  -T, --rrd-no-average      -- switch RRD in non-average mode\n"
   "  -r, --rrd-file <file>     -- RRD file (default <none>)\n"
   "  -c, --config-file <file>  -- configuration file (default sensors.conf)\n"
   "  -p, --pid-file <file>     -- PID file (default /var/run/sensord.pid)\n"
@@ -135,12 +137,13 @@
   "\n"
   "If no chips are specified, all chip info will be printed.\n";
 
-static const char *daemonShortOptions = "i:l:t:f:r:c:p:advhg:";
+static const char *daemonShortOptions = "i:l:Tt:f:r:c:p:advhg:";
 
 static const struct option daemonLongOptions[] = {
   { "interval", required_argument, NULL, 'i' },
   { "log-interval", required_argument, NULL, 'l' },
   { "rrd-interval", required_argument, NULL, 't' },
+  { "rrd-no-average", no_argument, NULL, 'T' },
   { "syslog-facility", required_argument, NULL, 'f' },
   { "rrd-file", required_argument, NULL, 'r' },
   { "config-file", required_argument, NULL, 'c' },
@@ -191,6 +194,9 @@
         if ((rrdTime = parseTime (optarg)) < 0)
           return -1;
         break;
+      case 'T':
+	rrdNoAverage = 1;
+	break;
       case 'f':
         if ((syslogFacility = parseFacility (optarg)) < 0)
           return -1;
diff -urN lm_sensors2.orig/prog/sensord/rrd.c lm_sensors2/prog/sensord/rrd.c
--- lm_sensors2.orig/prog/sensord/rrd.c	2004-03-08 19:03:42.000000000 +0100
+++ lm_sensors2/prog/sensord/rrd.c	2004-05-01 12:44:10.000000000 +0200
@@ -256,7 +256,7 @@
         ret = -num;
       } else {
         sprintf (stepBuff, "%d", rrdTime);
-        sprintf (rraBuff, "RRA:AVERAGE:%f:%d:%d", 0.5 /* fraction of non-unknown samples needed per entry */, 1 /* samples per entry */, 7 * 24 * 60 * 60 / rrdTime /* 1 week */);
+        sprintf (rraBuff, "RRA:%s:%f:%d:%d", rrdNoAverage?"LAST":"AVERAGE", 0.5 /* fraction of non-unknown samples needed per entry */, 1 /* samples per entry */, 7 * 24 * 60 * 60 / rrdTime /* 1 week */);
         argc += num;
         argv[argc ++] = rraBuff;
         argv[argc] = NULL;
diff -urN lm_sensors2.orig/prog/sensord/sensord.8 lm_sensors2/prog/sensord/sensord.8
--- lm_sensors2.orig/prog/sensord/sensord.8	2004-03-14 20:15:55.000000000 +0100
+++ lm_sensors2/prog/sensord/sensord.8	2004-05-01 12:47:36.000000000 +0200
@@ -70,6 +70,9 @@
 a round-robin database is configured.
 
 The time is specified as before; e.g., `5m'.
+.IP "-T, --rrd-no-average"
+Specify that the round-robin database should not be averaged.
+
 .IP "-r, --rrd-file file"
 Specify a round-robin database into which to log all sensor readings;
 e.g., `/var/log/sensord.rrd'. This database will be created if it does
diff -urN lm_sensors2.orig/prog/sensord/sensord.c lm_sensors2/prog/sensord/sensord.c
--- lm_sensors2.orig/prog/sensord/sensord.c	2002-06-10 19:56:16.000000000 +0200
+++ lm_sensors2/prog/sensord/sensord.c	2004-05-01 12:44:10.000000000 +0200
@@ -28,6 +28,7 @@
 #include <signal.h>
 #include <syslog.h>
 #include <unistd.h>
+#include <time.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 
@@ -75,7 +76,12 @@
 sensord
 (void) {
   int ret = 0;
-  int scanValue = 0, logValue = 0, rrdValue = 0;
+  int scanValue = 0, logValue = 0;
+  /*
+   * First RRD update at next RRD timeslot to prevent failures due
+   * one timeslot updated twice on restart for example.
+   */
+  int rrdValue = rrdTime - time(NULL) % rrdTime;
 
   sensorLog (LOG_INFO, "sensord started");
 
@@ -93,7 +99,11 @@
     }
     if ((ret = 0) && rrdTime && rrdFile && (rrdValue <= 0)) {
       ret = rrdUpdate ();
-      rrdValue += rrdTime;
+      /*
+       * We don't add here, but set because next RRD timeslot starts
+       * exactly then and not sooner!
+       */
+      rrdValue = rrdTime - time(NULL) % rrdTime;
     }
     if (!done && (ret = 0)) {
       int a = logTime ? logValue : INT_MAX;
diff -urN lm_sensors2.orig/prog/sensord/sensord.h lm_sensors2/prog/sensord/sensord.h
--- lm_sensors2.orig/prog/sensord/sensord.h	2002-10-23 16:51:54.000000000 +0200
+++ lm_sensors2/prog/sensord/sensord.h	2004-05-01 12:44:10.000000000 +0200
@@ -36,6 +36,7 @@
 extern int scanTime;
 extern int logTime;
 extern int rrdTime;
+extern int rrdNoAverage;
 extern int syslogFacility;
 extern int doScan;
 extern int doSet;
