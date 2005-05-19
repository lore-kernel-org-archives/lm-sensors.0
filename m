From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: ADM1030 Driver
Message-Id: <20040413195656.4ab65df5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

My comments inline.

> /* Many ADM1030 constants specified below */
> #define ADM1030_CONF1_MEN               0x01 /* monitoring enable */
> #define ADM1030_CONF1_AEN               0x80 /* Auto / SW Control */
> 
> #define ADM1030_REG_FAN_SPEED(nr)   	(0x08 + (nr))
> 
> #define ADM1030_REG_FAN_DIV(nr)		(0x20  + (nr))
> #define ADM1030_REG_FTAC(nr)		(0x10 + (nr))

ADM1030_REG_FAN_LOW or _MIN would be clearer.

> #define ADM1030_REG_FSP(nr)		(0x22 + (nr))

This is not correct, register 0x23 is something different. The normal
speed for fan 2 would obviously be stored in the upper nibble of the
same register. Also, the name isn't very explicit. I'd suggest
ADM1030_REG_FAN_NORMAL_SPEED.

> 
> 
> #define ADM1030_REG_TEMP_HLM(nr)		(0x14  + 4*(nr))
> #define ADM1030_REG_TEMP_LLM(nr)		(0x15  + 4*(nr))
> #define ADM1030_REG_TEMP_TLM(nr)		(0x16  + 4*(nr))

_HIGH, _LOW and (_THERM or _CRIT) prefered.


> /* Temperature values (nr = 1 (local) / 2 (remote)) */
> #define ADM1030_REG_TEMP(nr)		        (0xa + (nr))
> #define ADM1030_REG_TEMP_RNG(nr)		(0x24 + (nr))

RNG is a common acronym for "random number generator". You should use
"RANGE" instead, it's clearer IMHO.

> 
> /* Temperature values (nr = 1 (local) / 2 (remote)) */
> #define ADM1030_REG_CONF(nr)		        (nr)

Comment is bogus. And I don't see the point in using a parameter here,
since the two configuration registers have nothing in common. Just use
two defines.

I also note that the top macros use 0-1 for parameters, while the bottom
ones use 1-2. That's a bit confusing. Isn't it possible to tick to one
single convention?

You aren't taking advantage of the extended temperature resolution bits, are you?

> static u16 adm1030_fan_div = 1;

No. You should not need that, and it wouldn't be safe anymore for the
ADM1031 anyway (unless you declare a second variable). The correct way
to do it is that your to_display_fan_input() macro below should have two
parameters, not one. See asb100.c for a nice example.

> /* Each client has this additional data */
> struct adm1030_data {
>   struct semaphore	update_lock;
>   char			valid;		/* !=0 if following fields are valid */
>   unsigned int		last_updated;	/* In jiffies */
>   unsigned int		fan_input[1];
>   unsigned int	       	fan_div[1];
>   unsigned int	       	pwm[1];
>   unsigned int          temp_input[2];
>   unsigned int          temp_min[2];
>   unsigned int          temp_range[2];
>   unsigned int          temp_low_limit[2];
>   unsigned int          temp_high_limit[2];
>   unsigned int          temp_therm_limit[2];
> };

Indentation is broken.

> /* These macros converts registers values to sysfs-sensors compliant
>  * values
>  */
> #define to_display_temp_low_limit(reg) ((reg) * 1000)
> #define to_display_temp_high_limit(reg) ((reg) * 1000)
> #define to_display_temp_therm_limit(reg) ((reg) * 1000)
> #define to_display_temp_input(reg) ((reg) * 1000)
> #define to_display_temp_min(reg)   (1000 * ((((reg) >> 3) & 0x1f) << 2))
> #define to_display_temp_range(reg) (5000 * (1<<((reg)&0x07)))
> #define to_display_fan_input(reg)  ((reg) ? (11250 * 60) / ((reg)
> *               \
> 						    adm1030_fan_div) : 0)
> #define to_display_fan_div(reg)    (1 << (((reg) & 0xc0)>>6))
> #define to_display_pwm(reg)        ((reg)<<4)

Please use the usual names, see the other drivers for examples. Typical
names are TEMP_FROM_REG, TEMP_TO_REG, etc...

Do not define more macros than you need. For example, you obviously need
a single converter for temperature limits, don't define three.

> /* These macros converts sysfs-sensors compliant values into
>  * corresponding register value.
>  */
> #define to_reg_temp_min(reg, val) ((((val)/500) & 0xf8)|((reg) & 0x7))
> #define to_reg_temp_range(reg, val) (((reg) & 0xf8) | \
> (((val)<10000 ? 0 :                                   \
>   (val)<20000 ? 1 :                                   \
>   (val)<40000 ? 2 :                                   \
>   (val)<80000 ? 3 : 4) & 7))

It just me, or is this macro plain broken?

And usually, converters do not deal with the registers as you do. The
converters should return the "raw" values, and the caller can then
combine these with other values.

> static inline int to_reg_fan_div(unsigned int reg, unsigned int val) 
> {
>   adm1030_fan_div = val;
>   return ((reg & 0x3f) | 
> 	  ((val = 8 ? 0xc0 :                                            
> 	    val = 4 ? 0x80 :                                                
> 	    val = 2 ? 0x40 :                                                
> 	    val = 1 ? 0x00 : reg & 0xc0))); 
> }

