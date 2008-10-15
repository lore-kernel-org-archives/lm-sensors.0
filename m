From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 15 Oct 2008 08:22:47 +0000
Subject: Re: [lm-sensors] [RFC v2] [PATCH] hwmon: Add LTC4245 driver
Message-Id: <48F5A857.6090204@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081014224325.GC27799@ovro.caltech.edu>
In-Reply-To: <20081014224325.GC27799@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Ira Snyder wrote:
> Add Linux support for the Linear Technology LTC4245 Multiple Supply Hot
> Swap controller I2C monitoring interface.
>=20
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
>=20
> I've incorporated the suggestions from my first posting of this driver.
>=20
> I decided to add current and power readings for the Vee (-12v) voltage,
> as well as the 12v, 5v, and 3v mentioned in the suggestions. This seemed
> reasonable to me.
>=20

Good.

> I'd appreciate any more suggestions you may have. :)
>=20

See below :)

<snip>

> +power1_input		12v power usage (mW)
> +power2_input		5v  power usage (mW)
> +power3_input		3v  power usage (mW)
> +power4_input		Vee (-12v) power usage (mW)
> +

These should be in micro Watt so =CE=BCW not mW, I know this is not consist=
entent=20
with all other input's being in milli something, but the first piece of=20
supported power measuring hardware we had has sub milliWatt precision, henc=
e=20
this decision.

<snip>

 > +power1_alarm		12v power bad alarm
 > +power2_alarm		5v  power bad alarm
 > +power3_alarm		3v  power bad alarm
 > +power4_alarm		Vee (-12v) power bad alarm

Ah I missed these the first time, looking at the data sheet these are actua=
lly=20
the output voltages going under a specified treshold. So please rename thes=
e to=20
in5_min_alarm to in8_min_alarm

<snip>

