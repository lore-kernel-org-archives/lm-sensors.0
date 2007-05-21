From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 May 2007 11:57:39 +0000
Subject: Re: [lm-sensors] hwmon/w83627hf pwm_freq support
Message-Id: <20070521135739.793a9825@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075.140.93.65.31.1179669141.squirrel@webmail.tinet.org>
In-Reply-To: <1075.140.93.65.31.1179669141.squirrel@webmail.tinet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Carlos,

On Sun, 20 May 2007 15:52:21 +0200 (CEST), Carlos Olalla Mart=EDnez wrote:
> Couldnt test it, but w83697hf was OK in 2.6.21.1; any tester with a w8362=
7hf?
>=20
> Signed-off-by: Carlos Olalla <com.ea@tinet.org>
> diff -uprN -X linux-2.6.22-rc1/Documentation/dontdiff
> linux-2.6.22-rc1.orig/drivers/hwmon/w83627hf.c
> linux-2.6.22-rc1/drivers/hwmon/w83627hf.c
> --- linux-2.6.22-rc1.orig/drivers/hwmon/w83627hf.c	2007-05-13
> 03:45:56.000000000 +0200
> +++ linux-2.6.22-rc1/drivers/hwmon/w83627hf.c	2007-05-19
> 18:31:55.000000000 +0200

You mailer wrapped long lines -> I can't apply your patch. Please
resend and make sure the patch will remain untouched so that I can
apply it.

> @@ -25,12 +25,12 @@
>  /*
>      Supports following chips:
>=20
> -    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
> -    w83627hf	9	3	2	3	0x20	0x5ca3	no	yes(LPC)
> -    w83627thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
> -    w83637hf	7	3	3	3	0x80	0x5ca3	no	yes(LPC)
> -    w83687thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
> -    w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
> +    Chip	#vin	#fanin	#pwm	#pwm_freq	#temp	wchipid	vendid	i2c	ISA
> +    w83627hf	9	3	2	2		3	0x20	0x5ca3	no	yes(LPC)
> +    w83627thf	7	3	3	X		3	0x90	0x5ca3	no	yes(LPC)
> +    w83637hf	7	3	3	3		3	0x80	0x5ca3	no	yes(LPC)
> +    w83687thf	7	3	3	3		3	0x90	0x5ca3	no	yes(LPC)
> +    w83697hf	8	2	2	2		2	0x60	0x5ca3	no	yes(LPC)

Huh, please don't touch this table. We don't list every possible
feature here, only the core properties.

>=20
>      For other winbond chips, and for i2c support in the above chips,
>      use w83781d.c.
> @@ -220,6 +220,25 @@ static const u8 regpwm[] =3D { W83627THF_R
>  #define W836X7HF_REG_PWM(type, nr) (((type) =3D w83627hf) ? \
>                                       regpwm_627hf[(nr) - 1] : regpwm[(nr)
> - 1])
>=20
> +#define W83627HF_REG_PWM_FREQ1		0x5C	/* Only for the 627HF */
> +#define W83627HF_REG_PWM_FREQ2		0x5C	/* Only for the 627HF */
> +
> +#define W83637HF_REG_PWM_FREQ1		0x00	/* 697HF/687THF too */
> +#define W83637HF_REG_PWM_FREQ2		0x02	/* 697HF/687THF too */
> +#define W83637HF_REG_PWM_FREQ3		0x10	/* 687THF too */
> +
> +/* 687thf uses DC output by default and 627thf only uses DC output.
> + PWMCLK is useless for DC output */
> +static const u8 regpwmfreq_627hf[] =3D { W83627HF_REG_PWM_FREQ1,
> W83627HF_REG_PWM_FREQ2 };
> +static const u8 regpwmfreq[] =3D { W83637HF_REG_PWM_FREQ1,
> W83637HF_REG_PWM_FREQ2,
> +				 W83637HF_REG_PWM_FREQ3 };
> +#define W836X7HF_REG_PWM_FREQ(type, nr) (((type) =3D w83627hf) ? \
> +                                     regpwmfreq_627hf[(nr) - 1] :
> regpwmfreq[(nr) - 1])

You're trying to put together things which are too different. The
W83627HF handles the PWM frequencies in a completely different way, so
there is no point in having a single macro to handle all the chips.
This makes things more complex with no benefit. In fact your current
code even ends up reading the same register twice for the W83627HF -
that's inefficient.

So I suggest that you simply define:

#define W83627HF_REG_PWM_FREQ		0x5C			/* Only for the 627HF */
static const u8 W83637HF_REG_PWM_FREQ =3D { 0x00, 0x02, 0x10 };	/* 697HF/68=
7THF too */

