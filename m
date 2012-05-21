From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 21 May 2012 16:44:23 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: INA219 and INA226 support
Message-Id: <1337618663.22553.357.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <28DAD847AEFDD344B2D3802E7670BEE116AD804E@DNCE04.ent.ti.com>
In-Reply-To: <28DAD847AEFDD344B2D3802E7670BEE116AD804E@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lothar,

On Tue, 2012-05-08 at 13:43 -0400, Felten, Lothar wrote:
> Hello,
> 
> This patch brings support for the Texas Instruments INA219 and INA226 power monitors.
> 
I have a couple of observations.

[ ... ]

> diff -uprN linux-3.3.4/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> --- linux-3.3.4/drivers/hwmon/ina2xx.c  1970-01-01 01:00:00.000000000 +0100
> +++ b/drivers/hwmon/ina2xx.c    2012-05-08 19:02:26.305202216 +0200

[ ... ]
> +
> +/* settings - depend on use case */
> +#define INA219_CONFIG_DEFAULT          0x219F  /* PGA=1 */
> +#define INA226_CONFIG_DEFAULT          0x4527  /* averages */
> +

With this configuration (PGA=1), the dynamic range for the shunt
resistor voltage is 40 mV. Since we report the value in mV, it does not
provide much value to do that. It might be better to use PGA=8 instead,
for a dynamic range of 320 mV.

Did you have a special reason for selecting PGA=1 ? Otherwise, I think
we should change it to PGA=8.

[ ... ]

> +
> +       if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +               return -ENODEV;
> +

This is actually wrong; we need to check for I2C_FUNC_SMBUS_WORD_DATA
instead. I fixed that already.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
