From: Paul Thomas <pthomas8589@gmail.com>
Date: Mon, 18 Jul 2011 17:11:07 +0000
Subject: Re: [lm-sensors] [PATCH] iio: add support for Analog Devices ad7194
Message-Id: <CAD56B7fCuCHzjOz=VDE29-mUtVet3mcDmR4TmEGokKtXTOKr2g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310975165-19912-1-git-send-email-pthomas8589@gmail.com>
	<4E241286.3090103@cam.ac.uk>
	<4E242605.9050400@cam.ac.uk>
In-Reply-To: <4E242605.9050400@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: lm-sensors@lm-sensors.org, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>

Aside from the ABI stuff, I had a couple responses to your comments.

thanks,
Paul

>>>
>>> Signed-off-by: Paul Thomas <pthomas8589@gmail.com>
>>> ---
>>> =A0drivers/staging/iio/adc/Kconfig =A0| =A0 =A07 +
>>> =A0drivers/staging/iio/adc/Makefile | =A0 =A01 +
>>> =A0drivers/staging/iio/adc/ad7194.c | =A0462 ++++++++++++++++++++++++++=
++++++++++++
>>> =A03 files changed, 470 insertions(+), 0 deletions(-)
>>> =A0create mode 100644 drivers/staging/iio/adc/ad7194.c
>>>
>>> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/=
Kconfig
>>> index 8c751c4..871605b 100644
>>> --- a/drivers/staging/iio/adc/Kconfig
>>> +++ b/drivers/staging/iio/adc/Kconfig
>>> @@ -17,6 +17,13 @@ config AD7152
>>> =A0 =A0 =A0 =A0Say yes here to build support for Analog Devices capacit=
ive sensors.
>>> =A0 =A0 =A0 =A0(ad7152, ad7153) Provides direct access via sysfs.
>>>
>>> +config AD7194
>>> + =A0 =A0tristate "Analog Devices AD7194 ADC driver"
>>> + =A0 =A0depends on SPI
>>> + =A0 =A0help
>>> + =A0 =A0 =A0Say yes here to build support for Analog Devices ad7194.
>>> + =A0 =A0 =A0Provides direct access via sysfs.
>>> +
>>> =A0config AD7291
>>> =A0 =A0 =A0tristate "Analog Devices AD7291 temperature sensor driver"
>>> =A0 =A0 =A0depends on I2C
>>> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc=
/Makefile
>>> index 1d9b3f5..4da3c40 100644
>>> --- a/drivers/staging/iio/adc/Makefile
>>> +++ b/drivers/staging/iio/adc/Makefile
>>> @@ -31,6 +31,7 @@ obj-$(CONFIG_AD7298) +=3D ad7298.o
>>>
>>> =A0obj-$(CONFIG_AD7150) +=3D ad7150.o
>>> =A0obj-$(CONFIG_AD7152) +=3D ad7152.o
>>> +obj-$(CONFIG_AD7194) +=3D ad7194.o
>>> =A0obj-$(CONFIG_AD7291) +=3D ad7291.o
>>> =A0obj-$(CONFIG_AD7314) +=3D ad7314.o
>>> =A0obj-$(CONFIG_AD7745) +=3D ad7745.o
>>> diff --git a/drivers/staging/iio/adc/ad7194.c b/drivers/staging/iio/adc=
/ad7194.c
>>> new file mode 100644
>>> index 0000000..a867662
>>> --- /dev/null
>>> +++ b/drivers/staging/iio/adc/ad7194.c
>>> @@ -0,0 +1,462 @@
>>> +/*
>>> + * =A0ad7194 - driver for Analog Devices AD7194 A/D converter
>>> + *
>>> + * =A0Copyright (c) 2011 Paul Thomas <pthomas8589@gmail.com>
>>> + *
>>> + * =A0This program is distributed in the hope that it will be useful,
>>> + * =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>> + * =A0GNU General Public License for more details.
>>> + *
>>> + * =A0This program is free software; you can redistribute it and/or mo=
dify
>>> + * =A0it under the terms of the GNU General Public License version 2 or
>>> + * =A0later as publishhed by the Free Software Foundation.
>>> + *
>>> + * =A0You need to have something like this in struct spi_board_info
>>> + * =A0{
>>> + * =A0 =A0 =A0 =A0 =A0.modalias =A0 =A0 =A0 =3D "ad7194",
>>> + * =A0 =A0 =A0 =A0 =A0.max_speed_hz =A0 =3D 2*1000*1000,
>>> + * =A0 =A0 =A0 =A0 =A0.chip_select =A0 =A0=3D 0,
>>> + * =A0 =A0 =A0 =A0 =A0.bus_num =A0 =A0 =A0 =A0=3D 1,
>>> + * =A0},
>>> + *
>>> + * Three sysfs files are used chX_value, chX_diff and chX_gain
>>> + * chX_value is read only and returns that channels value in volts.
>>> + * chX_gain is read/write, the chX_value is scaled by the gain so it r=
etains
>>> + * it's proper units.
>>> + * chX_diff is read/write, if chX_diff is 0 then pseude mod is used,
>>> + * if chX_diff is 1 then differential mode is used.
>>> + * In this mode ch1_value selects ch1-ch2, and ch2_value selects ch2-c=
h1
>>> + */
>>> +
>>> +#define DEBUG 1
>>> +
>>> +/*From Table 15 in the datasheet*/
>>> +/*Register addresses*/
>>> +#define REG_STATUS =A00
>>> +#define REG_MODE =A0 =A01
>>> +#define REG_CONF =A0 =A02
>>> +#define REG_DATA =A0 =A03
>>> +#define REG_ID =A0 =A0 =A04
>>> +#define REG_GPOCON =A05
>>> +#define REG_OFFSET =A06
>>> +#define REG_FS =A0 =A0 =A07
>>> +
>>> +/*From Table 15 in the datasheet*/
>>> +#define COMM_ADDR_bp 3
>>> +#define COMM_READ_bm (1 << 6)
>>> +
>>> +#define CONF_CHOP_bm (1 << 23)
>>> +#define CONF_PSEUDO_bm (1 << 18)
>>> +#define CONF_BUF_bm (1 << 4)
>>> +#define CONF_CHAN_NEG_bp 8
>>> +#define CONF_CHAN_POS_bp 12
>>> +
>>> +
>>> +#define MODE_MD_SINGLE_gc (0x01 << 21)
>>> +#define MODE_MD_ZS_CAL_gc (0x04 << 21)
>>> +#define MODE_MD_FS_CAL_gc (0x05 << 21)
>>> +#define MODE_CLK_INTTRI_gc (0x02 << 18)
>>> +/*Table 8 in the datasheet provides options for the Filter Word*/
>>> +#define MODE_FILTER_WORD 1
>>> +#define SETTLE_MS 2
>>> +
>>> +#include <linux/device.h>
>>> +#include <linux/module.h>
>>> +#include <linux/init.h>
>>> +#include <linux/spi/spi.h>
>>> +#include <linux/err.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/delay.h>
>>> +
>>> +#include "../iio.h"
>>> +#include "../sysfs.h"
>>> +
>>> +#define DEVICE_NAME "ad7194"
>>> +#define NUM_CHANNELS 16
>>> +
> This wins the odd award. =A0The available gains seem unlikely to be tied =
to the
> number of channels.
Right! what was I thinking?

