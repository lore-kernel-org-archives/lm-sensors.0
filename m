From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Mon, 18 Jul 2011 12:24:37 +0000
Subject: Re: [lm-sensors] [PATCH] iio: add support for Analog Devices ad7194
Message-Id: <4E242605.9050400@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310975165-19912-1-git-send-email-pthomas8589@gmail.com> <4E241286.3090103@cam.ac.uk>
In-Reply-To: <4E241286.3090103@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Paul Thomas <pthomas8589@gmail.com>, lm-sensors@lm-sensors.org, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>

On 07/18/11 12:01, Jonathan Cameron wrote:
> cc'ing linux-iio and AD's driver list.
> 
> Any particular reason for posting to lm-sensors? Now it's there we'll
> keep them in the list though as someone might be interested.
> 
> On 07/18/11 08:46, Paul Thomas wrote:
>> This uses the iio sysfs interface, and inculdes gain and differential settings

Hi Paul,

This driver is lagging somewhat in interface terms. Having said that, it applies
and compiles fine which will make catching up to current point much easier.

If you are short on time I'm happy to do the conversion (as it is a nice simple
driver), but obviously I'll need to test it to find out what I messed up this
time.

Big issues:

1) iio_dev->dev_data is going away, so please use the iio_priv stuff.
2) interface is not terribly close the abi spec.
3) use chan_spec based registration. Actually that'll clean up the abi
issues as well and give you much shorter code.
4) differential channels are treated as separate channels (with appropriate
numbering).  This is easy here as there are no nasty constraints on channel
combinations (it only reads one at a time anyway!).

Various nitpicks inline.  Though the above seems like a lot, you have done
all the fiddly stuff about actually talking the the chips. Cleaning up
interfaces is relatively straight forward!  Lots of fun stuff to add to this
chip at a later date, but in the spirit of your driver, lets keep it simple
for now!

As long as you are happy to do a couple of rounds of testing, we could merge
this as is and do the abi work as a series of small steps on top of it?

Thanks,

