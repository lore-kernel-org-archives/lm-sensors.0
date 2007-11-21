From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 21 Nov 2007 20:46:43 +0000
Subject: Re: [lm-sensors] PATCH: fix building of 3.0.0-rc3 on powerpc and
Message-Id: <47449933.7060206@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090105060008010404030400"
List-Id: <lm-sensors.vger.kernel.org>
References: <473ECD90.5090603@hhs.nl>
In-Reply-To: <473ECD90.5090603@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090105060008010404030400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare wrote:
> Hi Hans,
> 
> On Sat, 17 Nov 2007 12:16:32 +0100, Hans de Goede wrote:
>> Hi All,
>>
>> I just build 3.0.0-rc3 for Fedora's devel branch and it needs the attached 
>> patch to compile on powerpc.
>>
>> I've not committed this to svn as I'm not sure this is the best way todo this.
> 
> Good catch, thanks. I'd rather address the problem in the top Makefile:
> there's no point in including prog/dump in the list of source
> directories if we won't build anything there. So I'd suggest something
> like:
> 
> ifneq (,$(findstring $(MACHINE), i386 i486 i586 i686 x86_64))
> SRCDIRS += prog/dump
> endif
> 
> in the top Makefile. Then you can even remove the architecture tests
> in prog/dump/Module.mk, as they will be redundant, and clean up that
> file a bit.
> 

mm, so I came up with the attached patch, but for some reason that does not 
work as MODULE_DIR gets set to prog/dump when executing install-etc on 
platforms which do include isadump like x86_64:

mkdir -p /var/tmp/lm_sensors-3.0.0-0.1.rc3.fc9-root-kojibuilder/etc
if [ ! -e 
/var/tmp/lm_sensors-3.0.0-0.1.rc3.fc9-root-kojibuilder/etc/sensors3.conf ] ; then \
	  install -m 644 etc/sensors.conf.eg 
/var/tmp/lm_sensors-3.0.0-0.1.rc3.fc9-root-kojibuilder/etc/sensors3.conf; \
	fi
mkdir -p /var/tmp/lm_sensors-3.0.0-0.1.rc3.fc9-root-kojibuilder/usr/bin
install -m 755 prog/dump/sensors-conf-convert 
/var/tmp/lm_sensors-3.0.0-0.1.rc3.fc9-root-kojibuilder/usr/bin
install: cannot stat `prog/dump/sensors-conf-convert': No such file or directory
make: *** [install-etc] Error 1

Regards,

Hans

--------------090105060008010404030400
Content-Type: text/x-patch;
 name="lm_sensors-3.0.0-rc3-ppc-build.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lm_sensors-3.0.0-rc3-ppc-build.patch"

diff -up lm_sensors-3.0.0-rc3/Makefile~ lm_sensors-3.0.0-rc3/Makefile
--- lm_sensors-3.0.0-rc3/Makefile~	2007-11-21 19:48:16.000000000 +0100
+++ lm_sensors-3.0.0-rc3/Makefile	2007-11-21 19:48:16.000000000 +0100
@@ -99,9 +99,12 @@ MACHINE := $(shell uname -m)
 # to do this. 
 
 # The subdirectories we need to build things in 
-SRCDIRS :=
-SRCDIRS += lib prog/detect prog/dump prog/pwm \
+SRCDIRS := lib prog/detect prog/pwm \
            prog/sensors ${PROG_EXTRA:%=prog/%} etc
+# Only build isadump and isaset on x86 machines.
+ifneq (,$(findstring $(MACHINE), i386 i486 i586 i686 x86_64))
+SRCDIRS += prog/dump
+endif
 SRCDIRS += lib/test
 
 # Some often-used commands with default options
diff -up lm_sensors-3.0.0-rc3/prog/dump/Module.mk~ lm_sensors-3.0.0-rc3/prog/dump/Module.mk
--- lm_sensors-3.0.0-rc3/prog/dump/Module.mk~	2007-11-21 19:47:28.000000000 +0100
+++ lm_sensors-3.0.0-rc3/prog/dump/Module.mk	2007-11-21 19:47:28.000000000 +0100
@@ -22,22 +22,14 @@ MODULE_DIR := prog/dump
 PROGDUMPDIR := $(MODULE_DIR)
 
 PROGDUMPMAN8DIR := $(MANDIR)/man8
-PROGDUMPMAN8FILES :=
+PROGDUMPMAN8FILES := $(MODULE_DIR)/isadump.8 $(MODULE_DIR)/isaset.8
 
 # Regrettably, even 'simply expanded variables' will not put their currently
 # defined value verbatim into the command-list of rules...
-PROGDUMPTARGETS :=
-PROGDUMPSOURCES := $(MODULE_DIR)/util.c
-PROGDUMPBININSTALL :=
-
-# Only build isadump and isaset on x86 machines.
-ifneq (,$(findstring $(MACHINE), i386 i486 i586 i686 x86_64))
-PROGDUMPMAN8FILES += $(MODULE_DIR)/isadump.8 $(MODULE_DIR)/isaset.8
-PROGDUMPTARGETS += $(MODULE_DIR)/isadump $(MODULE_DIR)/isaset
-PROGDUMPSOURCES += $(MODULE_DIR)/isadump.c $(MODULE_DIR)/isaset.c \
-		   $(MODULE_DIR)/superio.c
-PROGDUMPBININSTALL += $(MODULE_DIR)/isadump $(MODULE_DIR)/isaset
-endif
+PROGDUMPTARGETS := $(MODULE_DIR)/isadump $(MODULE_DIR)/isaset
+PROGDUMPSOURCES := $(MODULE_DIR)/util.c $(MODULE_DIR)/isadump.c \
+		   $(MODULE_DIR)/isaset.c $(MODULE_DIR)/superio.c
+PROGDUMPBININSTALL := $(MODULE_DIR)/isadump $(MODULE_DIR)/isaset
 
 # Include all dependency files. We use '.rd' to indicate this will create
 # executables.

--------------090105060008010404030400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090105060008010404030400--
