From: Herbert Poetzl <herbert@13thfloor.at>
Date: Thu, 02 Oct 2008 12:59:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: LM96000 support
Message-Id: <20081002125927.GD1173@MAIL.13thfloor.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081002142217.07c93a17@hyperion.delvare>
In-Reply-To: <20081002142217.07c93a17@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 02, 2008 at 02:22:17PM +0200, Jean Delvare wrote:
> Hi Herbert,
> 
> Wrong mailing list, redirecting to the correct one.
> 
> On Wed, 1 Oct 2008 20:52:35 +0200, Herbert Poetzl wrote:
> > this patch adds proper support for LM96000 (at least
> > the version I could test with) and provides some
> > 'generic' control of the tachometer monitor mode for
> > lm85/lm96000 pwm control.
> 
> Ideally this would be 2 separate patches.

okay

> > please consider for (mainline) inclusion!
> > 
> > TIA,
> > Herbert
> > 
> > Signed-off-by: Herbert Poetzl <herbert@13thfloor.at>
> > 
> > diff -NurpP --minimal linux-2.6.27-rc8-khali/Documentation/hwmon/lm85 linux-2.6.27-rc8-khali-lm96k-v0.1/Documentation/hwmon/lm85
> > --- linux-2.6.27-rc8-khali/Documentation/hwmon/lm85	2008-10-01 19:39:51.000000000 +0200
> > +++ linux-2.6.27-rc8-khali-lm96k-v0.1/Documentation/hwmon/lm85	2008-10-01 20:39:01.000000000 +0200
> > @@ -189,6 +189,22 @@ Configuration choices:
> >       -1    PWM always 100%  (full on)
> >       -2    Manual control (write to 'pwm#' to set)
> >  
> > +* PWM Tachometer Monitor Mode
> 
> You could add that this applies to the LM85 and LM96000 only.

does it?
haven't checked for all other LM85 clones, but
as the basic LM85 supports it, maybe others do
too?

will do some research there, when time permits

> > +
> > +* pwm#_tmm - controls the monitor mode for pwm#
> 
> I'm not convinced that this is the correct name. 

well, tachometer_monitor_mode seemed too long, and
tacho_mm was as unintuitive as tmm, while monitor_mode
might be fine, but maybe misleading, see next point

> These registers mainly affect the fan speed measurement, 
> not control (thus the name: Tachometer Monitor Mode), 
> even though mode 2 will have an effect on the PWM duty 
> cycle as well. So, shouldn't these files be rather named
> fan#_tmm?

nope, the TMM is per PWM unit, so while there are 
4 fans, they are only controlled by three PWM units
and each unit can set the TMM independantly, so
fan 3 and 4 are controlled with the same TMM bits

> > +Configuration choices:
> > +
> > +   Value     Meaning                                 <min
> > +  ------  ----------------------------------------  ------
> > +      0    Traditional tach input monitor             any   
> > +      1    Traditional tach input monitor            FFFFh
> > +      2    Most accurate readings                    FFFFh
> > +      3    Least effect on programmed PWM of Fan     FFFFh
> > +
> > +In the default setting, you will get false readings when under 
> > +minimum detctable RPM, in all other modes FFFFh.
> 
> Mode 0 seems a bit silly to me. 
> Shouldn't we automatically switch the chip to mode 1 
> when we find it in mode 0 (and high-frequency PWM isn't
> in use)?

I'm fine with auto adjusting the TMM, IMHO mode 2
would be the best choice for defaults, and it doesn't
hurt for high freq pwm to set it, as it is ignored
there ...

> >  The National LM85's have two vendor specific configuration
> >  features. Tach. mode and Spinup Control. For more details on these,
> >  see the LM85 datasheet or Application Note AN-1260. These features
> 
> Later on, the document says that the tachometer mode isn't 
> supported by the driver. You should change this, as it is now.

obviously missed that one :)

