From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 24 Dec 2005 16:04:01 +0000
Subject: [lm-sensors] revisiting __SENSOR_DEVICE_ATTR() and array
Message-Id: <20051224170401.793153ac.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <439A7911.5020904@gmail.com>
In-Reply-To: <439A7911.5020904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> Thanks for the review, heres the respin against rc5-mm3
> with corrections to the above.

Looks OK, except:

> diff -ruNp -X exclude-diffs ../linux-2.6.15-rc5-mm3-sk/include/linux/hwmon-sysfs.h adm/include/linux/hwmon-sysfs.h
> --- ../linux-2.6.15-rc5-mm3-sk/include/linux/hwmon-sysfs.h	2005-10-28 15:32:08.000000000 -0600
> +++ adm/include/linux/hwmon-sysfs.h	2005-12-19 05:12:15.000000000 -0700
> @@ -27,11 +27,13 @@ struct sensor_device_attribute{
>  #define to_sensor_dev_attr(_dev_attr) \
>  	container_of(_dev_attr, struct sensor_device_attribute, dev_attr)
>  
> -#define SENSOR_DEVICE_ATTR(_name,_mode,_show,_store,_index)	\
> -struct sensor_device_attribute sensor_dev_attr_##_name = {	\
> -	.dev_attr =	__ATTR(_name,_mode,_show,_store),	\
> -	.index =	_index,					\
> -}
> +#define SENSOR_ATTR(_name, _mode, _show, _store, _index)	\
> +	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
> +	  .index = _index }
> +
> +#define SENSOR_DEVICE_ATTR(_name, _mode, _show, _store, _index)	\
> +struct sensor_device_attribute sensor_dev_attr_##_name		\
> +	= SENSOR_ATTR(_name, _mode, _show, _store, _index)
>  
>  struct sensor_device_attribute_2 {
>  	struct device_attribute dev_attr;

This change is already provided by an earlier patch of mine - so you
shouldn't include it here.

> +       for (i=0; i<16; i++) {

Same comment here as for pc87360.c: please try to respect the coding
style around.

> +        /* vid deprecated in favour of cpu0_vid, remove after 2005-11-11 */

You are reintroducing a comment which was removed some times ago.

> hmm,  it has no maintainer listed.  I hope someone can test it.
> Im CCg the authors named in the file, in case theyre not on lm-sensors.

I know they are, but they might not be paying attention to everthing so
an explicit Cc couldn't hurt.

> also, it looks like the following could also benefit some (I havent 
> looked closely)
> adm1025,
> adm1031.
> adm9240 ,
> asb100,
> gl520sm.c
> lm{78,85}               several *_fan_##ofset##_{min,max,div,input}
> 
> A sligthly sloppy grep for DEVICE_ATTR or  '##' shows 905 lines.
> in hwmon/*, some of them are junk, but others are legitimate opportunities
> to lose weight.

Yes, virtually every driver can benefit. Just like with Yani Ioannou's
"dynamic sysfs callbacks", the larger the driver, the more it benefits.

> Also.  I noticed some repeated uses like this:
> ../../linux-2.6.14.3/drivers/hwmon/gl518sm.c:327:static 
> DEVICE_ATTR(in3_input, S_IRUGO, show_in_input3, NULL);
> 
> It suggests that DEVICE_ATTR needs a helper initialization macro
> just like SENSOR_ATTR, thoughts ?

It already exists, it's named __ATTR. I'm using it in my (not yet
published) f71805f driver.

Thanks,
-- 
Jean Delvare

