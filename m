From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 30 Aug 2006 16:24:19 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 3] hwmon: new vt1211 driver
Message-Id: <20060830182419.854a0698.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0608292235s3494ddecp2276c5d9841ac775@mail.gmail.com>
In-Reply-To: <191fb4ca0608292235s3494ddecp2276c5d9841ac775@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> 3rd try :-) Incorporated (hopefully) all changes requested by Jean Delvare.

We're getting there, even though maybe not as fast as you'd like ;)

> This is a new driver for the VIA vt1211 Super-IO chip. It is a rewrite
> of the existing vt1211 driver (by Mark D. Studebaker and Lars Ekman)
> which has been around for a while but never made it into the main
> kernel tree.
> 
> It is implemented as a platform driver and therefore requires the
> latest CVS version of lm_sensors to function properly.

The vt1211.c file created by this patch has DOS line endings instead of
Unix ones.

> +/* ---------------------------------------------------------------------
> + * Registers
> + *
> + * The sensors are defined as follows.
> + *
> + * Sensor          Voltage Mode   Temp Mode   Notes (from the datasheet)
> + * --------        ------------   ---------   --------------------------
> + * Reading 1                      temp1       Intel thermal diode
> + * Reading 3                      temp2       Internal thermal diode
> + * UCH1/Reading2   in0            temp3       NTC type thermistor
> + * UCH2            in1            temp4       +2.5V
> + * UCH3            in2            temp5       VccP
> + * UCH4            in3            temp6       +5V
> + * UCH5            in4            temp7       +12V
> + * 3.3V            in5                        Internal VDD (+3.3V)
> + *
> + * --------------------------------------------------------------------- */

Hmmm, so you permuted temp1, temp2 and temp3 compared to the Linux 2.4
driver. While I was OK with swapping temp1 and temp3 (in line with the
datasheet), I'm not as happy with changing temp2. It makes matching
with the datasheet harder.

What are the benefits? Making ISTEMP() more simple, and getting rid of
TEMPIX_FROM/TO_REG()?

> +
> +/* Voltages (in) numbered 0-5 (ix) */
> +#define VT1211_REG_IN(ix)		(0x21 + (ix))
> +#define VT1211_REG_IN_MIN(ix)		((ix) = 0 ? 0x3e : 0x2a + 2 * (ix))
> +#define VT1211_REG_IN_MAX(ix)		((ix) = 0 ? 0x3d : 0x29 + 2 * (ix))
> +
> +/* Temperatures (temp) numbered 0-6 (ix) */
> +static u8 regtemp[]	= {0x1f, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25};
> +static u8 regtempmax[]	= {0x39, 0x1d, 0x3d, 0x2b, 0x2d, 0x2f, 0x31};
> +static u8 regtemphyst[]	= {0x3a, 0x1e, 0x3e, 0x2c, 0x2e, 0x30, 0x32};
> +
> +/* Fans numbered 0-1 (ix) */
> +#define VT1211_REG_FAN(ix)		(0x29 + (ix))
> +#define VT1211_REG_FAN_MIN(ix)		(0x3b + (ix))
> +#define VT1211_REG_FAN_DIV	 	 0x47
> +
> +/* PWMs numbered 0-1 (ix) */
> +/* Auto points numbered 0-3 (ap) */
> +#define VT1211_REG_PWM(ix)		(0x60 + (ix))
> +#define VT1211_REG_PWM_CLK		 0x50
> +#define VT1211_REG_PWM_CTL		 0x51
> +#define VT1211_REG_PWM_AUTO_TEMP(ap)	(0x55 - (ap))
> +#define VT1211_REG_PWM_AUTO_PWM(ix, ap)	(0x58 + 2 * (ix) - (ap))
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
> +/* In, temp & fan alarm bits */
> +static const u8 bitalarmin[] 	= {11, 0, 1, 3, 8, 2, 9};
> +static const u8 bitalarmtemp[]	= {4, 15, 11, 0, 1, 3, 8};
> +static const u8 bitalarmfan[]	= {6, 7};
> +
> +/* ---------------------------------------------------------------------
> + * Data structures and manipulation thereof
> + * --------------------------------------------------------------------- */
> +
> +struct vt1211_data {
> +	unsigned short addr;
> +	const char *name;
> +	struct class_device *class_dev;
> +
> +	struct mutex update_lock;
> +	char valid;			/* !=0 if following fields are valid */
> +	unsigned long last_updated;	/* In jiffies */
> +
> +	/* Register values */
> +	u8  in[6];
> +	u8  in_max[6];
> +	u8  in_min[6];
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
> +/* ix = [0-5] */
> +#define ISVOLT(ix, uch_config)	((ix) > 4 ? 1 : \
> +				 !(((uch_config) >> ((ix) + 2)) & 1))
> +
> +/* ix = [0-6] */
> +#define ISTEMP(ix, uch_config)	((ix) < 2 ? 1 : \
> +				 ((uch_config) >> (ix)) & 1)
> +
> +/* in5 (ix = 5) is special. It's the internal 3.3V so it's scaled in the
> +   driver according to the VT1211 BIOS porting guide */
> +#define IN_FROM_REG(ix, reg)	((reg) < 3 ? 0 : (ix) = 5 ? \
> +				 (((reg) - 3) * 15882 + 479) / 958 : \
> +				 (((reg) - 3) * 10000 + 479) / 958)
> +#define IN_TO_REG(ix, val)	(SENSORS_LIMIT((ix) = 5 ? \
> +			   	 ((val) * 958 + 7941) / 15882 + 3 : \
> +			   	 ((val) * 958 + 5000) / 10000 + 3, 0, 255))
> +
> +/* temp1 (ix = 0) is an intel thermal diode which is scaled in user space.
> +   temp2 (ix = 1) is the internal temp diode so it's scaled in the driver
> +   according to some measurements that I took on an EPIA M10000.
> +   temp3-7 are thermistor based so the driver returns the voltage measured at
> +   the pin (range 0V - 2.2V). */
> +#define TEMP_FROM_REG(ix, reg)	((ix) = 0 ? (reg) * 1000 : \
> +				 (ix) = 1 ? (reg) < 51 ? 0 : \
> +				 ((reg) - 51) * 1000 : \
> +				 ((253 - (reg)) * 2200 + 105) / 210)
> +#define TEMP_TO_REG(ix, val)	SENSORS_LIMIT( \
> +				 ((ix) = 0 ? ((val) + 500) / 1000 : \
> +				  (ix) = 1 ? ((val) + 500) / 1000 + 51 : \
> +				  253 - ((val) * 210 + 1100) / 2200), 0, 255)
> +
> +#define DIV_FROM_REG(reg) 	(1 << (reg))
> +
> +#define RPM_FROM_REG(reg, div)	(((reg) = 0) || ((reg) = 255) ? 0 : \
> +				 1310720 / (reg) / DIV_FROM_REG(div))
> +#define RPM_TO_REG(val, div)	((val) = 0 ? 255 : \
> +				 SENSORS_LIMIT((1310720 / (val) / \
> +				 DIV_FROM_REG(div)), 1, 254))
> +
> +/* ---------------------------------------------------------------------
> + * Super-I/O constants and functions
> + * --------------------------------------------------------------------- */
> +
> +/* Configuration & data index port registers */
> +#define SIO_REG_CIP		0x2e
> +#define SIO_REG_DIP		0x2f
> +
> +/* Configuration registers */
> +#define SIO_VT1211_LDN		0x07	/* logical device number */
> +#define SIO_VT1211_DEVID	0x20	/* device ID */
> +#define SIO_VT1211_DEVREV	0x21	/* device revision */
> +#define SIO_VT1211_ACTIVE	0x30	/* HW monitor active */
> +#define SIO_VT1211_BADDR	0x60	/* base I/O address */
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
> +/* ---------------------------------------------------------------------
> + * Device I/O access
> + * --------------------------------------------------------------------- */
> +
> +static inline u8 vt1211_read8(struct vt1211_data *data, u8 reg)
> +{
> +	return inb(data->addr + reg);
> +}
> +
> +static inline void vt1211_write8(struct vt1211_data *data, u8 reg, u8 val)
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

