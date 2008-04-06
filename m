From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Apr 2008 09:58:47 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] thermal: build generic thermal driver
Message-Id: <20080406115847.2849532e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1207123645.27304.3.camel@acpi-hp-zz.sh.intel.com>
In-Reply-To: <1207123645.27304.3.camel@acpi-hp-zz.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Hans de Goede <j.w.r.degoede@hhs.nl>

Hi Rui,

On Wed, 02 Apr 2008 16:07:25 +0800, Zhang, Rui wrote:
> The generic thermal driver can be built as module "thermal_sys",
> which give us more flexibility both at build time and
> when bugs are reported.

I (obviously) like the idea...

> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/Kconfig   |    4 ++--
>  drivers/thermal/Makefile  |    3 ++-
>  drivers/thermal/thermal.c |    2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/drivers/thermal/Kconfig
> =================================> --- linux-2.6.orig/drivers/thermal/Kconfig
> +++ linux-2.6/drivers/thermal/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  
>  menuconfig THERMAL
> -	bool "Generic Thermal sysfs driver"
> +	tristate "Generic Thermal sysfs driver"

There's a build breakage currently if this is compiled as module, fix
is below:

---
 include/linux/thermal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.25-rc8.orig/include/linux/thermal.h	2008-02-11 09:49:10.000000000 +0100
+++ linux-2.6.25-rc8/include/linux/thermal.h	2008-04-06 09:40:06.000000000 +0200
@@ -89,7 +89,7 @@ int thermal_zone_bind_cooling_device(str
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 
-#ifdef	CONFIG_THERMAL
+#if defined CONFIG_THERMAL || defined CONFIG_THERMAL_MODULE
 struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 							       struct
 							       thermal_cooling_device_ops


>  	help
>  	  Generic Thermal Sysfs driver offers a generic mechanism for
>  	  thermal management. Usually it's made up of one or more thermal
> @@ -11,4 +11,4 @@ menuconfig THERMAL
>  	  Each thermal zone contains its own temperature, trip points,
>  	  cooling devices.
>  	  All platforms with ACPI thermal support can use this driver.
> -	  If you want this support, you should say Y here.
> +	  If you want this support, you should say Y or M here.
> Index: linux-2.6/drivers/thermal/thermal.c
> =================================> --- linux-2.6.orig/drivers/thermal/thermal.c
> +++ linux-2.6/drivers/thermal/thermal.c
> @@ -31,7 +31,7 @@
>  #include <linux/thermal.h>
>  #include <linux/spinlock.h>
>  
> -MODULE_AUTHOR("Zhang Rui")
> +MODULE_AUTHOR("Zhang Rui");
>  MODULE_DESCRIPTION("Generic thermal management sysfs support");
>  MODULE_LICENSE("GPL");
>  
> Index: linux-2.6/drivers/thermal/Makefile
> =================================> --- linux-2.6.orig/drivers/thermal/Makefile
> +++ linux-2.6/drivers/thermal/Makefile
> @@ -2,4 +2,5 @@
>  # Makefile for sensor chip drivers.
>  #
>  
> -obj-$(CONFIG_THERMAL)		+= thermal.o
> +thermal_sys-objs	+= thermal.o
> +obj-$(CONFIG_THERMAL)		+= thermal_sys.o
> 
> 

I'd rather rename the source file to thermal_sys.c, so that developers
can search for the module name and find it. It's also more efficient.
Git handles renaming just fine, so I guess Len can take care of this.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