Can be simplified.

> #define to_reg_pwm(reg, val) ((val) >> 4)
> #define to_reg_temp_low_limit(reg, val) ((val) / 1000)
> #define to_reg_temp_high_limit(reg, val) ((val) / 1000)
> #define to_reg_temp_therm_limit(reg, val) ((val) / 1000)

See my comments above (no register, no multiple macros doing the same thing).

> #define show(value, nr)	\
> static ssize_t show_##value##_##nr(struct device *dev, char *buf)		\
> {									\
> 	struct adm1030_data *data = adm1030_update_device(dev);		\
> 	return sprintf(buf, "%u\n", to_display_##value(data->value[(nr)-1]));	\
> }
> show(pwm, 1);
> show(temp_min, 1);
> show(temp_min, 2);
> show(temp_low_limit, 1);
> show(temp_low_limit, 2);
> show(temp_high_limit, 1);
> show(temp_high_limit, 2);
> show(temp_therm_limit, 1);
> show(temp_therm_limit, 2);
> show(temp_range, 1);
> show(temp_range, 2);
> show(temp_input, 1);
> show(temp_input, 2);
> show(fan_input, 1);
> show(fan_div, 1);
> 
> #define set(value, reg, nr)	\
> static ssize_t set_##value##_##nr(struct device *dev, const char *buf,
> size_t count)	\
> {								                \
> 	struct i2c_client *client = to_i2c_client(dev);		                \
> 	int temp = simple_strtoul(buf, NULL, 10);		                \
>         int old_val = adm1030_read_value(client,
> reg((nr)-1));                          \
> 	adm1030_write_value(client, reg((nr)-1), to_reg_##value(old_val,
> temp));	\
> 	return count;						                \
> }
> set(temp_min,   ADM1030_REG_TEMP_RNG, 1);
> set(temp_min,   ADM1030_REG_TEMP_RNG, 2);
> set(temp_range, ADM1030_REG_TEMP_RNG, 1);
> set(temp_range, ADM1030_REG_TEMP_RNG, 2);
> set(pwm,        ADM1030_REG_FSP,      1);
> set(fan_div,    ADM1030_REG_FAN_DIV,  1);

Now I get why you were defining multiple macros. You can just pass the
converter as an extra argument to set(). That said, some values will not
fit in that model anyway (set(fan_min...) for example, but strangely you
did not export it?)

> static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input_1, NULL);
> static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input_2, NULL);
> 
> static DEVICE_ATTR(pwm,         S_IWUSR | S_IRUGO, show_pwm_1,
> 		   set_pwm_1);

Incorrect name, should be pwm1.

> static DEVICE_ATTR(fan_div,     S_IRUGO | S_IWUSR, show_fan_div_1,
> 		   set_fan_div_1);

Incorrect name, should be fan1_div.

> static DEVICE_ATTR(fan_input,   S_IRUGO          , show_fan_input_1,   
> 		   NULL);

fan1_input.

Where is fan1_min?

> static DEVICE_ATTR(temp1_amin,   S_IRUGO | S_IWUSR, show_temp_min_1,    
> 		   set_temp_min_1);
> static DEVICE_ATTR(temp1_range, S_IRUGO | S_IWUSR, show_temp_range_1, 
> 		   set_temp_range_1);
> static DEVICE_ATTR(temp2_amin,   S_IRUGO | S_IWUSR, show_temp_min_2,    
> 		   set_temp_min_2);
> static DEVICE_ATTR(temp2_range, S_IRUGO | S_IWUSR, show_temp_range_2,  
> 		   set_temp_range_2);

BTW, what are these ones for? I don't understand why both thermal
sensors have these while there's a single fan to be controled anyway.

Also, I don't much like the names you chose, but you'd have to tell me a
bit more about what it is before I can come to the correct names.

> 	/* Now, we do the remaining detection. It is lousy. */

No, it is *NOT* lousy! (sorry to insist)

> static int adm1030_detach_client(struct i2c_client *client)
> {
> 	i2c_detach_client(client);
> 	kfree(client);
> 	return 0;
> }

You should check for error. The lm75 driver is a bad one and doesn't,
yet should. I think I already mentioned that. See any other chip driver
for an example of how to do it properly.

> 
> static int adm1030_read_value(struct i2c_client *client, u8 reg)
> {
>   return i2c_smbus_read_byte_data(client, reg);
> }
> 
> static int adm1030_write_value(struct i2c_client *client, u8 reg,
> unsigned int value)
> {
>   return i2c_smbus_write_byte_data(client, reg, value);
> }

You do not really need these, do you? At least inline them.

Two general comments/questions now:

1* How does bit 0 of configuration register 2 work? Maybe it could be
exported as pwm1_enable (if that's what it does).

2* I can clearly see that you are preparing the later adding of ADM1031
support. At this point, wouldn't it be easier to really support it? At
least we would protect ourselves against last time bad surprises. (And
if we extend the reasoning a little further, the driver should be named
adm1031, not adm1030, since the adm1030 is clearly a cut-down version of
the adm1031.)

Thanks.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
