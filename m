From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Jan 2013 21:50:34 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Driver for Maxim MAX6697 and compatibles
Message-Id: <20130115225034.38294f9d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1358277904-7421-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1358277904-7421-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org

Hi Guenter,

On Tue, 15 Jan 2013 11:25:04 -0800, Guenter Roeck wrote:
> Add support for MAX6581, MAX6602, MAX6622, MAX6636, MAX6689, MAX6693,
> MAX6694, MAX6697, MAX6698, and MAX6699 temperature sensors
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2:
> - Add suppport for platform data and devicetree based chip initialization
> - Drop S_IRUGOWU macro: s/S_IRUGOWU/S_IRUGO | S_IWUSR/
> v3:
> - Clarify devicetree documentation and platform data, indicating that all
>   configuration information must be specified
> - Fix alert-mask and over-temperature-mask values in devicetree example
> - Align bit masks in configuration data with tempX index values
> - Fix memset size in initialization code
> - Handle extended temperature range for MAX6581 correctly
> - Make data caching time dependent on chip type and configuration data
> - Fix have_ext bit map for MAX6581
> - Sort entries in max6697_chip_data[] array alphabetically
> - Fix race condition when reading alarms
> - Define and use constants for second index in data->temp array
> - Rename show_temp11 to show_temp_input. Drop second index (always zero)
> - Use DIV_ROUND_CLOSEST to convert milli-degrees to degrees in set_temp
> - Handle error return in set_temp correctly
> - Make max6697_attributes a two-dimensional array to reduce risk of error=
s when
>   accessing it
> - Drop temp1_fault as it is never used (local temperature sensor can not =
be
>   faulty)
> - Fix reading extended-range-enable property
> - If no configuration data is specified, read extended range and resistan=
ce
>   cancellation configuration from chip
> - Drop some unnecessary comments
> - Include linux/types.h in platform_data/max6697.h
> - Drop unused define MAX6697_MAX_CONFIG_REG
> - Add comments to fields in struct max6697_platform_data
> - Add support to configure beta compensation on MAX6693 and MAX6694

Thanks for the update. I have a few more comments:

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/max6697.txt
> (...)
> +- extended-range-enable
> +	Only valid for MAX6581. Set to enable extended temperature range.
> +	Extended temperature will be disabled if not specified.
> +- beta-compensation-enable
> +	Only valid for MAX6693 and MX6694. Set to enable beta compensation on
> +	remote temperature channel 1.
> +	beta compensation will be disabled if not specified.

Capital B.

> (...)
> +static ssize_t show_temp_input(struct device *dev,
> +			       struct device_attribute *devattr, char *buf)
> +{
> +	int index =3D to_sensor_dev_attr(devattr)->index;
> +	struct max6697_data *data =3D max6697_update_device(dev);
> +	int temp;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	temp =3D data->temp[index][MAX6697_TEMP_INPUT];
> +	temp <<=3D 3;
> +	temp |=3D data->temp[index][MAX6697_TEMP_EXT] >> 5;
> +	temp -=3D data->temp_offset << 3;

You could save one shifting by reordering the operations.

> +
> +	return sprintf(buf, "%d\n", temp * 125);
> +}
> (...)
> +static ssize_t set_temp(struct device *dev,
> +			struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	int nr =3D to_sensor_dev_attr_2(devattr)->nr;
> +	int index =3D to_sensor_dev_attr_2(devattr)->index;
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct max6697_data *data =3D i2c_get_clientdata(client);
> +	long temp;
> +	int ret;
> +
> +	ret =3D kstrtol(buf, 10, &temp);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&data->update_lock);
> +	temp =3D clamp_val(DIV_ROUND_CLOSEST(temp, 1000), -data->temp_offset,
> +			 127);

This 127 is OK for all chips but the MAX6851. I agree that the
temperature data format table in the datasheet looks wrong, but the
description of the EXTRANGE configuration bit description sheds some
light:

"Extended-Range Enable Bit. Set bit 1 to logic 1 to set the temperature and=
 limit data
range to -64=B0C to +191=B0C. Set bit 1 to logic 0 to set the range to 0=B0=
C to +255=B0C."

> +	temp +=3D data->temp_offset;
> +	data->temp[nr][index] =3D temp;
> +	ret =3D i2c_smbus_write_byte_data(client,
> +					index =3D=3D 2 ? MAX6697_REG_MAX[nr]
> +						   : MAX6697_REG_CRIT[nr],
> +					temp);
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret < 0 ? ret : count;
> +}
> (...)
> +static int max6697_init_chip(struct i2c_client *client)
> +{
> +	struct max6697_data *data =3D i2c_get_clientdata(client);
> +	struct max6697_platform_data *pdata =3D dev_get_platdata(&client->dev);
> +	struct max6697_platform_data p;
> +	const struct max6697_chip_data *chip =3D data->chip;
> +	int factor =3D chip->channels;
> +	int ret;
> +	u8 reg;
> +
> +	/*
> +	 * Don't touch configuration if neither platform data nor OF
> +	 * configuration was specified. If that is the case, use the
> +	 * current chip configuration.
> +	 */
> +	if (!pdata && !client->dev.of_node) {
> +		reg =3D i2c_smbus_read_byte_data(client, MAX6697_REG_CONFIG);
> +		if (reg < 0)

reg is unsigned. I don't get why gcc doesn't complain...

> +			return reg;
> +		if (data->type =3D=3D max6581) {
> +			data->temp_offset =3D
> +			  (reg & MAX6581_CONF_EXTENDED) ? 64 : 0;

data->temp_offset is 0 at this point so an "if" construct should be
more efficient.

> +			reg =3D i2c_smbus_read_byte_data(client,
> +						       MAX6581_REG_RESISTANCE);

reg is unsigned.

> +			if (reg < 0)
> +				return reg;
> +			factor +=3D hweight8(reg);
> +		} else {
> +			if (reg & MAX6697_CONF_RESISTANCE)
> +				factor++;
> +		}
> +		goto done;
> +	}
> (...)
> --- /dev/null
> +++ b/include/linux/platform_data/max6697.h
> @@ -0,0 +1,36 @@
> +/*
> + * max6697.h
> + *     Copyright (c) 2012 Guenter Roeck <linux@roeck-us.net>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef MAX6697_H
> +#define MAX6697_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * For all bit masks:
> + * bit 0:    local temperature
> + * bit 1..7: remote temperatures
> + */
> +struct max6697_platform_data {
> +	bool smbus_timeout_disable;	/* set to disable smbus timeouts */

"SMBus"

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
