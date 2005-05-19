From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: i2c-ali1535.c:548: warning: initialization from incompatible
Message-Id: <20050102111233.19192f6d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D6E143.8030204@arcor.de>
In-Reply-To: <41D6E143.8030204@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > If you did, please try to manually copy kernel/i2c.h from i2c 2.9.0
> > to /usr/local/include and see if it helps.
> 
> myhost:~/i2c-2.9.0# cp kernel/i2c.h /usr/local/include/
> myhost:~# cd ../lm_sensors-2.9.0/
> myhost:~/lm_sensors-2.9.0# make all
> gcc  -DMODVERSIONS -include 
> /root/linux-2.4.28/include/linux/modversions.h -D__KERNEL__ -DMODULE 
> -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include 
> -I/usr/local/include  -I/root/linux-2.4.28/include -nostdinc -I 
> /usr/lib/gcc-lib/i386-linux/2.95.4/include  -Wall -O2  -c 
> kernel/busses/i2c-ali1535.c -o kernel/busses/i2c-ali1535.o
> kernel/busses/i2c-ali1535.c:547: unknown field `inc_use' specified in 
> initializer
> kernel/busses/i2c-ali1535.c:548: unknown field `dec_use' specified in 
> initializer
> kernel/busses/i2c-ali1535.c:548: warning: initialization from 
> incompatible pointer type
> make: *** [kernel/busses/i2c-ali1535.o] Fehler 1
> 
> Doesn't work. :-(

Oops, my bad. You'd have to copy the file to /usr/local/include/linux,
not /usr/local/include (please delete the one you copied there). While
you're at it, you could copy kernel/i2c-algo-bit.h too, since some bus
drivers in lm_sensors need it.

-- 
Jean Delvare
http://khali.linux-fr.org/
