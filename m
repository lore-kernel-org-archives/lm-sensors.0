From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH] Manpages for i2cdetect and sensors-detect
Message-Id: <20040321202314.GA18469@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Please find attached manpages for i2cdetect and sensors-detect. They are
very small, but the programs are very easy to start (ie very few
options).

Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
--- lm-sensors-2.8.5.orig/prog/detect/Module.mk
+++ lm-sensors-2.8.5/prog/detect/Module.mk
@@ -21,6 +21,9 @@
 MODULE_DIR := prog/detect
 PROGDETECTDIR := $(MODULE_DIR)
 
+PROGDETECTMAN8DIR := $(MANDIR)/man8
+PROGDETECTMAN8FILES := $(MODULE_DIR)/i2cdetect.8 $(MODULE_DIR)/sensors-detect.8
+
 # Regrettably, even 'simply expanded variables' will not put their currently
 # defined value verbatim into the command-list of rules...
 PROGDETECTTARGETS := $(MODULE_DIR)/i2cdetect
@@ -39,8 +42,9 @@
 	$(CC) $(EXLDFLAGS) -o $@ $^
 
 install-prog-detect: all-prog-detect
-	$(MKDIR) $(DESTDIR)$(SBINDIR)
+	$(MKDIR) $(DESTDIR)$(SBINDIR) $(DESTDIR)$(PROGDETECTMAN8DIR)
 	$(INSTALL) -m 755 $(PROGDETECTSBININSTALL) $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -m 644 $(PROGDETECTMAN8FILES) $(DESTDIR)$(PROGDETECTMAN8DIR)
 user_install :: install-prog-detect
 
 clean-prog-detect:
--- lm-sensors-2.8.5.orig/prog/detect/i2cdetect.8
+++ lm-sensors-2.8.5/prog/detect/i2cdetect.8
@@ -0,0 +1,22 @@
+.TH I2CDETECT 8 "March 2004"
+.SH NAME
+i2cdetect \- detect i2c chips
+
+.SH SYNOPSIS
+.B i2cdetect 
+\fI-l\fR | \fII2CBUS\fR
+
+.SH DESCRIPTION
+i2cdetect is a userspace program to scan an i2c bus for devices. It outputs
+a table with the list of detected devices on the specified bus.
+.PP
+WARNING! This program can confuse your I2C bus, cause data loss and worse!
+
+.SH OPTIONS
+.TP
+.B "\-l"
+Outputs a list of installed busses.
+
+.SH AUTHOR
+This manual page was written by Aurelien Jarno <aurel32@debian.org>, for
+the Debian GNU/Linux system (but may be used by others).
--- lm-sensors-2.8.5.orig/prog/detect/sensors-detect.8
+++ lm-sensors-2.8.5/prog/detect/sensors-detect.8
@@ -0,0 +1,14 @@
+.TH SENSORS-DETECT 8 "May 1999"
+.SH NAME
+sensors-detect \- detect lm-sensors chips
+
+.SH SYNOPSIS
+.B sensors-detect
+
+.SH DESCRIPTION
+sensors-detect is an interactive program that will walk you through the
+process of scanning your system for various sensors supported by lm-sensors.
+
+.SH AUTHOR
+This manual page was written by Joey Hess <joey@debian.org>, for
+the Debian GNU/Linux system (but may be used by others).
