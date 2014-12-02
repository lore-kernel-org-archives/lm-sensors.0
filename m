From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 02 Dec 2014 11:39:55 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] hwmon: (lm95245) Add support for LM95235
Message-Id: <20141202123955.630b69b1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417383473-10328-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1417383473-10328-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun, 30 Nov 2014 13:37:52 -0800, Guenter Roeck wrote:
> LM95235 is register compatible to LM95245.
> 
> Also update link to LM95245 data sheet, and drop the link to the
> datasheet from the driver source to simplify code maintenance.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Drop link to datasheet from driver source.
>     Drop DEVNAME.
>     Update MODULE_DESCRIPTION.
>     Use the same driver_data values for supported chips
>     since the field is not used by the driver.
> 
>  Documentation/hwmon/lm95245 | 14 +++++++++-----
>  drivers/hwmon/Kconfig       |  5 +++--
>  drivers/hwmon/lm95245.c     | 41 +++++++++++++++++++++++++++--------------
>  3 files changed, 39 insertions(+), 21 deletions(-)
> (...)
> diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
> index 0ae0dfd..0680669 100644
> --- a/drivers/hwmon/lm95245.c
> +++ b/drivers/hwmon/lm95245.c
> (...)
> @@ -427,17 +424,32 @@ static int lm95245_detect(struct i2c_client *new_client,
>  			  struct i2c_board_info *info)
>  {
>  	struct i2c_adapter *adapter = new_client->adapter;
> +	int address = new_client->addr;
> +	const char *name;
> +	int rev, id;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	if (i2c_smbus_read_byte_data(new_client, LM95245_REG_R_MAN_ID)
> -			!= MANUFACTURER_ID
> -		|| i2c_smbus_read_byte_data(new_client, LM95245_REG_R_CHIP_ID)
> -			!= DEFAULT_REVISION)
> +	id = i2c_smbus_read_byte_data(new_client, LM95245_REG_R_MAN_ID);
> +	if (id != MANUFACTURER_ID)
>  		return -ENODEV;
>  
> -	strlcpy(info->type, DEVNAME, I2C_NAME_SIZE);
> +	rev = i2c_smbus_read_byte_data(new_client, LM95245_REG_R_CHIP_ID);
> +	switch(rev) {

Missing space before opening parenthesis, checkpatch complains about
it. Your original patch had it right, not sure what happened?

Everything else looks OK, so:

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
