From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: linux 2.6 port of adm1031
Message-Id: <20040620172105.2517f2fb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexandre,

Here are my comments about your adm1031 port:

> #define	ADM1031_CONF2_PWM2_ENABLE	0x02
There's a tabulation instead of a white space.

> #define TEMP_TO_REG(val)		((val < 0 ? ((val - 500) / 1000) & 0xff : \
> 					((val + 500) / 1000) & 0xff))

This isn't quite correct. "& 0xff" will not do anything. Better handle
out of limits cases first, or use SENSORS_LIMIT.

> +#define TEMP_FROM_REG(val)		(val * 1000)

Missing parentheses around val.

> #define FAN_DIV_TO_REG(val)		\
>             val = 8 ? 0xc0 :		\
>             val = 4 ? 0x80 :		\
>             val = 2 ? 0x40 :		\
>             val = 1 ? 0x00 :  0xFF

Having a macro for this doesn't make much sense IMHO, since have to
handle the error case after calling it anyway. It should be faster to
handle the whole thing in set_fan_div() directly.

> #define FAN_CHAN_TO_REG(val, reg)	\
>        ((reg & 0x1F) | ((val << 5) &  0xe0))

Parenthesis missing, extra white space. Use tabs for alignment (same for several other macros)!

> #define AUTO_TEMP_RANGE_FROM_REG(reg)	(5000 * (1<< ((reg)&0x7)))

Missing white space.

>      ((AUTO_TEMP_MIN_FROM_REG((reg)) - 5000))

Extra parentheses (two pairs).

> #define AUTO_TEMP_MAX_FROM_REG(reg)		\
>         AUTO_TEMP_RANGE_FROM_REG((reg)) +	\
>         AUTO_TEMP_MIN_FROM_REG((reg))

Here too.

> static int AUTO_TEMP_MAX_TO_REG(int val, int reg, int pwm)
> {
> 	int ret;
> 	int range = val - AUTO_TEMP_MIN_FROM_REG(reg);
> 
> 	range = ((val - AUTO_TEMP_MIN_FROM_REG(reg))*10)/(16 - pwm);
> 	ret = (((reg) & 0xf8) |
> 	       (((range) < 10000 ? 0 :
> 		 (range) < 20000 ? 1 :
> 		 (range) < 40000 ? 2 : (range) < 80000 ? 3 : 4) & 7));
> 	return ret;
> }

Here you don't need the parentheses around reg and range. It's not a
macro ;)

The "& 7" looks needless.

