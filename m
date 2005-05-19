From: rob.blomquist@verizon.net (Rob Blomquist)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: I2c (cvs upload) compile problem.
Message-Id: <200304092003.10837.rob.blomquist@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I uploaded the freshest i2c and lm_sensors packages by cvs tonight in the 
hopes that my ASUS A7N8X board with its Nivida chips would be detected. I am 
running a fresh build of Mandrake 9.1, with the 2.4.21-0.13mdk kernel 
running.

I get a compile error in "make install" right at the begininning:

[root@timmy2 i2c]# make install
if [ -n " kernel/i2c-core.o kernel/i2c-dev.o kernel/i2c-algo-bit.o 
kernel/i2c-algo-biths.o kernel/i2c-philips-par.o kernel/i2c-elv.o 
kernel/i2c-velleman.o kernel/i2c-algo-pcf.o kernel/i2c-proc.o 
kernel/i2c-pport.o" ] ; then \
  if [ -d "/lib/modules/`grep UTS_RELEASE 
/lib/modules/2.4.21-0.13mdk/build/include/linux/version.h|cut -f 2 
-d'"'`/kernel" ] ; then \
    mkdir -p /lib/modules/`grep UTS_RELEASE 
/lib/modules/2.4.21-0.13mdk/build/include/linux/version.h|cut -f 2 
-d'"'`/kernel/drivers/i2c ; \
    install -o root -g root -m 644  kernel/i2c-core.o kernel/i2c-dev.o 
kernel/i2c-algo-bit.o kernel/i2c-algo-biths.o kernel/i2c-philips-par.o 
kernel/i2c-elv.o kernel/i2c-velleman.o kernel/i2c-algo-pcf.o 
kernel/i2c-proc.o kernel/i2c-pport.o /lib/modules/`grep UTS_RELEASE 
/lib/modules/2.4.21-0.13mdk/build/include/linux/version.h|cut -f 2 
-d'"'`/kernel/drivers/i2c ; \
    for i in  kernel/i2c-core.o kernel/i2c-dev.o kernel/i2c-algo-bit.o 
kernel/i2c-algo-biths.o kernel/i2c-philips-par.o kernel/i2c-elv.o 
kernel/i2c-velleman.o kernel/i2c-algo-pcf.o kernel/i2c-proc.o 
kernel/i2c-pport.o ; do \
      rm -f /lib/modules/`grep UTS_RELEASE 
/lib/modules/2.4.21-0.13mdk/build/include/linux/version.h|cut -f 2 
-d'"'`/misc/`basename $i` ; \
    done \
  else \
    mkdir -p /lib/modules/`grep UTS_RELEASE 
/lib/modules/2.4.21-0.13mdk/build/include/linux/version.h|cut -f 2 
-d'"'`/misc ; \
    install -o root -g root -m 644  kernel/i2c-core.o kernel/i2c-dev.o 
kernel/i2c-algo-bit.o kernel/i2c-algo-biths.o kernel/i2c-philips-par.o 
kernel/i2c-elv.o kernel/i2c-velleman.o kernel/i2c-algo-pcf.o 
kernel/i2c-proc.o kernel/i2c-pport.o /lib/modules/`grep UTS_RELEASE 
/lib/modules/2.4.21-0.13mdk/build/include/linux/version.h|cut -f 2 
-d'"'`/misc ; \
  fi \
fi
install: `/lib/modules/2.4.21-0.13mdksmp' is a directory
install: `2.4.21-0.13mdkenterprise' is a directory
install: `2.4.21-0.13mdk' is a directory
make: *** [install-kernel] Error 1

Can you guys help me out with this one? Yes, 2.4.21-0.13mdksmp is a directory 
as is 2.4.21-0.13mdk, 2.4.21-0.13mdkenterprise sounds fair, but not on my 
system.

Rob
-- 

Kirkland, Washington
