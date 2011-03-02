From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Mar 2011 17:57:18 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for Texas
Message-Id: <20110302185718.3c0e06dc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110224174807.41c7597f@endymion.delvare>
	<1298639897-26856-1-git-send-email-eibach@gdsys.de>
In-Reply-To: <1298639897-26856-1-git-send-email-eibach@gdsys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dirk Eibach <eibach@gdsys.de>
Cc: linux-kernel@vger.kernel.org, guenter.roeck@ericsson.com, lm-sensors@lm-sensors.org, rdunlap@xenotime.net, linux-doc@vger.kernel.org

Hi Dirk,

On Fri, 25 Feb 2011 14:18:17 +0100, Dirk Eibach wrote:
> Signed-off-by: Dirk Eibach <eibach@gdsys.de>
> ---
> Changes since v1:
> - fixed/extended Documentation
> - removed unused register definitions
> - hardcoded PGA fullscale table size
> - made sure patch applies against v2.6.38-rc4
> - reordered functions to avoid forward declaration
> - results from i2c_smbus_read_word_data() are handled correctly
> - moved locking into ads1015_read_value()
> - removed unnecessray clearing of bit
> - proper error handling in ads1015_read_value()
> - use DIV_ROUND_CLOSEST for scaling result
> - removed detect()
> 
> Changes since v2:
> - removed *all* leftovers from detect()
> - fixed return with mutex held
> - made sysfs representation configurable
>   (hope this will be the reference implementation for generations to come ;)
> 
> Changes since v3:
> - included linux/of.h
> - remove linux/types.h from header file
> - sysfs is now configured with a bitmask
> - assume big-endian of-properties

Patch applied. Two things I'd still like to comment on:

> (...)
> +static unsigned int ads1015_get_exported_channels(struct i2c_client *client)
> +{
> +	struct ads1015_platform_data *pdata = dev_get_platdata(&client->dev);
> +#ifdef CONFIG_OF
> +	struct device_node *np = client->dev.of_node;
> +	const __be32 *of_channels;
> +	int of_channels_size;
> +#endif
> +
> +	/* prefer platform data */
> +	if (pdata)
> +		return pdata->exported_channels;
> +
> +#ifdef CONFIG_OF
> +	/* fallback on OF */
> +	of_channels = of_get_property(np, "exported-channels",
> +				      &of_channels_size);
> +	if (of_channels && (of_channels_size = sizeof(*of_channels)))
> +		return be32_to_cpup(of_channels);
> +#endif

The be32 thing looks odd. I don't get the idea, but as I don't know
much about devicetree, I'll trust you.

> +
> +	/* fallback on default configuration */
> +	return ADS1015_DEFAULT_CHANNELS;
> +}
> +
> +static int ads1015_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct ads1015_data *data;
> +	int err;
> +	unsigned int exported_channels;
> +	unsigned int k;
> +	unsigned int n = 0;
> +
> +	data = kzalloc(sizeof(struct ads1015_data), GFP_KERNEL);
> +	if (!data) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->update_lock);
> +
> +	/* build sysfs attribute group */
> +	data->attr_group.attrs = data->attr_table;
> +	exported_channels = ads1015_get_exported_channels(client);
> +	for (k = 0; k < ADS1015_CONFIG_CHANNELS; ++k) {
> +		if (!(exported_channels & (1<<k)))
> +			continue;
> +		data->attr_table[n++] > +			all_attributes[k];

There was no reason to split this statement, so I've put it back on a
single line.

> +	}

Besides this, there is still more dynamic attribute handling than I
expected. It looks OK, but I'll propose a patch making it more static.
You'll tell me what you think.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
