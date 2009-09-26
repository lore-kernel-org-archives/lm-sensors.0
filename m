From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Sep 2009 11:24:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Fix spurious section mismatch
Message-Id: <20090926132448.2374507c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <b9df5fa10909230701u128fbec2x78bb433e3a2f42b@mail.gmail.com>
In-Reply-To: <b9df5fa10909230701u128fbec2x78bb433e3a2f42b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rakib Mullick <rakib.mullick@gmail.com>
Cc: lm-sensors@lm-sensors.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <jic23@cam.ac.uk>

Hi Rabik,

On Wed, 23 Sep 2009 20:01:47 +0600, Rakib Mullick wrote:
> Fix spurious section mismatch warnings, caused due to reference from
> variable sht_drivers to
>  __devinit/__devexit functions sht15_probe()/remove().
> 
>  We were warned by the following warnings:
> 
>   LD      drivers/hwmon/built-in.o
> WARNING: drivers/hwmon/built-in.o(.data+0x264a0): Section mismatch in
> reference from the variable sht_drivers to the function
> .devinit.text:sht15_probe()
> The variable sht_drivers references
> the function __devinit sht15_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> WARNING: drivers/hwmon/built-in.o(.data+0x264a4): Section mismatch in
> reference from the variable sht_drivers to the function
> .devexit.text:sht15_remove()
> The variable sht_drivers references
> the function __devexit sht15_remove()
> If the reference is valid then annotate the
> variable with __exit* (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> WARNING: drivers/hwmon/built-in.o(.data+0x264f0): Section mismatch in
> reference from the variable sht_drivers to the function
> .devinit.text:sht15_probe()
> The variable sht_drivers references
> the function __devinit sht15_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> WARNING: drivers/hwmon/built-in.o(.data+0x264f4): Section mismatch in
> reference from the variable sht_drivers to the function
> .devexit.text:sht15_remove()
> The variable sht_drivers references
> the function __devexit sht15_remove()
> If the reference is valid then annotate the
> variable with __exit* (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> WARNING: drivers/hwmon/built-in.o(.data+0x26540): Section mismatch in
> reference from the variable sht_drivers to the function
> .devinit.text:sht15_probe()
> The variable sht_drivers references
> the function __devinit sht15_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> WARNING: drivers/hwmon/built-in.o(.data+0x26544): Section mismatch in
> reference from the variable sht_drivers to the function
> .devexit.text:sht15_remove()
> The variable sht_drivers references
> the function __devexit sht15_remove()
> If the reference is valid then annotate the
> variable with __exit* (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> WARNING: drivers/hwmon/built-in.o(.data+0x26590): Section mismatch in
> reference from the variable sht_drivers to the function
> .devinit.text:sht15_probe()
> The variable sht_drivers references
> the function __devinit sht15_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
> 
> -------
> Signed-off-by: Rakib Mullick <rakib.mullick@gmail.com>
> 
> --- linus/drivers/hwmon/sht15.c	2009-09-22 16:28:07.000000000 +0600
> +++ rakib/drivers/hwmon/sht15.c	2009-09-23 14:47:48.000000000 +0600
> @@ -619,8 +619,12 @@ static int __devexit sht15_remove(struct
>  	return 0;
>  }
> 
> -
> -static struct platform_driver sht_drivers[] = {
> +/*
> + * sht_drivers simultaneously refers to __devinit and __devexit function
> + * which causes spurious section mismatch warning. So use __refdata to
> + * get rid from this.
> + */
> +static struct platform_driver __refdata sht_drivers[] = {
>  	{
>  		.driver = {
>  			.name = "sht10",

Looks sane, applied, thanks. Jonathan, no objection?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
