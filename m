From: haakon.riiser@fys.uio.no (Haakon Riiser)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: lm_sensors 2.8.2 / DESTDIR / root
Message-Id: <20031218214236.GA4787@s.chello.no>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The reason for this email is that I always try to avoid running
Makefiles as root, even during 'make install'.  Therefore, I
always use the DESTDIR feature, when it's available.  Until today,
I always built i2c and lm_sensors by doing

  $ make
  $ make -i install DESTDIR=/foo
  $ cd /foo && su root && fix permissions/ownership && install

The -i flag to make install is a kludge to avoid having to be root
while installing to the DESTDIR, and it's only required because
the files are installed with "-o root -g root".  Using the -i
flag is of course not a good idea, since more fatal errors can
easily fly by undetected.

Today, I upgraded to Linux 2.6.0, and tried a similar install
procedure for lm_sensors, except that the make target is now "user"
and the install target is "user_install".  I now noticed that the
DESTDIR variable is not used everywhere in "user_install", so I
couldn't use the -i kludge anymore.  Instead, I wrote a patch that
removes the "-o root -g root" arguments to install everywhere, and
I also tried to add DESTDIR to all files/directories installed.
(The patch only applies to lm_sensors, not i2c, since only
lm_sensors is required in Linux 2.6.0.)

There's really no reason to say -o root -g root anyway, since if you
do install directly with make install, you have to be logged in as
root, and then the files will get the right ownership by default.
Much of the point of installing to a temporary DESTDIR is that you
don't have to be root, and that you can prepare the installation
by hand.  Fixing the ownership is trivial:

  chown -R root.root $DESTDIR

That being said, here's the patch:

-----BEGIN-----
diff -ru ../lm_sensors-2.8.2/Makefile lm_sensors-2.8.2/Makefile
--- ../lm_sensors-2.8.2/Makefile	2003-11-29 20:59:31.000000000 +0100
+++ lm_sensors-2.8.2/Makefile	2003-12-18 17:58:15.000000000 +0100
@@ -119,11 +119,6 @@
 # manual pages will be installed.
 MANDIR := $(PREFIX)/man
 
-# You should not need to change this. It defines the manual owner and group
-# as which manual pages are installed.
-MANOWN := root
-MANGRP := root
-
 MACHINE := $(shell uname -m)
 
 # Extra non-default programs to build; e.g., sensord
diff -ru ../lm_sensors-2.8.2/etc/Module.mk lm_sensors-2.8.2/etc/Module.mk
--- ../lm_sensors-2.8.2/etc/Module.mk	2003-06-28 22:04:51.000000000 +0200
+++ lm_sensors-2.8.2/etc/Module.mk	2003-12-18 17:55:16.000000000 +0100
@@ -29,7 +29,7 @@
 install-etc:
 	$(MKDIR) $(DESTDIR)$(ETCDIR)
 	if [ ! -e $(DESTDIR)$(ETCINSTALL) ] ; then \
-	  $(INSTALL) -o  root -g root -m 644 $(ETCTARGET) $(DESTDIR)$(ETCINSTALL); \
+	  $(INSTALL) -m 644 $(ETCTARGET) $(DESTDIR)$(ETCINSTALL); \
 	fi
 user_install :: install-etc
 
diff -ru ../lm_sensors-2.8.2/kernel/busses/Module.mk lm_sensors-2.8.2/kernel/busses/Module.mk
--- ../lm_sensors-2.8.2/kernel/busses/Module.mk	2003-06-14 21:25:19.000000000 +0200
+++ lm_sensors-2.8.2/kernel/busses/Module.mk	2003-12-18 17:55:16.000000000 +0100
@@ -105,7 +105,7 @@
 install-kernel-busses: all-kernel-busses
 	if [ -n "$(KERNELBUSSESTARGETS)" ] ; then \
 	  $(MKDIR) $(DESTDIR)$(MODPREF)/kernel/drivers/i2c/busses ; \
-	  $(INSTALL) -o root -g root -m 644 $(KERNELBUSSESTARGETS) $(DESTDIR)$(MODPREF)/kernel/drivers/i2c/busses ; \
+	  $(INSTALL) -m 644 $(KERNELBUSSESTARGETS) $(DESTDIR)$(MODPREF)/kernel/drivers/i2c/busses ; \
 	  for i in $(KERNELBUSSESTARGETS) ; do \
 	    $(RM) $(DESTDIR)$(MODPREF)/misc/`basename $$i` $(DESTDIR)$(MODPREF)/kernel/drivers/i2c/`basename $$i` \
 	          $(DESTDIR)$(MODPREF)/kernel/drivers/i2c/`basename $$i`.gz $(DESTDIR)$(MODPREF)/kernel/drivers/i2c/busses/`basename $$i`.gz ; \
