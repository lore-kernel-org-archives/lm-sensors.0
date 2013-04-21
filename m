From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Apr 2013 09:35:03 +0000
Subject: Re: [lm-sensors] [PATCH v3 4/4] hwmon: (tmp401) Add support for TMP432
Message-Id: <20130421113503.64e92bf7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1366478293-8167-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1366478293-8167-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 20 Apr 2013 10:18:13 -0700, Guenter Roeck wrote:
> TMP432 is similar to TMP431 with a second external temperature sensor.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: Add array entry for write critical temp register MSB
>     (no idea how that got lost)
> 
> v2: Fixed spelling error in commit log
>     Improved documentation
> 
>  Documentation/hwmon/tmp401 |   11 ++-
>  drivers/hwmon/tmp401.c     |  184 +++++++++++++++++++++++++++++++++++---------
>  2 files changed, 156 insertions(+), 39 deletions(-)

Please also update drivers/hwmon/Kconfig.

> 
> diff --git a/Documentation/hwmon/tmp401 b/Documentation/hwmon/tmp401
> index 12e4781..79f957e 100644
> --- a/Documentation/hwmon/tmp401
> +++ b/Documentation/hwmon/tmp401
> @@ -14,6 +14,10 @@ Supported chips:
>      Prefix: 'tmp431'
>      Addresses scanned: I2C 0x4c, 0x4d
>      Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp431.html
> +  * Texas Instruments TMP432
> +    Prefix: 'tmp432'
> +    Addresses scanned: I2C 0x4c, 0x4d
> +    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp432.html
>  
>  Authors:
>           Hans de Goede <hdegoede@redhat.com>
> @@ -23,8 +27,8 @@ Description
>  -----------
>  
>  This driver implements support for Texas Instruments TMP401, TMP411,
> -and TMP431 chips. These chips implement one remote and one local
> -temperature sensor. Temperature is measured in degrees
> +TMP431, and TMP432 chips. These chips implement one or two remote and
> +one local temperature sensor. Temperature is measured in degrees

Shouldn't it be "sensors", plural?

