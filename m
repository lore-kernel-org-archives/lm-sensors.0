From: ch@lathspell.de (Christian Hammers)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [patch] gcc-3.2 problems: i2c local vs. kernel headers
Message-Id: <20030319172417.GC14159@westend.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

I always got the following error when compiling lm_sensors-2.7.0:

> 	gcc   -DMODVERSIONS -include /lib/modules/2.4.20-bigvideo-1/build/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I.  -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.20-bigvideo-1/build/include   -O2   -c kernel/busses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o

>> 	kernel/busses/i2c-amd8111.c:26:2: #error Your i2c is too old - i2c-2.7.0 or greater required!

This is a compile problem as the include files of 2.7.0 are in
/usr/local/include/linux/. gcc-3.2.3 just puts /usr/local/include at the
end of the list although it is first on the command line and the info
page says the list is scanned left to right.
>		GNU CPP version 3.2.3 20030316 (Debian prerelease) (cpplib)
>	(i386 Linux/ELF)
>	GNU C version 3.2.3 20030316 (Debian prerelease) (i386-linux)
>		compiled by GNU C version 3.2.3 20030316 (Debian prerelease).
>	ignoring nonexistent directory "/usr/i386-linux/include"
>	ignoring duplicate directory "/usr/local/include"
>	  as it is a non-system directory that duplicates a system directory
>	#include "..." search starts here:
>	#include <...> search starts here:
>	 .
>	 kernel/include
>	 /usr/local/include
>	 /usr/lib/gcc-lib/i386-linux/3.2.3/include
>	 /usr/include
>	 /lib/modules/2.4.20-bigvideo-1/build/include

As a fix I suggest:

# diff -u Makefile.orig Makefile
--- Makefile.orig       2003-03-19 18:20:38.000000000 +0100
+++ Makefile    2003-03-19 18:21:08.000000000 +0100
@@ -178,7 +178,7 @@
 # PROGCPPFLAGS/PROGCFLAGS is to create non-kernel object files (which are linked into executables).
 # ARCPPFLAGS/ARCFLAGS are used to create archive object files (static libraries).
 # LIBCPPFLAGS/LIBCFLAGS are for shared library objects.
-ALL_CPPFLAGS := -I. -Ikernel/include -I$(I2C_HEADERS) -I$(LINUX_HEADERS)
+ALL_CPPFLAGS := -I. -Ikernel/include -I$(I2C_HEADERS) -idirafter $(LINUX_HEADERS)
 ALL_CFLAGS := -O2 
 
 ifeq ($(DEBUG),1)



bye,

  -christian-

-- 
 Big Misunderstandings #6398: The Titanic was not supposed to be
 unsinkable. The designer had a speech impediment. He said: "I have
 thith great unthinkable conthept ..."
