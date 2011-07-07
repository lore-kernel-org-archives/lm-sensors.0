From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jul 2011 09:48:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm95241) Add support for LM95231
Message-Id: <20110707114812.1d06fa40@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310002567-9905-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1310002567-9905-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Jul 2011 18:36:07 -0700, Guenter Roeck wrote:
> LM95231 is fully compatible to LM95241; only necessary change is to add
> chip detection.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/lm95241.c |   26 +++++++++++++++++++-------
>  1 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
> index d1bbdf8..94a8f3c 100644
> --- a/drivers/hwmon/lm95241.c
> +++ b/drivers/hwmon/lm95241.c
> @@ -75,7 +75,8 @@ static const unsigned short normal_i2c[] = {
>  #define TT_ON 1
>  #define TT_MASK 7
>  #define MANUFACTURER_ID 0x01
> -#define DEFAULT_REVISION 0xA4
> +#define LM95231_CHIP_ID	0xA1
> +#define LM95241_CHIP_ID	0xA4
>  
>  static const u8 lm95241_reg_address[] = {
>  	LM95241_REG_R_LOCAL_TEMPH,
> @@ -331,17 +332,27 @@ static int lm95241_detect(struct i2c_client *new_client,
>  {
>  	struct i2c_adapter *adapter = new_client->adapter;
>  	const char *name;
> +	int mfg_id;
> +	int chip_id;

Nitpicking: fits nicely on a single line.

>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	if (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
> -	    != MANUFACTURER_ID
> -	    || i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
> -	    != DEFAULT_REVISION)
> +	mfg_id = i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID);
> +	if (mfg_id != MANUFACTURER_ID)
>  		return -ENODEV;
>  
> -	name = DEVNAME;
> +	chip_id = i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID);
> +	switch (chip_id) {
> +	case LM95231_CHIP_ID:
> +		name = "lm95231";
> +		break;
> +	case LM95241_CHIP_ID:
> +		name = "lm95241";
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
>  
>  	strlcpy(info->type, name, I2C_NAME_SIZE);
>  	return 0;
> @@ -418,7 +429,8 @@ static int lm95241_remove(struct i2c_client *client)
>  
>  /* Driver data (common to all clients) */
>  static const struct i2c_device_id lm95241_id[] = {
> -	{ DEVNAME, 0 },
> +	{ "lm95231", 0 },
> +	{ "lm95241", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, lm95241_id);

Looks very good:

Acked-by: Jean Delvare <khali@linux-fr.org>

An update to drivers/hwmon/Kconfig would be welcome though.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
