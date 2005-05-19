From: radian@cox.net (Adrian Mariano)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: lm_sensors compiled problem
Message-Id: <200407051307.JAA22078@vizcacha.cox.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407010220.WAA29129@vizcacha.cox.net>
In-Reply-To: <200407010220.WAA29129@vizcacha.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Jul 4, 17:34, Jean Delvare <khali@linux-fr.org> wrote:
> > I'm trying to compile lm_sensors 2.8.7.  I compiled and installed
> > i2c-2.8.7, and I am compiling against the kernel source for the
> > running kernel and the source tree is the one used to compile the
> > current kernel.  However, it is a SuSE kernel, version 2.4.16, not one
> > of the pristine kernels from kernel.org.
> > 
> > I poked around briefly in the code to try to understand what is going
> > on, but basically I found that I was as confused as the compiler by
> > the code.  My compiler is gcc 2.95.3.
> > 
> > adrian> make
> > gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I.
> > -Ikernel/include -I/usr/local/include 
> > -I/lib/modules/2.4.16/build/include -nostdinc -I
> > /usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include  -Wall -O2  -c
> > kernel/busses/i2c-ali1535.c -o kernel/busses/i2c-ali1535.o
> > kernel/busses/i2c-ali1535.c:571: warning: implicit declaration of
> > function `__devexit_p' kernel/busses/i2c-ali1535.c:571: initializer
> > element is not constant kernel/busses/i2c-ali1535.c:571: (near
> > initialization for `ali1535_driver.remove')
> > kernel/busses/i2c-ali1535.c:572: initializer element is not constant
> > kernel/busses/i2c-ali1535.c:572: (near initialization for
> > `ali1535_driver') make: *** [kernel/busses/i2c-ali1535.o] Error 1
> 
> Yeah, known problem. We pretend to support kernels starting from 2.4.9
> but there are several changes that broke compatibility after lm_sensors
> 2.7.0 and you actually need a kernel >= 2.4.17. Feel free to submit
> fixes if you know what to do. Or you have two choices:
> 1* Upgrade kernel to 2.4.17.
> 2* Downgrade lm_sensors to 2.7.0.

I get a similar problem when I downgrade lm_sensors to 2.7.0.  I tried
using my existing i2c 2.8.7, and I also tried dropping back to i2c
2.7.0.  Using the approved combination of lm_sensors 2.70 with i2c
2.7.0 I got this:

gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.16/build/include   -O2   -c kernel/busses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
kernel/busses/i2c-amd8111.c:500: initializer element is not constant
kernel/busses/i2c-amd8111.c:500: (near initialization for `amd8111_driver.remove')
kernel/busses/i2c-amd8111.c:501: initializer element is not constant
kernel/busses/i2c-amd8111.c:501: (near initialization for `amd8111_driver')
make: *** [kernel/busses/i2c-amd8111.o] Error 1

I'm afraid that I don't know how to write the fixes, so I guess that
leaves upgrading the kernel as the sole option.  (I'm planning to move
to a 2.6 kernel.)

