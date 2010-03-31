From: Paul Thomas <pthomas8589@gmail.com>
Date: Wed, 31 Mar 2010 15:02:58 +0000
Subject: Re: [lm-sensors] [PATCH] V3, TI ads7871 a/d converter,
Message-Id: <s2lc785bba31003310802v27f3cc2zaf8c8f53a4ee6835@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1269124170-11623-1-git-send-email-pthomas8589@gmail.com>
In-Reply-To: <1269124170-11623-1-git-send-email-pthomas8589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Great, just a couple of responses.

On Wed, Mar 31, 2010 at 7:52 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 03/20/10 22:29, Paul Thomas wrote:
>> return -ENODEV if spi is ok, but you can't read OSC reg
>> removed most dev_dbg
>> passes checkpatch
>
> Now looks fine to me, though there is one bit of style that I'm
> surprised gets past checkpatch....
>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>
> There are a few things I'd like to see in addition, but
> they can easily occur later in an incremental patch...
>>
>> Signed-off-by: Paul Thomas <pthomas8589@gmail.com>
>> ---
>> =A0drivers/hwmon/Kconfig =A0 | =A0 =A09 ++
>> =A0drivers/hwmon/Makefile =A0| =A0 =A01 +
>> =A0drivers/hwmon/ads7871.c | =A0253 ++++++++++++++++++++++++++++++++++++=
+++++++++++
>> =A03 files changed, 263 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/hwmon/ads7871.c
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 68cf877..36a12d7 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -792,6 +792,15 @@ config SENSORS_ADS7828
>> =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so, the=
 module
