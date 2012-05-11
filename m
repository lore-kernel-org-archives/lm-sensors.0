From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 May 2012 21:07:59 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (it87) Make temp3 attribute conditional for IT8782F
Message-Id: <20120511230759.53781061@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336751383-3480-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1336751383-3480-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 11 May 2012 08:49:43 -0700, Guenter Roeck wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> On IT8782F, temp3 is only supported if UART6 is disabled.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: Resolve conflicts with previous patches.
>     Only remove temp sysfs attributes if the to-be-removed sensor exists,
>     to be in sync with the other attribute removal code.
> v2: Drop condition for IT8783F. On that chip, UART6 may be routed via JP4 to
>     a different set of pins, so we can not reliably detect if temp3 and RI6
>     overlap or not. 
> 
>  drivers/hwmon/it87.c |   79 +++++++++++++++++++++++++++++++++++++------------
>  1 files changed, 59 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index 88771a5..1385320 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> (...)
> @@ -2016,6 +2040,11 @@ static int __devinit it87_probe(struct platform_device *pdev)
>  			data->in_scaled |= (1 << 7);	/* in7 is VCCH5V */
>  	}
>  
> +	data->has_temp = 0x07;
> +	if (sio_data->skip_temp &&
> +	    !(it87_read_value(data, IT87_REG_TEMP_EXTRA) & 0x80))
> +		data->has_temp &= ~sio_data->skip_temp;

I don't like this. Right now it works because temp3 is the only input
that can be disabled. If there ever is another then it will break and
we may not notice. IMHO it should look more like:

	if ((sio_data->skip_temp & (1 << 2)) &&
	    !(it87_read_value(data, IT87_REG_TEMP_EXTRA) & 0x80))
		data->has_temp &= ~(1 << 2);

I would also suggest an additional test on chip type. Right now the
IT8782F is the only one setting sio_data->skip_temp but that might
change in the future.

All the rest looks good. If you agree with the propose changes, you can
add:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
