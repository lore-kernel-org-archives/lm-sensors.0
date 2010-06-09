From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Jun 2010 09:07:19 +0000
Subject: Re: [lm-sensors] [PATCH] fix hwmon/i5k_amb.c sysfs attribute for
Message-Id: <20100609110719.270634a9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100609140000.60975b2f.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20100609140000.60975b2f.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kame-san,

On Wed, 9 Jun 2010 14:00:00 +0900, KAMEZAWA Hiroyuki wrote:
> I'm not familiar with this area but I need this patch for lockdep in mmotm.
> please check.
> -Kame
> =
> From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> i5k_amb.ko uses dynamically allocated memory (by kmalloc) for
> attributes passed to sysfs. So, sysfs_attr_init() should be called
> for working happy with lockdep.

Such a fix is needed, yes. I though Jiri was working on it... Jiri?

> Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> ---
>  drivers/hwmon/i5k_amb.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Index: mmotm-2.6.34-Jun6/drivers/hwmon/i5k_amb.c
> =================================> --- mmotm-2.6.34-Jun6.orig/drivers/hwmon/i5k_amb.c
> +++ mmotm-2.6.34-Jun6/drivers/hwmon/i5k_amb.c
> @@ -289,6 +289,7 @@ static int __devinit i5k_amb_hwmon_init(
>  			iattr->s_attr.dev_attr.attr.mode = S_IRUGO;
>  			iattr->s_attr.dev_attr.show = show_label;
>  			iattr->s_attr.index = k;
> +			sysfs_attr_init(&iattr->s_attr.dev_attr.attr);
>  			res = device_create_file(&pdev->dev,
>  						 &iattr->s_attr.dev_attr);
>  			if (res)
> @@ -303,6 +304,7 @@ static int __devinit i5k_amb_hwmon_init(
>  			iattr->s_attr.dev_attr.attr.mode = S_IRUGO;
>  			iattr->s_attr.dev_attr.show = show_amb_temp;
>  			iattr->s_attr.index = k;
> +			sysfs_attr_init(&iattr->s_attr.dev_attr.attr);
>  			res = device_create_file(&pdev->dev,
>  						 &iattr->s_attr.dev_attr);
>  			if (res)
> @@ -318,6 +320,7 @@ static int __devinit i5k_amb_hwmon_init(
>  			iattr->s_attr.dev_attr.show = show_amb_min;
>  			iattr->s_attr.dev_attr.store = store_amb_min;
>  			iattr->s_attr.index = k;
> +			sysfs_attr_init(&iattr->s_attr.dev_attr.attr);
>  			res = device_create_file(&pdev->dev,
>  						 &iattr->s_attr.dev_attr);
>  			if (res)
> @@ -333,6 +336,7 @@ static int __devinit i5k_amb_hwmon_init(
>  			iattr->s_attr.dev_attr.show = show_amb_mid;
>  			iattr->s_attr.dev_attr.store = store_amb_mid;
>  			iattr->s_attr.index = k;
> +			sysfs_attr_init(&iattr->s_attr.dev_attr.attr);
>  			res = device_create_file(&pdev->dev,
>  						 &iattr->s_attr.dev_attr);
>  			if (res)
> @@ -348,6 +352,7 @@ static int __devinit i5k_amb_hwmon_init(
>  			iattr->s_attr.dev_attr.show = show_amb_max;
>  			iattr->s_attr.dev_attr.store = store_amb_max;
>  			iattr->s_attr.index = k;
> +			sysfs_attr_init(&iattr->s_attr.dev_attr.attr);
>  			res = device_create_file(&pdev->dev,
>  						 &iattr->s_attr.dev_attr);
>  			if (res)
> @@ -362,6 +367,7 @@ static int __devinit i5k_amb_hwmon_init(
>  			iattr->s_attr.dev_attr.attr.mode = S_IRUGO;
>  			iattr->s_attr.dev_attr.show = show_amb_alarm;
>  			iattr->s_attr.index = k;
> +			sysfs_attr_init(&iattr->s_attr.dev_attr.attr);
>  			res = device_create_file(&pdev->dev,
>  						 &iattr->s_attr.dev_attr);
>  			if (res)
> 

Looks good, applied, thanks.

That being said, I don't quite get how this is supposed to work.
Looking at the implementation of sysfs_attr_init(), it is a macro which
declares a static variable and uses it as a reference. Whether this
reference is shared amongst different attributes solely depends on how
the driver is written. If the driver has a helper function, or an
iterative loop, to create the attributes, they all share the reference.
If all file creations are explicit, each attribute has its reference.
I'm not sure how you can come up with anything useful in the end. Eric?

As a side note, I am really not a big fan of the current implementation
anyway. Having to add sysfs_attr_init() all around the place for
debugging purposes only is bad. We have 50 calling sites already and
more are inevitably coming. I would love to see this all folded into
device_create_file() so that it is transparent to the callers.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
