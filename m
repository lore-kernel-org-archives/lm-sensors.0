From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 11 May 2009 16:04:19 +0000
Subject: [lm-sensors] [PATCH v2 6/7] sensord: Use sigaction() for signal
Message-Id: <20090511160419.GG17530@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Replace the deprecated signal() function by sigaction().

The signal() function has some disadvantages. This patch replaces
signal() by sigaction() to install the signal handlers.

Changes in v2:

Zero sigaction structure.

 sensord.c |   33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

Index: quilt-sensors/prog/sensord/sensord.c
=================================--- quilt-sensors.orig/prog/sensord/sensord.c	2009-05-08 19:55:45.000000000 +0200
+++ quilt-sensors/prog/sensord/sensord.c	2009-05-08 21:18:30.000000000 +0200
@@ -65,7 +65,6 @@
 
 static void signalHandler(int sig)
 {
-	signal(sig, signalHandler);
 	switch (sig) {
 	case SIGTERM:
 		done = 1;
@@ -147,6 +146,31 @@
 	logOpened = 1;
 }
 
+static void install_sighandler(void)
+{
+	struct sigaction new;
+	int ret;
+
+	memset(&new, 0, sizeof(struct sigaction));
+	new.sa_handler = signalHandler;
+	sigemptyset(&new.sa_mask);
+	new.sa_flags = SA_RESTART;
+
+	ret = sigaction(SIGTERM, &new, NULL);
+	if (ret = -1) {
+		fprintf(stderr, "Could not set sighandler for SIGTERM: %s\n",
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	ret = sigaction(SIGHUP, &new, NULL);
+	if (ret = -1) {
+		fprintf(stderr, "Could not set sighandler for SIGHUP: %s\n",
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+}
+
 static void daemonize(void)
 {
 	int pid;
@@ -172,12 +196,7 @@
 		exit(EXIT_FAILURE);
 	}
 
-	/* I should use sigaction but... */
-	if (signal(SIGTERM, signalHandler) = SIG_ERR ||
-	    signal (SIGHUP, signalHandler) = SIG_ERR) {
-		perror("signal");
-		exit(EXIT_FAILURE);
-	}
+	install_sighandler();
 
 	if ((pid = fork()) = -1) {
 		perror("fork()");

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
