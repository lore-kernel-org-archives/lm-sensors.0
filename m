From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 31 Aug 2005 11:25:06 +0000
Subject: [lm-sensors] [patch 0/6] pc87360 SDA (sensor-dev-attr) callbacks
Message-Id: <IGUfQllj.1125479809.2860660.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200508302241.j7UMfQjF007933@harpo.jimc.earth>
In-Reply-To: <200508302241.j7UMfQjF007933@harpo.jimc.earth>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jim,

On 2005-08-30, Jim Cromie wrote:
> This patch set reworks hwmon/pc87360.c to use the SENSOR_DEVICE_ATTR
> idiom by Yani Iannou, then uses the new member field to distinguish
> which device is being accessed, eliminating the need for macro'd
> repetition of a bunch of sysfs callback routines.
>
> These patches are updated for 2.6.13 release, with minor header
> adjustments.

You will need to ensure that they apply cleanly on top of Greg's i2c
stack:
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-02-i2c-2.6.13.patch

This shouldn't be a problem, except maybe for the added include.

> 01	i2c-pc87360-01-yani-callback-form.patch
>
> a) Change DEVICE_ATTR declarations to SENSOR_DEVICE_ATTR declarations,
> which have an additional index member
>
> b) Rework sysfs-callbacks (embedded in macros) to use
> to_sensor_dev_attr to do a typesefe conversion of a *device_attribute
> to a *sensor_device_attribute.  Use the index member instead of the
> offset macro-arg to access the right sensor.

Looks to me like you missed 6 of them:

One in show_pwm##offset:
FAN_CONFIG_INVERT(data->fan_conf, \
		  offset-1))); \

Two in set_pwm##offset:
      FAN_CONFIG_INVERT(data->fan_conf, offset-1)); \
pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(offset-1), \

One in set_temp##offset##_min:
pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_MIN, \

One in set_temp##offset##_max:
pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_MAX, \

And one in set_temp##offset##_crit:
pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_CRIT, \

Of course, your patch 03 fixes it, but I still would prefer that each
patch does exactly one thing, and does it well.

> c) Change the calls to device_create_file() to dereference the
> sensor_device_attribute to pass its device_attribute member
>
> d) added includes

That would be without an "s", as there's a single include being added.

> 02	i2c-pc87360-02-fn-renames.patch
>
> Several of the macro-d functions rely on the ##offset## in the name to
> disambiguate them from others, this patch alters the names so we can
> drop the ##offset## in the next patch.

OK, no objection (but see my additional comment about _set_fan_min below.)

> 03.	i2c-pc87360-03-attr-callback-demacro.patch
>
> Convert macro-repeated callback-fns to single declaration.  They're
> already using attr->index (patch 1), and are disambiguated (patch 2),
> so this is as close as possible to a white-space patch.

Looks OK to me too, except for the additional blank lines you have been
inserting before show_temp_input and show_temp_alarms, which you should
drop.

> 04.	i2c-pc87360-04-mv-offset-skew-2-init.patch

Please spell out "to" in full letters, it's not that long.

> The temp, therm, fan, pwm callbacks all have an offset skew in the
> code which accommodates attribute numbering conventions under
> /sys/bus/i2c/devices/9191-6620/ (ie they start at 1)
>
> This patch moves that skew into the declaration, and out of the
> functions (except for therm, where we simplify from 2 skews to 1).
> The declarative skew is clearer, less error-prone, and more efficient.

The therm part looks bogus to me. Your patch leaves the -4 and +7 skews
in {show,set}_therm_crit while adding -4 in the declaration. This can't
be correct.

Additionally, you aren't actually addressing the skew problem for therm.
For most of it, you are moving from no skew in the declaration and a +7
skew in the functions to -4 in the declaration and +11 in the functions,
so you are actually *adding* skews for no benefit. Why don't you
instead set +7 in the declaration, and no skew in the functions? That
would work just fine as far as I can see, except for
{show,set}_therm_crit which will need an additional skew in functions -
but there's no way around it.


> 05.	i2c-pc87360-05-hwmon-sysfs-array-init.patch
>
> This patch refactors SENSOR_DEVICE_ATTR macro.  1st it creates a new
> macro __SENSOR_DEVICE_ATTR() which expands to an initialization
> expression, then it uses that in SENSOR_DEVICE_ATTR, which declares
> and initializes a struct sensor_device_attribute.
>
> __SENSOR_DEVICE_ATTR() imitates __ATTR in include/linux/device.h
>
> 06.	i2c-pc87360-06-array-init-loop.patch
>
> With __SENSOR_DEVICE_ATTR's defined by 05, we now use them to
> initialize a whole array of struct sensor_device_attributes.  This
> allows us to loop over the array, and call device_create_file() for
> each element.

These ones are more controversial and will need to be discussed, as I may
have mentioned earlier already. I would prefer them to be postponned for
now, so that we can concentrate on finally getting the first 4 patches
into -mm. It was about time (my bad.)

One thing your patch set doesn't do, and I think should, is merging
_set_fan_min and set_fan_min. Could you please work on a 5th patch doing
that? set_fan_min is just a wrapper now, and it's not needed that I can
see. So _set_fan_min should become set_fan_min, and should be called
directly.

You are not that far from a great patch set, good work. Please address
the issues I mentioned, add the 5th patch for set_fan_min, and repost.
Make sure you CC: Greg KH on each patch so that he can pick them for his
i2c tree. I would also enjoy: one diffstat for the 5-patch set, mentally
adding the individual diffstats isn't relevant here; and a comparison
of the binary size of the driver before and after the patch set, make
sure that you disable debugging before doing that.

Thanks,
--
Jean Delvare
