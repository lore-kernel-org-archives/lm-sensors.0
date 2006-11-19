From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 19 Nov 2006 09:06:41 +0000
Subject: [lm-sensors] [patch] incomplete mtp008.c port to 2.6.18.2
Message-Id: <20061119100641.5e815627.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0611172040300.15092@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.64.0611172040300.15092@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dean,

On Fri, 17 Nov 2006 20:48:59 -0800 (PST), dean gaudet wrote:
> i've recently been resurrecting some tyan s2510 and would like to get 
> their mtp008 working.  i found Andrew Pam's patch which brought mtp008 
> forward to 2.6.12, but i'd like to run 2.6.18.2 or later.
> 
> so i went through the patch and compared it with other 2.6.18 hwmon 
> drivers and without really any deep understanding made a bunch of changes 
> which seem to have made it mostly work.
> 
> i have two problems:
> 
> - the lm-sensors userland code seems to expect temp?_over/temp?_hyst files 
> for mtp008 but the driver has min/max... i patched lm-sensors for this, 
> but maybe i should have fixed the driver instead.

The user-space code looks OK to me, it's the driver which needs fixing.
The low temperature limit is in fact an hysteresis limit for that chip,
so the tempN_min files should actually be named tempN_max_hyst. Then
libsensors should be able to translate automatically between the old
names and the new names, so no further change should be required.

> - the mtp008 seems to hang and start reporting all zeroes/constant 
> garbage.  i'm skeptical this is just my hacked code though because the 
> BIOS "System Health Monitor" has the exact same problem after a few 
> minutes.

I found the following in our FAQ:
"Also, MTP008 chips seem to randomly refuse to respond, for unknown
reasons. You can see this as 'XX' entries in i2cdump."
So it might be a known issue with this chip. Which makes me wonder if
it's worth having a driver if it'll stop working after only a few
minutes. Unless this is a bug in the original drivers and we manage to
fix it, of course.

> so... does anyone happen to have a datasheet for this part?

I'll send it to you privately.

> or can anyone spot some obvious boneheadedness in my patch?

I don't have the time to review such a large patch at the moment so
here are just two random comments:

> +#include <linux/hwmon.h>     /* for hardware monitoring drivers */
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/hwmon-vid.h> /* if you need VRM support */

Drop these comments, they are hints for the reader of the driver
porting guide, not meant to be left in the final source code ;)

> +	device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in1_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in1_max.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in2_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in2_max.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in3_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in3_max.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in4_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in4_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in4_max.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in5_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in5_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in5_max.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in6_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in6_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_in6_max.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_max.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_type.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_max.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_type.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_max.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_type.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_div.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_div.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_input.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_min.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_div.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_pwm1.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_pwm1_enable.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_pwm2.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_pwm2_enable.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_pwm3.dev_attr);
> +	device_create_file(&new_client->dev, &sensor_dev_attr_pwm3_enable.dev_attr);
> +	device_create_file(&new_client->dev, &dev_attr_alarms);
> +	device_create_file(&new_client->dev, &dev_attr_beep_mask);
> +	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);

I seem to understand that the MTP008 has some inputs which are shared
between different functions, depending on the chip configuration. So
not all the features listed above are present on a given system. You
should only create the interface files which correspond to the chip
configuration. The user-space code might then need be educated not to
generate errors on missing files. The benefit is that you stop
presenting bogus data to the user, in turn limiting the support
requests we receive.

> note i didn't do the up/down -> mutex conversion yet.

You will also have to properly handle errors that might be returned by
device_create_file(), and to explicitely delete the files on driver
removal. The most efficient way to do this is to use file groups.
Almost all hardware monitoring drivers were converted that way between
2.6.18 and 2.6.19, so you can just take a look at how things were done
in other drivers, and do the same.

-- 
Jean Delvare

