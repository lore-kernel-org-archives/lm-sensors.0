From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 20 Aug 2006 13:50:07 +0000
Subject: [lm-sensors] [PATCH] Resubmit w83627hf.c pwm clock selection
Message-Id: <44E8688F.8070006@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Carlos,

Sorry for the delay, some of us had holiday and some of us had too much of other
work. We really like that someone has started to work on this.

> Sorry, I didnt follow the STANDARDS last time I send this patch.
> As you can see, its for the 2.6.17.3 kernel driver w83627hf.c

This time better. Let me check the rest.

I'm afraid we cannot accept the raw register writings. What we propose is:
All units should be in Hz

the sysfs name should be pwm1_freq, pwm2_freq

So PWM frequency = (Input Clock / Pre-scale) / 256
(it seems that 256 has fixed divisor? - this seems wrong)

So for the w83697hf allow anything from 180Khz/127 to 180KHz/1 and from
24Mhz/127 to 24Mhz/1 (in Hz unit)

For w83627hf just allow this:
 <2:0> = 000: 46.87KHz
<2:0> = 001: 23.43KHz (Default)
<2:0> = 010: 11.72KHz
<2:0> = 011: 5.85KHz
<2:0> = 100: 2.93KHz

If the value is in between or bigger/smaller then default to nearest defined
frequency.

We will need update to the documentation file too (as the separate patch).

Similar will apply to other chips when implemented.

Some very brief review will follow, so you know what else needs to be fixed.

> From: Carlos Olalla  <com.ea at tinet.org>
> 
> filename=hwmon-w83627hf-add-pwm-support.patch
> 
> This patch adds support for pwm clock selection and pwm clock scaling
> for the w83627hf and the w83697hf hardware monitors, both supported by this driver.
> 
> Signed-off-by: Carlos Olalla <com.ea at tinet.org>
> 
> ---
> 
> --- linux-2.6.17.3/drivers/hwmon/w83627hf.c.orig	2006-07-08 20:43:42.000000000 +0200
> +++ linux-2.6.17.3/drivers/hwmon/w83627hf.c	2006-07-05 17:43:31.000000000 +0200
> @@ -219,6 +219,15 @@ static const u8 regpwm[] = { W83627THF_R
>                               W83627THF_REG_PWM3 };
>  #define W836X7HF_REG_PWM(type, nr) (((type) = w83627hf) ? \
>                                       regpwm_627hf[(nr) - 1] : regpwm[(nr) - 1])
> +					 
Extra tabs the line should be empty
> +#define W83697HF_REG_PWMCLK1	0x00	/* Only for the 697HF */
> +#define W83697HF_REG_PWMCLK2	0x02	/* Only for the 697HF */
> +		 
Extra tabs the line should be empty
> +static const u8 reg_pwmclk_697hf[] = {W83697HF_REG_PWMCLK1, W83697HF_REG_PWMCLK2};
perhaps a space = { W83...  CLK2 };
> +							 
extra tabs and spaces
> +#define W83627HF_REG_PWMCLK12	0x5C	/* Only for the 627HF */
> +
> +// To do : w83627thf, w83637hf and w83687thf pwmclk support

Sorry // comments are not allowed (see CodingStyle document in Documentation/)

Are you sure that other chips has different

>  #define W83781D_REG_I2C_ADDR 0x48
>  #define W83781D_REG_I2C_SUBADDR 0x4A
> @@ -319,6 +328,7 @@ struct w83627hf_data {
>  	u32 beep_mask;		/* Register encoding, combined */
>  	u8 beep_enable;		/* Boolean */
>  	u8 pwm[3];		/* Register value */
> +	u8 pwmclk[3];		/* Register value */
>  	u16 sens[3];		/* 782D/783S only.
>  				   1 = pentium diode; 2 = 3904 diode;
>  				   3000-5000 = thermistor beta.
> @@ -901,6 +911,68 @@ device_create_file(&client->dev, &dev_at
>  } while (0)
>  
>  static ssize_t
> +show_pwmclk_reg(struct device *dev, char *buf, int nr)
> +{
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%ld\n", (long) data->pwmclk[nr - 1]);
> +}
> +
> +static ssize_t
> +store_pwmclk_reg(struct device *dev, const char *buf, size_t count, int nr)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct w83627hf_data *data = i2c_get_clientdata(client);
> +	u32 val;
> +
> +	val = simple_strtoul(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (data->type = w83627hf) {
> +		/* bits 7 and 3 are reserved */
> +		data->pwmclk[nr - 1] = PWM_TO_REG(val) & 0x77;
> +		/* bits 6..4 pwmclk2 .. bits 2..0 pwmclk1 */
> +		w83627hf_write_value(client,
> +				     W83627HF_REG_PWMCLK12,
> +				     data->pwmclk[nr - 1] |
> +				     (w83627hf_read_value(client,
> +				     W83627HF_REG_PWMCLK12) & 0x88)); 
> +	} else  if (data->type = w83697hf) {
> +		data->pwmclk[nr - 1] = PWM_TO_REG(val);

Here would be 0 allowed and I think 0 should not be allowed.

> +		w83627hf_write_value(client,
> +				     reg_pwmclk_697hf[nr - 1],
> +				     data->pwmclk[nr - 1]);
> +	} else  {
> +		/* TODO w83627thf, w83637hf and w83687thf */
> +	}

This TODO and else { cannot be there.

> +
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +#define sysfs_pwmclk(offset) \
> +static ssize_t show_regs_pwmclk_##offset (struct device *dev, struct device_attribute *attr, char
> *buf) \
> +{ \
> +	return show_pwmclk_reg(dev, buf, offset); \
> +} \
> +static ssize_t \
> +store_regs_pwmclk_##offset (struct device *dev, struct device_attribute *attr, const char *buf,
> size_t count) \
> +{ \
> +	return store_pwmclk_reg(dev, buf, count, offset); \
> +} \
> +static DEVICE_ATTR(pwmclk##offset, S_IRUGO | S_IWUSR, \
> +		  show_regs_pwmclk_##offset, store_regs_pwmclk_##offset);
> +
> +sysfs_pwmclk(1);
> +sysfs_pwmclk(2);
> +// sysfs_pwmclk(3); /* TODO w83627thf, w83637hf and w83687thf */
> +

I think you may use SENSOR_DEVICE_ATTR to pass the 1..2.. numbers more easily
 SENSOR_DEVICE_ATTR(pwm1_freq, S_IWUSR | S_IRUGO, show_pwm_freq, store_pwm_freq,
0), <- here you can pass 0 and you dont need nr - 1 anymore

This is also preferred method for new code. Then you need to group those
SENSOR_DEVICE_ATTR to array of pointers and not to array of structures as all
other hwmon drivers do. I think Mark is working on conversion.

Check the pca9539.c for details please, how to declare it.

If you have more questions, just ask please.

Regards
Rudolf