diff -ru ../lm_sensors-2.8.2/kernel/chips/Module.mk lm_sensors-2.8.2/kernel/chips/Module.mk
--- ../lm_sensors-2.8.2/kernel/chips/Module.mk	2003-10-29 06:37:52.000000000 +0100
+++ lm_sensors-2.8.2/kernel/chips/Module.mk	2003-12-18 17:55:16.000000000 +0100
@@ -159,7 +159,7 @@
 install-kernel-chips: all-kernel-chips
 	if [ -n "$(KERNELCHIPSTARGETS)" ] ; then \
 	  $(MKDIR) $(DESTDIR)$(MODPREF)/kernel/drivers/i2c/chips ; \
-	  $(INSTALL) -o root -g root -m 644 $(KERNELCHIPSTARGETS) $(DESTDIR)$(MODPREF)/kernel/drivers/i2c/chips ; \
+	  $(INSTALL) -m 644 $(KERNELCHIPSTARGETS) $(DESTDIR)$(MODPREF)/kernel/drivers/i2c/chips ; \
 	  for i in $(KERNELCHIPSTARGETS) ; do \
 	    $(RM) $(DESTDIR)$(MODPREF)/misc/`basename $$i` $(DESTDIR)$(MODPREF)/kernel/drivers/sensors/`basename $$i` \
 	          $(DESTDIR)$(MODPREF)/kernel/drivers/sensors/`basename $$i`.gz $(DESTDIR)$(MODPREF)/kernel/drivers/chips/`basename $$i`.gz ; \
diff -ru ../lm_sensors-2.8.2/kernel/include/Module.mk lm_sensors-2.8.2/kernel/include/Module.mk
--- ../lm_sensors-2.8.2/kernel/include/Module.mk	2003-11-22 03:32:30.000000000 +0100
+++ lm_sensors-2.8.2/kernel/include/Module.mk	2003-12-18 17:55:16.000000000 +0100
@@ -39,7 +39,7 @@
 install-all-kernel-include:
 	if [ -n "$(KERNELINCLUDEFILES)" ] ; then \
 	  $(MKDIR) $(DESTDIR)$(SYSINCLUDEDIR) ; \
-	  $(INSTALL) -o root -g root -m 644 $(KERNELINCLUDEFILES) $(DESTDIR)$(SYSINCLUDEDIR) ; \
+	  $(INSTALL) -m 644 $(KERNELINCLUDEFILES) $(DESTDIR)$(SYSINCLUDEDIR) ; \
 	fi
 
 user_install :: install-all-kernel-include
diff -ru ../lm_sensors-2.8.2/lib/Module.mk lm_sensors-2.8.2/lib/Module.mk
--- ../lm_sensors-2.8.2/lib/Module.mk	2003-11-16 18:57:29.000000000 +0100
+++ lm_sensors-2.8.2/lib/Module.mk	2003-12-18 17:57:43.000000000 +0100
@@ -106,7 +106,7 @@
 		 echo '         Run the following command: /sbin/ldconfig' ; \
 	     echo '******************************************************************************' ; \
 	fi
-	$(INSTALL) -o root -g root -m 644 $(LIBTARGETS) $(DESTDIR)$(LIBDIR)
+	$(INSTALL) -m 644 $(LIBTARGETS) $(DESTDIR)$(LIBDIR)
 	$(LN) $(LIBSHLIBNAME) $(DESTDIR)$(LIBDIR)/$(LIBSHSONAME)
 	$(LN) $(LIBSHSONAME) $(DESTDIR)$(LIBDIR)/$(LIBSHBASENAME)
 	@if [ "$(DESTDIR)$(LIBDIR)" != "/usr/lib" -a "$(DESTDIR)$(LIBDIR)" != "/lib" ] ; then \
@@ -128,9 +128,9 @@
 		  echo '         Add it and run /sbin/ldconfig for the userspace tools to work.' ; \
 		  echo '******************************************************************************' ) ; \
 	fi
-	$(INSTALL) -o root -g root -m 644 $(LIBHEADERFILES) $(DESTDIR)$(LIBINCLUDEDIR)
-	$(INSTALL) -o $(MANOWN) -g $(MANGRP) -m 644 $(LIBMAN3FILES) $(DESTDIR)$(LIBMAN3DIR)
-	$(INSTALL) -o $(MANOWN) -g $(MANGRP) -m 644 $(LIBMAN5FILES) $(DESTDIR)$(LIBMAN5DIR)
+	$(INSTALL) -m 644 $(LIBHEADERFILES) $(DESTDIR)$(LIBINCLUDEDIR)
+	$(INSTALL) -m 644 $(LIBMAN3FILES) $(DESTDIR)$(LIBMAN3DIR)
+	$(INSTALL) -m 644 $(LIBMAN5FILES) $(DESTDIR)$(LIBMAN5DIR)
 
 
 user_install :: install-lib
