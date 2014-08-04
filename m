From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 04 Aug 2014 14:23:50 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] hwmon: (ads1015) Fix out-of-bounds array access
Message-Id: <53DF9776.2060005@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406960711.15669.1.camel@phoenix>
In-Reply-To: <1406960711.15669.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/01/2014 11:25 PM, Axel Lin wrote:
> Current code uses data_rate as array index in ads1015_read_adc() and uses pga
> as array index in ads1015_reg_to_mv, so we must make sure both data_rate and
> pga settings are in valid value range. Both "ti,gain" and "ti,datarate" are
> optional properties, so use default setting if the setting is out-of-range.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Excellent catch.

I don't like either solution, though. Returning -EINVAL in the error case seems
to be more appropriate and should be the expected response.

Guenter

> ---
>   drivers/hwmon/ads1015.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
> index 22e0c92..fe1a5a1 100644
> --- a/drivers/hwmon/ads1015.c
> +++ b/drivers/hwmon/ads1015.c
> @@ -212,6 +212,7 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
>   				dev_err(&client->dev,
>   					"invalid gain on %s\n",
>   					node->full_name);
> +				pga = ADS1015_DEFAULT_PGA;
>   			}
>   		}
>
> @@ -222,6 +223,7 @@ static int ads1015_get_channels_config_of(struct i2c_client *client)
>   				dev_err(&client->dev,
>   					"invalid data_rate on %s\n",
>   					node->full_name);
> +				data_rate = ADS1015_DEFAULT_DATA_RATE;
>   			}
>   		}
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
