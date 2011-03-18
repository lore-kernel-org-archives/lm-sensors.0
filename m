From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Mar 2011 21:02:40 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ads1015) Make gain and datarate
Message-Id: <20110318220240.399ade64@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110312081809.GB9347@angua.secretlab.ca>
 <1300269715-15819-1-git-send-email-eibach@gdsys.de>
In-Reply-To: <1300269715-15819-1-git-send-email-eibach@gdsys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Dirk Eibach <eibach@gdsys.de>
Cc: lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, rdunlap@xenotime.net, devicetree-discuss@lists.ozlabs.org, w.sang@pengutronix.de

Hi Dirk,

On Wed, 16 Mar 2011 11:01:55 +0100, Dirk Eibach wrote:
> Configuration for ads1015 gain and datarate is possible via
> devicetree or platform data.
> 
> This is a followup patch to previous ads1015 patches on Jean Delvares
> tree.
> 
> Changes since v1:
> - replaced exported_channels bitmask with an enable entry per channel
> - improved platform data example in Documentation
> - improved patch description
> 
> Signed-off-by: Dirk Eibach <eibach@gdsys.de>
> ---
>  .../devicetree/bindings/hwmon/ads1015.txt          |   73 +++++++++++++
>  Documentation/devicetree/bindings/i2c/ads1015.txt  |   29 -----
>  Documentation/hwmon/ads1015                        |   44 ++++++---
>  drivers/hwmon/ads1015.c                            |  113 +++++++++++++++----
>  include/linux/i2c/ads1015.h                        |   10 ++-
>  5 files changed, 202 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ads1015.txt
>  delete mode 100644 Documentation/devicetree/bindings/i2c/ads1015.txt

Took me a little longer than I expected to review this, but here we go
finally:

> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ads1015.txt b/Documentation/devicetree/bindings/hwmon/ads1015.txt
> new file mode 100644
> index 0000000..fb6e139
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ads1015.txt
> @@ -0,0 +1,73 @@
> +ADS1015 (I2C)
> +
> +This device is a 12-bit A-D converter with 4 inputs.
> +
> +The inputs can be used single ended or in certain differential combinations.
> +
> +For configuration all possible combinations are mapped to 8 channels:
> +  0: Voltage over AIN0 and AIN1.
> +  1: Voltage over AIN0 and AIN3.
> +  2: Voltage over AIN1 and AIN3.
> +  3: Voltage over AIN2 and AIN3.
> +  4: Voltage over AIN0 and GND.
> +  5: Voltage over AIN1 and GND.
> +  6: Voltage over AIN2 and GND.
> +  7: Voltage over AIN3 and GND.
> +
> +Each channel can be configured indvidually:

Spelling: individually.

> + - pga ist the programmable gain amplifier

"is", not "ist" ;)

> +    0: FS = +/- 6.144 V

Please include the term "full scale" in the description, otherwise it's
not clear what "FS" means.

> +    1: FS = +/- 4.096 V
> +    2: FS = +/- 2.048 V (default)
> +    3: FS = +/- 1.024 V
> +    4: FS = +/- 0.512 V
> +    5: FS = +/- 0.256 V
> + - data_rate in samples per second
> +    0: 128
> +    1: 250
> +    2: 490
> +    3: 920
> +    4: 1600
> +    5: 2400
> +    6: 3300

These sample rates make me wonder if hwmon is really the right
subsystem for this device. hwmon is more like 2 samples per second.

As you documented the default value for pga, you should do the same for
data_rate.

> +
> +1) The /ads1015 node
> +
> +  Required properties:
> +
> +   - compatible : must be "ti,ads1015"
> +   - reg : I2C busaddress of the device

Missing space between "bus" and "address".

