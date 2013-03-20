From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 20 Mar 2013 23:44:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Move the IIO client driver for hwmon out of staging
Message-Id: <20130320234405.GA29172@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1363818079-31470-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1363818079-31470-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lm-sensors@lm-sensors.org, khali@linux-fr.org

On Wed, Mar 20, 2013 at 10:21:19PM +0000, Jonathan Cameron wrote:
> This driver uses channel maps, defined either through device tree
> or platform data, to create a hwmon driver which acts as a client
> for the underlying IIO device channels.  Thus a general purpose
> IIO adc driver can be used to provide hardware monitoring using a subset
> of its channels.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> cc: Guenter Roeck <linux@roeck-us.net>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> 
> --
>  The only non move changes here concern the description and changes to the
>  dependencies to IIO explicit and hwmon implicit.
> 
>  I'm proposing moving this into hwmon on the basis of placing drivers
>  based on what they provide rather than what their underlying hardware
>  is.
> 
That is what I would suggest as well.

I assume you will take this through the iio tree, as it depends
on my previous patch, correct ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
