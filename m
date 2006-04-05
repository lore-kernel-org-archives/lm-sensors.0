From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 05 Apr 2006 08:58:20 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add w83791d support
Message-Id: <20060405105820.43e93bd6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
In-Reply-To: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Charles,

> Add support for the w83791d sensor chip. The w83791d hardware is
> somewhere between the w83781d and the w83792d and this driver code
> is derived from the code that supports those chips.

Sorry for having been rather silent and slow about your driver to date.
I can see that Greg KH and Rudolf Marek did some review on your code
already, so it should be quite good already, and hopefully not far from
being mergeable.

Here are my own comments.

> +Author: Charles Spirakis
> +Contact: bezaur at gmail.com

Put it all on one line please (makes it easier to cut'n'paste into an
e-mail client to contact the author.)

> +static int init;
> +module_param(init, bool, 0);
> +MODULE_PARM_DESC(init, "Set to one to force chip initialization");

This parameter would be better named "reset", as you still do some
initialization regardless of it being set to 0. What really changes is
the reset step.

> +#define IN_TO_REG(nr,val)	(SENSORS_LIMIT((((val) * 10 + 8) / 16), 0, 255=
))
> +#define IN_FROM_REG(nr,val)	(((val) * 16) / 10)
> (...)
> +	return sprintf(buf,"%ld\n", \
> +			(long)(IN_FROM_REG(nr, (data->reg[nr] * 10)))); \
> (...)
> +	val =3D simple_strtoul(buf, NULL, 10) / 10; \
> +	 \
> +	mutex_lock(&data->update_lock); \
> +	data->in_##reg[nr] =3D SENSORS_LIMIT(IN_TO_REG(nr, val), 0, 255); \

This is no good, you're losing resolution by doing opposite operations
inside and outside the macros. Please simplify it all.

> +/* for temp1 only */
> +#define TEMP1_FROM_REG(val)	(((val) & 0x80 ? \
> +					(val) - 0x100 : \
> +					(val)) * 1000)
> +#define TEMP1_TO_REG(val)	(SENSORS_LIMIT(((val) < 0 ? \
> +					(val) + (0x100 * 1000) : \
> +					(val)) / 1000, 0, 0xff))

What you are doing here with your negative value check and offset
addition, is converting from u8 to s8 and vice-versa. You can let the
hardware do it for you, this will be both more readable and more
efficient. All you have to do is declare w83791d_data.temp1 as an array
of s8 instead of u8 (see the lm90 driver for an example.)

Same goes for temp2 and temp3, except that this is a bit more complex
due to the additional resolution bit. Usually we store each temperature
value in an s16 (left padded, 7 LSB are always 0) in this case.

> +#define PWM_FROM_REG(val)		(val)
> +#define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))

You are not using these for now, so you shouldn't define them.

> #define BEEP_ENABLE_TO_REG(val)		((val) ? 1 : 0)
> #define BEEP_ENABLE_FROM_REG(val)	((val) ? 1 : 0)

These ones are not especially useful, at least the way they are
implemented. They would make sense if you had no separate
w83791d_data.beep_enable member, but you do. So, please either drop
that separate member and keep the macros (with some changes, obviously),
or drop the macros.

> +static u8 div_to_reg(long val)
> +{
> +	int i;
> +	val =3D SENSORS_LIMIT(val, 1, 128) >> 1;
> +	for (i =3D 0; i < 6; i++) {
> +		if (val =3D 0)
> +			break;
> +		val >>=3D 1;
> +	}
> +	return (u8) i;
> +}

This code has a bug which was fixed in the w83792d driver recently: fan
clock divider value of 128 can't be set, because the end condition
should be "i < 7" instead of "i < 6". Please fix.

http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=9632051963cb6e6f7412990f8b962209b9334e13

In a more general way, you may want to take a look at the recent
changes which were made to the w83792d driver, and see if they could
apply to your code too.