> +   - #address-cells : must be <1>
> +   - #size-cells : must be <0>
> +
> +  The node contains child nodes for each channel that the platform uses.
> +
> +  Example ADS1015 node:
> +
> +    ads1015@49 {
> +	    compatible = "ti,ads1015";
> +	    reg = <0x49>;
> +	    #address-cells = <1>;
> +	    #size-cells = <0>;
> +
> +	    [ child node definitions... ]
> +    }
> +
> +2) channel nodes
> +
> +  Required properties:
> +
> +   - reg : the channel number
> +
> +  Optional properties:
> +
> +   - ti,gain : the programmable gain amplifier setting
> +   - ti,datarate : the converter datarate

Missing space between "data" and "rate" (the second time, of course.)
It's also confusing to have "datarate" for the property, but
"data_rate" as the struct member.

> +
> +  Example ADS1015 node:

This is an example channel node, not ADS1015 node.

> +
> +    channel@4 {
> +	    reg = <4>;
> +	    ti,gain = <3>;
> +	    ti,datarate = <5>;
> +    };
> diff --git a/Documentation/devicetree/bindings/i2c/ads1015.txt b/Documentation/devicetree/bindings/i2c/ads1015.txt
> deleted file mode 100644
> index 985e24d..0000000
> --- a/Documentation/devicetree/bindings/i2c/ads1015.txt
> +++ /dev/null

For the next iteration, please consider that the file was originally
located in Documentation/devicetree/bindings/hwmon. This is where I put
it upon recommendation by Grant Likely. So this new patch should modify
the document in-place, rather than create a new one and delete the old
one.

> @@ -1,29 +0,0 @@
> -ADS1015 (I2C)
> -
> -This device is a 12-bit A-D converter with 4 inputs.
> -
> -The inputs can be used single ended or in certain differential combinations.
> -
> -For configuration all possible combinations are mapped to 8 channels:
> -0: Voltage over AIN0 and AIN1.
> -1: Voltage over AIN0 and AIN3.
> -2: Voltage over AIN1 and AIN3.
> -3: Voltage over AIN2 and AIN3.
> -4: Voltage over AIN0 and GND.
> -5: Voltage over AIN1 and GND.
> -6: Voltage over AIN2 and GND.
> -7: Voltage over AIN3 and GND.
> -
> -Optional properties:
> -
> - - exported-channels : exported_channels is a bitmask that specifies which
> -		       channels should be accessible by the user.
> -
> -Example:
> -ads1015@49 {
> -	compatible = "ti,ads1015";
> -	reg = <0x49>;
> -	exported-channels = <0x14>;
> -};
> -
> -In this example only channel 2 and 4 would be accessible by the user.
> diff --git a/Documentation/hwmon/ads1015 b/Documentation/hwmon/ads1015
> index 56ee797..18a8e00 100644
> --- a/Documentation/hwmon/ads1015
> +++ b/Documentation/hwmon/ads1015
> @@ -38,30 +38,48 @@ Platform Data
>  
>  In linux/i2c/ads1015.h platform data is defined as:
>  
> +struct ads1015_channel_data {
> +	unsigned int pga;
> +	unsigned int data_rate;
> +};
> +
>  struct ads1015_platform_data {
>  	unsigned int exported_channels;
> +	struct ads1015_channel_data channel_data[ADS1015_CONFIG_CHANNELS];
>  };

These structure definitions do not match the actual ones in
<linux/i2c/ads1015.h>. This is a common problem when you duplicate
code... It doesn't stay magically in sync.

>  
>  exported_channels is a bitmask that specifies which inputs should be exported.

exported_channels no longer exists.

>  
> +channel_data contains configuration data for the exported inputs:

It was underlined before that the term "exported" should be avoided
here. "for the used input combinations" would sound better.

> +- pga ist the programmable gain amplifier

"is"

> +  0: FS = +/- 6.144 V
> +  1: FS = +/- 4.096 V
> +  2: FS = +/- 2.048 V (default)

I fail to see how this default is relevant when using platform data. If
the value isn't specified as part of the channel data, it'll be read as
0 by the driver, not 2.

> +  3: FS = +/- 1.024 V
> +  4: FS = +/- 0.512 V
> +  5: FS = +/- 0.256 V
> +- data_rate in samples per second
> +  0: 128
> +  1: 250
> +  2: 490
> +  3: 920
> +  4: 1600
> +  5: 2400
> +  6: 3300
> +

