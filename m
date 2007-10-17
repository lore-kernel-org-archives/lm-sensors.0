From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 17 Oct 2007 14:57:00 +0000
Subject: Re: [lm-sensors] [PATCH] On n2100 systems,
Message-Id: <20071017165700.7c282812@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071016100857.GA25544@kos.to>
In-Reply-To: <20071016100857.GA25544@kos.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Riku,

On Tue, 16 Oct 2007 13:08:57 +0300, Riku Voipio wrote:
> On thecus n2100, the bootloader does not setup fans to run. In order
> to protect the user from frying their gear, start up fans on boot.

Why don't you fix the "bootloader" (whatever it is in your context)
instead? Fixing the fan speed at the OS level sounds wrong. The user
might be using a different OS. The user might even not run any OS.
Would the hardware fry if the user stays in the bootloader?

On top of this, if I read the the datasheet of the F75375S correctly,
it has the fans on (in "speed mode") by default. This suggests that the
"bootloader" is no only "not setting up fans to run" but it is actively
turning them off. So that's what you really need to fix.

> 
> Depends on:
> 
> f75375s: Add new style bindings
> f75375s: allow setting up fans with platform_data
> 
> patches sent to lm-sensors mailing list.
> 
> Signed-off-by: Riku Voipio <riku.voipio@movial.fi>
> ---
>  arch/arm/mach-iop32x/n2100.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
> index 1873bd8..5a4acff 100644
> --- a/arch/arm/mach-iop32x/n2100.c
> +++ b/arch/arm/mach-iop32x/n2100.c
> @@ -16,6 +16,7 @@
>  
>  #include <linux/mm.h>
>  #include <linux/init.h>
> +#include <linux/f75375s.h>
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> @@ -200,11 +201,21 @@ static struct platform_device n2100_serial_device = {
>  	.resource	= &n2100_uart_resource,
>  };
>  
> +static struct f75375s_platform_data n2100_f75375s = {
> +	.pwm		= { 255, 255 },
> +	.pwm_enable = { 0, 0 },

Bad alignment. And I don't think that PWM can be completely disabled on
the F75375S anyway? So you should set pwm_enable to 1 not 0.

> +};
> +
>  static struct i2c_board_info __initdata n2100_i2c_devices[] = {
>  	{
>  		I2C_BOARD_INFO("rtc-rs5c372", 0x32),
>  		.type = "rs5c372b",
>  	},
> +	{
> +		I2C_BOARD_INFO("f75375", 0x2e),
> +		.type = "f75375",
> +		.platform_data = &n2100_f75375s,
> +	},
>  };
>  
>  /*


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
