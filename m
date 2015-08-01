From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 01 Aug 2015 00:36:13 +0000
Subject: Re: [lm-sensors] [PATCH v1] hwmon: (nct7802) Add device tree support
Message-Id: <55BC147D.4080706@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438380059-30114-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1438380059-30114-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Constantine Shulyupin <const@MakeLinux.com>
Cc: Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Constantine,

On 07/31/2015 03:00 PM, Constantine Shulyupin wrote:

Please add a description of what you are doing here.

> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
> The first trial.
> Question: how to configure local temp4 (EnLTD)?
> Allow "temp4_type = <3>" (EnLTD=3-2=1) or "temp4_enable = <1>" or else?

I don't see a reason to disable it. After all, it is always present.

Please make sure you copy the devicetree mailing list and the devicetree
maintainers for discussing devicetree properties. You can use
scripts/get_maintainer.pl to determine who needs to be copied.

The limited scope of the properties suggests that you might plan to submit
further patches to add more properties. Specifically, the chip also has
configurable voltage sensors, fan status, and fan control, for which
you would probably need properties as well. Splitting patch submission
for the properties into multiple chunks will make it difficult to review
for the devicetree maintainers. I would suggest to determine all required
bindings and submit at least the complete bindings document in one go.

> ---
>   .../devicetree/bindings/hwmon/nct7802.txt          | 28 ++++++++++++
>   .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>   drivers/hwmon/nct7802.c                            | 52 +++++++++++++++++-----

You should probably split this into three patches.

- Add vendor ID to vendor prefixes
- Add devicetree properties
- Add implementation

>   3 files changed, 71 insertions(+), 10 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/nct7802.txt
>
> diff --git a/Documentation/devicetree/bindings/hwmon/nct7802.txt b/Documentation/devicetree/bindings/hwmon/nct7802.txt
> new file mode 100644
> index 0000000..568d3aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nct7802.txt
> @@ -0,0 +1,28 @@
> +Nuvoton NCT7802Y Hardware Monitoring IC
> +
> +Required node properties:
> +
> + - "compatible": must be "nuvoton,nct7802"
> + - "reg": I2C bus address of the device
> +
> +Optional properties:
> +
> + - temp1_type
> + - temp2_type
> + - temp3_type

Please use '-' instead of '_', and use full words.
Not sure how to enumerate the different sensors - looking for advice from devicetree
maintainers.

> +
> +Valid values:
> +
> + 0 - disabled
> + 3 - thermal diode
> + 4 - thermistor

The numbering ties into implementation details (sysfs representation). This is
not desirable for devicetree properties, which are supposed to be OS and implementation
independent.

It might make sense to use strings here. 'disabled' seems redundant, in a way -
a temperature sensor might be considered disabled if it is not listed.

Another option might be to have a single property, such as

	temperature-sensors = <0, 1, 2, 1>;

where each value indicates one of the sensors, with
	0 - disabled
	1 - diode
	2 - thermistor

I don't really have a strong opinion, though. Again looking for advice
from devicetree maintainers.

> +
> +Example nct7802 node:
> +
> +nct7802 {
> +	compatible = "nuvoton,nct7802";
> +	reg = <0x2a>;
> +	temp1_type = <4>;
> +	temp2_type = <4>;
> +	temp3_type = <4>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 181b53e..821e000 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -149,6 +149,7 @@ netxeon		Shenzhen Netxeon Technology CO., LTD
>   newhaven	Newhaven Display International
>   nintendo	Nintendo
>   nokia	Nokia
> +nuvoton	Nuvoton
>   nvidia	NVIDIA
>   nxp	NXP Semiconductors
>   onnn	ON Semiconductor Corp.
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index 3ce33d2..2be995d 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -84,24 +84,30 @@ static ssize_t show_temp_type(struct device *dev, struct device_attribute *attr,
>   	return sprintf(buf, "%u\n", (mode >> (2 * sattr->index) & 3) + 2);
>   }
>
> +int set_temp_type(struct nct7802_data *data, int index, u8 type)
> +{
> +	if (index = 2 && type != 4) /* RD3 */
> +		return -EINVAL;
> +	if ((type > 0 && type < 3) || type > 4)
> +		return -EINVAL;
> +	return regmap_update_bits(data->regmap, REG_MODE,
> +				  3 << 2 * index,
> +				  (type ? type - 2 : 0) << 2 * index);
> +}
> +
>   static ssize_t store_temp_type(struct device *dev,
>   			       struct device_attribute *attr,
>   			       const char *buf, size_t count)
>   {
>   	struct nct7802_data *data = dev_get_drvdata(dev);
>   	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
> -	unsigned int type;
> +	u8 type;
>   	int err;
>
> -	err = kstrtouint(buf, 0, &type);
> +	err = kstrtou8(buf, 0, &type);
>   	if (err < 0)
>   		return err;
> -	if (sattr->index = 2 && type != 4) /* RD3 */
> -		return -EINVAL;
> -	if (type < 3 || type > 4)
> -		return -EINVAL;
> -	err = regmap_update_bits(data->regmap, REG_MODE,
> -			3 << 2 * sattr->index, (type - 2) << 2 * sattr->index);
> +	err = set_temp_type(data, sattr->index, type);
>   	return err ? : count;
>   }
>
> @@ -1077,9 +1083,11 @@ static const struct regmap_config nct7802_regmap_config = {
>   	.volatile_reg = nct7802_regmap_is_volatile,
>   };
>
> -static int nct7802_init_chip(struct nct7802_data *data)
> +static int nct7802_init_chip(struct device_node *node,
> +			     struct nct7802_data *data)
>   {
>   	int err;
> +	u32 temp_type;
>
>   	/* Enable ADC */
>   	err = regmap_update_bits(data->regmap, REG_START, 0x01, 0x01);
> @@ -1091,6 +1099,22 @@ static int nct7802_init_chip(struct nct7802_data *data)
>   	if (err)
>   		return err;
>
> +	if (of_property_read_u32(node, "temp1_type", &temp_type) = 0) {
> +		err = set_temp_type(data, 0, temp_type);
> +		if (err)
> +			return err;
> +	}
> +	if (of_property_read_u32(node, "temp2_type", &temp_type) = 0) {
> +		err = set_temp_type(data, 1, temp_type);
> +		if (err)
> +			return err;
> +	}
> +	if (of_property_read_u32(node, "temp3_type", &temp_type) = 0) {
> +		err = set_temp_type(data, 2, temp_type);
> +		if (err)
> +			return err;
> +	}
> +
>   	/* Enable Vcore and VCC voltage monitoring */
>   	return regmap_update_bits(data->regmap, REG_VMON_ENABLE, 0x03, 0x03);
>   }
> @@ -1113,7 +1137,7 @@ static int nct7802_probe(struct i2c_client *client,
>
>   	mutex_init(&data->access_lock);
>
> -	ret = nct7802_init_chip(data);
> +	ret = nct7802_init_chip(client->dev.of_node, data);
>   	if (ret < 0)
>   		return ret;
>
> @@ -1133,10 +1157,18 @@ static const struct i2c_device_id nct7802_idtable[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, nct7802_idtable);
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id nct7802_dt_match[] = {
> +	{ .compatible = "nuvoton,nct7802" },
> +	{ },
> +};
> +#endif
> +
>   static struct i2c_driver nct7802_driver = {
>   	.class = I2C_CLASS_HWMON,
>   	.driver = {
>   		.name = DRVNAME,
> +		.of_match_table = of_match_ptr(nct7802_dt_match),
>   	},
>   	.detect = nct7802_detect,
>   	.probe = nct7802_probe,
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
