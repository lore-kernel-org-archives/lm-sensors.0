From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 01 Sep 2006 12:33:42 +0000
Subject: [lm-sensors] TODO: "dynamic" sysfs callbacks
Message-Id: <20060901143342.15558b83.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F1E5B6.1080105@gmail.com>
In-Reply-To: <44F1E5B6.1080105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> once again with the email-harvesting / communication/coordination.
> 
> <quoting Jean, I think>
> 
> BTW, do you have any plan to convert the asb100 driver to use the
> "dynamic" sysfs callbacks? This would kill some more macros, and shrink
> the driver size even more.
> 
> 
> The approx list of 'opportunities' here is:
> 
> [jimc at harpo ac-2]$ grep -rl '##' drivers/hwmon/*.c
> drivers/hwmon/abituguru.c
> drivers/hwmon/adm1021.c
> drivers/hwmon/adm1025.c
> drivers/hwmon/adm1026.c	 - patch on hold, needs tester.

I had to discard it from my stack, it no more applies after Mark M.
Hoffman's patch fixing unchecked return values.

> drivers/hwmon/adm1031.c
> drivers/hwmon/adm9240.c
> drivers/hwmon/asb100.c
> drivers/hwmon/ds1621.c
> drivers/hwmon/fscher.c
> drivers/hwmon/fscpos.c
> drivers/hwmon/gl518sm.c
> drivers/hwmon/gl520sm.c
> drivers/hwmon/it87.c
> drivers/hwmon/lm75.c
> drivers/hwmon/lm77.c
> drivers/hwmon/lm78.c
> drivers/hwmon/lm80.c
> drivers/hwmon/lm85.c
> drivers/hwmon/lm87.c
> drivers/hwmon/lm92.c
> drivers/hwmon/max1619.c
> drivers/hwmon/sis5595.c
> drivers/hwmon/smsc47b397.c
> drivers/hwmon/smsc47m192.c
> drivers/hwmon/smsc47m1.c
> drivers/hwmon/via686a.c
> drivers/hwmon/vt8231.c
> drivers/hwmon/w83627ehf.c
> drivers/hwmon/w83627hf.c
> drivers/hwmon/w83781d.c
> drivers/hwmon/w83791d.c
> drivers/hwmon/w83792d.c

I do not consider the dynamic sysfs callbacks conversion as "must be
done". Of course drivers are nicer and smaller when done, but this is a
significant work, and it needs complete testing, contrary to the
unchecked return values fixes.

So I wouldn't bother converting a driver unless you can test it. See
what happened with the adm1026 driver, you converted it long ago,
nobody ever tested it, and now the patch is discarded as it conflicts
with other changes.

> *Deeper 'dynamic's are possible*
> 
> The above folds multiple callbacks on 1 dimension (index)
> to reduce code footprint, but more are possible.
> 
> 
> 
> following 2 steps above:
> 
> 1. function now relys on being passed a struct sensor_device_attribute_2
> which has 2 additional parameters; index, and nr.  This example uses
> 2nd parameter to distinguish which attribute of the sensor is being
> requested (index still chooses 1 of N sensors)
>  
> static ssize_t show_fan(struct device *dev, struct device_attribute *devattr, char *buf)
> {
>         struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
>         int idx = attr->index;
>         int func = attr->nr;
>         struct pc87360_data *data = pc87360_update_device(dev);
>         unsigned res = -1;
> 
>         switch(func) {
>         case FN_FAN_INPUT:
>                 res = FAN_FROM_REG(data->fan[idx],
>                                    FAN_DIV_FROM_REG(data->fan_status[idx]));
>                 break;
>         case FN_FAN_MIN:
>                 res = FAN_FROM_REG(data->fan_min[idx],
>                                    FAN_DIV_FROM_REG(data->fan_status[idx]));
>                 break;
>         case FN_FAN_STATUS:
>                 res = FAN_STATUS_FROM_REG(data->fan_status[idx]);
>                 break;
>         case FN_FAN_DIV:
>                 res = FAN_DIV_FROM_REG(data->fan_status[idx]);
>                 break;
>         default:
>                 printk(KERN_ERR "unknown attr fetch\n");
>         }
>         return sprintf(buf, "%u\n", res);
> }

As I mentioned earlier during the vt1211 review, I'm no big fan of this
approach. You end up aggregating many features which don't share much
code. It's still reasonable in your example above, but I think it has
gone to an extreme in one case in the vt1211 driver. Let's not jump
from one extreme to the other.

I do agree that having a single callback for displaying fanN_input and
fanN_min makes full sense, and this suggests a second level of
indexing. But beyond that point I think we have to be reasonable. I
don't mind for new drivers, authors should stay relatively free,
however I strongly object to converting all our perfectly working
drivers to use that approach.

Beyond the readability of the code, there are some performance issues
to consider. For example I wonder how the code above interacts with the
CPU cache, compared to 1-level-indexed callbacks, in the typical
"sensors" scenario. I don't really have the time to investigate this,
unfortunately. Switch/case is usually not recommended in performance
terms, even though I'd expect gcc to optimize it relatively nicely if
the "func" values are chosen wisely.

> NB - technique saves ~ 9% object code on 1 driver.

It really depends on where you come from for a given driver. But yes
there's definitely a size reduction.

> This "2-D dynamic callback" approach is not widely used,
> currently only done in:
> 	w83792d.c, abituguru.c.
> patches which use it:
> 	vt1211.c - going in soon I believe (congrats Juerg)
> 	pc87360.c - 
> 	- unreviewed, patch 3/3 has some annoying screwups in the attr mapping,
> 	- as visible above (DIV vs fan_status, will recheck/redo)
> 	case FN_FAN_DIV:
>                 res = FAN_DIV_FROM_REG(data->fan_status[idx]);

The 2-index variants may be a problem because not all callbacks need 2
parameters and mixing 0, 1 and 2-indexes attributes can become a mess.
Using sysfs_create_group may help in that respect, because it
manipulates pointers rather than the attributes directly.

I have been thinking of a "standard hwmon attribute" which would
combine our current sensor and sensor_2 attributes. I'll think again
about it after we are done with the unchecked return values.

-- 
Jean Delvare