Jonathan
>>
>> Signed-off-by: Paul Thomas <pthomas8589@gmail.com>
>> ---
>>  drivers/staging/iio/adc/Kconfig  |    7 +
>>  drivers/staging/iio/adc/Makefile |    1 +
>>  drivers/staging/iio/adc/ad7194.c |  462 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 470 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/staging/iio/adc/ad7194.c
>>
>> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
>> index 8c751c4..871605b 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -17,6 +17,13 @@ config AD7152
>>  	  Say yes here to build support for Analog Devices capacitive sensors.
>>  	  (ad7152, ad7153) Provides direct access via sysfs.
>>  
>> +config AD7194
>> +	tristate "Analog Devices AD7194 ADC driver"
>> +	depends on SPI
>> +	help
>> +	  Say yes here to build support for Analog Devices ad7194.
>> +	  Provides direct access via sysfs.
>> +
>>  config AD7291
>>  	tristate "Analog Devices AD7291 temperature sensor driver"
>>  	depends on I2C
>> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
>> index 1d9b3f5..4da3c40 100644
>> --- a/drivers/staging/iio/adc/Makefile
>> +++ b/drivers/staging/iio/adc/Makefile
>> @@ -31,6 +31,7 @@ obj-$(CONFIG_AD7298) += ad7298.o
>>  
>>  obj-$(CONFIG_AD7150) += ad7150.o
>>  obj-$(CONFIG_AD7152) += ad7152.o
>> +obj-$(CONFIG_AD7194) += ad7194.o
>>  obj-$(CONFIG_AD7291) += ad7291.o
>>  obj-$(CONFIG_AD7314) += ad7314.o
>>  obj-$(CONFIG_AD7745) += ad7745.o
>> diff --git a/drivers/staging/iio/adc/ad7194.c b/drivers/staging/iio/adc/ad7194.c
>> new file mode 100644
>> index 0000000..a867662
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7194.c
>> @@ -0,0 +1,462 @@
>> +/*
>> + *  ad7194 - driver for Analog Devices AD7194 A/D converter
>> + *
>> + *  Copyright (c) 2011 Paul Thomas <pthomas8589@gmail.com>
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + *  GNU General Public License for more details.
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License version 2 or
>> + *  later as publishhed by the Free Software Foundation.
>> + *
>> + *	You need to have something like this in struct spi_board_info
>> + *	{
>> + *		.modalias	= "ad7194",
>> + *		.max_speed_hz	= 2*1000*1000,
>> + *		.chip_select	= 0,
>> + *		.bus_num	= 1,
>> + *	},
>> + *
>> + * Three sysfs files are used chX_value, chX_diff and chX_gain
>> + * chX_value is read only and returns that channels value in volts.
>> + * chX_gain is read/write, the chX_value is scaled by the gain so it retains
>> + * it's proper units.
>> + * chX_diff is read/write, if chX_diff is 0 then pseude mod is used,
>> + * if chX_diff is 1 then differential mode is used.
>> + * In this mode ch1_value selects ch1-ch2, and ch2_value selects ch2-ch1
>> + */
>> +
>> +#define DEBUG 1
>> +
>> +/*From Table 15 in the datasheet*/
>> +/*Register addresses*/
>> +#define REG_STATUS  0
>> +#define REG_MODE    1
>> +#define REG_CONF    2
>> +#define REG_DATA    3
>> +#define REG_ID      4
>> +#define REG_GPOCON  5
>> +#define REG_OFFSET  6
>> +#define REG_FS      7
>> +
>> +/*From Table 15 in the datasheet*/
>> +#define COMM_ADDR_bp 3
>> +#define COMM_READ_bm (1 << 6)
>> +
>> +#define CONF_CHOP_bm (1 << 23)
>> +#define CONF_PSEUDO_bm (1 << 18)
>> +#define CONF_BUF_bm (1 << 4)
>> +#define CONF_CHAN_NEG_bp 8
>> +#define CONF_CHAN_POS_bp 12
>> +
>> +
>> +#define MODE_MD_SINGLE_gc (0x01 << 21)
>> +#define MODE_MD_ZS_CAL_gc (0x04 << 21)
>> +#define MODE_MD_FS_CAL_gc (0x05 << 21)
>> +#define MODE_CLK_INTTRI_gc (0x02 << 18)
>> +/*Table 8 in the datasheet provides options for the Filter Word*/
>> +#define MODE_FILTER_WORD 1
>> +#define SETTLE_MS 2
>> +
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/err.h>
>> +#include <linux/mutex.h>
>> +#include <linux/delay.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +
>> +#define DEVICE_NAME	"ad7194"
>> +#define NUM_CHANNELS 16
>> +
This wins the odd award.  The available gains seem unlikely to be tied to the
number of channels.
>> +const uint8_t gains[NUM_CHANNELS] = {1, 0, 0, 8, 16, 32, 64, 128};
>> +
>> +struct ad7194_data {
>> +	struct spi_device *spi_dev;
>> +	struct iio_dev *indio_dev;
>> +	uint8_t gain[NUM_CHANNELS];
>> +	uint8_t diff[NUM_CHANNELS];
>> +	struct mutex lock;
>> +};
>> +
>> +static ssize_t show_gain(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
>> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
>> +	struct ad7194_data *pdata = dev_info->dev_data;
>> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +
>> +	return sprintf(buf, "%d\n", gains[pdata->gain[this_attr->address]]);
>> +}
>> +
>> +static ssize_t set_gain(struct device *dev,
>> +		struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +	uint8_t gain_real, i;
>> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
>> +	struct ad7194_data *pdata = dev_info->dev_data;
>> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +
>> +	gain_real = simple_strtol(buf, NULL, 10);
>> +	if (gain_real = 0)
>> +		return -EPERM;
>> +	for (i = 0; i < NUM_CHANNELS; i++) {
>> +		if (gains[i] = gain_real) {
>> +			pdata->gain[this_attr->address] =  i;
>> +			return count;
>> +		}
>> +	}
>> +	return -EPERM;
>> +}
>> +
>> +static ssize_t show_diff(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
>> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
>> +	struct ad7194_data *pdata = dev_info->dev_data;
>> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +
>> +	return sprintf(buf, "%d\n", pdata->diff[this_attr->address]);
>> +}
>> +
>> +static ssize_t set_diff(struct device *dev,
>> +		struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +	uint8_t diff;
>> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
>> +	struct ad7194_data *pdata = dev_info->dev_data;
>> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +
>> +	diff = simple_strtol(buf, NULL, 10);
strtobool and set value to the resulting bool.
>> +	if (diff)
>> +		pdata->diff[this_attr->address] = 1;
>> +	else
>> +		pdata->diff[this_attr->address] = 0;
>> +	return count;
>> +}
>> +
>> +static inline int ad7194_read_reg8(struct spi_device *spi,
>> +		int reg, uint8_t *val)
>> +{
>> +	int ret;
>> +	uint8_t tx[1], rx[1];
>> +
>> +	tx[0] = (COMM_READ_bm | (reg << COMM_ADDR_bp));
>> +
>> +	ret = spi_write_then_read(spi, tx, 1, rx, 1);
>> +	*val = rx[0];
>> +	return ret;
>> +}
>> +
>> +static inline int ad7194_read_reg24(struct spi_device *spi,
>> +		int reg, uint32_t *val)
>> +{
>> +	int ret;
>> +	uint8_t tx[1], rx[3];
>> +
>> +	tx[0] = (COMM_READ_bm | (reg << COMM_ADDR_bp));
Don't allocate single element arrays.  Just makes things
harder to read.

>> +
>> +	ret = spi_write_then_read(spi, tx, 1, rx, 3);
>> +	*val = (rx[0] << 16) + (rx[1] << 8) + rx[2];
>> +	return ret;
>> +}
>> +
>> +static inline int ad7194_write_reg24(struct spi_device *spi,
>> +		int reg, uint32_t *val)
>> +{
>> +	uint8_t tx[4];
>> +
>> +	tx[0] = (reg << COMM_ADDR_bp);
>> +	tx[1] = (*val >> 16) & 0xff;
>> +	tx[2] = (*val >> 8) & 0xff;
>> +	tx[3] = (*val >> 0) & 0xff;
>> +
>> +	return spi_write(spi, tx, 4);
IIRC spi_write requires dma safe buffers (cache line aligned
buffers on the heap).
>> +}
>> +
>> +static ssize_t show_voltage(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
>> +	uint32_t conf, mode, val, sign, pos_chan, neg_chan = 0;
>> +	uint8_t status, gain, diff;
>> +	int32_t whole, fract;
>> +	int ret;
>> +
>> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
>> +	struct ad7194_data *pdata = dev_info->dev_data;
Pdata is a bad name choice.  THat implies platform data (by conventional
use).  Here it is instance specific data I think? state is a typical
variable name, or chip.

>> +	struct spi_device *spi = pdata->spi_dev;
>> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +
>> +	pos_chan = this_attr->address;
>> +	gain = pdata->gain[this_attr->address];
>> +	diff = pdata->diff[this_attr->address];
Just general point. Don't bother with local variables for stuff that
is only used once.  Just makes reading harder.
>> +
>> +	if (diff = 1) {
>> +		/*if in0_diff is true, reading in0_input still returns
>> +		* in0, but it is in0-in1, if you read in1_input
>> +		* then you get in1-in0 */
In a nutshell that explains why we don't use the interface you've gone
with but have an explicit one for differential channels. (see the max1363
driver for examples).

>> +		if ((pos_chan % 2) = 0)
>> +			neg_chan = pos_chan+1;
>> +		else
>> +			neg_chan = pos_chan-1;
>> +
>> +		conf = CONF_CHOP_bm | CONF_BUF_bm |
>> +			(pos_chan << CONF_CHAN_POS_bp) |
>> +			(neg_chan << CONF_CHAN_NEG_bp) | gain;
>> +	} else {
>> +		conf = CONF_CHOP_bm | CONF_PSEUDO_bm | CONF_BUF_bm |
>> +			(pos_chan << CONF_CHAN_POS_bp) | gain;
>> +	}
>> +
>> +	ret = mutex_lock_interruptible(&pdata->lock);
>> +	if (ret != 0)
>> +		return ret;
>> +
>> +	ret = ad7194_write_reg24(spi, REG_CONF, &conf);
>> +	if (ret != 0)
>> +		goto out;
>> +
>> +	mode = MODE_MD_SINGLE_gc | MODE_CLK_INTTRI_gc | MODE_FILTER_WORD;
>> +	ret = ad7194_write_reg24(spi, REG_MODE, &mode);
>> +	if (ret != 0)
>> +		goto out;
>> +
>> +	msleep_interruptible(SETTLE_MS);
>> +
>> +	ret = ad7194_read_reg8(spi, REG_STATUS, &status);
>> +	if (ret != 0)
>> +		goto out;
>> +	status = (status >> 6) & 0x01;
>> +
>> +	ret = ad7194_read_reg24(spi, REG_DATA, &val);
>> +	if (ret != 0)
>> +		goto out;
>> +
>> +	sign = (val & 0x800000) >> 23;
>> +	if (sign)
>> +		fract = (val & 0x7fffff);
>> +	else
>> +		fract = 0x7fffff - (val & 0x7fffff);
>> +	fract = ((int64_t)fract*4095000) >> 23;
>> +	fract = fract / gains[gain];
>> +	whole = fract / 1000000;
>> +	fract = fract % 1000000;
As a general rule, we'd push this into userspace, but the interface
allows for either so we can keep this as is if you really want to.
I'd like to see a little comment explaining what the calcuation is
though!
>> +
>> +	if (status = 0) {
>> +		mutex_unlock(&pdata->lock);
>> +		if (sign)
>> +			return sprintf(buf, "%d.%.6d\n", whole, fract);
>> +		else
>> +			return sprintf(buf, "-%d.%.6d\n", whole, fract);
>> +	} else {
>> +		ret = -EAGAIN;
>> +		goto out;
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&pdata->lock);
>> +	return ret;
>> +}
>> +


