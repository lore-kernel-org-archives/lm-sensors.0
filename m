From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jun 2008 18:13:44 +0000
Subject: Re: [lm-sensors] [PATCH] ad7414 missing id table
Message-Id: <20080613201344.5af0d488@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080613121324.19febc11@lappy.seanm.ca>
In-Reply-To: <20080613121324.19febc11@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 13 Jun 2008 12:13:24 -0400, Sean MacLennan wrote:
> The ad7414 driver is missing an id table.
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> ---
> Index: drivers/hwmon/ad7414.c
> =================================> --- drivers/hwmon/ad7414.c	(revision 12577)
> +++ drivers/hwmon/ad7414.c	(working copy)
> @@ -225,12 +225,18 @@
>  	return 0;
>  }
>  
> +static const struct i2c_device_id ad7414_id[] = {
> +	{ "ad7414", 0 },
> +	{}
> +};
> +
>  static struct i2c_driver ad7414_driver = {
>  	.driver = {
>  		.name	= "ad7414",
>  	},
>  	.probe	= ad7414_probe,
>  	.remove	= __devexit_p(ad7414_remove),
> +	.id_table = ad7414_id,
>  };
>  
>  static int __init ad7414_init(void)

Acked-by: Jean Delvare <khali@linux-fr.org>

(I have no idea what tree this patch is against though... there's no
ad7414 driver upstream nor in MMH's hwmon-testing tree.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
