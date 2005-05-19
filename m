From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] Enable the build of isadump only on x86 architectures
Message-Id: <20040321114152.GA10777@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

It seems that isadump is x86 specific, since it makes calls to inb() and
outb(). The others utilities and the library build well on non-x86
architectures. That's why I propose to enable the build of isadump only
on x86 architectures.

The attached patch against current CVS implements that.

Aurelien


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: prog/dump/Module.mk
=================================RCS file: /home/cvs/lm_sensors2/prog/dump/Module.mk,v
retrieving revision 1.14
diff -u -1 -b -p -r1.14 Module.mk
--- lm_sensors2.orig/prog/dump/Module.mk	21 Mar 2004 10:28:48 -0000	1.14
+++ lm_sensors2./prog/dump/Module.mk	21 Mar 2004 10:46:17 -0000
@@ -24,4 +24,3 @@ PROGDUMPDIR := $(MODULE_DIR)
 PROGDUMPMAN8DIR := $(MANDIR)/man8
-PROGDUMPMAN8FILES := $(MODULE_DIR)/isadump.8 $(MODULE_DIR)/i2cdump.8 \
-		     $(MODULE_DIR)/i2cset.8
+PROGDUMPMAN8FILES := $(MODULE_DIR)/i2cdump.8 $(MODULE_DIR)/i2cset.8
 
@@ -29,8 +28,14 @@ PROGDUMPMAN8FILES := $(MODULE_DIR)/isadu
 # defined value verbatim into the command-list of rules...
-PROGDUMPTARGETS := $(MODULE_DIR)/isadump $(MODULE_DIR)/i2cdump \
-		   $(MODULE_DIR)/i2cset
-PROGDUMPSOURCES := $(MODULE_DIR)/isadump.c  $(MODULE_DIR)/i2cdump.c \
-		   $(MODULE_DIR)/i2cset.c $(MODULE_DIR)/i2cbusses.c
-PROGDUMPBININSTALL := $(MODULE_DIR)/isadump $(MODULE_DIR)/i2cdump \
-		   $(MODULE_DIR)/i2cset
+PROGDUMPTARGETS := $(MODULE_DIR)/i2cdump $(MODULE_DIR)/i2cset
+PROGDUMPSOURCES := $(MODULE_DIR)/i2cdump.c $(MODULE_DIR)/i2cset.c \
+		   $(MODULE_DIR)/i2cbusses.c
+PROGDUMPBININSTALL := $(MODULE_DIR)/i2cdump $(MODULE_DIR)/i2cset
+
+# Only build isadump on x86 machines.
+ifneq (,$(findstring $(MACHINE), i386 i486 i586 i686 x86_64))
+PROGDUMPMAN8FILES += $(MODULE_DIR)/isadump.8
+PROGDUMPTARGETS += $(MODULE_DIR)/isadump
+PROGDUMPSOURCES += $(MODULE_DIR)/isadump.c
+PROGDUMPBININSTALL += $(MODULE_DIR)/isadump
+endif
 
