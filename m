From: aurel32@debian.org (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: [PATCH] I2C: Support for sparc64
Message-Id: <20050103002237.GA7554@bode.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Please find attached a patch that was send to me by a Debian user to
make possible the build of the i2c modules on a sparc64.

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
--- i2c-2.9.0.orig/Makefile
+++ i2c-2.9.0/Makefile
@@ -142,6 +142,12 @@
 	     -mcmodel=kernel -fno-reorder-blocks -finline-limit 00 -fno-strength-reduce
 endif
 
+ifeq ($(MACHINE),sparc64)
+MODCFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow \
+	     -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare \
+	     -Wa,--undeclared-regs
+endif
+
 ifeq ($(SMP),1)
 MODCPPFLAGS += -D__SMP__
 endif
