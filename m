From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Date: Mon, 28 Apr 2008 08:31:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adt7473) Initialize
Message-Id: <fv421e$vjg$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080426163426.7684ce5d@hyperion.delvare>
In-Reply-To: <20080426163426.7684ce5d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> --- linux-2.6.26-rc0.orig/drivers/hwmon/adt7473.c	2008-04-26 15:36:41.000000000 +0200
> +++ linux-2.6.26-rc0/drivers/hwmon/adt7473.c	2008-04-26 16:15:05.000000000 +0200
> @@ -298,6 +298,9 @@ no_sensor_update:
>  						ADT7473_REG_PWM_BHVR(i));
>  	}
>  
> +	i = i2c_smbus_read_byte_data(client, ADT7473_REG_CFG4);
> +	data->max_duty_at_overheat = !!(i & ADT7473_CFG4_MAX_DUTY_AT_OVT);

Maybe it would be more understandable to use:
data->max_duty_at_overheat = (i & ADT7473_CFG4_MAX_DUTY_AT_OVT) ? 1 : 0;

Although I don't know if gcc optimizes both to the same instructions.

> +
>  	data->limits_last_updated = local_jiffies;
>  	data->limits_valid = 1;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
