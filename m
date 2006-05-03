From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 03 May 2006 19:43:09 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND] hwmon: new vt1211 driver
Message-Id: <445907CD.7040305@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0604062128m60ba1c53gbcab205aa6f40c0c@mail.gmail.com>
In-Reply-To: <191fb4ca0604062128m60ba1c53gbcab205aa6f40c0c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again,

This is the first time after a week or so I have relatively free evening...
I'm sorry for the delay, but again, too much stuff around here lately.

I was speaking with Jean to become a co-maintainer so I could accept the patches 
too, but I'm bit worried if I know enough to do that...

Please check my comments. Generally the -1 stuff should be fixed, the ----
lines should be a bit shorter and ARRAY_SIZE macro can be used. And alarm
stuff should use the mapping arrrays...

I'm not sure if I like the "combo" callbacks, but I'm not strictly aginst it.

Regards
Rudolf

> +/* -------------------------------------------------------------------------

Hmm as Jim already mentioned I dont know if Jean will like it. On the other hand 
this line is on many places in kernel, but bit shorter, like this:

/*-------------------------------------------------------------------------*/

> + * Registers
> + *
> + * The sensors are defined as follows. Temp3 and temp1 are swapped to match
> + * the VT1211 driver for kernel 2.4.
> + *
> + * Sensor          Voltage Mode   Temp Mode   Notes (from the datasheet)
> + * --------        ------------   ---------   --------------------------
> + * Reading 1                      temp3       Intel thermal diode
> + * Reading 3                      temp1       internal thermal diode
> + * UCH1/Reading2   in0            temp2       NTC type thermistor
> + * UCH2            in1            temp4       +2.5V
> + * UCH3            in2            temp5       VccP
> + * UCH4            in3            temp6       +5V
> + * UCH5            in4            temp7       +12V
> + * 3.3V            in5                        internal VDD (+3.3V)
> + * -12V            in6                        reserved
> + *
> + * ------------------------------------------------------------------------- */
> +
> +/* Voltages (in) numbered 0-6 (ix) */
> +#define VT1211_REG_IN(ix)		(0x21 + (ix))
> +#define VT1211_REG_IN_MIN(ix)		((ix) = 0 ? 0x3e : 0x2a + 2 * (ix))
> +#define VT1211_REG_IN_MAX(ix)		((ix) = 0 ? 0x3d : 0x29 + 2 * (ix))
> +
> +static const u8 regtemp[]     = {0x20, 0x21, 0x1f, 0x22, 0x23, 0x24, 0x25};

This may have a tab maybe...

