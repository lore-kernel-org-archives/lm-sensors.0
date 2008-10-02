From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 02 Oct 2008 15:24:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: LM96000 support
Message-Id: <20081002172447.1aa65501@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081002142217.07c93a17@hyperion.delvare>
In-Reply-To: <20081002142217.07c93a17@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Herbert,

On Thu, 2 Oct 2008 14:59:27 +0200, Herbert Poetzl wrote:
> On Thu, Oct 02, 2008 at 02:22:17PM +0200, Jean Delvare wrote:
> > On Wed, 1 Oct 2008 20:52:35 +0200, Herbert Poetzl wrote:
> > > diff -NurpP --minimal linux-2.6.27-rc8-khali/Documentation/hwmon/lm85 linux-2.6.27-rc8-khali-lm96k-v0.1/Documentation/hwmon/lm85
> > > --- linux-2.6.27-rc8-khali/Documentation/hwmon/lm85	2008-10-01 19:39:51.000000000 +0200
> > > +++ linux-2.6.27-rc8-khali-lm96k-v0.1/Documentation/hwmon/lm85	2008-10-01 20:39:01.000000000 +0200
> > > @@ -189,6 +189,22 @@ Configuration choices:
> > >       -1    PWM always 100%  (full on)
> > >       -2    Manual control (write to 'pwm#' to set)
> > >  
> > > +* PWM Tachometer Monitor Mode
> > 
> > You could add that this applies to the LM85 and LM96000 only.
> 
> does it?
> haven't checked for all other LM85 clones, but
> as the basic LM85 supports it, maybe others do
> too?
> 
> will do some research there, when time permits

At least the EMC6D102 has different registers (0x90-0x93) for the same
purpose, and no registers 0x74-0x76.

> > > +
> > > +* pwm#_tmm - controls the monitor mode for pwm#
> > 
> > I'm not convinced that this is the correct name. 
> 
> well, tachometer_monitor_mode seemed too long, and
> tacho_mm was as unintuitive as tmm, while monitor_mode
> might be fine, but maybe misleading, see next point

I have no problem with "tmm". Users will have to read the documentation
to find out what to write there anyway.

> > These registers mainly affect the fan speed measurement, 
> > not control (thus the name: Tachometer Monitor Mode), 
> > even though mode 2 will have an effect on the PWM duty 
> > cycle as well. So, shouldn't these files be rather named
> > fan#_tmm?
> 
> nope, the TMM is per PWM unit, so while there are 
> 4 fans, they are only controlled by three PWM units
> and each unit can set the TMM independantly, so
> fan 3 and 4 are controlled with the same TMM bits

Well, it's a bit more complex than that. TMM assumes that the
connection between tachometers and PWM outputs is known. So TMM is
actually per {PWM unit and all tachometers for fans controlled by it},
which admittedly isn't that easy to express in a file name ;)

But I won't argue anyway. The name is not a standard one so I don't
want to spend too much time discussing it.

> > > +Configuration choices:
> > > +
> > > +   Value     Meaning                                 <min
> > > +  ------  ----------------------------------------  ------
> > > +      0    Traditional tach input monitor             any   
> > > +      1    Traditional tach input monitor            FFFFh
> > > +      2    Most accurate readings                    FFFFh
> > > +      3    Least effect on programmed PWM of Fan     FFFFh
> > > +
> > > +In the default setting, you will get false readings when under 
> > > +minimum detctable RPM, in all other modes FFFFh.
> > 
> > Mode 0 seems a bit silly to me. 
> > Shouldn't we automatically switch the chip to mode 1 
> > when we find it in mode 0 (and high-frequency PWM isn't
> > in use)?
> 
> I'm fine with auto adjusting the TMM, IMHO mode 2
> would be the best choice for defaults, and it doesn't
> hurt for high freq pwm to set it, as it is ignored
> there ...

The problem is that modes 2 and 3 require that the connections between
the PWM and tachometers are as expected by the chip. Unfortunately
there is no guarantee that the motherboard manufacturers will respect
that.

Also, when the connections are correct, there is a choice to make
between mode 2 (most accurate speed values) and mode 3 (better speed
control). Only the users know what they prefer for their own setup. Not
that it seems to make too much of a difference in practice though.

