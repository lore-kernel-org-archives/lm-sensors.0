From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Apr 2011 00:03:20 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] Make all it87 drivers SMP safe.
Message-Id: <20110407000320.GA28123@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302124396-22449-1-git-send-email-natg@google.com>
In-Reply-To: <1302124396-22449-1-git-send-email-natg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

On Wed, Apr 06, 2011 at 05:13:16PM -0400, Nat Gurumoorthy wrote:
> 03 - Adds changes to hwmon driver to use the new lock.
> 
> Signed-off-by: Nat Gurumoorthy <natg@google.com>
> 
Content looks ok, but two comments:

1) When sending a series of patches, send subsequent ones as reply to the first patch.
   "git send-email" does this for you, as does quilt.
2) The headline of each patch should describe what is done in that patch.
   The description above doesn't mean anything without knowing the context.

Also see Documentation/SubmittingPatches, item #2 and #15.

Thanks,
Guenter

> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 297bc9a..afe671a 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -436,6 +436,7 @@ config SENSORS_IBMPEX
>  config SENSORS_IT87
>  	tristate "ITE IT87xx and compatibles"
>  	select HWMON_VID
> +	select IT87_LOCK
>  	help
>  	  If you say yes here you get support for ITE IT8705F, IT8712F,
>  	  IT8716F, IT8718F, IT8720F, IT8721F, IT8726F and IT8758E sensor
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index 316b648..bc32535 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -55,6 +55,8 @@
>  #include <linux/dmi.h>
>  #include <linux/acpi.h>
>  #include <linux/io.h>
> +#include <linux/spinlock.h>
> +#include <linux/it87_lock.h>
>  
>  #define DRVNAME "it87"
>  
> @@ -110,7 +112,9 @@ superio_select(int ldn)
>  
>  static inline void
>  superio_enter(void)
> +__acquires(&it87_io_lock)
>  {
> +	spin_lock(&it87_io_lock);
>  	outb(0x87, REG);
>  	outb(0x01, REG);
>  	outb(0x55, REG);
> @@ -119,9 +123,11 @@ superio_enter(void)
>  
>  static inline void
>  superio_exit(void)
> +__releases(&it87_io_lock)
>  {
>  	outb(0x02, REG);
>  	outb(0x02, VAL);
> +	spin_unlock(&it87_io_lock);
>  }
>  
>  /* Logical device 4 registers */
> @@ -1899,8 +1905,12 @@ static int __devexit it87_remove(struct platform_device *pdev)
>     would slow down the IT87 access and should not be necessary. */
>  static int it87_read_value(struct it87_data *data, u8 reg)
>  {
> +	int ret;
> +	spin_lock(&it87_io_lock);
>  	outb_p(reg, data->addr + IT87_ADDR_REG_OFFSET);
> -	return inb_p(data->addr + IT87_DATA_REG_OFFSET);
> +	ret = inb_p(data->addr + IT87_DATA_REG_OFFSET);
> +	spin_unlock(&it87_io_lock);
> +	return ret;
>  }
>  
>  /* Must be called with data->update_lock held, except during initialization.
> @@ -1908,8 +1918,10 @@ static int it87_read_value(struct it87_data *data, u8 reg)
>     would slow down the IT87 access and should not be necessary. */
>  static void it87_write_value(struct it87_data *data, u8 reg, u8 value)
>  {
> +	spin_lock(&it87_io_lock);
>  	outb_p(reg, data->addr + IT87_ADDR_REG_OFFSET);
>  	outb_p(value, data->addr + IT87_DATA_REG_OFFSET);
> +	spin_unlock(&it87_io_lock);
>  }
>  
>  /* Return 1 if and only if the PWM interface is safe to use */
> -- 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
