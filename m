From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 02 Jun 2013 15:39:23 +0000
Subject: Re: [lm-sensors] [PATCHv2 1/3] Add support for GMT G762/G763 PWM fan controller
Message-Id: <87mwr88qtw.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1369687670.git.arno@natisbad.org>
	<b44f55c4194f6cd8c94f8a3d63ad5c8bd1d1cfe0.1369687670.git.arno@natisbad.org>
	<20130601143304.GA6580@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Simon Guinot <simon.guinot@sequanux.org>

Hi Guenter,

apologies for the looong email ...

Guenter Roeck <linux@roeck-us.net> writes:

>> +	return (clk*30*gear_mult)/((cnt ? cnt : 1)*p*clk_div);
>
> Please follow CodingStyle and add spaces between operators (not just
> here).

done.


>> +static struct g762_data *g762_update_client(struct device *dev)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct g762_data *data = i2c_get_clientdata(client);
>> +
>> +	mutex_lock(&data->update_lock);
>> +	if (time_before(jiffies, data->last_updated + G762_UPDATE_INTERVAL) &&
>> +	    likely(data->valid))
>> +		goto out;
>> +
>> +	data->set_cnt =  i2c_smbus_read_byte_data(client, G762_REG_SET_CNT);
>> +	data->act_cnt =  i2c_smbus_read_byte_data(client, G762_REG_ACT_CNT);
>> +	data->fan_sta =  i2c_smbus_read_byte_data(client, G762_REG_FAN_STA);
>> +	data->set_out =  i2c_smbus_read_byte_data(client, G762_REG_SET_OUT);
>> +	data->fan_cmd1 = i2c_smbus_read_byte_data(client, G762_REG_FAN_CMD1);
>> +	data->fan_cmd2 = i2c_smbus_read_byte_data(client, G762_REG_FAN_CMD2);
>> +
> Failed i2c reads (returning negative values) not a problem ? Driver
> operation will be more or less random in that case, and may result in
> erratic behavior.

Now checking return value of both i2c_smbus_{read,write}_byte_data(). I
also created wrappers for both functions to report some info upon error.