The duplicate documentation between Documentation/hwmon/ads1015 and
Documentation/devicetree/bindings/hwmon/ads1015.txt is somewhat
unpleasant. It will be difficult to keep things in sync over time. I
wonder if this could be avoided.

>  Example:
>  struct ads1015_platform_data data = {
> -	.exported_channels = (1 << 2) | (1 << 4)
> +	.channel_data = {
> +		[2] = { .enabled = true, .pga = 1, .data_rate = 0 },
> +		[4] = { .enabled = true, .pga = 4, .data_rate = 5 },
> +	}
>  };

This looks pretty good, I have to admit :)

>  
> -In this case only in2_input and in4_input would be created.
> +In this case only in2_input(FS +/- 4.096 V, 128 SPS) and in4_input

Space missing before opening parenthesis.

> +(FS +/- 0.512 V, 2400 SPS) would be created.
>  
>  Devicetree
>  ----------
>  
> -The ads1015 node may have an "exported-channels" property.
> -exported_channels is a bitmask that specifies which inputs should be exported.
> -
> -Example:
> -ads1015@49 {
> -	compatible = "ti,ads1015";
> -	reg = <0x49>;
> -	exported-channels = < 0x14 >;
> -};
> -
> -In this case only in2_input and in4_input would be created.
> +Configuration is also possible via devicetree:
> +Documentation/devicetree/bindings/hwmon/ads1015.txt
> diff --git a/drivers/hwmon/ads1015.c b/drivers/hwmon/ads1015.c
> index 8ef2b60..a7c524d 100644
> --- a/drivers/hwmon/ads1015.c
> +++ b/drivers/hwmon/ads1015.c
> @@ -25,7 +25,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> -#include <linux/jiffies.h>
> +#include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
> @@ -45,12 +45,18 @@ enum {
>  static const unsigned int fullscale_table[8] = {
>  	6144, 4096, 2048, 1024, 512, 256, 256, 256 };
>  
> -#define ADS1015_CONFIG_CHANNELS 8
> +/* Data rates in samples per second */
> +static const unsigned int data_rate_table[8] = {
> +	128, 250, 490, 920, 1600, 2400, 3300, 3300 };
> +
>  #define ADS1015_DEFAULT_CHANNELS 0xff
> +#define ADS1015_DEFAULT_PGA 2
> +#define ADS1015_DEFAULT_DATA_RATE 4

Does it really make sense to have a default configuration? The chip
needs proper configuration to be usable at all, I would think it makes
sense to make the platform or devicetree data mandatory. I am
particularly worried about the case where the PGA is set improperly: the
input voltage could be over what the chip supports?

Or asking the other way around: do you see any problem with making the
platform data or devicetree data mandatory?

>  
>  struct ads1015_data {
>  	struct device *hwmon_dev;
>  	struct mutex update_lock; /* mutex protect updates */
> +	struct ads1015_channel_data channel_data[ADS1015_CONFIG_CHANNELS];
>  };
>  
>  static s32 ads1015_read_reg(struct i2c_client *client, unsigned int reg)
> @@ -71,32 +77,38 @@ static int ads1015_read_value(struct i2c_client *client, unsigned int channel,
>  {
>  	u16 config;
>  	s16 conversion;
> -	unsigned int pga;
> +	struct ads1015_data *data = i2c_get_clientdata(client);
> +	unsigned int pga = data->channel_data[channel].pga;
>  	int fullscale;
> +	unsigned int data_rate = data->channel_data[channel].data_rate;
> +	unsigned int conversion_time_ms;
>  	unsigned int k;
> -	struct ads1015_data *data = i2c_get_clientdata(client);
>  	int res;
>  
>  	mutex_lock(&data->update_lock);
>  
> -	/* get fullscale voltage */
> +	/* get channel parameters */
>  	res = ads1015_read_reg(client, ADS1015_CONFIG);
>  	if (res < 0)
>  		goto err_unlock;
>  	config = res;
> -	pga = (config >> 9) & 0x0007;
>  	fullscale = fullscale_table[pga];
> +	conversion_time_ms = 1 + 1000 / data_rate_table[data_rate];

Maybe a suitable use case for DIV_ROUND_UP()?

>  
>  	/* set channel and start single conversion */

You don't only set the channel and start the conversion. You also set
the PGA and data rate.

> -	config &= ~(0x0007 << 12);
> -	config |= (1 << 15) | (1 << 8) | (channel & 0x0007) << 12;
> +	config &= 0x001f;
> +	config |= (1 << 15) | (1 << 8);
> +	config |= (channel & 0x0007) << 12;
> +	config |= (pga & 0x0007) << 9;
> +	config |= (data_rate & 0x0007) << 5;
>  
> -	/* wait until conversion finished */
>  	res = ads1015_write_reg(client, ADS1015_CONFIG, config);
>  	if (res < 0)
>  		goto err_unlock;
> +
> +	/* wait until conversion finished */
>  	for (k = 0; k < 5; ++k) {
> -		schedule_timeout(msecs_to_jiffies(1));
> +		msleep(k ? 1 : conversion_time_ms);
>  		res = ads1015_read_reg(client, ADS1015_CONFIG);
>  		if (res < 0)
>  			goto err_unlock;

This could be done more efficiently: msleep(conversion_time_ms) before
the loop, and msleep(1) inside the loop (after reading the register.)

That being said... As the conversion rate is known in advance, the
retry loop should never be needed, should it? Did you ever see it
trigger?

> @@ -166,29 +178,83 @@ static int ads1015_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static unsigned int ads1015_get_exported_channels(struct i2c_client *client)
> +static void ads1015_get_exported_channels(struct i2c_client *client)
>  {
> +	unsigned int k;
> +	struct ads1015_data *data = i2c_get_clientdata(client);
>  	struct ads1015_platform_data *pdata = dev_get_platdata(&client->dev);
>  #ifdef CONFIG_OF
> -	struct device_node *np = client->dev.of_node;
> -	const __be32 *of_channels;
> -	int of_channels_size;
> +	struct device_node *node;
>  #endif
>  
>  	/* prefer platform data */
> -	if (pdata)
> -		return pdata->exported_channels;
> +	if (pdata) {
> +		memcpy(data->channel_data, pdata->channel_data,
> +		       sizeof(data->channel_data));
> +		return;
> +	}
>  
>  #ifdef CONFIG_OF
>  	/* fallback on OF */
> -	of_channels = of_get_property(np, "exported-channels",
> -				      &of_channels_size);
> -	if (of_channels && (of_channels_size = sizeof(*of_channels)))
> -		return be32_to_cpup(of_channels);
> +	if (!client->dev.of_node
> +	    || !of_get_next_child(client->dev.of_node, NULL))
> +		goto fallback_default;
> +
> +	for_each_child_of_node(client->dev.of_node, node) {
> +		const __be32 *property;
> +		int len;
> +		unsigned int channel;
> +		unsigned int pga = ADS1015_DEFAULT_PGA;
> +		unsigned int data_rate = ADS1015_DEFAULT_DATA_RATE;
> +
> +		property = of_get_property(node, "reg", &len);
> +		if (!property || (len < sizeof(int))) {

For consistency with the following tests, you should test for len !sizeof(int). Note that you can omit the parentheses around this test,
BTW, and same below.

> +			dev_err(&client->dev, "ads1015: invalid reg on %s\n",

The leading "ads1015:" in all error messages is redundant, as dev_err()
will include the client name already.

> +				node->full_name);
> +			continue;
> +		}
> +
> +		channel = be32_to_cpup(property);
> +		if (channel > ADS1015_CONFIG_CHANNELS) {
> +			dev_err(&client->dev, "ads1015: invalid addr=%x on %s\n",
> +				channel, node->full_name);

"addr" is misleading, it is a channel number (sort of, at least), not
an address. I'm sure you can come up with a more useful error message.

> +			continue;
> +		}
> +
> +		property = of_get_property(node, "ti,gain", &len);
> +		if (property && (len = sizeof(int))) {
> +			pga = be32_to_cpup(property);
> +			if (pga > 7) {
> +				dev_err(&client->dev,
> +					"ads1015: invalid gain on %s\n",
> +					node->full_name);
> +			}
> +		}
> +
> +		property = of_get_property(node, "ti,datarate", &len);
> +		if (property && (len = sizeof(int))) {
> +			data_rate = be32_to_cpup(property);
> +			if (data_rate > 7)

I count only 6 possible data rates.

> +				dev_err(&client->dev,
> +					"ads1015: invalid data_rate on %s\n",
> +					node->full_name);

Curly braces would be appreciated, for readability and consistency.

> +		}
> +
> +		data->channel_data[channel].enabled = true;
> +		data->channel_data[channel].pga = pga;
> +		data->channel_data[channel].data_rate = data_rate;
> +	}
> +
> +	return;
>  #endif
>  
>  	/* fallback on default configuration */
> -	return ADS1015_DEFAULT_CHANNELS;
> +fallback_default:

Use of goto and label is discouraged, except for error paths. If you
feel the need for it, it suggests that the devicetree parsing code
should be moved to a separate function. Maybe this would let you merge
the two #ifdef CONFIG_OF blocks, which would be nice, and also get rid
of the following warning I'm seeing:

drivers/hwmon/ads1015.c: In function ‘ads1015_get_exported_channels’:
drivers/hwmon/ads1015.c:252:1: warning: label ‘fallback_default’ defined but not used



> +	for (k = 0; k < ADS1015_CONFIG_CHANNELS; ++k) {
> +		data->channel_data[k].enabled = true;
> +		data->channel_data[k].pga = ADS1015_DEFAULT_PGA;
> +		data->channel_data[k].data_rate = ADS1015_DEFAULT_DATA_RATE;
> +	}

As said earlier, I'm really not sure that this default makes any sense.

>  }  
>  static int ads1015_probe(struct i2c_client *client,
> @@ -196,7 +262,6 @@ static int ads1015_probe(struct i2c_client *client,
>  {
>  	struct ads1015_data *data;
>  	int err;
> -	unsigned int exported_channels;
>  	unsigned int k;
>  
>  	data = kzalloc(sizeof(struct ads1015_data), GFP_KERNEL);
> @@ -209,9 +274,9 @@ static int ads1015_probe(struct i2c_client *client,
>  	mutex_init(&data->update_lock);
>  
>  	/* build sysfs attribute group */
> -	exported_channels = ads1015_get_exported_channels(client);
> +	ads1015_get_exported_channels(client);

This function would rather be named ads1015_get_channels_config or
similar.

>  	for (k = 0; k < ADS1015_CONFIG_CHANNELS; ++k) {
> -		if (!(exported_channels & (1<<k)))
> +		if (!data->channel_data[k].enabled)
>  			continue;
>  		err = device_create_file(&client->dev, &ads1015_in[k].dev_attr);
>  		if (err)
> diff --git a/include/linux/i2c/ads1015.h b/include/linux/i2c/ads1015.h
> index 8541c6a..0d9e746 100644
> --- a/include/linux/i2c/ads1015.h
> +++ b/include/linux/i2c/ads1015.h
> @@ -21,8 +21,16 @@
>  #ifndef LINUX_ADS1015_H
>  #define LINUX_ADS1015_H
>  
> +#define ADS1015_CONFIG_CHANNELS 8

I can't make sense of the "CONFIG" part in the name.

> +
> +struct ads1015_channel_data {
> +	bool enabled;
> +	unsigned int pga;
> +	unsigned int data_rate;
> +};
> +
>  struct ads1015_platform_data {
> -	unsigned int exported_channels;
> +	struct ads1015_channel_data channel_data[ADS1015_CONFIG_CHANNELS];
>  };
>  
>  #endif /* LINUX_ADS1015_H */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
