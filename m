From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 08 May 2012 17:49:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: INA219 and INA226 support
Message-Id: <1336499345.22553.92.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <28DAD847AEFDD344B2D3802E7670BEE116AD804E@DNCE04.ent.ti.com>
In-Reply-To: <28DAD847AEFDD344B2D3802E7670BEE116AD804E@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-05-08 at 13:43 -0400, Felten, Lothar wrote:
> Hello,
> 
> This patch brings support for the Texas Instruments INA219 and INA226 power monitors.
> 
> Signed-off-by: Lothar Felten <l-felten@ti.com>

Hi Lothar,

couple of minors. See inline. No need to resubmit, I already took care
of it.

> --
> diff -uprN linux-3.3.4/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
> --- linux-3.3.4/Documentation/hwmon/ina2xx      1970-01-01 01:00:00.000000000 +0100
> +++ b/Documentation/hwmon/ina2xx        2012-05-07 15:27:56.142307748 +0200
> @@ -0,0 +1,29 @@
> +Kernel driver ina2xx
> +==========
> +
> +Supported chips:
> +  * Texas Instruments INA219
> +    Prefix: 'ina219'
> +    Addresses: I2C 0x40 - 0x4f
> +    Datasheet: Publicly available at the Texas Instruments website
> +               http://www.ti.com/
> +
> +  * Texas Instruments INA226
> +    Prefix: 'ina226'
> +    Addresses: I2C 0x40 - 0x4f
> +    Datasheet: Publicly available at the Texas Instruments website
> +               http://www.ti.com/
> +
> +Author: Lothar Felten <l-felten@ti.com>
> +
> +Description
> +-----------
> +
> +The INA219 is a high-side current shunt and power monitor with an I2C
> +interface. The INA219 monitors both shunt drop and supply voltage, with
> +programmable conversion times and filtering.
> +
> +The INA226 is a current shunt and power monitor with an I2C interface.
> +The INA226 monitors both a shunt voltage drop and bus supply voltage.
> +
> +The shunt value in milliohms can be set via the kernel config.

No longer true; via platform data and micro-ohm.

> diff -uprN linux-3.3.4/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> --- linux-3.3.4/drivers/hwmon/ina2xx.c  1970-01-01 01:00:00.000000000 +0100
> +++ b/drivers/hwmon/ina2xx.c    2012-05-08 19:02:26.305202216 +0200
> @@ -0,0 +1,369 @@

[ ... ] 

> +
> +static const struct i2c_device_id ina2xx_id[] = {
> +       { "ina219", ina219 },
> +       { "ina226", ina226 },
> +       { }
> +}

I get a compile error here, due to the missing semicolon above. Wonder
why you don't see it. Did you compile it into the kernel (ie not as
module) ? That might explain it.

> +MODULE_DEVICE_TABLE(i2c, ina2xx_id);
> +
> +

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
