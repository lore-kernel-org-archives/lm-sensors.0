From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Mon, 06 Jun 2005 17:18:30 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] pca9539: new i2c drvier
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9076CB27@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C9076C7D9@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C9076C7D9@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, 

Thanks for your feedback.
I've incorporated your suggestions, so the next pca9539 patch should be
'final'. ;)

Ben

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Saturday, June 04, 2005 2:26 AM
To: Gardner, Ben
Cc: LM Sensors; Greg KH
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc5-mm2] pca9539: new i2c drvier
(retry 3 - attachment)

Hi Ben,

> Anyway, here is attempt 3, as an attachment.
> => 
> This is a driver for the PCA9539, a 16 bit digital I/O chip.
> It uses the new i2c-sysfs interfaces.

And here are my comments about your code (which overall looks very
good).

> +/* following are the sysfs callback functions */ static ssize_t 
> +pca9539_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
> +	struct pca9539_data *data i2c_get_clientdata(to_i2c_client(dev));
> +	return sprintf(buf, "%d\n",
i2c_smbus_read_byte_data(&data->client, 
> +(u8)psa->index)); }

This can be made a lot more simple. You currently go from dev to client
to data back to client. What about:

static ssize_t pca9539_show(struct device *dev, struct device_attribute
*attr,
			    char *buf)
{
	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
	struct i2c_client *client = to_i2c_client(dev);
	return sprintf(buf, "%d\n", i2c_smbus_read_byte_data(client,
(u8)psa->index)); }

Same holds for pca9539_store(), obviously.

BTW, please split lines which are longer than 80 characters, as
mentioned in Documentation/CodingStyle.

> +static ssize_t pca9539_store(struct device *dev, struct
device_attribute *attr,
> +			     const char *buf, size_t count) {
> +	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
> +	struct pca9539_data *data i2c_get_clientdata(to_i2c_client(dev));
> +	u8 val = simple_strtoul(buf, NULL, 0);
> +	i2c_smbus_write_byte_data(&data->client, (u8)psa->index, val);
> +	return count;
> +}

You fail to check the validity of the new value. Wrapping it into an u8
is no good. It would be far better to actually check the value, and
reject it if incorrect. Something in the lines of:

	unsigned long val = simple_strtoul(buf, NULL, 0);
	if (val > 0xff)
		return -EINVAL;

This is what the similar pcf8574 driver does. You may even have it warn
in the logs if you want.

> +	static
SENSOR_DEVICE_ATTR(name,S_IRUGO,pca9539_show,NULL,enum_name)
> (...)
> +	static 
> +SENSOR_DEVICE_ATTR(name,S_IRUGO|S_IWUSR,pca9539_show,pca9539_store,en
> +um_name)

Add one space after each comma please. Spaces are also welcome around
"|". As a side note, "enum_name" is a bad name IMHO, I would go for
"index" or "command" or whatever you like which expresses what this
parameter is holding.

> +PCA9539_ENTRY_RW(config0, PCA9539_CONFIG_0); 
> +PCA9539_ENTRY_RW(config1, PCA9539_CONFIG_1);

"config" isn't a very relevant name. It could mean about anything
depending on the chip. What about "direction" instead?

> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE
> +				     | I2C_FUNC_SMBUS_WRITE_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_READ_BYTE_DATA))
> +		goto exit;

Not correct. You test for I2C_FUNC_SMBUS_BYTE but never actually use
this SMBus command in your code. Additionally,
I2C_FUNC_SMBUS_WRITE_BYTE_DATA | I2C_FUNC_SMBUS_READ_BYTE_DATA can be
shorten into I2C_FUNC_SMBUS_BYTE_DATA.

> +	/* Detection: not sure how to do that... 
> +	 * possibility: toggle the value read from invert0 and see if
input0
> +	 * changes polarity. 
> +	 * However, if the inputs are changing, this won't work.
> +	 */

No, detection code should not write anything to the chips.

One possible detection method is to check that input and output match
(modulo the polarity inversion) for all pins configured as outputs. I
have made something similar in sensors-detect for the PCA9556, which is
basically the same chip as the PCA9539 with half the GPIO pins. The code
there reads like:

	return unless ($input & ~$config) = (($output ^ $invert) &
~$config);

Another possible check would be on the number of registers (or
commands). The PCA9539 has 8 commands, so reading "register" 0x07 will
return a value, while reading register "0x08" will return an error.

If you could add detection for your chip to sensors-detect once you're
done with the driver, this would be appreciated.

> +	/* Register sysfs hooks */
> +	return sysfs_create_group(&new_client->dev.kobj, 
> +&pca9539_defattr_group);

Negative, an error from sysfs_create_group() should not be returned by
the detection function due to the current (broken) design of
i2c_detect().

> --- linux-2.6.12-rc5-mm2-clean/drivers/i2c/chips/Kconfig
2005-06-01 14:29:17.000000000 -0500
> +++ linux-2.6.12-rc5-mm2-pca9539/drivers/i2c/chips/Kconfig
2005-06-03 12:09:22.000000000 -0500
> @@ -498,4 +498,14 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called m41t00.
>  
> +config SENSORS_PCA9539
> +	tristate "PCA9539 16-bit digital IO"
> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for the PCA9539
> +	  low power digital I/O with 16 bit.
> +          
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called pca9539.
> +
>  endmenu

I'd rather see this entry next to the PCF8574 one, as both chips are
similar in their function.

Thanks,
--
Jean Delvare


