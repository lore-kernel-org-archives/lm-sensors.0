From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Apr 2011 14:04:51 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon/f71882fg: Add support for F71808A
Message-Id: <20110427160451.3f95dbfc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1303393458-4001-2-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1303393458-4001-2-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 21 Apr 2011 15:44:18 +0200, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/hwmon/f71882fg |    4 ++
>  drivers/hwmon/Kconfig        |    2 +-
>  drivers/hwmon/f71882fg.c     |   79 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/hwmon/f71882fg b/Documentation/hwmon/f71882fg
> index df02245..84d2623 100644
> --- a/Documentation/hwmon/f71882fg
> +++ b/Documentation/hwmon/f71882fg
> @@ -6,6 +6,10 @@ Supported chips:
>      Prefix: 'f71808e'
>      Addresses scanned: none, address read from Super I/O config space
>      Datasheet: Not public
> +  * Fintek F71808A
> +    Prefix: 'f71808a'
> +    Addresses scanned: none, address read from Super I/O config space
> +    Datasheet: Not public
>    * Fintek F71858FG
>      Prefix: 'f71858fg'
>      Addresses scanned: none, address read from Super I/O config space
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 065d01b..b4ede46 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -320,7 +320,7 @@ config SENSORS_F71882FG
>  	  If you say yes here you get support for hardware monitoring
>  	  features of many Fintek Super-I/O (LPC) chips. The currently
>  	  supported chips are:
> -	    F71808E
> +	    F71808E/A
>  	    F71858FG
>  	    F71862FG
>  	    F71863FG
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index 16330db..341922d 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -48,6 +48,7 @@
>  
>  #define SIO_FINTEK_ID		0x1934	/* Manufacturers ID */
>  #define SIO_F71808E_ID		0x0901	/* Chipset ID */
> +#define SIO_F71808A_ID		0x1001	/* Chipset ID */
>  #define SIO_F71858_ID		0x0507  /* Chipset ID */
>  #define SIO_F71862_ID		0x0601	/* Chipset ID */
>  #define SIO_F71869_ID		0x0814	/* Chipset ID */
> @@ -107,11 +108,12 @@ static unsigned short force_id;
>  module_param(force_id, ushort, 0);
>  MODULE_PARM_DESC(force_id, "Override the detected device ID");
>  
> -enum chips { f71808e, f71858fg, f71862fg, f71869, f71882fg, f71889fg,
> +enum chips { f71808e, f71808a, f71858fg, f71862fg, f71869, f71882fg, f71889fg,
>  	     f71889ed, f71889a, f8000, f81865f };
>  
>  static const char *f71882fg_names[] = {
>  	"f71808e",
> +	"f71808a",
>  	"f71858fg",
>  	"f71862fg",
>  	"f71869", /* Both f71869f and f71869e, reg. compatible and same id */
> @@ -125,6 +127,7 @@ static const char *f71882fg_names[] = {
>  
>  static const char f71882fg_has_in[][F71882FG_MAX_INS] = {
>  	[f71808e]	= { 1, 1, 1, 1, 1, 1, 0, 1, 1 },
> +	[f71808a]	= { 1, 1, 1, 1, 0, 0, 0, 1, 1 },
>  	[f71858fg]	= { 1, 1, 1, 0, 0, 0, 0, 0, 0 },
>  	[f71862fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
>  	[f71869]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
> @@ -138,6 +141,7 @@ static const char f71882fg_has_in[][F71882FG_MAX_INS] = {
>  
>  static const char f71882fg_has_in1_alarm[] = {
>  	[f71808e]	= 0,
> +	[f71808a]	= 0,
>  	[f71858fg]	= 0,
>  	[f71862fg]	= 0,
>  	[f71869]	= 0,
> @@ -151,6 +155,7 @@ static const char f71882fg_has_in1_alarm[] = {
>  
>  static const char f71882fg_fan_has_beep[] = {
>  	[f71808e]	= 0,
> +	[f71808a]	= 0,
>  	[f71858fg]	= 0,
>  	[f71862fg]	= 1,
>  	[f71869]	= 1,
> @@ -164,6 +169,7 @@ static const char f71882fg_fan_has_beep[] = {
>  
>  static const char f71882fg_nr_fans[] = {
>  	[f71808e]	= 3,
> +	[f71808a]	= 2, /* +1 fan which is monitor + simple pwm only */
>  	[f71858fg]	= 3,
>  	[f71862fg]	= 3,
>  	[f71869]	= 3,
> @@ -171,12 +177,13 @@ static const char f71882fg_nr_fans[] = {
>  	[f71889fg]	= 3,
>  	[f71889ed]	= 3,
>  	[f71889a]	= 3,
> -	[f8000]		= 3,
> +	[f8000]		= 3, /* +1 fan which is monitor only */
>  	[f81865f]	= 2,
>  };
>  
>  static const char f71882fg_temp_has_beep[] = {
>  	[f71808e]	= 0,
> +	[f71808a]	= 1,
>  	[f71858fg]	= 0,
>  	[f71862fg]	= 1,
>  	[f71869]	= 1,
> @@ -190,6 +197,7 @@ static const char f71882fg_temp_has_beep[] = {
>  
>  static const char f71882fg_nr_temps[] = {
>  	[f71808e]	= 2,
> +	[f71808a]	= 2,
>  	[f71858fg]	= 3,
>  	[f71862fg]	= 3,
>  	[f71869]	= 3,
> @@ -314,6 +322,10 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
>  	char *buf);
>  static ssize_t store_pwm(struct device *dev, struct device_attribute *devattr,
>  	const char *buf, size_t count);
> +static ssize_t show_simple_pwm(struct device *dev,
> +	struct device_attribute *devattr, char *buf);
> +static ssize_t store_simple_pwm(struct device *dev,
> +	struct device_attribute *devattr, const char *buf, size_t count);
>  static ssize_t show_pwm_enable(struct device *dev,
>  	struct device_attribute *devattr, char *buf);
>  static ssize_t store_pwm_enable(struct device *dev,
> @@ -563,6 +575,14 @@ static struct sensor_device_attribute_2 fxxxx_fan_attr[4][6] = { {
>  		      show_pwm_interpolate, store_pwm_interpolate, 0, 3),
>  } };
>  
> +/* Attr for the third fan of the f71808a, which only has manual pwm */
> +static struct sensor_device_attribute_2 f71808a_fan3_attr[] = {
> +	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 0, 2),
> +	SENSOR_ATTR_2(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 2),
> +	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR,
> +		      show_simple_pwm, store_simple_pwm, 0, 2),
> +};
> +
>  /* Attr for models which can beep on Fan alarm */
>  static struct sensor_device_attribute_2 fxxxx_fan_beep_attr[] = {
>  	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
> @@ -1736,6 +1756,38 @@ leave:
>  	return count;
>  }
>  
> +static ssize_t show_simple_pwm(struct device *dev,
> +			       struct device_attribute *devattr, char *buf)
> +{
> +	struct f71882fg_data *data = f71882fg_update_device(dev);
> +	int val, nr = to_sensor_dev_attr_2(devattr)->index;
> +
> +	val = data->pwm[nr];
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t store_simple_pwm(struct device *dev,
> +				struct device_attribute *devattr,
> +				const char *buf, size_t count)
> +{
> +	struct f71882fg_data *data = dev_get_drvdata(dev);
> +	int err, nr = to_sensor_dev_attr_2(devattr)->index;
> +	long val;
> +
> +	err = strict_strtol(buf, 10, &val);
> +	if (err)
> +		return err;
> +
> +	val = SENSORS_LIMIT(val, 0, 255);
> +
> +	mutex_lock(&data->update_lock);
> +	f71882fg_write8(data, F71882FG_REG_PWM(nr), val);
> +	data->pwm[nr] = val;
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
>  static ssize_t show_pwm_enable(struct device *dev,
>  			       struct device_attribute *devattr, char *buf)
>  {
> @@ -2182,6 +2234,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
>  
>  	if (start_reg & 0x02) {
>  		switch (data->type) {
> +		case f71808a:
>  		case f71808e:
>  		case f71869:
>  			/* These always have signed auto point temps */
> @@ -2243,6 +2296,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
>  		}
>  
>  		switch (data->type) {
> +		case f71808a:
>  		case f71808e:
>  		case f71869:
>  		case f71889fg:

Nitpicking: in all other places you listed the f71808e first, so you
should do the same here for consistency.

> @@ -2269,6 +2323,16 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
>  		}
>  
>  		switch (data->type) {
> +		case f71808a:
> +			err = f71882fg_create_sysfs_files(pdev,
> +				&fxxxx_auto_pwm_attr[0][0],
> +				ARRAY_SIZE(fxxxx_auto_pwm_attr[0]) * nr_fans);
> +			if (err)
> +				goto exit_unregister_sysfs;
> +			err = f71882fg_create_sysfs_files(pdev,
> +					f71808a_fan3_attr,
> +					ARRAY_SIZE(f71808a_fan3_attr));
> +			break;
>  		case f71862fg:
>  			err = f71882fg_create_sysfs_files(pdev,
>  					f71862fg_auto_pwm_attr,
> @@ -2386,6 +2450,14 @@ static int f71882fg_remove(struct platform_device *pdev)
>  		}
>  
>  		switch (data->type) {
> +		case f71808a:
> +			f71882fg_remove_sysfs_files(pdev,
> +				&fxxxx_auto_pwm_attr[0][0],
> +				ARRAY_SIZE(fxxxx_auto_pwm_attr[0]) * nr_fans);
> +			f71882fg_remove_sysfs_files(pdev,
> +					f71808a_fan3_attr,
> +					ARRAY_SIZE(f71808a_fan3_attr));
> +			break;
>  		case f71862fg:
>  			f71882fg_remove_sysfs_files(pdev,
>  					f71862fg_auto_pwm_attr,
> @@ -2438,6 +2510,9 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
>  	case SIO_F71808E_ID:
>  		sio_data->type = f71808e;
>  		break;
> +	case SIO_F71808A_ID:
> +		sio_data->type = f71808a;
> +		break;
>  	case SIO_F71858_ID:
>  		sio_data->type = f71858fg;
>  		break;

Other than this, it looks all reasonable, so I've adjusted the code
myself and applied the patch. Thanks for your contribution.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
