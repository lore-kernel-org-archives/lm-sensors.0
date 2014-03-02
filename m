From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 02 Mar 2014 13:17:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Do not accept name attributes which include '-'
Message-Id: <20140302141743.0fdf2de5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393612837-20042-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393612837-20042-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 28 Feb 2014 10:40:37 -0800, Guenter Roeck wrote:
> hwmon name attributes must not include '-', as specified in
> Documentation/hwmon/sysfs-interface. Validate the name attribute
> and return an error if it is invalid.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/hwmon.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index e176a43..6a84df4 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -22,6 +22,7 @@
>  #include <linux/gfp.h>
>  #include <linux/spinlock.h>
>  #include <linux/pci.h>
> +#include <linux/string.h>
>  
>  #define HWMON_ID_PREFIX "hwmon"
>  #define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
> @@ -99,6 +100,10 @@ hwmon_device_register_with_groups(struct device *dev, const char *name,
>  	struct hwmon_device *hwdev;
>  	int err, id;
>  
> +	/* Do not accept '-' in hwmon name attribute */
> +	if (name && strchr(name, '-'))
> +		return ERR_PTR(-EINVAL);
> +

I like it, thanks for doing that. Maybe we could check for spaces too?
That would break libsensors as well, and I vaguely recalled that
someone attempted that once already (caught during code review,
thankfully.)

>  	id = ida_simple_get(&hwmon_ida, 0, 0, GFP_KERNEL);
>  	if (id < 0)
>  		return ERR_PTR(id);

Also I think we want to discuss the x86_pkg_temp_thermal driver case
with the guys responsible for it. The driver creates a thermal zone
with type "pkg-temp-0" (and "pkg-temp-1" etc. if you have more than one
CPU.) The thermal-to-hwmon bridge puts "pkg-temp-0" in the name
attribute, which causes libsensors to have to deal with a device named
"pkg-temp-0-virtual-0". Horrible.

Changing "pkg-temp" to "pkg_temp" isn't enough. We also need to teach
the thermal-to-hwmon bridge how to deal with multiple instances of the
same thermal device. And we need to find a way to transmit the
information to libsensors (presumably trough a new sysfs attribute?),
and then implement the support in libsensors.

In the specific case of x86_pkg_temp_thermal though, the sanest thing
to do IMHO would be to _not_ have it exposed as a hwmon device at all.
The temperature it reports is already reported by the coretemp driver,
and I see no point in reporting it twice.

I seem to recall there was a plan to have a flag to skip certain
thermal zones in the thermal-to-hwmon bridge, was it ever implemented?
We'd need exactly that.


-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
