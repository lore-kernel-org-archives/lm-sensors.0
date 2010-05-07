From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 07 May 2010 16:07:16 +0000
Subject: Re: [lm-sensors] [patch]hp_accel: Fix race in device removal
Message-Id: <20100507160716.GA1506@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <201005071804.20462.oneukum@suse.de>
In-Reply-To: <201005071804.20462.oneukum@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oliver Neukum <oneukum@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Eric Piel <eric.piel@tremplin-utc.net>, Pavel Herrmann <morpheus.ibis@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, stable@kernel.org

On Fri 2010-05-07 18:04:20, Oliver Neukum wrote:
> From 505056649f5ecb1ebb086981243b9870ce961a87 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver@neukum.org>
> Date: Fri, 7 May 2010 18:02:07 +0200
> Subject: [PATCH] hp_accel: Fix race in device removal
> 
> The work queue has to be flushed after the device has been made
> inaccessible.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>

ACK.
> ---
>  drivers/hwmon/hp_accel.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/hp_accel.c b/drivers/hwmon/hp_accel.c
> index c8ab505..7580f55 100644
> --- a/drivers/hwmon/hp_accel.c
> +++ b/drivers/hwmon/hp_accel.c
> @@ -328,8 +328,8 @@ static int lis3lv02d_remove(struct acpi_device *device, int type)
>  	lis3lv02d_joystick_disable();
>  	lis3lv02d_poweroff(&lis3_dev);
>  
> -	flush_work(&hpled_led.work);
>  	led_classdev_unregister(&hpled_led.led_classdev);
> +	flush_work(&hpled_led.work);
>  
>  	return lis3lv02d_remove_fs(&lis3_dev);
>  }

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
