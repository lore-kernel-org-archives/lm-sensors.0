From: Robert Coulson <robert.coulson@ericsson.com>
Date: Mon, 28 Nov 2011 23:18:20 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (pmbus/zl6100) Only instantiate
Message-Id: <C379E95F3359F140B21F5259C55CC83148CBF06E47@EUSAACMS0714.eamcs.ericsson.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1322076654-5652-5-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1322076654-5652-5-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 
> -----Original Message-----
> From: Guenter Roeck 
> Sent: Wednesday, November 23, 2011 11:31 AM
> To: Jean Delvare
> Cc: Robert Coulson; lm-sensors@lm-sensors.org; Guenter Roeck
> Subject: [PATCH 4/4] hwmon: (pmbus/zl6100) Only instantiate 
> external temperature sensor if enabled
> 
> BMR4xx devices don't have an external temperature sensor, and 
> instantiating it does not provide value anyway if it is disabled.
> Only instantiate it if it is enabled.
> 
> Also optimize wait time between I2C chip accesses in the 
> probe function, and replace unnecessary check for support for 
> I2C_FUNC_SMBUS_READ_BYTE_DATA with now required support for 
> I2C_FUNC_SMBUS_READ_WORD_DATA.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Reviewed-by: Robert Coulson <robert.coulson@ericsson.com>

> ---
>  drivers/hwmon/pmbus/zl6100.c |   19 ++++++++++++++-----
>  1 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/zl6100.c 
> b/drivers/hwmon/pmbus/zl6100.c index 7a72b6e..48c7b4a 100644
> --- a/drivers/hwmon/pmbus/zl6100.c
> +++ b/drivers/hwmon/pmbus/zl6100.c
> @@ -38,8 +38,11 @@ struct zl6100_data {
>  
>  #define to_zl6100_data(x)  container_of(x, struct zl6100_data, info)
>  
> +#define ZL6100_MFR_CONFIG		0xd0
>  #define ZL6100_DEVICE_ID		0xe4
>  
> +#define ZL6100_MFR_XTEMP_ENABLE		(1 << 7)
> +
>  #define ZL6100_WAIT_TIME		1000	/* uS	*/
>  
>  static ushort delay = ZL6100_WAIT_TIME; @@ -162,7 +165,7 @@ 
> static int zl6100_probe(struct i2c_client *client,
>  	const struct i2c_device_id *mid;
>  
>  	if (!i2c_check_functionality(client->adapter,
> -				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> +				     I2C_FUNC_SMBUS_READ_WORD_DATA
>  				     | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
>  		return -ENODEV;
>  
> @@ -210,12 +213,9 @@ static int zl6100_probe(struct 
> i2c_client *client,
>  	/*
>  	 * Since there was a direct I2C device access above, wait before
>  	 * accessing the chip again.
> -	 * Set the timestamp, wait, then set it again. This 
> should provide
> -	 * enough buffer time to be safe.
>  	 */
>  	data->access = ktime_get();
>  	zl6100_wait(data);
> -	data->access = ktime_get();
>  
>  	info = &data->info;
>  
> @@ -223,7 +223,16 @@ static int zl6100_probe(struct 
> i2c_client *client,
>  	info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
>  	  | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
>  	  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> -	  | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
> +	  | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
> +
> +	ret = i2c_smbus_read_word_data(client, ZL6100_MFR_CONFIG);
> +	if (ret < 0)
> +		goto err_mem;
> +	if (ret & ZL6100_MFR_XTEMP_ENABLE)
> +		info->func[0] |= PMBUS_HAVE_TEMP2;
> +
> +	data->access = ktime_get();
> +	zl6100_wait(data);
>  
>  	info->read_word_data = zl6100_read_word_data;
>  	info->read_byte_data = zl6100_read_byte_data;
> --
> 1.7.3.1
> 
> 
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
