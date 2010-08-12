From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Aug 2010 07:14:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pc87360) Fix device resource
Message-Id: <20100812091447.04d5408c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100707145841.58052281@hyperion.delvare>
In-Reply-To: <20100707145841.58052281@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Wed, 11 Aug 2010 15:15:31 -0600, Jim Cromie wrote:
> On Wed, Aug 11, 2010 at 6:59 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > > In the meantime, it looks like res_count isnt initialized before 1st use.
> > > (...)
> > > Oddly, gcc doesnt complain about this,
> > > is this somehow hidden by zeroed memory due to __init on the function ??
> >
> > This is indeed a bug, thanks a lot for finding and reporting it. It's
> > fixed now.
>
> WRT lack of uninit-var warning,
> 
> [jimc@harpo sk1]$ make V=1 drivers/hwmon/pc87360.ko
> ...
>   gcc -Wp,-MD,drivers/hwmon/.pc87360.o.d  -nostdinc -isystem
> /usr/lib/gcc/i686-redhat-linux/4.4.4/include
> -I/home/jimc/lx/linux-2.6.git/arch/x86/include -Iinclude
>  -I/home/jimc/lx/linux-2.6.git/include -include include/generated/autoconf.h
>  -I/home/jimc/lx/linux-2.6.git/drivers/hwmon -Idrivers/hwmon -D__KERNEL__
> -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
> -fno-common -Werror-implicit-function-declaration -Wno-format-security
> -fno-delete-null-pointer-checks -Os -m32 -msoft-float -mregparm=3
> -freg-struct-return -mpreferred-stack-boundary=2 -march=pentium-mmx
> -mtune=generic -Wa,-mtune=generic32 -ffreestanding -DCONFIG_AS_CFI=1
> -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -pipe
> -Wno-sign-compare -fno-asynchronous-unwind-tables -mno-sse -mno-mmx
> -mno-sse2 -mno-3dnow -Wframe-larger-than24 -fno-stack-protector
> -fno-omit-frame-pointer -fno-optimize-sibling-calls
> -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow
> -fconserve-stack  -DMODULE -D"KBUILD_STR(s)=#s"
> -D"KBUILD_BASENAME=KBUILD_STR(pc87360)"
>  -D"KBUILD_MODNAME=KBUILD_STR(pc87360)"  -c -o drivers/hwmon/pc87360.o
> /home/jimc/lx/linux-2.6.git/drivers/hwmon/pc87360.c
> make -f /home/jimc/lx/linux-2.6.git/scripts/Makefile.modpost
>   scripts/mod/modpost   -o /home/jimc/lx/sk1/Module.symvers    -S   -s
> WARNING: modpost: Found 21 section mismatch(es).
> 
> -Wuninitialized  is not in there (explaining lack of warnings)
> 
> is this a local config problem, or has it somehow dropped out of the Kconfig
> process ?
> or was it never in there (seems unlikely) ?

-Wuninitialized is implied by -Wall (which is there) "only with -O1 and
above" (quoting the man page). I'm not sure if -Os qualifies. But
anyway I'm not using CONFIG_CC_OPTIMIZE_FOR_SIZE and didn't get the
warning either...

Maybe this option is simply not 100% reliable. After all, it prints
false positives every now and then, so maybe it also fails to catch
some bugs.

> also, regarding your patch, is there a real need for res_count at all ?
> IOW, why not this (abbreviated) ?
> 
> - res[res_count].start = extra_isa[i];
> + res[i].start = extra_isa[i];
> ...
> - err = platform_device_add_resources(pdev, res, res_count);
> + err = platform_device_add_resources(pdev, res, --i);

We're iterating over 2 different arrays: res and extra_isa. res_count
is the index for res[], i is the index for extra_isa[]. If all
resources are present then both are in sync, but if any resource is
missing then they will drift. So no, I can't see any way to get rid of
res_count.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
