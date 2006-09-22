From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 22 Sep 2006 07:50:33 +0000
Subject: [lm-sensors] [patch] hwmon: w83781d - check return code of
Message-Id: <20060922095033.cdf4329a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F70D89.30409@gmail.com>
In-Reply-To: <44F70D89.30409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> Add 2 attr-file groups (for base and model-specific attrs respectively),
> create the base group with single call to sysfs_create_group,
> check the return code on individual calls to device_create_file for each
> of the model-specific attr-files.
> 
> Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
> 
> ---
> 
> This is compile-tested only, needs validation on hardware, or
> very thorough inspection.

I have some more comments, see below.

> There are several distasteful macro-function-decl-expansions still there :
> 
> show_in_reg(in);
> show_in_reg(in_min);
> show_in_reg(in_max);
> 
> store_in_reg(MIN, min);
> store_in_reg(MAX, max);
> 
> and also a compound one:  This one in particular is crying for a 
> 2D-callback implementation.
> Ill do it (its my axe, Ill grind it some more ;-), IFF you find a tester 
> for it.
> Anyway, thats not for 19.

Yes, there is much room for cleanups to this driver using at least 1D
callbacks, and possibly 2D callbacks in some cases. If you want to
provide a patch doing this, this is welcome - just don't be overzealous
and cleanup the code without rewriting too much of it please. And as
you noticed, this is 2.6.20 material at this point.

> diff -ruNp -X dontdiff -X exclude-diffs 6rlocks-1/drivers/hwmon/w83781d.c 6rlocks-w83/drivers/hwmon/w83781d.c
> --- 6rlocks-1/drivers/hwmon/w83781d.c	2006-09-19 23:58:37.000000000 -0600
> +++ 6rlocks-w83/drivers/hwmon/w83781d.c	2006-09-21 22:12:06.000000000 -0600
> @@ -40,6 +40,8 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c-isa.h>
>  #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

You do not appear to actually need this one yet.