>> +/* Set fan RPM value. This only makes sense in closed-loop mode. */
>> +static int do_set_fan_target(struct device *dev, unsigned long val)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct g762_data *data = g762_update_client(dev);
>> +	int ret = -EINVAL;
>> +
>> +	mutex_lock(&data->update_lock);
>> +	if (data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE) { /* closed-loop */
>> +		data->set_cnt = cnt_from_rpm(val, data->clk,
>> +					     PULSE_FROM_REG(data->fan_cmd1),
>> +					     CLKDIV_FROM_REG(data->fan_cmd1),
>> +					     GEARMULT_FROM_REG(data->fan_cmd2));
>> +		ret = i2c_smbus_write_byte_data(client, G762_REG_SET_CNT,
>> +						data->set_cnt);
>
> In closed loop mode you have two paths to set the same register. Given that,
> it doesn't make sense to me to set the fan target with set_pwm as
> well.

It does not seems logical to me to remove access to pwm1 in closed-loop
mode, i.e. prevent the user to have access to the 0-255 interface now
that she can pass RPM values.

I am not an expert but utilities like fancontrol/pwmconfig work with
pwm1 sysfs entry, not fan1_target. AFAICT from sysfs doc, this simple
and agnostic interface (0 to 255 value) should work for all
combinations: DC vs PWM, closed vs open-loop. If I make pwm1 unavailable
in closed-loop mode to keep only fan1_target as a unique path to control
the speed, then this goes against least expectation principle and
requires hacks from user or .dts writer: one of those will have to force
open-loop to change the value. On ReadyNAS Duo v2 and 102, if I do not
provide a .dts file which changes the default value of the chip (not 
modified by u-boot), pwmconfig/fancontrol will not work by default.

As I do not have your background on the topic, I'll let you decide but
here is what seems logical to me (considering ReadyNAS hardware and
default values, how the chip works and the experience I had w/
fancontrol and pwmconfig):   

 - let pwm1 available in all cases: DC/PWM and closed/open-loop. This
   makes fancontrol usable in all cases w/o any user interaction.

 - provide fan_target in closed-loop mode only and do not accept values
   before the mode is indeed closed-loop. I think we can expect the
   user who uses this interface to have read some documentation. For
   instance, you need to know which value makes sense on your platform,
   which is not that obvious.

Guenter, if you still think it is a good idea to make pwm1 unavailable
in closed-loop mode, I will make the change and stop arguing.


> If you use one attribute (set_pwm) for setting set_out, and the other for
> set_cnt, your problems with conditional command acceptance should be solved.

I do not have problems with current logic: in practice, for a given
board, mode will be set (by u-boot or driver) before the speed related
registers are modified. I even take care in pdata attributes import to
set fan_target after everything else.


>> +static void g762_platform_data_of_overload(struct i2c_client *client,
>> +					   struct g762_platform_data *pdata)
>> +{
>> +	if (!client->dev.of_node)
>> +		return;
>> +
>> +	g762_of_import_one_prop(client, &pdata->fan_gear_mode, "fan_gear_mode");
>> +	g762_of_import_one_prop(client, &pdata->pwm_polarity, "pwm_polarity");
>> +	g762_of_import_one_prop(client, &pdata->fan_startv, "fan_startv");
>> +	g762_of_import_one_prop(client, &pdata->pwm_freq, "pwm_freq");
>> +	g762_of_import_one_prop(client, &pdata->fan_div, "fan_div");
>> +	g762_of_import_one_prop(client, &pdata->fan_pulses, "fan_pulses");
>> +	g762_of_import_one_prop(client, &pdata->pwm_mode, "pwm_mode");
>> +	g762_of_import_one_prop(client, &pdata->fan_target, "fan_target");
>> +	g762_of_import_one_prop(client, &pdata->pwm_enable, "pwm_enable");
>
> I second the other comments ... why not use the sysfs interface to set the
> values it supports ?

answer in previous email to Simon.


>> +/*
>> + * Read and write functions for pwm1 sysfs file. Get and set the fan speed
>> + * in both open and closed-loop mode. Speed is given as a relative value
>> + * between 0 and 255, where 255 is maximum speed. Note that due to rounding
>> + * errors it is possible that you don't read back exactly the value you have
>> + * set.
>> + */
>> +static ssize_t get_pwm(struct device *dev, struct device_attribute *da,
>> +		       char *buf)
>> +{
>> +	struct g762_data *data = g762_update_client(dev);
>> +	int val;
>> +
>> +	mutex_lock(&data->update_lock);
>> +	if (data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE) { /* closed-loop */
>> +		val = PWM_FROM_CNT(data->set_cnt);
>> +	} else {                                           /* open-loop */
>> +		val = data->set_out;
>> +	}
>
> Again, this is not very consistent, as set_cnt is pretty much reported twice
> (as pwm and as target speed) in closed loop mode. Just report set_out here.

will do if you decide I should kill pwm1 in closed-loop mode. 


> Side note: { } is not needed in single-statement conditionals.

Will be fixed in v3.


>> +/* When filling a g762_platform_data structure to be passed during platform
>> + * init to the driver, it needs to be initialized to the following default
>> + * value before changing specific fields. This is needed to avoid a sparse
>> + * initialization to have current values replaced by 0 */
>> +
> comment style

Will be fixed in v3.


>> +static const struct g762_platform_data G762_DEFAULT_PDATA = {
>> +	.fan_startv = G762_DEFAULT_NO_OVERLOAD,
>> +	.fan_gear_mode = G762_DEFAULT_NO_OVERLOAD,
>> +	.fan_div = G762_DEFAULT_NO_OVERLOAD,
>> +	.fan_pulses = G762_DEFAULT_NO_OVERLOAD,
>> +	.fan_target = G762_DEFAULT_NO_OVERLOAD,
>> +	.pwm_polarity = G762_DEFAULT_NO_OVERLOAD,
>> +	.pwm_enable = G762_DEFAULT_NO_OVERLOAD,
>> +	.pwm_freq = G762_DEFAULT_NO_OVERLOAD,
>> +	.pwm_mode = G762_DEFAULT_NO_OVERLOAD,
>> +};
>> +
> A constant array in an include file ? Please not; this is completely
> unacceptable. You can pass platform data to the driver like every other
> driver does. The entire approach with G762_DEFAULT_NO_OVERLOAD is odd anyway;
> it would be great if you could come up with another mechanism to pass platform
> data. It is quite common to use '0' for 'default' to avoid having to initialize
> all default fields.

My life would be easier if I could use 0 and just let the developer pass
a sparse g762_platform_data, initialized only with the value she has
interest in, but as discussed in previous email to Simon, 0 is a valid
value for some attributes (fan_startv, fan_gear_mode, pwm_polarity,
pwm_mode at least) which prevents using it as a 'default' value. If a
good pattern exists for that problem I would happy to learn it.

In a first version of v3, I first replaced G762_DEFAULT_PDATA by the
declaration of a function which sets all the fields of the structure one
bye one to G762_DEFAULT_NO_OVERLOAD. The header looked better but I don't
think the whole approach did.

So I changed my mind and went for the following: a wrapper for passing
attribute values, which sets MSB of passed value to 1. This allows to
spot initialized values in a sparse init. I put some info and an example
at the beginning of the header.

I am currently rereading v3 and will post it soon.

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