>>> +const uint8_t gains[NUM_CHANNELS] =3D {1, 0, 0, 8, 16, 32, 64, 128};
>>> +
>>> +struct ad7194_data {
>>> + =A0 =A0struct spi_device *spi_dev;
>>> + =A0 =A0struct iio_dev *indio_dev;
>>> + =A0 =A0uint8_t gain[NUM_CHANNELS];
>>> + =A0 =A0uint8_t diff[NUM_CHANNELS];
>>> + =A0 =A0struct mutex lock;
>>> +};
>>> +
>>> +static ssize_t show_gain(struct device *dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute *attr, char *buf)
>>> +{
>>> + =A0 =A0struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>>> + =A0 =A0struct ad7194_data *pdata =3D dev_info->dev_data;
>>> + =A0 =A0struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>>> +
>>> + =A0 =A0return sprintf(buf, "%d\n", gains[pdata->gain[this_attr->addre=
ss]]);
>>> +}
>>> +
>>> +static ssize_t set_gain(struct device *dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute *attr, const char *buf=
, size_t count)
>>> +{
>>> + =A0 =A0uint8_t gain_real, i;
>>> + =A0 =A0struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>>> + =A0 =A0struct ad7194_data *pdata =3D dev_info->dev_data;
>>> + =A0 =A0struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>>> +
>>> + =A0 =A0gain_real =3D simple_strtol(buf, NULL, 10);
>>> + =A0 =A0if (gain_real =3D 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0return -EPERM;
>>> + =A0 =A0for (i =3D 0; i < NUM_CHANNELS; i++) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0if (gains[i] =3D gain_real) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->gain[this_attr->address=
] =3D =A0i;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return count;
>>> + =A0 =A0 =A0 =A0 =A0 =A0}
>>> + =A0 =A0}
>>> + =A0 =A0return -EPERM;
>>> +}
>>> +
>>> +static ssize_t show_diff(struct device *dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute *attr, char *buf)
>>> +{
>>> + =A0 =A0struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>>> + =A0 =A0struct ad7194_data *pdata =3D dev_info->dev_data;
>>> + =A0 =A0struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>>> +
>>> + =A0 =A0return sprintf(buf, "%d\n", pdata->diff[this_attr->address]);
>>> +}
>>> +
>>> +static ssize_t set_diff(struct device *dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute *attr, const char *buf=
, size_t count)
>>> +{
>>> + =A0 =A0uint8_t diff;
>>> + =A0 =A0struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>>> + =A0 =A0struct ad7194_data *pdata =3D dev_info->dev_data;
>>> + =A0 =A0struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>>> +
>>> + =A0 =A0diff =3D simple_strtol(buf, NULL, 10);
> strtobool and set value to the resulting bool.
>>> + =A0 =A0if (diff)
>>> + =A0 =A0 =A0 =A0 =A0 =A0pdata->diff[this_attr->address] =3D 1;
>>> + =A0 =A0else
>>> + =A0 =A0 =A0 =A0 =A0 =A0pdata->diff[this_attr->address] =3D 0;
>>> + =A0 =A0return count;
>>> +}
>>> +
>>> +static inline int ad7194_read_reg8(struct spi_device *spi,
>>> + =A0 =A0 =A0 =A0 =A0 =A0int reg, uint8_t *val)
>>> +{
>>> + =A0 =A0int ret;
>>> + =A0 =A0uint8_t tx[1], rx[1];
>>> +
>>> + =A0 =A0tx[0] =3D (COMM_READ_bm | (reg << COMM_ADDR_bp));
>>> +
>>> + =A0 =A0ret =3D spi_write_then_read(spi, tx, 1, rx, 1);
>>> + =A0 =A0*val =3D rx[0];
>>> + =A0 =A0return ret;
>>> +}
>>> +
>>> +static inline int ad7194_read_reg24(struct spi_device *spi,
>>> + =A0 =A0 =A0 =A0 =A0 =A0int reg, uint32_t *val)
>>> +{
>>> + =A0 =A0int ret;
>>> + =A0 =A0uint8_t tx[1], rx[3];
>>> +
>>> + =A0 =A0tx[0] =3D (COMM_READ_bm | (reg << COMM_ADDR_bp));
> Don't allocate single element arrays. =A0Just makes things
> harder to read.
I was trying to keep consistency between the _reg8 & _reg24 versions
as well as between the rx & tx buffers. It makes the
spi_write_then_read(spi, tx, 1, rx, 3) read nicely, but if that's a
no-no then I can change it.

>
>>> +
>>> + =A0 =A0ret =3D spi_write_then_read(spi, tx, 1, rx, 3);
>>> + =A0 =A0*val =3D (rx[0] << 16) + (rx[1] << 8) + rx[2];
>>> + =A0 =A0return ret;
>>> +}
>>> +
>>> +static inline int ad7194_write_reg24(struct spi_device *spi,
>>> + =A0 =A0 =A0 =A0 =A0 =A0int reg, uint32_t *val)
>>> +{
>>> + =A0 =A0uint8_t tx[4];
>>> +
>>> + =A0 =A0tx[0] =3D (reg << COMM_ADDR_bp);
>>> + =A0 =A0tx[1] =3D (*val >> 16) & 0xff;
>>> + =A0 =A0tx[2] =3D (*val >> 8) & 0xff;
>>> + =A0 =A0tx[3] =3D (*val >> 0) & 0xff;
>>> +
>>> + =A0 =A0return spi_write(spi, tx, 4);
> IIRC spi_write requires dma safe buffers (cache line aligned
> buffers on the heap).
Could you expand here?

>>> +}
>>> +
>>> +static ssize_t show_voltage(struct device *dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute *attr, char *buf)
>>> +{
>>> + =A0 =A0uint32_t conf, mode, val, sign, pos_chan, neg_chan =3D 0;
>>> + =A0 =A0uint8_t status, gain, diff;
>>> + =A0 =A0int32_t whole, fract;
>>> + =A0 =A0int ret;
>>> +
>>> + =A0 =A0struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>>> + =A0 =A0struct ad7194_data *pdata =3D dev_info->dev_data;
> Pdata is a bad name choice. =A0THat implies platform data (by conventional
> use). =A0Here it is instance specific data I think? state is a typical
> variable name, or chip.
>
>>> + =A0 =A0struct spi_device *spi =3D pdata->spi_dev;
>>> + =A0 =A0struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>>> +
>>> + =A0 =A0pos_chan =3D this_attr->address;
>>> + =A0 =A0gain =3D pdata->gain[this_attr->address];
>>> + =A0 =A0diff =3D pdata->diff[this_attr->address];
> Just general point. Don't bother with local variables for stuff that
> is only used once. =A0Just makes reading harder.
>>> +
>>> + =A0 =A0if (diff =3D 1) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0/*if in0_diff is true, reading in0_input still=
 returns
>>> + =A0 =A0 =A0 =A0 =A0 =A0* in0, but it is in0-in1, if you read in1_input
>>> + =A0 =A0 =A0 =A0 =A0 =A0* then you get in1-in0 */
> In a nutshell that explains why we don't use the interface you've gone
> with but have an explicit one for differential channels. (see the max1363
> driver for examples).
>
>>> + =A0 =A0 =A0 =A0 =A0 =A0if ((pos_chan % 2) =3D 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0neg_chan =3D pos_chan+1;
>>> + =A0 =A0 =A0 =A0 =A0 =A0else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0neg_chan =3D pos_chan-1;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0conf =3D CONF_CHOP_bm | CONF_BUF_bm |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pos_chan << CONF_CHAN_POS_bp)=
 |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(neg_chan << CONF_CHAN_NEG_bp)=
 | gain;
>>> + =A0 =A0} else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0conf =3D CONF_CHOP_bm | CONF_PSEUDO_bm | CONF_=
BUF_bm |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pos_chan << CONF_CHAN_POS_bp)=
 | gain;
