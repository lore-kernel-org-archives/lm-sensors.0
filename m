From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Sep 2009 14:49:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090918164902.55a387eb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Sep 2009 14:09:23 +0200, Rodolfo Giometti wrote:
> Hi Jean,
> 
> this new proposal patch sounds better to you? :)
> 
> Ciao,
> 
> Rodolfo
> 
> --
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2d50166..bc7058f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -894,6 +894,7 @@ config SENSORS_W83L786NG
>  
>  config SENSORS_W83627HF
>  	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
> +	depends on 83627HF

Which doesn't exist, so the driver can't be selected. Obviously you
meant: depends on MFD_W83627HF.

But please also see my discussion with Samuel on depends vs. select.
I'd prefer that you use select. Especially given that the MFD
configuration entry is _after_ the hwmon configuration entry in
Kconfig, I fear that even if users see and select MFD_W83627HF, they
won't walk back to the W83627HF entry to select it.

Samuel, wouldn't it make sense to move the MFD section up in the Device
Drivers section?

Even after fixing this so that I could select the driver, I'm hitting
build problems:

  CC [M]  drivers/hwmon/w83627hf.o
drivers/hwmon/w83627hf.c: In function ‘w83627hf_probe’:
drivers/hwmon/w83627hf.c:1121: warning: passing argument 1 of ‘acpi_check_resource_conflict’ from incompatible pointer type
drivers/hwmon/w83627hf.c:1125: error: ‘WINB_REGION_SIZE’ undeclared (first use in this function)
drivers/hwmon/w83627hf.c:1125: error: (Each undeclared identifier is reported only once
drivers/hwmon/w83627hf.c:1125: error: for each function it appears in.)
drivers/hwmon/w83627hf.c: In function ‘w83627hf_remove’:
drivers/hwmon/w83627hf.c:1290: error: ‘WINB_REGION_SIZE’ undeclared (first use in this function)

Please build-test your patches before you send them.

>  	select HWMON_VID
>  	help
>  	  If you say yes here you get support for the Winbond W836X7 series
> diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
> index 389150b..4757668 100644
> --- a/drivers/hwmon/w83627hf.c
> +++ b/drivers/hwmon/w83627hf.c
> @@ -51,18 +51,10 @@
>  #include <linux/mutex.h>
>  #include <linux/ioport.h>
>  #include <linux/acpi.h>
> -#include <asm/io.h>
> +#include <linux/io.h>

As I said before, this change is already upstream, so please don't
include it in your patch.

>  #include "lm75.h"
> +#include <linux/mfd/w83627hf.h>

Global includes must be listed before local ones.

I'll go on with the review when you provide a patch I can build.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
