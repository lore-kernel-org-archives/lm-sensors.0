From: floeff@arcor.de (Florian Effenberger)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: i2c-ali1535.c:548: warning: initialization from incompatible pointer
Message-Id: <41D6E143.8030204@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello list,

When compiling lm_sensors 2.9.0 with gcc 2.95.4, I receive the following 
error:

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

Have filed this as ticket 1857.

Florian
