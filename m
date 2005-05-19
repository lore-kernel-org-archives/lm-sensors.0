From: martin@xades.com (Martin Dengler)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [patch] gcc-3.2 problems: i2c local vs. kernel headers
Message-Id: <1051573668.19842.8.camel@earth.xades.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030319172417.GC14159@westend.com>
In-Reply-To: <20030319172417.GC14159@westend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Christian's solution doesn't work perfectly with gcc 3.2.2.  Since this
is an earlier version than his I wouldn't expect a fix, but I thought
I'd email in case this comes up again with other people and RedHat 9
(pulled my hair out for a while).

The problem seems to be that old headers from /usr/include/linux are
being picked up in 3.2.2 and I couldn't find a way to get gcc to use the
right ones.  So I switched to gcc2.96 (on my Redhat 9,
compat-gcc-7.3-2.96.118 provides /usr/bin/gcc296) in the Makefile and
all worked fine.

I am using lm_sensors-2.7.0 on RH9.  The error I got from gcc-3.2.2
after Christian's fix was:

----
[snip]
gcc -M -MG  -D__SMP__ -DMODVERSIONS -include
/lib/modules/2.4.20smp-lowlat-pre/build/include/linux/modversions.h
-D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I.
-Ikernel/include -I/usr/local/include -idirafter
-I/lib/modules/2.4.20smp-lowlat-pre/build/include -O2 
kernel/busses/i2c-ali1535.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1535.d
kernel/busses/i2c-ali1535.o: Makefile '`dirname
kernel/busses/i2c-ali1535.d`/Module.mk' @' > kernel/busses/i2c-ali1535.d
In file included from /usr/include/linux/fs.h:23,
                 from /usr/include/linux/capability.h:17,
                 from /usr/include/linux/binfmts.h:5,
                 from /usr/include/linux/sched.h:9,
                 from kernel/busses/i2c-ali1535.c:63:
/usr/include/linux/string.h:8:2: warning: #warning Using kernel header
in userland!
In file included from /usr/include/linux/bitops.h:69,
                 from /usr/include/asm/system.h:7,
                 from /usr/include/linux/sched.h:16,
                 from kernel/busses/i2c-ali1535.c:63:
/usr/include/asm/bitops.h:327:2: warning: #warning This includefile is
not available on all architectures.
/usr/include/asm/bitops.h:328:2: warning: #warning Using kernel headers
in userspace: atomicity not guaranteed
make: *** No rule to make target `linux/modules/53c700.ver', needed by
`kernel/chips/vt1211.d'.  Stop.
----

This file appears to be a random (first in directory list order) file 
which exists in my kernel headers directory
(/lib/modules/2.4.20smp-lowlat-pre/include/linux/modules/53c700.ver) but
is not found by gcc.  Doh...

Martin



Mark D. Studebaker wrote:
________________________________________________________________________
that looks like an excellent solution. Thank you.

Christian Hammers wrote:
> Hello
> 
> I always got the following error when compiling lm_sensors-2.7.0:
> 
> 
>>	gcc   -DMODVERSIONS -include /lib/modules/2.4.20-bigvideo-1/build/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I.  -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.20-bigvideo-1/build/include   -O2   -c kernel/busses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
> 
> 
>>>	kernel/busses/i2c-amd8111.c:26:2: #error Your i2c is too old - i2c-2.7.0 or greater required!
> 
> 
> This is a compile problem as the include files of 2.7.0 are in
> /usr/local/include/linux/. gcc-3.2.3 just puts /usr/local/include at the
> end of the list although it is first on the command line and the info
> page says the list is scanned left to right.
> 
>>		GNU CPP version 3.2.3 20030316 (Debian prerelease) (cpplib)
>>	(i386 Linux/ELF)
>>	GNU C version 3.2.3 20030316 (Debian prerelease) (i386-linux)
>>		compiled by GNU C version 3.2.3 20030316 (Debian prerelease).
>>	ignoring nonexistent directory "/usr/i386-linux/include"
>>	ignoring duplicate directory "/usr/local/include"
>>	  as it is a non-system directory that duplicates a system directory
>>	#include "..." search starts here:
>>	#include <...> search starts here:
>>	 .
>>	 kernel/include
>>	 /usr/local/include
>>	 /usr/lib/gcc-lib/i386-linux/3.2.3/include
>>	 /usr/include
>>	 /lib/modules/2.4.20-bigvideo-1/build/include
> 
> 
> As a fix I suggest:
> 
> # diff -u Makefile.orig Makefile
> --- Makefile.orig       2003-03-19 18:20:38.000000000 +0100
> +++ Makefile    2003-03-19 18:21:08.000000000 +0100
> @@ -178,7 +178,7 @@
>  # PROGCPPFLAGS/PROGCFLAGS is to create non-kernel object files (which are linked into executables).
>  # ARCPPFLAGS/ARCFLAGS are used to create archive object files (static libraries).
>  # LIBCPPFLAGS/LIBCFLAGS are for shared library objects.
> -ALL_CPPFLAGS := -I. -Ikernel/include -I$(I2C_HEADERS) -I$(LINUX_HEADERS)
> +ALL_CPPFLAGS := -I. -Ikernel/include -I$(I2C_HEADERS) -idirafter $(LINUX_HEADERS)
>  ALL_CFLAGS := -O2 
>  
>  ifeq ($(DEBUG),1)
> 
> 
> 
> bye,
> 
>   -christian-
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030429/989c5d74/attachment.bin