diff -ru ../lm_sensors-2.8.2/prog/detect/Module.mk lm_sensors-2.8.2/prog/detect/Module.mk
--- ../lm_sensors-2.8.2/prog/detect/Module.mk	2003-11-29 20:38:10.000000000 +0100
+++ lm_sensors-2.8.2/prog/detect/Module.mk	2003-12-18 17:55:16.000000000 +0100
@@ -40,7 +40,7 @@
 
 install-prog-detect: all-prog-detect
 	mkdir -p $(DESTDIR)$(SBINDIR)
-	$(INSTALL) -o root -g root -m 755 $(PROGDETECTSBININSTALL) $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -m 755 $(PROGDETECTSBININSTALL) $(DESTDIR)$(SBINDIR)
 user_install :: install-prog-detect
 
 clean-prog-detect:
diff -ru ../lm_sensors-2.8.2/prog/dump/Module.mk lm_sensors-2.8.2/prog/dump/Module.mk
--- ../lm_sensors-2.8.2/prog/dump/Module.mk	2003-11-21 05:05:48.000000000 +0100
+++ lm_sensors-2.8.2/prog/dump/Module.mk	2003-12-18 17:55:16.000000000 +0100
@@ -45,7 +45,7 @@
 
 install-prog-dump: all-prog-dump
 	mkdir -p $(DESTDIR)$(SBINDIR)
-	$(INSTALL) -o root -g root -m 755 $(PROGDUMPBININSTALL) $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -m 755 $(PROGDUMPBININSTALL) $(DESTDIR)$(SBINDIR)
 user_install :: install-prog-dump
 
 clean-prog-dump:
diff -ru ../lm_sensors-2.8.2/prog/eeprom/Module.mk lm_sensors-2.8.2/prog/eeprom/Module.mk
--- ../lm_sensors-2.8.2/prog/eeprom/Module.mk	2003-11-29 14:29:59.000000000 +0100
+++ lm_sensors-2.8.2/prog/eeprom/Module.mk	2003-12-18 17:55:16.000000000 +0100
@@ -23,7 +23,8 @@
                      $(MODULE_DIR)/decode-vaio.pl
 
 install-prog-eeprom: $(PROGEEPROMTARGETS)
-	$(INSTALL) -o root -g root -m 755 $(PROGEEPROMTARGETS) $(BINDIR)
+	mkdir -p $(DESTDIR)$(BINDIR)
+	$(INSTALL) -m 755 $(PROGEEPROMTARGETS) $(DESTDIR)$(BINDIR)
 
 user_install :: install-prog-eeprom
 
diff -ru ../lm_sensors-2.8.2/prog/hotplug/Makefile lm_sensors-2.8.2/prog/hotplug/Makefile
--- ../lm_sensors-2.8.2/prog/hotplug/Makefile	2003-05-31 19:30:47.000000000 +0200
+++ lm_sensors-2.8.2/prog/hotplug/Makefile	2003-12-18 17:55:16.000000000 +0100
@@ -18,7 +18,7 @@
 	$(CC) $(CFLAGS) -c $< -o $@
 
 install: all
-	install -o root -g root -m 644 $(OBJS) /lib/modules/$(VER)/kernel/drivers/i2c/busses
+	install -m 644 $(OBJS) /lib/modules/$(VER)/kernel/drivers/i2c/busses
 
 clean:
 	rm -f $(OBJS)
diff -ru ../lm_sensors-2.8.2/prog/pwm/Module.mk lm_sensors-2.8.2/prog/pwm/Module.mk
--- ../lm_sensors-2.8.2/prog/pwm/Module.mk	2003-10-28 02:41:47.000000000 +0100
+++ lm_sensors-2.8.2/prog/pwm/Module.mk	2003-12-18 17:55:16.000000000 +0100
@@ -22,7 +22,8 @@
                   $(MODULE_DIR)/pwmconfig
 
 install-prog-pwm: $(PROGPWMTARGETS)
-	$(INSTALL) -o root -g root -m 755 $(PROGPWMTARGETS) $(SBINDIR)
+	mkdir -p $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -m 755 $(PROGPWMTARGETS) $(DESTDIR)$(SBINDIR)
 
 user_install :: install-prog-pwm
 
diff -ru ../lm_sensors-2.8.2/prog/rrd/Makefile lm_sensors-2.8.2/prog/rrd/Makefile
--- ../lm_sensors-2.8.2/prog/rrd/Makefile	2002-01-05 16:39:17.000000000 +0100
+++ lm_sensors-2.8.2/prog/rrd/Makefile	2003-12-18 17:55:16.000000000 +0100
@@ -41,10 +41,10 @@
 	install -d -o $(USER) -m 777 $(APACHDIR)/pix
 
 install: all $(RRDB) $(SENSDIR) $(CRONTAB) $(APACHDIR)/pix
