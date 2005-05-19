From: rloos@baer-gmbh.com (Robert Loos)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: Ticket 1083 Error-msgs
Message-Id: <01C2A4F8.BC69F320.rloos@baer-gmbh.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Team,

in fact, I did not make -f Makefile.p4b but only make in the root of your 
package. But if I change to proc/hotplug, where the Makefile.p4b resides 
and execute, I get the following Errors:


LX1:/home/supervisor/linux_packete/lm_sensors-2.7.0/lm_sensors-2.7.0/pro  
g/hotplug # make -f Makefile.p4b
grep: /lib/modules/2.4.19-4GB/build/Makefile: No such file or directory
grep: /lib/modules/2.4.19-4GB/build/include/linux/autoconf.h: No such file 
or directory
cc  -D__KERNEL__ -DMODULE -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing 
-I/lib/modules/2.4.19-4GB/build/include   -c -o p4b_smbus.o p4b_smbus.c
p4b_smbus.c:60:2: #error ERROR - You must have 'Support for hot-pluggable 
devices' enabled in your kernel (under 'general setup')!!
In file included from /usr/include/linux/module.h:297,
                 from p4b_smbus.c:63:
/usr/include/linux/version.h:2:2: #error 
"============================"
/usr/include/linux/version.h:3:2: #error "You should not include 
/usr/include/{linux,asm}/ header"
/usr/include/linux/version.h:4:2: #error "files directly for the 
compilation of kernel modules."
/usr/include/linux/version.h:5:2: #error ""
/usr/include/linux/version.h:6:2: #error "glibc now uses kernel header 
files from a well-defined"
/usr/include/linux/version.h:7:2: #error "working kernel version (as 
recommended by Linus Torvalds)"
/usr/include/linux/version.h:8:2: #error "These files are glibc internal 
and may not match the"
/usr/include/linux/version.h:9:2: #error "currently running kernel. They 
should only be"
/usr/include/linux/version.h:10:2: #error "included via other system header 
files - user space"
/usr/include/linux/version.h:11:2: #error "programs should not directly 
include <linux/*.h> or"
/usr/include/linux/version.h:12:2: #error "<asm/*.h> as well."
/usr/include/linux/version.h:13:2: #error ""
/usr/include/linux/version.h:14:2: #error "To build kernel modules please 
do the following:"
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
/usr/include/linux/version.h:22:2: #error " o Now copy 
/boot/vmlinuz.version.h to"
/usr/include/linux/version.h:23:2: #error "   /lib/modules/`uname 
-r`/build/include/linux/version.h"
/usr/include/linux/version.h:24:2: #error ""
/usr/include/linux/version.h:25:2: #error " o When compiling, make sure to 
use the following"
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
In file included from p4b_smbus.c:63:
/usr/include/linux/module.h:299: parse error before "UTS_RELEASE"
In file included from /usr/include/asm/hardirq.h:6,
                 from /usr/include/linux/interrupt.h:45,
                 from p4b_smbus.c:70:
/usr/include/linux/irq.h:65: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here 
(not in a function)
/usr/include/linux/irq.h:65: requested alignment is not a constant
In file included from /usr/include/linux/interrupt.h:45,
                 from p4b_smbus.c:70:
/usr/include/asm/hardirq.h:16: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here 
(not in a function)
/usr/include/asm/hardirq.h:16: requested alignment is not a constant
In file included from p4b_smbus.c:70:
/usr/include/linux/interrupt.h:128: `CONFIG_X86_L1_CACHE_SHIFT' undeclared 
here (not in a function)
/usr/include/linux/interrupt.h:128: requested alignment is not a constant
p4b_smbus.c: In function `i801smbus_build':
p4b_smbus.c:176: warning: implicit declaration of function 
`pci_setup_device'
p4b_smbus.c: In function `init_module':
p4b_smbus.c:254: warning: implicit declaration of function 
`pci_insert_device'
p4b_smbus.c: In function `cleanup_module':
p4b_smbus.c:265: warning: implicit declaration of function 
`pci_remove_device'
make: *** [p4b_smbus.o] Error 1


Sincerely,

Robert Loos

P.S. I have the Linux kernel sources installed in /usr/src/linux

--
B?r Industrie-Elektronik GmbH
Robert Loos
Lange Str. 87
90762 F?rth
Tel. 0911 97059-15
Fax +49 911 9705950
http://www.baer-gmbh.com

