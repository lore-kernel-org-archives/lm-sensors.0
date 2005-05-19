From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH] Architecture dependent build flags
Message-Id: <20050310022816.GA928@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Please find two patches, one for i2c and one for lm-sensors, to set
gcc flags that are architecture dependent (to match the kernel ABI).

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: Makefile
=================================RCS file: /home/cvs/i2c/Makefile,v
retrieving revision 1.35
diff -u -d -p -r1.35 Makefile
--- Makefile	3 Jan 2005 18:38:09 -0000	1.35
+++ Makefile	10 Mar 2005 02:37:53 -0000
@@ -134,7 +134,7 @@ MODCFLAGS := $(CFLAGS) -D__KERNEL__ -DMO
              -DEXPORT_SYMTAB
 
 ifeq ($(MACHINE),alpha)
-MODCFLAGS += -ffixed-8 -ffixed-8 -mno-fp-regs -mcpu=ev56
+MODCFLAGS += -ffixed-8 -mno-fp-regs -mcpu=ev56
 endif
 
 ifeq ($(MACHINE),x86_64)
@@ -148,6 +148,20 @@ MODCFLAGS += -m64 -pipe -mno-fpu -mcpu=u
 	     -Wa,--undeclared-regs
 endif
 
+ifeq ($(MACHINE),mips)
+MODCFLAGS += -mabi2 -mips3 -Wa,-32 -Wa,-mips3 -Wa,--trap
+endif
+
+ifeq ($(MACHINE),sparc32)
+MODCFLAGS += -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
+endif
+
+ifeq ($(MACHINE),sparc64)
+MODCFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow \
+	     -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare \
+	     -Wa,--undeclared-regs
+endif
+
 ifeq ($(SMP),1)
 MODCPPFLAGS += -D__SMP__
 endif
-------------- next part --------------
Index: Makefile
=================================RCS file: /home/cvs/lm_sensors2/Makefile,v
retrieving revision 1.94
diff -u -d -p -r1.94 Makefile
--- Makefile	7 Feb 2005 19:58:57 -0000	1.94
+++ Makefile	10 Mar 2005 02:39:46 -0000
@@ -215,6 +215,20 @@ MODCFLAGS += -fno-strict-aliasing -fno-c
 	     -mcmodel=kernel -fno-reorder-blocks -finline-limit 00 -fno-strength-reduce
 endif
 
+ifeq ($(MACHINE),mips)
+MODCFLAGS += -mabi2 -mips3 -Wa,-32 -Wa,-mips3 -Wa,--trap
+endif
+
+ifeq ($(MACHINE),sparc32)
+MODCFLAGS += -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
+endif
+
+ifeq ($(MACHINE),sparc64)
+MODCFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow \
+	     -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare \
+	     -Wa,--undeclared-regs
+endif
+
 ifeq ($(SMP),1)
 MODCPPFLAGS += -D__SMP__
 endif
