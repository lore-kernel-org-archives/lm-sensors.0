From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 23 Jun 2011 14:15:11 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] HWMON: TMP102 - Added support for 12
Message-Id: <20110623161511.4efc5915@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ankur,

Moving to the lm-sensors list, as already requested once.

On Wed, 22 Jun 2011 09:58:52 +0530, Ankur Patel wrote:
> From: Ankur Patel <ankur.patel@quipment.in>
> 
> In tmp102.ko driver support for 12 bit data is added.

Why do you need this?

Did you test your patch? I doubt it.

> Signed-off-by: Ankur Patel <ankur.patel@quipment.in>
> ---
>  drivers/hwmon/tmp102.c |   28 ++++++++++++++++++++--------
>  1 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
> index 5bd1949..6e03a87 100644
> --- a/drivers/hwmon/tmp102.c
> +++ b/drivers/hwmon/tmp102.c
> @@ -47,6 +47,9 @@
>  #define	TMP102_TLOW_REG			0x02
>  #define	TMP102_THIGH_REG		0x03
>  
> +#define TMP102_CONFIG  (TMP102_CONF_TM | TMP102_CONF_EM | TMP102_CONF_CR1)
> +#define TMP102_CONFIG_RD_ONLY (TMP102_CONF_R0 | TMP102_CONF_R1 | TMP102_CONF_AL)
> +
>  struct tmp102 {
>  	struct device *hwmon_dev;
>  	struct mutex lock;
> @@ -68,16 +71,26 @@ static inline int tmp102_write_reg(struct i2c_client *client, u8 reg, u16 val)
>  	return i2c_smbus_write_word_data(client, reg, swab16(val));
>  }
>  
> -/* convert left adjusted 13-bit TMP102 register value to milliCelsius */
> +/* convert left adjusted TMP102 register value to milliCelsius for 13 bit &
> + * 12 bit by dividing with 128 & 256 respectively*/

Comments paraphrasing the code are useless.

>  static inline int tmp102_reg_to_mC(s16 val)
>  {
> -	return ((val & ~0x01) * 1000) / 128;
> +	#if TMP102_CONFIG & TMP102_CONF_EM
> +		return ((val & ~0x01) * 1000) / 128;
> +	#else
> +		return ((val & ~0x01) * 1000) / 256;
> +	#endif

This is a nonsense. I'm not even sure if the construct is valid and
portable, but even if it is, TMP102_CONFIG & TMP102_CONF_EM will
always evaluate to true, so the #else part is never used. So your patch
is a no-op.

If you want the driver to support both 12-bit and 13-bit modes, the
test above has to be a run-time test. Then you will also have to
provide a way to set the desired mode, as currently the driver
forces 13-bit mode. This would normally be passed through platform
data. Alternatively, the driver could assume that the setting is
already correct, and read it from the chip, instead of setting it.

But first of all you'll have to explain why you want 12-bit mode
support. What's the benefit?

>  }
>  
> -/* convert milliCelsius to left adjusted 13-bit TMP102 register value */
> +/* convert milliCelsius to left adjusted TMP102 register value for 13 bit &
> + * 12 bit by multiplying with 128 & 256 respectivley*/
>  static inline u16 tmp102_mC_to_reg(int val)
>  {
> -	return (val * 128) / 1000;
> +	#if TMP102_CONFIG & TMP102_CONF_EM
> +		return (val * 128) / 1000;
> +	#else
> +		return (val * 256) / 1000;
> +	#endif
>  }
>  
>  static const u8 tmp102_reg[] = {
> @@ -126,7 +139,9 @@ static ssize_t tmp102_set_temp(struct device *dev,
>  
>  	if (strict_strtol(buf, 10, &val) < 0)
>  		return -EINVAL;
> -	val = SENSORS_LIMIT(val, -256000, 255000);
> +	/* It will limit the Input temperature range to -55 Deg. Cel to
> +	 * 150 Deg. Cel */
> +	val = SENSORS_LIMIT(val, -55000, 150000);

This change is unrelated with the rest of the patch and not described
in the header either. Again, a comment paraphrasing the code is
useless. And the change is not even valid for 12-bit mode...

>  
>  	mutex_lock(&tmp102->lock);
>  	tmp102->temp[sda->index] = val;
> @@ -155,9 +170,6 @@ static const struct attribute_group tmp102_attr_group = {
>  	.attrs = tmp102_attributes,
>  };
>  
> -#define TMP102_CONFIG  (TMP102_CONF_TM | TMP102_CONF_EM | TMP102_CONF_CR1)
> -#define TMP102_CONFIG_RD_ONLY (TMP102_CONF_R0 | TMP102_CONF_R1 | TMP102_CONF_AL)
> -
>  static int __devinit tmp102_probe(struct i2c_client *client,
>  				  const struct i2c_device_id *id)
>  {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
