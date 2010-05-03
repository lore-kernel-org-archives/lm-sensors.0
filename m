From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 03 May 2010 10:58:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asc7621) Bug fixes
Message-Id: <20100503125814.57138b78@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BDC27C4.2000205@kenm.demon.co.uk>
In-Reply-To: <4BDC27C4.2000205@kenm.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ken,

On Sat, 01 May 2010 14:08:20 +0100, Ken Milmore wrote:
> Find patch attached; this should apply against Linus' 2.6 tree. The 
> issues fixed here have all been discussed before on the lm_sensors list 
> (see 07/2008 and 04/2010), so hopefully they are uncontroversial.

Thanks for the patch. Review below.

> Having taken a brief look at the PWM control inteface in the driver, I 
> can see there are a few rough edges there but it is probably too late to 
> address them now.  In particular the pwm[1-3]_enable and 
> pwm[1-3]_auto_channels settings tend to interpret "Fan control disabled" 
> as "Fan off", which doesn't accord with the principle of least surprise, 
> or with the sysfs-interface documentation.  IMHO "Fan full on" would 
> have been a much safer default for these settings...

Indeed, and this is serious enough that I would take a patch fixing
that right now. Especially pwm[1-3]_enable = 0 MUST switch fans to
full speed, pwmconfig and fancontrol rely on this.

