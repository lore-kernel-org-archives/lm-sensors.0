From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 04 Jan 2011 21:08:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (via686a) Initialize fan_div values
Message-Id: <1294175319.9786.53.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110104215911.64ec2815@endymion.delvare>
In-Reply-To: <20110104215911.64ec2815@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-01-04 at 15:59 -0500, Jean Delvare wrote:
> Functions set_fan_min() and set_fan_div() assume that the fan_div
> values have already been read from the register. The driver currently
> doesn't initialize them at load time, they are only set when function
> via686a_update_device() is called. This means that set_fan_min() and
> set_fan_div() misbehave if, for example, "sensors -s" is called
> before any monitoring application (e.g. "sensors") is has been run.
> 
> Fix the problem by always initializing the fan_div values at device
> bind time.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: stable@kernel.org

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

> ---
>  drivers/hwmon/via686a.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.37-rc8.orig/drivers/hwmon/via686a.c	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.37-rc8/drivers/hwmon/via686a.c	2011-01-04 21:51:52.000000000 +0100
> @@ -687,6 +687,13 @@ static int __devexit via686a_remove(stru
>  	return 0;
>  }
>  
> +static void via686a_update_fan_div(struct via686a_data *data)
> +{
> +	int reg = via686a_read_value(data, VIA686A_REG_FANDIV);
> +	data->fan_div[0] = (reg >> 4) & 0x03;
> +	data->fan_div[1] = reg >> 6;
> +}
> +
>  static void __devinit via686a_init_device(struct via686a_data *data)
>  {
>  	u8 reg;
> @@ -700,6 +707,9 @@ static void __devinit via686a_init_devic
>  	via686a_write_value(data, VIA686A_REG_TEMP_MODE,
>  			    (reg & ~VIA686A_TEMP_MODE_MASK)
>  			    | VIA686A_TEMP_MODE_CONTINUOUS);
> +
> +	/* Pre-read fan clock divisor values */
> +	via686a_update_fan_div(data);
>  }
>  
>  static struct via686a_data *via686a_update_device(struct device *dev)
> @@ -751,9 +761,7 @@ static struct via686a_data *via686a_upda
>  		    (via686a_read_value(data, VIA686A_REG_TEMP_LOW23) &
>  		     0xc0) >> 6;
>  
> -		i = via686a_read_value(data, VIA686A_REG_FANDIV);
> -		data->fan_div[0] = (i >> 4) & 0x03;
> -		data->fan_div[1] = i >> 6;
> +		via686a_update_fan_div(data);
>  		data->alarms >  		    via686a_read_value(data,
>  				       VIA686A_REG_ALARM1) |
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