> +static const u8 regtempmax[]  = {0x1d, 0x3d, 0x39, 0x2b, 0x2d, 0x2f, 0x31};
> +static const u8 regtemphyst[] = {0x1e, 0x3e, 0x3a, 0x2c, 0x2e, 0x30, 0x32};
> +
> +/* Temperatures (temp) numbered 1-7 (ix) */
> +#define VT1211_REG_TEMP(ix)		(regtemp[(ix) - 1])
> +#define VT1211_REG_TEMP_MAX(ix)		(regtempmax[(ix) - 1])
> +#define VT1211_REG_TEMP_HYST(ix)	(regtemphyst[(ix) - 1])
> +
> +/* Fans numbered 1-2 (ix) */
> +#define VT1211_REG_FAN(ix)		(0x28 + (ix))
> +#define VT1211_REG_FAN_MIN(ix)		(0x3a + (ix))
> +#define VT1211_REG_FAN_DIV	 	 0x47
> +
> +/* PWMs numbered 1-2 (ix) */
> +/* Auto points numbered 1-4 (ap) */
> +#define VT1211_REG_PWM(ix)		(0x5f + (ix))
> +#define VT1211_REG_PWM_CLK		 0x50
> +#define VT1211_REG_PWM_CTL		 0x51
> +#define VT1211_REG_PWM_AUTO_TEMP(ix)	(0x51 + (ix))
> +#define VT1211_REG_PWM_AUTO_PWM(ix, ap)	(0x52 + 2 * (ix) + ap)
> +
> +/* Miscellaneous registers */
> +#define VT1211_REG_CONFIG		0x40
> +#define VT1211_REG_ALARM1		0x41
> +#define VT1211_REG_ALARM2		0x42
> +#define VT1211_REG_VID			0x45
> +#define VT1211_REG_UCH_CONFIG		0x4a
> +#define VT1211_REG_TEMP1_CONFIG		0x4b
> +#define VT1211_REG_TEMP2_CONFIG		0x4c
> +
> +/* -------------------------------------------------------------------------
> + * Data structures and manipulation thereof
> + * ------------------------------------------------------------------------- */
> +
> +struct vt1211_data {
> +	unsigned short addr;
> +	const char *name;
> +	struct mutex lock;
> +	struct class_device *class_dev;
> +
> +	struct mutex update_lock;
> +	char valid;			/* !=0 if following fields are valid */
> +	unsigned long last_updated;	/* In jiffies */
> +
> +	/* Register values */
> +	u8  in[7];
> +	u8  in_max[7];
> +	u8  in_min[7];
> +	u8  temp[7];
> +	u8  temp_max[7];
> +	u8  temp_hyst[7];
> +	u8  fan[2];
> +	u8  fan_min[2];
> +	u8  fan_div[2];
> +	u8  fan_ctl;
> +	u8  pwm[2];
> +	u8  pwm_ctl[2];
> +	u8  pwm_clk;
> +	u8  pwm_auto_temp[4];
> +	u8  pwm_auto_pwm[2][4];
> +	u8  vid;		/* Read once at init time */
> +	u8  vrm;
> +	u8  uch_config;		/* Read once at init time */
> +	u16 alarms;
> +};
> +
> +/* ix = [0-6] */
> +#define ISVOLT(ix, uch_config)	((ix) > 4 ? 1 : \
> +				 !(((uch_config) >> ((ix) + 2)) & 1))
> +
> +/* ix = [1-7] */
> +#define ISTEMP(ix, uch_config)	((ix) = 1 ? 1 : \
> +				 (ix) = 3 ? 1 : \
> +				 (ix) = 2 ? ((uch_config) >> 2) & 1 : \
> +				 ((uch_config) >> ((ix) - 1)) & 1)
> +
> +/* in5 is special. It's the internal 3.3V so it's scaled in the driver
> +   according to the VT1211 BIOS porting guide */
> +#define IN_FROM_REG(ix, val)	((val) < 3 ? 0 : (ix) = 5 ? \
> +				 ((val) - 3) * 15882 / 958 : \
> +				 ((val) - 3) * 10000 / 958)
> +#define IN_TO_REG(ix, val)	((ix) = 5 ? \
> +			   	 SENSORS_LIMIT((((val) * 958 / 15882) + 3), \
> +					0, 255) : \
> +			   	 SENSORS_LIMIT((((val) * 958 / 10000) + 3), \
> +				   	0, 255))
> +
> +/* temp1 is special. It's the internal temp diode so it's scaled in the driver
> +   according to some real life measurements that I took on my EPIA M10000 */
> +#define TEMP_FROM_REG(ix, val)	((ix) = 1 ? \
> +				 (val) < 51 ? 0 : ((val) - 51) * 1000 : \
> +				 (val) * 1000)
> +#define TEMP_TO_REG(ix, val)	((ix) = 1 ? \
> +				 SENSORS_LIMIT((((val) / 1000) + 51), \
> +				 	0, 255) : \
> +				 SENSORS_LIMIT(((val) / 1000), 0, 255))
> +
> +#define DIV_FROM_REG(val) 	(1 << (val))
> +#define DIV_TO_REG(val)   	((val) = 8 ? 3 : \
> +			   	 (val) = 4 ? 2 : \
> +			   	 (val) = 1 ? 0 : 1)
> +
> +#define PWM_FROM_REG(val) 	(val)
> +#define PWM_TO_REG(val)   	SENSORS_LIMIT((val), 0, 255)
> +
> +#define RPM_FROM_REG(val, div)	((val) <= 0   ? 0 : \
> +				 (val) >= 255 ? 0 : \
> +				 1310720 / (val) / DIV_FROM_REG(div))
> +#define RPM_TO_REG(rpm, div)	((rpm) = 0 ? 0 : \
> +				 SENSORS_LIMIT((1310720 / (rpm) / \
> +				 	DIV_FROM_REG(div)), 1, 255))
> +
> +/* -------------------------------------------------------------------------
> + * Super-I/O constants and functions
> + * ------------------------------------------------------------------------- */
> +
> +/* Configuration & data index port registers */
> +#define SIO_REG_CIP		0x2e
> +#define SIO_REG_DIP		0x2f
> +
> +/* Configuration registers */
> +#define SIO_VT1211_LDN		0x07	/* logical device number */
> +#define SIO_VT1211_DEVID	0x20	/* device ID */
> +#define SIO_VT1211_DEVREV	0x21	/* device revision */
> +#define SIO_VT1211_BADDR	0x60	/* base I/O address */
> +#define SIO_VT1211_BADDR_MASK	0xff80
> +
> +#define SIO_VT1211_ID		0x3c	/* VT1211 device ID */
> +
> +/* VT1211 logical device numbers */
> +#define SIO_VT1211_LDN_HWMON	0x0b	/* HW monitor */
> +
> +static inline void superio_outb(int reg, int val)
> +{
> +	outb(reg, SIO_REG_CIP);
> +	outb(val, SIO_REG_DIP);
> +}
> +
> +static inline int superio_inb(int reg)
> +{
> +	outb(reg, SIO_REG_CIP);
> +	return inb(SIO_REG_DIP);
> +}
> +
> +static inline void superio_select(int ldn)
> +{
> +	outb(SIO_VT1211_LDN, SIO_REG_CIP);
> +	outb(ldn, SIO_REG_DIP);
> +}
> +
> +static inline void superio_enter(void)
> +{
> +	outb(0x87, SIO_REG_CIP);
> +	outb(0x87, SIO_REG_CIP);
> +}
> +
> +static inline void superio_exit(void)
> +{
> +	outb(0xaa, SIO_REG_CIP);
> +}
> +
> +/* -------------------------------------------------------------------------
> + * Device I/O access
> + * ------------------------------------------------------------------------- */
> +
> +static u8 vt1211_read8(struct vt1211_data *data, u8 reg)
> +{
> +	return inb(data->addr + reg);
> +}
> +
> +static void vt1211_write8(struct vt1211_data *data, u8 reg, u8 val)
> +{
> +	outb(val, data->addr + reg);
> +}
> +
> +static struct vt1211_data *vt1211_update_device(struct device *dev)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	int ix, val;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	/* registers cache is refreshed after 1 second */
> +	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
> +
> +		/* voltage (in) registers */
> +		for (ix = 0; ix <= 6; ix++) {

The ARRAY_SIZE idea sounds good to me too.

> +			if (ISVOLT(ix, data->uch_config)) {
> +				data->in[ix] = vt1211_read8(data,
> +						VT1211_REG_IN(ix));
> +				data->in_min[ix] = vt1211_read8(data,
> +						VT1211_REG_IN_MIN(ix));
> +				data->in_max[ix] = vt1211_read8(data,
> +						VT1211_REG_IN_MAX(ix));
> +			} else {
> +				data->in[ix] = 0;
> +				data->in_min[ix] = 0;
> +				data->in_max[ix] = 0;
> +			}
> +		}
> +
> +		/* temp registers */
> +		for (ix = 1; ix <= 7; ix++) {

And Jims proposal for the "get rid of -1" is a good one too. And of course on 
other places too.

> +			if (ISTEMP(ix, data->uch_config)) {
> +				data->temp[ix-1] = vt1211_read8(data,
> +						VT1211_REG_TEMP(ix));
> +				data->temp_max[ix-1] = vt1211_read8(data,
> +						VT1211_REG_TEMP_MAX(ix));
> +				data->temp_hyst[ix-1] = vt1211_read8(data,
> +						VT1211_REG_TEMP_HYST(ix));
> +			} else {
> +				data->temp[ix-1] = 0;
> +				data->temp_max[ix-1] = 0;
> +				data->temp_hyst[ix-1] = 0;
> +			}
> +		}
> +
> +		/* fan & pwm registers */
> +		for (ix = 1; ix <= 2; ix++) {
> +			data->fan[ix-1] = vt1211_read8(data,
> +						VT1211_REG_FAN(ix));
> +			data->fan_min[ix-1] = vt1211_read8(data,
> +						VT1211_REG_FAN_MIN(ix));
> +			data->pwm[ix-1] = vt1211_read8(data,
> +						VT1211_REG_PWM(ix));
> +		}
> +		val = vt1211_read8(data, VT1211_REG_FAN_DIV);
> +		data->fan_div[0] = (val >> 4) & 3;
> +		data->fan_div[1] = (val >> 6) & 3;
> +		data->fan_ctl = val & 0xf;
> +
> +		val = vt1211_read8(data, VT1211_REG_PWM_CTL);
> +		data->pwm_ctl[0] = val & 0xf;
> +		data->pwm_ctl[1] = (val >> 4) & 0xf;
> +
> +		data->pwm_clk = vt1211_read8(data, VT1211_REG_PWM_CLK);
> +
> +		/* pwm & temp auto point registers */
> +		data->pwm_auto_pwm[0][0] = 255;	/* hard wired */
> +		data->pwm_auto_pwm[0][1] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_PWM(1, 2));
> +		data->pwm_auto_pwm[0][2] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_PWM(1, 3));
> +		data->pwm_auto_pwm[0][3] = 0;	/* hard wired */
> +		data->pwm_auto_pwm[1][0] = 255;	/* hard wired */
> +		data->pwm_auto_pwm[1][1] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_PWM(2, 2));
> +		data->pwm_auto_pwm[1][2] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_PWM(2, 3));
> +		data->pwm_auto_pwm[1][3] = 0;	/* hard wired */
> +		for (ix = 1; ix <= 4; ix++) {
> +			data->pwm_auto_temp[ix-1] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_TEMP(ix));
> +		}
> +
> +		/* alarm registers */
> +		data->alarms = (vt1211_read8(data, VT1211_REG_ALARM1) |
> +				(vt1211_read8(data, VT1211_REG_ALARM2) << 8));
> +
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +
> +/* -------------------------------------------------------------------------
> + * Voltage sysfs interfaces
> + * ix = [0-6]
> + * ------------------------------------------------------------------------- */
> +
> +#define SHOW_IN_INPUT	0
> +#define SHOW_SET_IN_MIN	1
> +#define SHOW_SET_IN_MAX	2
> +#define SHOW_IN_ALARM	3
> +
> +static ssize_t show_in(struct device *dev, struct device_attribute *attr,
> +		       char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int nr = sensor_attr_2->nr;
> +	switch (nr) {
> +	case SHOW_SET_IN_MIN:
> +		return sprintf(buf, "%d\n", IN_FROM_REG(ix, data->in_min[ix]));
> +	case SHOW_SET_IN_MAX:
> +		return sprintf(buf, "%d\n", IN_FROM_REG(ix, data->in_max[ix]));
> +	case SHOW_IN_ALARM:
> +		return sprintf(buf, "%d\n", ISVOLT(ix, data->uch_config) &
> +			       (ix = 0 ? data->alarms >> 11 :
> +				ix = 1 ? data->alarms >>  0 :
> +				ix = 2 ? data->alarms >>  1 :
> +				ix = 3 ? data->alarms >>  3 :
> +				ix = 4 ? data->alarms >>  8 :
> +				ix = 5 ? data->alarms >>  2 :
> +				data->alarms >>  9) & 1);
> +	default:
> +		return sprintf(buf, "%d\n", IN_FROM_REG(ix, data->in[ix]));
> +	}
> +}
> +
> +static ssize_t set_in(struct device *dev, struct device_attribute *attr,
> +		      const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int nr = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +	mutex_lock(&data->update_lock);
> +	switch (nr) {
> +	case SHOW_SET_IN_MIN:
> +		data->in_min[ix] = IN_TO_REG(ix, val);
> +		vt1211_write8(data, VT1211_REG_IN_MIN(ix), data->in_min[ix]);
> +		break;
> +	case SHOW_SET_IN_MAX:
> +		data->in_max[ix] = IN_TO_REG(ix, val);
> +		vt1211_write8(data, VT1211_REG_IN_MAX(ix), data->in_max[ix]);
> +		break;
> +	}
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/* -------------------------------------------------------------------------
> + * Temperature sysfs interfaces
> + * ix = [1-7]
> + * ------------------------------------------------------------------------- */
> +
> +#define SHOW_TEMP_INPUT		0
> +#define SHOW_SET_TEMP_MAX	1
> +#define SHOW_SET_TEMP_MAX_HYST	2
> +#define SHOW_TEMP_ALARM		3

Jim wrote that he likes the idea, well I'm myself still not convinced.

The classic 2D array grouping is more elegant in term of function, but bit 
strange on the hand of array mapping/dimension.

This case is vice-versa data structures are nice function is bit more 
complicated. I'm not telling you to remove it, but please at least change
the default case to error and nr to some better name.

> +static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int nr = sensor_attr_2->nr;
> +	switch (nr) {

The variable name nr lost the meaning maybe something like fn?

> +	case SHOW_SET_TEMP_MAX:
> +		return sprintf(buf, "%d\n",
> +			       TEMP_FROM_REG(ix, data->temp_max[ix-1]));
> +	case SHOW_SET_TEMP_MAX_HYST:
> +		return sprintf(buf, "%d\n",
> +			       TEMP_FROM_REG(ix, data->temp_hyst[ix-1]));
> +	case SHOW_TEMP_ALARM:
> +		return sprintf(buf, "%d\n", ISTEMP(ix, data->uch_config) &
> +			       (ix = 1 ? data->alarms >> 15 :
> +				ix = 2 ? data->alarms >> 11 :
> +				ix = 3 ? data->alarms >>  4 :
> +				ix = 4 ? data->alarms >>  0 :
> +				ix = 5 ? data->alarms >>  1 :
> +				ix = 6 ? data->alarms >>  3 :
> +				data->alarms >>  8) & 1);

I'm definetely for a static lookup table and perhaps on other places too.

> +	default:

Perhaps the default should be an error?

> +		return sprintf(buf, "%d\n",
> +			       TEMP_FROM_REG(ix, data->temp[ix-1]));
> +	}
> +}
> +
> +static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int nr = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +	mutex_lock(&data->update_lock);
> +	switch (nr) {
> +	case SHOW_SET_TEMP_MAX:
> +		data->temp_max[ix-1] = TEMP_TO_REG(ix, val);
> +		vt1211_write8(data, VT1211_REG_TEMP_MAX(ix),
> +			      data->temp_max[ix-1]);
> +		break;
> +	case SHOW_SET_TEMP_MAX_HYST:
> +		data->temp_hyst[ix-1] = TEMP_TO_REG(ix, val);
> +		vt1211_write8(data, VT1211_REG_TEMP_HYST(ix),
> +			      data->temp_hyst[ix-1]);
> +		break;
> +	}
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/* -------------------------------------------------------------------------
> + * Fan sysfs interfaces
> + * ix = [1-2]
> + *  ------------------------------------------------------------------------ */
> +
> +#define SHOW_FAN_INPUT		0
> +#define SHOW_SET_FAN_MIN	1
> +#define SHOW_SET_FAN_DIV	2
> +#define SHOW_FAN_ALARM		3
> +
> +static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int nr = sensor_attr_2->nr;
> +	switch (nr) {
> +	case SHOW_SET_FAN_MIN:
> +		return sprintf(buf, "%d\n", RPM_FROM_REG(data->fan_min[ix-1],
> +			       data->fan_div[ix-1]));
> +	case SHOW_SET_FAN_DIV:
> +		return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[ix-1]));
> +	case SHOW_FAN_ALARM:
> +		return sprintf(buf, "%d\n", (data->alarms >> (ix + 5)) & 1);
> +	default:
> +		return sprintf(buf, "%d\n", RPM_FROM_REG(data->fan[ix-1],
> +			       data->fan_div[ix-1]));
> +	}
> +}
> +
> +static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int nr = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +	mutex_lock(&data->update_lock);
> +	switch (nr) {
> +	case SHOW_SET_FAN_MIN:
> +		data->fan_min[ix-1] = RPM_TO_REG(val, data->fan_div[ix-1]);
> +		vt1211_write8(data, VT1211_REG_FAN_MIN(ix),
> +			      data->fan_min[ix-1]);
> +		break;
> +	case SHOW_SET_FAN_DIV:
> +		data->fan_div[ix-1] = DIV_TO_REG(val);
> +		vt1211_write8(data, VT1211_REG_FAN_DIV,
> +			      ((data->fan_div[1] << 6) |
> +			       (data->fan_div[0] << 4) |
> +				data->fan_ctl));
> +		break;
> +	}
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/* -------------------------------------------------------------------------
> + * PWM sysfs interfaces
> + * ix = [1-2]
> + * ------------------------------------------------------------------------- */
> +
> +#define SHOW_PWM			0
> +#define SHOW_SET_PWM_ENABLE		1
> +#define SHOW_SET_PWM_FREQUENCY		2
> +#define SHOW_SET_PWM_AUTO_CHANNELS_TEMP	3
> +
> +static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int en, sg, tmp;
> +	int ix = sensor_attr_2->index;
> +	int nr = sensor_attr_2->nr;
> +	switch (nr) {
> +	case SHOW_SET_PWM_ENABLE:
> +		en = data->pwm_ctl[ix-1] >> 3;
> +		sg = data->fan_ctl & 1;
> +		return sprintf(buf, "%d\n", (en && sg) ? 2 : en ? 1 : 0);
> +	case SHOW_SET_PWM_FREQUENCY:
> +		tmp = data->pwm_clk & 7;
> +		return sprintf(buf, "%d\n",
> +			       (tmp = 1 ? 45000 : tmp = 2 ? 22500 :
> +				tmp = 3 ? 11250 : tmp = 4 ?  5630 :
> +				tmp = 5 ?  2800 : tmp = 6 ?  1400 :
> +				tmp = 7 ?   700 : 90000));
> +	case SHOW_SET_PWM_AUTO_CHANNELS_TEMP:
> +		tmp = data->pwm_ctl[ix-1] & 7;
> +		return sprintf(buf, "%d\n", (tmp = 1 ? 3 : tmp = 2 ? 2 :
> +					     tmp = 7 ? 1 : tmp + 1));
> +	default:
> +		return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[ix-1]));
> +	}
> +}
> +
> +static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int tmp;
> +	int ix = sensor_attr_2->index;
> +	int nr = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +	mutex_lock(&data->update_lock);
> +	switch (nr) {
> +	case SHOW_SET_PWM_ENABLE:
> +		/* fan[1-2] out enable bits */
> +		if (val) {
> +			data->pwm_ctl[ix-1] |= 8;
> +		} else {
> +			data->pwm_ctl[ix-1] &= 7;
> +		}
> +		/* SmartGuardian controller enable bit */
> +		if (val > 1) {
> +			data->fan_ctl |= 1;
> +		} else {
> +			data->fan_ctl &= 0xe;
> +		}
> +		vt1211_write8(data, VT1211_REG_PWM_CTL,
> +			      ((data->pwm_ctl[1] << 4) |
> +				data->pwm_ctl[0]));
> +		vt1211_write8(data, VT1211_REG_FAN_DIV,
> +			      ((data->fan_div[1] << 6) |
> +			       (data->fan_div[0] << 4) |
> +				data->fan_ctl));
> +		break;
> +	case SHOW_SET_PWM_FREQUENCY:
> +		tmp = (val = 45000 ? 1 : val = 22500 ? 2 : 
> +		       val = 11250 ? 3 : val =  5630 ? 4 :
> +		       val =  2800 ? 5 : val =  1400 ? 6 :
> +		       val =   700 ? 7 : 0);
> +		data->pwm_clk = (data->pwm_clk & 0xf8) | tmp;
> +		vt1211_write8(data, VT1211_REG_PWM_CLK, data->pwm_clk);
> +		break;
> +	case SHOW_SET_PWM_AUTO_CHANNELS_TEMP:
> +		tmp = (val = 3 ? 1 : val = 2 ? 2 : val > 7 ? 1 : val - 1);
> +		data->pwm_ctl[ix-1] = (data->pwm[ix-1] & 8) | tmp;
> +		vt1211_write8(data, VT1211_REG_PWM_CTL,
> +			      ((data->pwm_ctl[1] << 4) | data->pwm_ctl[0]));
> +		break;
> +	}
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/* -------------------------------------------------------------------------
> + * PWM auto point definitions
> + * ix = [1-2]
> + * ap = [1-4]
> + * ------------------------------------------------------------------------- */
> +
> +/*
> + * pwm[ix]_auto_point[ap]_temp mapping table:
> + * Note that there is only a single set of temp auto points that controls both
> + * PWM controllers. We still create 2 sets of sysfs entries to make it look
> + * more consistent even though they map to the same registers.
> + *
> + * ix ap : description
> + * ------------------------------------------------------
> + * 1  1  : pwm1/pwm2 full speed temperature (pwm_auto_temp[0])
> + * 1  2  : pwm1/pwm2 high speed temperature (pwm_auto_temp[1])
> + * 1  3  : pwm1/pwm2 low speed temperature (pwm_auto_temp[2])
> + * 1  4  : pwm1/pwm2 off temperature (pwm_auto_temp[3])
> + * 2  1  : pwm1/pwm2 full speed temperature (pwm_auto_temp[0])
> + * 2  2  : pwm1/pwm2 high speed temperature (pwm_auto_temp[1])
> + * 2  3  : pwm1/pwm2 low speed temperature (pwm_auto_temp[2])
> + * 2  4  : pwm1/pwm2 off temperature (pwm_auto_temp[3])
> + */
> +
> +static ssize_t show_pwm_auto_point_temp(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int ap = sensor_attr_2->nr;
> +	int tmp = data->pwm_ctl[ix-1] & 7;
> +	return sprintf(buf, "%d\n",
> +		       TEMP_FROM_REG(tmp, data->pwm_auto_temp[ap-1]));
> +}
> +
> +static ssize_t set_pwm_auto_point_temp(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int ap = sensor_attr_2->nr;
> +	int tmp = data->pwm_ctl[ix-1] & 7;
> +	long val = simple_strtol(buf, NULL, 10);
> +	mutex_lock(&data->update_lock);
> +	data->pwm_auto_temp[ap-1] = TEMP_TO_REG(tmp, val);
> +	vt1211_write8(data, VT1211_REG_PWM_AUTO_TEMP(ap),
> +		      data->pwm_auto_temp[ap-1]);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/*
> + * pwm[ix]_auto_point[ap]_pwm mapping table:
> + * Note that the PWM auto points 1 & 4 are hard-wired in the vt1211 and can't
> + * be changed.
> + *
> + * ix ap : description
> + * ------------------------------------------------------
> + * 1  1  : pwm1 full speed duty cycle (pwm_auto_pwm[0][0], hard-wired to 255)
> + * 1  2  : pwm1 high speed duty cycle (pwm_auto_pwm[0][1])
> + * 1  3  : pwm1 low speed duty cycle (pwm_auto_pwm[0][2])
> + * 1  4  : pwm1 off (pwm_auto_pwm[0][3], hard-wired to 0)
> + * 2  1  : pwm2 full speed duty cycle (pwm_auto_pwm[1][0], hard-wired to 255)
> + * 2  2  : pwm2 high speed duty cycle (pwm_auto_pwm[1][1])
> + * 2  3  : pwm2 low speed duty cycle (pwm_auto_pwm[1][2])
> + * 2  4  : pwm2 off (pwm_auto_pwm[1][3], hard-wired to 0)
> +*/
> +
> +static ssize_t show_pwm_auto_point_pwm(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int ap = sensor_attr_2->nr;
> +	return sprintf(buf, "%d\n",
> +		       PWM_FROM_REG(data->pwm_auto_pwm[ix-1][ap-1]));
> +}
> +
> +static ssize_t set_pwm_auto_point_pwm(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int ap = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +	if (ap = 2 || ap = 3) {
> +		mutex_lock(&data->update_lock);
> +		data->pwm_auto_pwm[ix-1][ap-1] = PWM_TO_REG(val);
> +		vt1211_write8(data, VT1211_REG_PWM_AUTO_PWM(ix, ap),
> +			      data->pwm_auto_pwm[ix-1][ap-1]);
> +		mutex_unlock(&data->update_lock);
> +	}
> +	return count;
> +}
> +
> +/* -------------------------------------------------------------------------
> + * Miscellaneous sysfs interfaces (VRM, VID and name)
> + * ------------------------------------------------------------------------- */
> +
> +static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	return sprintf(buf, "%d\n", data->vrm);
> +}
> +
> +static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	long val = simple_strtol(buf, NULL, 10);
> +	data->vrm = val;
> +	return count;
> +}
> +
> +static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
> +}
> +
> +static ssize_t show_name(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	return sprintf(buf, "%s\n", data->name);
> +}
> +
> +/* -------------------------------------------------------------------------
> + * Device attribute structs
> + * ------------------------------------------------------------------------- */
> +
> +#define SENSOR_ATTR_IN(ix) \
> +	SENSOR_ATTR_2(in##ix##_input, S_IRUGO, \
> +		show_in, NULL, SHOW_IN_INPUT, ix), \
> +	SENSOR_ATTR_2(in##ix##_min, S_IRUGO | S_IWUSR, \
> +		show_in, set_in, SHOW_SET_IN_MIN, ix), \
> +	SENSOR_ATTR_2(in##ix##_max, S_IRUGO | S_IWUSR, \
> +		show_in, set_in, SHOW_SET_IN_MAX, ix), \
> +	SENSOR_ATTR_2(in##ix##_alarm, S_IRUGO, \
> +		show_in, NULL, SHOW_IN_ALARM, ix)
> +
> +#define SENSOR_ATTR_TEMP(ix) \
> +	SENSOR_ATTR_2(temp##ix##_input, S_IRUGO, \
> +		show_temp, NULL, SHOW_TEMP_INPUT, ix), \
> +	SENSOR_ATTR_2(temp##ix##_max, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, SHOW_SET_TEMP_MAX, ix), \
> +	SENSOR_ATTR_2(temp##ix##_max_hyst, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, SHOW_SET_TEMP_MAX_HYST, ix), \
> +	SENSOR_ATTR_2(temp##ix##_alarm, S_IRUGO, \
> +		show_temp, NULL, SHOW_TEMP_ALARM, ix)
> +
> +#define SENSOR_ATTR_FAN(ix) \
> +	SENSOR_ATTR_2(fan##ix##_input, S_IRUGO, \
> +		show_fan, NULL, SHOW_FAN_INPUT, ix), \
> +	SENSOR_ATTR_2(fan##ix##_min, S_IRUGO | S_IWUSR, \
> +		show_fan, set_fan, SHOW_SET_FAN_MIN, ix), \
> +	SENSOR_ATTR_2(fan##ix##_div, S_IRUGO | S_IWUSR, \
> +		show_fan, set_fan, SHOW_SET_FAN_DIV, ix), \
> +	SENSOR_ATTR_2(fan##ix##_alarm, S_IRUGO, \
> +		show_fan, NULL, SHOW_FAN_ALARM, ix)
> +
> +#define SENSOR_ATTR_PWM(ix) \
> +	SENSOR_ATTR_2(pwm##ix, S_IRUGO, \
> +		show_pwm, NULL, SHOW_PWM, ix), \
> +	SENSOR_ATTR_2(pwm##ix##_enable, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SHOW_SET_PWM_ENABLE, ix), \
> +	SENSOR_ATTR_2(pwm##ix##_frequency, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SHOW_SET_PWM_FREQUENCY, ix), \
> +	SENSOR_ATTR_2(pwm##ix##_auto_channels_temp, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SHOW_SET_PWM_AUTO_CHANNELS_TEMP, ix)
> +
> +#define SENSOR_ATTR_PWM_AUTO_POINT(ix, ap) \
> +	SENSOR_ATTR_2(pwm##ix##_auto_point##ap##_temp, \
> +		S_IRUGO | S_IWUSR, \
> +		show_pwm_auto_point_temp, set_pwm_auto_point_temp, ix, ap), \
> +	SENSOR_ATTR_2(pwm##ix##_auto_point##ap##_pwm, \
> +		S_IRUGO | S_IWUSR, \
> +		show_pwm_auto_point_pwm, set_pwm_auto_point_pwm, ix, ap)
> +
> +static struct sensor_device_attribute_2 vt1211_sensor_attr_2[] = {
> +	SENSOR_ATTR_IN(0),
> +	SENSOR_ATTR_IN(1),
> +	SENSOR_ATTR_IN(2),
> +	SENSOR_ATTR_IN(3),
> +	SENSOR_ATTR_IN(4),
> +	SENSOR_ATTR_IN(5),
> +	SENSOR_ATTR_IN(6),
> +	SENSOR_ATTR_TEMP(1),
> +	SENSOR_ATTR_TEMP(2),
> +	SENSOR_ATTR_TEMP(3),
> +	SENSOR_ATTR_TEMP(4),
> +	SENSOR_ATTR_TEMP(5),
> +	SENSOR_ATTR_TEMP(6),
> +	SENSOR_ATTR_TEMP(7),
> +	SENSOR_ATTR_FAN(1),
> +	SENSOR_ATTR_FAN(2),
> +	SENSOR_ATTR_PWM(1),
> +	SENSOR_ATTR_PWM(2),
> +	SENSOR_ATTR_PWM_AUTO_POINT(1, 1),
> +	SENSOR_ATTR_PWM_AUTO_POINT(1, 2),
> +	SENSOR_ATTR_PWM_AUTO_POINT(1, 3),
> +	SENSOR_ATTR_PWM_AUTO_POINT(1, 4),
> +	SENSOR_ATTR_PWM_AUTO_POINT(2, 1),
> +	SENSOR_ATTR_PWM_AUTO_POINT(2, 2),
> +	SENSOR_ATTR_PWM_AUTO_POINT(2, 3),
> +	SENSOR_ATTR_PWM_AUTO_POINT(2, 4)
> +};
> +
> +static struct device_attribute vt1211_misc_attr[] = {
> +	__ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm),
> +	__ATTR(cpu0_vid, S_IRUGO, show_vid, NULL),
> +	__ATTR(name, S_IRUGO, show_name, NULL)
> +};
> +
> +/* -------------------------------------------------------------------------
> + * Device registration and initialization
> + * ------------------------------------------------------------------------- */
> +
> +static void __devinit vt1211_init_device(struct vt1211_data *data)
> +{
> +	/* Read VID */
> +	data->vid = vt1211_read8(data, VT1211_REG_VID) & 0x1f;
> +	data->vrm = vid_which_vrm();
> +
> +	/* Read (and initialize) UCH config */
> +	data->uch_config = vt1211_read8(data, VT1211_REG_UCH_CONFIG);
> +	if (uch_config > -1) {
> +		data->uch_config = (data->uch_config & 0x83) |
> +				   (uch_config & 0x7c);
> +		vt1211_write8(data, VT1211_REG_UCH_CONFIG, data->uch_config);
> +	}
> +
> +	/* The VT1211 implements 3 different modes how interrupts get
> +	 * cleared:
> +	 * 1) Clear INT when temp falls below max limit.
> +	 * 2) Clear INT when status register is read. Regenerate INT as long
> +	 *    as temp stays above hysteresis limit.
> +	 * 3) Clear INT when status register is read. DON'T regenerate INT
> +	 *    until temp falls below hysteresis limit and exceeds hot limit
> +	 *    again.
> +	 *
> +	 * We make sure that we're using mode 2 which is not the default
> +	 * (at least not on a EPIA M10000 */
> +	vt1211_write8(data, VT1211_REG_TEMP1_CONFIG, 0);
> +	vt1211_write8(data, VT1211_REG_TEMP2_CONFIG, 0);
> +}
> +
> +static int __devinit vt1211_probe(struct platform_device *pdev)
> +{
> +	struct vt1211_data *data;
> +	struct resource *res;
> +	int i, err;
> +
> +	if (!(data = kzalloc(sizeof(struct vt1211_data), GFP_KERNEL))) {
> +		err = -ENOMEM;
> +		printk(KERN_ERR DRVNAME ": Out of memory\n");
> +		goto EXIT;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	data->addr = res->start;
> +	mutex_init(&data->lock);
> +	data->name = "vt1211";
> +	mutex_init(&data->update_lock);
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	data->class_dev = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
> +		goto EXIT_FREE;
> +	}
> +
> +	/* Initialize the VT1211 chip */
> +	vt1211_init_device(data);
> +
> +	/* Register sysfs interface files */
> +	for (i = 0; i < ARRAY_SIZE(vt1211_sensor_attr_2); i++) {
> +		err = device_create_file(&pdev->dev,
> +					 &vt1211_sensor_attr_2[i].dev_attr);
> +		if (err) {
> +			goto EXIT_DEV_UNREGISTER;
> +		}
> +	}
> +	for (i = 0; i < ARRAY_SIZE(vt1211_misc_attr); i++) {
> +		err = device_create_file(&pdev->dev, &vt1211_misc_attr[i]);
> +		if (err) {
> +			goto EXIT_DEV_UNREGISTER;
> +		}
> +	}
> +
> +	return 0;
> +
> +EXIT_DEV_UNREGISTER:
> +	dev_err(&pdev->dev, "Sysfs interface creation failed\n");
> +	hwmon_device_unregister(data->class_dev);
> +EXIT_FREE:
> +	kfree(data);
> +EXIT:
> +	return err;
> +}
> +
> +static int __devexit vt1211_remove(struct platform_device *pdev)
> +{
> +	struct vt1211_data *data = platform_get_drvdata(pdev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	hwmon_device_unregister(data->class_dev);
> +	kfree(data);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver vt1211_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name  = DRVNAME,
> +	},
> +	.probe  = vt1211_probe,
> +	.remove = __devexit_p(vt1211_remove),
> +};
> +
> +static int __init vt1211_device_add(unsigned short address)
> +{
> +	struct resource res = {
> +		.start	= address,
> +		.end	= address + 0x7f,
> +		.flags	= IORESOURCE_IO,
> +	};
> +	int err;
> +
> +	pdev = platform_device_alloc(DRVNAME, address);
> +	if (!pdev) {
> +		err = -ENOMEM;
> +		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> +		goto EXIT;
> +	}
> +
> +	res.name = pdev->name;
> +	err = platform_device_add_resources(pdev, &res, 1);
> +	if (err) {
> +		printk(KERN_ERR DRVNAME ": Device resource addition failed "
> +		       "(%d)\n", err);
> +		goto EXIT_DEV_PUT;
> +	}
> +
> +	err = platform_device_add(pdev);
> +	if (err) {
> +		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
> +		       err);
> +		goto EXIT_DEV_PUT;
> +	}
> +
> +	return 0;
> +
> +EXIT_DEV_PUT:
> +	platform_device_put(pdev);
> +EXIT:
> +	return err;
> +}
> +
> +static int __init vt1211_find(unsigned short *address)
> +{
> +	int err = -ENODEV;
> +	u16 val;
> +
> +	superio_enter();
> +
> +	val = superio_inb(SIO_VT1211_DEVID);
> +	if (val != SIO_VT1211_ID) {
> +		goto EXIT;
> +	}
> +
> +	superio_select(SIO_VT1211_LDN_HWMON);
> +
> +	val = ((superio_inb(SIO_VT1211_BADDR) << 8) |
> +	       (superio_inb(SIO_VT1211_BADDR + 1)));
> +	*address = val & SIO_VT1211_BADDR_MASK;
> +	if (*address = 0) {
> +		printk(KERN_WARNING DRVNAME ": Base address not set, "
> +		       "skipping\n");
> +		goto EXIT;
> +	}
> +
> +	err = 0;
> +	printk(KERN_INFO DRVNAME ": Found VT1211 chip at %#x, revision %u\n",
> +	       *address, superio_inb(SIO_VT1211_DEVREV));
> +
> +EXIT:
> +	superio_exit();
> +	return err;
> +}
> +
> +static int __init vt1211_init(void)
> +{
> +	int err;
> +	unsigned short address;
> +
> +	if (vt1211_find(&address)) {
> +		err = -ENODEV;
> +		goto EXIT;
> +	}
> +
> +	err = platform_driver_register(&vt1211_driver);
> +	if (err) {
> +		goto EXIT;
> +	}
> +
> +	/* Sets global pdev as a side effect */
> +	err = vt1211_device_add(address);
> +	if (err) {
> +		goto EXIT_DRV_UNREGISTER;
> +	}
> +
> +	return 0;
> +
> + EXIT_DRV_UNREGISTER:
> +	platform_driver_unregister(&vt1211_driver);
> + EXIT:
> +	return err;
> +}
> +
> +static void __exit vt1211_exit(void)
> +{
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&vt1211_driver);
> +}
> +
> +MODULE_AUTHOR("Juerg Haefliger <juergh at gmail.com>, "
> +	      "Lars Ekman <emil71se at yahoo.com>, "
> +	      "Mark D. Studebaker <mdsxyz123 at yahoo.com>");
> +MODULE_DESCRIPTION("VT1211 sensors");
> +MODULE_LICENSE("GPL");
> +
> +module_init(vt1211_init);
> +module_exit(vt1211_exit);
> +
> +/* -------------------------------------------------------------------------
> + * End of file
> + * ------------------------------------------------------------------------- */
> diff -uprN -X linux-2.6.16-mm2-vanilla/Documentation/dontdiff -x Documentation linux-2.6.16-mm2-vanilla/MAINTAINERS linux-2.6.16-mm2/MAINTAINERS
> --- linux-2.6.16-mm2-vanilla/MAINTAINERS	2006-04-01 07:50:51.000000000 +0000
> +++ linux-2.6.16-mm2/MAINTAINERS	2006-04-01 08:38:43.000000000 +0000
> @@ -3053,6 +3053,12 @@ W:	http://linuxtv.org
>  T:	git kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
>  S:	Maintained
>  
> +VT1211 HARDWARE MONITOR DRIVER
> +P:	Juerg Haefliger
> +M:	juergh at gmail.com
> +L:	lm-sensors at lm-sensors.org
> +S:	Maintained
> +
>  VT8231 HARDWARE MONITOR DRIVER
>  P:	Roger Lucas
>  M:	roger at planbit.co.uk

