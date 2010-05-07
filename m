From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 07 May 2010 15:54:01 +0000
Subject: Re: [lm-sensors] [patch]hp_accel: Fix race in device removal
Message-Id: <20100507175401.3099fdef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201005071747.40801.oneukum@suse.de>
In-Reply-To: <201005071747.40801.oneukum@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oliver Neukum <oneukum@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Eric Piel <eric.piel@tremplin-utc.net>, Pavel Herrmann <morpheus.ibis@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Pavel Machek <pavel@ucw.cz>, stable@kernel.org

Hi Oliver,

On Fri, 7 May 2010 17:47:40 +0200, Oliver Neukum wrote:
> From 64a9e0d8e585c65526248e6cf1659a13fb01a93a Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver@neukum.org>
> Date: Fri, 7 May 2010 17:41:59 +0200
> Subject: [PATCH] hp_accel: Fix race in device removal
> 
> The work queue has to be flushed after the device has been made
> inaccessible.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> ---
>  drivers/hwmon/hp_accel.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/hp_accel.c b/drivers/hwmon/hp_accel.c
> index c8ab505..6f6e05d 100644
> --- a/drivers/hwmon/hp_accel.c
> +++ b/drivers/hwmon/hp_accel.c
> @@ -328,9 +328,9 @@ static int lis3lv02d_remove(struct acpi_device *device, int type)
>  	lis3lv02d_joystick_disable();
>  	lis3lv02d_poweroff(&lis3_dev);
>  
> -	flush_work(&hpled_led.work);
>  	led_classdev_unregister(&hpled_led.led_classdev);
> -
> +	flush_work(&hpled_led.work);
> +	
>  	return lis3lv02d_remove_fs(&lis3_dev);
>  }
>  

You are adding trailing white space. Please don't. Use
scripts/checkpatch.pl to check your patches before you send them.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
