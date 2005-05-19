From: peb@mppmu.mpg.de (Peter Breitenlohner)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: lm_sensors-2.2.8 -- a comment (+patch) and a question
Message-Id: <Pine.LNX.4.58.0401161140590.14623@pcl321.mppmu.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

1. I recently fetched , built, and installed your i2c and lm_sensors
packages (v2.2.8). I noticed that your Makefiles have been DESTDIRized, but
unfortunately not completely so. The attached patch should add (some of
the?) missing pieces.

2. I noticed that both packages (i2c and lm_sensors) contain header files
kernel/include/i2c-dev.h that got installed (in my case) as
/usr/local/include/linux/i2c-dev.h. These two files are, however, NOT
identical. Actually there is a rather short one with 1578 bytes from i2c and
a longer on with 12372 bytes form lm_sensors.

This is very confusiong and, if I were to install i2c a second time (for
whatever reasons) might lead to all sort of problems.

Why these to different versions of the same header??????????

Peter Breitenlohner <peb@mppmu.mpg.de>
-------------- next part --------------
diff -ur lm_sensors-2.8.2.orig/prog/eeprom/Module.mk lm_sensors-2.8.2/prog/eeprom/Module.mk
--- lm_sensors-2.8.2.orig/prog/eeprom/Module.mk	2003-11-29 14:29:59.000000000 +0100
+++ lm_sensors-2.8.2/prog/eeprom/Module.mk	2003-12-24 16:35:24.000000000 +0100
@@ -23,7 +23,8 @@
                      $(MODULE_DIR)/decode-vaio.pl
 
 install-prog-eeprom: $(PROGEEPROMTARGETS)
-	$(INSTALL) -o root -g root -m 755 $(PROGEEPROMTARGETS) $(BINDIR)
+	mkdir -p $(DESTDIR)$(BINDIR)
+	$(INSTALL) -o root -g root -m 755 $(PROGEEPROMTARGETS) $(DESTDIR)$(BINDIR)
 
 user_install :: install-prog-eeprom
 
diff -ur lm_sensors-2.8.2.orig/prog/pwm/Module.mk lm_sensors-2.8.2/prog/pwm/Module.mk
--- lm_sensors-2.8.2.orig/prog/pwm/Module.mk	2003-10-28 02:41:47.000000000 +0100
+++ lm_sensors-2.8.2/prog/pwm/Module.mk	2003-12-24 16:35:24.000000000 +0100
@@ -22,7 +22,8 @@
                   $(MODULE_DIR)/pwmconfig
 
 install-prog-pwm: $(PROGPWMTARGETS)
-	$(INSTALL) -o root -g root -m 755 $(PROGPWMTARGETS) $(SBINDIR)
+	mkdir -p $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -o root -g root -m 755 $(PROGPWMTARGETS) $(DESTDIR)$(SBINDIR)
 
 user_install :: install-prog-pwm
 
diff -ur lm_sensors-2.8.2.orig/prog/xeon/Module.mk lm_sensors-2.8.2/prog/xeon/Module.mk
--- lm_sensors-2.8.2.orig/prog/xeon/Module.mk	2003-11-29 14:29:59.000000000 +0100
+++ lm_sensors-2.8.2/prog/xeon/Module.mk	2003-12-24 16:35:24.000000000 +0100
@@ -21,7 +21,8 @@
 PROGXEONTARGETS := $(MODULE_DIR)/decode-xeon.pl
 
 install-prog-xeon: $(PROGXEONTARGETS)
-	$(INSTALL) -o root -g root -m 755 $(PROGXEONTARGETS) $(BINDIR)
+	mkdir -p $(DESTDIR)$(BINDIR)
+	$(INSTALL) -o root -g root -m 755 $(PROGXEONTARGETS) $(DESTDIR)$(BINDIR)
 
 user_install :: install-prog-xeon
 
