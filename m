From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Sep 2010 15:14:43 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (adm1031) Replace update_rate
Message-Id: <20100916171443.0322bdb6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284602835-7605-1-git-send-email-guenter.roeck@ericsson.com>
	<1284602835-7605-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284602835-7605-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 15 Sep 2010 19:07:14 -0700, Guenter Roeck wrote:
> The attribute reflects an interval, not a rate.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/sysfs-interface |   12 +++++-----
>  drivers/hwmon/adm1031.c             |   43 +++++++++++++++++++---------------
>  2 files changed, 30 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index ff45d1f..df0cdd2 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -91,13 +91,13 @@ name		The chip name.
>  		I2C devices get this attribute created automatically.
>  		RO
>  
> -update_rate	The rate at which the chip will update readings.
> -		Unit: millisecond
> +update_interval	The interval at which the chip or driver will update readings.

I think I prefer the original wording. The attribute is really about
setting the register refresh rate at the hardware level. The fact that
register cache lifetime in the driver can be adjusted accordingly is an
optional implementation detail IMHO.

> +		Unit: milliseconds

Why change? All other units are singular in the file.

>  		RW
> -		Some devices have a variable update rate. This attribute
> -		can be used to change the update rate to the desired
> -		frequency.
> -

Killing an innocent blank line ;)

> +		Some devices have a variable update rate or interval.
> +		Some drivers may want to make the update interval configurable
> +		instead of using a hardcoded value. This attribute can be used
> +		to change the update interval to the desired value.
>  
>  ************
>  * Voltages *

I'm fine with all the rest.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