> > diff -NurpP --minimal linux-2.6.27-rc8-khali/drivers/hwmon/lm85.c linux-2.6.27-rc8-khali-lm96k-v0.1/drivers/hwmon/lm85.c
> > --- linux-2.6.27-rc8-khali/drivers/hwmon/lm85.c	2008-10-01 19:39:51.000000000 +0200
> > +++ linux-2.6.27-rc8-khali-lm96k-v0.1/drivers/hwmon/lm85.c	2008-10-01 20:29:25.000000000 +0200
> > @@ -39,7 +39,8 @@
> >  static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
> >  
> >  /* Insmod parameters */
> > -I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm1027, adt7463, emc6d100, emc6d102);
> > +I2C_CLIENT_INSMOD_7(lm85b, lm85c, lm96000, adm1027, adt7463, emc6d100,
> > +		    emc6d102);
> >  
> >  /* The LM85 registers */
> >  
> > @@ -67,6 +68,7 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102
> >  #define	LM85_VERSTEP_GENERIC		0x60
> >  #define	LM85_VERSTEP_LM85C		0x60
> >  #define	LM85_VERSTEP_LM85B		0x62
> > +#define	LM85_VERSTEP_LM96000		0x69
> 
> What about 0x68? 
> We've seen LM96000 chips with this device ID already,
> so we should support it.

I'm fine with adding that too, but I do not have
any hardware to test this on, all LM96000 I have
use the 0x69 id, but we might consider masking
off the lower 3 bits, as they are used for version
stepping only (On LM96000 that is)

