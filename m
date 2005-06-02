From: greg@kroah.com (Greg KH)
Date: Thu, 02 Jun 2005 08:00:50 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 2/3] i2c: new sysfs class
Message-Id: <20050602061045.GB8530@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033654.GC4906@jupiter.solarsys.private>
In-Reply-To: <20050602033654.GC4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 01, 2005 at 11:36:54PM -0400, Mark M. Hoffman wrote:
> 
> This patch adds the sysfs class "hwmon" for use by hardware monitoring
> (sensors) chip drivers.  It (the Kconfig text) presumes that sensors
> chip drivers will be moved to drivers/hwmon (although that is not done
> by this patch).
> 
> Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
> 
> Index: linux-2.6.12-rc5-mm1/drivers/Kconfig
> =================================> --- linux-2.6.12-rc5-mm1.orig/drivers/Kconfig
> +++ linux-2.6.12-rc5-mm1/drivers/Kconfig
> @@ -42,6 +42,8 @@ source "drivers/input/Kconfig"
>  
>  source "drivers/char/Kconfig"
>  
> +source "drivers/hwmon/Kconfig"
> +
>  source "drivers/i2c/Kconfig"
>  
>  source "drivers/w1/Kconfig"
> Index: linux-2.6.12-rc5-mm1/drivers/Makefile
> =================================> --- linux-2.6.12-rc5-mm1.orig/drivers/Makefile
> +++ linux-2.6.12-rc5-mm1/drivers/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_GAMEPORT)		+= input/gamepor
>  obj-$(CONFIG_INPUT)		+= input/
>  obj-$(CONFIG_I2O)		+= message/
>  obj-$(CONFIG_I2C)		+= i2c/
> +obj-$(CONFIG_HWMON)		+= hwmon/
>  obj-$(CONFIG_W1)		+= w1/
>  obj-$(CONFIG_PHONE)		+= telephony/
>  obj-$(CONFIG_MD)		+= md/
> Index: linux-2.6.12-rc5-mm1/drivers/hwmon/Kconfig
> =================================> --- linux-2.6.12-rc5-mm1.orig/drivers/hwmon/Kconfig
> +++ linux-2.6.12-rc5-mm1/drivers/hwmon/Kconfig
> @@ -0,0 +1,15 @@
> +
> +menu "Hardware Monitoring (Sensors) support"
> +
> +config HWMON
> +	tristate "Hardware Monitoring Core support"
> +	help
> +	  If you want hardware monitoring (sensors) support, you should
> +	  say Y here and also to the specific driver(s) for your sensors
> +	  chip(s) below.
> +
> +	  This support can also be built as a module.  If so, the module
> +	  will be called hwmon.

Nice, but you forgot to enable this config option for all of the i2c
chip drivers that use it.  Without that, you get a bunch of compiler
errors at link time :)

Care to send a patch to fix this?

> +struct class_device *hwmon_device_register(struct device *dev, char *fmt, ...)

Do you really want free-form stuff here?  more on that in the next
patch...

> +#ifndef _HWMON_H_
> +#define _HWMON_H_
> +
> +#include <linux/device.h>
> +
> +struct class_device *hwmon_device_register(struct device *dev, char *fmt, ...);
> +
> +void hwmon_device_unregister(struct class_device *cdev);

You might want to just change this to the following, if you don't want
to change the Kconfig entries for the i2c chips:

#ifdef CONFIG_HWMON
struct class_device *hwmon_device_register(struct device *dev, char *fmt, ...);
void hwmon_device_unregister(struct class_device *cdev);
#else
static inline struct class_device *hwmon_device_register(struct device *dev, char *fmt, ...)
{
	return ERR_PTR(-ENODEV);
}
void hwmon_device_unregister(struct class_device *cdev) { }
#endif

But it's up to you...

thanks,

greg k-h