These don't even vaguely conform to the abi. See
drivers/staging/iio/Documentation/sysfs-bus-iio.  Mostly this will
get cleaned up in converting the driver over to chan_spec based
registration.  Hehe, this reminds me why we introduced the chan spec
stuff in the first place!
>> +static IIO_DEVICE_ATTR(ch1_value, S_IRUGO, show_voltage, NULL, 0);
>> +static IIO_DEVICE_ATTR(ch2_value, S_IRUGO, show_voltage, NULL, 1);
>> +static IIO_DEVICE_ATTR(ch3_value, S_IRUGO, show_voltage, NULL, 2);
>> +static IIO_DEVICE_ATTR(ch4_value, S_IRUGO, show_voltage, NULL, 3);
>> +static IIO_DEVICE_ATTR(ch5_value, S_IRUGO, show_voltage, NULL, 4);
>> +static IIO_DEVICE_ATTR(ch6_value, S_IRUGO, show_voltage, NULL, 5);
>> +static IIO_DEVICE_ATTR(ch7_value, S_IRUGO, show_voltage, NULL, 6);
>> +static IIO_DEVICE_ATTR(ch8_value, S_IRUGO, show_voltage, NULL, 7);
>> +static IIO_DEVICE_ATTR(ch9_value, S_IRUGO, show_voltage, NULL, 8);
>> +static IIO_DEVICE_ATTR(ch10_value, S_IRUGO, show_voltage, NULL, 9);
>> +static IIO_DEVICE_ATTR(ch11_value, S_IRUGO, show_voltage, NULL, 10);
>> +static IIO_DEVICE_ATTR(ch12_value, S_IRUGO, show_voltage, NULL, 11);
>> +static IIO_DEVICE_ATTR(ch13_value, S_IRUGO, show_voltage, NULL, 12);
>> +static IIO_DEVICE_ATTR(ch14_value, S_IRUGO, show_voltage, NULL, 13);
>> +static IIO_DEVICE_ATTR(ch15_value, S_IRUGO, show_voltage, NULL, 14);
>> +static IIO_DEVICE_ATTR(ch16_value, S_IRUGO, show_voltage, NULL, 15);
>> +
>> +static IIO_DEVICE_ATTR(ch1_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 0);
>> +static IIO_DEVICE_ATTR(ch2_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 1);
>> +static IIO_DEVICE_ATTR(ch3_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 2);
>> +static IIO_DEVICE_ATTR(ch4_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 3);
>> +static IIO_DEVICE_ATTR(ch5_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 4);
>> +static IIO_DEVICE_ATTR(ch6_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 5);
>> +static IIO_DEVICE_ATTR(ch7_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 6);
>> +static IIO_DEVICE_ATTR(ch8_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 7);
>> +static IIO_DEVICE_ATTR(ch9_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 8);
>> +static IIO_DEVICE_ATTR(ch10_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 9);
>> +static IIO_DEVICE_ATTR(ch11_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 10);
>> +static IIO_DEVICE_ATTR(ch12_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 11);
>> +static IIO_DEVICE_ATTR(ch13_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 12);
>> +static IIO_DEVICE_ATTR(ch14_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 13);
>> +static IIO_DEVICE_ATTR(ch15_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 14);
>> +static IIO_DEVICE_ATTR(ch16_gain, S_IWUSR | S_IRUGO, show_gain, set_gain, 15);
>> +

