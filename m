From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 08 Oct 2007 21:44:10 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-new-driver-v2.patch
Message-Id: <20071008234410.40a9ff54@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <470A0F98.5070400@hhs.nl>
In-Reply-To: <470A0F98.5070400@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 08 Oct 2007 13:08:08 +0200, Hans de Goede wrote:
> This patch adds a new merged driver for FSC sensor chips, it merges the fscher
> and fscpos drivers and adds support for the FSC Scylla, Heracles and Heimdall
> chips.
> 
> This version of the patch has had all issues found during the review by Jean
> Delvare addressed:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021396.html
> 
> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> Jean, can you please ack this one?

Can't ack it as there's one bug remaining :/ And I have a few
suggestions for improvements as well.

> +static ssize_t store_alert_led(struct device *dev,
> +	struct device_attribute *devattr, const char *buf, size_t count)
> +{
> +	u8 reg;
> +	struct fschmd_data *data = dev_get_drvdata(dev);
> +	unsigned long v = simple_strtoul(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	reg = i2c_smbus_read_byte_data(&data->client, FSCHMD_REG_CONTROL);
> +
> +	if (v)
> +		reg |= FSCHMD_CONTROL_ALERT_LED_MASK;
> +	else
> +		reg &= ~FSCHMD_CONTROL_ALERT_LED_MASK;
> +
> +	i2c_smbus_write_byte_data(&data->client, FSCHMD_REG_CONTROL, v);

You want to write "reg" here, not "v".

> +
> +	data->global_control = reg;
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +

You could also use FSCHMD_CONTROL_ALERT_LED_MASK instead of 0x01 in
show_alert_led().

> +static int fschmd_detect(struct i2c_adapter *adapter, int address, int kind)
> +{
> (...)
> +	for (i = 0; i < ARRAY_SIZE(fschmd_attr); i++) {
> +		err = device_create_file(&client->dev,
> +					&fschmd_attr[i].dev_attr);
> +		if (err)
> +			goto exit_detach;
> +	}
> +
> +	for (i = 0; i < (FSCHMD_NO_TEMP_SENSORS[data->kind] * 4); i++) {

Why don't you just use ARRAY_SIZE()? Less likely to break with future
changes.

> +		/* Poseidon doesn't have TEMP_LIMIT registers */
> +		if (kind = fscpos && fschmd_temp_attr[i].dev_attr.show =
> +				show_temp_max)
> +			continue;
> +
> +		err = device_create_file(&client->dev,
> +					&fschmd_temp_attr[i].dev_attr);
> +		if (err)
> +			goto exit_detach;
> +	}
> +
> +	for (i = 0; i < (FSCHMD_NO_FAN_SENSORS[data->kind] * 5); i++) {

Same here. And same in fschmd_detach_client().

The rest looks all OK now. Please post a last update and I'll ack it
tomorrow.

One more note: there's a lot of trailing whitespace in your driver. I
think Mark will strip it before committing your patch but it would be
easier for everyone if you could avoid trailing whitespace in future
patches.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
