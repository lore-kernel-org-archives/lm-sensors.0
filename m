From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 24 May 2007 15:34:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/pc87360: Convert to a platform driver
Message-Id: <4655B08D.4000004@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070521171943.420aa00b@hyperion.delvare>
In-Reply-To: <20070521171943.420aa00b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
>
> I finally found some time to convert the pc87360 driver to a platform
> driver. Jim (or anyone else with access to supported hardware), could
> you please give it a try and confirm that it works OK?
> Thanks.
>
>   

yes it works!

these are with the conf in debian unstable -

soekris:~# uname -a
Linux soekris 2.6.22-rc2-sk #2 Mon May 21 19:15:36 MDT 2007 i586 GNU/Linux
soekris:~#
soekris:~# sensors
pc87366-isa-6620
Adapter: ISA adapter
in0:       +3.01 V  (min =  +0.00 V, max =  +3.01 V)      
in1:       +2.01 V  (min =  +0.00 V, max =  +3.01 V)      
in2:       +2.48 V  (min =  +0.00 V, max =  +3.01 V)      
in3:       +0.66 V  (min =  +0.00 V, max =  +3.01 V)      
in4:       +2.46 V  (min =  +0.00 V, max =  +3.01 V)      
in5:       +2.49 V  (min =  +0.00 V, max =  +3.01 V)      
in6:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)      
Vsb:       +3.31 V  (min =  +0.00 V, max =  +6.03 V)      
Vdd:       +2.98 V  (min =  +0.00 V, max =  +6.03 V)      
Vbat:      +3.01 V  (min =  +0.00 V, max =  +3.01 V)      
AVdd:      +3.28 V  (min =  +0.00 V, max =  +6.03 V)      
CPU0 Temp:  +127 C  (low  =   -55 C, high =  +127 C)   OPEN
CPU0 Crit:  +127 C ALARM
CPU1 Temp:  +127 C  (low  =   -55 C, high =  +127 C)   OPEN
CPU1 Crit:  +127 C ALARM
S-IO Temp:   +93 C  (low  =   -55 C, high =  +127 C) 
S-IO Crit:  +127 C
[ 1903.061714] hwmon-vid: requested unknown VRM version
vid:      +0.000 V  (VRM Version 0.0)


the rest is probably more than anyone really needs to see, but...

soekris:~# ls /sys/devices/platform/
i8042/          pc8736x_gpio.0/ serial8250/    
net48xx-led/    pcspkr/         serial8250.0/  
pc87360.26144/  scx200_gpio.0/  uevent         
soekris:~# ls /sys/devices/platform/pc87360.26144/
alarms_in      in1_max     in5_input   in8_status    temp2_max     temp5_max
alarms_temp    in1_min     in5_max     in9_input     temp2_min     temp5_min
bus@           in1_status  in5_min     in9_max       temp2_status  
temp5_status
cpu0_vid       in2_input   in5_status  in9_min       temp3_crit    
temp6_crit
driver@        in2_max     in6_input   in9_status    temp3_input   
temp6_input
hwmon:hwmon0@  in2_min     in6_max     modalias      temp3_max     temp6_max
in0_input      in2_status  in6_min     name          temp3_min     temp6_min
in0_max        in3_input   in6_status  subsystem@    temp3_status  
temp6_status
in0_min        in3_max     in7_input   temp1_crit    temp4_crit    uevent
in0_status     in3_min     in7_max     temp1_input   temp4_input   vrm
in10_input     in3_status  in7_min     temp1_max     temp4_max
in10_max       in4_input   in7_status  temp1_min     temp4_min
in10_min       in4_max     in8_input   temp1_status  temp4_status
in10_status    in4_min     in8_max     temp2_crit    temp5_crit
in1_input      in4_status  in8_min     temp2_input   temp5_input
soekris:~#
soekris:~# ll /sys/devices/platform/pc87360.26144/
total 0
-r--r--r-- 1 root root 4096 May 23 18:57 alarms_in
-r--r--r-- 1 root root 4096 May 23 18:57 alarms_temp
lrwxrwxrwx 1 root root    0 May 22 18:19 bus -> ../../../bus/platform/
-r--r--r-- 1 root root 4096 May 22 18:19 cpu0_vid
lrwxrwxrwx 1 root root    0 May 22 18:19 driver -> 
../../../bus/platform/drivers/pc87360/
lrwxrwxrwx 1 root root    0 May 23 18:57 hwmon:hwmon0 -> 
../../../class/hwmon/hwmon0/
....
-r--r--r-- 1 root root 4096 May 22 18:19 in9_input
-rw-r--r-- 1 root root 4096 May 22 18:19 in9_max
-rw-r--r-- 1 root root 4096 May 22 18:19 in9_min
-r--r--r-- 1 root root 4096 May 22 18:19 in9_status
-r--r--r-- 1 root root 4096 May 23 18:57 modalias
-r--r--r-- 1 root root 4096 May 22 18:19 name
lrwxrwxrwx 1 root root    0 May 22 18:19 subsystem -> ../../../bus/platform/
......
-rw-r--r-- 1 root root 4096 May 22 18:19 temp6_crit
-r--r--r-- 1 root root 4096 May 22 18:19 temp6_input
-rw-r--r-- 1 root root 4096 May 22 18:19 temp6_max
-rw-r--r-- 1 root root 4096 May 22 18:19 temp6_min
-r--r--r-- 1 root root 4096 May 22 18:19 temp6_status
-rw-r--r-- 1 root root 4096 May 23 18:57 uevent
-rw-r--r-- 1 root root 4096 May 22 18:19 vrm



