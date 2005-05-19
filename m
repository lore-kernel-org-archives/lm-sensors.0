From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [PATCH] i2c-nforce2 and mkpatch
Message-Id: <20040416191726.GB31563@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040416184158.GA31563@pc.aurel32.private>
In-Reply-To: <20040416184158.GA31563@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

New patch, this time the help is working.

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN lm_sensors2.orig/kernel/busses/Module.mk lm_sensors2/kernel/busses/Module.mk
--- lm_sensors2.orig/kernel/busses/Module.mk	2004-04-16 20:32:04.000000000 +0200
+++ lm_sensors2/kernel/busses/Module.mk	2004-04-16 20:33:19.000000000 +0200
@@ -25,7 +25,6 @@
 # defined value verbatim into the command-list of rules...
 # These targets are NOT included in 'mkpatch' ...
 KERNELBUSSESTARGETS :-KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-nforce2.o
 ifeq ($(shell if grep -q '^CONFIG_IPMI_HANDLER=' $(LINUX)/.config; then echo 1; fi),1)
 KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-ipmb.o
 KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-ipmi.o
@@ -56,6 +55,9 @@
 ifneq ($(shell if grep -q '^CONFIG_I2C_ISA=y' $(LINUX)/.config; then echo 1; fi),1)
 KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-isa.o
 endif
+ifneq ($(shell if grep -q '^CONFIG_I2C_NFORCE2=y' $(LINUX)/.config; then echo 1; fi),1)
+KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-nforce2.o
+endif
 ifneq ($(shell if grep -q '^CONFIG_I2C_SIS5595=y' $(LINUX)/.config; then echo 1; fi),1)
 KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-sis5595.o
 endif
diff -urN lm_sensors2.orig/mkpatch/FILES lm_sensors2/mkpatch/FILES
--- lm_sensors2.orig/mkpatch/FILES	2004-04-16 20:32:04.000000000 +0200
+++ lm_sensors2/mkpatch/FILES	2004-04-16 20:33:19.000000000 +0200
@@ -6,6 +6,7 @@
 kernel/busses/i2c-i801.c	drivers/i2c/i2c-i801.c
 kernel/busses/i2c-i810.c	drivers/i2c/i2c-i810.c
 kernel/busses/i2c-isa.c		drivers/i2c/i2c-isa.c
+kernel/busses/i2c-nforce2.c     drivers/i2c/i2c-nforce2.c
 kernel/busses/i2c-piix4.c	drivers/i2c/i2c-piix4.c
 kernel/busses/i2c-savage4.c	drivers/i2c/i2c-savage4.c
 kernel/busses/i2c-sis5595.c	drivers/i2c/i2c-sis5595.c
diff -urN lm_sensors2.orig/mkpatch/mkpatch.pl lm_sensors2/mkpatch/mkpatch.pl
--- lm_sensors2.orig/mkpatch/mkpatch.pl	2004-04-16 20:32:04.000000000 +0200
+++ lm_sensors2/mkpatch/mkpatch.pl	2004-04-16 20:57:53.000000000 +0200
@@ -88,6 +88,7 @@
            m@Intel I801@ or
            m@Intel I810/I815 based Mainboard@ or
            m@Intel 82371AB PIIX4\(E\)@ or
+           m@Nvidia Nforce2@ or
            m@Silicon Integrated Systems Corp. SiS5595 based Mainboard@ or
            m@VIA Technologies, Inc. VT82C586B@ or
            m@VIA Technologies, Inc. VT82C596, 596B, 686A/B, 8233@ or
@@ -201,6 +202,13 @@
   built as a module which can be inserted and removed while the kernel
   is running.
 
+Nvidia Nforce2 based Mainboard
+CONFIG_I2C_NFORCE2
+  If you say yes to this option, support will be included for the 
+  Nvidia Nforce2 family of mainboard I2C interfaces. This can also be
+  built as a module which can be inserted and removed while the kernel
+  is running.
+
 Silicon Integrated Systems Corp. SiS5595 based Mainboard
 CONFIG_I2C_SIS5595
   If you say yes to this option, support will be included for the 
@@ -851,6 +859,7 @@
     dep_tristate '  Intel 82801AA, AB, BA, DB' CONFIG_I2C_I801 $CONFIG_I2C
     dep_tristate '  Intel i810AA/AB/E and i815' CONFIG_I2C_I810 $CONFIG_I2C_ALGOBIT
     dep_tristate '  Intel 82371AB PIIX4(E), 443MX, ServerWorks OSB4/CSB5, SMSC Victory66' CONFIG_I2C_PIIX4 $CONFIG_I2C
+    dep_tristate '  Nvidia Nforce2' CONFIG_I2C_NFORCE2 $CONFIG_I2C
     dep_tristate '  SiS 5595' CONFIG_I2C_SIS5595 $CONFIG_I2C
     dep_tristate '  SiS 630/730' CONFIG_I2C_SIS630 $CONFIG_I2C
     dep_tristate '  SiS 645/961,645DX/961,735' CONFIG_I2C_SIS645 $CONFIG_I2C $CONFIG_HOTPLUG
@@ -966,6 +975,7 @@
 obj-$(CONFIG_I2C_I801)			+= i2c-i801.o
 obj-$(CONFIG_I2C_I810)			+= i2c-i810.o
 obj-$(CONFIG_I2C_ISA)			+= i2c-isa.o
+obj-$(CONFIG_I2C_NFORCE2)		+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PIIX4)			+= i2c-piix4.o
 obj-$(CONFIG_I2C_SIS5595)		+= i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)		+= i2c-sis630.o