And use these directly in the code. This will be much more simple that
way.

> +
> +/* From manual 627hf -> 46870 Hz is the base,
> +	we take 46880 to avoid float results with divisors. */
> +#define W83627HF_DEFAULT_PWM_FREQ	46880

There are no floats in the kernel. Integer division will strip the
non-integer part for you. So just use 46870.

And the name is badly chosen, as the datasheet says that the default is
23.43 kHz. 46.87 kHz is more like the base PWM clock, or maximum
frequency.

> +
>  #define W83781D_REG_I2C_ADDR 0x48
>  #define W83781D_REG_I2C_SUBADDR 0x4A
>=20
> @@ -267,6 +286,49 @@ static int TEMP_FROM_REG(u8 reg)
>=20
>  #define PWM_TO_REG(val) (SENSORS_LIMIT((val),0,255))
>=20
> +static inline unsigned long pwm_freq_from_reg_627hf(u8 reg, int nr)
> +{
> +	unsigned long freq;
> +	/* bits 6..4 pwmclk2 (nr=3D2) .. bits 2..0 pwmclk1 (nr=3D1) */
> +	reg =3D (reg >> ((nr-1)*4)) & 0x07;
> +	freq =3D W83627HF_DEFAULT_PWM_FREQ/(2^reg);

Eek! 2^reg is NOT "2 at the power reg". ^ is the bitwise XOR operator.

This should be instead written:

	freq =3D W83627HF_DEFAULT_PWM_FREQ >> reg;

> +	return freq;
> +}
> +static inline u8 pwm_freq_to_reg_627hf(unsigned long val, int nr)
> +{
> +	u8 i;
> +	/* Only 5 dividers (1 2 4 8 16)... Search for the nearest available
> frequency */
> +	for (i =3D 0; i < 5; i++) {
> +		if (val > (W83627HF_DEFAULT_PWM_FREQ/(2^i) +
> W83627HF_DEFAULT_PWM_FREQ/(2^(i+1))) / 2)

Again this isn't correct and should be written >> i and >> (i + 1).

> +			break;
> +	}
> +	return (i << ((nr-1)*4));
> +}
> +
> +static inline unsigned long pwm_freq_from_reg(u8 reg)
> +{
> +	/* Clock bit 8 -> 180 kHz or 24 MHz */
> +	unsigned long clock =3D (reg & 0x80) ? 180000UL : 24000000UL;
> +
> +	reg &=3D 0x7f;
> +	/* This should not happen but anyway... */
> +	if (reg =3D 0)
> +		reg++;
> +	return clock / ( reg << 8 );
> +}
> +static inline u8 pwm_freq_to_reg(unsigned long val)
> +{
> +	/* Minimum divider value is 0x01 and maximum is 0x7F */
> +	if (val >=3D 93750)	/* The highest we can do */
> +		return 0x01;
> +	if (val >=3D 738)	/* Use 24 MHz clock */

Should be > 720, so that values between 703 (highest with 180 kHz
clock) and 738 (lowest with 24 MHz clock) are redirected to the nearest
possible value.

> +		return (24000000UL / (val << 8));
> +	if (val < 6)		/* The lowest we can do */
> +		return 0xFF;
> +	else			/* Use 180 kHz clock */
> +		return 0x80 | (180000UL / (val << 8));
> +}
> +
>  #define BEEP_MASK_FROM_REG(val)		 (val)
>  #define BEEP_MASK_TO_REG(val)		((val) & 0xffffff)
>  #define BEEP_ENABLE_TO_REG(val)		((val)?1:0)
> @@ -316,6 +378,7 @@ struct w83627hf_data {
>  	u32 beep_mask;		/* Register encoding, combined */
>  	u8 beep_enable;		/* Boolean */
>  	u8 pwm[3];		/* Register value */
> +	u8 pwm_freq[3];		/* Register value */
>  	u16 sens[3];		/* 782D/783S only.
>  				   1 =3D pentium diode; 2 =3D 3904 diode;
>  				   3000-5000 =3D thermistor beta.
> @@ -852,6 +915,61 @@ sysfs_pwm(2);
>  sysfs_pwm(3);
>=20
>  static ssize_t
> +show_pwm_freq_reg(struct device *dev, char *buf, int nr)
> +{
> +	struct w83627hf_data *data =3D w83627hf_update_device(dev);
> +//	return sprintf(buf, "%ld\n", (long) data->pwm_freq[nr - 1]);

Please clean up your code before sending patches.

> +	if (data->type =3D w83627hf)
> +		return sprintf(buf, "%ld\n",
> pwm_freq_from_reg_627hf(data->pwm_freq[nr-1],nr));
> +	else
> +		return sprintf(buf, "%ld\n", pwm_freq_from_reg(data->pwm_freq[nr-1]));
> +}
> +
> +static ssize_t
> +store_pwm_freq_reg(struct device *dev, const char *buf, size_t count, int
> nr)
> +{
> +	struct w83627hf_data *data =3D dev_get_drvdata(dev);
> +	u32 val;
> +	u8 mask[]=3D{0xF8, 0x8F};

static const.

> +
> +	val =3D simple_strtoul(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (data->type =3D w83627hf) {
> +		data->pwm_freq[nr - 1] =3D pwm_freq_to_reg_627hf(val,nr);
> +		w83627hf_write_value( data, regpwmfreq_627hf[nr - 1],
> +					data->pwm_freq[nr - 1] |
> +					(w83627hf_read_value(data,
> +					regpwmfreq_627hf[nr - 1]) & mask[nr - 1]) );

Coding style: no space inside parentheses.

> +	} else if ( (data->type =3D w83637hf) || (data->type =3D w83697hf) ||
> (data->type =3D w83687thf) ) {

This could be a simple "else".

> +		data->pwm_freq[nr - 1] =3D pwm_freq_to_reg(val);
> +		w83627hf_write_value(data, regpwmfreq[nr - 1],
> +					data->pwm_freq[nr - 1]);
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +#define sysfs_pwm_freq(offset) \
> +static ssize_t show_regs_pwm_freq_##offset (struct device *dev, struct
> device_attribute *attr, char *buf) \
> +{ \
> +	return show_pwm_freq_reg(dev, buf, offset); \
> +} \
> +static ssize_t \
> +store_regs_pwm_freq_##offset (struct device *dev, struct device_attribute
> *attr, const char *buf, size_t count) \
> +{ \
> +	return store_pwm_freq_reg(dev, buf, count, offset); \
> +} \
> +static DEVICE_ATTR(pwm##offset##_freq, S_IRUGO | S_IWUSR, \
> +		  show_regs_pwm_freq_##offset, store_regs_pwm_freq_##offset);
> +
> +sysfs_pwm_freq(1);
> +sysfs_pwm_freq(2);
> +sysfs_pwm_freq(3);
> +
> +static ssize_t
>  show_sensor_reg(struct device *dev, char *buf, int nr)
>  {
>  	struct w83627hf_data *data =3D w83627hf_update_device(dev);
> @@ -1044,6 +1162,8 @@ static struct attribute *w83627hf_attrib
>=20
>  	&dev_attr_pwm1.attr,
>  	&dev_attr_pwm2.attr,
> +	&dev_attr_pwm1_freq.attr,
> +	&dev_attr_pwm2_freq.attr,

These files shouldn't be created for the W83627THF, so they should go
to the optional attributes group.

>=20
>  	&dev_attr_name.attr,
>  	NULL
> @@ -1074,6 +1194,7 @@ static struct attribute *w83627hf_attrib
>  	&dev_attr_temp3_type.attr,
>=20
>  	&dev_attr_pwm3.attr,
> +	&dev_attr_pwm3_freq.attr,
>=20
>  	NULL
>  };
> @@ -1167,6 +1288,10 @@ static int __devinit w83627hf_probe(stru
>  		if ((err =3D device_create_file(dev, &dev_attr_pwm3)))
>  			goto ERROR4;
>=20
> +	if (data->type =3D w83637hf || data->type =3D w83687thf)
> +		if ((err =3D device_create_file(dev, &dev_attr_pwm3_freq)))
> +			goto ERROR4;
> +
>  	data->class_dev =3D hwmon_device_register(dev);
>  	if (IS_ERR(data->class_dev)) {
>  		err =3D PTR_ERR(data->class_dev);
> @@ -1470,6 +1595,14 @@ static struct w83627hf_data *w83627hf_up
>  			   (data->type =3D w83627hf || data->type =3D w83697hf))
>  				break;
>  		}
> +		for (i =3D 1; i <=3D 3; i++) {
> +			u8 tmp =3D w83627hf_read_value(data,
> +				W836X7HF_REG_PWM_FREQ(data->type, i));
> +			data->pwm_freq[i - 1] =3D tmp;

You don't need a temporary variable here.

> +			if(i =3D 2 &&
> +			   (data->type !=3D w83637hf || data->type !=3D w83687thf))
> +				break;
> +		}
>=20
>  		data->temp =3D w83627hf_read_value(data, W83781D_REG_TEMP(1));
>  		data->temp_max=20
Please address my comments, test and resubmit.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
