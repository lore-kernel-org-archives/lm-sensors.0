From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: experience with the 2.4.26
Message-Id: <1082021680.407e573036d38@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF042BDD97.61ACBC24-ONC1256E77.0031DAA1-C1256E77.00323804@kaufland.de>
In-Reply-To: <OF042BDD97.61ACBC24-ONC1256E77.0031DAA1-C1256E77.00323804@kaufland.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me]

> Hi all,
> 
> Have you any experience the the 2.4.26 kernel?
> I'd tried to installed the lm_sensors-2.8.6 but i got the follow
> compiler erros message:
> 
> gcc  -D__SMP__ -DMODVERSIONS -include /lib/modules/2.4.26
> /build/include/linux/modversions.h -D__KERNEL__ -DMODULE
> -DEXPORT_SYMTAB
> -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include
> -I/lib/modules/2.4.26/build/include -nostdinc -I
> /usr/lib/gcc-lib/i386-linux/2.95.4/include  -Wall -O2  -c
> kernel/busses/i2c-nforce2.c -o kernel/busses/i2c-nforce2.o
> kernel/busses/i2c-nforce2.c: In function `nforce2_access':
> kernel/busses/i2c-nforce2.c:140: `I2C_CLIENT_PEC' undeclared (first
> use in this function)
> (...)
> Is the kernel the cause?

Yes, but you would have the same problem with 2.4.25. The problem is
that lm_sensors 2.8.6 needs i2c 2.8.1, while 2.4 kernels have i2c 2.6.1
or the like.

You need to patch your kernel with this:
http://delvare.nerim.net/i2c/
if you want lm_sensors 2.8.x to work on a 2.4 kernel.

There is no patch for 2.4.26 yet, let's just hope that the patch for
2.4.25 will work.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