+struct w83791d_data {
+	struct i2c_client client;
+	struct class_device *class_dev;
+	struct mutex update_lock;
+	enum chips type;

You don't use the type value anywhere at the moment, and the chances
that your driver will have to support more chips in the future are low,
so you could drop it to save some memory.

> +#define show_fan_reg(reg) \
> +static ssize_t show_##reg(struct device *dev, struct device_attribute *a=
ttr, \
> +				char *buf) \
> +{ \
> +	struct sensor_device_attribute *sensor_attr =3D \
> +						to_sensor_dev_attr(attr); \
> +	int nr =3D sensor_attr->index - 1; \

You could define the sysfs files attribute differently so that you
don't need to apply that offset on every access to every file. That
would be both shorter and more efficient.

> +	default:
> +		dev_warn(dev, "store_fan_div: Unexpected nr seen: %d\n", nr);
> +		count =3D -EINVAL;
> +		goto err_exit;

This is so unexpected that this just cannot happen, unless you have an
internal (code) error. So this part should either not exist at all (now
that the driver is working) or be only compiled in in debug mode.

> +	tmp_fan_div =3D ((data->fan_div[nr] << new_shift) & (~keep_mask));

The outermost pair of parentheses could be omitted.

> +	for (i =3D 0; i < 3; i++) {
> +		w83791d_write(client, W83791D_REG_BEEP_CTRL[i], val);
> +		val >>=3D 8;
> +	}

I think Rudolf told you to omit the "& 0xff" masking... but I don't
agree. I think the code is much clearer with the masking, and less
likely to break on future changes too. So feel free to add the mask
back.

> +static ssize_t store_vrm_reg(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct w83791d_data *data =3D i2c_get_clientdata(client);
> +	u32 val;
> +
> +	val =3D simple_strtoul(buf, NULL, 10);
> +	mutex_lock(&data->update_lock);
> +	data->vrm =3D val;
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}

You don't actually need to lock here. vrm is internal to the driver,
it's not read from a chip register.

> +	(*sub_cli) =3D sub_client > +			kzalloc(sizeof(struct i2c_client), GFP_=
KERNEL);
> (...)
> +	sub_client->flags =3D 0;

Not needed, as kzalloc already zeroed the whole structure.

> +	new_client->flags =3D 0;

Ditto. Also, I would appreciate if you could rename "new_client" to
just "client" in the detect function. I wish the first driver did not
use "new_client", so we wouldn't have it in all drivers now...

> +	data->valid =3D 0;

And here too.

> +	if (kind < 0) {
> +		if (w83791d_read(new_client, W83791D_REG_CONFIG) & 0x80) {
> +			dev_dbg(dev, "Detection failed at step 3\n");
> +			goto error1;
> +		}
> +		val1 =3D w83791d_read(new_client, W83791D_REG_BANK);
> +		val2 =3D w83791d_read(new_client, W83791D_REG_CHIPMAN);
> +		/* Check for Winbond ID if in bank 0 */
> +		if (!(val1 & 0x07)) {
> +			/* yes it is Bank0 */
> +			if (((!(val1 & 0x80)) && (val2 !=3D 0xa3)) ||
> +			    ((val1 & 0x80) && (val2 !=3D 0x5c))) {
> +				goto error1;
> +			}
> +		}
> +		/* If Winbond chip, address of chip and W83791D_REG_I2C_ADDR
> +		   should match */
> +		if (w83791d_read(new_client, W83791D_REG_I2C_ADDR) !=3D address) {
> +			dev_dbg(dev, "Detection failed at step 5\n");
> +			goto error1;
> +		}
> +	}

Please renumber the debug messages, and add one for the second possible
failure. I have a pending patch doing that for the w83792d driver:
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/i2c=
/hwmon-w83792d-quiet-on-misdetection.patch

> +	/* A few vars need to be filled upon startup */
> +	for (i =3D 1; i <=3D NUMBER_OF_FANIN; i++) {
> +		data->fan_min[i - 1] =3D w83791d_read(new_client,
> +						W83791D_REG_FAN_MIN[i]);
> +	}

Isn't it a nice off-by-one I'm spotting here? Please fix!

+	for (i =3D 0; i < 2; i++) {
+		device_create_file(dev, &sda_beep_ctrl[i].dev_attr);
+	}

You could use ARRAY_SIZE(sda_beep_ctrl) instead of hardcoding 2. This
is easier to understand for the reader, and more robust to future
changes too. I'm not sure if this array really adds anything though.

> +static int w83791d_read(struct i2c_client *client, u8 reg)
> +{
> +	return i2c_smbus_read_byte_data(client, reg);
> +}
> +
> +static int w83791d_write(struct i2c_client *client, u8 reg, u8 value)
> +{
> +	return i2c_smbus_write_byte_data(client, reg, value);
> +}

Please inline these.
http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h
0ab7fe4c009c40dc485731f9ad98e1d336ddae

> +	temp2_cfg =3D w83791d_read(client, W83791D_REG_TEMP2_CONFIG);
> +	temp3_cfg =3D w83791d_read(client, W83791D_REG_TEMP3_CONFIG);
> +	w83791d_write(client, W83791D_REG_TEMP2_CONFIG, temp2_cfg & 0xe6);
> +	w83791d_write(client, W83791D_REG_TEMP3_CONFIG, temp3_cfg & 0xe6);

What are these doing? This needs a comment. Also note that you could do
with a single temporary variable (or even without one.)

> +	if (time_after(jiffies, data->last_updated + (HZ * 3))
> +			|| time_before(jiffies, data->last_updated)
> +			|| !data->valid) {

The time_before() check isn't needed. time_after() takes care of the
jiffies count wrapping on its own. Looks like the w83792d driver is
broken in that respect, a patch would be welcome. See the lm90 driver
for the proper way.

> +	dev_dbg(dev, "beep_enable is: 0x%08x\n", data->beep_enable);

0x%08x to display an u8?

> +	dev_dbg(dev, "vid is: 0x%04x\n", data->vid);
> +	dev_dbg(dev, "vrm is: 0x%04x\n", data->vrm);

These are u8 too.

> +}
> +
> +#endif

No blank line here please.

> +MODULE_AUTHOR("Charles Spirakis<bezaur at gmail.com>");

Add a space between your name and the address.

> +MODULE_DESCRIPTION("W83791D driver for linux-2.6");

The "for linux-2.6" is a bit redundant ;)

OK, that's it. Please fix the issues I mentioned (or explain why you
won't if you don't agree with my comments.) Then resubmit the driver,
and I should accept it and get it merged. Thanks for the good work!

Other things which need to be done about this driver:

* Userspace part. Does libsensors handle this driver properly already?

* Linux 2.4. For now the W83791D chip is handled by the w83781d driver.
This might be a bit confusing to the user that we have a dedicated
driver in 2.6 and not in 2.4. OTOH I don't have the time to split
support to a separate driver myself. If anyone wants to do it, this is
welcome, but probably not required.

* sensors-detect needs to be updated, as for now it points the W83791D
owners to the w83781d driver regardless of the kernel version. Patch
anyone?

* The website needs to be updated to mention the new driver. I'll take
care of that.

Thanks again,
--=20
Jean Delvare

