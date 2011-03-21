From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Mon, 21 Mar 2011 19:28:58 +0000
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon: sht15: add checksum
Message-Id: <4D87A6FA.5030202@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-2-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-2-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/16/11 18:44, Vivien Didelot wrote:
> From: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
> 
> The sht15 sensor allows validating exchages
typo.
> to and from the device using
> a crc8 function. Two utility functions to read individual bytes from
> the device and reverse a byte have also been added.
This setting should definitely be configured via platform data.
If there is reason to have it on for a given device, that is unlikely
to only be true sometimes!

Otherwise, more or less fine.  A few minor suggestions inline.
> 
> Signed-off-by: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> To: lm-sensors@lm-sensors.org
> Cc: khali@linux-fr.org
> ---
>  drivers/hwmon/sht15.c |  194 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 179 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> index 2c586fc..83822a6 100644
> --- a/drivers/hwmon/sht15.c
> +++ b/drivers/hwmon/sht15.c
> @@ -1,6 +1,9 @@
>  /*
>   * sht15.c - support for the SHT15 Temperature and Humidity Sensor
>   *
> + * Portions Copyright (c) 2010-2011 Savoir-faire Linux Inc.
> + *          Jerome Oufella <jerome.oufella@savoirfairelinux.com>
> + *
>   * Copyright (c) 2009 Jonathan Cameron
>   *
>   * Copyright (c) 2007 Wouter Horre
> @@ -9,8 +12,8 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   *
> - * Currently ignoring checksum on readings.
>   * Default resolution only (14bit temp, 12bit humidity)
> + * Checksum validation can be enabled via the checksumming sysfs attribute
>   * Ignoring battery status.
>   * Heater not enabled.
>   * Timings are all conservative.
> @@ -39,8 +42,9 @@
>  #include <linux/slab.h>
>  #include <asm/atomic.h>
>  
> -#define SHT15_MEASURE_TEMP	3
> -#define SHT15_MEASURE_RH	5
> +#define SHT15_MEASURE_TEMP	0x03
> +#define SHT15_MEASURE_RH	0x05
> +#define SHT15_SOFT_RESET	0x1E
>  
>  #define SHT15_READING_NOTHING	0
>  #define SHT15_READING_TEMP	1
> @@ -51,6 +55,9 @@
>  #define SHT15_TSCKH		100	/* clock high */
>  #define SHT15_TSU		150	/* data setup time */
>  
> +/* Min timings in msecs */
> +#define SHT15_TSRST		11	/* soft reset time */
> +
>  /**
>   * struct sht15_temppair - elements of voltage dependant temp calc
>   * @vdd:	supply voltage in microvolts
> @@ -72,6 +79,34 @@ static const struct sht15_temppair temppoints[] = {
>  	{ 5000000, -40100 },
>  };
>  
> +/* Table from crc data sheet, section 2.4 */
I'll just assume you got this right. The table google gave me was in
decimal and I'm feeling lazy.
> +static const u8 sht15_crc8_table[] = {
> +	0x00, 0x31, 0x62, 0x53, 0xC4, 0xF5, 0xA6, 0x97,	0xB9, 0x88, 0xDB,
> +	0xEA, 0x7D, 0x4C, 0x1F, 0x2E, 0x43, 0x72, 0x21, 0x10, 0x87, 0xB6,
> +	0xE5, 0xD4, 0xFA, 0xCB, 0x98, 0xA9, 0x3E, 0x0F, 0x5C, 0x6D, 0x86,
> +	0xB7, 0xE4, 0xD5, 0x42, 0x73, 0x20, 0x11, 0x3F, 0x0E, 0x5D, 0x6C,
> +	0xFB, 0xCA, 0x99, 0xA8, 0xC5, 0xF4, 0xA7, 0x96, 0x01, 0x30, 0x63,
> +	0x52, 0x7C, 0x4D, 0x1E, 0x2F, 0xB8, 0x89, 0xDA, 0xEB, 0x3D, 0x0C,
> +	0x5F, 0x6E, 0xF9, 0xC8, 0x9B, 0xAA, 0x84, 0xB5, 0xE6, 0xD7, 0x40,
> +	0x71, 0x22, 0x13, 0x7E, 0x4F, 0x1C, 0x2D, 0xBA, 0x8B, 0xD8, 0xE9,
> +	0xC7, 0xF6, 0xA5, 0x94, 0x03, 0x32, 0x61, 0x50, 0xBB, 0x8A, 0xD9,
> +	0xE8, 0x7F, 0x4E, 0x1D, 0x2C, 0x02, 0x33, 0x60, 0x51, 0xC6, 0xF7,
> +	0xA4, 0x95, 0xF8, 0xC9, 0x9A, 0xAB, 0x3C, 0x0D, 0x5E, 0x6F, 0x41,
> +	0x70, 0x23, 0x12, 0x85, 0xB4, 0xE7, 0xD6, 0x7A, 0x4B, 0x18, 0x29,
> +	0xBE, 0x8F, 0xDC, 0xED, 0xC3, 0xF2, 0xA1, 0x90, 0x07, 0x36, 0x65,
> +	0x54, 0x39, 0x08, 0x5B, 0x6A, 0xFD, 0xCC, 0x9F, 0xAE, 0x80, 0xB1,
> +	0xE2, 0xD3, 0x44, 0x75, 0x26, 0x17, 0xFC, 0xCD, 0x9E, 0xAF, 0x38,
> +	0x09, 0x5A, 0x6B, 0x45, 0x74, 0x27, 0x16, 0x81, 0xB0, 0xE3, 0xD2,
> +	0xBF, 0x8E, 0xDD, 0xEC, 0x7B, 0x4A, 0x19, 0x28, 0x06, 0x37, 0x64,
> +	0x55, 0xC2, 0xF3, 0xA0, 0x91, 0x47, 0x76, 0x25, 0x14, 0x83, 0xB2,
> +	0xE1, 0xD0, 0xFE, 0xCF, 0x9C, 0xAD, 0x3A, 0x0B, 0x58, 0x69, 0x04,
> +	0x35, 0x66, 0x57, 0xC0, 0xF1, 0xA2, 0x93, 0xBD, 0x8C, 0xDF, 0xEE,
> +	0x79, 0x48, 0x1B, 0x2A, 0xC1, 0xF0, 0xA3, 0x92, 0x05, 0x34, 0x67,
> +	0x56, 0x78, 0x49, 0x1A, 0x2B, 0xBC, 0x8D, 0xDE, 0xEF, 0x82, 0xB3,
> +	0xE0, 0xD1, 0x46, 0x77, 0x24, 0x15, 0x3B, 0x0A, 0x59, 0x68, 0xFF,
> +	0xCE, 0x9D, 0xAC
> +};
> +
>  /**
>   * struct sht15_data - device instance specific data
>   * @pdata:	platform data (gpio's etc)
> @@ -79,6 +114,7 @@ static const struct sht15_temppair temppoints[] = {
>   * @wait_queue:	wait queue for getting values from device
>   * @val_temp:	last temperature value read from device
>   * @val_humid: 	last humidity value read from device
> + * @checksum_ok:last value read from device passed checksum verification
>   * @flag:	status flag used to identify what the last request was
>   * @valid:	are the current stored values valid (start condition)
>   * @last_updat:	time of last update
> @@ -95,6 +131,7 @@ static const struct sht15_temppair temppoints[] = {
>   *		based upon it will be invalid.
>   * @update_supply_work:	work struct that is used to update the supply_uV
>   * @interrupt_handled:	flag used to indicate a hander has been scheduled
> + * @checksumming:	flag used to indicate the data checksum must be validated
>   */
>  struct sht15_data {
>  	struct sht15_platform_data	*pdata;
> @@ -102,6 +139,7 @@ struct sht15_data {
>  	wait_queue_head_t		wait_queue;
>  	uint16_t			val_temp;
>  	uint16_t			val_humid;
> +	u8				checksum_ok;
>  	u8				flag;
>  	u8				valid;
>  	unsigned long			last_updat;
> @@ -114,8 +152,46 @@ struct sht15_data {
>  	int				supply_uV_valid;
>  	struct work_struct		update_supply_work;
>  	atomic_t			interrupt_handled;
> +	u8				checksumming;
>  };
>  
Please don't introduce unwanted function prototypes.  If you need
to reorganise the code so they aren't needed.

> +static u8 sht15_read_byte(struct sht15_data *);
> +static void sht15_ack(struct sht15_data *);
> +static void sht15_end_transmission(struct sht15_data *);
> +
> +/**
> + * reverse() - reverse a byte
> + * @byte:    byte to reverse.
> + *
> + * stolen from drivers/lirc/lirc_i2c.c
> + */
> +static u8 reverse(u8 byte)
> +{
> +	u8 i, c;
> +
> +	for (c = 0, i = 0; i < 8; i++)

Ternary operatures in the middle something like this are really
really hard to read!
How about...
  c |= (!!(byte & (1 << i))) << (7 - i);
> +		c |= ((byte & (1 << i)) ? 1 : 0) << (7 - i);
> +	return c;
> +}
> +
> +/**
> + * sht15_crc8() - compute crc8
> + * @data:	sht15 retrieved data
> + *
> + * This implements section 2 of the crc data sheet
> + */
> +static u8 sht15_crc8(const unsigned char *data, unsigned char len)
> +{
> +	unsigned char crc = 0;
> +
> +	while (len--) {
> +		crc = sht15_crc8_table[*data ^ crc];
> +		data++;
> +	}
> +
> +	return crc;
> +}
> +
>  /**
>   * sht15_connection_reset() - reset the comms interface
>   * @data:	sht15 specific data
> @@ -229,6 +305,19 @@ static int sht15_send_cmd(struct sht15_data *data, u8 cmd)
>  	ret = sht15_wait_for_response(data);
>  	return ret;
>  }
> +
> +/**
> + * sht15_soft_reset() - send a soft reset command
> + * @data:	sht15 specific data
> + *
> + * As described in section 3.2 of the data sheet
> + */
> +static inline void sht15_soft_reset(struct sht15_data *data)
> +{
> +	sht15_send_cmd(data, SHT15_SOFT_RESET);
> +	msleep(SHT15_TSRST);
> +}
> +
>  /**
>   * sht15_update_single_val() - get a new value from device
>   * @data:		device instance specific data
> @@ -263,6 +352,17 @@ static inline int sht15_update_single_val(struct sht15_data *data,
>  		sht15_connection_reset(data);
>  		return -ETIME;
>  	}
> +
> +	/*
> +	 *  Perform checksum validation on the received data.
> +	 *  Specification mentions that in case a checksum verification fails,
> +	 *  a soft reset command must be sent to the device.
> +	 */
> +	if (data->checksumming && !data->checksum_ok) {
> +		sht15_soft_reset(data);
> +		return -EAGAIN;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -366,8 +466,36 @@ static ssize_t sht15_show_humidity(struct device *dev,
>  	ret = sht15_update_vals(data);
>  
>  	return ret ? ret : sprintf(buf, "%d\n", sht15_calc_humid(data));
> +}
> +
As stated above, platform data please, not sysfs for this.
> +static ssize_t sht15_show_checksum(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct sht15_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", data->checksumming);
> +}
> +
> +static ssize_t sht15_store_checksum(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct sht15_data *data = dev_get_drvdata(dev);
> +	long value;
> +
> +	mutex_lock(&data->read_lock);
> +	if (strict_strtol(buf, 10, &value)) {
> +		mutex_unlock(&data->read_lock);
> +		return -EINVAL;
> +	}
> +
> +	data->checksumming = !!value;
> +	mutex_unlock(&data->read_lock);
> +
> +	return count;
> +}
>  
> -};
>  static ssize_t show_name(struct device *dev,
>  			 struct device_attribute *attr,
>  			 char *buf)
> @@ -382,10 +510,15 @@ static SENSOR_DEVICE_ATTR(temp1_input,
>  static SENSOR_DEVICE_ATTR(humidity1_input,
>  			  S_IRUGO, sht15_show_humidity,
>  			  NULL, 0);
> +static DEVICE_ATTR(checksumming,
> +			  S_IRUGO | S_IWUSR,
> +			  sht15_show_checksum,
> +			  sht15_store_checksum);
>  static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
>  static struct attribute *sht15_attrs[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	&sensor_dev_attr_humidity1_input.dev_attr.attr,
> +	&dev_attr_checksumming.attr,
>  	&dev_attr_name.attr,
>  	NULL,
>  };
> @@ -437,13 +570,35 @@ static void sht15_end_transmission(struct sht15_data *data)
>  	ndelay(SHT15_TSCKL);
>  }
>  
> -static void sht15_bh_read_data(struct work_struct *work_s)
> +/**
> + * sht15_read_byte() - Read a byte back from the device
> + * @data:	device state.
> + */
> +static u8 sht15_read_byte(struct sht15_data *data)
>  {
>  	int i;
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
> +static void sht15_bh_read_data(struct work_struct *work_s)
> +{
>  	uint16_t val = 0;
> +	u8 dev_checksum = 0;
> +	u8 checksum_values[3];
>  	struct sht15_data *data
>  		= container_of(work_s, struct sht15_data,
>  			       read_work);
> +
>  	/* Firstly, verify the line is low */
>  	if (gpio_get_value(data->pdata->gpio_data)) {
>  		/* If not, then start the interrupt again - care
> @@ -458,16 +613,24 @@ static void sht15_bh_read_data(struct work_struct *work_s)
>  			return;
>  	}
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
> +	val = sht15_read_byte(data);
> +	val <<= 8;
> +	sht15_ack(data);
> +	val |= sht15_read_byte(data);
> +
> +	if (data->checksumming) {
> +		/**
> +		 *  Ask the device for a checksum and read it back.
> +		 *  Note: the device sends the checksum byte reversed.
> +		 */
> +		sht15_ack(data);
> +		dev_checksum = reverse(sht15_read_byte(data));
That looks rather over 80 characters. Please run checkpatch.pl on this
before resending.
> +		checksum_values[0] = (data->flag = SHT15_READING_TEMP) ? SHT15_MEASURE_TEMP : SHT15_MEASURE_RH;
> +		checksum_values[1] = (u8) (val >> 8);
> +		checksum_values[2] = (u8) val;
> +		data->checksum_ok = (sht15_crc8(checksum_values, 3) = dev_checksum);
>  	}
> +
>  	/* Tell the device we are done */
>  	sht15_end_transmission(data);
>  
> @@ -538,6 +701,7 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  	}
>  	data->pdata = pdev->dev.platform_data;
>  	data->supply_uV = data->pdata->supply_mv*1000;
No. That changes the default.  By all means allow this to be turned on, but
making it the default may effect existing users.
> +	data->checksumming = 1; /* Verify checksums by default */
>  
>  /* If a regulator is available, query what the supply voltage actually is!*/
>  	data->reg = regulator_get(data->dev, "vcc");
> @@ -583,7 +747,7 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  	}
>  	disable_irq_nosync(gpio_to_irq(data->pdata->gpio_data));
>  	sht15_connection_reset(data);
> -	sht15_send_cmd(data, 0x1E);
> +	sht15_soft_reset(data);
>  
>  	data->hwmon_dev = hwmon_device_register(data->dev);
>  	if (IS_ERR(data->hwmon_dev)) {


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
