From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: i2c-2.7.0 won't comile
Message-Id: <3EB9C39F.4050903@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EB966D2.5090506@mechanized-mind.net>
In-Reply-To: <3EB966D2.5090506@mechanized-mind.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> * Gustave Nylander <gustave@mechanized-mind.net> [2003-05-07 16:04:34 -0400]:
> 
>>I'm stuck at pretty much the first step, tyring to do a 'make' on the 
>>i2c package. It looks like i2c is not integrated into my kernel, and not 
>>loading as a module already, so I don't know what the problem is. I've 
>>included some details:
>>
>>OS: Red Hat 9.0
>>Kernel: 2.4.20-9
>>Motherboard: MSI KT3 Ultra2 (MS-6380E)
>>Chipset: VIA VT8235 Chipset
>>Sensors: Winbond W83697HF
> 
> 
> Here is what I did, step by step, to compile sensors 2.7.0 vs. RH 9.
> 
> 1) Install the appropriate kernel-source RPM.  Copy the config file
> that matches your kernel into its proper place, something like this:
> 
> $ cp /usr/src/linux-2.4.20-9/configs/kernel-2.4.20-i686.config \
>      /usr/src/linux-2.4.20-9/.config
> 
> 2) Do *not* do anything else in that tree.  Don't "make clean", don't
> "make dep", nothing.  Somehow, that screws it all up.  Sorry I haven't
> looked into it more than that.  Uninstall & reinstall the RPM if you
> must.

Red hat pre-generates all the modversion madness for all the kernels and 
includes them in the kernel source tree.  Further, the versions.h that 
is in place looks at something like this:

#include <linux/rhconfig.h>
#if defined(__module__smp)
#define UTS_RELEASE "2.4.18-10smp"
#elif defined(__module__BOOT)
#define UTS_RELEASE "2.4.18-10BOOT"
#elif defined(__module__bigmem)
#define UTS_RELEASE "2.4.18-10bigmem"
#elif defined(__module__debug)
#define UTS_RELEASE "2.4.18-10debug"
#else
#define UTS_RELEASE "2.4.18-10"
#endif
#define LINUX_VERSION_CODE 132114
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

Normally there would only be one UTS_RELEASE entry here.  This alone 
gives many makefiles fits.

Notice the include of rhconfig.h.  That file includes /boot/kernel.h 
which is created each time a Red Hat kernel boots.  /boot/kernel.h tells 
  rhconfig.h what the active kernel is (smp, up, bigmem, 586, 686, etc.) 
which then tells (via __module__xxxx) version.h, modversions.h and 
modules/foo.ver which #defines to make active.

When you 'make clean' or make 'dep' you delete this version madness and 
it all breaks down until you actually build a kernel in that tree.  But 
then the files are setup ONLY for that single kernel.

> NOTE: from here on, I assume you're already running the kernel that
> matches the config above.  That does make it easier.
> 
> 3) In the I2C makefile uncomment these lines (if you do have SMP,
> you can figure out what to do):
> 
> SMP := 0
> 
> MODVER := 1
> 
> MODPREF := /lib/modules/$(KERNELVERSION)

Thanks to the use of := in the makefile, you can specify these on the 
command line instead of editing the makefile if you want...

   make SMP=0 MODVER=1 MODPREF=/lib/modules/$(uname -r)

> 4) Now build & install I2C.
> 
> NOTE: If you're using the same tree which failed to build earlier,
> please do a "make clean" first.

    make SMP=0 MODVER=1 MODPREF=/lib/modules/$(uname -r) install

> 5) Now lm_sensors2 is almost the same procedure except the makefile
> needs a very minor patch (in addition to the uncommenting)...
> 
> Index: Makefile
> =================================> RCS file: /home/cvs/lm_sensors2/Makefile,v
> retrieving revision 1.60
> diff -r1.60 Makefile
> 181c181
> < ALL_CPPFLAGS := -I. -Ikernel/include -I$(I2C_HEADERS) -I$(LINUX_HEADERS)
> ---
> 
>>ALL_CPPFLAGS := -I. -Ikernel/include -isystem $(I2C_HEADERS) -isystem $(LINUX_HEADERS)
> 
> 
> If you're interested in the details of why this is needed, look here:
> 
> http://archives.andrew.net.au/lm-sensors/msg02538.html
> 
> After you apply this patch, the rest follows the readme.  Let me know
> if that doesn't work.

I also find that if I create a soft link in the i2c tree:

     ln -s kernel linux

Then I can build lm_sensors without installing i2c.  Just compile i2c as 
above, then in lm_sensors:

     make I2C_HEADERS=<path to i2c>

Then I can insmod the .o files directly from the i2c and lm_sensors 
build areas for testing without clobbering the kernel files.

:v)

-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