-	install -o root -g root -m 755 sens_update_rrd $(BINPATH)
-	install -o root -g root -m 755 sens_week.cgi $(APACHDIR)
-	install -o root -g root -m 755 sens_day.cgi $(APACHDIR)
-	install -o root -g root -m 755 summ_week.cgi $(APACHDIR)
+	install -m 755 sens_update_rrd $(BINPATH)
+	install -m 755 sens_week.cgi $(APACHDIR)
+	install -m 755 sens_day.cgi $(APACHDIR)
+	install -m 755 summ_week.cgi $(APACHDIR)
 #	grep sens_update_rrd $(CRONTAB) > /dev/null 2>&1 || echo '*/5 * * * *	/usr/local/bin/sens_update_rrd' $(RRDB) $(SENSDEV) >> $(CRONTAB)
 	@echo
 	@echo Note!!! You must manually install the following line in the crontab for user $(USER):
diff -ru ../lm_sensors-2.8.2/prog/sensord/Module.mk lm_sensors-2.8.2/prog/sensord/Module.mk
--- ../lm_sensors-2.8.2/prog/sensord/Module.mk	2003-08-11 10:47:15.000000000 +0200
+++ lm_sensors-2.8.2/prog/sensord/Module.mk	2003-12-18 17:57:28.000000000 +0100
@@ -45,8 +45,8 @@
 
 install-prog-sensord: all-prog-sensord
 	$(MKDIR) $(DESTDIR)$(SBINDIR) $(DESTDIR)$(PROGSENSORDMAN1DIR)
-	$(INSTALL) -o root -g root -m 755 $(PROGSENSORDTARGETS) $(DESTDIR)$(SBINDIR)
-	$(INSTALL) -o $(MANOWN) -g $(MANGRP) -m 644 $(PROGSENSORDMAN1FILES) $(DESTDIR)$(PROGSENSORDMAN1DIR)
+	$(INSTALL) -m 755 $(PROGSENSORDTARGETS) $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -m 644 $(PROGSENSORDMAN1FILES) $(DESTDIR)$(PROGSENSORDMAN1DIR)
 user_install :: install-prog-sensord
 
 clean-prog-sensord:
diff -ru ../lm_sensors-2.8.2/prog/sensors/Module.mk lm_sensors-2.8.2/prog/sensors/Module.mk
--- ../lm_sensors-2.8.2/prog/sensors/Module.mk	2003-06-28 22:04:50.000000000 +0200
+++ lm_sensors-2.8.2/prog/sensors/Module.mk	2003-12-18 17:57:07.000000000 +0100
@@ -41,8 +41,8 @@
 
 install-prog-sensors: all-prog-sensors
 	mkdir -p $(DESTDIR)$(BINDIR) $(DESTDIR)$(PROGSENSORSMAN1DIR)
-	$(INSTALL) -o root -g root -m 755 $(PROGSENSORSTARGETS) $(DESTDIR)$(BINDIR)
-	$(INSTALL) -o $(MANOWN) -g $(MANGRP) -m 644 $(PROGSENSORSMAN1FILES) $(DESTDIR)$(PROGSENSORSMAN1DIR)
+	$(INSTALL) -m 755 $(PROGSENSORSTARGETS) $(DESTDIR)$(BINDIR)
+	$(INSTALL) -m 644 $(PROGSENSORSMAN1FILES) $(DESTDIR)$(PROGSENSORSMAN1DIR)
 user_install :: install-prog-sensors
 
 clean-prog-sensors:
diff -ru ../lm_sensors-2.8.2/prog/xeon/Module.mk lm_sensors-2.8.2/prog/xeon/Module.mk
--- ../lm_sensors-2.8.2/prog/xeon/Module.mk	2003-11-29 14:29:59.000000000 +0100
+++ lm_sensors-2.8.2/prog/xeon/Module.mk	2003-12-18 17:55:16.000000000 +0100
@@ -21,7 +21,8 @@
 PROGXEONTARGETS := $(MODULE_DIR)/decode-xeon.pl
 
 install-prog-xeon: $(PROGXEONTARGETS)
-	$(INSTALL) -o root -g root -m 755 $(PROGXEONTARGETS) $(BINDIR)
+	mkdir -p $(DESTDIR)$(BINDIR)
+	$(INSTALL) -m 755 $(PROGXEONTARGETS) $(DESTDIR)$(BINDIR)
 
 user_install :: install-prog-xeon
 
-----END-----

-- 
 Haakon