> From 5a9cc351ca11375a81082a06212ac45ac900b213 Mon Sep 17 00:00:00 2001
> From: Ken Milmore <ken.milmore@googlemail.com>
> Date: Sat, 1 May 2010 13:26:41 +0100
> Subject: [PATCH] hwmon: (asc7621) Bug fixes
> 
> * Allow fan minimum RPM to be set to zero without triggering alarms.
> * Fix voltage scaling arithmetic and correct scale factors.
> * Correct fan1-fan4 alarm bit shifts.
> * Correct register address for temp3_smoothing_enable.
> * Read the alarm registers with high priority.
> 
> Signed-off-by: Ken Milmore <ken.milmore@googlemail.com>
> ---
>  drivers/hwmon/asc7621.c |   63 +++++++++++++++++++++++------------------------
>  1 files changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
> index 7f94810..0f388ad 100644
> --- a/drivers/hwmon/asc7621.c
> +++ b/drivers/hwmon/asc7621.c
> @@ -268,8 +268,11 @@ static ssize_t store_fan16(struct device *dev,
>  	if (strict_strtol(buf, 10, &reqval))

It would make sense to use strtoul here instead. Negative fan speeds
make no sense.

>  		return -EINVAL;
>  
> +	/* If a minimum RPM of zero is requested, then we set the register to
> +	   0xffff. This value allows the fan to be stopped completely without
> +	   generating an alarm. */
>  	reqval > -	    (SENSORS_LIMIT((reqval) <= 0 ? 0 : 5400000 / (reqval), 0, 65534));
> +	    (reqval <= 0 ? 0xffff : SENSORS_LIMIT(5400000 / reqval, 0, 0xfffe));

And then this becomes = 0.

>  
>  	mutex_lock(&data->update_lock);
>  	data->reg[param->msb[0]] = (reqval >> 8) & 0xff;
> @@ -285,8 +288,9 @@ static ssize_t store_fan16(struct device *dev,
>   * Voltages are scaled in the device so that the nominal voltage
>   * is 3/4ths of the 0-255 range (i.e. 192).
>   * If all voltages are 'normal' then all voltage registers will
> - * read 0xC0.  This doesn't help us if we don't have a point of refernce.
> - * The data sheet however provides us with the full scale value for each
> + * read 0xC0.
> + *
> + * The data sheet provides us with the 3/4 scale value for each voltage
>   * which is stored in in_scaling.  The sda->index parameter value provides
>   * the index into in_scaling.
>   *
> @@ -295,7 +299,7 @@ static ssize_t store_fan16(struct device *dev,
>   */
>  
>  static int asc7621_in_scaling[] = {
> -	3320, 3000, 4380, 6640, 16000
> +	2500, 2250, 3300, 5000, 12000
>  };
>  
>  static ssize_t show_in10(struct device *dev, struct device_attribute *attr,
> @@ -306,19 +310,12 @@ static ssize_t show_in10(struct device *dev, struct device_attribute *attr,
>  	u8 nr = sda->index;
>  
>  	mutex_lock(&data->update_lock);
> -	regval = (data->reg[param->msb[0]] * asc7621_in_scaling[nr]) / 256;
> -
> -	/* The LSB value is a 2-bit scaling of the MSB's LSbit value.
> -	 * I.E.  If the maximim voltage for this input is 6640 millivolts then
> -	 * a MSB register value of 0 = 0mv and 255 = 6640mv.
> -	 * A 1 step change therefore represents 25.9mv (6640 / 256).
> -	 * The extra 2-bits therefore represent increments of 6.48mv.
> -	 */
> -	regval += ((asc7621_in_scaling[nr] / 256) / 4) *
> -	    (data->reg[param->lsb[0]] >> 6);
> -
> +	regval = (data->reg[param->msb[0]] << 8) | (data->reg[param->lsb[0]]);
>  	mutex_unlock(&data->update_lock);
>  
> +	/* The LSB value is a 2-bit scaling of the MSB's LSbit value. */
> +	regval = (regval >> 6) * asc7621_in_scaling[nr] / (0xc0 << 2);
> +

Looks much better :)

>  	return sprintf(buf, "%u\n", regval);
>  }
>  
> @@ -331,7 +328,7 @@ static ssize_t show_in8(struct device *dev, struct device_attribute *attr,
>  
>  	return sprintf(buf, "%u\n",
>  		       ((data->reg[param->msb[0]] *
> -			 asc7621_in_scaling[nr]) / 256));
> +			 asc7621_in_scaling[nr]) / 0xc0));
>  }
>  
>  static ssize_t store_in8(struct device *dev, struct device_attribute *attr,
> @@ -344,9 +341,11 @@ static ssize_t store_in8(struct device *dev, struct device_attribute *attr,
>  	if (strict_strtol(buf, 10, &reqval))
>  		return -EINVAL;
>  
> -	reqval = SENSORS_LIMIT(reqval, 0, asc7621_in_scaling[nr]);
> +	reqval = SENSORS_LIMIT(reqval, 0, 0xffff);

Do you really need this? There's another call to SENSORS_LIMIT() below,
I thought it would be enough.

> +
> +	reqval = reqval * 0xc0 / asc7621_in_scaling[nr];
>  
> -	reqval = (reqval * 255 + 128) / asc7621_in_scaling[nr];
> +	reqval = SENSORS_LIMIT(reqval, 0, 0xff);
>  
>  	mutex_lock(&data->update_lock);
>  	data->reg[param->msb[0]] = reqval;
> @@ -846,11 +845,11 @@ static struct asc7621_param asc7621_params[] = {
>  	PWRITE(in3_max, 3, PRI_LOW, 0x4b, 0, 0, 0, in8),
>  	PWRITE(in4_max, 4, PRI_LOW, 0x4d, 0, 0, 0, in8),
>  
> -	PREAD(in0_alarm, 0, PRI_LOW, 0x41, 0, 0x01, 0, bitmask),
> -	PREAD(in1_alarm, 1, PRI_LOW, 0x41, 0, 0x01, 1, bitmask),
> -	PREAD(in2_alarm, 2, PRI_LOW, 0x41, 0, 0x01, 2, bitmask),
> -	PREAD(in3_alarm, 3, PRI_LOW, 0x41, 0, 0x01, 3, bitmask),
> -	PREAD(in4_alarm, 4, PRI_LOW, 0x42, 0, 0x01, 0, bitmask),
> +	PREAD(in0_alarm, 0, PRI_HIGH, 0x41, 0, 0x01, 0, bitmask),
> +	PREAD(in1_alarm, 1, PRI_HIGH, 0x41, 0, 0x01, 1, bitmask),
> +	PREAD(in2_alarm, 2, PRI_HIGH, 0x41, 0, 0x01, 2, bitmask),
> +	PREAD(in3_alarm, 3, PRI_HIGH, 0x41, 0, 0x01, 3, bitmask),
> +	PREAD(in4_alarm, 4, PRI_HIGH, 0x42, 0, 0x01, 0, bitmask),
>  
>  	PREAD(fan1_input, 0, PRI_HIGH, 0x29, 0x28, 0, 0, fan16),
>  	PREAD(fan2_input, 1, PRI_HIGH, 0x2b, 0x2a, 0, 0, fan16),
> @@ -862,10 +861,10 @@ static struct asc7621_param asc7621_params[] = {
>  	PWRITE(fan3_min, 2, PRI_LOW, 0x59, 0x58, 0, 0, fan16),
>  	PWRITE(fan4_min, 3, PRI_LOW, 0x5b, 0x5a, 0, 0, fan16),
>  
> -	PREAD(fan1_alarm, 0, PRI_LOW, 0x42, 0, 0x01, 0, bitmask),
> -	PREAD(fan2_alarm, 1, PRI_LOW, 0x42, 0, 0x01, 1, bitmask),
> -	PREAD(fan3_alarm, 2, PRI_LOW, 0x42, 0, 0x01, 2, bitmask),
> -	PREAD(fan4_alarm, 3, PRI_LOW, 0x42, 0, 0x01, 3, bitmask),
> +	PREAD(fan1_alarm, 0, PRI_HIGH, 0x42, 0, 0x01, 2, bitmask),
> +	PREAD(fan2_alarm, 1, PRI_HIGH, 0x42, 0, 0x01, 3, bitmask),
> +	PREAD(fan3_alarm, 2, PRI_HIGH, 0x42, 0, 0x01, 4, bitmask),
> +	PREAD(fan4_alarm, 3, PRI_HIGH, 0x42, 0, 0x01, 5, bitmask),
>  
>  	PREAD(temp1_input, 0, PRI_HIGH, 0x25, 0x10, 0, 0, temp10),
>  	PREAD(temp2_input, 1, PRI_HIGH, 0x26, 0x15, 0, 0, temp10),
> @@ -886,10 +885,10 @@ static struct asc7621_param asc7621_params[] = {
>  	PWRITE(temp3_max, 2, PRI_LOW, 0x53, 0, 0, 0, temp8),
>  	PWRITE(temp4_max, 3, PRI_LOW, 0x35, 0, 0, 0, temp8),
>  
> -	PREAD(temp1_alarm, 0, PRI_LOW, 0x41, 0, 0x01, 4, bitmask),
> -	PREAD(temp2_alarm, 1, PRI_LOW, 0x41, 0, 0x01, 5, bitmask),
> -	PREAD(temp3_alarm, 2, PRI_LOW, 0x41, 0, 0x01, 6, bitmask),
> -	PREAD(temp4_alarm, 3, PRI_LOW, 0x43, 0, 0x01, 0, bitmask),
> +	PREAD(temp1_alarm, 0, PRI_HIGH, 0x41, 0, 0x01, 4, bitmask),
> +	PREAD(temp2_alarm, 1, PRI_HIGH, 0x41, 0, 0x01, 5, bitmask),
> +	PREAD(temp3_alarm, 2, PRI_HIGH, 0x41, 0, 0x01, 6, bitmask),
> +	PREAD(temp4_alarm, 3, PRI_HIGH, 0x43, 0, 0x01, 0, bitmask),
>  
>  	PWRITE(temp1_source, 0, PRI_LOW, 0x02, 0, 0x07, 4, bitmask),
>  	PWRITE(temp2_source, 1, PRI_LOW, 0x02, 0, 0x07, 0, bitmask),
> @@ -898,7 +897,7 @@ static struct asc7621_param asc7621_params[] = {
>  
>  	PWRITE(temp1_smoothing_enable, 0, PRI_LOW, 0x62, 0, 0x01, 3, bitmask),
>  	PWRITE(temp2_smoothing_enable, 1, PRI_LOW, 0x63, 0, 0x01, 7, bitmask),
> -	PWRITE(temp3_smoothing_enable, 2, PRI_LOW, 0x64, 0, 0x01, 3, bitmask),
> +	PWRITE(temp3_smoothing_enable, 2, PRI_LOW, 0x63, 0, 0x01, 3, bitmask),
>  	PWRITE(temp4_smoothing_enable, 3, PRI_LOW, 0x3c, 0, 0x01, 3, bitmask),
>  
>  	PWRITE(temp1_smoothing_time, 0, PRI_LOW, 0x62, 0, 0x07, 0, temp_st),
> -- 
> 1.7.1
> 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
