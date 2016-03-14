From: Pascal Sachs <Pascal.Sachs@sensirion.com>
Date: Mon, 14 Mar 2016 15:28:52 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: add support for Sensirion SHT3x sensors
Message-Id: <157916ADD54A1D4ABFF27DDF0233870C956E1FE3@S-EXCH01.sensirion.lokal>
List-Id: <lm-sensors.vger.kernel.org>
References: <157916ADD54A1D4ABFF27DDF0233870C956E1A93@S-EXCH01.sensirion.lokal>,<20160310191411.GA2388@roeck-us.net>
In-Reply-To: <20160310191411.GA2388@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Frey <David.Frey@sensirion.com>

Hi Guenter

Thank you for the fast code review.
During extended testing of the updated driver we found some other minor iss=
ues with the alert feature we would like to fix before submitting again.

We as well have to update our submission process, since the company mail se=
rver converts tabs to whitespaces and adds this confidentiality message to =
the end.
I am very sorry about that, but I did not knew that.

Regards,
Pascal

Von: Guenter Roeck [linux@roeck-us.net]
Gesendet: Donnerstag, 10. M=E4rz 2016 20:14
An: Pascal Sachs
Cc: Jean Delvare; Jonathan Corbet; lm-sensors@lm-sensors.org; linux-doc@vge=
r.kernel.org; linux-kernel@vger.kernel.org; David Frey
Betreff: Re: [PATCH 1/1] hwmon: add support for Sensirion SHT3x sensors

On Thu, Mar 10, 2016 at 02:56:43PM +0000, Pascal Sachs wrote:
> From: David Frey <david.frey@sensirion.com>
>
> This driver implements support for the Sensirion SHT3x-DIS chip,
> a humidity and temperature sensor. Temperature is measured
> in degrees Celsius, relative humidity is expressed as a percentage.
> In the sysfs interface, all values are scaled by 1000,
> i.e. the value for 31.5 degrees Celsius is 31500.
>

Your patch is whitespace damaged (spaces instead of tabs). Please fix
in the next revision.

> Signed-off-by: Pascal Sachs <pascal.sachs@sensirion.com>
> ---
> Patch was generated against kernel v4.5-rc7
>
>  Documentation/hwmon/sht3x           |  42 ++++
>  drivers/hwmon/Kconfig               |  10 +
>  drivers/hwmon/Makefile              |   1 +
>  drivers/hwmon/sht3x.c               | 389 ++++++++++++++++++++++++++++++=
++++++
>  include/linux/platform_data/sht3x.h |  23 +++
>  5 files changed, 465 insertions(+)
>  create mode 100644 Documentation/hwmon/sht3x
>  create mode 100644 drivers/hwmon/sht3x.c
>  create mode 100644 include/linux/platform_data/sht3x.h
>
> diff --git a/Documentation/hwmon/sht3x b/Documentation/hwmon/sht3x
> new file mode 100644
> index 0000000..6023862
> --- /dev/null
> +++ b/Documentation/hwmon/sht3x
> @@ -0,0 +1,42 @@
> +Kernel driver sht3x
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Supported chips:
> +  * Sensirion SHT3x-DIS
> +    Prefix: 'sht3x'
> +    Addresses scanned: none
> +    Datasheet: http://www.sensirion.com/fileadmin/user_upload/customers/=
sensirion/Dokumente/Humidity/Sensirion_Humidity_Datasheet_SHT3x_DIS.pdf
> +
> +Author:
> +  David Frey <david.frey@sensirion.com>
> +
> +Description
> +-----------
> +
> +This driver implements support for the Sensirion SHT3x-DIS chip, a humid=
ity
> +and temperature sensor. Temperature is measured in degrees celsius, rela=
tive
> +humidity is expressed as a percentage. In the sysfs interface, all value=
s are
> +scaled by 1000, i.e. the value for 31.5 degrees celsius is 31500.
> +
> +The device communicates with the I2C protocol. Sensors can have the I2C
> +addresses 0x44 or 0x45, depending on the wiring. See
> +Documentation/i2c/instantiating-devices for methods to instantiate the d=
evice.
> +
> +There are two options configurable by means of sht3x_platform_data:
> +1. blocking (pull the I2C clock line down while performing the measureme=
nt) or
> +   non-blocking mode. Blocking mode will guarantee the fastest result but
> +   the I2C bus will be busy during that time. By default, non-blocking m=
ode
> +   is used. Make sure clock-stretching works properly on your device if =
you
> +   want to use blocking mode.
> +2. high or low accuracy. High accuracy is used by default and using it is
> +   strongly recommended.
> +
> +sysfs-Interface
> +---------------
> +
> +temp1_input:      temperature input
> +humidity1_input:  humidity input
> +high_alert_set:   temperature and humidity at which to set the high alert
> +high_alert_clear: temperature and humidity at which to clear the high al=
ert
> +low_alert_clear:  temperature and humidity at which to clear the low ale=
rt
> +low_alert_set:    temperature and humidity at which to set the low alert

