From: bertrik@zonnet.nl (Bertrik Sikken)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Compilation problems with current CVS version
Message-Id: <3DA5C130.7010308@zonnet.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

For some time now I've been unable to compile lmsensors from CVS.
I get an error in adm1021.c, forcing me to disable it in
Modules.mk in order to compile and install the other modules.

Attached is the output of make.

Kind regards,
Bertrik Sikken

-------------- next part --------------
[root@kf-gd-tg01-149 lm_sensors2]# make
gcc  -DMODVERSIONS -include /lib/modules/2.4.20-pre10/build/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.20-pre10/build/include   -O2   -c kernel/chips/adm1021.c -o kernel/chips/adm1021.o
cc1: warning: changing search order for system directory "/usr/local/include"
cc1: warning:   as it has already been specified as a non-system directory
kernel/chips/adm1021.c:52: warning: parameter names (without types) in function declaration
kernel/chips/adm1021.c:52: warning: data definition has no type or storage class
kernel/chips/adm1021.c:110: field `type' has incomplete type
kernel/chips/adm1021.c: In function `adm1021_attach_adapter':
kernel/chips/adm1021.c:211: `addr_data' undeclared (first use in this function)
kernel/chips/adm1021.c:211: (Each undeclared identifier is reported only once
kernel/chips/adm1021.c:211: for each function it appears in.)
kernel/chips/adm1021.c: In function `adm1021_detect':
kernel/chips/adm1021.c:270: `adm1023' undeclared (first use in this function)
kernel/chips/adm1021.c:272: `adm1021' undeclared (first use in this function)
kernel/chips/adm1021.c:274: `thmc10' undeclared (first use in this function)
kernel/chips/adm1021.c:276: `gl523sm' undeclared (first use in this function)
kernel/chips/adm1021.c:280: `max1617a' undeclared (first use in this function)
kernel/chips/adm1021.c:285: `lm84' undeclared (first use in this function)
kernel/chips/adm1021.c:287: `mc1066' undeclared (first use in this function)
kernel/chips/adm1021.c:289: `max1617' undeclared (first use in this function)
kernel/chips/adm1021.c: In function `adm1021_update_client':
kernel/chips/adm1021.c:463: `adm1021' undeclared (first use in this function)
kernel/chips/adm1021.c:467: `adm1023' undeclared (first use in this function)
kernel/chips/adm1021.c: In function `adm1021_remote_temp':
kernel/chips/adm1021.c:519: `adm1023' undeclared (first use in this function)
make: *** [kernel/chips/adm1021.o] Error 1
[root@kf-gd-tg01-149 lm_sensors2]#
