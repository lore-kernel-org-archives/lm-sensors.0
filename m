From: palsedgj@colorado.net (John Palsedge)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: make install problem with i2c package
Message-Id: <4054812F.50803@colorado.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

System: Red Hat 7.2,  2.4.7-10 kernel
download: i2c-2.7.0.tar.gz

Makefile: default (include files -> /usr/local/include)

compile seemed to go OK.

make install (ran as root) failed with messages:

grep: /lib/modules/2.4.7-10/build/.config: No such file or directory     
     (true)
Note: /lib/modules/2.4.7-10/build ->  ../../../usr/src/linux-2.4.7-10/, 
contents of which are

abi/      CREDITS         include/  lib/         net/            scripts/
arch/     Documentation/  init/     MAINTAINERS  README
configs/  drivers/        ipc/      Makefile     REPORTING-BUGS
COPYING   fs/             kernel/   mm/          Rules.make

contents of configs is

kernel-2.4.7-athlon.config      kernel-2.4.7-i586-smp.config
kernel-2.4.7-athlon-smp.config  kernel-2.4.7-i686.config
kernel-2.4.7-i386-BOOT.config   kernel-2.4.7-i686-debug.config
kernel-2.4.7-i386.config        kernel-2.4.7-i686-enterprise.config
kernel-2.4.7-i386-smp.con

other messages from install:

install: `/lib/modules/2.4.7-10smp' is a directory
install: `2.4.7-10BOOT' is a directory
install: `2.4.7-10enterprise' is a directory
install: `2.4.7-10debug' is a directory
make: *** [install-kernel] Error 1

No include files were installed in /usr/local/include.  I did not have 
this directory, so I created it (as root) and tried again: same result.  

"Error 1" doesn't tell me much.  Unfortunately I can't find my O'Reilly 
Make book.  

I ran rpm -qa | grep i2c and got nothing.

Any ideas?

John Palsedge - SIlverthorne, Colorado