Please use standard attribute names as documented in
Documentation/hwmon/sysfs-interface. This would be
temp1_{min,max}, temp1_{min,max}_hyst, humidity1_{min,max},
humidity1_{min,max}_hyst.

> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 60fb80b..4722b76 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1235,6 +1235,16 @@ config SENSORS_SHTC1
>           This driver can also be built as a module.  If so, the module
>           will be called shtc1.
>
> +config SENSORS_SHT3x
> +       tristate "Sensiron humidity and temperature sensors. SHT3x and co=
mpat."
> +       depends on I2C
> +       help
> +         If you say yes here you get support for the Sensiron SHT30 and =
SHT31
> +         humidity and temperature sensors.
> +
> +         This driver can also be built as a module.  If so, the module
> +         will be called sht3x.
> +

Please try to keep in alphabetic order (ahead of SHTC1).

>  config SENSORS_S3C
>         tristate "Samsung built-in ADC"
>         depends on S3C_ADC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 30c94df..8f19eab 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -136,6 +136,7 @@ obj-$(CONFIG_SENSORS_SCH5636)       +=3D sch5636.o
>  obj-$(CONFIG_SENSORS_SHT15)    +=3D sht15.o
>  obj-$(CONFIG_SENSORS_SHT21)    +=3D sht21.o
>  obj-$(CONFIG_SENSORS_SHTC1)    +=3D shtc1.o
> +obj-$(CONFIG_SENSORS_SHT3x)    +=3D sht3x.o

Please try to keep files in alphabetic order.

>  obj-$(CONFIG_SENSORS_SIS5595)  +=3D sis5595.o
>  obj-$(CONFIG_SENSORS_SMM665)   +=3D smm665.o
>  obj-$(CONFIG_SENSORS_SMSC47B397)+=3D smsc47b397.o
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> new file mode 100644
> index 0000000..2e78c44
> --- /dev/null
> +++ b/drivers/hwmon/sht3x.c
> @@ -0,0 +1,389 @@
> +/* Sensirion SHT3x-DIS humidity and temperature sensor driver.
> + * The SHT3x comes in many different versions, this driver is for the
> + * I2C version only.
> + *
> + * Copyright (C) 2015 Sensirion AG, Switzerland
> + * Author: David Frey <david.frey@sensirion.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <asm/page.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/platform_data/sht3x.h>
> +
> +/* commands (high precision mode) */
> +static const unsigned char sht3x_cmd_measure_blocking_hpm[]    =3D { 0x2=
c, 0x06 };
> +static const unsigned char sht3x_cmd_measure_nonblocking_hpm[] =3D { 0x2=
4, 0x00 };
> +
> +/* commands (low power mode) */
> +static const unsigned char sht3x_cmd_measure_blocking_lpm[]    =3D { 0x2=
c, 0x10 };
> +static const unsigned char sht3x_cmd_measure_nonblocking_lpm[] =3D { 0x2=
4, 0x16 };
> +
> +static const unsigned char sht3x_cmd_read_status_reg[]         =3D { 0xF=
3, 0x2D };
> +
> +#define HIGH_ALERT_SET_NAME "high_alert_set"
> +#define HIGH_ALERT_CLEAR_NAME "high_alert_clear"
> +#define LOW_ALERT_SET_NAME "low_alert_set"
> +#define LOW_ALERT_CLEAR_NAME "low_alert_clear"
> +
> +/* delays for non-blocking i2c commands, both in us */
> +#define SHT3X_NONBLOCKING_WAIT_TIME_HPM  15000
> +#define SHT3X_NONBLOCKING_WAIT_TIME_LPM   4000
> +
> +#define SHT3X_WORD_LEN         2
> +#define SHT3X_CMD_LENGTH       SHT3X_WORD_LEN

