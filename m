From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 29 May 2015 08:49:11 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (nct6775) Add missing sysfs attibute initialization
Message-Id: <20150529104911.2f1a980c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432829756-14595-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1432829756-14595-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 28 May 2015 09:15:55 -0700, Guenter Roeck wrote:
> The following error message is seen when loading the nct6775 driver
> with DEBUG_LOCK_ALLOC enabled.
> 
> BUG: key ffff88040b2f0030 not in .data!
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 186 at kernel/locking/lockdep.c:2988
> 				lockdep_init_map+0x469/0x630()
> DEBUG_LOCKS_WARN_ON(1)
> 
> Caused by a missing call to sysfs_attr_init() when initializing
> sysfs attributes.
> 
> Reported-by: Alexey Orishko <alexey.orishko@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/nct6775.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index 4fcb48103299..bd1c99deac71 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -995,6 +995,7 @@ nct6775_create_attr_group(struct device *dev, struct sensor_template_group *tg,
>  				 (*t)->dev_attr.attr.name, tg->base + i);
>  			if ((*t)->s2) {
>  				a2 = &su->u.a2;
> +				sysfs_attr_init(&a2->dev_attr.attr);
>  				a2->dev_attr.attr.name = su->name;
>  				a2->nr = (*t)->u.s.nr + i;
>  				a2->index = (*t)->u.s.index;
> @@ -1005,6 +1006,7 @@ nct6775_create_attr_group(struct device *dev, struct sensor_template_group *tg,
>  				*attrs = &a2->dev_attr.attr;
>  			} else {
>  				a = &su->u.a1;
> +				sysfs_attr_init(&a->dev_attr.attr);
>  				a->dev_attr.attr.name = su->name;
>  				a->index = (*t)->u.index + i;
>  				a->dev_attr.attr.mode 
Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
