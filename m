From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 May 2007 08:14:49 +0000
Subject: Re: [lm-sensors] hwmon/w83627hf pwm_freq support
Message-Id: <20070528101449.64e85fbd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075.140.93.65.31.1179669141.squirrel@webmail.tinet.org>
In-Reply-To: <1075.140.93.65.31.1179669141.squirrel@webmail.tinet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Carlos,

On Sat, 26 May 2007 14:55:19 +0200 (CEST), Carlos Olalla Mart=EDnez wrote:

> diff -uprN -X linux-2.6.22-rc1/Documentation/dontdiff linux-2.6.22-rc1.or=
ig/drivers/hwmon/w83627hf.c linux-2.6.22-rc1/drivers/hwmon/w83627hf.c
> --- linux-2.6.22-rc1.orig/drivers/hwmon/w83627hf.c	2007-05-13 03:45:56.00=
0000000 +0200
> +++ linux-2.6.22-rc1/drivers/hwmon/w83627hf.c	2007-05-26 14:45:05.0000000=
00 +0200
> @@ -220,6 +220,18 @@ static const u8 regpwm[] =3D { W83627THF_R
>  #define W836X7HF_REG_PWM(type, nr) (((type) =3D w83627hf) ? \
>                                       regpwm_627hf[(nr) - 1] : regpwm[(nr=
) - 1])
> =20
> +#define W83627HF_REG_PWM_FREQ		0x5C	/* Only for the 627HF */
> +
> +#define W83637HF_REG_PWM_FREQ1		0x00	/* 697HF/687THF too */
> +#define W83637HF_REG_PWM_FREQ2		0x02	/* 697HF/687THF too */
> +#define W83637HF_REG_PWM_FREQ3		0x10	/* 687THF too */
> +
> +static const u8 W83637HF_REG_PWM_FREQ[] =3D { W83637HF_REG_PWM_FREQ1,=20
> +					W83637HF_REG_PWM_FREQ2,=20
> +					W83637HF_REG_PWM_FREQ1 };

This should obviously be W83637HF_REG_PWM_FREQ3.

> +
> +#define W83627HF_BASE_PWM_FREQ	46870
> +
>  #define W83781D_REG_I2C_ADDR 0x48
>  #define W83781D_REG_I2C_SUBADDR 0x4A
> =20
> @@ -267,6 +279,47 @@ static int TEMP_FROM_REG(u8 reg)
> =20
>  #define PWM_TO_REG(val) (SENSORS_LIMIT((val),0,255))
> =20
> +static inline unsigned long pwm_freq_from_reg_627hf(u8 reg)
> +{
> +	unsigned long freq;
> +	freq =3D W83627HF_BASE_PWM_FREQ >> reg;
> +	return freq;
> +}
> +static inline u8 pwm_freq_to_reg_627hf(unsigned long val)
> +{
> +	u8 i;
> +	/* Only 5 dividers (1 2 4 8 16)... Search for the nearest available fre=
quency */
> +	for (i =3D 0; i < 5; i++) {
> +		if (val > (((W83627HF_BASE_PWM_FREQ >> i) + (W83627HF_BASE_PWM_FREQ >>=
 (i+1))) / 2))=20
> +			break;
> +	}
> +	return i;
> +}

This could return with i =3D 5, which isn't correct.