> 		if(data->conf1 & ADM1031_CONF1_AUTO_MODE){

Missing white spaces.

> #define fan_auto_channel_offset(offset)						\
> static ssize_t show_fan_auto_channel_##offset (struct device *dev, char *buf)	\
> {										\
>         return show_fan_auto_channel(dev, buf, 0x##offset - 1);			\
> }										\
> static ssize_t set_fan_auto_channel_##offset (struct device *dev,		\
>         const char *buf, size_t count)						\
> {										\
>         return set_fan_auto_channel(dev, buf, count, 0x##offset - 1);		\
> }										\
> static DEVICE_ATTR(auto_fan##offset##_channel, S_IRUGO | S_IWUSR,		\
> 		   show_fan_auto_channel_##offset,				\
>                    set_fan_auto_channel_##offset)

Tabs, tabs, tabs! ;) And there are several other places where you should
fix that. A good way to get rid of these is to search for "        "
(eight consecutive white spaces) in your text editor and check whether
they have to be replaced. Most will.

> static ssize_t show_auto_temp_off(struct device *dev, char *buf, int nr)
> {
> 	struct adm1031_data *data = adm1031_update_device(dev);
> 	return sprintf(buf, "%d\n", AUTO_TEMP_MIN_FROM_REG(data->auto_temp[nr])
> 		       - 5000);
> }

You have defined AUTO_TEMP_OFF_FROM_REG, so you could use it now.

> 	    (((val>>4) & 0xf) != 5)){

Missing white space.

> static int trust_fan_readings(struct adm1031_data *data, int chan)

I think I've simplified (and fixed) this function much in the 2.4
driver. Please take a look and do the same here.

> static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
> {
> 	struct adm1031_data *data = adm1031_update_device(dev);
> 	int tmp;
> 	tmp =  FAN_FROM_REG(data->fan_min[nr],
> 			    FAN_DIV_FROM_REG(data->fan_div[nr]));
> 	return sprintf(buf, "%d\n",tmp);
> }

You don't really need a temporary variable here, do you?

> 	val = simple_strtol(buf, NULL, 10);
> 	if (val) {
> 		int tmp;
> 		tmp = FAN_TO_REG(val, FAN_DIV_FROM_REG(data->fan_div[nr]));
> 		data->fan_min[nr] = tmp > 255 ? 255 : tmp;
> 	} else {
> 		data->fan_min[nr] = 0xff;
> 	}

Can't you embed everyting in FAN_TO_REG? It's a pity to define a macro
and then have so much additional tests to do "manually" as you call it.

> static ssize_t
> set_temp_min(struct device *dev, const char *buf, size_t count, int nr)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct adm1031_data *data = i2c_get_clientdata(client);
> 	int val;
> 
> 	down(&data->update_lock);
> 	val = simple_strtol(buf, NULL, 10);
> 	val = SENSORS_LIMIT(val, -55000, 128000);
> 	data->temp_min[nr] = TEMP_TO_REG(val);
> 	adm1031_write_value(client, ADM1031_REG_TEMP_MIN(nr),
> 			    data->temp_min[nr]);
> 	up(&data->update_lock);
> 	return count;
> }

Don't hold the lock before you actually need it. Max temp is 127750
(127875 for external channels), not 128000. Same in set_temp_max and
set_temp_crit.

> static DEVICE_ATTR(pwm_invert, S_IRUGO | S_IWUSR,
> 		   show_pwm_invert, set_pwm_invert);

Wasn't it supposed to be discarded?

> 		if (((id != 0x31) || (id != 0x30)) && (co != 0x41))
> 			goto exit_free;

That test looks bogus. The first condition ((id != 0x31) || (id !0x30)) is always true (id can't be both 0x30 and 0x31) so it actually
accept any chip from Analog Devices (co = 0x41). What about:
		if (!((id = 0x31 || id = 0x30) && co = 0x41))
			goto exit_free;

The 2.4 drivers will need to be fixed too.

>       exit_free:
> 	kfree(new_client);
>       exit:
> 	return err;

Please left-align labels.

> 		data->fan_div[0] > 		    adm1031_read_value(client, ADM1031_REG_FAN_DIV(0));
> 		data->fan_min[0] > 		    adm1031_read_value(client, ADM1031_REG_FAN_MIN(0));
> 		data->fan[0] > 		    adm1031_read_value(client, ADM1031_REG_FAN_SPEED(0));
> 		data->pwm[0] > 		    0xf & adm1031_read_value(client, ADM1031_REG_PWM);
> 		data->conf1 = adm1031_read_value(client, ADM1031_REG_CONF1);
> 
> 		data->conf2 = adm1031_read_value(client, ADM1031_REG_CONF2);
> 
> 		if (data->chip_type = adm1031) {
> 			data->fan_div[1] > 			    adm1031_read_value(client, ADM1031_REG_FAN_DIV(1));
> 			data->fan_min[1] > 			    adm1031_read_value(client, ADM1031_REG_FAN_MIN(1));
> 			data->fan[1] > 			    adm1031_read_value(client,
> 					       ADM1031_REG_FAN_SPEED(1));
> 			data->pwm[1] > 			    (0xf & (adm1031_read_value(client, ADM1031_REG_PWM)
> 				    >> 4));
> 
> 		}

You should be able to refactor code here.

The driver is in good shape and fully functional as far as I could see.
As soon as you'll have fixed all the points listed above, you should
send your patch to Greg KH for integration into his 2.6 tree. Don't
forget to sign the patch using a "Signed-off-by:" line.

Good work!

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
