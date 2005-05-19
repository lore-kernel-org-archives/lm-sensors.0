From: a.voropay@vmb-service.ru (Alexander Voropay)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors-2.4.5 on RedHat 8.0 default kernel
Message-Id: <01cd01c37bae$35422880$1701a8c0@ALEC>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

 There is problem during compilation "lm_sensors-2.4.5"
on RedHat 8.0 kernel "2.4.18-14" (default installation kernel).

 As it is known, RedHad uses deeply patced kernel with
"i2c" v2.6.3 built-in. It is _very_ difficult to change "i2c"
to new version, so I need to build old "lm_sensors-2.4.5"

====== insmod works OK ====
[root@xeon ~]# insmod i2c-i801
[root@xeon ~]# dmesg
...
i2c-core.o: i2c core module
i2c-i801.o version 2.6.3 (20020322)
i2c-core.o: adapter SMBus I801 adapter at 0580 registered as adapter 0.
i2c-i801.o: I801 bus detected and initialized
i2c-core.o: adapter unregistered: SMBus I801 adapter at 0580
=====

 Unfortunately, it is impossible to build "lm_sensors-2.4.5"
with this kernel :(  It seems, some *.h are changed, so I need
to change "linux/malloc.h"  --> "linux/slab.h" in all of files.

=======
[root@xeon lm_sensors-2.4.5]# make
..
..
gcc -I. -Ikernel/include -I/usr/local/include -I/usr/src/linux/include
-O2  -D__KERNEL__ -DMODULE -fomit-frame-pointer  -DEXPORT_SYMTAB
-D__SMP__ -DMODVERSIONS -include
/usr/src/linux/include/linux/modversions.h -c kernel/chips/lm80.c -o
kernel/chips/lm80.o
In file included from kernel/chips/lm80.c:24:
/usr/src/linux/include/linux/malloc.h:4:2: #error linux/malloc.h is
deprecated, use linux/slab.h instead.
make: *** [kernel/chips/lm80.o] Error 1
=======

 Is it possible to issue version "lm_sensors-2.4.5.1" for this kind of
kernels ?


--
-=AV=-
