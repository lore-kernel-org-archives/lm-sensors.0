From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2007 15:28:10 +0000
Subject: [lm-sensors] [PATCH 6/6] Make /etc/sensors3.conf the default config
Message-Id: <20071024172810.55f3a250@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use /etc/sensors3.conf as the default configuration file. If it can't
be found, fallback to /etc/sensors.conf. This allows for an old
libsensors and a new libsensors to be installed in parallel, and each
one has its own configuration file.

One important change here is that the default configuration file will
be installed as /etc/sensors3.conf by "make install".

---
 INSTALL                  |    2 +-
 doc/fan-divisors         |    4 ++--
 etc/Module.mk            |    2 +-
 etc/sensors-conf-convert |    2 +-
 lib/init.c               |    6 +++++-
 lib/libsensors.3         |   15 ++++++++++++++-
 lib/sensors.conf.5       |   12 +++++++++++-
 prog/sensord/sensord.8   |    2 ++
 prog/sensors/sensors.1   |    2 ++
 9 files changed, 39 insertions(+), 8 deletions(-)

--- lm-sensors-3.orig/INSTALL	2007-09-24 15:33:19.000000000 +0200
+++ lm-sensors-3/INSTALL	2007-10-24 16:37:16.000000000 +0200
@@ -71,7 +71,7 @@ program to get a report of all detected 
 page for available options.
 
 The initial output of `sensors' will not be perfect. You have to adjust
-the configuration file (/etc/sensors.conf) to match your motherboard.
+the configuration file (/etc/sensors3.conf) to match your motherboard.
 This includes (re)labelling inputs, ignoring unused inputs, changing
 voltage compute lines and setting limits. Write down all the sensor
 information your BIOS displays as a hint to what you are supposed to
--- lm-sensors-3.orig/doc/fan-divisors	2007-04-02 13:20:56.000000000 +0200
+++ lm-sensors-3/doc/fan-divisors	2007-10-24 16:45:27.000000000 +0200
@@ -47,7 +47,7 @@ How to change fan divisors
 --------------------------
 
 Put an entry "set fanN_div X" in the appropriate section of
-/etc/sensors.conf and run 'sensors -s'
+/etc/sensors3.conf and run 'sensors -s'
 (N is the number of the fan, and X is the divisor you want).
 
 
@@ -87,7 +87,7 @@ outputs 4 pulses by revolution, instead 
 
 As we learned above, you can _not_ fix this by changing
 the fan divisor. You must add entries into the appropriate
-section of /etc/sensors.conf:
+section of /etc/sensors3.conf:
 
 	compute fanN  @/2,  2*@
 
--- lm-sensors-3.orig/etc/Module.mk	2007-09-26 23:43:45.000000000 +0200
+++ lm-sensors-3/etc/Module.mk	2007-10-24 16:48:28.000000000 +0200
@@ -21,7 +21,7 @@
 MODULE_DIR := etc
 
 ETCTARGET := $(MODULE_DIR)/sensors.conf.eg
-ETCINSTALL := $(ETCDIR)/sensors.conf
+ETCINSTALL := $(ETCDIR)/sensors3.conf
 
 
 # No all rule
--- lm-sensors-3.orig/etc/sensors-conf-convert	2007-10-09 14:45:22.000000000 +0200
+++ lm-sensors-3/etc/sensors-conf-convert	2007-10-24 16:35:15.000000000 +0200
@@ -367,7 +367,7 @@ BEGIN
 
 	if (defined $ARGV[0] && ($ARGV[0] eq '-h' || $ARGV[0] eq '--help')) {
 		print "Convert sensors.conf from lm-sensors 2 format to lm-sensors 3 format\n",
-		      "Typical usage: sensors-conf-convert /etc/sensors.conf\n";
+		      "Typical usage: sensors-conf-convert < /etc/sensors.conf > /etc/sensors3.conf\n";
 		exit 0;
 	}
 }
--- lm-sensors-3.orig/lib/init.c	2007-10-24 16:26:17.000000000 +0200
+++ lm-sensors-3/lib/init.c	2007-10-24 16:26:17.000000000 +0200
@@ -20,6 +20,7 @@
 
 #include <stdlib.h>
 #include <stdio.h>
+#include <errno.h>
 #include "sensors.h"
 #include "data.h"
 #include "error.h"
@@ -29,7 +30,8 @@
 #include "scanner.h"
 #include "init.h"
 
-#define DEFAULT_CONFIG_FILE	ETCDIR "/sensors.conf"
+#define DEFAULT_CONFIG_FILE	ETCDIR "/sensors3.conf"
+#define ALT_CONFIG_FILE		ETCDIR "/sensors.conf"
 
 int sensors_init(FILE *input)
 {
@@ -49,6 +51,8 @@ int sensors_init(FILE *input)
 	} else {
 		/* No configuration provided, use default */
 		input = fopen(DEFAULT_CONFIG_FILE, "r");
+		if (!input && errno = ENOENT)
+			input = fopen(ALT_CONFIG_FILE, "r");
 		if (input) {
 			if (sensors_scanner_init(input) ||
 			    sensors_yyparse()) {
--- lm-sensors-3.orig/lib/libsensors.3	2007-10-24 16:21:18.000000000 +0200
+++ lm-sensors-3/lib/libsensors.3	2007-10-24 16:26:17.000000000 +0200
@@ -24,7 +24,7 @@
 .\"
 .\" References consulted:
 .\"     libsensors source code
-.TH libsensors 3  "June 2007" "lm-sensors 3" "Linux Programmer's Manual"
+.TH libsensors 3  "October 2007" "lm-sensors 3" "Linux Programmer's Manual"
 .SH NAME
 libsensors \- publicly accessible functions provided by the sensors library
 .SH SYNOPSIS
@@ -57,6 +57,9 @@ value unequal to zero, you are in troubl
 be initialized properly. If you want to reload the configuration file, call
 sensors_cleanup() below before calling sensors_init() again.
 
+If FILE is NULL, the default configuration file is used (see the FILES
+section below). Most applications will want to do that.
+
 .B void sensors_cleanup(void);
 .br
 Clean-up function: You can't access anything after this, until the next sensors_init() call!
@@ -168,6 +171,16 @@ data structures.
 .br
 A string representing the version of libsensors.
 
+.SH FILES
+.I /etc/sensors3.conf
+.br
+.I /etc/sensors.conf
+.RS
+The system-wide
+.BR libsensors (3)
+configuration file. /etc/sensors3.conf is tried first, and if it doesn't exist,
+/etc/sensors.conf is used instead.
+
 .SH SEE ALSO
 sensors.conf(5)
 
--- lm-sensors-3.orig/lib/sensors.conf.5	2007-10-24 16:21:18.000000000 +0200
+++ lm-sensors-3/lib/sensors.conf.5	2007-10-24 16:26:17.000000000 +0200
@@ -23,7 +23,7 @@
 .\"
 .\" References consulted:
 .\"     sensors.conf.eg by Frodo Looijaard
-.TH sensors.conf 5  "September 2007" "lm-sensors 3" "Linux User's Manual"
+.TH sensors.conf 5  "October 2007" "lm-sensors 3" "Linux User's Manual"
 .SH NAME
 sensors.conf \- libsensors configuration file
 
@@ -394,6 +394,16 @@ the feature is in the same class as the 
 and there is anywhere else a statement for this specific class member,
 that one takes always precedence.
 
+.SH FILES
+.I /etc/sensors3.conf
+.br
+.I /etc/sensors.conf
+.RS
+The system-wide
+.BR libsensors (3)
+configuration file. /etc/sensors3.conf is tried first, and if it doesn't exist,
+/etc/sensors.conf is used instead.
+
 .SH SEE ALSO
 libsensors(3)
 
--- lm-sensors-3.orig/prog/sensord/sensord.8	2007-10-24 16:26:57.000000000 +0200
+++ lm-sensors-3/prog/sensord/sensord.8	2007-10-24 16:27:21.000000000 +0200
@@ -360,6 +360,8 @@ after which the daemon will exit.
 Round-robin database support doesn't cope with
 multiple sensor chips having duplicate sensor labels.
 .SH FILES
+.I /etc/sensors3.conf
+.br
 .I /etc/sensors.conf
 .RS
 The system-wide
--- lm-sensors-3.orig/prog/sensors/sensors.1	2007-10-24 16:26:55.000000000 +0200
+++ lm-sensors-3/prog/sensors/sensors.1	2007-10-24 16:27:16.000000000 +0200
@@ -74,6 +74,8 @@ buses of the same type. As bus numbers a
 over reboots, these statements let you refer to each bus by its name rather
 than numbers.
 .SH FILES
+.I /etc/sensors3.conf
+.br
 .I /etc/sensors.conf
 .RS
 The system wide configuration file. See


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
