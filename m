From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 17 Dec 2010 22:16:18 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] applesmc: Use PnP rather than
Message-Id: <20101217221618.GA13207@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101216170018.GA8140@ericsson.com>
 <1292623106-31684-1-git-send-email-mjg@redhat.com>
In-Reply-To: <1292623106-31684-1-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg@redhat.com>
Cc: "rydberg@euromail.se" <rydberg@euromail.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Dec 17, 2010 at 04:58:25PM -0500, Matthew Garrett wrote:
> The AppleSMC device is described in ACPI, including a list of its resources.
> We should use those rather than hardcoding the ports. A side-effect is that
> we can then remove the DMI matching, since there's a unique identifier to
> indicate that the machine has one of these devices.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/hwmon/applesmc.c |  182 ++++++++++++++++++++++------------------------
>  1 files changed, 86 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index ce0372f..6c98b60 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -30,7 +30,6 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/delay.h>
> -#include <linux/platform_device.h>
>  #include <linux/input-polldev.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -43,11 +42,13 @@
>  #include <linux/leds.h>
>  #include <linux/hwmon.h>
>  #include <linux/workqueue.h>
> +#include <linux/slab.h>
> +#include <linux/pnp.h>
>  
>  /* data port used by Apple SMC */
> -#define APPLESMC_DATA_PORT	0x300
> +#define APPLESMC_DATA_PORT	0x0
>  /* command/status port used by Apple SMC */
> -#define APPLESMC_CMD_PORT	0x304
> +#define APPLESMC_CMD_PORT	0x4
>  
>  #define APPLESMC_NR_PORTS	32 /* 0x300-0x31f */
>  
> @@ -76,6 +77,8 @@
>  #define MOTION_SENSOR_Z_KEY	"MO_Z" /* r-o sp78 (2 bytes) */
>  #define MOTION_SENSOR_KEY	"MOCN" /* r/w ui16 */
>  
> +#define NOTIFICATION_KEY	"NTOK"
> +
>  #define FANS_COUNT		"FNum" /* r-o ui8 */
>  #define FANS_MANUAL		"FS! " /* r-w ui16 */
>  #define FAN_ID_FMT		"F%dID" /* r-o char[16] */
> @@ -103,6 +106,14 @@ static const char *const fan_speed_fmt[] = {
>  #define to_index(attr) (to_sensor_dev_attr(attr)->index & 0xffff)
>  #define to_option(attr) (to_sensor_dev_attr(attr)->index >> 16)
>  
> +struct applesmc_pnp_device {
> +	int iobase;
> +	int iolen;
> +};
> +
> +struct pnp_dev *pdev;
> +struct applesmc_pnp_device *apple_pnp_device;
> +
Those variables are still global.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
