From: peb@mppmu.mpg.de (Peter Breitenlohner)
Date: Wed, 08 Mar 2006 08:50:38 +0000
Subject: [lm-sensors] i2c-2.10.0 and lm_sensors-2.10.0 --- 2 patches
Message-Id: <Pine.LNX.4.64.0603080940220.1369@pcl321.mppmu.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'd like to suggest the attached two patches for i2c-2.10.0 and
lm_sensors-2.10.0.

Why?

1. The header i2c-pcf8584.h is included from i2c-algo-pcf.h and should
therefore installed together with i2c-algo-pcf.h (not with i2c-elektor).

2. When running "make KERNELVERSION=version all install" in order to build
and install the modules for a new (configured and installed, but not yet
running) kernel, you should use "depmod -a $(KERNELVERSION)" instead of
"depmod -a". The latter would rebuild the dependencies for the current
kernel, quite useless in this situation.

Please answer directly, since I'm not on this list.

regards
Peter Breitenlohner <peb at mppmu.mpg.de>
-------------- next part --------------
diff -ur i2c-2.10.0.orig/Makefile i2c-2.10.0/Makefile
--- i2c-2.10.0.orig/Makefile	2005-07-24 17:40:03.000000000 +0200
+++ i2c-2.10.0/Makefile	2006-03-07 22:44:54.000000000 +0100
@@ -211,7 +211,7 @@
 
 install :: all
 ifeq ($(DESTDIR),)
-	-/sbin/depmod -a
+	-/sbin/depmod -a $(KERNELVERSION)
 else
 	@echo "*** This is a \`staged' install using \"$(DESTDIR)\" as prefix."
 	@echo "***"
diff -ur i2c-2.10.0.orig/kernel/Module.mk i2c-2.10.0/kernel/Module.mk
--- i2c-2.10.0.orig/kernel/Module.mk	2005-05-12 19:25:24.000000000 +0200
+++ i2c-2.10.0/kernel/Module.mk	2006-03-07 21:08:08.000000000 +0100
@@ -58,11 +58,11 @@
 ifneq ($(shell if grep -q '^CONFIG_I2C_ALGOPCF=y' $(LINUX)/.config; then echo 1; fi),1)
 KERNELTARGETS += $(MODULE_DIR)/i2c-algo-pcf.o
 KERNELINCLUDES += $(MODULE_DIR)/i2c-algo-pcf.h
+KERNELINCLUDES += $(MODULE_DIR)/i2c-pcf8584.h
 endif
 # will not build outside kernel tree 
 ifneq ($(shell if grep -q '^CONFIG_I2C_ELEKTOR=y' $(LINUX)/.config; then echo 1; fi),1)
 #KERNELTARGETS += $(MODULE_DIR)/i2c-elektor.o
-#KERNELINCLUDES += $(MODULE_DIR)/i2c-pcf8584.h
 endif
 ifneq ($(shell if grep -q '^CONFIG_I2C_PROC=y' $(LINUX)/.config; then echo 1; fi),1)
 KERNELTARGETS += $(MODULE_DIR)/i2c-proc.o
-------------- next part --------------
diff -ur lm_sensors-2.10.0.orig/Makefile lm_sensors-2.10.0/Makefile
--- lm_sensors-2.10.0.orig/Makefile	2006-02-15 02:46:46.000000000 +0100
+++ lm_sensors-2.10.0/Makefile	2006-03-07 22:43:46.000000000 +0100
@@ -321,7 +321,7 @@
 all :: user
 install :: all user_install
 ifeq ($(DESTDIR),)
-	-/sbin/depmod -a
+	-/sbin/depmod -a $(KERNELVERSION)
 else
 	@echo "*** This is a \`staged' install using \"$(DESTDIR)\" as prefix."
 	@echo "***"
