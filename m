From: cshx@adelphia.net (c.s.h.)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: can you help me fix my screw up?
Message-Id: <200208240035.41511.cshx@adelphia.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I recently was updating my system and I mistakenly messed with the kernel 
stuff.  I thought I had everything back in its place, but I can't seem to 
compile the i2c sensors.  compiling gives errors, which I've included below.

I was hoping it might be easy for you to tell me what I've messed up on my 
system, and that it might be easy to fix.  If not, that's okay.

I'm running Mandrake 8.2 mostly upgraded to 9.0-beta, but with kernel 2.4.18-6

thanks a lot,
--chris

[csh@me-bangor2c-186 i2c-2.6.4]$ make
grep: /usr/src/linux/Makefile: No such file or directory
grep: /usr/src/linux/include/linux/autoconf.h: No such file or directory
grep: /usr/src/linux/.config: No such file or directory
grep: /usr/src/linux/.config: No such file or directory
grep: /usr/src/linux/.config: No such file or directory
grep: /usr/src/linux/.config: No such file or directory
grep: /usr/src/linux/.config: No such file or directory
grep: /usr/src/linux/.config: No such file or directory
grep: /usr/src/linux/.config: No such file or directory
grep: /usr/src/linux/.config: No such file or directory
grep: /usr/src/linux/.config: No such file or directory
grep: /usr/src/linux/.config: No such file or directory
grep: /usr/src/linux/.config: No such file or directory
gcc -I/usr/src/linux/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE 
-fomit-frame-pointer -DEXPORT_SYMTAB -c kernel/i2c-core.c -o 
kernel/i2c-core.o
In file included from /usr/include/linux/prefetch.h:13,
                 from /usr/include/linux/list.h:6,
                 from /usr/include/linux/module.h:11,
                 from kernel/i2c-core.c:26:
/usr/include/asm/processor.h:55: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here 
(not in a function)
/usr/include/asm/processor.h:55: requested alignment is not a constant
In file included from /usr/include/linux/module.h:20,
                 from kernel/i2c-core.c:26:
