From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 17 Nov 2007 11:16:32 +0000
Subject: [lm-sensors] PATCH: fix building of 3.0.0-rc3 on powerpc and other
Message-Id: <473ECD90.5090603@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040107030806090306060809"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------040107030806090306060809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I just build 3.0.0-rc3 for Fedora's devel branch and it needs the attached 
patch to compile on powerpc.

I've not committed this to svn as I'm not sure this is the best way todo this.

Regards,

Hans

--------------040107030806090306060809
Content-Type: text/x-patch;
 name="lm_sensors-3.0.0-rc3-ppc-build.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lm_sensors-3.0.0-rc3-ppc-build.patch"

diff -up lm_sensors-3.0.0-rc3/prog/dump/Module.mk~ lm_sensors-3.0.0-rc3/prog/dump/Module.mk
--- lm_sensors-3.0.0-rc3/prog/dump/Module.mk~	2007-11-17 11:56:31.000000000 +0100
+++ lm_sensors-3.0.0-rc3/prog/dump/Module.mk	2007-11-17 11:56:31.000000000 +0100
@@ -59,7 +59,10 @@ install-prog-dump: all-prog-dump
 	$(MKDIR) $(DESTDIR)$(SBINDIR) $(DESTDIR)$(PROGDUMPMAN8DIR)
 	$(INSTALL) -m 755 $(PROGDUMPBININSTALL) $(DESTDIR)$(SBINDIR)
 	$(INSTALL) -m 644 $(PROGDUMPMAN8FILES) $(DESTDIR)$(PROGDUMPMAN8DIR)
+
+ifneq (,$(findstring $(MACHINE), i386 i486 i586 i686 x86_64))
 user_install :: install-prog-dump
+endif
 
 user_uninstall::
 	$(RM) $(REMOVEDUMPBIN)

--------------040107030806090306060809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------040107030806090306060809--