> +/* Return the voltage from the given register in millivolts */
> +static u32 ltc4245_get_voltage(struct device *dev, u8 reg)
> +{
> +	struct ltc4245_data *data =3D ltc4245_update_device(dev);
> +	const s32 val =3D data->vregs[reg - 0x10];
> +	const u8 regval =3D val;
> +	u32 mv =3D 0;
> +
> +	if (unlikely(val < 0))
> +		return 0;
> +
> +	switch (reg) {
> +	case LTC4245_12VIN:
> +	case LTC4245_12VOUT:
> +		mv =3D regval * 55;
> +		break;
> +	case LTC4245_12VSENSE:
> +		mv =3D regval * 250 / 1000;

You are loosing precision here, regval needs to change 4 steps for mv to ch=
ange=20
one. I think it is better todo the current calculation in one step in=20
get_current() with a comment which contains the multi step floanting point =

human readable form. In any case you must change things so that this precis=
ion=20
no longer gets lost.

> +		break;
> +	case LTC4245_5VIN:
> +	case LTC4245_5VOUT:
> +		mv =3D regval * 22;
> +		break;
> +	case LTC4245_5VSENSE:
> +		mv =3D regval * 125 / 1000;
> +		break;

Idem.

> +	case LTC4245_3VIN:
> +	case LTC4245_3VOUT:
> +		mv =3D regval * 15;
> +		break;
> +	case LTC4245_3VSENSE:
> +		mv =3D regval * 125 / 1000;
> +		break;

Idem.

> +	case LTC4245_VEEIN:
> +	case LTC4245_VEEOUT:
> +		mv =3D regval * 55;
> +		break;
> +	case LTC4245_VEESENSE:
> +		mv =3D regval * 250 / 1000;
> +		break;

Guess what? Idem :)

> +	case LTC4245_GPIOADC1:
> +	case LTC4245_GPIOADC2:
> +	case LTC4245_GPIOADC3:
> +		mv =3D regval * 10;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
> +
> +	return mv;
> +}
> +
> +/* Return the current in the given sense register in milliAmperes */
> +static u32 ltc4245_get_current(struct device *dev, u8 reg)
> +{
> +	const u32 voltage =3D ltc4245_get_voltage(dev, reg);
> +
> +	switch (reg) {
> +	case LTC4245_12VSENSE:
> +		return voltage / 50;

This returns the Amperage in Amperes not in milli Amperes. milli Volt divid=
ed=20
by milli Ohm gives Ampere not milli Ampere. So the correct calculation woul=
d be:

 > +		return voltage * 1000 / 50;

At which point the resolution loss described above becomes very relevant!

> +	case LTC4245_5VSENSE:
> +		/* Fixed point math: mV / 3.5 mOhm =3D mA */
> +		return (voltage * 35 + 5) / 10;
> +	case LTC4245_3VSENSE:
> +		/* Fixed point math: mV / 2.5 mOhm =3D mA */
> +		return (voltage * 25 + 5) / 10;
> +	case LTC4245_VEESENSE:
> +		return voltage / 100;

All 3 idem. Also why don't you add + 25 resp. + 50 for correct rounding in =
the=20
+/- 12V cases?

> +static ssize_t ltc4245_show_voltage_alarm(struct device *dev,
> +					  struct device_attribute *da,
> +					  char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> +	struct ltc4245_data *data =3D ltc4245_update_device(dev);
> +	const s32 fault1 =3D data->cregs[LTC4245_FAULT1];
> +	int alarm =3D 0;
> +
> +	if (unlikely(fault1 < 0)) {
> +		memset(buf, 0, PAGE_SIZE); /* user should not see old data */
> +		return 0;
> +	}
> +
> +	switch (attr->index) {
> +	case LTC4245_12VIN:
> +		alarm =3D fault1 & (1 << 0);
> +		break;
> +	case LTC4245_5VIN:
> +		alarm =3D fault1 & (1 << 1);
> +		break;
> +	case LTC4245_3VIN:
> +		alarm =3D fault1 & (1 << 2);
> +		break;
> +	case LTC4245_VEEIN:
> +		alarm =3D fault1 & (1 << 3);
> +		break;

Why don't you just set attr->index to to the mask to test with, or the amou=
nt=20
to shift the 1 and then get rid of this switch case?

> +	default:
> +		/* If we get here, the developer messed up */
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", alarm ? 1 : 0);
> +}
> +
> +static ssize_t ltc4245_show_current_alarm(struct device *dev,
> +					  struct device_attribute *da,
> +					  char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> +	struct ltc4245_data *data =3D ltc4245_update_device(dev);
> +	const s32 fault1 =3D data->cregs[LTC4245_FAULT1];
> +	int alarm =3D 0;
> +
> +	if (unlikely(fault1 < 0)) {
> +		memset(buf, 0, PAGE_SIZE); /* user should not see old data */
> +		return 0;
> +	}
> +
> +	switch (attr->index) {
> +	case LTC4245_12VSENSE:
> +		alarm =3D fault1 & (1 << 4);
> +		break;
> +	case LTC4245_5VSENSE:
> +		alarm =3D fault1 & (1 << 5);
> +		break;
> +	case LTC4245_3VSENSE:
> +		alarm =3D fault1 & (1 << 6);
> +		break;
> +	case LTC4245_VEESENSE:
> +		alarm =3D fault1 & (1 << 7);
> +		break;
> +	default:
> +		/* If we get here, the developer messed up */
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
> +

Idem, note that this function is and most certainly becomes identical to
ltc4245_show_voltage_alarm, so please fold the 2 into 1.

> +	return snprintf(buf, PAGE_SIZE, "%d\n", alarm ? 1 : 0);
> +}
> +
> +static ssize_t ltc4245_show_power_alarm(struct device *dev,
> +					struct device_attribute *da,
> +					char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> +	struct ltc4245_data *data =3D ltc4245_update_device(dev);
> +	const s32 fault2 =3D data->cregs[LTC4245_FAULT2];
> +	int alarm =3D 0;
> +
> +	if (unlikely(fault2 < 0)) {
> +		memset(buf, 0, PAGE_SIZE); /* user should not see old data */
> +		return 0;
> +	}
> +
> +	switch (attr->index) {
> +	case LTC4245_12VOUT:
> +		alarm =3D fault2 & (1 << 0);
> +		break;
> +	case LTC4245_5VOUT:
> +		alarm =3D fault2 & (1 << 1);
> +		break;
> +	case LTC4245_3VOUT:
> +		alarm =3D fault2 & (1 << 2);
> +		break;
> +	case LTC4245_VEEOUT:
> +		alarm =3D fault2 & (1 << 3);
> +		break;

Idem, see below for some more comments about folding all 3 alarm functions =
into 1.

> +	default:
> +		/* If we get here, the developer messed up */
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", alarm ? 1 : 0);
> +}
> +
> +/* These macros are used below in constructing device attribute objects
> + * for use with sysfs_create_group() to make a sysfs device file
> + * for each register.
> + */
> +#define LTC4245_VOLTAGE_RO(name, ltc4245_cmd_idx) \
> +	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
> +	ltc4245_show_voltage, NULL, ltc4245_cmd_idx)
> +

Please combine this with LTC4245_VOLTAGE_ALARM into one LTC4245_VOLTAGE
define. Just pass in for example in1 as name and use string concatenation t=
o=20
get the in1_input and in1_min_alarm names, like this: "name ## _input" and =

"name ## _min_alarm" .

Also use a third macro argument for the index value for the alarm=20
SENSOR_DEVICE_ATTR() so that you can directly pass in the shift value / mas=
k=20
for getting the alarm. Hmm, once you add the in4_min_alarm -> in8_min_alarm=
,=20
you need to pass 2 things, which fault register to use and which mask to ap=
ply,=20
better switch to SENSOR_DEVICE_ATTR2 then, which allows you to pass both an=
=20
index and a nr.

> +#define LTC4245_CURRENT_RO(name, ltc4245_cmd_idx) \
> +	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
> +	ltc4245_show_current, NULL, ltc4245_cmd_idx)
> +

Idem combine with LTC4245_CURRENT_ALARM please.

> +#define LTC4245_POWER_RO(name, ltc4245_cmd_idx) \
> +	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
> +	ltc4245_show_power, NULL, ltc4245_cmd_idx)
> +

> +#define LTC4245_VOLTAGE_ALARM(name, ltc4245_cmd_idx) \
> +	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
> +	ltc4245_show_voltage_alarm, NULL, ltc4245_cmd_idx)
> +
> +#define LTC4245_CURRENT_ALARM(name, ltc4245_cmd_idx) \
> +	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
> +	ltc4245_show_current_alarm, NULL, ltc4245_cmd_idx)
> +
> +#define LTC4245_POWER_ALARM(name, ltc4245_cmd_idx) \
> +	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
> +	ltc4245_show_power_alarm, NULL, ltc4245_cmd_idx)
> +

These 3 should be removed then.

<snip>

Well still some work to do, but we are definitely getting there. I think th=
e=20
3th revision will be "perfect".

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
