From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 08 May 2012 17:57:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: INA219 and INA226 support
Message-Id: <1336499839.22553.96.camel@groeck-laptop>
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

Ah, just found something else:

[ ... ]
> +       switch (data->kind) {
> +       case ina219:
> +               /* device configuration */
> +               ina2xx_write_word(client, INA2XX_CONFIG, INA219_CONFIG_DEFAULT);
> +
> +               /* set current LSB to 1mA, shunt is in uOhms */
> +               /* (equation 13 in datasheet) */
> +               ina2xx_write_word(client, INA2XX_CALIBRATION, (40960 / shunt));

shunt is now in uOhm, so I suspect the above is probably no longer
correct. Can you verify ?

> +               dev_info(&client->dev,
> +                       "power monitor INA219 (Rshunt = %li uOhm)\n", shunt);
> +               data->registers = INA219_REGISTERS;
> +               break;
> +       case ina226:
> +               /* device configuration */
> +               ina2xx_write_word(client, INA2XX_CONFIG, INA226_CONFIG_DEFAULT);
> +
> +               /* set current LSB to 1mA, shunt is in uOhms */
> +               /* (equation 1 in datasheet)*/
> +               ina2xx_write_word(client, INA2XX_CALIBRATION, (5120 / shunt));

Same here. With 10,000 uOhm default, the above doesn't really make sense
anymore, and should probably be something like
		5120000 / shunt

[ Oh, and the ( ) around the equation isn't needed ... ]

Please have a look and resubmit.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