Umm.. What are these?  I think based on quick look at the datasheet that you
are using them to switch the _value attributes from unipolar to differential?
Please register them as separate channels (see max1363 for lots and lots of
examples).  It can be a bit fiddly to maintain the internal state but it does
give us a coherent general interface.
>> +static IIO_DEVICE_ATTR(ch1_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 0);
>> +static IIO_DEVICE_ATTR(ch2_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 1);
>> +static IIO_DEVICE_ATTR(ch3_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 2);
>> +static IIO_DEVICE_ATTR(ch4_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 3);
>> +static IIO_DEVICE_ATTR(ch5_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 4);
>> +static IIO_DEVICE_ATTR(ch6_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 5);
>> +static IIO_DEVICE_ATTR(ch7_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 6);
>> +static IIO_DEVICE_ATTR(ch8_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 7);
>> +static IIO_DEVICE_ATTR(ch9_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 8);
>> +static IIO_DEVICE_ATTR(ch10_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 9);
>> +static IIO_DEVICE_ATTR(ch11_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 10);
>> +static IIO_DEVICE_ATTR(ch12_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 11);
>> +static IIO_DEVICE_ATTR(ch13_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 12);
>> +static IIO_DEVICE_ATTR(ch14_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 13);
>> +static IIO_DEVICE_ATTR(ch15_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 14);
>> +static IIO_DEVICE_ATTR(ch16_diff, S_IWUSR | S_IRUGO, show_diff, set_diff, 15);
>> +
>> +static struct attribute *ad7194_attributes[] = {
>> +	&iio_dev_attr_ch1_value.dev_attr.attr,
>> +	&iio_dev_attr_ch2_value.dev_attr.attr,
>> +	&iio_dev_attr_ch3_value.dev_attr.attr,
>> +	&iio_dev_attr_ch4_value.dev_attr.attr,
>> +	&iio_dev_attr_ch5_value.dev_attr.attr,
>> +	&iio_dev_attr_ch6_value.dev_attr.attr,
>> +	&iio_dev_attr_ch7_value.dev_attr.attr,
>> +	&iio_dev_attr_ch8_value.dev_attr.attr,
>> +	&iio_dev_attr_ch9_value.dev_attr.attr,
>> +	&iio_dev_attr_ch10_value.dev_attr.attr,
>> +	&iio_dev_attr_ch11_value.dev_attr.attr,
>> +	&iio_dev_attr_ch12_value.dev_attr.attr,
>> +	&iio_dev_attr_ch13_value.dev_attr.attr,
>> +	&iio_dev_attr_ch14_value.dev_attr.attr,
>> +	&iio_dev_attr_ch15_value.dev_attr.attr,
>> +	&iio_dev_attr_ch16_value.dev_attr.attr,
>> +	&iio_dev_attr_ch1_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch2_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch3_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch4_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch5_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch6_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch7_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch8_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch9_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch10_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch11_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch12_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch13_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch14_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch15_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch16_gain.dev_attr.attr,
>> +	&iio_dev_attr_ch1_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch2_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch3_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch4_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch5_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch6_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch7_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch8_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch9_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch10_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch11_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch12_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch13_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch14_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch15_diff.dev_attr.attr,
>> +	&iio_dev_attr_ch16_diff.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group ad7194_attribute_group = {
>> +	.attrs = ad7194_attributes,
>> +};
>> +
>> +static const struct iio_info ad7194_info = {
>> +	.attrs = &ad7194_attribute_group,
>> +	.driver_module = THIS_MODULE,
>> +};
>> +
>> +static int __devinit ad7194_probe(struct spi_device *spi)
>> +{
>> +	int ret, err;
>> +	struct ad7194_data *pdata;
>> +
>> +	/* Configure the SPI bus */
>> +	spi->mode = (SPI_MODE_0);
>> +	spi->bits_per_word = 8;
>> +	spi_setup(spi);
>> +
>> +	pdata = kzalloc(sizeof(struct ad7194_data), GFP_KERNEL);
>> +	if (!pdata) {
>> +		err = -ENOMEM;
>> +		goto exit;
>> +	}
>> +
>> +	dev_set_drvdata(&spi->dev, pdata);
>> +
>> +	pdata->spi_dev = spi;
>> +
>> +	pdata->indio_dev = iio_allocate_device(0);
>> +	if (pdata->indio_dev = NULL) {
>> +		ret = -ENOMEM;
>> +		goto error_free;
>> +	}
>> +
>> +	mutex_init(&pdata->lock);
>> +	pdata->indio_dev->name = "ad7194";
>> +	pdata->indio_dev->dev.parent = &spi->dev;
>> +	pdata->indio_dev->info = &ad7194_info;
>> +	pdata->indio_dev->dev_data = (void *)pdata;
Devdata is going away I'm afraid (only still there in
1 driver and that's because Jon is having issues getting
the kernel up and running on his board to check I haven't
messed up the conversion!)  Please do this with
iio_allocate_device(sizeof(*pdata)), then use iio_priv
to get to the resulting private data.

>> +
>> +	ret = iio_device_register(pdata->indio_dev);
>> +	if (ret)
>> +		goto error_free_dev;
>> +
>> +	return 0;
>> +
>> +error_free_dev:
>> +	iio_free_device(pdata->indio_dev);
>> +error_free:
>> +	kfree(pdata);
>> +exit:
>> +	return err;
>> +}
>> +
>> +static int __devexit ad7194_remove(struct spi_device *spi)
>> +{
>> +	struct ad7194_data *pdata = dev_get_drvdata(&spi->dev);
>> +
>> +	dev_set_drvdata(&spi->dev, NULL);
>> +	iio_device_unregister(pdata->indio_dev);
>> +	iio_free_device(pdata->indio_dev);
>> +	kfree(pdata);
>> +	return 0;
>> +}
>> +
>> +static struct spi_driver ad7194_driver = {
>> +	.driver = {
I've never understood why people like having a define
for the part name.  Much better to just put it here
where everyone expects to find it!

>> +		.name = DEVICE_NAME,
>> +		.bus = &spi_bus_type,
>> +		.owner = THIS_MODULE,
>> +	},
>> +
>> +	.probe = ad7194_probe,
>> +	.remove = __devexit_p(ad7194_remove),
>> +};
>> +
>> +static int __init ad7194_init(void)
>> +{
>> +	return spi_register_driver(&ad7194_driver);
>> +}
>> +
>> +static void __exit ad7194_exit(void)
>> +{
>> +	spi_unregister_driver(&ad7194_driver);
>> +}
>> +
>> +module_init(ad7194_init);
>> +module_exit(ad7194_exit);
>> +
>> +MODULE_AUTHOR("Paul Thomas <pthomas8589@gmail.com>");
>> +MODULE_DESCRIPTION("TI AD7194 A/D driver");
>> +MODULE_LICENSE("GPL");
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