> > > @@ -67,6 +68,7 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102
> > >  #define	LM85_VERSTEP_GENERIC		0x60
> > >  #define	LM85_VERSTEP_LM85C		0x60
> > >  #define	LM85_VERSTEP_LM85B		0x62
> > > +#define	LM85_VERSTEP_LM96000		0x69
> > 
> > What about 0x68? 
> > We've seen LM96000 chips with this device ID already,
> > so we should support it.
> 
> I'm fine with adding that too, but I do not have
> any hardware to test this on, all LM96000 I have
> use the 0x69 id, but we might consider masking
> off the lower 3 bits, as they are used for version
> stepping only (On LM96000 that is)

This makes sense. If National Semiconductor ever produces a chip with,
say, ID 0x6a, that would either be the next iteration of the LM96000,
or hopefully a backwards-compatible chip.

> > > +static ssize_t set_pwm_tmm(struct device *dev,
> > > +		struct device_attribute *attr, const char *buf, size_t count)
> > > +{
> > > +	int nr = to_sensor_dev_attr(attr)->index;
> > > +	struct i2c_client *client = to_i2c_client(dev);
> > > +	struct lm85_data *data = i2c_get_clientdata(client);
> > > +	long val = simple_strtol(buf, NULL, 10);
> > > +	int mask = 3 << (2*nr);
> > 
> > You should reject invalid values at this point.
> > 
> > BTW, the datasheet says that only mode 0 is valid for high frequency
> > PWM modes. So I guess that the driver should enforce that, by forcing
> > mode 0 and preventing non-zero values from being written when a high
> > frequency is selected?
> 
> my tests showed that it doesn't matter what is written
> there when in high-freq mode, so I think we have two
> options here, each with their own advantage/disadvantage
> 
> 1) set tmm to 0 when in high-freq mode
>  advantages:
> 	- tmm will show the effective mode
>  disadvantages:
> 	- tmm will changed on low->high(->low)
> 	- additional code in freq settings
> 
> 2) handle tmm regardless of frequency
>  advantages:
> 	- tmm will keep the setting when changing
> 	  low->high->low
> 	- no extra code required
>  disadvantages:
> 	- tmm will show wrong values in high-freq mode
> 
> just let me know what you prefer

Or option 3: in show_pwm_tmm() check if high-freq mode, if yes return
0, if no return the value of the TMM register. That way we return the
correct value all the time. Or am I missing some issue this approach
would have?

> > > @@ -886,7 +929,7 @@ static ssize_t set_temp_auto_temp_min(st
> > >  		TEMP_FROM_REG(data->zone[nr].limit));
> > >  	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
> > >  		((data->zone[nr].range & 0x0f) << 4)
> > > -		| (data->pwm_freq[nr] & 0x07));
> > > +		| (data->pwm_freq[nr] & 0x0f));
> > 
> > You might as well drop the masking altogether, it's useless.
> 
> okay, I'm fine with that, will solve the
> O(1) problem above too

I don't think this is related to the problem in question. The masking
was useless even before your patch. data->pwm_freq[nr] is already
masked when reading it from the register or from the user input, so
masking it again each time we use is a no-op.

> > > @@ -1480,7 +1538,7 @@ static struct lm85_data *lm85_update_dev
> > >  			data->autofan[i].config > > >  			    lm85_read_value(client, LM85_REG_AFAN_CONFIG(i));
> > >  			val = lm85_read_value(client, LM85_REG_AFAN_RANGE(i));
> > > -			data->pwm_freq[i] = val & 0x07;
> > > +			data->pwm_freq[i] = val & 0x0f;
> > 
> > You could instead do:
> > 			data->pwm_freq[i] = val & (data->type = lm96000 ? 0x0f : 0x07);
> > 
> > That way, you guarantee that the value is within the correct bounds for
> > the pwm frequency map, so you can keep the original (fast) algorithm in
> > FREQ_FROM_REG (just drop the useless masking there.)
> 
> if possible, I'd rather avoid that, because such
> inline conditions get easily out of sync or cause
> very strange issues when the tables are extended

Still, this is the only technically correct way to do it. Otherwise you
are carrying data bits which may not make sense for a given chip type.
And I fail to see how this could go out-of-sync: you know how many
frequencies each chip type support, and this isn't going to change.

If you think it's safer, you can add a pwm_freq_mask field to struct
lm85_data and initialize it at the same time you initialize
data->freq_map.

> I'd prefer to change the table layout once again
> to contain the table length as first argument if
> the limiting is required at all

Either that, or keep the tables in their original form and add either
data->pwm_freq_mask or data->freq_map_size. The latter option has the
advantage that you can share the LM85 and LM96000 frequency tables.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
