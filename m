From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: porting libsensors to the 2.6 kernel's /sys interface
Message-Id: <20030730181827.25cc2bd7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <CBF7F1A2-C175-11D7-BB43-003065DC6B50@ghz.cc>
In-Reply-To: <CBF7F1A2-C175-11D7-BB43-003065DC6B50@ghz.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> >> So is there any need to include the kernel headers when compiling 
> >> other
> >> parts of lm_sensors? In particular, I ran into trouble with the 2.6
> >> version of linux/sysctl.h, and disabling $(LINUX_HEADERS) in the
> >> makefile (by setting it to '.') picked up
> >/usr/include/linux/sysctl.h,> which resulted in a much happier
> >compiler.
> >
> > NEVER use kernel header files from userspace!!!
> 
> Honest, the Makefile did it, not me! It broke hardcore against 2.6 
> (__user macros and all), so that's why I was trying to figure out what
> was going on there.
> 
> > Use the glibc sanitized ones that your glibc is built against.  If
> > not, bad things will happen.
> 
> OK, so basically what that means is that LINUX_HEADERS needs to come 
> out of ALL_CPPFLAGS (or some similar kernel/userspace CPPFLAGS split 
> has to happen).

Proposed patch attached. Can you give it a try and tell us how it works
for you? Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Index: Makefile
=================================RCS file: /home/cvs/lm_sensors2/Makefile,v
retrieving revision 1.72
diff -u -r1.72 Makefile
--- Makefile	8 Jul 2003 09:06:50 -0000	1.72
+++ Makefile	30 Jul 2003 16:31:07 -0000
@@ -185,7 +185,7 @@
 # PROGCPPFLAGS/PROGCFLAGS is to create non-kernel object files (which are linked into executables).
 # ARCPPFLAGS/ARCFLAGS are used to create archive object files (static libraries).
 # LIBCPPFLAGS/LIBCFLAGS are for shared library objects.
-ALL_CPPFLAGS := -I. -Ikernel/include -I$(I2C_HEADERS) -I$(LINUX_HEADERS)
+ALL_CPPFLAGS := -I. -Ikernel/include -I$(I2C_HEADERS)
 ALL_CFLAGS := -Wall -O2 
 
 ifeq ($(DEBUG),1)
@@ -225,7 +225,7 @@
 # from user space headers.
 kbuild_2_4_nostdinc := -nostdinc $(shell LC_ALL=C $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
 
-MODCPPFLAGS += -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer $(ALL_CPPFLAGS) $(kbuild_2_4_nostdinc)
+MODCPPFLAGS += -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer $(ALL_CPPFLAGS) -I$(LINUX_HEADERS) $(kbuild_2_4_nostdinc)
 MODCFLAGS += $(ALL_CFLAGS)
 PROGCPPFLAGS := $(ALL_CPPFLAGS)
 PROGCFLAGS := $(ALL_CFLAGS)