>> =A0 =A0 =A0 =A0 will be called ads7828.
>>
>> +config SENSORS_ADS7871
>> + =A0 =A0 tristate "Texas Instruments ADS7871 A/D converter"
>> + =A0 =A0 depends on SPI
>> + =A0 =A0 help
>> + =A0 =A0 =A0 If you say yes here you get support for TI ADS7871 & ADS78=
70
>> +
>> + =A0 =A0 =A0 This driver can also be built as a module. =A0If so, the m=
odule
>> + =A0 =A0 =A0 will be called ads7871.
>> +
>> =A0config SENSORS_AMC6821
>> =A0 =A0 =A0 tristate "Texas Instruments AMC6821"
>> =A0 =A0 =A0 depends on I2C =A0&& EXPERIMENTAL
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 4bc215c..84e65a5 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -29,6 +29,7 @@ obj-$(CONFIG_SENSORS_ADM1029) =A0 =A0 =A0 +=3D adm1029=
.o
>> =A0obj-$(CONFIG_SENSORS_ADM1031) =A0 =A0 =A0 =A0+=3D adm1031.o
>> =A0obj-$(CONFIG_SENSORS_ADM9240) =A0 =A0 =A0 =A0+=3D adm9240.o
>> =A0obj-$(CONFIG_SENSORS_ADS7828) =A0 =A0 =A0 =A0+=3D ads7828.o
>> +obj-$(CONFIG_SENSORS_ADS7871) =A0 =A0 =A0 =A0+=3D ads7871.o
>> =A0obj-$(CONFIG_SENSORS_ADT7462) =A0 =A0 =A0 =A0+=3D adt7462.o
>> =A0obj-$(CONFIG_SENSORS_ADT7470) =A0 =A0 =A0 =A0+=3D adt7470.o
>> =A0obj-$(CONFIG_SENSORS_ADT7473) =A0 =A0 =A0 =A0+=3D adt7473.o
>> diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
>> new file mode 100644
>> index 0000000..4d0ae10
>> --- /dev/null
>> +++ b/drivers/hwmon/ads7871.c
>> @@ -0,0 +1,253 @@
>> +/*
>> + * =A0ads7871 - driver for TI ADS7871 A/D converter
>> + *
>> + * =A0Copyright (c) 2010 Paul Thomas <pthomas8589@gmail.com>
>> + *
>> + * =A0This program is distributed in the hope that it will be useful,
>> + * =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * =A0GNU General Public License for more details.
>> + *
>> + * =A0This program is free software; you can redistribute it and/or mod=
ify
>> + * =A0it under the terms of the GNU General Public License version 2 or
>> + * =A0later as publishhed by the Free Software Foundation.
>> + *
>> + * =A0 You need to have something like this in struct spi_board_info
>> + * =A0 {
>> + * =A0 =A0 =A0 =A0 =A0 .modalias =A0 =A0 =A0 =3D "ads7871",
>> + * =A0 =A0 =A0 =A0 =A0 .max_speed_hz =A0 =3D 2*1000*1000,
>> + * =A0 =A0 =A0 =A0 =A0 .chip_select =A0 =A0=3D 0,
>> + * =A0 =A0 =A0 =A0 =A0 .bus_num =A0 =A0 =A0 =A0=3D 1,
>> + * =A0 },
>> + */
>> +
>> +/*From figure 18 in the datasheet*/
>> +/*Register addresses*/
>> +#define REG_LS_BYTE =A00 /*A/D Output Data, LS Byte*/
>> +#define REG_MS_BYTE =A01 /*A/D Output Data, MS Byte*/
>> +#define REG_PGA_VALID =A0 =A0 =A0 =A02 /*PGA Valid Register*/
>> +#define REG_AD_CONTROL =A0 =A0 =A0 3 /*A/D Control Register*/
>> +#define REG_GAIN_MUX 4 /*Gain/Mux Register*/
>> +#define REG_IO_STATE 5 /*Digital I/O State Register*/
>> +#define REG_IO_CONTROL =A0 =A0 =A0 6 /*Digital I/O Control Register*/
>> +#define REG_OSC_CONTROL =A0 =A0 =A07 /*Rev/Oscillator Control Register*/
>> +#define REG_SER_CONTROL 24 /*Serial Interface Control Register*/
>> +#define REG_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 31 /*ID Register*/
>> +
>> +/*From figure 17 in the datasheet
>> +* These bits get ORed with the address to form
>> +* the instruction byte */
>> +/*Instruction Bit masks*/
>> +#define INST_MODE_bm (1<<7)
>> +#define INST_READ_bm (1<<6)
>> +#define INST_16BIT_bm =A0 =A0 =A0 =A0(1<<5)
>> +
>> +/*From figure 18 in the datasheet*/
>> +/*bit masks for Rev/Oscillator Control Register*/
>> +#define MUX_CNV_bv =A0 7
>> +#define MUX_CNV_bm =A0 (1<<MUX_CNV_bv)
>> +#define MUX_M3_bm =A0 =A0(1<<3) /*M3 selects single ended*/
>> +#define MUX_G_bv =A0 =A0 4 /*allows for reg =3D (gain << MUX_G_bv) | ..=
.*/
>> +
>> +/*From figure 18 in the datasheet*/
>> +/*bit masks for Rev/Oscillator Control Register*/
>> +#define OSC_OSCR_bm =A0(1<<5)
>> +#define OSC_OSCE_bm =A0(1<<4)
>> + =A0 =A0 dev_dbg(&spi->dev, "REG_OSC_CONTROL write:%x, read:%x\n", val,=
 ret);