No blank line here please.

> +		/* voltage (in) registers */
> +		for (ix = 0; ix < ARRAY_SIZE(data->in); ix++) {
> +			if (ISVOLT(ix, data->uch_config)) {
> +				data->in[ix] = vt1211_read8(data,
> +						VT1211_REG_IN(ix));
> +				data->in_min[ix] = vt1211_read8(data,
> +						VT1211_REG_IN_MIN(ix));
> +				data->in_max[ix] = vt1211_read8(data,
> +						VT1211_REG_IN_MAX(ix));
> +			}
> +		}
> +
> +		/* temp registers */
> +		for (ix = 0; ix < ARRAY_SIZE(data->temp); ix++) {
> +			if (ISTEMP(ix, data->uch_config)) {
> +				data->temp[ix] = vt1211_read8(data,
> +						regtemp[ix]);
> +				data->temp_max[ix] = vt1211_read8(data,
> +						regtempmax[ix]);
> +				data->temp_hyst[ix] = vt1211_read8(data,
> +						regtemphyst[ix]);
> +			}
> +		}
> +
> +		/* fan & pwm registers */
> +		for (ix = 0; ix < ARRAY_SIZE(data->fan); ix++) {
> +			data->fan[ix] = vt1211_read8(data,
> +						VT1211_REG_FAN(ix));
> +			data->fan_min[ix] = vt1211_read8(data,
> +						VT1211_REG_FAN_MIN(ix));
> +			data->pwm[ix] = vt1211_read8(data,
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
> +		data->pwm_auto_pwm[0][1] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_PWM(0, 1));
> +		data->pwm_auto_pwm[0][2] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_PWM(0, 2));
> +		data->pwm_auto_pwm[1][1] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_PWM(1, 1));
> +		data->pwm_auto_pwm[1][2] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_PWM(1, 2));
> +		for (ix = 0; ix < ARRAY_SIZE(data->pwm_auto_temp); ix++) {
> +			data->pwm_auto_temp[ix] = vt1211_read8(data,
> +						VT1211_REG_PWM_AUTO_TEMP(ix));
> +		}
> +
> +		/* alarm registers */
> +		data->alarms = (vt1211_read8(data, VT1211_REG_ALARM2) << 8) |
> +				vt1211_read8(data, VT1211_REG_ALARM1);
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
> +/* ---------------------------------------------------------------------
> + * Voltage sysfs interfaces
> + * ix = [0-5]
> + * --------------------------------------------------------------------- */
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
> +	int fn = sensor_attr_2->nr;
> +	int res;
> +
> +	switch (fn) {
> +	case SHOW_IN_INPUT:
> +		res = IN_FROM_REG(ix, data->in[ix]);
> +		break;
> +	case SHOW_SET_IN_MIN:
> +		res = IN_FROM_REG(ix, data->in_min[ix]);
> +		break;
> +	case SHOW_SET_IN_MAX:
> +		res = IN_FROM_REG(ix, data->in_max[ix]);
> +		break;
> +	case SHOW_IN_ALARM:
> +		res = ISVOLT(ix, data->uch_config) &
> +		      (data->alarms >> bitalarmin[ix]) & 1;

The ISVOLT() test shouldn't be needed, as you shouldn't have created
the file if that channel wasn't use for voltage.

> +		break;
> +	default:
> +		res = 0;
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +
> +	return sprintf(buf, "%d\n", res);
> +}
> +
> +static ssize_t set_in(struct device *dev, struct device_attribute *attr,
> +		      const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (fn) {
> +	case SHOW_SET_IN_MIN:
> +		data->in_min[ix] = IN_TO_REG(ix, val);
> +		vt1211_write8(data, VT1211_REG_IN_MIN(ix), data->in_min[ix]);
> +		break;
> +	case SHOW_SET_IN_MAX:
> +		data->in_max[ix] = IN_TO_REG(ix, val);
> +		vt1211_write8(data, VT1211_REG_IN_MAX(ix), data->in_max[ix]);
> +		break;
> +	default:
> +		dev_dbg("Unknown attr fetch (%d)\n", fn);

Missing dev, causing compilation failure when debug enabled.

> +	}
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Temperature sysfs interfaces
> + * ix = [0-6]
> + * --------------------------------------------------------------------- */
> +
> +#define SHOW_TEMP_INPUT		0
> +#define SHOW_SET_TEMP_MAX	1
> +#define SHOW_SET_TEMP_MAX_HYST	2
> +#define SHOW_TEMP_ALARM		3
> +
> +static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	int res;
> +
> +	switch (fn) {
> +	case SHOW_TEMP_INPUT:
> +		res = TEMP_FROM_REG(ix, data->temp[ix]);
> +		break;
> +	case SHOW_SET_TEMP_MAX:
> +		res = TEMP_FROM_REG(ix, data->temp_max[ix]);
> +		break;
> +	case SHOW_SET_TEMP_MAX_HYST:
> +		res = TEMP_FROM_REG(ix, data->temp_hyst[ix]);
> +		break;
> +	case SHOW_TEMP_ALARM:
> +		res = ISTEMP(ix, data->uch_config) &
> +		      (data->alarms >> bitalarmtemp[ix]) & 1;

The ISTEMP() test shouldn't be needed, as you shouldn't have created
the file if that channel wasn't use for temperature.

> +		break;
> +	default:
> +		res = 0;
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +
> +	return sprintf(buf, "%d\n", res);
> +}
> +
> +static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (fn) {
> +	case SHOW_SET_TEMP_MAX:
> +		data->temp_max[ix] = TEMP_TO_REG(ix, val);
> +		vt1211_write8(data, regtempmax[ix],
> +			      data->temp_max[ix]);
> +		break;
> +	case SHOW_SET_TEMP_MAX_HYST:
> +		data->temp_hyst[ix] = TEMP_TO_REG(ix, val);
> +		vt1211_write8(data, regtemphyst[ix],
> +			      data->temp_hyst[ix]);
> +		break;
> +	default:
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Fan sysfs interfaces
> + * ix = [0-1]
> + * --------------------------------------------------------------------- */
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
> +	int fn = sensor_attr_2->nr;
> +	int res;
> +
> +	switch (fn) {
> +	case SHOW_FAN_INPUT:
> +		res = RPM_FROM_REG(data->fan[ix], data->fan_div[ix]);
> +		break;
> +	case SHOW_SET_FAN_MIN:
> +		res = RPM_FROM_REG(data->fan_min[ix], data->fan_div[ix]);
> +		break;
> +	case SHOW_SET_FAN_DIV:
> +		res = DIV_FROM_REG(data->fan_div[ix]);
> +		break;
> +	case SHOW_FAN_ALARM:
> +		res = (data->alarms >> bitalarmfan[ix]) & 1;
> +		break;
> +	default:
> +		res = 0;
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +
> +	return sprintf(buf, "%d\n", res);
> +}
> +
> +static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +	int reg;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	/* sync the data cache */
> +	reg = vt1211_read8(data, VT1211_REG_FAN_DIV);
> +	data->fan_div[0] = (reg >> 4) & 3;
> +	data->fan_div[1] = (reg >> 6) & 3;
> +	data->fan_ctl = reg & 0xf;
> +
> +	switch (fn) {
> +	case SHOW_SET_FAN_MIN:
> +		data->fan_min[ix] = RPM_TO_REG(val, data->fan_div[ix]);
> +		vt1211_write8(data, VT1211_REG_FAN_MIN(ix),
> +			      data->fan_min[ix]);
> +		break;
> +	case SHOW_SET_FAN_DIV:
> +		switch (val) {
> +			case 1: data->fan_div[ix] = 0; break;
> +			case 2: data->fan_div[ix] = 1; break;
> +			case 4: data->fan_div[ix] = 2; break;
> +			case 8: data->fan_div[ix] = 3; break;
> +			default:
> +				count = -EINVAL;
> +				dev_err(dev, "fan div value %ld not "
> +					"supported. Choose one of 1, 2, "
> +				        "4, or 8.\n", val);
> +				goto EXIT;
> +		}
> +		vt1211_write8(data, VT1211_REG_FAN_DIV,
> +			      ((data->fan_div[1] << 6) |
> +			       (data->fan_div[0] << 4) |
> +				data->fan_ctl));
> +		break;
> +	default:
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +
> +EXIT:
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * PWM sysfs interfaces
> + * ix = [0-1]
> + * --------------------------------------------------------------------- */
> +
> +#define SHOW_PWM			0
> +#define SHOW_SET_PWM_ENABLE		1
> +#define SHOW_SET_PWM_FREQ		2
> +#define SHOW_SET_PWM_AUTO_CHANNELS_TEMP	3
> +
> +static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int en, sg;	/* PWM output enable, SmartGuardian ctrl enable */
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	int res;
> +
> +	switch (fn) {
> +	case SHOW_PWM:
> +		res = data->pwm[ix];
> +		break;
> +	case SHOW_SET_PWM_ENABLE:
> +		en = (data->pwm_ctl[ix] >> 3) & 1;
> +		sg = data->fan_ctl & 1;
> +		res = (en && sg) ? 2 : 0;

Isn't "sg" always 1 if "en" is 1 for at least one fan, by driver
design? If so, you can avoid testing it here, testing "en" alone will
give the same result.

> +		break;
> +	case SHOW_SET_PWM_FREQ:
> +		res = 90000 >> (data->pwm_clk & 7);
> +		break;
> +	case SHOW_SET_PWM_AUTO_CHANNELS_TEMP:
> +		res = (data->pwm_ctl[ix] & 7) + 1;
> +		break;
> +	default:
> +		res = 0;
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +
> +	return sprintf(buf, "%d\n", res);
> +}
> +
> +static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute_2 *sensor_attr_2 > +						to_sensor_dev_attr_2(attr);
> +	int ix = sensor_attr_2->index;
> +	int fn = sensor_attr_2->nr;
> +	long val = simple_strtol(buf, NULL, 10);
> +	int reg;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	/* sync the data cache */
> +	reg = vt1211_read8(data, VT1211_REG_FAN_DIV);
> +	data->fan_div[0] = (reg >> 4) & 3;
> +	data->fan_div[1] = (reg >> 6) & 3;
> +	data->fan_ctl = reg & 0xf;

You need this only in the SHOW_SET_PWM_ENABLE case.

> +	reg = vt1211_read8(data, VT1211_REG_PWM_CTL);
> +	data->pwm_ctl[0] = reg & 0xf;
> +	data->pwm_ctl[1] = (reg >> 4) & 0xf;

You don't need this in the SHOW_SET_PWM_FREQ case.

> +	data->pwm_clk = vt1211_read8(data, VT1211_REG_PWM_CLK);

And you only need this in the SHOW_SET_PWM_FREQ case.

So, reading from these three registers in all cases is inefficient. I
think you are reaching the limits of your one-callback-with-switch
construct here. There isn't so much in common between all cases. Please
only read the register values you need. And if you prefer to split this
function into three smaller functions, that's fine with me ;)


> +
> +	switch (fn) {
> +	case SHOW_SET_PWM_ENABLE:
> +		switch (val) {
> +		case 0:
> +			data->pwm_ctl[ix] &= 7;
> +			/* disable SmartGuardian if both PWM outputs are
> +			 * disabled */
> +			if ((data->pwm_ctl[ix ^ 1] & 1) = 0) {
> +				data->fan_ctl &= 0xe;
> +			}
> +			break;
> +		case 2:
> +			data->pwm_ctl[ix] |= 8;
> +			data->fan_ctl |= 1;
> +			break;
> +		default:
> +			count = -EINVAL;
> +			dev_err(dev, "pwm mode %ld not supported. "
> +			        "Choose one of 0 or 2.\n", val);
> +			goto EXIT;
> +		}
> +		vt1211_write8(data, VT1211_REG_PWM_CTL,
> +			      ((data->pwm_ctl[1] << 4) |
> +				data->pwm_ctl[0]));
> +		vt1211_write8(data, VT1211_REG_FAN_DIV,
> +			      ((data->fan_div[1] << 6) |
> +			       (data->fan_div[0] << 4) |
> +				data->fan_ctl));

BTW, here you don't actually care about the values of fan_div, all you
need is to make sure you don't overwrite them in the register. In that
case it isn't very efficient to decode them and store them in the
cache, then shift and merge them again to recreate the register value.
Instead you could store the upper nibble of the register value in a
temporary variable, it'd be more efficient, and IMHO clearer.

> +		break;
> +	case SHOW_SET_PWM_FREQ:
> +		switch (val) {
> +		case 90000: val = 0; break;
> +		case 45000: val = 1; break;
> +		case 22500: val = 2; break;
> +		case 11250: val = 3; break;
> +		case  5625: val = 4; break;
> +		case  2812: val = 5; break;
> +		case  1406: val = 6; break;
> +		case   703: val = 7; break;
> +		default:
> +			count = -EINVAL;
> +			dev_err(dev, "pwm frequency %ld not supported. "
> +			        "Choose one of 90000, 45000, 22500, 11250, "
> +			        "5625, 2812, 1406, or 703.\n", val);
> +			goto EXIT;
> +		}

Huuu, no! You had such a nice piece of code to handle this before...

We do _not_ want to ask user-space for exact numbers for continuous
values, only for discrete values where the possible values are
standarized (like fan_div, pwm and pwm_enable). Here the user has no
chance to guess the valid frequencies, because they are completely
chip-specific.

So please revert to your nearest-point formula which was doing a much
better job.

> +		data->pwm_clk = (data->pwm_clk & 0xf8) | val;
> +		vt1211_write8(data, VT1211_REG_PWM_CLK, data->pwm_clk);
> +		break;
> +	case SHOW_SET_PWM_AUTO_CHANNELS_TEMP:
> +		if ((val < 1) || (val > 7)) {
> +			count = -EINVAL;
> +			dev_err(dev, "temp channel %ld not supported. "
> +				"Choose a value between 1 and 7.\n", val);
> +			goto EXIT;
> +		}
> +		if (!ISTEMP(val - 1, data->uch_config)) {
> +			count = -EINVAL;
> +			dev_err(dev, "temp channel %ld is not available.\n",
> +				val);
> +			goto EXIT;
> +		}
> +		data->pwm_ctl[ix] = (data->pwm_ctl[ix] & 8) | (val - 1);
> +		vt1211_write8(data, VT1211_REG_PWM_CTL,
> +			      ((data->pwm_ctl[1] << 4) | data->pwm_ctl[0]));
> +		break;
> +	default:
> +		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +	}
> +
> +EXIT:
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * PWM auto point definitions
> + * ix = [0-1]
> + * ap = [0-3]
> + * --------------------------------------------------------------------- */
> +
> +/*
> + * pwm[ix+1]_auto_point[ap+1]_temp mapping table:
> + * Note that there is only a single set of temp auto points that controls both
> + * PWM controllers. We still create 2 sets of sysfs files to make it look
> + * more consistent even though they map to the same registers.
> + *
> + * ix ap : description
> + * -------------------
> + * 0  0  : pwm1/2 off temperature        (pwm_auto_temp[0])
> + * 0  1  : pwm1/2 low speed temperature  (pwm_auto_temp[1])
> + * 0  2  : pwm1/2 high speed temperature (pwm_auto_temp[2])
> + * 0  3  : pwm1/2 full speed temperature (pwm_auto_temp[3])
> + * 1  0  : pwm1/2 off temperature        (pwm_auto_temp[0])
> + * 1  1  : pwm1/2 low speed temperature  (pwm_auto_temp[1])
> + * 1  2  : pwm1/2 high speed temperature (pwm_auto_temp[2])
> + * 1  3  : pwm1/2 full speed temperature (pwm_auto_temp[3])
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
> +
> +	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->pwm_ctl[ix] & 7,
> +		       data->pwm_auto_temp[ap]));
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
> +	long val = simple_strtol(buf, NULL, 10);
> +	int reg;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	/* sync the data cache */
> +	reg = vt1211_read8(data, VT1211_REG_PWM_CTL);
> +	data->pwm_ctl[0] = reg & 0xf;
> +	data->pwm_ctl[1] = (reg >> 4) & 0xf;
> +
> +	data->pwm_auto_temp[ap] = TEMP_TO_REG(data->pwm_ctl[ix] & 7, val);
> +	vt1211_write8(data, VT1211_REG_PWM_AUTO_TEMP(ap),
> +		      data->pwm_auto_temp[ap]);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +/*
> + * pwm[ix+1]_auto_point[ap+1]_pwm mapping table:
> + * Note that the PWM auto points 0 & 3 are hard-wired in the VT1211 and can't
> + * be changed.
> + *
> + * ix ap : description
> + * -------------------
> + * 0  0  : pwm1 off                   (pwm_auto_pwm[0][0], hard-wired to 0)
> + * 0  1  : pwm1 low speed duty cycle  (pwm_auto_pwm[0][1])
> + * 0  2  : pwm1 high speed duty cycle (pwm_auto_pwm[0][2])
> + * 0  3  : pwm1 full speed duty cycle (pwm_auto_pwm[0][3], hard-wired to 255)
> + * 1  0  : pwm2 off                   (pwm_auto_pwm[1][0], hard-wired to 255)
> + * 1  1  : pwm2 low speed duty cycle  (pwm_auto_pwm[1][1])
> + * 1  2  : pwm2 high speed duty cycle (pwm_auto_pwm[1][2])
> + * 1  3  : pwm2 full speed            (pwm_auto_pwm[1][3], hard-wired to 0)

"hard-wired" comments swapped for pwm2. There's also an extra "duty
cycle" for pwm1 full speed which can probably go away.

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
> +
> +	return sprintf(buf, "%d\n", data->pwm_auto_pwm[ix][ap]);
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
> +
> +	if ((val < 0) || (val > 255)) {
> +		dev_err(dev, "pwm value %ld is out of range. "
> +			"Choose a value between 0 and 255." , val);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&data->update_lock);
> +	data->pwm_auto_pwm[ix][ap] = val;
> +	vt1211_write8(data, VT1211_REG_PWM_AUTO_PWM(ix, ap),
> +		      data->pwm_auto_pwm[ix][ap]);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Miscellaneous sysfs interfaces (VRM, VID, name, and (legacy) alarms)
> + * --------------------------------------------------------------------- */
> +
> +static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", data->vrm);
> +}
> +
> +static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +	long val = simple_strtol(buf, NULL, 10);
> +
> +	data->vrm = val;
> +
> +	return count;
> +}
> +
> +static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
> +}
> +
> +static ssize_t show_name(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct vt1211_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", data->name);
> +}
> +
> +static ssize_t show_alarms(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct vt1211_data *data = vt1211_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", data->alarms);
> +}
> +
> +/* ---------------------------------------------------------------------
> + * Device attribute structs
> + * --------------------------------------------------------------------- */
> +
> +#define SENSOR_ATTR_IN_INPUT(ix) \
> +	SENSOR_ATTR_2(in##ix##_input, S_IRUGO, \
> +		show_in, NULL, SHOW_IN_INPUT, ix)
> +
> +static struct sensor_device_attribute_2 vt1211_sysfs_in_input[] = {
> +	SENSOR_ATTR_IN_INPUT(0),
> +	SENSOR_ATTR_IN_INPUT(1),
> +	SENSOR_ATTR_IN_INPUT(2),
> +	SENSOR_ATTR_IN_INPUT(3),
> +	SENSOR_ATTR_IN_INPUT(4),
> +	SENSOR_ATTR_IN_INPUT(5),
> +};
> +
> +#define SENSOR_ATTR_IN_MIN(ix) \
> +	SENSOR_ATTR_2(in##ix##_min, S_IRUGO | S_IWUSR, \
> +		show_in, set_in, SHOW_SET_IN_MIN, ix)
> +
> +static struct sensor_device_attribute_2 vt1211_sysfs_in_min[] = {
> +	SENSOR_ATTR_IN_MIN(0),
> +	SENSOR_ATTR_IN_MIN(1),
> +	SENSOR_ATTR_IN_MIN(2),
> +	SENSOR_ATTR_IN_MIN(3),
> +	SENSOR_ATTR_IN_MIN(4),
> +	SENSOR_ATTR_IN_MIN(5),
> +};
> +
> +#define SENSOR_ATTR_IN_MAX(ix) \
> +	SENSOR_ATTR_2(in##ix##_max, S_IRUGO | S_IWUSR, \
> +		show_in, set_in, SHOW_SET_IN_MAX, ix)
> +
> +static struct sensor_device_attribute_2 vt1211_sysfs_in_max[] = {
> +	SENSOR_ATTR_IN_MAX(0),
> +	SENSOR_ATTR_IN_MAX(1),
> +	SENSOR_ATTR_IN_MAX(2),
> +	SENSOR_ATTR_IN_MAX(3),
> +	SENSOR_ATTR_IN_MAX(4),
> +	SENSOR_ATTR_IN_MAX(5),
> +};
> +
> +#define SENSOR_ATTR_IN_ALARM(ix) \
> +	SENSOR_ATTR_2(in##ix##_alarm, S_IRUGO, \
> +		show_in, NULL, SHOW_IN_ALARM, ix)
> +
> +static struct sensor_device_attribute_2 vt1211_sysfs_in_alarm[] = {
> +	SENSOR_ATTR_IN_ALARM(0),
> +	SENSOR_ATTR_IN_ALARM(1),
> +	SENSOR_ATTR_IN_ALARM(2),
> +	SENSOR_ATTR_IN_ALARM(3),
> +	SENSOR_ATTR_IN_ALARM(4),
> +	SENSOR_ATTR_IN_ALARM(5),
> +};
> +
> +#define SENSOR_ATTR_TEMP_INPUT(ix) \
> +	SENSOR_ATTR_2(temp##ix##_input, S_IRUGO, \
> +		show_temp, NULL, SHOW_TEMP_INPUT, ix-1)
> +
> +static struct sensor_device_attribute_2 vt1211_sysfs_temp_input[] = {
> +	SENSOR_ATTR_TEMP_INPUT(1),
> +	SENSOR_ATTR_TEMP_INPUT(2),
> +	SENSOR_ATTR_TEMP_INPUT(3),
> +	SENSOR_ATTR_TEMP_INPUT(4),
> +	SENSOR_ATTR_TEMP_INPUT(5),
> +	SENSOR_ATTR_TEMP_INPUT(6),
> +	SENSOR_ATTR_TEMP_INPUT(7),
> +};
> +
> +#define SENSOR_ATTR_TEMP_MAX(ix) \
> +	SENSOR_ATTR_2(temp##ix##_max, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, SHOW_SET_TEMP_MAX, ix-1)
> +
> +static struct sensor_device_attribute_2 vt1211_sysfs_temp_max[] = {
> +	SENSOR_ATTR_TEMP_MAX(1),
> +	SENSOR_ATTR_TEMP_MAX(2),
> +	SENSOR_ATTR_TEMP_MAX(3),
> +	SENSOR_ATTR_TEMP_MAX(4),
> +	SENSOR_ATTR_TEMP_MAX(5),
> +	SENSOR_ATTR_TEMP_MAX(6),
> +	SENSOR_ATTR_TEMP_MAX(7),
> +};
> +
> +#define SENSOR_ATTR_TEMP_MAX_HYST(ix) \
> +	SENSOR_ATTR_2(temp##ix##_max_hyst, S_IRUGO | S_IWUSR, \
> +		show_temp, set_temp, SHOW_SET_TEMP_MAX_HYST, ix-1)
> +
> +static struct sensor_device_attribute_2 vt1211_sysfs_temp_max_hyst[] = {
> +	SENSOR_ATTR_TEMP_MAX_HYST(1),
> +	SENSOR_ATTR_TEMP_MAX_HYST(2),
> +	SENSOR_ATTR_TEMP_MAX_HYST(3),
> +	SENSOR_ATTR_TEMP_MAX_HYST(4),
> +	SENSOR_ATTR_TEMP_MAX_HYST(5),
> +	SENSOR_ATTR_TEMP_MAX_HYST(6),
> +	SENSOR_ATTR_TEMP_MAX_HYST(7),
> +};
> +
> +#define SENSOR_ATTR_TEMP_ALARM(ix) \
> +	SENSOR_ATTR_2(temp##ix##_alarm, S_IRUGO, \
> +		show_temp, NULL, SHOW_TEMP_ALARM, ix-1)
> +
> +static struct sensor_device_attribute_2 vt1211_sysfs_temp_alarm[] = {
> +	SENSOR_ATTR_TEMP_ALARM(1),
> +	SENSOR_ATTR_TEMP_ALARM(2),
> +	SENSOR_ATTR_TEMP_ALARM(3),
> +	SENSOR_ATTR_TEMP_ALARM(4),
> +	SENSOR_ATTR_TEMP_ALARM(5),
> +	SENSOR_ATTR_TEMP_ALARM(6),
> +	SENSOR_ATTR_TEMP_ALARM(7),
> +};
> +
> +#define SENSOR_ATTR_FAN(ix) \
> +	SENSOR_ATTR_2(fan##ix##_input, S_IRUGO, \
> +		show_fan, NULL, SHOW_FAN_INPUT, ix-1), \
> +	SENSOR_ATTR_2(fan##ix##_min, S_IRUGO | S_IWUSR, \
> +		show_fan, set_fan, SHOW_SET_FAN_MIN, ix-1), \
> +	SENSOR_ATTR_2(fan##ix##_div, S_IRUGO | S_IWUSR, \
> +		show_fan, set_fan, SHOW_SET_FAN_DIV, ix-1), \
> +	SENSOR_ATTR_2(fan##ix##_alarm, S_IRUGO, \
> +		show_fan, NULL, SHOW_FAN_ALARM, ix-1)
> +
> +#define SENSOR_ATTR_PWM(ix) \
> +	SENSOR_ATTR_2(pwm##ix, S_IRUGO, \
> +		show_pwm, NULL, SHOW_PWM, ix-1), \
> +	SENSOR_ATTR_2(pwm##ix##_enable, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SHOW_SET_PWM_ENABLE, ix-1), \
> +	SENSOR_ATTR_2(pwm##ix##_auto_channels_temp, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SHOW_SET_PWM_AUTO_CHANNELS_TEMP, ix-1)
> +
> +#define SENSOR_ATTR_PWM_FREQ(ix) \
> +	SENSOR_ATTR_2(pwm##ix##_freq, S_IRUGO | S_IWUSR, \
> +		show_pwm, set_pwm, SHOW_SET_PWM_FREQ, ix-1)
> +
> +#define SENSOR_ATTR_PWM_FREQ_RO(ix) \
> +	SENSOR_ATTR_2(pwm##ix##_freq, S_IRUGO, \
> +		show_pwm, NULL, SHOW_SET_PWM_FREQ, ix-1)
> +
> +#define SENSOR_ATTR_PWM_AUTO_POINT_TEMP(ix, ap) \
> +	SENSOR_ATTR_2(pwm##ix##_auto_point##ap##_temp, S_IRUGO | S_IWUSR, \
> +		show_pwm_auto_point_temp, set_pwm_auto_point_temp, \
> +		ap-1, ix-1)
> +
> +#define SENSOR_ATTR_PWM_AUTO_POINT_TEMP_RO(ix, ap) \
> +	SENSOR_ATTR_2(pwm##ix##_auto_point##ap##_temp, S_IRUGO, \
> +		show_pwm_auto_point_temp, NULL, \
> +		ap-1, ix-1)
> +
> +#define SENSOR_ATTR_PWM_AUTO_POINT_PWM(ix, ap) \
> +	SENSOR_ATTR_2(pwm##ix##_auto_point##ap##_pwm, S_IRUGO | S_IWUSR, \
> +		show_pwm_auto_point_pwm, set_pwm_auto_point_pwm, \
> +		ap-1, ix-1)
> +
> +#define SENSOR_ATTR_PWM_AUTO_POINT_PWM_RO(ix, ap) \
> +	SENSOR_ATTR_2(pwm##ix##_auto_point##ap##_pwm, S_IRUGO, \
> +		show_pwm_auto_point_pwm, NULL, \
> +		ap-1, ix-1)
> +
> +static struct sensor_device_attribute_2 vt1211_sysfs_fan_pwm[] = {
> +	SENSOR_ATTR_FAN(1),
> +	SENSOR_ATTR_FAN(2),
> +	SENSOR_ATTR_PWM(1),
> +	SENSOR_ATTR_PWM(2),
> +	SENSOR_ATTR_PWM_FREQ(1),
> +	SENSOR_ATTR_PWM_FREQ_RO(2),
> +	SENSOR_ATTR_PWM_AUTO_POINT_TEMP(1, 1),
> +	SENSOR_ATTR_PWM_AUTO_POINT_TEMP(1, 2),
> +	SENSOR_ATTR_PWM_AUTO_POINT_TEMP(1, 3),
> +	SENSOR_ATTR_PWM_AUTO_POINT_TEMP(1, 4),
> +	SENSOR_ATTR_PWM_AUTO_POINT_TEMP_RO(2, 1),
> +	SENSOR_ATTR_PWM_AUTO_POINT_TEMP_RO(2, 2),
> +	SENSOR_ATTR_PWM_AUTO_POINT_TEMP_RO(2, 3),
> +	SENSOR_ATTR_PWM_AUTO_POINT_TEMP_RO(2, 4),
> +	SENSOR_ATTR_PWM_AUTO_POINT_PWM_RO(1, 1),
> +	SENSOR_ATTR_PWM_AUTO_POINT_PWM(1, 2),
> +	SENSOR_ATTR_PWM_AUTO_POINT_PWM(1, 3),
> +	SENSOR_ATTR_PWM_AUTO_POINT_PWM_RO(1, 4),
> +	SENSOR_ATTR_PWM_AUTO_POINT_PWM_RO(2, 1),
> +	SENSOR_ATTR_PWM_AUTO_POINT_PWM(2, 2),
> +	SENSOR_ATTR_PWM_AUTO_POINT_PWM(2, 3),
> +	SENSOR_ATTR_PWM_AUTO_POINT_PWM_RO(2, 4),
> +};
> +
> +static struct device_attribute vt1211_sysfs_misc[] = {
> +	__ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm),
> +	__ATTR(cpu0_vid, S_IRUGO, show_vid, NULL),
> +	__ATTR(name, S_IRUGO, show_name, NULL),
> +	__ATTR(alarms, S_IRUGO, show_alarms, NULL),
> +};
> +
> +/* ---------------------------------------------------------------------
> + * Device registration and initialization
> + * --------------------------------------------------------------------- */
> +
> +static void __devinit vt1211_init_device(struct vt1211_data *data)
> +{
> +	/* Read VID and set VRM */
> +	data->vid = vt1211_read8(data, VT1211_REG_VID) & 0x1f;

Any reason why this is only read once, rather than updated on every
read?

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
> +	/* Initialize the interrupt mode (if request at module load time).
> +	 * The VT1211 implements 3 different modes for clearing interrupts:
> +	 * 0: Clear INT when status register is read. Regenerate INT as long
> +	 *    as temp stays above hysteresis limit.
> +	 * 1: Clear INT when status register is read. DON'T regenerate INT
> +	 *    until temp falls below hysteresis limit and exceeds hot limit
> +	 *    again.
> +	 * 2: Clear INT when temp falls below max limit. */
> +	switch (int_mode) {
> +	case -1: break;
> +	case  0:
> +		vt1211_write8(data, VT1211_REG_TEMP1_CONFIG, 0);
> +		vt1211_write8(data, VT1211_REG_TEMP2_CONFIG, 0);
> +		break;
> +	case  1:
> +		vt1211_write8(data, VT1211_REG_TEMP1_CONFIG, 0x15);
> +		vt1211_write8(data, VT1211_REG_TEMP2_CONFIG, 0x55);
> +		break;
> +	case  2:
> +		vt1211_write8(data, VT1211_REG_TEMP1_CONFIG, 0xaa);
> +		vt1211_write8(data, VT1211_REG_TEMP2_CONFIG, 0xaa);
> +		break;

Looks to me like you are giving the user too much power. There are only
two sane choices here, either leave the mode unchanged, or force to
"comparator mode" (0) because that's what the "lm_sensors standard". I
see no point in letting the user force one of the modes that will make
sensors' output look weird.

> +	default:
> +		printk(KERN_ERR DRVNAME ": Invalid interrupt mode %d. "
> +		       "Choose one of 0, 1, or 2.\n", int_mode);

This one should be converted to dev_err() if you leave it here, but
actually it would be even better to check for invalid value at module
initialization time, and refuse to load the module if value is not
correct. Same applies to uch_config.

> +	}
> +
> +	/* Fill in some hard wired values into our data struct */
> +	data->pwm_auto_pwm[0][3] = 255;
> +	data->pwm_auto_pwm[1][3] = 255;
> +}
> +
> +static void vt1211_remove_sysfs(struct platform_device *pdev)
> +{
> +	int i;

You may want to set
	stuct device *dev = &pdev->dev;
here, so that all the further uses are shorter. Might make things
faster as well, assuming gcc isn't able to optimize it on its own.

> +
> +	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_in_input); i++) {
> +		device_remove_file(&pdev->dev,
> +			&vt1211_sysfs_in_input[i].dev_attr);
> +		device_remove_file(&pdev->dev,
> +			&vt1211_sysfs_in_min[i].dev_attr);
> +		device_remove_file(&pdev->dev,
> +			&vt1211_sysfs_in_max[i].dev_attr);
> +		device_remove_file(&pdev->dev,
> +			&vt1211_sysfs_in_alarm[i].dev_attr);
> +	}
> +	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_temp_input); i++) {
> +		device_remove_file(&pdev->dev,
> +			&vt1211_sysfs_temp_input[i].dev_attr);
> +		device_remove_file(&pdev->dev,
> +			&vt1211_sysfs_temp_max[i].dev_attr);
> +		device_remove_file(&pdev->dev,
> +			&vt1211_sysfs_temp_max_hyst[i].dev_attr);
> +		device_remove_file(&pdev->dev,
> +			&vt1211_sysfs_temp_alarm[i].dev_attr);
> +	}
> +	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_fan_pwm); i++) {
> +		device_remove_file(&pdev->dev,
> +			&vt1211_sysfs_fan_pwm[i].dev_attr);
> +	}
> +	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_misc); i++) {
> +		device_remove_file(&pdev->dev, &vt1211_sysfs_misc[i]);
> +	}
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
> +		dev_err(&pdev->dev, "Out of memory\n");
> +		goto EXIT;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	data->addr = res->start;
> +	data->name = DRVNAME;
> +	mutex_init(&data->update_lock);
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	/* Initialize the VT1211 chip */
> +	vt1211_init_device(data);
> +
> +	/* Create sysfs interface files */
> +	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_in_input); i++) {
> +		if (ISVOLT(i, data->uch_config)) {
> +			err = device_create_file(&pdev->dev,
> +				&vt1211_sysfs_in_input[i].dev_attr);
> +			if (!err) {
> +				err = device_create_file(&pdev->dev,
> +				&vt1211_sysfs_in_min[i].dev_attr);
> +			}
> +			if (!err) {
> +				err = device_create_file(&pdev->dev,
> +				&vt1211_sysfs_in_max[i].dev_attr);
> +			}
> +			if (!err) {
> +				err = device_create_file(&pdev->dev,
> +				&vt1211_sysfs_in_alarm[i].dev_attr);
> +			}
> +			if (err) {
> +				goto EXIT_DEV_REMOVE;
> +			}
> +		}

This isn't very elegant. What about:

			if ((err = device_create_file(&pdev->dev,
				   &vt1211_sysfs_in_input[i].dev_attr)
			 || (err = device_create_file(&pdev->dev,
				   &vt1211_sysfs_in_min[i].dev_attr)
			 || (err = device_create_file(&pdev->dev,
				   &vt1211_sysfs_in_max[i].dev_attr)
			 || (err = device_create_file(&pdev->dev,
				   &vt1211_sysfs_in_alarm[i].dev_attr))
				goto EXIT_DEV_REMOVE;

It's more compact and achieves the same. Same below...

> +	}
> +	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_temp_input); i++) {
> +		if (ISTEMP(i, data->uch_config)) {
> +			err = device_create_file(&pdev->dev,
> +				&vt1211_sysfs_temp_input[i].dev_attr);
> +			if (!err) {
> +				err = device_create_file(&pdev->dev,
> +				&vt1211_sysfs_temp_max[i].dev_attr);
> +			}
> +			if (!err) {
> +				err = device_create_file(&pdev->dev,
> +				&vt1211_sysfs_temp_max_hyst[i].dev_attr);
> +			}
> +			if (!err) {
> +				err = device_create_file(&pdev->dev,
> +				&vt1211_sysfs_temp_alarm[i].dev_attr);
> +			}
> +			if (err) {
> +				goto EXIT_DEV_REMOVE;
> +			}
> +		}
> +	}
> +	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_fan_pwm); i++) {
> +		err = device_create_file(&pdev->dev,
> +			&vt1211_sysfs_fan_pwm[i].dev_attr);
> +		if (err) {
> +			goto EXIT_DEV_REMOVE;
> +		}
> +	}
> +	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_misc); i++) {
> +		err = device_create_file(&pdev->dev,
> +			&vt1211_sysfs_misc[i]);
> +		if (err) {
> +			goto EXIT_DEV_REMOVE;
> +		}
> +	}
> +
> +	/* Register device */
> +	data->class_dev = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
> +		goto EXIT_DEV_REMOVE_SILENT;
> +	}
> +
> +	return 0;
> +
> +EXIT_DEV_REMOVE:
> +	dev_err(&pdev->dev, "Sysfs interface creation failed (%d)\n", err);
> +EXIT_DEV_REMOVE_SILENT:
> +	vt1211_remove_sysfs(pdev);
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(data);
> +EXIT:
> +	return err;
> +}
> +
> +static int __devexit vt1211_remove(struct platform_device *pdev)
> +{
> +	struct vt1211_data *data = platform_get_drvdata(pdev);
> +
> +	hwmon_device_unregister(data->class_dev);
> +	vt1211_remove_sysfs(pdev);
> +	platform_set_drvdata(pdev, NULL);
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

You could use vt1211_driver.driver.name to avoid storing another copy
of the string.

> +	if (!pdev) {
> +		err = -ENOMEM;
> +		printk(KERN_ERR DRVNAME ": Device allocation failed (%d)\n",
> +		       err);
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
> +
> +	superio_enter();
> +
> +	if (superio_inb(SIO_VT1211_DEVID) != SIO_VT1211_ID) {
> +		goto EXIT;
> +	}
> +
> +	superio_select(SIO_VT1211_LDN_HWMON);
> +
> +	if ((superio_inb(SIO_VT1211_ACTIVE) & 1) = 0) {
> +		printk(KERN_WARNING DRVNAME ": HW monitor is disabled, "
> +		       "skipping\n");
> +		goto EXIT;
> +	}
> +
> +	*address = ((superio_inb(SIO_VT1211_BADDR) << 8) |
> +		    (superio_inb(SIO_VT1211_BADDR + 1))) & 0xff00;
> +	if (*address = 0) {
> +		printk(KERN_WARNING DRVNAME ": Base address is not set, "
> +		       "skipping\n");
> +		goto EXIT;
> +	}
> +
> +	err = 0;
> +	printk(KERN_INFO DRVNAME ": Found VT1211 chip at 0x%04x, "
> +	       "revision %u\n", *address, superio_inb(SIO_VT1211_DEVREV));
> +
> +EXIT:
> +	superio_exit();
> +	return err;
> +}
> +
> +static int __init vt1211_init(void)
> +{
> +	int err;
> +	unsigned short address = 0;
> +
> +	err = vt1211_find(&address);
> +	if (err) {
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

Usually we omit the curly braces for these "if (err) goto error"
constructs, but it's up to you.

> +
> +	return 0;
> +
> +EXIT_DRV_UNREGISTER:
> +	platform_driver_unregister(&vt1211_driver);
> +EXIT:
> +	return err;
> +}
> +
> +static void __exit vt1211_exit(void)
> +{
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&vt1211_driver);
> +}
> +
> +MODULE_AUTHOR("Juerg Haefliger <juergh at gmail.com>");
> +MODULE_DESCRIPTION("VT1211 sensors");
> +MODULE_LICENSE("GPL");
> +
> +module_init(vt1211_init);
> +module_exit(vt1211_exit);
> diff -uprN -X linux-2.6.18-rc4-mm-vanilla/Documentation/dontdiff -x Documentation -x usr -x dwarf2-defs.h linux-2.6.18-rc4-mm-vanilla/include/linux/utsrelease.h linux-2.6.18-rc4-mm/include/linux/utsrelease.h
> --- linux-2.6.18-rc4-mm-vanilla/include/linux/utsrelease.h	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.18-rc4-mm/include/linux/utsrelease.h	2006-08-16 21:04:49.000000000 -0700
> @@ -0,0 +1 @@
> +#define UTS_RELEASE "2.6.18-rc4-mm1"

This shouldn't have been part of the patch!

General note: I wonder if messages printed on invalid user inputs
shouldn't be printed with dev_warn() instead of dev_err()? After all
they are not errors from the driver or hardware.

OK, we're almost there I think. All my comments above are quite minor.
I hope I didn't miss anything important. Please make the final
adjustments unless you disagree, and resubmit. Once we have the final
version of the driver we can modify the user-space side to match.

Thanks,
-- 
Jean Delvare