> * * * * *
>
> Convert the pc87360 driver from the nonsensical i2c-isa hack to a
> regular platform driver. This is a direct conversion, other cleanups
> could happen on top of that.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Jim Cromie <jim.cromie@gmail.com>
>   
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>



> ---
>  drivers/hwmon/Kconfig   |    2 
>  drivers/hwmon/pc87360.c |  232 +++++++++++++++++++++++++++--------------------
>  2 files changed, 137 insertions(+), 97 deletions(-)
>
> --- linux-2.6.22-rc2.orig/drivers/hwmon/Kconfig	2007-05-20 21:37:43.000000000 +0200
> +++ linux-2.6.22-rc2/drivers/hwmon/Kconfig	2007-05-21 14:59:27.000000000 +0200
> @@ -405,8 +405,6 @@ config SENSORS_MAX6650
>  
>  config SENSORS_PC87360
>  	tristate "National Semiconductor PC87360 family"
> -	depends on I2C && EXPERIMENTAL
> -	select I2C_ISA
>  	select HWMON_VID
>  	help
>  	  If you say yes here you get access to the hardware monitoring
> --- linux-2.6.22-rc2.orig/drivers/hwmon/pc87360.c	2007-05-16 08:55:56.000000000 +0200
> +++ linux-2.6.22-rc2/drivers/hwmon/pc87360.c	2007-05-21 16:33:39.000000000 +0200
> @@ -1,7 +1,7 @@
>  /*
>   *  pc87360.c - Part of lm_sensors, Linux kernel modules
>   *              for hardware monitoring
> - *  Copyright (C) 2004 Jean Delvare <khali@linux-fr.org>
> + *  Copyright (C) 2004, 2007 Jean Delvare <khali@linux-fr.org>
>   *
>   *  Copied from smsc47m1.c:
>   *  Copyright (C) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
> @@ -37,8 +37,7 @@
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/jiffies.h>
> -#include <linux/i2c.h>
> -#include <linux/i2c-isa.h>
> +#include <linux/platform_device.h>
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/hwmon-vid.h>
> @@ -47,12 +46,10 @@
>  #include <asm/io.h>
>  
>  static u8 devid;
> -static unsigned short address;
> +static struct platform_device *pdev;
>  static unsigned short extra_isa[3];
>  static u8 confreg[4];
>  
> -enum chips { any_chip, pc87360, pc87363, pc87364, pc87365, pc87366 };
> -
>  static int init = 1;
>  module_param(init, int, 0);
>  MODULE_PARM_DESC(init,
> @@ -178,11 +175,11 @@ static inline u8 PWM_TO_REG(int val, int
>  					 ((val) + 500) / 1000)
>  
>  /*
> - * Client data (each client gets its own)
> + * Device data
>   */
>  
>  struct pc87360_data {
> -	struct i2c_client client;
> +	const char *name;
>  	struct class_device *class_dev;
>  	struct mutex lock;
>  	struct mutex update_lock;
> @@ -222,27 +219,28 @@ struct pc87360_data {
>   * Functions declaration
>   */
>  
> -static int pc87360_detect(struct i2c_adapter *adapter);
> -static int pc87360_detach_client(struct i2c_client *client);
> +static int pc87360_probe(struct platform_device *pdev);
> +static int pc87360_remove(struct platform_device *pdev);
>  
>  static int pc87360_read_value(struct pc87360_data *data, u8 ldi, u8 bank,
>  			      u8 reg);
>  static void pc87360_write_value(struct pc87360_data *data, u8 ldi, u8 bank,
>  				u8 reg, u8 value);
> -static void pc87360_init_client(struct i2c_client *client, int use_thermistors);
> +static void pc87360_init_device(struct platform_device *pdev,
> +				int use_thermistors);
>  static struct pc87360_data *pc87360_update_device(struct device *dev);
>  
>  /*
> - * Driver data (common to all clients)
> + * Driver data
>   */
>  
> -static struct i2c_driver pc87360_driver = {
> +static struct platform_driver pc87360_driver = {
>  	.driver = {
>  		.owner	= THIS_MODULE,
>  		.name	= "pc87360",
>  	},
> -	.attach_adapter	= pc87360_detect,
> -	.detach_client	= pc87360_detach_client,
> +	.probe		= pc87360_probe,
> +	.remove		= __devexit_p(pc87360_remove),
>  };
>  
>  /*
> @@ -281,8 +279,7 @@ static ssize_t set_fan_min(struct device
>  	size_t count)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	long fan_min = simple_strtol(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> @@ -347,8 +344,7 @@ static ssize_t set_pwm(struct device *de
>  	size_t count)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	long val = simple_strtol(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> @@ -410,8 +406,7 @@ static ssize_t set_in_min(struct device 
>  	size_t count)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	long val = simple_strtol(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> @@ -425,8 +420,7 @@ static ssize_t set_in_max(struct device 
>  	size_t count)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	long val = simple_strtol(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> @@ -511,8 +505,7 @@ static ssize_t show_vrm(struct device *d
>  }
>  static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	data->vrm = simple_strtoul(buf, NULL, 10);
>  	return count;
>  }
> @@ -584,8 +577,7 @@ static ssize_t set_therm_min(struct devi
>  	size_t count)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	long val = simple_strtol(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> @@ -599,8 +591,7 @@ static ssize_t set_therm_max(struct devi
>  	size_t count)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	long val = simple_strtol(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> @@ -614,8 +605,7 @@ static ssize_t set_therm_crit(struct dev
>  	size_t count)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	long val = simple_strtol(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> @@ -715,8 +705,7 @@ static ssize_t set_temp_min(struct devic
>  	size_t count)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	long val = simple_strtol(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> @@ -730,8 +719,7 @@ static ssize_t set_temp_max(struct devic
>  	size_t count)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	long val = simple_strtol(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> @@ -745,8 +733,7 @@ static ssize_t set_temp_crit(struct devi
>  	size_t count)
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	long val = simple_strtol(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> @@ -818,6 +805,14 @@ static const struct attribute_group pc87
>  	.attrs = pc8736x_temp_attr_array,
>  };
>  
> +static ssize_t show_name(struct device *dev, struct device_attribute
> +			 *devattr, char *buf)
> +{
> +	struct pc87360_data *data = dev_get_drvdata(dev);
> +	return sprintf(buf, "%s\n", data->name);
> +}
> +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> +
>  /*
>   * Device detection, registration and update
>   */
> @@ -912,28 +907,18 @@ static int __init pc87360_find(int sioad
>  	return 0;
>  }
>  
> -static int pc87360_detect(struct i2c_adapter *adapter)
> +static int __devinit pc87360_probe(struct platform_device *pdev)
>  {
>  	int i;
> -	struct i2c_client *client;
>  	struct pc87360_data *data;
>  	int err = 0;
>  	const char *name = "pc87360";
>  	int use_thermistors = 0;
> -	struct device *dev;
> +	struct device *dev = &pdev->dev;
>  
>  	if (!(data = kzalloc(sizeof(struct pc87360_data), GFP_KERNEL)))
>  		return -ENOMEM;
>  
> -	client = &data->client;
> -	dev = &client->dev;
> -	i2c_set_clientdata(client, data);
> -	client->addr = address;
> -	mutex_init(&data->lock);
> -	client->adapter = adapter;
> -	client->driver = &pc87360_driver;
> -	client->flags = 0;
> -
>  	data->fannr = 2;
>  	data->innr = 0;
>  	data->tempnr = 0;
> @@ -960,15 +945,17 @@ static int pc87360_detect(struct i2c_ada
>  		break;
>  	}
>  
> -	strlcpy(client->name, name, sizeof(client->name));
> +	data->name = name;
>  	data->valid = 0;
> +	mutex_init(&data->lock);
>  	mutex_init(&data->update_lock);
> +	platform_set_drvdata(pdev, data);
>  
>  	for (i = 0; i < 3; i++) {
>  		if (((data->address[i] = extra_isa[i]))
>  		 && !request_region(extra_isa[i], PC87360_EXTENT,
>  		 		    pc87360_driver.driver.name)) {
> -			dev_err(&client->dev, "Region 0x%x-0x%x already "
> +			dev_err(dev, "Region 0x%x-0x%x already "
>  				"in use!\n", extra_isa[i],
>  				extra_isa[i]+PC87360_EXTENT-1);
>  			for (i--; i >= 0; i--)
> @@ -982,9 +969,6 @@ static int pc87360_detect(struct i2c_ada
>  	if (data->fannr)
>  		data->fan_conf = confreg[0] | (confreg[1] << 8);
>  
> -	if ((err = i2c_attach_client(client)))
> -		goto ERROR2;
> -
>  	/* Use the correct reference voltage
>  	   Unless both the VLM and the TMS logical devices agree to
>  	   use an external Vref, the internal one is used. */
> @@ -996,7 +980,7 @@ static int pc87360_detect(struct i2c_ada
>  						PC87365_REG_TEMP_CONFIG);
>  		}
>  		data->in_vref = (i&0x02) ? 3025 : 2966;
> -		dev_dbg(&client->dev, "Using %s reference voltage\n",
> +		dev_dbg(dev, "Using %s reference voltage\n",
>  			(i&0x02) ? "external" : "internal");
>  
>  		data->vid_conf = confreg[3];
> @@ -1015,18 +999,18 @@ static int pc87360_detect(struct i2c_ada
>  		if (devid = 0xe9 && data->address[1]) /* PC87366 */
>  			use_thermistors = confreg[2] & 0x40;
>  
> -		pc87360_init_client(client, use_thermistors);
> +		pc87360_init_device(pdev, use_thermistors);
>  	}
>  
>  	/* Register all-or-nothing sysfs groups */
>  
>  	if (data->innr &&
> -	    (err = sysfs_create_group(&client->dev.kobj,
> +	    (err = sysfs_create_group(&dev->kobj,
>  				      &pc8736x_vin_group)))
>  		goto ERROR3;
>  
>  	if (data->innr = 14 &&
> -	    (err = sysfs_create_group(&client->dev.kobj,
> +	    (err = sysfs_create_group(&dev->kobj,
>  				      &pc8736x_therm_group)))
>  		goto ERROR3;
>  
> @@ -1067,7 +1051,10 @@ static int pc87360_detect(struct i2c_ada
>  			goto ERROR3;
>  	}
>  
> -	data->class_dev = hwmon_device_register(&client->dev);
> +	if ((err = device_create_file(dev, &dev_attr_name)))
> +		goto ERROR3;
> +
> +	data->class_dev = hwmon_device_register(dev);
>  	if (IS_ERR(data->class_dev)) {
>  		err = PTR_ERR(data->class_dev);
>  		goto ERROR3;
> @@ -1075,14 +1062,12 @@ static int pc87360_detect(struct i2c_ada
>  	return 0;
>  
>  ERROR3:
> +	device_remove_file(dev, &dev_attr_name);
>  	/* can still remove groups whose members were added individually */
> -	sysfs_remove_group(&client->dev.kobj, &pc8736x_temp_group);
> -	sysfs_remove_group(&client->dev.kobj, &pc8736x_fan_group);
> -	sysfs_remove_group(&client->dev.kobj, &pc8736x_therm_group);
> -	sysfs_remove_group(&client->dev.kobj, &pc8736x_vin_group);
> -
> -	i2c_detach_client(client);
> -ERROR2:
> +	sysfs_remove_group(&dev->kobj, &pc8736x_temp_group);
> +	sysfs_remove_group(&dev->kobj, &pc8736x_fan_group);
> +	sysfs_remove_group(&dev->kobj, &pc8736x_therm_group);
> +	sysfs_remove_group(&dev->kobj, &pc8736x_vin_group);
>  	for (i = 0; i < 3; i++) {
>  		if (data->address[i]) {
>  			release_region(data->address[i], PC87360_EXTENT);
> @@ -1093,20 +1078,18 @@ ERROR1:
>  	return err;
>  }
>  
> -static int pc87360_detach_client(struct i2c_client *client)
> +static int __devexit pc87360_remove(struct platform_device *pdev)
>  {
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = platform_get_drvdata(pdev);
>  	int i;
>  
>  	hwmon_device_unregister(data->class_dev);
>  
> -	sysfs_remove_group(&client->dev.kobj, &pc8736x_temp_group);
> -	sysfs_remove_group(&client->dev.kobj, &pc8736x_fan_group);
> -	sysfs_remove_group(&client->dev.kobj, &pc8736x_therm_group);
> -	sysfs_remove_group(&client->dev.kobj, &pc8736x_vin_group);
> -
> -	if ((i = i2c_detach_client(client)))
> -		return i;
> +	device_remove_file(&pdev->dev, &dev_attr_name);
> +	sysfs_remove_group(&pdev->dev.kobj, &pc8736x_temp_group);
> +	sysfs_remove_group(&pdev->dev.kobj, &pc8736x_fan_group);
> +	sysfs_remove_group(&pdev->dev.kobj, &pc8736x_therm_group);
> +	sysfs_remove_group(&pdev->dev.kobj, &pc8736x_vin_group);
>  
>  	for (i = 0; i < 3; i++) {
>  		if (data->address[i]) {
> @@ -1144,9 +1127,10 @@ static void pc87360_write_value(struct p
>  	mutex_unlock(&(data->lock));
>  }
>  
> -static void pc87360_init_client(struct i2c_client *client, int use_thermistors)
> +static void pc87360_init_device(struct platform_device *pdev,
> +				int use_thermistors)
>  {
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = platform_get_drvdata(pdev);
>  	int i, nr;
>  	const u8 init_in[14] = { 2, 2, 2, 2, 2, 2, 2, 1, 1, 3, 1, 2, 2, 2 };
>  	const u8 init_temp[3] = { 2, 2, 1 };
> @@ -1155,7 +1139,7 @@ static void pc87360_init_client(struct i
>  	if (init >= 2 && data->innr) {
>  		reg = pc87360_read_value(data, LD_IN, NO_BANK,
>  					 PC87365_REG_IN_CONVRATE);
> -		dev_info(&client->dev, "VLM conversion set to "
> +		dev_info(&pdev->dev, "VLM conversion set to "
>  			 "1s period, 160us delay\n");
>  		pc87360_write_value(data, LD_IN, NO_BANK,
>  				    PC87365_REG_IN_CONVRATE,
> @@ -1169,7 +1153,7 @@ static void pc87360_init_client(struct i
>  			reg = pc87360_read_value(data, LD_IN, i,
>  						 PC87365_REG_IN_STATUS);
>  			if (!(reg & 0x01)) {
> -				dev_dbg(&client->dev, "Forcibly "
> +				dev_dbg(&pdev->dev, "Forcibly "
>  					"enabling in%d\n", i);
>  				pc87360_write_value(data, LD_IN, i,
>  						    PC87365_REG_IN_STATUS,
> @@ -1193,7 +1177,7 @@ static void pc87360_init_client(struct i
>  			reg = pc87360_read_value(data, LD_TEMP, i,
>  						 PC87365_REG_TEMP_STATUS);
>  			if (!(reg & 0x01)) {
> -				dev_dbg(&client->dev, "Forcibly "
> +				dev_dbg(&pdev->dev, "Forcibly "
>  					"enabling temp%d\n", i+1);
>  				pc87360_write_value(data, LD_TEMP, i,
>  						    PC87365_REG_TEMP_STATUS,
> @@ -1210,7 +1194,7 @@ static void pc87360_init_client(struct i
>  				reg = pc87360_read_value(data, LD_TEMP,
>  				      (i-11)/2, PC87365_REG_TEMP_STATUS);
>  				if (reg & 0x01) {
> -					dev_dbg(&client->dev, "Skipping "
> +					dev_dbg(&pdev->dev, "Skipping "
>  						"temp%d, pin already in use "
>  						"by temp%d\n", i-7, (i-11)/2);
>  					continue;
> @@ -1220,7 +1204,7 @@ static void pc87360_init_client(struct i
>  				reg = pc87360_read_value(data, LD_IN, i,
>  							 PC87365_REG_IN_STATUS);
>  				if (!(reg & 0x01)) {
> -					dev_dbg(&client->dev, "Forcibly "
> +					dev_dbg(&pdev->dev, "Forcibly "
>  						"enabling temp%d\n", i-7);
>  					pc87360_write_value(data, LD_IN, i,
>  						PC87365_REG_TEMP_STATUS,
> @@ -1234,7 +1218,7 @@ static void pc87360_init_client(struct i
>  		reg = pc87360_read_value(data, LD_IN, NO_BANK,
>  					 PC87365_REG_IN_CONFIG);
>  		if (reg & 0x01) {
> -			dev_dbg(&client->dev, "Forcibly "
> +			dev_dbg(&pdev->dev, "Forcibly "
>  				"enabling monitoring (VLM)\n");
>  			pc87360_write_value(data, LD_IN, NO_BANK,
>  					    PC87365_REG_IN_CONFIG,
> @@ -1246,7 +1230,7 @@ static void pc87360_init_client(struct i
>  		reg = pc87360_read_value(data, LD_TEMP, NO_BANK,
>  					 PC87365_REG_TEMP_CONFIG);
>  		if (reg & 0x01) {
> -			dev_dbg(&client->dev, "Forcibly enabling "
> +			dev_dbg(&pdev->dev, "Forcibly enabling "
>  				"monitoring (TMS)\n");
>  			pc87360_write_value(data, LD_TEMP, NO_BANK,
>  					    PC87365_REG_TEMP_CONFIG,
> @@ -1268,9 +1252,9 @@ static void pc87360_init_client(struct i
>  	}
>  }
>  
> -static void pc87360_autodiv(struct i2c_client *client, int nr)
> +static void pc87360_autodiv(struct device *dev, int nr)
>  {
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	u8 old_min = data->fan_min[nr];
>  
>  	/* Increase clock divider if needed and possible */
> @@ -1280,7 +1264,7 @@ static void pc87360_autodiv(struct i2c_c
>  			data->fan_status[nr] += 0x20;
>  			data->fan_min[nr] >>= 1;
>  			data->fan[nr] >>= 1;
> -			dev_dbg(&client->dev, "Increasing "
> +			dev_dbg(dev, "Increasing "
>  				"clock divider to %d for fan %d\n",
>  				FAN_DIV_FROM_REG(data->fan_status[nr]), nr+1);
>  		}
> @@ -1292,7 +1276,7 @@ static void pc87360_autodiv(struct i2c_c
>  			data->fan_status[nr] -= 0x20;
>  			data->fan_min[nr] <<= 1;
>  			data->fan[nr] <<= 1;
> -			dev_dbg(&client->dev, "Decreasing "
> +			dev_dbg(dev, "Decreasing "
>  				"clock divider to %d for fan %d\n",
>  				FAN_DIV_FROM_REG(data->fan_status[nr]),
>  				nr+1);
> @@ -1309,14 +1293,13 @@ static void pc87360_autodiv(struct i2c_c
>  
>  static struct pc87360_data *pc87360_update_device(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct pc87360_data *data = i2c_get_clientdata(client);
> +	struct pc87360_data *data = dev_get_drvdata(dev);
>  	u8 i;
>  
>  	mutex_lock(&data->update_lock);
>  
>  	if (time_after(jiffies, data->last_updated + HZ * 2) || !data->valid) {
> -		dev_dbg(&client->dev, "Data update\n");
> +		dev_dbg(dev, "Data update\n");
>  
>  		/* Fans */
>  		for (i = 0; i < data->fannr; i++) {
> @@ -1330,7 +1313,7 @@ static struct pc87360_data *pc87360_upda
>  						   LD_FAN, NO_BANK,
>  						   PC87360_REG_FAN_MIN(i));
>  				/* Change clock divider if needed */
> -				pc87360_autodiv(client, i);
> +				pc87360_autodiv(dev, i);
>  				/* Clear bits and write new divider */
>  				pc87360_write_value(data, LD_FAN, NO_BANK,
>  						    PC87360_REG_FAN_STATUS(i),
> @@ -1418,9 +1401,53 @@ static struct pc87360_data *pc87360_upda
>  	return data;
>  }
>  
> +static int __init pc87360_device_add(unsigned short address)
> +{
> +	struct resource res = {
> +		.name	= "pc87360",
> +		.flags	= IORESOURCE_IO,
> +	};
> +	int err, i;
> +
> +	pdev = platform_device_alloc("pc87360", address);
> +	if (!pdev) {
> +		err = -ENOMEM;
> +		printk(KERN_ERR "pc87360: Device allocation failed\n");
> +		goto exit;
> +	}
> +
> +	for (i = 0; i < 3; i++) {
> +		if (!extra_isa[i])
> +			continue;
> +		res.start = extra_isa[i];
> +		res.end = extra_isa[i] + PC87360_EXTENT - 1;
> +		err = platform_device_add_resources(pdev, &res, 1);
> +		if (err) {
> +			printk(KERN_ERR "pc87360: Device resource[%d] "
> +			       "addition failed (%d)\n", i, err);
> +			goto exit_device_put;
> +		}
> +	}
> +
> +	err = platform_device_add(pdev);
> +	if (err) {
> +		printk(KERN_ERR "pc87360: Device addition failed (%d)\n",
> +		       err);
> +		goto exit_device_put;
> +	}
> +
> +	return 0;
> +
> +exit_device_put:
> +	platform_device_put(pdev);
> +exit:
> +	return err;
> +}
> +
>  static int __init pc87360_init(void)
>  {
> -	int i;
> +	int err, i;
> +	unsigned short address = 0;
>  
>  	if (pc87360_find(0x2e, &devid, extra_isa)
>  	 && pc87360_find(0x4e, &devid, extra_isa)) {
> @@ -1443,12 +1470,27 @@ static int __init pc87360_init(void)
>  		return -ENODEV;
>  	}
>  
> -	return i2c_isa_add_driver(&pc87360_driver);
> +	err = platform_driver_register(&pc87360_driver);
> +	if (err)
> +		goto exit;
> +
> +	/* Sets global pdev as a side effect */
> +	err = pc87360_device_add(address);
> +	if (err)
> +		goto exit_driver;
> +
> +	return 0;
> +
> + exit_driver:
> +	platform_driver_unregister(&pc87360_driver);
> + exit:
> +	return err;
>  }
>  
>  static void __exit pc87360_exit(void)
>  {
> -	i2c_isa_del_driver(&pc87360_driver);
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&pc87360_driver);
>  }
>  
>  
>
>
>   


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
