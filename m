From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 09 Dec 2008 19:00:25 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Fix various typos
Message-Id: <493EC049.9040503@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081209163734.683475cf@hyperion.delvare>
In-Reply-To: <20081209163734.683475cf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  Documentation/hwmon/lm85  |    2 +-
>  drivers/hwmon/it87.c      |    2 +-
>  drivers/hwmon/w83627ehf.c |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Looks good to me :)

Regards,

Hans

> --- linux-2.6.28-rc7.orig/drivers/hwmon/w83627ehf.c	2008-12-05 23:58:15.000000000 +0100
> +++ linux-2.6.28-rc7/drivers/hwmon/w83627ehf.c	2008-12-08 10:48:34.000000000 +0100
> @@ -503,7 +503,7 @@ static struct w83627ehf_data *w83627ehf_
>  		}
>  
>  		for (i = 0; i < 4; i++) {
> -			/* pwmcfg, tolarance mapped for i=0, i=1 to same reg */
> +			/* pwmcfg, tolerance mapped for i=0, i=1 to same reg */
>  			if (i != 1) {
>  				pwmcfg = w83627ehf_read_value(data,
>  						W83627EHF_REG_PWM_ENABLE[i]);
> --- linux-2.6.28-rc7.orig/Documentation/hwmon/lm85	2008-10-24 09:27:31.000000000 +0200
> +++ linux-2.6.28-rc7/Documentation/hwmon/lm85	2008-12-08 10:48:34.000000000 +0100
> @@ -164,7 +164,7 @@ configured individually according to the
>                        temperature. (PWM value from 0 to 255)
>  
>  * pwm#_auto_pwm_minctl - this flags selects for temp#_auto_temp_off temperature
> -                         the bahaviour of fans. Write 1 to let fans spinning at
> +                         the behaviour of fans. Write 1 to let fans spinning at
>  			 pwm#_auto_pwm_min or write 0 to let them off.
>  
>  NOTE: It has been reported that there is a bug in the LM85 that causes the flag
> --- linux-2.6.28-rc7.orig/drivers/hwmon/it87.c	2008-12-05 23:58:15.000000000 +0100
> +++ linux-2.6.28-rc7/drivers/hwmon/it87.c	2008-12-08 10:48:49.000000000 +0100
> @@ -1386,7 +1386,7 @@ static void __devinit it87_init_device(s
>  			it87_write_value(data, IT87_REG_TEMP_HIGH(i), 127);
>  	}
>  
> -	/* Check if temperature channnels are reset manually or by some reason */
> +	/* Check if temperature channels are reset manually or by some reason */
>  	tmp = it87_read_value(data, IT87_REG_TEMP_ENABLE);
>  	if ((tmp & 0x3f) = 0) {
>  		/* Temp1,Temp3=thermistor; Temp2=thermal diode */
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