Also, line length is limited to 80, please fold the lines that are
longer than that. This applies to the rest of your patch too.

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
> +	return (clock / (reg << 8));
> +}
> +static inline u8 pwm_freq_to_reg(unsigned long val)
> +{
> +	/* Minimum divider value is 0x01 and maximum is 0x7F */
> +	if (val >=3D 93750)	/* The highest we can do */
> +		return 0x01;
> +	if (val >=3D 720)	/* Use 24 MHz clock */
> +		return (24000000UL / (val << 8));
> +	if (val < 6)		/* The lowest we can do */
> +		return 0xFF;
> +	else			/* Use 180 kHz clock */
> +		return (0x80 | (180000UL / (val << 8)));
> +}
> +
>  #define BEEP_MASK_FROM_REG(val)		 (val)
>  #define BEEP_MASK_TO_REG(val)		((val) & 0xffffff)
>  #define BEEP_ENABLE_TO_REG(val)		((val)?1:0)
> @@ -316,6 +369,7 @@ struct w83627hf_data {
>  	u32 beep_mask;		/* Register encoding, combined */
>  	u8 beep_enable;		/* Boolean */
>  	u8 pwm[3];		/* Register value */
> +	u8 pwm_freq[3];		/* Register value */=20
>  	u16 sens[3];		/* 782D/783S only.
>  				   1 =3D pentium diode; 2 =3D 3904 diode;
>  				   3000-5000 =3D thermistor beta.
> @@ -852,6 +906,59 @@ sysfs_pwm(2);
>  sysfs_pwm(3);
> =20
>  static ssize_t
> +show_pwm_freq_reg(struct device *dev, char *buf, int nr)
> +{
> +	struct w83627hf_data *data =3D w83627hf_update_device(dev);
> +	if (data->type =3D w83627hf)=20
> +		return sprintf(buf, "%ld\n", pwm_freq_from_reg_627hf(data->pwm_freq[nr=
 - 1]));
> +	else
> +		return sprintf(buf, "%ld\n", pwm_freq_from_reg(data->pwm_freq[nr - 1])=
);
> +}
> +
> +static ssize_t
> +store_pwm_freq_reg(struct device *dev, const char *buf, size_t count, in=
t nr)
> +{
> +	struct w83627hf_data *data =3D dev_get_drvdata(dev);
> +	static const u8 mask[]=3D{0xF8, 0x8F};
> +	u32 val;
> +
> +	val =3D simple_strtoul(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (data->type =3D w83627hf) {
> +		data->pwm_freq[nr - 1] =3D pwm_freq_to_reg_627hf(val);
> +		w83627hf_write_value(data, W83627HF_REG_PWM_FREQ,=20
> +					(data->pwm_freq[nr - 1] << ((nr - 1)*4)) |=20
> +					(w83627hf_read_value(data, W83627HF_REG_PWM_FREQ) & mask[nr - 1]));
> +	} else {
> +		data->pwm_freq[nr - 1] =3D pwm_freq_to_reg(val);
> +		w83627hf_write_value(data, W83637HF_REG_PWM_FREQ[nr - 1],
> +					data->pwm_freq[nr - 1]);
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +#define sysfs_pwm_freq(offset) \
> +static ssize_t show_regs_pwm_freq_##offset (struct device *dev, struct d=
evice_attribute *attr, char *buf) \
> +{ \
> +	return show_pwm_freq_reg(dev, buf, offset); \
> +} \
> +static ssize_t \
> +store_regs_pwm_freq_##offset (struct device *dev, struct device_attribut=
e *attr, const char *buf, size_t count) \
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
> @@ -1075,6 +1182,9 @@ static struct attribute *w83627hf_attrib
> =20
>  	&dev_attr_pwm3.attr,
> =20
> +	&dev_attr_pwm1_freq.attr,
> +	&dev_attr_pwm2_freq.attr,
> +	&dev_attr_pwm3_freq.attr,
>  	NULL
>  };
> =20
> @@ -1137,7 +1247,9 @@ static int __devinit w83627hf_probe(stru
>  		 || (err =3D device_create_file(dev, &dev_attr_in5_max))
>  		 || (err =3D device_create_file(dev, &dev_attr_in6_input))
>  		 || (err =3D device_create_file(dev, &dev_attr_in6_min))
> -		 || (err =3D device_create_file(dev, &dev_attr_in6_max)))
> +		 || (err =3D device_create_file(dev, &dev_attr_in6_max))
> +		 || (err =3D device_create_file(dev, &dev_attr_pwm1_freq))
> +		 || (err =3D device_create_file(dev, &dev_attr_pwm2_freq)))
>  			goto ERROR4;
> =20
>  	if (data->type !=3D w83697hf)
> @@ -1167,6 +1279,12 @@ static int __devinit w83627hf_probe(stru
>  		if ((err =3D device_create_file(dev, &dev_attr_pwm3)))
>  			goto ERROR4;
> =20
> +	if (data->type =3D w83637hf || data->type =3D w83687thf)
> +		if ((err =3D device_create_file(dev, &dev_attr_pwm1_freq))
> +		 || (err =3D device_create_file(dev, &dev_attr_pwm2_freq))
> +		 || (err =3D device_create_file(dev, &dev_attr_pwm3_freq)))
> +			goto ERROR4;
> +
>  	data->class_dev =3D hwmon_device_register(dev);
>  	if (IS_ERR(data->class_dev)) {
>  		err =3D PTR_ERR(data->class_dev);
> @@ -1470,6 +1588,22 @@ static struct w83627hf_data *w83627hf_up
>  			   (data->type =3D w83627hf || data->type =3D w83697hf))
>  				break;
>  		}
> +		if (data->type !=3D w83627thf) {
> +			if (data->type =3D w83627hf) {
> +					u8 tmp =3D w83627hf_read_value(data,=20
> +							W83627HF_REG_PWM_FREQ);
> +					data->pwm_freq[0] =3D tmp & 0x07;
> +					data->pwm_freq[1] =3D (tmp >> 4) & 0x07;
> +				}
> +			else {
> +				for (i =3D 1; i <=3D 3; i++) {
> +					data->pwm_freq[i - 1] =3D w83627hf_read_value(data,
> +								 W83637HF_REG_PWM_FREQ[i - 1]);
> +					if(i =3D 2 && (data->type =3D w83697hf))
> +						break;
> +				}
> +			}
> +		}

The type tests can be optimized:

		if (data->type =3D w83627hf) {
			(...)
		} else if (data->type !=3D w83627thf) {
			(...)
		}


> =20
>  		data->temp =3D w83627hf_read_value(data, W83781D_REG_TEMP(1));
>  		data->temp_max=20
Other than that, your patch looks good to me, thanks. Please provide an
updated version addressing the few remaining issues and I'll apply it.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
