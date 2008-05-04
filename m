From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 May 2008 12:27:58 +0000
Subject: Re: [lm-sensors] [patch 2.6.26-rc1] lm75: sensor reading bugfix
Message-Id: <20080504142758.0112cd7c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805031919.17110.david-b@pacbell.net>
In-Reply-To: <200805031919.17110.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 3 May 2008 19:19:16 -0700, David Brownell wrote:
> LM75 sensor reading bugfix: never save error status as valid
> sensor output.  This could be improved, but at least this
> prevents certain rude failure modes.

I agree this needs fixing, especially with the error value cleanup
patches you've sent for the i2c stack lately. While -1 swabs to itself,
other error values may look like real temperatures once swabbed.

> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> Goes on top of the previously submitted lm75 cleanup patch:
> 
> 	http://marc.info/?l=lm-sensors&m0880547009929&w=2
> 
>  drivers/hwmon/lm75.c |   20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> --- g26.orig/drivers/hwmon/lm75.c	2008-05-03 18:44:59.000000000 -0700
> +++ g26/drivers/hwmon/lm75.c	2008-05-03 19:03:08.000000000 -0700
> @@ -259,10 +259,13 @@ static struct i2c_driver lm75_driver = {
>     the SMBus standard. */
>  static int lm75_read_value(struct i2c_client *client, u8 reg)
>  {
> +	int value;
> +
>  	if (reg = LM75_REG_CONF)
>  		return i2c_smbus_read_byte_data(client, reg);
> -	else
> -		return swab16(i2c_smbus_read_word_data(client, reg));
> +
> +	value = i2c_smbus_read_word_data(client, reg);
> +	return (value < 0) ? value : swab16(value);
>  }
>  
>  static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value)
> @@ -295,9 +298,16 @@ static struct lm75_data *lm75_update_dev
>  		int i;
>  		dev_dbg(&client->dev, "Starting lm75 update\n");
>  
> -		for (i = 0; i < ARRAY_SIZE(data->temp); i++)
> -			data->temp[i] = lm75_read_value(client,
> -							LM75_REG_TEMP[i]);
> +		for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
> +			int status;
> +
> +			status = lm75_read_value(client, LM75_REG_TEMP[i]);
> +			if (status < 0)
> +				dev_dbg(&client->dev, "reg %d, err %d\n",
> +						LM75_REG_TEMP[i], status);
> +			else
> +				data->temp[i] = status;
> +		}
>  		data->last_updated = jiffies;
>  		data->valid = 1;
>  	}

Looks good, tested OK (i.e. no regression in the working case.)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