Why separate defines if they are both the same ? Sure,
they are logically different as one is used for data and the other
for the command (I think), but then they should be defined separately
without having one reference the other.

> +#define SHT3X_CRC8_LEN         1
> +#define SHT3X_RESPONSE_LENGTH  6
> +#define SHT3X_THRESHOLD_LENGTH 2
> +#define SHT3X_THRESHOLD_COUNT \
> +       (sizeof(threshold_commands) / sizeof(struct sht3x_alert_commands))
> +#define SHT3X_CRC8_LEN         1
> +#define SHT3X_CRC8_POLYNOMIAL  0x31
> +#define SHT3X_CRC8_INIT        0xFF
> +
> +DECLARE_CRC8_TABLE(sht3x_crc8_table);
> +
> +struct sht3x_alert_commands {
> +       const char *threshold_name;
> +       const char read_command[SHT3X_CMD_LENGTH];
> +       const char write_command[SHT3X_CMD_LENGTH];
> +};
> +
> +const struct sht3x_alert_commands threshold_commands[] =3D {
> +       { HIGH_ALERT_SET_NAME,   {0xe1, 0x1f}, {0x61, 0x1d} },
> +       { HIGH_ALERT_CLEAR_NAME, {0xe1, 0x14}, {0x61, 0x16} },
> +       { LOW_ALERT_SET_NAME,    {0xe1, 0x02}, {0x61, 0x00} },
> +       { LOW_ALERT_CLEAR_NAME,  {0xe1, 0x09}, {0x61, 0x0B} },

Please use array index values to identify an attribute/sensor,
not names. See below.

> +};
> +
> +struct sht3x_data {
> +       struct i2c_client *client;
> +       struct mutex update_lock;
> +
> +       const unsigned char *command;
> +       unsigned int nonblocking_wait_time;     /* in us */
> +
> +       struct sht3x_platform_data setup;
> +
> +       int temperature;        /* 1000 * temperature in dgr C */
> +       int humidity;           /* 1000 * relative humidity in %RH */
> +};
> +
> +
> +static const struct sht3x_alert_commands*
> +find_commands(const char *threshold_name)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < SHT3X_THRESHOLD_COUNT; i++) {
> +               if (strcmp(threshold_name, threshold_commands[i].threshol=
d_name)
> +                               =3D=3D 0)
> +                       return &threshold_commands[i];
> +       }
> +       return 0;
> +}

This is unnecessary (and unacceptable). See below.

