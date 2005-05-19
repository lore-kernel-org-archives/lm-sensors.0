From: floeff@arcor.de (Florian Effenberger)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: i2c-ali1535.c:548: warning: initialization from incompatible
Message-Id: <41D7BF57.7020409@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D6E143.8030204@arcor.de>
In-Reply-To: <41D6E143.8030204@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

> Did you install i2c 2.9.0? lm_sensors 2.9.0 needs it.

I did and the install went smooth.

> If you did, please try to manually copy kernel/i2c.h from i2c 2.9.0 to
> /usr/local/include and see if it helps.

myhost:~/i2c-2.9.0# cp kernel/i2c.h /usr/local/include/
myhost:~# cd ../lm_sensors-2.9.0/
myhost:~/lm_sensors-2.9.0# make all
gcc  -DMODVERSIONS -include 
/root/linux-2.4.28/include/linux/modversions.h -D__KERNEL__ -DMODULE 
-DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include 
-I/usr/local/include  -I/root/linux-2.4.28/include -nostdinc -I 
/usr/lib/gcc-lib/i386-linux/2.95.4/include  -Wall -O2  -c 
kernel/busses/i2c-ali1535.c -o kernel/busses/i2c-ali1535.o
kernel/busses/i2c-ali1535.c:547: unknown field `inc_use' specified in 
initializer
kernel/busses/i2c-ali1535.c:548: unknown field `dec_use' specified in 
initializer
kernel/busses/i2c-ali1535.c:548: warning: initialization from 
incompatible pointer type
make: *** [kernel/busses/i2c-ali1535.o] Fehler 1

Doesn't work. :-(

Florian
