From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 13 Oct 2007 12:58:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/sis5595: Add individual alarm files
Message-Id: <20071013145854.26b96602@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <470E6494.7000408@gmail.com>
In-Reply-To: <470E6494.7000408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Fri, 12 Oct 2007 23:49:19 +0200, Ivo Manca wrote:
> Hey Jean,
> 
> Thanks for the quick review. It's starting to show I'm new to this, 
> isn't it? ;)

New contributors are always welcome :)

> Anyway, one question while making the patch for 2.6.23.1:
> 
> @@ -553,7 +578,9 @@
>           || (err = device_create_file(&pdev->dev,
>                            &dev_attr_temp1_max))
>           || (err = device_create_file(&pdev->dev,
> -                          &dev_attr_temp1_max_hyst)))
> +                          &dev_attr_temp1_max_hyst))
> +         || (err = device_create_file(&pdev->dev,
> +                          &sensor_dev_attr_temp1_alarm.dev_attr)))
>              goto exit_remove_files;
> (E-mail client will most likely mess this up, however, it's also in the 
> original patch you just reviewed...).
> The line "&sensor_dev_attr_temp1_alarm.dev_attr)))" can not fit within 
> 80 characters using the same indentation as the lines above it; it takes 
> 87 characters. However, removing the spaces before it, will still make 
> it use 81 chars... I can't see any hint about it in the CodingStyles and 
> removing some tabs will make it look just plain ugly. Any hint how to 
> format it? Patch against 2.6.23.1 is ready, just waiting to be sure how 
> to do this correct :p

The usual way to workaround this is indeed to reduce the level of
indentation. Not necessarily very nice, but the easiest. In this
particular case, if you don't want to do that, I see two alternatives
(probably for a different patch though):

1* Move the creation of these individual files to a separate function.
This saves one level of indentation, so it should fit.

2* Split sis5595_attributes_opt into sis5595_attributes_in4 and
sis5595_attributes_temp1, and use sysfs_create_group on these instead
of individual calls to device_create_file.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