> +#include <linux/sysfs.h>
>  #include <linux/hwmon-vid.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> @@ -359,13 +361,6 @@ sysfs_in_offsets(6);
>  sysfs_in_offsets(7);
>  sysfs_in_offsets(8);
>  
> -#define device_create_file_in(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> -device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> -device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> -} while (0)
> -
>  #define show_fan_reg(reg) \
>  static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
>  { \
> @@ -420,12 +415,6 @@ sysfs_fan_min_offset(2);
>  sysfs_fan_offset(3);
>  sysfs_fan_min_offset(3);
>  
> -#define device_create_file_fan(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
> -device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
> -} while (0)
> -
>  #define show_temp_reg(reg) \
>  static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
>  { \
> @@ -496,13 +485,6 @@ sysfs_temp_offsets(1);
>  sysfs_temp_offsets(2);
>  sysfs_temp_offsets(3);
>  
> -#define device_create_file_temp(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
> -device_create_file(&client->dev, &dev_attr_temp##offset##_max); \
> -device_create_file(&client->dev, &dev_attr_temp##offset##_max_hyst); \
> -} while (0)
> -
>  static ssize_t
>  show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -510,10 +492,8 @@ show_vid_reg(struct device *dev, struct 
>  	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
>  }
>  
> -static
> -DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
> -#define device_create_file_vid(client) \
> -device_create_file(&client->dev, &dev_attr_cpu0_vid);
> +static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
> +
>  static ssize_t
>  show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -533,11 +513,8 @@ store_vrm_reg(struct device *dev, struct
>  
>  	return count;
>  }
> +static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
>  
> -static
> -DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
> -#define device_create_file_vrm(client) \
> -device_create_file(&client->dev, &dev_attr_vrm);
>  static ssize_t
>  show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -545,17 +522,16 @@ show_alarms_reg(struct device *dev, stru
>  	return sprintf(buf, "%u\n", data->alarms);
>  }
>  
> -static
> -DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
> -#define device_create_file_alarms(client) \
> -device_create_file(&client->dev, &dev_attr_alarms);
> -static ssize_t show_beep_mask (struct device *dev, struct device_attribute *attr, char *buf)
> +static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
> +
> +static ssize_t
> +show_beep_mask(struct device *dev, struct device_attribute *attr, char *buf)

Please back out this one cleanup - it doesn't belong to this patch.

>  {
>  	struct w83781d_data *data = w83781d_update_device(dev);
>  	return sprintf(buf, "%ld\n",
>  		       (long)BEEP_MASK_FROM_REG(data->beep_mask, data->type));
>  }
> -static ssize_t show_beep_enable (struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_beep_enable(struct device *dev, struct device_attribute *attr, char *buf)

Same here.

>  {
>  	struct w83781d_data *data = w83781d_update_device(dev);
>  	return sprintf(buf, "%ld\n",
> @@ -614,12 +590,6 @@ static DEVICE_ATTR(beep_##reg, S_IRUGO |
>  sysfs_beep(ENABLE, enable);
>  sysfs_beep(MASK, mask);
>  
> -#define device_create_file_beep(client) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_beep_enable); \
> -device_create_file(&client->dev, &dev_attr_beep_mask); \
> -} while (0)
> -
>  static ssize_t
>  show_fan_div_reg(struct device *dev, char *buf, int nr)
>  {
> @@ -685,11 +655,6 @@ sysfs_fan_div(1);
>  sysfs_fan_div(2);
>  sysfs_fan_div(3);
>  
> -#define device_create_file_fan_div(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
> -} while (0)
> -
>  static ssize_t
>  show_pwm_reg(struct device *dev, char *buf, int nr)
>  {
> @@ -786,16 +751,6 @@ sysfs_pwmenable(2);		/* only PWM2 can be
>  sysfs_pwm(3);
>  sysfs_pwm(4);
>  
> -#define device_create_file_pwm(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_pwm##offset); \
> -} while (0)
> -
> -#define device_create_file_pwmenable(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_pwm##offset##_enable); \
> -} while (0)
> -
>  static ssize_t
>  show_sensor_reg(struct device *dev, char *buf, int nr)
>  {
> @@ -864,11 +819,6 @@ sysfs_sensor(1);
>  sysfs_sensor(2);
>  sysfs_sensor(3);
>  
> -#define device_create_file_sensor(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_temp##offset##_type); \
> -} while (0)
> -
>  /* This function is called when:
>       * w83781d_driver is inserted (when this module is loaded), for each
>         available adapter
> @@ -993,11 +943,69 @@ ERROR_SC_0:
>  	return err;
>  }
>  
> +#define IN_UNIT_ATTRS(X)			\
> +	&dev_attr_in##X##_input.attr,		\
> +	&dev_attr_in##X##_min.attr,		\
> +	&dev_attr_in##X##_max.attr
> +
> +#define FAN_UNIT_ATTRS(X)			\
> +	&dev_attr_fan##X##_input.attr,		\
> +	&dev_attr_fan##X##_min.attr,		\
> +	&dev_attr_fan##X##_div.attr
> +
> +#define TEMP_UNIT_ATTRS(X)			\
> +	&dev_attr_temp##X##_input.attr,		\
> +	&dev_attr_temp##X##_max.attr,		\
> +	&dev_attr_temp##X##_max_hyst.attr
> +
> +static struct attribute *w83781d_attributes[] = {
> +	IN_UNIT_ATTRS(0),
> +	IN_UNIT_ATTRS(2),
> +	IN_UNIT_ATTRS(3),
> +	IN_UNIT_ATTRS(4),
> +	IN_UNIT_ATTRS(5),
> +	IN_UNIT_ATTRS(6),
> +	FAN_UNIT_ATTRS(1),
> +	FAN_UNIT_ATTRS(2),
> +	FAN_UNIT_ATTRS(3),
> +	TEMP_UNIT_ATTRS(1),
> +	TEMP_UNIT_ATTRS(2),
> +	&dev_attr_cpu0_vid.attr,
> +	&dev_attr_vrm.attr,
> +	&dev_attr_alarms.attr,
> +	&dev_attr_beep_mask.attr,
> +	&dev_attr_beep_enable.attr,
> +	NULL
> +};
> +static struct attribute_group w83781d_group = {
> +	.attrs = w83781d_attributes,
> +};

This one can be declared const.

> +
> +static struct attribute *w83781d_attributes_opt[] = {
> +	IN_UNIT_ATTRS(1),
> +	IN_UNIT_ATTRS(7),
> +	IN_UNIT_ATTRS(8),
> +	TEMP_UNIT_ATTRS(3),
> +	&dev_attr_pwm1.attr,
> +	&dev_attr_pwm2.attr,
> +	&dev_attr_pwm2_enable.attr,
> +	&dev_attr_pwm3.attr,
> +	&dev_attr_pwm4.attr,
> +	&dev_attr_temp1_type.attr,	/* for sensor */
> +	&dev_attr_temp2_type.attr,
> +	&dev_attr_temp3_type.attr,
> +	NULL
> +};
> +static struct attribute_group w83781d_group_opt = {
> +	.attrs = w83781d_attributes_opt,
> +};

const

> +
>  static int
>  w83781d_detect(struct i2c_adapter *adapter, int address, int kind)
>  {
>  	int i = 0, val1 = 0, val2;
> -	struct i2c_client *new_client;
> +	struct i2c_client *client;
> +	struct device *clidev;

I would have gone with just "dev" as there is no other device involved,
so no room for confusion. But the choice is yours.

>  	struct w83781d_data *data;
>  	int err;
>  	const char *client_name = "";
> @@ -1074,13 +1082,14 @@ w83781d_detect(struct i2c_adapter *adapt
>  		goto ERROR1;
>  	}
>  
> -	new_client = &data->client;
> -	i2c_set_clientdata(new_client, data);
> -	new_client->addr = address;
> +	client = &data->client;
> +	i2c_set_clientdata(client, data);
> +	client->addr = address;
>  	mutex_init(&data->lock);
> -	new_client->adapter = adapter;
> -	new_client->driver = is_isa ? &w83781d_isa_driver : &w83781d_driver;
> -	new_client->flags = 0;
> +	client->adapter = adapter;
> +	client->driver = is_isa ? &w83781d_isa_driver : &w83781d_driver;
> +	client->flags = 0;
> +	clidev = &client->dev;
>  
>  	/* Now, we do the remaining detection. */
>  
> @@ -1089,20 +1098,18 @@ w83781d_detect(struct i2c_adapter *adapt
>  	   force_*=... parameter, and the Winbond will be reset to the right
>  	   bank. */
>  	if (kind < 0) {
> -		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80) {
> -			dev_dbg(&new_client->dev, "Detection failed at step "
> -				"3\n");
> +		if (w83781d_read_value(client, W83781D_REG_CONFIG) & 0x80) {
> +			dev_dbg(&client->dev, "Detection failed at step 3\n");

Why don't you use clidev now that you have defined it?

>  			err = -ENODEV;
>  			goto ERROR2;
>  		}
> -		val1 = w83781d_read_value(new_client, W83781D_REG_BANK);
> -		val2 = w83781d_read_value(new_client, W83781D_REG_CHIPMAN);
> +		val1 = w83781d_read_value(client, W83781D_REG_BANK);
> +		val2 = w83781d_read_value(client, W83781D_REG_CHIPMAN);
>  		/* Check for Winbond or Asus ID if in bank 0 */
>  		if ((!(val1 & 0x07)) &&
>  		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
>  		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
> -			dev_dbg(&new_client->dev, "Detection failed at step "
> -				"4\n");
> +			dev_dbg(&client->dev, "Detection failed at step 4\n");

Same here (and in several other places in this function.)

>  			err = -ENODEV;
>  			goto ERROR2;
>  		}
> @@ -1111,8 +1118,8 @@ w83781d_detect(struct i2c_adapter *adapt
>  		if ((!is_isa) && (((!(val1 & 0x80)) && (val2 = 0xa3)) ||
>  				  ((val1 & 0x80) && (val2 = 0x5c)))) {
>  			if (w83781d_read_value
> -			    (new_client, W83781D_REG_I2C_ADDR) != address) {
> -				dev_dbg(&new_client->dev, "Detection failed "
> +			    (client, W83781D_REG_I2C_ADDR) != address) {
> +				dev_dbg(&client->dev, "Detection failed "
>  					"at step 5\n");
>  				err = -ENODEV;
>  				goto ERROR2;
> @@ -1122,27 +1129,27 @@ w83781d_detect(struct i2c_adapter *adapt
>  
>  	/* We have either had a force parameter, or we have already detected the
>  	   Winbond. Put it now into bank 0 and Vendor ID High Byte */
> -	w83781d_write_value(new_client, W83781D_REG_BANK,
> -			    (w83781d_read_value(new_client,
> -						W83781D_REG_BANK) & 0x78) |
> -			    0x80);
> +	w83781d_write_value(client, W83781D_REG_BANK,
> +			    (w83781d_read_value(client,
> +						W83781D_REG_BANK)

Seems to fit on the same line?

> +			     & 0x78) | 0x80);
>  
>  	/* Determine the chip type. */
>  	if (kind <= 0) {
>  		/* get vendor ID */
> -		val2 = w83781d_read_value(new_client, W83781D_REG_CHIPMAN);
> +		val2 = w83781d_read_value(client, W83781D_REG_CHIPMAN);
>  		if (val2 = 0x5c)
>  			vendid = winbond;
>  		else if (val2 = 0x12)
>  			vendid = asus;
>  		else {
> -			dev_dbg(&new_client->dev, "Chip was made by neither "
> +			dev_dbg(&client->dev, "Chip was made by neither "
>  				"Winbond nor Asus?\n");
>  			err = -ENODEV;
>  			goto ERROR2;
>  		}
>  
> -		val1 = w83781d_read_value(new_client, W83781D_REG_WCHIPID);
> +		val1 = w83781d_read_value(client, W83781D_REG_WCHIPID);
>  		if ((val1 = 0x10 || val1 = 0x11) && vendid = winbond)
>  			kind = w83781d;
>  		else if (val1 = 0x30 && vendid = winbond)
> @@ -1156,7 +1163,7 @@ w83781d_detect(struct i2c_adapter *adapt
>  			kind = as99127f;
>  		else {
>  			if (kind = 0)
> -				dev_warn(&new_client->dev, "Ignoring 'force' "
> +				dev_warn(&client->dev, "Ignoring 'force' "
>  					 "parameter for unknown chip at "
>  					 "adapter %d, address 0x%02x\n",
>  					 i2c_adapter_id(adapter), address);
> @@ -1178,20 +1185,20 @@ w83781d_detect(struct i2c_adapter *adapt
>  	}
>  
>  	/* Fill in the remaining client fields and put into the global list */
> -	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
> +	strlcpy(client->name, client_name, I2C_NAME_SIZE);
>  	data->type = kind;
>  
>  	data->valid = 0;
>  	mutex_init(&data->update_lock);
>  
>  	/* Tell the I2C layer a new client has arrived */
> -	if ((err = i2c_attach_client(new_client)))
> +	if ((err = i2c_attach_client(client)))
>  		goto ERROR2;
>  
>  	/* attach secondary i2c lm75-like clients */
>  	if (!is_isa) {
>  		if ((err = w83781d_detect_subclients(adapter, address,
> -				kind, new_client)))
> +				kind, client)))
>  			goto ERROR3;
>  	} else {
>  		data->lm75[0] = NULL;
> @@ -1199,11 +1206,11 @@ w83781d_detect(struct i2c_adapter *adapt
>  	}
>  
>  	/* Initialize the chip */
> -	w83781d_init_client(new_client);
> +	w83781d_init_client(client);
>  
>  	/* A few vars need to be filled upon startup */
>  	for (i = 1; i <= 3; i++) {
> -		data->fan_min[i - 1] = w83781d_read_value(new_client,
> +		data->fan_min[i - 1] = w83781d_read_value(client,
>  					W83781D_REG_FAN_MIN(i));
>  	}
>  	if (kind != w83781d && kind != as99127f)
> @@ -1211,65 +1218,74 @@ w83781d_detect(struct i2c_adapter *adapt
>  			data->pwmenable[i] = 1;
>  
>  	/* Register sysfs hooks */
> -	data->class_dev = hwmon_device_register(&new_client->dev);
> -	if (IS_ERR(data->class_dev)) {
> -		err = PTR_ERR(data->class_dev);
> -		goto ERROR4;
> -	}
> +	if ((err = sysfs_create_group(&client->dev.kobj, &w83781d_group)))
> +		goto ERROR5;
>  
> -	device_create_file_in(new_client, 0);
> -	if (kind != w83783s)
> -		device_create_file_in(new_client, 1);
> -	device_create_file_in(new_client, 2);
> -	device_create_file_in(new_client, 3);
> -	device_create_file_in(new_client, 4);
> -	device_create_file_in(new_client, 5);
> -	device_create_file_in(new_client, 6);
> +	if (kind != w83783s) {
> +		err = device_create_file(clidev, &dev_attr_in1_input)
> +			|| device_create_file(clidev, &dev_attr_in1_min)
> +			|| device_create_file(clidev, &dev_attr_in1_max);
> +		if (err)
> +			goto ERROR5;
> +	}

Not correct, sorry. device_create_file() returns a real error value,
not just a boolean status, so using boolean logic directly loses the
error value. You need to do something like:

	if (kind != w83783s) {
		if ((err = device_create_file(clidev, &dev_attr_in1_input))
		 || (err = device_create_file(clidev, &dev_attr_in1_min))
		 || (err = device_create_file(clidev, &dev_attr_in1_max)))
			goto ERROR5;
	}

That way the value of "err" is properly returned. Same for all other
cases below.

>  	if (kind != as99127f && kind != w83781d && kind != w83783s) {
> -		device_create_file_in(new_client, 7);
> -		device_create_file_in(new_client, 8);
> +		err = device_create_file(clidev, &dev_attr_in7_input)
> +			|| device_create_file(clidev, &dev_attr_in7_min)
> +			|| device_create_file(clidev, &dev_attr_in7_max)
> +			|| device_create_file(clidev, &dev_attr_in8_input)
> +			|| device_create_file(clidev, &dev_attr_in8_min)
> +			|| device_create_file(clidev, &dev_attr_in8_max);
> +		if (err)
> +			goto ERROR5;
> +	}
> +	if (kind != w83783s) {
> +		err = device_create_file(clidev, &dev_attr_temp3_input)
> +			|| device_create_file(clidev, &dev_attr_temp3_max)
> +			|| device_create_file(clidev, &dev_attr_temp3_max_hyst);
> +			if (err)
> +				goto ERROR5;
>  	}
> -
> -	device_create_file_fan(new_client, 1);
> -	device_create_file_fan(new_client, 2);
> -	device_create_file_fan(new_client, 3);
> -
> -	device_create_file_temp(new_client, 1);
> -	device_create_file_temp(new_client, 2);
> -	if (kind != w83783s)
> -		device_create_file_temp(new_client, 3);
> -
> -	device_create_file_vid(new_client);
> -	device_create_file_vrm(new_client);
> -
> -	device_create_file_fan_div(new_client, 1);
> -	device_create_file_fan_div(new_client, 2);
> -	device_create_file_fan_div(new_client, 3);
> -
> -	device_create_file_alarms(new_client);
> -
> -	device_create_file_beep(new_client);
>  
>  	if (kind != w83781d && kind != as99127f) {
> -		device_create_file_pwm(new_client, 1);
> -		device_create_file_pwm(new_client, 2);
> -		device_create_file_pwmenable(new_client, 2);
> +		err = device_create_file(clidev, &dev_attr_pwm1)
> +			|| device_create_file(clidev, &dev_attr_pwm2)
> +			|| device_create_file(clidev, &dev_attr_pwm2_enable);
> +					      
> +		if (err)
> +			goto ERROR5;
>  	}
>  	if (kind = w83782d && !is_isa) {
> -		device_create_file_pwm(new_client, 3);
> -		device_create_file_pwm(new_client, 4);
> +		err = device_create_file(clidev, &dev_attr_pwm3)
> +			|| device_create_file(clidev, &dev_attr_pwm4);
> +		if (err)
> +			goto ERROR5;
>  	}
>  
>  	if (kind != as99127f && kind != w83781d) {
> -		device_create_file_sensor(new_client, 1);
> -		device_create_file_sensor(new_client, 2);
> -		if (kind != w83783s)
> -			device_create_file_sensor(new_client, 3);
> +		err = device_create_file(clidev, &dev_attr_temp1_type)
> +			|| device_create_file(clidev, &dev_attr_temp2_type);
> +		if (err)
> +			goto ERROR5;
> +		if (kind != w83783s) {
> +			err = device_create_file(clidev, &dev_attr_temp3_type);
> +			if (err)
> +				goto ERROR5;
> +		}
> +	}
> +
> +	data->class_dev = hwmon_device_register(clidev);
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		goto ERROR5;
>  	}
>  
>  	return 0;
>  
> -ERROR4:
> +ERROR5:
> +	sysfs_remove_group(&client->dev.kobj, &w83781d_group);
> +	sysfs_remove_group(&client->dev.kobj, &w83781d_group_opt);
> +
> +/* ERROR4: */

You could use ERROR4 for the first sysfs group creation. If not, then
kill the label completely rather than commenting it out.

>  	if (data->lm75[1]) {
>  		i2c_detach_client(data->lm75[1]);
>  		kfree(data->lm75[1]);
> @@ -1279,7 +1295,7 @@ ERROR4:
>  		kfree(data->lm75[0]);
>  	}
>  ERROR3:
> -	i2c_detach_client(new_client);
> +	i2c_detach_client(client);
>  ERROR2:
>  	kfree(data);
>  ERROR1:
> @@ -1296,9 +1312,11 @@ w83781d_detach_client(struct i2c_client 
>  	int err;
>  
>  	/* main client */
> -	if (data)
> +	if (data) {
>  		hwmon_device_unregister(data->class_dev);
> -
> +		sysfs_remove_group(&client->dev.kobj, &w83781d_group);
> +		sysfs_remove_group(&client->dev.kobj, &w83781d_group_opt);
> +	}
>  	if (i2c_is_isa_client(client))
>  		release_region(client->addr, W83781D_EXTENT);
>  

Care to repin a patch addressing the few objections above? Thanks.

-- 
Jean Delvare

