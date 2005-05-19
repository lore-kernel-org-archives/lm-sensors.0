From: Genesis1976@gmx.de (Genesis1976@gmx.de)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: Ticket #: 1234
Message-Id: <3EDC9251.71FD0676@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

here is the output of the make install command.

Regards
M.Newiger
-------------- next part --------------
grep: /lib/modules/2.4.18-14smp/build/.config: No such file or directory
grep: /lib/modules/2.4.18-14smp/build/.config: No such file or directory
grep: /lib/modules/2.4.18-14smp/build/.config: No such file or directory
grep: /lib/modules/2.4.18-14smp/build/.config: No such file or directory
grep: /lib/modules/2.4.18-14smp/build/.config: No such file or directory
grep: /lib/modules/2.4.18-14smp/build/.config: No such file or directory
grep: /lib/modules/2.4.18-14smp/build/.config: No such file or directory
grep: /lib/modules/2.4.18-14smp/build/.config: No such file or directory
grep: /lib/modules/2.4.18-14smp/build/.config: No such file or directory
grep: /lib/modules/2.4.18-14smp/build/.config: No such file or directory
grep: /lib/modules/2.4.18-14smp/build/.config: No such file or directory
if [ -n " kernel/i2c-core.o kernel/i2c-dev.o kernel/i2c-algo-bit.o kernel/i2c-elv.o kernel/i2c-velleman.o kernel/i2c-algo-pcf.o kernel/i2c-elektor.o kernel/i2c-proc.o kernel/i2c-pport.o kernel/i2c-pcf-epp.o" ] ; then \
  if [ -d "/lib/modules/`grep UTS_RELEASE /lib/modules/2.4.18-14smp/build/include/linux/version.h|cut -f 2 -d'"'`/kernel" ] ; then \
    mkdir -p /lib/modules/`grep UTS_RELEASE /lib/modules/2.4.18-14smp/build/include/linux/version.h|cut -f 2 -d'"'`/kernel/drivers/i2c ; \
    install -o root -g root -m 644  kernel/i2c-core.o kernel/i2c-dev.o kernel/i2c-algo-bit.o kernel/i2c-elv.o kernel/i2c-velleman.o kernel/i2c-algo-pcf.o kernel/i2c-elektor.o kernel/i2c-proc.o kernel/i2c-pport.o kernel/i2c-pcf-epp.o /lib/modules/`grep UTS_RELEASE /lib/modules/2.4.18-14smp/build/include/linux/version.h|cut -f 2 -d'"'`/kernel/drivers/i2c ; \
    for i in  kernel/i2c-core.o kernel/i2c-dev.o kernel/i2c-algo-bit.o kernel/i2c-elv.o kernel/i2c-velleman.o kernel/i2c-algo-pcf.o kernel/i2c-elektor.o kernel/i2c-proc.o kernel/i2c-pport.o kernel/i2c-pcf-epp.o ; do \
      rm -f /lib/modules/`grep UTS_RELEASE /lib/modules/2.4.18-14smp/build/include/linux/version.h|cut -f 2 -d'"'`/misc/`basename $i` ; \
    done \
  else \
    mkdir -p /lib/modules/`grep UTS_RELEASE /lib/modules/2.4.18-14smp/build/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
    install -o root -g root -m 644  kernel/i2c-core.o kernel/i2c-dev.o kernel/i2c-algo-bit.o kernel/i2c-elv.o kernel/i2c-velleman.o kernel/i2c-algo-pcf.o kernel/i2c-elektor.o kernel/i2c-proc.o kernel/i2c-pport.o kernel/i2c-pcf-epp.o /lib/modules/`grep UTS_RELEASE /lib/modules/2.4.18-14smp/build/include/linux/version.h|cut -f 2 -d'"'`/misc ; \
  fi \
fi
install: `/lib/modules/2.4.18-14smp' is a directory
install: `2.4.18-14BOOT' is a directory
install: `2.4.18-14bigmem' is a directory
install: `2.4.18-14debug' is a directory
make: *** [install-kernel] Error 1