>>> + =A0 =A0}
>>> +
>>> + =A0 =A0ret =3D mutex_lock_interruptible(&pdata->lock);
>>> + =A0 =A0if (ret !=3D 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0return ret;
>>> +
>>> + =A0 =A0ret =3D ad7194_write_reg24(spi, REG_CONF, &conf);
>>> + =A0 =A0if (ret !=3D 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0goto out;
>>> +
>>> + =A0 =A0mode =3D MODE_MD_SINGLE_gc | MODE_CLK_INTTRI_gc | MODE_FILTER_=
WORD;
>>> + =A0 =A0ret =3D ad7194_write_reg24(spi, REG_MODE, &mode);
>>> + =A0 =A0if (ret !=3D 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0goto out;
>>> +
>>> + =A0 =A0msleep_interruptible(SETTLE_MS);
>>> +
>>> + =A0 =A0ret =3D ad7194_read_reg8(spi, REG_STATUS, &status);
>>> + =A0 =A0if (ret !=3D 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0goto out;
>>> + =A0 =A0status =3D (status >> 6) & 0x01;
>>> +
>>> + =A0 =A0ret =3D ad7194_read_reg24(spi, REG_DATA, &val);
>>> + =A0 =A0if (ret !=3D 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0goto out;
>>> +
>>> + =A0 =A0sign =3D (val & 0x800000) >> 23;
>>> + =A0 =A0if (sign)
>>> + =A0 =A0 =A0 =A0 =A0 =A0fract =3D (val & 0x7fffff);
>>> + =A0 =A0else
>>> + =A0 =A0 =A0 =A0 =A0 =A0fract =3D 0x7fffff - (val & 0x7fffff);
>>> + =A0 =A0fract =3D ((int64_t)fract*4095000) >> 23;
>>> + =A0 =A0fract =3D fract / gains[gain];
>>> + =A0 =A0whole =3D fract / 1000000;
>>> + =A0 =A0fract =3D fract % 1000000;
> As a general rule, we'd push this into userspace, but the interface
> allows for either so we can keep this as is if you really want to.
> I'd like to see a little comment explaining what the calcuation is
> though!
>>> +
>>> + =A0 =A0if (status =3D 0) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&pdata->lock);
>>> + =A0 =A0 =A0 =A0 =A0 =A0if (sign)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return sprintf(buf, "%d.%.6d\n=
", whole, fract);
>>> + =A0 =A0 =A0 =A0 =A0 =A0else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return sprintf(buf, "-%d.%.6d\=
n", whole, fract);
>>> + =A0 =A0} else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EAGAIN;
>>> + =A0 =A0 =A0 =A0 =A0 =A0goto out;
>>> + =A0 =A0}
>>> +
>>> +out:
>>> + =A0 =A0mutex_unlock(&pdata->lock);
>>> + =A0 =A0return ret;
>>> +}
>>> +
>
>
> These don't even vaguely conform to the abi. See
> drivers/staging/iio/Documentation/sysfs-bus-iio. =A0Mostly this will
> get cleaned up in converting the driver over to chan_spec based
> registration. =A0Hehe, this reminds me why we introduced the chan spec
> stuff in the first place!
>>> +static IIO_DEVICE_ATTR(ch1_value, S_IRUGO, show_voltage, NULL, 0);
>>> +static IIO_DEVICE_ATTR(ch2_value, S_IRUGO, show_voltage, NULL, 1);
>>> +static IIO_DEVICE_ATTR(ch3_value, S_IRUGO, show_voltage, NULL, 2);
>>> +static IIO_DEVICE_ATTR(ch4_value, S_IRUGO, show_voltage, NULL, 3);
>>> +static IIO_DEVICE_ATTR(ch5_value, S_IRUGO, show_voltage, NULL, 4);
>>> +static IIO_DEVICE_ATTR(ch6_value, S_IRUGO, show_voltage, NULL, 5);
>>> +static IIO_DEVICE_ATTR(ch7_value, S_IRUGO, show_voltage, NULL, 6);
>>> +static IIO_DEVICE_ATTR(ch8_value, S_IRUGO, show_voltage, NULL, 7);
>>> +static IIO_DEVICE_ATTR(ch9_value, S_IRUGO, show_voltage, NULL, 8);
>>> +static IIO_DEVICE_ATTR(ch10_value, S_IRUGO, show_voltage, NULL, 9);
>>> +static IIO_DEVICE_ATTR(ch11_value, S_IRUGO, show_voltage, NULL, 10);
>>> +static IIO_DEVICE_ATTR(ch12_value, S_IRUGO, show_voltage, NULL, 11);
>>> +static IIO_DEVICE_ATTR(ch13_value, S_IRUGO, show_voltage, NULL, 12);
>>> +static IIO_DEVICE_ATTR(ch14_value, S_IRUGO, show_voltage, NULL, 13);
>>> +static IIO_DEVICE_ATTR(ch15_value, S_IRUGO, show_voltage, NULL, 14);
>>> +static IIO_DEVICE_ATTR(ch16_value, S_IRUGO, show_voltage, NULL, 15);
>>> +
>>> +static IIO_DEVICE_ATTR(ch1_gain, S_IWUSR | S_IRUGO, show_gain, set_gai=
n, 0);
>>> +static IIO_DEVICE_ATTR(ch2_gain, S_IWUSR | S_IRUGO, show_gain, set_gai=
n, 1);
>>> +static IIO_DEVICE_ATTR(ch3_gain, S_IWUSR | S_IRUGO, show_gain, set_gai=
n, 2);
>>> +static IIO_DEVICE_ATTR(ch4_gain, S_IWUSR | S_IRUGO, show_gain, set_gai=
n, 3);
>>> +static IIO_DEVICE_ATTR(ch5_gain, S_IWUSR | S_IRUGO, show_gain, set_gai=
n, 4);
>>> +static IIO_DEVICE_ATTR(ch6_gain, S_IWUSR | S_IRUGO, show_gain, set_gai=
n, 5);
>>> +static IIO_DEVICE_ATTR(ch7_gain, S_IWUSR | S_IRUGO, show_gain, set_gai=
n, 6);
>>> +static IIO_DEVICE_ATTR(ch8_gain, S_IWUSR | S_IRUGO, show_gain, set_gai=
n, 7);
>>> +static IIO_DEVICE_ATTR(ch9_gain, S_IWUSR | S_IRUGO, show_gain, set_gai=
n, 8);
>>> +static IIO_DEVICE_ATTR(ch10_gain, S_IWUSR | S_IRUGO, show_gain, set_ga=
in, 9);
>>> +static IIO_DEVICE_ATTR(ch11_gain, S_IWUSR | S_IRUGO, show_gain, set_ga=
in, 10);
>>> +static IIO_DEVICE_ATTR(ch12_gain, S_IWUSR | S_IRUGO, show_gain, set_ga=
in, 11);
>>> +static IIO_DEVICE_ATTR(ch13_gain, S_IWUSR | S_IRUGO, show_gain, set_ga=
in, 12);
>>> +static IIO_DEVICE_ATTR(ch14_gain, S_IWUSR | S_IRUGO, show_gain, set_ga=
in, 13);
>>> +static IIO_DEVICE_ATTR(ch15_gain, S_IWUSR | S_IRUGO, show_gain, set_ga=
in, 14);
>>> +static IIO_DEVICE_ATTR(ch16_gain, S_IWUSR | S_IRUGO, show_gain, set_ga=
in, 15);
>>> +
>
> Umm.. What are these? =A0I think based on quick look at the datasheet tha=
t you
> are using them to switch the _value attributes from unipolar to different=
ial?
> Please register them as separate channels (see max1363 for lots and lots =
of
> examples). =A0It can be a bit fiddly to maintain the internal state but i=
t does
> give us a coherent general interface.
>>> +static IIO_DEVICE_ATTR(ch1_diff, S_IWUSR | S_IRUGO, show_diff, set_dif=
f, 0);
>>> +static IIO_DEVICE_ATTR(ch2_diff, S_IWUSR | S_IRUGO, show_diff, set_dif=
f, 1);
>>> +static IIO_DEVICE_ATTR(ch3_diff, S_IWUSR | S_IRUGO, show_diff, set_dif=
f, 2);
>>> +static IIO_DEVICE_ATTR(ch4_diff, S_IWUSR | S_IRUGO, show_diff, set_dif=
f, 3);
>>> +static IIO_DEVICE_ATTR(ch5_diff, S_IWUSR | S_IRUGO, show_diff, set_dif=
f, 4);
>>> +static IIO_DEVICE_ATTR(ch6_diff, S_IWUSR | S_IRUGO, show_diff, set_dif=
f, 5);
>>> +static IIO_DEVICE_ATTR(ch7_diff, S_IWUSR | S_IRUGO, show_diff, set_dif=
f, 6);
>>> +static IIO_DEVICE_ATTR(ch8_diff, S_IWUSR | S_IRUGO, show_diff, set_dif=
f, 7);
>>> +static IIO_DEVICE_ATTR(ch9_diff, S_IWUSR | S_IRUGO, show_diff, set_dif=
f, 8);
>>> +static IIO_DEVICE_ATTR(ch10_diff, S_IWUSR | S_IRUGO, show_diff, set_di=
ff, 9);
>>> +static IIO_DEVICE_ATTR(ch11_diff, S_IWUSR | S_IRUGO, show_diff, set_di=
ff, 10);
>>> +static IIO_DEVICE_ATTR(ch12_diff, S_IWUSR | S_IRUGO, show_diff, set_di=
ff, 11);
>>> +static IIO_DEVICE_ATTR(ch13_diff, S_IWUSR | S_IRUGO, show_diff, set_di=
ff, 12);
>>> +static IIO_DEVICE_ATTR(ch14_diff, S_IWUSR | S_IRUGO, show_diff, set_di=
ff, 13);
>>> +static IIO_DEVICE_ATTR(ch15_diff, S_IWUSR | S_IRUGO, show_diff, set_di=
ff, 14);
>>> +static IIO_DEVICE_ATTR(ch16_diff, S_IWUSR | S_IRUGO, show_diff, set_di=
ff, 15);
>>> +
>>> +static struct attribute *ad7194_attributes[] =3D {
>>> + =A0 =A0&iio_dev_attr_ch1_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch2_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch3_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch4_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch5_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch6_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch7_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch8_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch9_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch10_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch11_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch12_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch13_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch14_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch15_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch16_value.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch1_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch2_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch3_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch4_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch5_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch6_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch7_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch8_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch9_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch10_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch11_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch12_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch13_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch14_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch15_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch16_gain.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch1_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch2_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch3_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch4_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch5_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch6_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch7_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch8_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch9_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch10_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch11_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch12_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch13_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch14_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch15_diff.dev_attr.attr,
>>> + =A0 =A0&iio_dev_attr_ch16_diff.dev_attr.attr,
>>> + =A0 =A0NULL,
>>> +};
>>> +
>>> +static const struct attribute_group ad7194_attribute_group =3D {
>>> + =A0 =A0.attrs =3D ad7194_attributes,
>>> +};
>>> +
>>> +static const struct iio_info ad7194_info =3D {
>>> + =A0 =A0.attrs =3D &ad7194_attribute_group,
>>> + =A0 =A0.driver_module =3D THIS_MODULE,
>>> +};
>>> +
>>> +static int __devinit ad7194_probe(struct spi_device *spi)
>>> +{
>>> + =A0 =A0int ret, err;
>>> + =A0 =A0struct ad7194_data *pdata;
>>> +
>>> + =A0 =A0/* Configure the SPI bus */
>>> + =A0 =A0spi->mode =3D (SPI_MODE_0);
>>> + =A0 =A0spi->bits_per_word =3D 8;
>>> + =A0 =A0spi_setup(spi);
>>> +
>>> + =A0 =A0pdata =3D kzalloc(sizeof(struct ad7194_data), GFP_KERNEL);
>>> + =A0 =A0if (!pdata) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0err =3D -ENOMEM;
>>> + =A0 =A0 =A0 =A0 =A0 =A0goto exit;
>>> + =A0 =A0}
>>> +
>>> + =A0 =A0dev_set_drvdata(&spi->dev, pdata);
>>> +
>>> + =A0 =A0pdata->spi_dev =3D spi;
>>> +
>>> + =A0 =A0pdata->indio_dev =3D iio_allocate_device(0);
>>> + =A0 =A0if (pdata->indio_dev =3D NULL) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM;
>>> + =A0 =A0 =A0 =A0 =A0 =A0goto error_free;
>>> + =A0 =A0}
>>> +
>>> + =A0 =A0mutex_init(&pdata->lock);
>>> + =A0 =A0pdata->indio_dev->name =3D "ad7194";
>>> + =A0 =A0pdata->indio_dev->dev.parent =3D &spi->dev;
>>> + =A0 =A0pdata->indio_dev->info =3D &ad7194_info;
>>> + =A0 =A0pdata->indio_dev->dev_data =3D (void *)pdata;
> Devdata is going away I'm afraid (only still there in
> 1 driver and that's because Jon is having issues getting
> the kernel up and running on his board to check I haven't
> messed up the conversion!) =A0Please do this with
> iio_allocate_device(sizeof(*pdata)), then use iio_priv
> to get to the resulting private data.
>
>>> +
>>> + =A0 =A0ret =3D iio_device_register(pdata->indio_dev);
>>> + =A0 =A0if (ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0goto error_free_dev;
>>> +
>>> + =A0 =A0return 0;
>>> +
>>> +error_free_dev:
>>> + =A0 =A0iio_free_device(pdata->indio_dev);
>>> +error_free:
>>> + =A0 =A0kfree(pdata);
>>> +exit:
>>> + =A0 =A0return err;
>>> +}
>>> +
>>> +static int __devexit ad7194_remove(struct spi_device *spi)
>>> +{
>>> + =A0 =A0struct ad7194_data *pdata =3D dev_get_drvdata(&spi->dev);
>>> +
>>> + =A0 =A0dev_set_drvdata(&spi->dev, NULL);
>>> + =A0 =A0iio_device_unregister(pdata->indio_dev);
>>> + =A0 =A0iio_free_device(pdata->indio_dev);
>>> + =A0 =A0kfree(pdata);
>>> + =A0 =A0return 0;
>>> +}
>>> +
>>> +static struct spi_driver ad7194_driver =3D {
>>> + =A0 =A0.driver =3D {
> I've never understood why people like having a define
> for the part name. =A0Much better to just put it here
> where everyone expects to find it!
>
>>> + =A0 =A0 =A0 =A0 =A0 =A0.name =3D DEVICE_NAME,
>>> + =A0 =A0 =A0 =A0 =A0 =A0.bus =3D &spi_bus_type,
>>> + =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
>>> + =A0 =A0},
>>> +
>>> + =A0 =A0.probe =3D ad7194_probe,
>>> + =A0 =A0.remove =3D __devexit_p(ad7194_remove),
>>> +};
>>> +
>>> +static int __init ad7194_init(void)
>>> +{
>>> + =A0 =A0return spi_register_driver(&ad7194_driver);
>>> +}
>>> +
>>> +static void __exit ad7194_exit(void)
>>> +{
>>> + =A0 =A0spi_unregister_driver(&ad7194_driver);
>>> +}
>>> +
>>> +module_init(ad7194_init);
>>> +module_exit(ad7194_exit);
>>> +
>>> +MODULE_AUTHOR("Paul Thomas <pthomas8589@gmail.com>");
>>> +MODULE_DESCRIPTION("TI AD7194 A/D driver");
>>> +MODULE_LICENSE("GPL");
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