> >  #define	LM85_VERSTEP_ADM1027		0x60
> >  #define	LM85_VERSTEP_ADT7463		0x62
> >  #define	LM85_VERSTEP_ADT7463C		0x6A
> > @@ -91,6 +93,8 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102
> >  #define	LM85_REG_AFAN_HYST1		0x6d
> >  #define	LM85_REG_AFAN_HYST2		0x6e
> >  
> > +#define	LM85_REG_TACHO_MON_MODE		0x74
> > +
> >  #define	ADM1027_REG_EXTEND_ADC1		0x76
> >  #define	ADM1027_REG_EXTEND_ADC2		0x77
> >  
> > @@ -185,11 +189,16 @@ static int RANGE_TO_REG(int range)
> >  #define RANGE_FROM_REG(val)	lm85_range_map[(val) & 0x0f]
> >  
> >  /* These are the PWM frequency encodings */
> > -static const int lm85_freq_map[8] = { /* 1 Hz */
> > -	10, 15, 23, 30, 38, 47, 62, 94
> 
> Note: this 62 should actually be 61, as you did for the LM96000. I've
> fixed it in my code.

okay

> > +static const int lm85_freq_map[] = { /* 1 Hz */
> > +	10, 15, 23, 30, 38, 47, 62, 94, 0
> >  };
> > -static const int adm1027_freq_map[8] = { /* 1 Hz */
> > -	11, 15, 22, 29, 35, 44, 59, 88
> > +static const int lm96000_freq_map[] = { /* 1 Hz */
> > +	10, 15, 23, 30, 38, 47, 61, 94,
> > +	22500, 24000, 25700, 25700,
> > +	27700, 27700, 30000, 30000, 0
> > +};
> > +static const int adm1027_freq_map[] = { /* 1 Hz */
> > +	11, 15, 22, 29, 35, 44, 59, 88, 0
> >  };
> >  
> >  static int FREQ_TO_REG(const int *map, int freq)
> > @@ -197,7 +206,7 @@ static int FREQ_TO_REG(const int *map, i
> >  	int i;
> >  
> >  	/* Find the closest match */
> > -	for (i = 0; i < 7; ++i)
> > +	for (i = 0; map[i + 1]; i++)
> >  		if (freq <= (map[i] + map[i + 1]) / 2)
> >  			break;
> >  	return i;
> > @@ -205,7 +214,13 @@ static int FREQ_TO_REG(const int *map, i
> >  
> >  static int FREQ_FROM_REG(const int *map, u8 reg)
> >  {
> > -	return map[reg & 0x07];
> 
> Note that the masking wasn't needed, as it already happens in
> lm85_update_device().
> 
> > +	int i;
> > +
> > +	for (i = 0; map[i]; i++)
> > +		if (reg = i)
> > +			break;
> > +
> > +	return map[i];
> >  }
> 
> You are replacing an algorithm in constant time (O(1)) by a linear one
> (O(N)). This is no good, and can easily be avoided. You simply need to
> ensure that the value of "reg" is suitable for the map's size, this can
> be done by a simple masking in lm85_update_device().

yes, but we need different masks for the various
devices, will think about something there ...

> >  /* Since we can't use strings, I'm abusing these numbers
> > @@ -304,6 +319,7 @@ struct lm85_data {
> >  	u8 temp_ext[3];		/* Decoded values */
> >  	u8 in_ext[8];		/* Decoded values */
> >  	u8 vid;			/* Register value */
> > +	u8 tmm;			/* Register value */
> >  	u8 vrm;			/* VRM version */
> >  	u32 alarms;		/* Register encoding, combined */
> >  	struct lm85_autofan autofan[3];
> > @@ -327,6 +343,7 @@ static const struct i2c_device_id lm85_i
> >  	{ "lm85", any_chip },
> >  	{ "lm85b", lm85b },
> >  	{ "lm85c", lm85c },
> > +	{ "lm96000", lm96000 },
> >  	{ "emc6d100", emc6d100 },
> >  	{ "emc6d101", emc6d100 },
> >  	{ "emc6d102", emc6d102 },
> > @@ -567,7 +584,31 @@ static ssize_t set_pwm_freq(struct devic
> >  	data->pwm_freq[nr] = FREQ_TO_REG(data->freq_map, val);
> >  	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
> >  		(data->zone[nr].range << 4)
> > -		| data->pwm_freq[nr]);
> > +		| (data->pwm_freq[nr] & 0x0f));
> 
> Useless masking.
> 
> > +	mutex_unlock(&data->update_lock);
> > +	return count;
> > +}
> > +
> > +static ssize_t show_pwm_tmm(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	int nr = to_sensor_dev_attr(attr)->index;
> > +	struct lm85_data *data = lm85_update_device(dev);
> > +	return sprintf(buf, "%d\n", (data->tmm >> (2*nr)) & 3);
> > +}
> > +
> > +static ssize_t set_pwm_tmm(struct device *dev,
> > +		struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	int nr = to_sensor_dev_attr(attr)->index;
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct lm85_data *data = i2c_get_clientdata(client);
> > +	long val = simple_strtol(buf, NULL, 10);
> > +	int mask = 3 << (2*nr);
> 
> You should reject invalid values at this point.
> 
> BTW, the datasheet says that only mode 0 is valid for high frequency
> PWM modes. So I guess that the driver should enforce that, by forcing
> mode 0 and preventing non-zero values from being written when a high
> frequency is selected?

my tests showed that it doesn't matter what is written
there when in high-freq mode, so I think we have two
options here, each with their own advantage/disadvantage

1) set tmm to 0 when in high-freq mode
 advantages:
	- tmm will show the effective mode
 disadvantages:
	- tmm will changed on low->high(->low)
	- additional code in freq settings

2) handle tmm regardless of frequency
 advantages:
	- tmm will keep the setting when changing
	  low->high->low
	- no extra code required
 disadvantages:
	- tmm will show wrong values in high-freq mode

just let me know what you prefer

> > +	mutex_lock(&data->update_lock);
> > +	data->tmm = (data->tmm & ~mask) | ((val & 3) << (2*nr));
> > +	lm85_write_value(client, LM85_REG_TACHO_MON_MODE, data->tmm);
> >  	mutex_unlock(&data->update_lock);
> >  	return count;
> >  }
> > @@ -578,7 +619,9 @@ static SENSOR_DEVICE_ATTR(pwm##offset, S
> >  static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,	\
> >  		show_pwm_enable, set_pwm_enable, offset - 1);		\
> >  static SENSOR_DEVICE_ATTR(pwm##offset##_freq, S_IRUGO | S_IWUSR,	\
> > -		show_pwm_freq, set_pwm_freq, offset - 1)
> > +		show_pwm_freq, set_pwm_freq, offset - 1);		\
> > +static SENSOR_DEVICE_ATTR(pwm##offset##_tmm, S_IRUGO | S_IWUSR,		\
> > +		show_pwm_tmm, set_pwm_tmm, offset - 1)
> >  
> >  
> >  show_pwm_reg(1);
> > @@ -886,7 +929,7 @@ static ssize_t set_temp_auto_temp_min(st
> >  		TEMP_FROM_REG(data->zone[nr].limit));
> >  	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
> >  		((data->zone[nr].range & 0x0f) << 4)
> > -		| (data->pwm_freq[nr] & 0x07));
> > +		| (data->pwm_freq[nr] & 0x0f));
> 
> You might as well drop the masking altogether, it's useless.