>> +#define OSC_REFE_bm =A0(1<<3)
>> +#define OSC_BUFE_bm =A0(1<<2)
>> +#define OSC_R2V_bm =A0 (1<<1)
>> +#define OSC_RBG_bm =A0 (1<<0)
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/err.h>
>> +#include <linux/mutex.h>
>> +#include <linux/delay.h>
>> +
>> +#define DEVICE_NAME =A0"ads7871"
>> +
>> +struct ads7871_data {
>> + =A0 =A0 struct device =A0 *hwmon_dev;
>> + =A0 =A0 struct mutex =A0 =A0update_lock;
>> +};
>> +
>> +static int ads7871_read_reg8(struct spi_device *spi, int reg)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 reg =3D reg | INST_READ_bm;
>> + =A0 =A0 ret =3D spi_w8r8(spi, reg);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int ads7871_read_reg16(struct spi_device *spi, int reg)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 reg =3D reg | INST_READ_bm | INST_16BIT_bm;
>> + =A0 =A0 ret =3D spi_w8r16(spi, reg);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int ads7871_write_reg8(struct spi_device *spi, int reg, u8 val)
>> +{
>> + =A0 =A0 u8 tmp[2] =3D {reg, val};
>> + =A0 =A0 return spi_write(spi, tmp, sizeof(tmp));
>> +}
>> +
>> +static ssize_t show_voltage(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *da, char *buf)
>> +{
>> + =A0 =A0 struct spi_device *spi =3D to_spi_device(dev);
>> + =A0 =A0 struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da=
);
>> + =A0 =A0 int ret, val, i =3D 0;
>> + =A0 =A0 uint8_t channel, mux_cnv;
>> +
>> + =A0 =A0 channel =3D attr->index;
>> + =A0 =A0 /*TODO: add support for conversions
>> + =A0 =A0 =A0*other than single ended with a gain of 1*/
>> + =A0 =A0 /*MUX_M3_bm forces single ended*/
>> + =A0 =A0 /*This is also where the gain of the PGA would be set*/
>> + =A0 =A0 ads7871_write_reg8(spi, REG_GAIN_MUX,
>> + =A0 =A0 =A0 =A0 =A0 =A0 (MUX_CNV_bm | MUX_M3_bm | channel));
>> +
>> + =A0 =A0 ret =3D ads7871_read_reg8(spi, REG_GAIN_MUX);
>> + =A0 =A0 mux_cnv =3D ((ret & MUX_CNV_bm)>>MUX_CNV_bv);
>> + =A0 =A0 /*on 400MHz arm9 platform the conversion
>> + =A0 =A0 =A0*is already done when we do this test*/
>> + =A0 =A0 while ((i < 2) && mux_cnv) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 i++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ads7871_read_reg8(spi, REG_GAIN_MUX);
>> + =A0 =A0 =A0 =A0 =A0 =A0 mux_cnv =3D ((ret & MUX_CNV_bm)>>MUX_CNV_bv);
>> + =A0 =A0 =A0 =A0 =A0 =A0 msleep_interruptible(1);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (mux_cnv =3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 val =3D ads7871_read_reg16(spi, REG_LS_BYTE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*result in volts*10000 =3D (val/8192)*2.5*100=
00*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 val =3D ((val>>2) * 25000) / 8192;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", val);
>> + =A0 =A0 } else {
> This shouldn't have gotten through check patch. =A0You never have
> brackets round a single line like this. =A0Should be,

I re-read CodingStyle when I was running checkpatch and saw that if
the branch is part of a muli line conditional statement (line 171 in
CodingStyle) then all sections should be braes should be used.

>
> } else
> =A0 =A0 =A0 =A0return -1;
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 }
>> +}
>> +
>> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_voltage, NULL, 0);
>> +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_voltage, NULL, 1);
>> +static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_voltage, NULL, 2);
>> +static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_voltage, NULL, 3);
>> +static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_voltage, NULL, 4);
>> +static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_voltage, NULL, 5);
>> +static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_voltage, NULL, 6);
>> +static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_voltage, NULL, 7);
>> +
>> +static struct attribute *ads7871_attributes[] =3D {
>> + =A0 =A0 &sensor_dev_attr_in0_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in1_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in2_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in3_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in4_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in5_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in6_input.dev_attr.attr,
>> + =A0 =A0 &sensor_dev_attr_in7_input.dev_attr.attr,
>> + =A0 =A0 NULL
>> +};
>> +
>> +static const struct attribute_group ads7871_group =3D {
>> + =A0 =A0 .attrs =3D ads7871_attributes,
>> +};
>> +
>> +static int __devinit ads7871_probe(struct spi_device *spi)
>> +{
>> + =A0 =A0 int status, ret, err =3D 0;
>> + =A0 =A0 uint8_t val;
>> + =A0 =A0 struct ads7871_data *pdata;
>> +
> There is still a lot of debug code in here that is useful for development
> but probably doesn't want to be in the final driver.
I'm happy with what you think is best, but in other driver I've been
glad to have a little bit in demesg.

>> + =A0 =A0 dev_dbg(&spi->dev, "probe\n");
>> +
> sizeof(*pdata) is neater.
>> + =A0 =A0 pdata =3D kzalloc(sizeof(struct ads7871_data), GFP_KERNEL);
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 status =3D sysfs_create_group(&spi->dev.kobj, &ads7871_group);
>> + =A0 =A0 if (status < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error_free;
>> +
>> + =A0 =A0 pdata->hwmon_dev =3D hwmon_device_register(&spi->dev);
>> + =A0 =A0 if (IS_ERR(pdata->hwmon_dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(pdata->hwmon_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error_remove;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spi_set_drvdata(spi, pdata);
>> +
>> + =A0 =A0 /* Configure the SPI bus */
>> + =A0 =A0 spi->mode =3D (SPI_MODE_0);
>> + =A0 =A0 spi->bits_per_word =3D 8;
>> + =A0 =A0 spi_setup(spi);
>> +
>> + =A0 =A0 ads7871_write_reg8(spi, REG_SER_CONTROL, 0);
>> + =A0 =A0 ads7871_write_reg8(spi, REG_AD_CONTROL, 0);
>> +
>> + =A0 =A0 val =3D (OSC_OSCR_bm | OSC_OSCE_bm | OSC_REFE_bm | OSC_BUFE_bm=
);
>> + =A0 =A0 ads7871_write_reg8(spi, REG_OSC_CONTROL, val);
>> + =A0 =A0 ret =3D ads7871_read_reg8(spi, REG_OSC_CONTROL);
>> +
>> + =A0 =A0 dev_dbg(&spi->dev, "REG_OSC_CONTROL write:%x, read:%x\n", val,=
 ret);
>> + =A0 =A0 /*because there is no other error checking on an SPI bus
>> + =A0 =A0 we need to make sure we really have a chip*/
>> + =A0 =A0 if (val !=3D ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error_remove;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +
>> +error_remove:
>> + =A0 =A0 sysfs_remove_group(&spi->dev.kobj, &ads7871_group);
>> +error_free:
>> + =A0 =A0 kfree(pdata);
>> +exit:
>> + =A0 =A0 return err;
>> +}
>> +
>> +static int __devexit ads7871_remove(struct spi_device *spi)
>> +{
>> + =A0 =A0 struct ads7871_data *pdata =3D spi_get_drvdata(spi);
>> +
>> + =A0 =A0 hwmon_device_unregister(pdata->hwmon_dev);
>> + =A0 =A0 sysfs_remove_group(&spi->dev.kobj, &ads7871_group);
>> + =A0 =A0 kfree(pdata);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct spi_driver ads7871_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D DEVICE_NAME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .bus =3D &spi_bus_type,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 },
>> +
>> + =A0 =A0 .probe =3D ads7871_probe,
>> + =A0 =A0 .remove =3D __devexit_p(ads7871_remove),
>> +};
>
> The driver supports two devices (as per description),
> hence it would be nice to use a device table to allow
> platform support code to specify which actually have.
>
>> +
>> +static int __init ads7871_init(void)
>> +{
>> + =A0 =A0 return spi_register_driver(&ads7871_driver);
>> +}
>> +
>> +static void __exit ads7871_exit(void)
>> +{
>> + =A0 =A0 spi_unregister_driver(&ads7871_driver);
>> +}
>> +
>> +module_init(ads7871_init);
>> +module_exit(ads7871_exit);
>> +
>> +MODULE_AUTHOR("Paul Thomas <pthomas8589@gmail.com>");
>> +MODULE_DESCRIPTION("TI ADS7871 A/D driver");
>> +MODULE_LICENSE("GPL");
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
