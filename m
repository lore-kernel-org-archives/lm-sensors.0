From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 19 Feb 2011 18:20:16 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hp_accel: Fix driver name
Message-Id: <20110219182016.GA1038@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219142832.1516d1ee@endymion.delvare>
In-Reply-To: <20110219142832.1516d1ee@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 19, 2011 at 08:28:32AM -0500, Jean Delvare wrote:
> I suspect that the "lis3lv02d" driver name is a legacy from before
> the split into several modules. Use a specific name for the hp_accel
> driver, for better error messages and easier investigation of issues.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Eric Piel <eric.piel@tremplin-utc.net>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> Not tested due to lack of hardware.
> 
>  drivers/platform/x86/hp_accel.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.38-rc5.orig/drivers/platform/x86/hp_accel.c	2011-02-19 13:28:46.000000000 +0100
> +++ linux-2.6.38-rc5/drivers/platform/x86/hp_accel.c	2011-02-19 13:39:49.000000000 +0100
> @@ -39,7 +39,7 @@
>  #include <acpi/acpi_drivers.h>
>  #include "../../misc/lis3lv02d/lis3lv02d.h"
>  
> -#define DRIVER_NAME     "lis3lv02d"
> +#define DRIVER_NAME     "hp_accel"
>  #define ACPI_MDPS_CLASS "accelerometer"
>  
Not sure if you can do that, given the close interrelation with lis3lv02d.c.
That really asks for testing on a real system.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