/usr/include/linux/modversions.h:1:2: #error 
"============================"
/usr/include/linux/modversions.h:2:2: #error "You should not include 
/usr/include/{linux,asm}/ header"
/usr/include/linux/modversions.h:3:2: #error "files directly for the 
compilation of kernel modules."
/usr/include/linux/modversions.h:4:2: #error ""
/usr/include/linux/modversions.h:5:2: #error "glibc now uses kernel header 
files from a well-defined"
/usr/include/linux/modversions.h:6:2: #error "working kernel version (as 
recommended by Linus Torvalds)"
/usr/include/linux/modversions.h:7:2: #error "These files are glibc internal 
and may not match the"
/usr/include/linux/modversions.h:8:2: #error "currently running kernel. They 
should only be"
/usr/include/linux/modversions.h:9:2: #error "included via other system header 
files - user space"
/usr/include/linux/modversions.h:10:2: #error "programs should not directly 
include <linux/*.h> or"
/usr/include/linux/modversions.h:11:2: #error "<asm/*.h> as well."
/usr/include/linux/modversions.h:12:2: #error ""
/usr/include/linux/modversions.h:13:2: #error "To build kernel modules please 
do the following:"
/usr/include/linux/modversions.h:14:2: #error ""
/usr/include/linux/modversions.h:15:2: #error " o Have the kernel sources 
installed"
/usr/include/linux/modversions.h:16:2: #error ""
/usr/include/linux/modversions.h:17:2: #error " o Make sure that the symbolic 
link"
/usr/include/linux/modversions.h:18:2: #error "   /lib/modules/`uname 
-r`/build exists and points to"
/usr/include/linux/modversions.h:19:2: #error "   the matching kernel source 
directory"
/usr/include/linux/modversions.h:20:2: #error ""
/usr/include/linux/modversions.h:21:2: #error " o Now copy 
/boot/vmlinuz.version.h to"
/usr/include/linux/modversions.h:22:2: #error "   /lib/modules/`uname 
-r`/build/include/linux/version.h"
/usr/include/linux/modversions.h:23:2: #error ""
/usr/include/linux/modversions.h:24:2: #error " o When compiling, make sure to 
use the following"
/usr/include/linux/modversions.h:25:2: #error "   compiler option to use the 
correct include files:"
/usr/include/linux/modversions.h:26:2: #error ""
/usr/include/linux/modversions.h:27:2: #error "   -I/lib/modules/`uname 
-r`/build/include"
/usr/include/linux/modversions.h:28:2: #error ""
/usr/include/linux/modversions.h:29:2: #error "   instead of"
/usr/include/linux/modversions.h:30:2: #error ""
/usr/include/linux/modversions.h:31:2: #error "   -I/usr/include/linux"
/usr/include/linux/modversions.h:32:2: #error ""
/usr/include/linux/modversions.h:33:2: #error "   Please adjust the Makefile 
accordingly."
/usr/include/linux/modversions.h:34:2: #error 
"============================"
In file included from /usr/include/linux/module.h:296,
                 from kernel/i2c-core.c:26:
/usr/include/linux/version.h:2:2: #error 
"============================"
/usr/include/linux/version.h:3:2: #error "You should not include 
/usr/include/{linux,asm}/ header"
/usr/include/linux/version.h:4:2: #error "files directly for the compilation 
of kernel modules."
/usr/include/linux/version.h:5:2: #error ""
/usr/include/linux/version.h:6:2: #error "glibc now uses kernel header files 
from a well-defined"
/usr/include/linux/version.h:7:2: #error "working kernel version (as 
recommended by Linus Torvalds)"
/usr/include/linux/version.h:8:2: #error "These files are glibc internal and 
may not match the"
/usr/include/linux/version.h:9:2: #error "currently running kernel. They 
should only be"
/usr/include/linux/version.h:10:2: #error "included via other system header 
files - user space"
/usr/include/linux/version.h:11:2: #error "programs should not directly 
include <linux/*.h> or"
/usr/include/linux/version.h:12:2: #error "<asm/*.h> as well."
/usr/include/linux/version.h:13:2: #error ""
/usr/include/linux/version.h:14:2: #error "To build kernel modules please do 
the following:"
/usr/include/linux/version.h:15:2: #error ""
/usr/include/linux/version.h:16:2: #error " o Have the kernel sources 
installed"
/usr/include/linux/version.h:17:2: #error ""
/usr/include/linux/version.h:18:2: #error " o Make sure that the symbolic 
link"
/usr/include/linux/version.h:19:2: #error "   /lib/modules/`uname -r`/build 
exists and points to"
/usr/include/linux/version.h:20:2: #error "   the matching kernel source 
directory"
/usr/include/linux/version.h:21:2: #error ""
/usr/include/linux/version.h:22:2: #error " o Now copy /boot/vmlinuz.version.h 
to"
/usr/include/linux/version.h:23:2: #error "   /lib/modules/`uname 
-r`/build/include/linux/version.h"
/usr/include/linux/version.h:24:2: #error ""
/usr/include/linux/version.h:25:2: #error " o When compiling, make sure to use 
the following"
/usr/include/linux/version.h:26:2: #error "   compiler option to use the 
correct include files:"
/usr/include/linux/version.h:27:2: #error ""
/usr/include/linux/version.h:28:2: #error "   -I/lib/modules/`uname 
-r`/build/include"
/usr/include/linux/version.h:29:2: #error ""
/usr/include/linux/version.h:30:2: #error "   instead of"
/usr/include/linux/version.h:31:2: #error ""
/usr/include/linux/version.h:32:2: #error "   -I/usr/include/linux"
/usr/include/linux/version.h:33:2: #error ""
/usr/include/linux/version.h:34:2: #error "   Please adjust the Makefile 
accordingly."
/usr/include/linux/version.h:35:2: #error 
"============================"
In file included from kernel/i2c-core.c:26:
/usr/include/linux/module.h:298: parse error before "UTS_RELEASE"
In file included from kernel/i2c.h:45,
                 from kernel/i2c-core.c:32:
/usr/include/linux/version.h:2:2: #error 
"============================"
/usr/include/linux/version.h:3:2: #error "You should not include 
/usr/include/{linux,asm}/ header"
/usr/include/linux/version.h:4:2: #error "files directly for the compilation 
of kernel modules."
/usr/include/linux/version.h:5:2: #error ""
/usr/include/linux/version.h:6:2: #error "glibc now uses kernel header files 
from a well-defined"
/usr/include/linux/version.h:7:2: #error "working kernel version (as 
recommended by Linus Torvalds)"
/usr/include/linux/version.h:8:2: #error "These files are glibc internal and 
may not match the"
/usr/include/linux/version.h:9:2: #error "currently running kernel. They 
should only be"
/usr/include/linux/version.h:10:2: #error "included via other system header 
files - user space"
/usr/include/linux/version.h:11:2: #error "programs should not directly 
include <linux/*.h> or"
/usr/include/linux/version.h:12:2: #error "<asm/*.h> as well."
/usr/include/linux/version.h:13:2: #error ""
/usr/include/linux/version.h:14:2: #error "To build kernel modules please do 
the following:"
/usr/include/linux/version.h:15:2: #error ""
/usr/include/linux/version.h:16:2: #error " o Have the kernel sources 
installed"
/usr/include/linux/version.h:17:2: #error ""
/usr/include/linux/version.h:18:2: #error " o Make sure that the symbolic 
link"
/usr/include/linux/version.h:19:2: #error "   /lib/modules/`uname -r`/build 
exists and points to"
/usr/include/linux/version.h:20:2: #error "   the matching kernel source 
directory"
/usr/include/linux/version.h:21:2: #error ""
/usr/include/linux/version.h:22:2: #error " o Now copy /boot/vmlinuz.version.h 
to"
/usr/include/linux/version.h:23:2: #error "   /lib/modules/`uname 
-r`/build/include/linux/version.h"
/usr/include/linux/version.h:24:2: #error ""
/usr/include/linux/version.h:25:2: #error " o When compiling, make sure to use 
the following"
/usr/include/linux/version.h:26:2: #error "   compiler option to use the 
correct include files:"
/usr/include/linux/version.h:27:2: #error ""
/usr/include/linux/version.h:28:2: #error "   -I/lib/modules/`uname 
-r`/build/include"
/usr/include/linux/version.h:29:2: #error ""
/usr/include/linux/version.h:30:2: #error "   instead of"
/usr/include/linux/version.h:31:2: #error ""
/usr/include/linux/version.h:32:2: #error "   -I/usr/include/linux"
/usr/include/linux/version.h:33:2: #error ""
/usr/include/linux/version.h:34:2: #error "   Please adjust the Makefile 
accordingly."
/usr/include/linux/version.h:35:2: #error 
"============================"
In file included from kernel/i2c-core.c:36:
/usr/include/linux/version.h:2:2: #error 
"============================"
/usr/include/linux/version.h:3:2: #error "You should not include 
/usr/include/{linux,asm}/ header"
/usr/include/linux/version.h:4:2: #error "files directly for the compilation 
of kernel modules."
/usr/include/linux/version.h:5:2: #error ""
/usr/include/linux/version.h:6:2: #error "glibc now uses kernel header files 
from a well-defined"
/usr/include/linux/version.h:7:2: #error "working kernel version (as 
recommended by Linus Torvalds)"
/usr/include/linux/version.h:8:2: #error "These files are glibc internal and 
may not match the"
/usr/include/linux/version.h:9:2: #error "currently running kernel. They 
should only be"
/usr/include/linux/version.h:10:2: #error "included via other system header 
files - user space"
/usr/include/linux/version.h:11:2: #error "programs should not directly 
include <linux/*.h> or"
/usr/include/linux/version.h:12:2: #error "<asm/*.h> as well."
/usr/include/linux/version.h:13:2: #error ""
/usr/include/linux/version.h:14:2: #error "To build kernel modules please do 
the following:"
/usr/include/linux/version.h:15:2: #error ""
/usr/include/linux/version.h:16:2: #error " o Have the kernel sources 
installed"
/usr/include/linux/version.h:17:2: #error ""
/usr/include/linux/version.h:18:2: #error " o Make sure that the symbolic 
link"
/usr/include/linux/version.h:19:2: #error "   /lib/modules/`uname -r`/build 
exists and points to"
/usr/include/linux/version.h:20:2: #error "   the matching kernel source 
directory"
/usr/include/linux/version.h:21:2: #error ""
/usr/include/linux/version.h:22:2: #error " o Now copy /boot/vmlinuz.version.h 
to"
/usr/include/linux/version.h:23:2: #error "   /lib/modules/`uname 
-r`/build/include/linux/version.h"
/usr/include/linux/version.h:24:2: #error ""
/usr/include/linux/version.h:25:2: #error " o When compiling, make sure to use 
the following"
/usr/include/linux/version.h:26:2: #error "   compiler option to use the 
correct include files:"
/usr/include/linux/version.h:27:2: #error ""
/usr/include/linux/version.h:28:2: #error "   -I/lib/modules/`uname 
-r`/build/include"
/usr/include/linux/version.h:29:2: #error ""
/usr/include/linux/version.h:30:2: #error "   instead of"
/usr/include/linux/version.h:31:2: #error ""
/usr/include/linux/version.h:32:2: #error "   -I/usr/include/linux"
/usr/include/linux/version.h:33:2: #error ""
/usr/include/linux/version.h:34:2: #error "   Please adjust the Makefile 
accordingly."
/usr/include/linux/version.h:35:2: #error 
"============================"
kernel/i2c-core.c: In function `i2c_add_adapter':
kernel/i2c-core.c:149: `MUTEX' undeclared (first use in this function)
kernel/i2c-core.c:149: (Each undeclared identifier is reported only once
kernel/i2c-core.c:149: for each function it appears in.)
kernel/i2c-core.c: In function `i2c_init':
kernel/i2c-core.c:1485: `MUTEX' undeclared (first use in this function)
kernel/i2c-core.c: At top level:
kernel/i2c-core.c:1585: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1585: warning: data definition has no type or storage class
kernel/i2c-core.c:1586: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1586: warning: data definition has no type or storage class
kernel/i2c-core.c:1587: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1587: warning: data definition has no type or storage class
kernel/i2c-core.c:1588: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1588: warning: data definition has no type or storage class
kernel/i2c-core.c:1589: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1589: warning: data definition has no type or storage class
kernel/i2c-core.c:1590: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1590: warning: data definition has no type or storage class
kernel/i2c-core.c:1591: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1591: warning: data definition has no type or storage class
kernel/i2c-core.c:1592: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1592: warning: data definition has no type or storage class
kernel/i2c-core.c:1593: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1593: warning: data definition has no type or storage class
kernel/i2c-core.c:1594: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1594: warning: data definition has no type or storage class
kernel/i2c-core.c:1595: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1595: warning: data definition has no type or storage class
kernel/i2c-core.c:1596: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1596: warning: data definition has no type or storage class
kernel/i2c-core.c:1599: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1599: warning: data definition has no type or storage class
kernel/i2c-core.c:1600: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1600: warning: data definition has no type or storage class
kernel/i2c-core.c:1601: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1601: warning: data definition has no type or storage class
kernel/i2c-core.c:1602: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1602: warning: data definition has no type or storage class
kernel/i2c-core.c:1603: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1603: warning: data definition has no type or storage class
kernel/i2c-core.c:1604: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1604: warning: data definition has no type or storage class
kernel/i2c-core.c:1606: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1606: warning: data definition has no type or storage class
kernel/i2c-core.c:1607: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1607: warning: data definition has no type or storage class
kernel/i2c-core.c:1608: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1608: warning: data definition has no type or storage class
kernel/i2c-core.c:1609: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1609: warning: data definition has no type or storage class
kernel/i2c-core.c:1610: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1610: warning: data definition has no type or storage class
kernel/i2c-core.c:1611: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1611: warning: data definition has no type or storage class
kernel/i2c-core.c:1612: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1612: warning: data definition has no type or storage class
kernel/i2c-core.c:1613: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1613: warning: data definition has no type or storage class
kernel/i2c-core.c:1614: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1614: warning: data definition has no type or storage class
kernel/i2c-core.c:1615: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1615: warning: data definition has no type or storage class
kernel/i2c-core.c:1616: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1616: warning: data definition has no type or storage class
kernel/i2c-core.c:1617: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1617: warning: data definition has no type or storage class
kernel/i2c-core.c:1618: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1618: warning: data definition has no type or storage class
kernel/i2c-core.c:1620: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1620: warning: data definition has no type or storage class
kernel/i2c-core.c:1621: parse error before 
"config_must_be_included_before_module"
kernel/i2c-core.c:1621: warning: data definition has no type or storage class
make: *** [kernel/i2c-core.o] Error 1
[csh@me-bangor2c-186 i2c-2.6.4]$




