From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 02 Oct 2014 13:22:14 +0000
Subject: Re: [lm-sensors] [PATCH v4 3/4] pmbus: add regulator support
Message-Id: <542D5186.7060908@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1412190349-16343-1-git-send-email-atull@opensource.altera.com> <1412190349-16343-4-git-send-email-atull@opensource.altera.com> <20141002112011.GS4273@sirena.org.uk>
In-Reply-To: <20141002112011.GS4273@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, atull@opensource.altera.com
Cc: jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com

On 10/02/2014 04:20 AM, Mark Brown wrote:
> On Wed, Oct 01, 2014 at 02:05:49PM -0500, atull@opensource.altera.com wrote:
>> From: Alan Tull <atull@opensource.altera.com>
>>
>> Add support for simple on/off control of each channel.
>
> This is basically fine but the regulator API has moved on a bit with the
> DT handling over the time you've been working on this.
>
>> Signed-off-by: Alan Tull <atull@opensource.altera.com>
>>
>> v2: Remove '#include <linux/regulator/machine.h>'
>>      Only one regulator per pmbus device
>
> Put this after the --- as covered in SubmittingPatches.
>
>> +static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
>> +{
>> +	struct device *dev = rdev_get_dev(rdev);
>> +	struct i2c_client *client = to_i2c_client(dev->parent);
>> +	u8 page = rdev_get_id(rdev);
>> +
>> +	return pmbus_update_byte_data(client, page, PMBUS_OPERATION,
>> +				      PB_OPERATION_CONTROL_ON,
>> +				      enable ? PB_OPERATION_CONTROL_ON : 0);
>> +}
>> +
>> +static int pmbus_regulator_enable(struct regulator_dev *rdev)
>> +{
>> +	return _pmbus_regulator_on_off(rdev, 1);
>> +}
>
> I'm not sure factoring out the code actually won much here.
>
>> +	np_regulators = of_get_child_by_name(dev->of_node, "regulators");
>> +	if (!np_regulators)
>> +		return 0;
>> +
>> +	ret = of_regulator_match(dev, np_regulators, info->reg_matches,
>> +				 info->num_regulators);
>> +	of_node_put(np_regulators);
>
> We now have helpers in the regulator core for this - set of_match and
> regulators_node in the regulator descriptor and the core will resolve
> this stuff for you and...
>
>> +		if (pdata && pdata->reg_init_data) {
>> +			config.init_data = &pdata->reg_init_data[i];
>> +		} else {
>> +			config.init_data = info->reg_matches[i].init_data;
>> +			config.of_node = info->reg_matches[i].of_node;
>> +		}
>
> ...you can just drop the else case (and check for reg_init_data) here.
>

Guess we'll need another version after all.

Alan, in that case please provide prototyles for the new API functions
introduced in patch 2/4.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