okay, I'm fine with that, will solve the
O(1) problem above too

> >  /* Update temp_auto_hyst and temp_auto_off */
> >  	data->zone[nr].hyst = HYST_TO_REG(TEMP_FROM_REG(
> > @@ -929,7 +972,7 @@ static ssize_t set_temp_auto_temp_max(st
> >  		val - min);
> >  	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
> >  		((data->zone[nr].range & 0x0f) << 4)
> > -		| (data->pwm_freq[nr] & 0x07));
> > +		| (data->pwm_freq[nr] & 0x0f));
> 
> Same here.
> 
> >  	mutex_unlock(&data->update_lock);
> >  	return count;
> >  }
> > @@ -999,6 +1042,9 @@ static struct attribute *lm85_attributes
> >  	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
> >  	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
> >  	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
> > +	&sensor_dev_attr_pwm1_tmm.dev_attr.attr,
> > +	&sensor_dev_attr_pwm2_tmm.dev_attr.attr,
> > +	&sensor_dev_attr_pwm3_tmm.dev_attr.attr,
> >  
> >  	&sensor_dev_attr_in0_input.dev_attr.attr,
> >  	&sensor_dev_attr_in1_input.dev_attr.attr,
> > @@ -1145,6 +1191,9 @@ static int lm85_detect(struct i2c_client
> >  			case LM85_VERSTEP_LM85B:
> >  				kind = lm85b;
> >  				break;
> > +			case LM85_VERSTEP_LM96000:
> > +				kind = lm96000;
> > +				break;
> >  			}
> >  		} else if (company = LM85_COMPANY_ANALOG_DEV) {
> >  			switch (verstep) {
> > @@ -1193,6 +1242,9 @@ static int lm85_detect(struct i2c_client
> >  	case lm85c:
> >  		type_name = "lm85c";
> >  		break;
> > +	case lm96000:
> > +		type_name = "lm96000";
> > +		break;
> >  	case adm1027:
> >  		type_name = "adm1027";
> >  		break;
> > @@ -1237,6 +1289,9 @@ static int lm85_probe(struct i2c_client 
> >  	case emc6d102:
> >  		data->freq_map = adm1027_freq_map;
> >  		break;
> > +	case lm96000:
> > +		data->freq_map = lm96000_freq_map;
> > +		break;
> >  	default:
> >  		data->freq_map = lm85_freq_map;
> >  	}
> > @@ -1401,6 +1456,9 @@ static struct lm85_data *lm85_update_dev
> >  			    lm85_read_value(client, LM85_REG_PWM(i));
> >  		}
> >  
> > +		/* maybe restrict to LM85/LM96000? */
> > +		data->tmm = lm85_read_value(client, LM85_REG_TACHO_MON_MODE);
> 
> Yes, please restrict to the chips which have this register. SMBus
> access isn't cheap.

see research :)

> > +
> >  		data->alarms = lm85_read_value(client, LM85_REG_ALARM1);
> >  
> >  		if (data->type = emc6d100) {
> > @@ -1480,7 +1538,7 @@ static struct lm85_data *lm85_update_dev
> >  			data->autofan[i].config > >  			    lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));
> >  			val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));
> > -			data->pwm_freq[i] = val & 0x07;
> > +			data->pwm_freq[i] = val & 0x0f;
> 
> You could instead do:
> 			data->pwm_freq[i] = val & (data->type = lm96000 ? 0x0f : 0x07);
> 
> That way, you guarantee that the value is within the correct bounds for
> the pwm frequency map, so you can keep the original (fast) algorithm in
> FREQ_FROM_REG (just drop the useless masking there.)

if possible, I'd rather avoid that, because such
inline conditions get easily out of sync or cause
very strange issues when the tables are extended

I'd prefer to change the table layout once again
to contain the table length as first argument if
the limiting is required at all

best,
Herbert

> >  			data->zone[i].range = val >> 4;
> >  			data->autofan[i].min_pwm > >  			    lm85_read_value(client, LM85_REG_AFAN_MINPWM(i));
> 
> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
