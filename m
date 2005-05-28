From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 28 May 2005 15:31:53 +0000
Subject: [lm-sensors] W83792 review
Message-Id: <20050528153200.4e00abbb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <429605CE.5060009@sh.cvut.cz>
In-Reply-To: <429605CE.5060009@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> I'm inviting other developers to check my objections I need to develop
> "review skill". - Thanks

OK, let's go. Everything I don't comment on, I agree with.

> > (2) I have not implemented the 0.5 degree to temperature2 and
> > temperature3, while the driver for linux-2.4 implemented this.
> 
> That is the reason temp1 has separate handling and variable? If so,
> please add the code. or better would be to fix existing code so it
> does not look so strange.

No, better would be to actually add the handling of the additional
resolution bit.

> > static inline u8
> > FAN_TO_REG(long rpm, int div)
> > {
> 
> I'm not sure, but I think it should be like
> 
> static inline u8 FAN_TO_REG(long rpm, int div)
> {

Both styles exist and seem to be accepted in the kernel tree.
CodingStyle doesn't mention that point, so I'd say it's fine and there
is no need for Chunhao to to change his code.

> > 	/* array of 2 pointers to subclients */
> > 	struct i2c_client *lm75[2];
> 
> The subclients are lm75 compatible? (I think so), but I'm not sure
> about the name...

Same we did in all other Winbond drivers. That's alright.

> > 	u8 temp_max_add[2];	/* Register value */
> > 	u8 temp_max_hyst_add[2];	/* Register value */
> 
> Big I and align too please

"Big I" ? :)

> > static ssize_t
> > show_pwmenable_reg(struct device *dev, char *buf, int nr)
> > {
> > 	struct w83792d_data *data = w83792d_update_device(dev);
> > 	long pwm_enable_tmp = 1;
> 
> Should be u32 instead?
> 
> > 	if (data->pwmenable[nr-1] = 0) {
> > 		pwm_enable_tmp = 1; /* manual mode */
> > 	} else if (data->pwmenable[nr-1] = 1) {
> > 		pwm_enable_tmp = 3; /* thermal cruise/Smart Fan I */
> > 	} else if (data->pwmenable[nr-1] = 2) {
> > 		pwm_enable_tmp = 2; /* Smart Fan II */
> > 	}
> > 	return sprintf(buf, "%ld\n", pwm_enable_tmp);
> > }

u32 or long doesn't make much difference when you only need to store
values from 0 to 2. Even an u8 would do.

Note that this function could be made more readable/compact/efficient by
using either a switch/case construct, or a PWM_ENABLE_FROM_REG macro or
inline function, or even a lookup table.

> > 	0xc0; fan_cfg_tmp = ((cfg4_tmp|cfg3_tmp)|cfg2_tmp)|cfg1_tmp;
> 
> Missing spaces
> fan_cfg_tmp = ((cfg4_tmp | cfg3_tmp) | cfg2_tmp) | cfg1_tmp;

And useless parentheses ;)

> > static ssize_t
> > show_sf2_level_reg(struct device *dev, char *buf, int nr, int index)
> > {
> > 	struct w83792d_data *data = w83792d_update_device(dev);
> > 	return sprintf(buf, "%ld\n",
> > 	(long)(((data->sf2_levels[index-1][nr])*100)/15));
> 
> Missing spaces

Also note that the (long) cast could (and should) be avoided.

> > 	/* A few vars need to be filled upon startup */
> > 	for (i = 1; i <= 7; i++) {
> > 		data->fan_min[i - 1] = w83792d_read_value(new_client,
> > 					W83792D_REG_FAN_MIN[i]);
> > 	}
> 
> hmm really? why not it init_client?

The purpose of init_client is to initialize the chip. These lines
initalize the cache on driver side, so it's different. I think all
drivers currently do exactly what Chunhao does and it looks OK to me.

Good work Rudolf, most of your points were valid. Good review :)

-- 
Jean Delvare
