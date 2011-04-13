From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 13 Apr 2011 11:39:46 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (sht15) add support for the
Message-Id: <4DA58B82.1000701@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302636879-16615-4-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1302636879-16615-4-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/12/11 20:34, Vivien Didelot wrote:
> * Add support for:
>   - Heater.
>   - End of battery notice.
>   - Ability not to reload from OTP.
>   - Low resolution (12bit temp, 8bit humidity).
> * Add an utility function to read individual bytes from the device.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  Documentation/hwmon/sht15 |   29 +++++-
>  drivers/hwmon/sht15.c     |  247 +++++++++++++++++++++++++++++++++++++++------
>  include/linux/sht15.h     |    4 +
>  3 files changed, 245 insertions(+), 35 deletions(-)
> 
> diff --git a/Documentation/hwmon/sht15 b/Documentation/hwmon/sht15
> index 50c07f5..a9e36e3 100644
> --- a/Documentation/hwmon/sht15
> +++ b/Documentation/hwmon/sht15
> @@ -4,6 +4,7 @@ Kernel driver sht15
>  Authors:
>    * Wouter Horre
>    * Jonathan Cameron
> +  * Vivien Didelot <vivien.didelot@savoirfairelinux.com>
>  
>  Supported chips:
>    * Sensirion SHT10
> @@ -30,14 +31,38 @@ Description
>  The SHT10, SHT11, SHT15, SHT71, and SHT75 are humidity and temperature
>  sensors.
>  
> -The devices communicate using two GPIO lines and use the default
> -resolution settings of 14 bits for temperature and 12 bits for humidity.
> +The devices communicate using two GPIO lines.
> +
> +Supported resolutions for the measurements are 14 bits for temperature and 12
> +bits for humidity, or 12 bits for temperature and 8 bits for humidity.
> +
> +The humidity calibration coefficients are programmed into an OTP memory on the
> +chip. These coefficients are used to internally calibrate the signals from the
> +sensors. Disabling the reload of those coefficients allows saving 10ms for each
> +measurement and decrease power consumption, while loosing on precision.
> +
> +Some options may be set directly in the sht15_platform_data structure
> +or via sysfs attributes.
>  
>  Note: The regulator supply name is set to "vcc".
>  
> +Platform data
> +-------------
> +
> +* no_otp_reload:
> +  flag to indicate not to reload from OTP (default to false).
> +* low_resolution:
> +  flag to indicate the temp/humidity resolution to use (default to false).
> +
>  Sysfs interface
>  ---------------
>  
>  * temp1_input:     temperature input
>  * humidity1_input: humidity input
> +* heater_enable:   write 1 in this attribute to enable the on-chip heater,
> +                   0 to disable it. Be careful not to enable the heater
> +                   for too long.
> +* temp1_fault:     if 1, this means that the voltage is low (below 2.47V) and
> +                   measurement may be invalid.
> +* humidity1_fault: same as temp1_fault.
>  
> diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> index 42992fe..77d25d3 100644
> --- a/drivers/hwmon/sht15.c
> +++ b/drivers/hwmon/sht15.c
> @@ -1,6 +1,9 @@
>  /*
>   * sht15.c - support for the SHT15 Temperature and Humidity Sensor
>   *
> + * Portions Copyright (c) 2010-2011 Savoir-faire Linux Inc.
> + *          Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> + *
>   * Copyright (c) 2009 Jonathan Cameron
>   *
>   * Copyright (c) 2007 Wouter Horre
> @@ -33,6 +36,8 @@
>  /* Commands */
>  #define SHT15_MEASURE_TEMP		0x03
>  #define SHT15_MEASURE_RH		0x05
> +#define SHT15_WRITE_STATUS		0x06
> +#define SHT15_READ_STATUS		0x07
>  #define SHT15_SOFT_RESET		0x1E
>  
>  /* Min timings */
> @@ -41,6 +46,12 @@
>  #define SHT15_TSU			150	/* (nsecs) data setup time */
>  #define SHT15_TSRST			11	/* (msecs) soft reset time */
>  
> +/* Status Register Bits */
> +#define SHT15_STATUS_LOW_RESOLUTION	0x01
> +#define SHT15_STATUS_NO_OTP_RELOAD	0x02
> +#define SHT15_STATUS_HEATER		0x04
> +#define SHT15_STATUS_LOW_BATTERY	0x40
> +
>  /* Actions the driver may be doing */
>  enum sht15_state {
>  	SHT15_READING_NOTHING,
> @@ -74,9 +85,12 @@ static const struct sht15_temppair temppoints[] = {
>   * @wait_queue:		wait queue for getting values from device.
>   * @val_temp:		last temperature value read from device.
>   * @val_humid:		last humidity value read from device.
> + * @val_status:		last status register value read from device.
>   * @state:		state identifying the action the driver is doing.
>   * @measurements_valid:	are the current stored measures valid (start condition).
> + * @status_valid:	is the current stored status valid (start condition).
>   * @last_measurement:	time of last measure.
> + * @last_status:	time of last status reading.
>   * @read_lock:		mutex to ensure only one read in progress at a time.
>   * @dev:		associate device structure.
>   * @hwmon_dev:		device associated with hwmon subsystem.
> @@ -97,9 +111,12 @@ struct sht15_data {
>  	wait_queue_head_t		wait_queue;
>  	uint16_t			val_temp;
>  	uint16_t			val_humid;
> +	u8				val_status;
>  	enum sht15_state		state;
>  	bool				measurements_valid;
> +	bool				status_valid;
>  	unsigned long			last_measurement;
> +	unsigned long			last_status;
>  	struct mutex			read_lock;
>  	struct device			*dev;
>  	struct device			*hwmon_dev;
> @@ -244,11 +261,106 @@ static int sht15_soft_reset(struct sht15_data *data)
>  	if (ret)
>  		return ret;
>  	msleep(SHT15_TSRST);
> +	/* device resets default hardware status register value */
> +	data->val_status = 0;
> +
> +	return ret;
> +}
> +
> +/**
> + * sht15_end_transmission() - notify device of end of transmission
> + * @data:	device state.
> + *
> + * This is basically a NAK (single clock pulse, data high).
> + */
> +static void sht15_end_transmission(struct sht15_data *data)
> +{
> +	gpio_direction_output(data->pdata->gpio_data, 1);
> +	ndelay(SHT15_TSU);
> +	gpio_set_value(data->pdata->gpio_sck, 1);
> +	ndelay(SHT15_TSCKH);
> +	gpio_set_value(data->pdata->gpio_sck, 0);
> +	ndelay(SHT15_TSCKL);
> +}
> +
> +/**
> + * sht15_read_byte() - Read a byte back from the device
> + * @data:	device state.
> + */
> +static u8 sht15_read_byte(struct sht15_data *data)
> +{
> +	int i;
> +	u8 byte = 0;
> +
> +	for (i = 0; i < 8; ++i) {
> +		byte <<= 1;
> +		gpio_set_value(data->pdata->gpio_sck, 1);
> +		ndelay(SHT15_TSCKH);
> +		byte |= !!gpio_get_value(data->pdata->gpio_data);
> +		gpio_set_value(data->pdata->gpio_sck, 0);
> +		ndelay(SHT15_TSCKL);
> +	}
> +	return byte;
> +}
> +
> +/**
> + * sht15_send_status() - write the status register byte
> + * @data:	sht15 specific data.
> + * @status:	the byte to set the status register with.
> + *
> + * As described in figure 14 and table 5 of the datasheet.
> + */
> +static int sht15_send_status(struct sht15_data *data, u8 status)
> +{
> +	int ret;
> +
> +	ret = sht15_send_cmd(data, SHT15_WRITE_STATUS);
> +	if (ret)
> +		return ret;
> +	gpio_direction_output(data->pdata->gpio_data, 1);
> +	ndelay(SHT15_TSU);
> +	sht15_send_byte(data, status);
> +	ret = sht15_wait_for_response(data);
> +	if (ret)
> +		return ret;
>  
> +	data->val_status = status;
>  	return 0;
>  }
>  
>  /**
> + * sht15_update_status() - get updated status register from device if too old
> + * @data:	device instance specific data.
> + *
> + * As described in figure 15 and table 5 of the datasheet.
> + */
> +static int sht15_update_status(struct sht15_data *data)
> +{
> +	int ret = 0;
> +	u8 status;
> +	int timeout = HZ;
> +
> +	mutex_lock(&data->read_lock);
> +	if (time_after(jiffies, data->last_status + timeout)
> +			|| !data->status_valid) {
> +		ret = sht15_send_cmd(data, SHT15_READ_STATUS);
> +		if (ret)
> +			goto error_ret;
> +		status = sht15_read_byte(data);
> +
> +		sht15_end_transmission(data);
> +
> +		data->val_status = status;
> +		data->status_valid = true;
> +		data->last_status = jiffies;
> +	}
> +error_ret:
> +	mutex_unlock(&data->read_lock);
> +
> +	return ret;
> +}
> +
> +/**
>   * sht15_measurement() - get a new value from device
>   * @data:		device instance specific data
>   * @command:		command sent to request value
> @@ -324,6 +436,7 @@ error_ret:
>  static inline int sht15_calc_temp(struct sht15_data *data)
>  {
>  	int d1 = temppoints[0].d1;
> +	int d2 = (data->val_status & SHT15_STATUS_LOW_RESOLUTION) ? 40 : 10;
>  	int i;
>  
>  	for (i = ARRAY_SIZE(temppoints) - 1; i > 0; i--)
> @@ -336,7 +449,7 @@ static inline int sht15_calc_temp(struct sht15_data *data)
>  			break;
>  		}
>  
> -	return data->val_temp * 10 + d1;
> +	return data->val_temp * d2 + d1;
>  }
>  
>  /**
> @@ -353,19 +466,86 @@ static inline int sht15_calc_humid(struct sht15_data *data)
>  {
>  	int rh_linear; /* milli percent */
>  	int temp = sht15_calc_temp(data);
> -
> +	int c2, c3;
> +	int t2;
>  	const int c1 = -4;
> -	const int c2 = 40500; /* x 10 ^ -6 */
> -	const int c3 = -28;   /* x 10 ^ -7 */
> +
> +	if (data->val_status & SHT15_STATUS_LOW_RESOLUTION) {
> +		c2 = 648000; /* x 10 ^ -6 */
> +		c3 = -7200;  /* x 10 ^ -7 */
> +		t2 = 1280;
> +	} else {
> +		c2 = 40500;  /* x 10 ^ -6 */
> +		c3 = -28;    /* x 10 ^ -7 */
> +		t2 = 80;
> +	}
>  
>  	rh_linear = c1 * 1000
>  		+ c2 * data->val_humid / 1000
>  		+ (data->val_humid * data->val_humid * c3) / 10000;
> -	return (temp - 25000) * (10000 + 80 * data->val_humid)
> +	return (temp - 25000) * (10000 + t2 * data->val_humid)
>  		/ 1000000 + rh_linear;
>  }
>  
>  /**
> + * sht15_show_status() - show status information in sysfs
> + * @dev:	device.
> + * @attr:	device attribute.
> + * @buf:	sysfs buffer where information is written to.
> + *
> + * Will be called on read access to temp1_fault, humidity1_fault
> + * and heater_enable sysfs attributes.
> + * Returns number of bytes written into buffer, negative errno on error.
> + */
> +static ssize_t sht15_show_status(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	int ret;
> +	struct sht15_data *data = dev_get_drvdata(dev);
> +	u8 bit = to_sensor_dev_attr(attr)->index;
> +
> +	ret = sht15_update_status(data);
> +
> +	return ret ? ret : sprintf(buf, "%d\n", !!(data->val_status & bit));
> +}
> +
> +/**
> + * sht15_store_heater() - change heater state via sysfs
> + * @dev:	device.
> + * @attr:	device attribute.
> + * @buf:	sysfs buffer to read the new heater state from.
> + * @count:	length of the data.
> + *
> + * Will be called on read access to heater_enable sysfs attribute.
> + * Returns number of bytes actually decoded, negative errno on error.
> + */
> +static ssize_t sht15_store_heater(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	int ret;
> +	struct sht15_data *data = dev_get_drvdata(dev);
> +	long value;
> +	u8 status;
> +
> +	if (strict_strtol(buf, 10, &value))
> +		return -EINVAL;
> +
> +	mutex_lock(&data->read_lock);
> +	status = data->val_status & 0x07;
> +	if (!!value)
> +		status |= SHT15_STATUS_HEATER;
> +	else
> +		status &= ~SHT15_STATUS_HEATER;
> +
> +	ret = sht15_send_status(data, status);
> +	mutex_unlock(&data->read_lock);
> +
> +	return ret ? ret : count;
> +}
> +
> +/**
>   * sht15_show_temp() - show temperature measurement value in sysfs
>   * @dev:	device.
>   * @attr:	device attribute.
> @@ -407,7 +587,6 @@ static ssize_t sht15_show_humidity(struct device *dev,
>  	ret = sht15_update_measurements(data);
>  
>  	return ret ? ret : sprintf(buf, "%d\n", sht15_calc_humid(data));
> -
>  }
>  
>  static ssize_t show_name(struct device *dev,
> @@ -422,10 +601,19 @@ static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
>  			  sht15_show_temp, NULL, 0);
>  static SENSOR_DEVICE_ATTR(humidity1_input, S_IRUGO,
>  			  sht15_show_humidity, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, sht15_show_status, NULL,
> +			  SHT15_STATUS_LOW_BATTERY);
> +static SENSOR_DEVICE_ATTR(humidity1_fault, S_IRUGO, sht15_show_status, NULL,
> +			  SHT15_STATUS_LOW_BATTERY);
> +static SENSOR_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR, sht15_show_status,
> +			  sht15_store_heater, SHT15_STATUS_HEATER);
>  static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
>  static struct attribute *sht15_attrs[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	&sensor_dev_attr_humidity1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_fault.dev_attr.attr,
> +	&sensor_dev_attr_humidity1_fault.dev_attr.attr,
> +	&sensor_dev_attr_heater_enable.dev_attr.attr,
>  	&dev_attr_name.attr,
>  	NULL,
>  };
> @@ -466,25 +654,8 @@ static void sht15_ack(struct sht15_data *data)
>  	gpio_direction_input(data->pdata->gpio_data);
>  }
>  
> -/**
> - * sht15_end_transmission() - notify device of end of transmission
> - * @data:	device state
> - *
> - * This is basically a NAK. (single clock pulse, data high)
> - */
> -static void sht15_end_transmission(struct sht15_data *data)
> -{
> -	gpio_direction_output(data->pdata->gpio_data, 1);
> -	ndelay(SHT15_TSU);
> -	gpio_set_value(data->pdata->gpio_sck, 1);
> -	ndelay(SHT15_TSCKH);
> -	gpio_set_value(data->pdata->gpio_sck, 0);
> -	ndelay(SHT15_TSCKL);
> -}
> -
>  static void sht15_bh_read_data(struct work_struct *work_s)
>  {
> -	int i;
>  	uint16_t val = 0;
>  	struct sht15_data *data
>  		= container_of(work_s, struct sht15_data,
> @@ -505,16 +676,10 @@ static void sht15_bh_read_data(struct work_struct *work_s)
>  	}
>  
>  	/* Read the data back from the device */
> -	for (i = 0; i < 16; ++i) {
> -		val <<= 1;
> -		gpio_set_value(data->pdata->gpio_sck, 1);
> -		ndelay(SHT15_TSCKH);
> -		val |= !!gpio_get_value(data->pdata->gpio_data);
> -		gpio_set_value(data->pdata->gpio_sck, 0);
> -		ndelay(SHT15_TSCKL);
> -		if (i = 7)
> -			sht15_ack(data);
> -	}
> +	val = sht15_read_byte(data);
> +	val <<= 8;
> +	sht15_ack(data);
> +	val |= sht15_read_byte(data);
>  
>  	/* Tell the device we are done */
>  	sht15_end_transmission(data);
> @@ -568,6 +733,7 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  {
>  	int ret = 0;
>  	struct sht15_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	u8 status = 0;
>  
>  	if (!data) {
>  		ret = -ENOMEM;
> @@ -588,6 +754,10 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  	}
>  	data->pdata = pdev->dev.platform_data;
>  	data->supply_uV = data->pdata->supply_mv * 1000;
> +	if (data->pdata->no_otp_reload)
> +		status |= SHT15_STATUS_NO_OTP_RELOAD;
> +	if (data->pdata->low_resolution)
> +		status |= SHT15_STATUS_LOW_RESOLUTION;
>  
>  	/*
>  	 * If a regulator is available,
> @@ -646,6 +816,13 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_release_irq;
>  
> +	/* write status with platform data options */
> +	if (status) {
> +		ret = sht15_send_status(data, status);
> +		if (ret)
> +			goto err_release_irq;
> +	}
> +
>  	ret = sysfs_create_group(&pdev->dev.kobj, &sht15_attr_group);
>  	if (ret) {
>  		dev_err(&pdev->dev, "sysfs create failed\n");
> @@ -689,6 +866,10 @@ static int __devexit sht15_remove(struct platform_device *pdev)
>  	 * prevent new ones beginning
>  	 */
>  	mutex_lock(&data->read_lock);
> +	if (sht15_soft_reset(data)) {
> +		mutex_unlock(&data->read_lock);
> +		return -EFAULT;
> +	}
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);
>  	if (!IS_ERR(data->reg)) {
> diff --git a/include/linux/sht15.h b/include/linux/sht15.h
> index 1e30214..d836ca6 100644
> --- a/include/linux/sht15.h
> +++ b/include/linux/sht15.h
> @@ -19,10 +19,14 @@
>   * @gpio_sck:		no. of gpio to which the data clock is connected.
>   * @supply_mv:		supply voltage in mv. Overridden by regulator if
>   *			available.
> + * @no_otp_reload:	flag to indicate no reload from OTP.
> + * @low_resolution:	flag to indicate the temp/humidity resolution to use.
>   */
>  struct sht15_platform_data {
>  	int gpio_data;
>  	int gpio_sck;
>  	int supply_mv;
> +	bool no_otp_reload;
> +	bool low_resolution;
>  };
>  


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
