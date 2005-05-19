From: ni_kanda@yahoo.com (Kanda Nikornpongsin)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: problem installing i2c and sensors, please help!!
Message-Id: <20030308025008.47671.qmail@web14904.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi lm_sensor team,

I followed the instruction and read FAQ over and over
again. However I am still not able to successfully
compile i2c-2.7.0

General info
it's intel an mother board 810E chipset running RH8.0

I downloaded i2c-2.7.0.tar.gz. 
run "make all" (with no complaint)
however when run "make install"

I got the following message:

grep: /lib/modules/2.4.18-14/build/.config: No such
file or directory
grep: /lib/modules/2.4.18-14/build/.config: No such
file or directory
grep: /lib/modules/2.4.18-14/build/.config: No such
file or directory
grep: /lib/modules/2.4.18-14/build/.config: No such
file or directory
grep: /lib/modules/2.4.18-14/build/.config: No such
file or directory
grep: /lib/modules/2.4.18-14/build/.config: No such
file or directory
grep: /lib/modules/2.4.18-14/build/.config: No such
file or directory
grep: /lib/modules/2.4.18-14/build/.config: No such
file or directory
grep: /lib/modules/2.4.18-14/build/.config: No such
file or directory
grep: /lib/modules/2.4.18-14/build/.config: No such
file or directory
grep: /lib/modules/2.4.18-14/build/.config: No such
file or directory
if [ -n " kernel/i2c-core.o kernel/i2c-dev.o
kernel/i2c-algo-bit.o kernel/i2c-elv.o
kernel/i2c-velleman.o kernel/i2c-algo-pcf.o
kernel/i2c-elektor.o kernel/i2c-proc.o
kernel/i2c-pport.o kernel/i2c-pcf-epp.o" ] ; then \
  if [ -d "/lib/modules/`grep UTS_RELEASE
/lib/modules/2.4.18-14/build/include/linux/version.h|cut
-f 2 -d'"'`/kernel" ] ; then \
    mkdir -p /lib/modules/`grep UTS_RELEASE
/lib/modules/2.4.18-14/build/include/linux/version.h|cut
-f 2 -d'"'`/kernel/drivers/i2c ; \
    install -o root -g root -m 644  kernel/i2c-core.o
kernel/i2c-dev.o kernel/i2c-algo-bit.o
kernel/i2c-elv.o kernel/i2c-velleman.o
kernel/i2c-algo-pcf.o kernel/i2c-elektor.o
kernel/i2c-proc.o kernel/i2c-pport.o
kernel/i2c-pcf-epp.o /lib/modules/`grep UTS_RELEASE
/lib/modules/2.4.18-14/build/include/linux/version.h|cut
-f 2 -d'"'`/kernel/drivers/i2c ; \
    for i in  kernel/i2c-core.o kernel/i2c-dev.o
kernel/i2c-algo-bit.o kernel/i2c-elv.o
kernel/i2c-velleman.o kernel/i2c-algo-pcf.o
kernel/i2c-elektor.o kernel/i2c-proc.o
kernel/i2c-pport.o kernel/i2c-pcf-epp.o ; do \
      rm -f /lib/modules/`grep UTS_RELEASE
/lib/modules/2.4.18-14/build/include/linux/version.h|cut
-f 2 -d'"'`/misc/`basename $i` ; \
    done \
  else \
    mkdir -p /lib/modules/`grep UTS_RELEASE
/lib/modules/2.4.18-14/build/include/linux/version.h|cut
-f 2 -d'"'`/misc ; \
    install -o root -g root -m 644  kernel/i2c-core.o
kernel/i2c-dev.o kernel/i2c-algo-bit.o
kernel/i2c-elv.o kernel/i2c-velleman.o
kernel/i2c-algo-pcf.o kernel/i2c-elektor.o
kernel/i2c-proc.o kernel/i2c-pport.o
kernel/i2c-pcf-epp.o /lib/modules/`grep UTS_RELEASE
/lib/modules/2.4.18-14/build/include/linux/version.h|cut
-f 2 -d'"'`/misc ; \
  fi \
fi
install: `/lib/modules/2.4.18-14smp' is a directory
install: `2.4.18-14BOOT' is a directory
install: `2.4.18-14bigmem' is a directory
install: `2.4.18-14debug' is a directory
make: *** [install-kernel] Error 1

I double check path for i2c headers. they are in
/lib/modules/2.4.18-14/build/include

I also noticed that after "ran make all" it created 4
directories below
2.4.18-14 (contains misc)
2.4.18-14bigmem (empty folder)
2.4.18-14BOOT (empty folder)
2.4.18-14debug (empty folder)

I am not sure what I am missing. Without i2c I cannot
really compile lm_sensors successfully please help (it
complained that I need i2c-2.7.0 or greater)

please help, thanks so much in advance!!!

-kanda



__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/
