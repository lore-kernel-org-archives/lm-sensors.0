From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 09 Mar 2009 08:46:12 +0000
Subject: [lm-sensors] [PATCH 6/7] sensord: Coding style conversion (gnu ->
Message-Id: <20090309084612.GG4636@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix coding style in sensord.c

---
 prog/sensord/sensord.c |  382 ++++++++++++++++++++++++-------------------------
 1 file changed, 192 insertions(+), 190 deletions(-)

--- quilt-sensors.orig/prog/sensord/sensord.c	2009-03-07 23:32:46.000000000 +0100
+++ quilt-sensors/prog/sensord/sensord.c	2009-03-07 23:40:17.000000000 +0100
@@ -44,197 +44,199 @@
 
 #include <stdarg.h>
 
-void
-sensorLog
-(int priority, const char *fmt, ...) {
-  static char buffer[1 + LOG_BUFFER];
-  va_list ap;
-  va_start (ap, fmt);
-  vsnprintf (buffer, LOG_BUFFER, fmt, ap);
-  buffer[LOG_BUFFER] = '\0';
-  va_end (ap);
-  if (debug || (priority < LOG_DEBUG)) {
-    if (logOpened) {
-      syslog (priority, "%s", buffer);
-    } else {
-      fprintf (stderr, "%s\n", buffer);
-      fflush (stderr);
-    }
-  }
-}
-
-static void
-signalHandler
-(int sig) {
-  signal (sig, signalHandler);
-  switch (sig) {
-    case SIGTERM:
-      done = 1;
-      break;
-    case SIGHUP:
-      reload = 1;
-      break;
-  }
-}
-
-static int
-sensord
-(void) {
-  int ret = 0;
-  int scanValue = 0, logValue = 0;
-  /*
-   * First RRD update at next RRD timeslot to prevent failures due
-   * one timeslot updated twice on restart for example.
-   */
-  int rrdValue = rrdTime - time(NULL) % rrdTime;
-
-  sensorLog (LOG_INFO, "sensord started");
-
-  while (!done) {
-    if (reload) {
-      ret = reloadLib (sensorsCfgFile);
-      if (ret)
-        sensorLog (LOG_NOTICE, "config reload error (%d)", ret);
-      reload = 0;
-    }
-    if (scanTime && (scanValue <= 0)) {
-      if ((ret = scanChips ()))
-        sensorLog (LOG_NOTICE, "sensor scan error (%d)", ret);
-      scanValue += scanTime;
-    }
-    if (logTime && (logValue <= 0)) {
-      if ((ret = readChips ()))
-        sensorLog (LOG_NOTICE, "sensor read error (%d)", ret);
-      logValue += logTime;
-    }
-    if (rrdTime && rrdFile && (rrdValue <= 0)) {
-      if ((ret = rrdUpdate ()))
-        sensorLog (LOG_NOTICE, "rrd update error (%d)", ret);
-      /*
-       * The amount of time to wait is computed using the same method as
-       * in RRD instead of simply adding the interval.
-       */
-      rrdValue = rrdTime - time(NULL) % rrdTime;
-    }
-    if (!done) {
-      int a = logTime ? logValue : INT_MAX;
-      int b = scanTime ? scanValue : INT_MAX;
-      int c = (rrdTime && rrdFile) ? rrdValue : INT_MAX;
-      int sleepTime = (a < b) ? ((a < c) ? a : c) : ((b < c) ? b : c);
-      sleep (sleepTime);
-      scanValue -= sleepTime;
-      logValue -= sleepTime;
-      rrdValue -= sleepTime;
-    }
-  }
-
-  sensorLog (LOG_INFO, "sensord stopped");
-
-  return ret;
-}
-
-static void
-openLog
-(void) {
-  openlog ("sensord", 0, syslogFacility);
-  logOpened = 1; 
-}
-
-static void
-daemonize
-(void) {
-  int pid;
-  struct stat fileStat;
-  FILE *file;
-
-  if (chdir ("/") < 0) {
-    perror ("chdir()");
-    exit (EXIT_FAILURE);
-  }
-
-  if (!(stat (pidFile, &fileStat)) &&
-      ((!S_ISREG (fileStat.st_mode)) || (fileStat.st_size > 11))) {
-    fprintf (stderr, "Error: PID file `%s' already exists and looks suspicious.\n", pidFile);
-    exit (EXIT_FAILURE);
-  }
+void sensorLog(int priority, const char *fmt, ...)
+{
+	static char buffer[1 + LOG_BUFFER];
+	va_list ap;
+	va_start(ap, fmt);
+	vsnprintf(buffer, LOG_BUFFER, fmt, ap);
+	buffer[LOG_BUFFER] = '\0';
+	va_end(ap);
+	if (debug || (priority < LOG_DEBUG)) {
+		if (logOpened) {
+			syslog(priority, "%s", buffer);
+		} else {
+			fprintf(stderr, "%s\n", buffer);
+			fflush(stderr);
+		}
+	}
+}
+
+static void signalHandler(int sig)
+{
+	signal(sig, signalHandler);
+	switch (sig) {
+	case SIGTERM:
+		done = 1;
+		break;
+	case SIGHUP:
+		reload = 1;
+		break;
+	}
+}
+
+static int sensord(void)
+{
+	int ret = 0;
+	int scanValue = 0, logValue = 0;
+	/*
+	 * First RRD update at next RRD timeslot to prevent failures due
+	 * one timeslot updated twice on restart for example.
+	 */
+	int rrdValue = rrdTime - time(NULL) % rrdTime;
+
+	sensorLog(LOG_INFO, "sensord started");
+
+	while (!done) {
+		if (reload) {
+			ret = reloadLib(sensorsCfgFile);
+			if (ret)
+				sensorLog(LOG_NOTICE,
+					  "config reload error (%d)", ret);
+			reload = 0;
+		}
+		if (scanTime && (scanValue <= 0)) {
+			if ((ret = scanChips()))
+				sensorLog(LOG_NOTICE,
+					  "sensor scan error (%d)", ret);
+			scanValue += scanTime;
+		}
+		if (logTime && (logValue <= 0)) {
+			if ((ret = readChips()))
+				sensorLog(LOG_NOTICE,
+					  "sensor read error (%d)", ret);
+			logValue += logTime;
+		}
+		if (rrdTime && rrdFile && (rrdValue <= 0)) {
+			if ((ret = rrdUpdate()))
+				sensorLog(LOG_NOTICE,
+					  "rrd update error (%d)", ret);
+			/*
+			 * The amount of time to wait is computed using the
+			 * same method as in RRD instead of simply adding the
+			 * interval.
+			 */
+			rrdValue = rrdTime - time(NULL) % rrdTime;
+		}
+		if (!done) {
+			int a = logTime ? logValue : INT_MAX;
+			int b = scanTime ? scanValue : INT_MAX;
+			int c = (rrdTime && rrdFile) ? rrdValue : INT_MAX;
+			int sleepTime = (a < b) ? ((a < c) ? a : c) :
+				((b < c) ? b : c);
+			sleep(sleepTime);
+			scanValue -= sleepTime;
+			logValue -= sleepTime;
+			rrdValue -= sleepTime;
+		}
+	}
+
+	sensorLog(LOG_INFO, "sensord stopped");
+
+	return ret;
+}
+
+static void openLog(void)
+{
+	openlog("sensord", 0, syslogFacility);
+	logOpened = 1;
+}
+
+static void daemonize(void)
+{
+	int pid;
+	struct stat fileStat;
+	FILE *file;
+
+	if (chdir("/") < 0) {
+		perror("chdir()");
+		exit(EXIT_FAILURE);
+	}
+
+	if (!(stat(pidFile, &fileStat)) &&
+	    ((!S_ISREG(fileStat.st_mode)) || (fileStat.st_size > 11))) {
+		fprintf(stderr,
+			"Error: PID file `%s' already exists and looks suspicious.\n",
+			pidFile);
+		exit(EXIT_FAILURE);
+	}
  
-  if (!(file = fopen (pidFile, "w"))) {
-    fprintf (stderr, "fopen(\"%s\"): %s\n", pidFile, strerror (errno));
-    exit (EXIT_FAILURE);
-  }
+	if (!(file = fopen(pidFile, "w"))) {
+		fprintf(stderr, "fopen(\"%s\"): %s\n", pidFile,
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	/* I should use sigaction but... */
+	if (signal(SIGTERM, signalHandler) = SIG_ERR ||
+	    signal (SIGHUP, signalHandler) = SIG_ERR) {
+		perror("signal");
+		exit(EXIT_FAILURE);
+	}
+
+	if ((pid = fork()) = -1) {
+		perror("fork()");
+		exit(EXIT_FAILURE);
+	} else if (pid != 0) {
+		fprintf(file, "%d\n", pid);
+		fclose(file);
+		unloadLib();
+		exit(EXIT_SUCCESS);
+	}
+
+	if (setsid() < 0) {
+		perror("setsid()");
+		exit(EXIT_FAILURE);
+	}
+
+	fclose(file);
+	close(STDIN_FILENO);
+	close(STDOUT_FILENO);
+	close(STDERR_FILENO);
+}
+
+static void undaemonize(void)
+{
+	unlink(pidFile);
+	closelog();
+}
+
+int main(int argc, char **argv)
+{
+	int ret = 0;
+
+	if (parseArgs(argc, argv) ||
+	    parseChips(argc, argv))
+		exit(EXIT_FAILURE);
+
+	if (loadLib(sensorsCfgFile))
+		exit(EXIT_FAILURE);
+
+	if (isDaemon)
+		openLog();
+	if (rrdFile)
+		ret = rrdInit();
+
+	if (ret) {
+	} else if (doCGI) {
+		ret = rrdCGI();
+	} else if (isDaemon) {
+		daemonize();
+		ret = sensord();
+		undaemonize();
+	} else {
+		if (doSet)
+			ret = setChips();
+		else if (doScan)
+			ret = scanChips();
+		else if (rrdFile)
+			ret = rrdUpdate();
+		else
+			ret = readChips();
+	}
   
-  /* I should use sigaction but... */
-  if (signal (SIGTERM, signalHandler) = SIG_ERR ||
-      signal (SIGHUP, signalHandler) = SIG_ERR) {
-    perror ("signal");
-    exit (EXIT_FAILURE);
-  }
-
-  if ((pid = fork ()) = -1) {
-    perror ("fork()");
-    exit (EXIT_FAILURE);
-  } else if (pid != 0) {
-    fprintf (file, "%d\n", pid);
-    fclose (file);
-    unloadLib ();
-    exit (EXIT_SUCCESS);
-  }
-
-  if (setsid () < 0) {
-    perror ("setsid()");
-    exit (EXIT_FAILURE);
-  }
-
-  fclose (file);
-  close (STDIN_FILENO);
-  close (STDOUT_FILENO);
-  close (STDERR_FILENO);
-}
-
-static void 
-undaemonize
-(void) {
-  unlink (pidFile);
-  closelog ();
-}
-
-int
-main
-(int argc, char **argv) {
-  int ret = 0;
+	if (unloadLib())
+		exit(EXIT_FAILURE);
   
-  if (parseArgs (argc, argv) ||
-      parseChips (argc, argv))
-    exit (EXIT_FAILURE);
-  
-  if (loadLib (sensorsCfgFile))
-    exit (EXIT_FAILURE);
-
-  if (isDaemon)
-    openLog ();
-  if (rrdFile)
-    ret = rrdInit ();
-  
-  if (ret) {
-  } else if (doCGI) {
-    ret = rrdCGI ();
-  } else if (isDaemon) {
-    daemonize ();
-    ret = sensord ();
-    undaemonize ();
-  } else {
-    if (doSet)
-      ret = setChips ();
-    else if (doScan)
-      ret = scanChips ();
-    else if (rrdFile)
-      ret = rrdUpdate ();
-    else
-      ret = readChips ();
-  }
-  
-  if (unloadLib ())
-    exit (EXIT_FAILURE);
-  
-  return ret;
+	return ret;
 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