> +
> +static int sht3x_read_from_command(struct i2c_client *client,
> +                                  const char *command,
> +                                  char *buf, int length,
> +                                  unsigned int wait_time)
> +{
> +       int ret =3D i2c_master_send(client, command, SHT3X_CMD_LENGTH);
> +

This warrants an explanation why you can not use standard (smbus)
send/receive commands.

> +       if (ret !=3D SHT3X_CMD_LENGTH) {
> +               dev_err(&client->dev, "failed to send command: %d\n", ret=
);

Please no logging noise on errors. If you really think you have to log,
consider making the messages dev_dbg().

> +               return ret < 0 ? ret : -EIO;
> +       }
> +
> +       if (wait_time)
> +               usleep_range(wait_time, wait_time + 1000);
> +
> +       ret =3D i2c_master_recv(client, buf, length);
> +       if (ret !=3D length) {
> +               dev_err(&client->dev, "failed to read values: %d\n", ret);
> +               return ret < 0 ? ret : -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sht3x_extract_temperature(u16 raw)
> +{
> +       /*
> +        * From datasheet:
> +        * T =3D -45 + 175 * ST / 2^16
> +        * Adapted for integer fixed point (3 digit) arithmetic.
> +        */
> +       return ((21875 * (int)raw) >> 13) - 45000;
> +}
> +
> +static int sht3x_extract_humidity(u16 raw)
> +{
> +       /*
> +        * From datasheet:
> +        * RH =3D 100 * SRH / 2^16
> +        * Adapted for integer fixed point (3 digit) arithmetic.
> +        */
> +       return ((12500 * (int)raw) >> 13);
> +}
> +
> +/* sysfs attributes */
> +static struct sht3x_data *sht3x_update_client(struct device *dev)
> +{
> +       struct sht3x_data *data =3D dev_get_drvdata(dev);
> +       struct i2c_client *client =3D data->client;
> +       unsigned char buf[SHT3X_RESPONSE_LENGTH];
> +       u16 val;
> +       int ret =3D 0;

Unnecessary initialization.

> +       /*
> +        * In blocking mode (clock stretching mode) the I2C bus
> +        * is blocked for other traffic, thus the call to i2c_master_recv=
()
> +        * will wait until the data is ready. For non blocking mode, we
> +        * have to wait ourselves.
> +        */
> +       unsigned int wait_time =3D data->setup.blocking_io ?
> +                       0 : data->nonblocking_wait_time;

It might make more sense to store the wait time in sht3x_data, or does it
ever change during runtime ?

> +
> +       mutex_lock(&data->update_lock);
> +
> +       ret =3D sht3x_read_from_command(client, data->command,
> +                                     buf, sizeof(buf), wait_time);
> +       if (ret)
> +               goto out;
> +
> +       val =3D be16_to_cpup((__be16 *) buf);
> +       data->temperature =3D sht3x_extract_temperature(val);
> +       val =3D be16_to_cpup((__be16 *) (buf + 3));
> +       data->humidity =3D sht3x_extract_humidity(val);
> +
> +out:
> +       mutex_unlock(&data->update_lock);
> +
> +       return ret =3D=3D 0 ? data : ERR_PTR(ret);
> +}
> +
> +static ssize_t temp1_input_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       struct sht3x_data *data =3D sht3x_update_client(dev);
> +
> +       if (IS_ERR(data))
> +               return PTR_ERR(data);
> +
> +       return sprintf(buf, "%d\n", data->temperature);
> +}
> +
> +static ssize_t humidity1_input_show(struct device *dev,
> +                                   struct device_attribute *attr, char *=
buf)
> +{
> +       struct sht3x_data *data =3D sht3x_update_client(dev);
> +
> +       if (IS_ERR(data))
> +               return PTR_ERR(data);
> +
> +       return sprintf(buf, "%d\n", data->humidity);
> +}
> +
> +static ssize_t alert_show(struct device *dev,
> +                         struct device_attribute *attr,
> +                         char *buf)
> +{
> +       char buffer[SHT3X_WORD_LEN];
> +       u16 raw;
> +       int temperature, humidity;
> +       struct sht3x_data *data =3D dev_get_drvdata(dev);
> +       struct i2c_client *client =3D data->client;
> +       const struct sht3x_alert_commands *commands =3D
> +               find_commands(attr->attr.name);
> +
Please use SENSOR_DEVICE_ATTR for the attribute declarations.
It lets you specify an additional parameter, which you can use as array ind=
ex.

> +       int ret =3D sht3x_read_from_command(client, commands->read_comman=
d,
> +                                         buffer, sizeof(buffer), 0);

I am quite sure this results in a checkpatch warning. It is quite long anyw=
ay
for a variable declaration combined with initialization. Please split.

In general, if a variable declaration plus initialization is longer than one
line, please split declaration from initialization.

I am also concerned that the call to sht3x_read_from_command() is not mutex
protected. This means it can be called twice, while the update function is
waiting for a response. Hard to imagine that this won't cause trouble.
It might be better to move the locking into sht3x_read_from_command().

> +       if (ret)
> +               return ret;
> +
> +       raw =3D be16_to_cpup((__be16 *) buffer);
> +       /*
> +        * top 7 bits are the humidity MSB,
> +        * lower 9 bits are temperature MSB
> +        */
> +       temperature =3D sht3x_extract_temperature((raw & 0x01ff) << 7);
> +       humidity =3D sht3x_extract_humidity(raw & 0xfe00);
> +
> +       return scnprintf(buf, PAGE_SIZE, "%d %d\n", temperature, humidity=
);

Again, please use (separate) standard attributes.

> +}
> +
> +static ssize_t alert_store(struct device *dev,
> +                          struct device_attribute *attr,
> +                          const char *buf,
> +                          size_t count)
> +{
> +       char buffer[2 * SHT3X_WORD_LEN + SHT3X_CRC8_LEN];

Strictly speaking, since you have separate defines, this should be
        char buffer[SHT3X_CMD_LENGTH + SHT3X_WORD_LEN + SHT3X_CRC8_LEN];

> +       char *position =3D buffer;
> +       u16 raw;
> +       int temperature, humidity;
> +       struct sht3x_data *data =3D dev_get_drvdata(dev);
> +       struct i2c_client *client =3D data->client;
> +       const struct sht3x_alert_commands *commands =3D
> +               find_commands(attr->attr.name);
> +
> +       int ret =3D sscanf(buf, "%d %d", &temperature, &humidity);
> +
> +       if (ret !=3D SHT3X_THRESHOLD_LENGTH) {
> +               dev_err(&client->dev, "wrong number of arguments: %d", re=
t);
> +               return -EINVAL;
> +       }
> +       if (temperature < -45000 || temperature > 130000) {
> +               dev_err(&client->dev, "temperature out of range");
> +               return -EINVAL;
> +       }
> +       if (humidity < 0 || humidity > 100000) {
> +               dev_err(&client->dev, "humidity out of range");
> +               return -EINVAL;
> +       }

Please use clamp_val() to limit number ranges.

Also, as mentioned before, please no kernel log messages on errors.
We don't usually log ABI errors; this could easily be used to fill up
the kernel log with junk.

> +
> +       memcpy(position, commands->write_command, SHT3X_CMD_LENGTH);
> +       position +=3D SHT3X_CMD_LENGTH;
> +       /*
> +        * ST =3D (T + 45) / 175 * 2^16
> +        * SRH =3D RH / 100 * 2^16
> +        * adapted for fixed point arithmetic and packed the same as
> +        * in alert_show()
> +        */
> +       raw =3D ((temperature + 45000) * 24543) >> (16 + 7);
> +       raw |=3D ((humidity * 42950) >> 16) & 0xfe00;
> +       *(__be16 *)(position) =3D cpu_to_be16(raw);
> +       position[SHT3X_WORD_LEN] =3D crc8(sht3x_crc8_table,
> +                                       position, SHT3X_WORD_LEN,
> +                                       SHT3X_CRC8_INIT);

This is confusing. First you add to position, then you index the result.
Since index values are all constant, can you instead just work with buffer
pointers directly ?

> +
> +       ret =3D i2c_master_send(client, buffer, sizeof(buffer));
> +       if (ret !=3D sizeof(buffer)) {
> +               dev_err(&client->dev, "failed to set alert threshold\n");
> +               return ret < 0 ? ret : -EIO;
> +       }
> +       return count;
> +}
> +
> +static DEVICE_ATTR_RO(temp1_input);
> +static DEVICE_ATTR_RO(humidity1_input);
> +static DEVICE_ATTR(high_alert_set, 0664, alert_show, alert_store);
> +static DEVICE_ATTR(high_alert_clear, 0664, alert_show, alert_store);
> +static DEVICE_ATTR(low_alert_set, 0664, alert_show, alert_store);
> +static DEVICE_ATTR(low_alert_clear, 0664, alert_show, alert_store);
> +
> +static struct attribute *sht3x_attrs[] =3D {
> +       &dev_attr_temp1_input.attr,
> +       &dev_attr_humidity1_input.attr,
> +       &dev_attr_high_alert_set.attr,
> +       &dev_attr_high_alert_clear.attr,
> +       &dev_attr_low_alert_set.attr,
> +       &dev_attr_low_alert_clear.attr,
> +       NULL
> +};
> +
> +ATTRIBUTE_GROUPS(sht3x);
> +
> +static void sht3x_select_command(struct sht3x_data *data)
> +{
> +       if (data->setup.high_precision) {
> +               data->command =3D data->setup.blocking_io ?
> +                               sht3x_cmd_measure_blocking_hpm :
> +                               sht3x_cmd_measure_nonblocking_hpm;
> +               data->nonblocking_wait_time =3D SHT3X_NONBLOCKING_WAIT_TI=
ME_HPM;
> +
> +       } else {
> +               data->command =3D data->setup.blocking_io ?
> +                               sht3x_cmd_measure_blocking_lpm :
> +                               sht3x_cmd_measure_nonblocking_lpm;
> +               data->nonblocking_wait_time =3D SHT3X_NONBLOCKING_WAIT_TI=
ME_LPM;
> +       }
> +}
> +
> +static int sht3x_probe(struct i2c_client *client,
> +                      const struct i2c_device_id *id)
> +{
> +       int ret;
> +       char status_reg[2];
> +       struct sht3x_data *data;
> +       struct device *hwmon_dev;
> +       struct i2c_adapter *adap =3D client->adapter;
> +       struct device *dev =3D &client->dev;
> +
> +       if (!i2c_check_functionality(adap, I2C_FUNC_I2C)) {
> +               dev_err(dev, "plain i2c transactions not supported\n");
> +               return -ENODEV;
> +       }
> +
> +       ret =3D i2c_master_send(client, sht3x_cmd_read_status_reg,
> +                             SHT3X_CMD_LENGTH);
> +       if (ret !=3D SHT3X_CMD_LENGTH) {
> +               dev_err(dev, "could not send read_status_reg command: %d\=
n",
> +                       ret);
> +               return ret < 0 ? ret : -ENODEV;
> +       }
> +       ret =3D i2c_master_recv(client, status_reg, sizeof(status_reg));
> +       if (ret !=3D sizeof(status_reg)) {
> +               dev_err(dev, "could not read status register: %d\n", ret);
> +               return -ENODEV;
> +       }
> +
Unless I am missing something, those commands are only to check if the devi=
ce
is present. This unnecessarily slows down boot time. Please drop; the device
should not be instantiated if it isn't there.

> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->setup.blocking_io =3D false;
> +       data->setup.high_precision =3D true;
> +       data->client =3D client;
> +       crc8_populate_msb(sht3x_crc8_table, SHT3X_CRC8_POLYNOMIAL);
> +
> +       if (client->dev.platform_data)
> +               data->setup =3D *(struct sht3x_platform_data *)dev->platf=
orm_data;
> +       sht3x_select_command(data);
> +       mutex_init(&data->update_lock);
> +
> +       hwmon_dev =3D devm_hwmon_device_register_with_groups(dev,
> +                       client->name,
> +                       data, sht3x_groups);
> +       if (IS_ERR(hwmon_dev))
> +               dev_dbg(dev, "unable to register hwmon device\n");
> +
> +       return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +/* device ID table */
> +static const struct i2c_device_id sht3x_id[] =3D {
> +       {"sht3x", 0},
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, sht3x_id);
> +
> +static struct i2c_driver sht3x_i2c_driver =3D {
> +       .driver.name =3D "sht3x",
> +       .probe       =3D sht3x_probe,
> +       .id_table    =3D sht3x_id,
> +};
> +
> +module_i2c_driver(sht3x_i2c_driver);
> +
> +MODULE_AUTHOR("David Frey <david.frey@sensirion.com>");
> +MODULE_DESCRIPTION("Sensirion SHT3x humidity and temperature sensor driv=
er");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/sht3x.h b/include/linux/platform=
_data/sht3x.h
> new file mode 100644
> index 0000000..c8be876
> --- /dev/null
> +++ b/include/linux/platform_data/sht3x.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (C) 2015 Sensirion AG, Switzerland
> + * Author: David Frey <david.frey@sensirion.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
Source code is GPLv2 or later, header file is GPLv2. Is this accidential
or on purpose ?

> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __SHT3X_H_
> +#define __SHT3X_H_
> +
> +struct sht3x_platform_data {
> +       bool blocking_io;
> +       bool high_precision;
> +};
> +#endif /* __SHT3X_H_ */
> --
> 1.9.1
> ________________________________
> Confidentiality: The information contained in this email message and all =
attachments transmitted with it is legally privileged and confidential info=
rmation intended only for the use of the addressee. If you have received th=
is email in error, please immediately notify us and delete this email and a=
ny attachments from your system. Thank you.

Uuhh ... maybe I was not authorized to even read this mail after all.
How would I or anyone else know ? This is really a red flag.

Guenter
________________________________
Confidentiality: The information contained in this email message and all at=
tachments transmitted with it is legally privileged and confidential inform=
ation intended only for the use of the addressee. If you have received this=
 email in error, please immediately notify us and delete this email and any=
 attachments from your system. Thank you.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
