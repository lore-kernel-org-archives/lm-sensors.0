From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 11 Mar 2006 16:09:11 +0000
Subject: [lm-sensors] i2c-2.10.0 and lm_sensors-2.10.0 --- 2 patches
Message-Id: <20060311170911.2d89c0a6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0603080940220.1369@pcl321.mppmu.mpg.de>
In-Reply-To: <Pine.LNX.4.64.0603080940220.1369@pcl321.mppmu.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

> 1. The header i2c-pcf8584.h is included from i2c-algo-pcf.h and should
> therefore installed together with i2c-algo-pcf.h (not with i2c-elektor).

Yes, you're prefectly right. I've applied this part already.

> 2. When running "make KERNELVERSION=version all install" in order to build
> and install the modules for a new (configured and installed, but not yet
> running) kernel, you should use "depmod -a $(KERNELVERSION)" instead of
> "depmod -a". The latter would rebuild the dependencies for the current
> kernel, quite useless in this situation.

Good point. I thought we had been fixing this already, but obviously
this isn't the case.

However, I'd like a more complete fix. There are two methods to compile
i2c/lm_sensors for a different kernel: make KERNELVERSION=version and
make LINUX=/linux. Your patches only fix the former method, and not the
latter, which is the one I use.

In fact it looks to me like our Makefiles were not meant to use the
value of KERNELVERSION past the line where we set LINUX from it. For
the rest of build process, the version is extracted again from the
source LINUX points to (in MODPREF).

So I would suggest the following patch for lm_sensors instead (and
something similar for i2c). It includes your own change:

Index: Makefile
=================================RCS file: /home/cvs/lm_sensors2/Makefile,v
retrieving revision 1.103
diff -u -r1.103 Makefile
--- Makefile	23 Feb 2006 22:58:52 -0000	1.103
+++ Makefile	11 Mar 2006 16:57:39 -0000
@@ -82,7 +82,8 @@
 # This is the main modules directory into which the modules will be installed.
 # The magic invocation will return something like this:
 #   /lib/modules/2.4.29
-MODPREF := /lib/modules/$(shell $(CC) -I$(LINUX_HEADERS) -E etc/config.c | grep uts_release |cut -f 2 -d'"')
+KERNELVERSION = $(shell $(CC) -I$(LINUX_HEADERS) -E etc/config.c | grep uts_release |cut -f 2 -d'"')
+MODPREF := /lib/modules/$(KERNELVERSION)
 
 # When building userspace for use with 2.4.x series kernels, we turn off
 # sysfs support by default.  You can override this (e.g. if you want
@@ -319,7 +320,7 @@
 all :: user
 install :: all user_install
 ifeq ($(DESTDIR),)
-	-/sbin/depmod -a
+	-/sbin/depmod -a $(KERNELVERSION)
 else
 	@echo "*** This is a \`staged' install using \"$(DESTDIR)\" as prefix."
 	@echo "***"

What do you think? That way setting either LINUX or KERNELVERSION on
the command line will work.

Note that I ended up with an error either way. I'm running a 2.6
kernel, and when building lm_sensors for a 2.4.32 kernel, depmod now
dies with the following error:

/sbin/depmod -a 2.4.32
depmod: QM_MODULES: Function not implemented

Any idea what's going on? I did not have the problem before "thanks" to
our broken Makefile (depmod was run for the 2.6 kernel instead). Now, no
big deal either, the error isn't fatal, but it makes me curious.

Thanks for your patches!

-- 
Jean Delvare

