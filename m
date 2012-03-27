From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Mar 2012 07:08:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (f75375s) Fix warning message seen in some configurations
Message-Id: <20120327090807.4f39fb7a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332603907-18251-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1332603907-18251-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat, 24 Mar 2012 08:45:07 -0700, Guenter Roeck wrote:
> In some configurations, BUG() does not result in an endless loop but returns to
> the caller. This results in the following compiler warning:
> 
> drivers/hwmon/f75375s.c: In function 'duty_mode_enabled':
> drivers/hwmon/f75375s.c:280: warning: control reaches end of non-void function
> drivers/hwmon/f75375s.c: In function 'auto_mode_enabled':
> drivers/hwmon/f75375s.c:295: warning: control reaches end of non-void function
> 
> Fix the warning by returning something sensible after BUG().
> 
> Cc: Nikolaus Schulz <schulz@macnetix.de>
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/f75375s.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index 729499e..ece4159 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -276,6 +276,7 @@ static bool duty_mode_enabled(u8 pwm_enable)
>  		return false;
>  	default:
>  		BUG();
> +		return true;
>  	}
>  }
>  
> @@ -291,6 +292,7 @@ static bool auto_mode_enabled(u8 pwm_enable)
>  		return true;
>  	default:
>  		BUG();
> +		return false;
>  	}
>  }


Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