>  Celsius. Resolution of the remote sensor is 0.0625 degree. Local
>  sensor resolution can be set to 0.5, 0.25, 0.125 or 0.0625 degree (not
>  supported by the driver so far, so using the default resolution of 0.5
> @@ -44,3 +48,6 @@ some additional features.
>  
>    Exported via sysfs attribute temp_reset_history. Writing 1 to this
>    file triggers a reset.
> +
> +TMP432 is compatible with TMP401 and TMP431. It supports two external
> +temperature sensors.
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index fa6af51..32abda1 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -43,7 +43,7 @@
>  /* Addresses to scan */
>  static const unsigned short normal_i2c[] = { 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
>  
> -enum chips { tmp401, tmp411, tmp431 };
> +enum chips { tmp401, tmp411, tmp431, tmp432 };
>  
>  /*
>   * The TMP401 registers, note some registers have different addresses for
> @@ -85,6 +85,30 @@ static const u8 TMP401_TEMP_LSB[6][2] = {
>  	{ 0x33, 0x37 },	/* highest */
>  };
>  
> +static const u8 TMP432_TEMP_MSB_READ[4][3] = {
> +	{ 0x00, 0x01, 0x23 },	/* temp */
> +	{ 0x06, 0x08, 0x16 },	/* low limit */
> +	{ 0x05, 0x07, 0x15 },	/* high limit */
> +	{ 0x20, 0x19, 0x1A },	/* therm (crit) limit */
> +};
> +
> +static const u8 TMP432_TEMP_MSB_WRITE[4][3] = {
> +	{ 0, 0, 0 },		/* temp  - unused */
> +	{ 0x0C, 0x0E, 0x16 },	/* low limit */
> +	{ 0x0B, 0x0D, 0x15 },	/* high limit */
> +	{ 0x20, 0x19, 0x1A },	/* therm (crit) limit */
> +};
> +
> +static const u8 TMP432_TEMP_LSB[3][3] = {
> +	{ 0x29, 0x10, 0x24 },	/* temp */
> +	{ 0x3E, 0x14, 0x18 },	/* low limit */
> +	{ 0x3D, 0x13, 0x17 },	/* high limit */
> +};

TI engineers are idiots :( How hard was it to make both register maps
compatible, really?

> +
> +/* [0] = fault, [1] = low, [2] = high, [3] = therm/crit */
> +static const u8 TMP432_STATUS_REG[] = {
> +	0x1b, 0x36, 0x35, 0x37 };
> +

TMP401_STATUS vs. TMP432_STATUS_REG is a bit inconsistent. But well,
the current naming scheme is inconsistent already so I suppose it
no longer matters.

>  /* Flags */
>  #define TMP401_CONFIG_RANGE			BIT(2)
>  #define TMP401_CONFIG_SHUTDOWN			BIT(6)
> @@ -96,6 +120,11 @@ static const u8 TMP401_TEMP_LSB[6][2] = {
>  #define TMP401_STATUS_LOCAL_LOW			BIT(5)
>  #define TMP401_STATUS_LOCAL_HIGH		BIT(6)
>  
> +/* On TMP432, each status has its own register */
> +#define TMP432_STATUS_LOCAL			BIT(0)
> +#define TMP432_STATUS_REMOTE1			BIT(1)
> +#define TMP432_STATUS_REMOTE2			BIT(2)

These are not strictly needed. Given that they match the driver's
internal order, you could just pass 0, 1 and 2 as you do for every
other attribute and use BIT() in the function itself as needed.

But well, I'm just thinking out loud, your code is fine so up to you.

> +
>  /* Manufacturer / Device ID's */
>  #define TMP401_MANUFACTURER_ID			0x55
>  #define TMP401_DEVICE_ID			0x11
> @@ -103,6 +132,7 @@ static const u8 TMP401_TEMP_LSB[6][2] = {
>  #define TMP411B_DEVICE_ID			0x13
>  #define TMP411C_DEVICE_ID			0x10
>  #define TMP431_DEVICE_ID			0x31
> +#define TMP432_DEVICE_ID			0x32
>  
>  /*
>   * Driver data (common to all clients)
> @@ -112,6 +142,7 @@ static const struct i2c_device_id tmp401_id[] = {
>  	{ "tmp401", tmp401 },
>  	{ "tmp411", tmp411 },
>  	{ "tmp431", tmp431 },
> +	{ "tmp432", tmp432 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, tmp401_id);
> @@ -130,9 +161,9 @@ struct tmp401_data {
>  	unsigned int update_interval;	/* in milliseconds */
>  
>  	/* register values */
> -	u8 status;
> +	u8 status[4];
>  	u8 config;
> -	u16 temp[6][2];
> +	u16 temp[6][3];
>  	u8 temp_crit_hyst;
>  };
>  
> @@ -166,22 +197,26 @@ static int tmp401_update_device_reg16(struct i2c_client *client,
>  {
>  	int i, j, val;
>  	int num_regs = data->kind = tmp411 ? 6 : 4;
> +	int num_sensors = data->kind = tmp432 ? 3 : 2;
>  
> -	for (i = 0; i < 2; i++) {			/* local / rem1 */
> +	for (i = 0; i < num_sensors; i++) {		/* local / rem1 */

You could add " / rem2" or " / ..." at the end of the comment.

>  		for (j = 0; j < num_regs; j++) {	/* temp / low / ... */
> +			u8 reg;

For consistency with the rest of the code, this variable should be
named regaddr.

>  			/*
>  			 * High byte must be read first immediately followed
>  			 * by the low byte
>  			 */
> -			val = i2c_smbus_read_byte_data(client,
> -						TMP401_TEMP_MSB_READ[j][i]);
> +			reg = data->kind = tmp432 ? TMP432_TEMP_MSB_READ[j][i]
> +						   : TMP401_TEMP_MSB_READ[j][i];
> +			val = i2c_smbus_read_byte_data(client, reg);
>  			if (val < 0)
>  				return val;
>  			data->temp[j][i] = val << 8;
>  			if (j = 3)		/* crit is msb only */
>  				continue;
> -			val = i2c_smbus_read_byte_data(client,
> -						TMP401_TEMP_LSB[j][i]);
> +			reg = data->kind = tmp432 ? TMP432_TEMP_LSB[j][i]
> +						   : TMP401_TEMP_LSB[j][i];
> +			val = i2c_smbus_read_byte_data(client, reg);
>  			if (val < 0)
>  				return val;
>  			data->temp[j][i] |= val;
> @@ -195,7 +230,7 @@ static struct tmp401_data *tmp401_update_device(struct device *dev)
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct tmp401_data *data = i2c_get_clientdata(client);
>  	struct tmp401_data *ret = data;
> -	int val;
> +	int i, val;
>  	unsigned long next_update;
>  
>  	mutex_lock(&data->update_lock);
> @@ -203,12 +238,34 @@ static struct tmp401_data *tmp401_update_device(struct device *dev)
>  	next_update = data->last_updated +
>  		      msecs_to_jiffies(data->update_interval) + 1;
>  	if (time_after(jiffies, next_update) || !data->valid) {
> -		val = i2c_smbus_read_byte_data(client, TMP401_STATUS);
> -		if (val < 0) {
> -			ret = ERR_PTR(val);
> -			goto abort;
> +		if (data->kind != tmp432) {

Maybe add a comment explaining that the driver uses the TMP432 status
format internally and for other chips you have to dispatch the bits to
a similar format?

> +			val = i2c_smbus_read_byte_data(client, TMP401_STATUS);
> +			if (val < 0) {
> +				ret = ERR_PTR(val);
> +				goto abort;
> +			}
> +			data->status[0] > +			  (val & TMP401_STATUS_REMOTE_OPEN) >> 1;
> +			data->status[1] > +			  ((val & TMP401_STATUS_REMOTE_LOW) >> 2) |
> +			  ((val & TMP401_STATUS_LOCAL_LOW) >> 5);
> +			data->status[2] > +			  ((val & TMP401_STATUS_REMOTE_HIGH) >> 3) |
> +			  ((val & TMP401_STATUS_LOCAL_HIGH) >> 6);
> +			data->status[3] = val & (TMP401_STATUS_LOCAL_CRIT
> +						| TMP401_STATUS_REMOTE_CRIT);
> +		} else {
> +			for (i = 0; i < ARRAY_SIZE(data->status); i++) {
> +				val = i2c_smbus_read_byte_data(client,
> +							TMP432_STATUS_REG[i]);
> +				if (val < 0) {
> +					ret = ERR_PTR(val);
> +					goto abort;
> +				}
> +				data->status[i] = val;
> +			}
>  		}
> -		data->status = val;
> +
>  		val = i2c_smbus_read_byte_data(client, TMP401_CONFIG_READ);
>  		if (val < 0) {
>  			ret = ERR_PTR(val);

All the rest looks good.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
