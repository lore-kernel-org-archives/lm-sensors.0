From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: 2.7.0 testings
Message-Id: <3DE651B2.601577C4@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021127213903.5b84866d.khali@linux-fr.org>
In-Reply-To: <20021127213903.5b84866d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I like your suggestion for fixing LINUX :If you fix that I'll fix pport.

The build symlink comes from the top level kernel Makefile,
from 'make modules_install'.

Jean Delvare wrote:
> 
> > I'll test with a 2.2 series kernel on another machine early tomorrow.
> 
> We have a problem. 2.2 kernels may not have a
> /lib/modules/$VERSION/build symlink. I don't know what's responsible for
> creating it. Curiously, when I tried on my laptop with a 2.2.22 kernel,
> the symlink was created. But on my old desktop system, kernels 2.2.14,
> 2.2.16 and 2.2.20 don't have one.
> 
> So we can't keep the things as they are. I suggest to use the following:
> 
> LINUX := $(shell if [ -L /lib/modules/$(KERNELVERSION)/build ] ; then
> echo "/lib/modules/$(KERNELVERSION)/build" ; else echo "/usr/src/linux"
> ; fi)
> 
> Someone's got a better idea?
> 
> Another problem:
> 
> /usr/src/i2c> make
> gcc -I/usr/src/linux/include -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE
> -fomit-frame-pointer -DEXPORT_SYMTAB -DMODVERSIONS -include
> /usr/src/linux/include/linux/modversions.h -c kernel/i2c-pport.c -o
> kernel/i2c-pport.o
> kernel/i2c-pport.c: In function `bit_pport_init':
> kernel/i2c-pport.c:115: wrong type argument to unary exclamation mark
> make: *** [kernel/i2c-pport.o] Error 1
> /usr/src/i2c>
> 
> This is a 2.2.20 kernel. The code is:
> 
>     112
>     113 static int bit_pport_init(void)
>     114 {
>     115     if (!request_region((base+2),1, "i2c (PPORT adapter)")) {
>     116         return -ENODEV;
>     117     } else {
>     118
> 
> >From /usr/src/linux-2.2.20:
> kernel/resource.c:void request_region(unsigned long from, unsigned long
> num, const char *name)
> So actually you are not supposed to check a returned value. Who can fix
> this?
> 
> I also get this warning for many files:
> /usr/src/linux-2.2.20/include/linux/module.h:13: warning: `_set_ver'
> redefined
> /usr/src/linux-2.2.20/include/linux/modsetver.h:9: warning: this is the
> location of the previous definition
> But I guess this is a kernel-side problem, right? Gonna try on a 2.2.22
> to see if it has been fixed.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
