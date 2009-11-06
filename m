From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 Nov 2009 13:15:42 +0000
Subject: Re: [lm-sensors] [patch 1/5] hwmon: Convert fschmd to unlocked_ioctl
Message-Id: <20091106141542.12404c5c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091015202722.372890083@linutronix.de>
	<20091015202758.400949170@linutronix.de>
In-Reply-To: <20091015202758.400949170@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lm-sensors@lm-sensors.org, Hans de Goede <hdegoede@redhat.com>

Hi Thomas,

Sorry for the late answer.

On Thu, 15 Oct 2009 20:28:31 -0000, Thomas Gleixner wrote:
> The conversion of fschmd watchdog ioctl to unlocked_ioctl needs to
> protect the static watchdog_info variable for the WDIOC_GETSUPPORT
> command.
> 
> All other commands are safe w/o BKL as the called watchdog functions
> are already serialized with watchdog_lock of the sensor.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: lm-sensors@lm-sensors.org
> ---
>  drivers/hwmon/fschmd.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6-tip/drivers/hwmon/fschmd.c
> =================================> --- linux-2.6-tip.orig/drivers/hwmon/fschmd.c
> +++ linux-2.6-tip/drivers/hwmon/fschmd.c
> @@ -844,8 +844,8 @@ static ssize_t watchdog_write(struct fil
>  	return count;
>  }
>  
> -static int watchdog_ioctl(struct inode *inode, struct file *filp,
> -	unsigned int cmd, unsigned long arg)
> +static long watchdog_ioctl(struct file *filp, unsigned int cmd,
> +			   unsigned long arg)
>  {
>  	static struct watchdog_info ident = {
>  		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
> @@ -857,11 +857,13 @@ static int watchdog_ioctl(struct inode *
>  
>  	switch (cmd) {
>  	case WDIOC_GETSUPPORT:
> +		mutex_lock(&watchdog_data_mutex);
>  		ident.firmware_version = data->revision;
>  		if (!nowayout)
>  			ident.options |= WDIOF_MAGICCLOSE;
>  		if (copy_to_user((void __user *)arg, &ident, sizeof(ident)))
>  			ret = -EFAULT;
> +		mutex_unlock(&watchdog_data_mutex);
>  		break;

I'm not sure why we need to hold the mutex here? My understanding is
that watchdog_data_mutex protects watchdog_data_list and each
watchdog's kref. And the above code doesn't touch either.

What I am more worried about is why ident is declared static. This
looks like a bug to me. Instead of abusing watchdog_data_mutex to
workaround this, I'd rather remove the "static". I guess that the
current code happens to work because neither data->revision nor
nowayout can change over time, but this looks needlessly fragile.

Hans, any comment?

>  
>  	case WDIOC_GETSTATUS:
> @@ -921,7 +923,7 @@ static const struct file_operations watc
>  	.open = watchdog_open,
>  	.release = watchdog_release,
>  	.write = watchdog_write,
> -	.ioctl = watchdog_ioctl,
> +	.unlocked_ioctl = watchdog_ioctl,
>  };

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
