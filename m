From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 06 Aug 2008 07:46:05 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (w83791d) fan 4/5 pins can also
Message-Id: <489956BD.3020002@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200808060029.31190.m.hulsman@tudelft.nl>
In-Reply-To: <200808060029.31190.m.hulsman@tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marc Hulsman wrote:
> Fan 4/5 and PWM 4/5 pins can be used for GPIO. If the bios initializes these 
> pins as in use for GPIO we keep it that way and do not construct the 
> sysfs-interface for them.  I left the code for reading the corresponding 
> registers during update_device unchanged as adding conditional terms would 
> only complicate the code. 
> 

Looks good:
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

One note though (for a future patch) you say you keep reading the unused regs 
to keep the code clean. I understand this, but please keep in mind that i2c is 
pretty slow, so you might want todo another patch changing this.

Or even better write a patch where you stop re-reading never changing registers 
completely, iow read config / min / max registers only once on probe and then 
only read registers which actually measure things (and thus can change without 
a write) in update_device (Yes there is the potential problem of acpi code 
writing to the device underneath us but we aren't checking for that now anyways).

Regards,

Hans


> Marc
> ---
> Pins fan/pwm 4-5 can be in use as GPIO. If that is the case, do not
> create their sysfs-interface. 
> 
> Signed-off-by: Marc Hulsman <m.hulsman@tudelft.nl>
> ---
>  drivers/hwmon/w83791d.c |   30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> ---
> Index: linux-2.6.27-rc1/drivers/hwmon/w83791d.c
> =================================> --- linux-2.6.27-rc1.orig/drivers/hwmon/w83791d.c
> +++ linux-2.6.27-rc1/drivers/hwmon/w83791d.c
> @@ -160,6 +160,7 @@ static const u8 W83791D_REG_BEEP_CTRL[3]
>  	0xA3,			/* BEEP Control Register 3 */
>  };
>  
> +#define W83791D_REG_GPIO		0x15
>  #define W83791D_REG_CONFIG		0x40
>  #define W83791D_REG_VID_FANDIV		0x47
>  #define W83791D_REG_DID_VID4		0x49
> @@ -908,8 +909,6 @@ static struct attribute *w83791d_attribu
>  	FAN_UNIT_ATTRS(0),
>  	FAN_UNIT_ATTRS(1),
>  	FAN_UNIT_ATTRS(2),
> -	FAN_UNIT_ATTRS(3),
> -	FAN_UNIT_ATTRS(4),
>  	TEMP_UNIT_ATTRS(0),
>  	TEMP_UNIT_ATTRS(1),
>  	TEMP_UNIT_ATTRS(2),
> @@ -925,6 +924,18 @@ static const struct attribute_group w837
>  	.attrs = w83791d_attributes,
>  };
>  
> +/* Separate group of attributes for fan/pwm 4-5. Their pins can also be
> +   in use for GPIO in which case their sysfs-interface should not be made
> +   available */
> +static struct attribute *w83791d_attributes_fanpwm45[] = {
> +	FAN_UNIT_ATTRS(3),
> +	FAN_UNIT_ATTRS(4),
> +	NULL
> +};
> +
> +static const struct attribute_group w83791d_group_fanpwm45 = {
> +	.attrs = w83791d_attributes_fanpwm45,
> +};
>  
>  static int w83791d_detect_subclients(struct i2c_client *client)
>  {
> @@ -1056,6 +1067,7 @@ static int w83791d_probe(struct i2c_clie
>  	struct w83791d_data *data;
>  	struct device *dev = &client->dev;
>  	int i, val1, err;
> +	u8 has_fanpwm45;
>  
>  #ifdef DEBUG
>  	val1 = w83791d_read(client, W83791D_REG_DID_VID4);
> @@ -1089,15 +1101,27 @@ static int w83791d_probe(struct i2c_clie
>  	if ((err = sysfs_create_group(&client->dev.kobj, &w83791d_group)))
>  		goto error3;
>  
> +	/* Check if pins of fan/pwm 4-5 are in use as GPIO */
> +	has_fanpwm45 = w83791d_read(client, W83791D_REG_GPIO) & 0x10;
> +	if (has_fanpwm45) {
> +		err = sysfs_create_group(&client->dev.kobj,
> +					 &w83791d_group_fanpwm45);
> +		if (err)
> +			goto error4;
> +	}
> +
>  	/* Everything is ready, now register the working device */
>  	data->hwmon_dev = hwmon_device_register(dev);
>  	if (IS_ERR(data->hwmon_dev)) {
>  		err = PTR_ERR(data->hwmon_dev);
> -		goto error4;
> +		goto error5;
>  	}
>  
>  	return 0;
>  
> +error5:
> +	if (has_fanpwm45)
> +		sysfs_remove_group(&client->dev.kobj, &w83791d_group_fanpwm45);
>  error4:
>  	sysfs_remove_group(&client->dev.kobj, &w83791d_group);
>  error3:
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
