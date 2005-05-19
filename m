From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: i2c-2.7.0 won't comile
Message-Id: <20030508045446.GD23199@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EB966D2.5090506@mechanized-mind.net>
In-Reply-To: <3EB966D2.5090506@mechanized-mind.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Philip Pokorny <ppokorny@penguincomputing.com> [2003-05-07 19:40:31 -0700]:

> Red hat pre-generates all the modversion madness for all the kernels and 
> includes them in the kernel source tree.  Further, the versions.h that 
> is in place looks at something like this:
> 
> #include <linux/rhconfig.h>
> #if defined(__module__smp)
> #define UTS_RELEASE "2.4.18-10smp"
> #elif defined(__module__BOOT)
> #define UTS_RELEASE "2.4.18-10BOOT"
> #elif defined(__module__bigmem)
> #define UTS_RELEASE "2.4.18-10bigmem"
> #elif defined(__module__debug)
> #define UTS_RELEASE "2.4.18-10debug"
> #else
> #define UTS_RELEASE "2.4.18-10"
> #endif
> #define LINUX_VERSION_CODE 132114
> #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
> 
> Normally there would only be one UTS_RELEASE entry here.  This alone 
> gives many makefiles fits.

Ours, e.g. :)  Once upon a time I suggested a way for us to deal with
that but the suggestion was ignored... ah yes here it is:

http://archives.andrew.net.au/lm-sensors/msg01854.html

> Notice the include of rhconfig.h.  That file includes /boot/kernel.h 
> which is created each time a Red Hat kernel boots.  /boot/kernel.h tells 
>  rhconfig.h what the active kernel is (smp, up, bigmem, 586, 686, etc.) 
> which then tells (via __module__xxxx) version.h, modversions.h and 
> modules/foo.ver which #defines to make active.
> 
> When you 'make clean' or make 'dep' you delete this version madness and 
> it all breaks down until you actually build a kernel in that tree.  But 
> then the files are setup ONLY for that single kernel.

Great explanation - thanks.

> I also find that if I create a soft link in the i2c tree:
> 
>     ln -s kernel linux
> 
> Then I can build lm_sensors without installing i2c.  Just compile i2c as 
> above, then in lm_sensors:
> 
>     make I2C_HEADERS=<path to i2c>
> 
> Then I can insmod the .o files directly from the i2c and lm_sensors 
> build areas for testing without clobbering the kernel files.

That is slick - thanks again!

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
