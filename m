From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 18 Jun 2013 15:53:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ina2xx) Add device tree support to pass the shunt resistor
Message-Id: <20130618155350.GA9554@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[ resending with copy to lm-sensors mailing list ]

On Tue, Jun 18, 2013 at 03:42:26PM +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <yuantian.tang@freescale.com>
> 
> Adding another way that is device tree to pass the shunt resistor
> value to driver except for platform data.
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
>  Documentation/hwmon/ina2xx | 3 ++-
>  drivers/hwmon/ina2xx.c     | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
> index 03444f9..6fb8b76 100644
> --- a/Documentation/hwmon/ina2xx
> +++ b/Documentation/hwmon/ina2xx
> @@ -44,4 +44,5 @@ The INA226 monitors both a shunt voltage drop and bus supply voltage.
>  The INA230 is a high or low side current shunt and power monitor with an I2C
>  interface. The INA230 monitors both a shunt voltage drop and bus supply voltage.
>  
> -The shunt value in micro-ohms can be set via platform data.
> +The shunt value in micro-ohms can be set via platform data or dts in which
> +the property should be shunt-resistor-value.
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index 4958b2f..ae2d27a 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -221,6 +221,7 @@ static int ina2xx_probe(struct i2c_client *client,
>  	struct ina2xx_data *data;
>  	struct ina2xx_platform_data *pdata;
>  	int ret;
> +	u32 val;
>  	long shunt = 10000; /* default shunt value 10mOhms */
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
> @@ -234,6 +235,11 @@ static int ina2xx_probe(struct i2c_client *client,
>  		pdata >  		  (struct ina2xx_platform_data *)client->dev.platform_data;
>  		shunt = pdata->shunt_uohms;
> +	} else if (client->dev.of_node) {
> +		ret = of_property_read_u32(client->dev.of_node,
> +				"shunt-resistor-value", &val);

Please use "shunt-resistor"; this is what is used in the ina209 driver.
Also, you don't have to check if client->dev.of_node is set;
of_property_read_u32 does it for you. So you can simplify the code to

	} else if (!of_property_read_u32(client->dev.of_node, "shunt-resistor",
					&val) {
		shunt = val;
	}

You should also add Documentation/devicetree/bindings/i2c/ina2xx.txt and update 
Documentation/hwmon/ina2xx.

Thanks,
Guenter

> +		if (ret = 0)
> +			shunt = val;
>  	}
>  
>  	if (shunt <= 0)
> -- 
> 1.8.0

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
