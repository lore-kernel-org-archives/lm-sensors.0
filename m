From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: ADM1030 Driver
Message-Id: <1081373230.1690.17.camel@megapc>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK,

I just read the Documentation/i2c/porting-clients and sysfs-interface,
and I saw that I am far from the standard (in terms of naming and coding
conventions...) 
Will work on it tomorrow...

Alex.

On Wed, 2004-04-07 at 21:45, Alexandre d'Alton wrote:
> Hi everybody,
> 
> Here is the first version of the adm1030 sensor driver I've made. It is
> tested on my MSI MegaPC 651 which is SiS chipset based.
> 
> The driver is written for the Linux 2.6.4 kernel, if you want to compile
> it just add 
> obj-m += adm1030.o 
> to the drivers/i2c/chips/Makefile. It's ugly, but if you do not see a
> lot of issues in the code, I'll prepare a patch for the latest 2.6.5-mm
> kernel.
> 
> What the driver can do :
> 	- Read system temperature ( temp_local_in )
> 	- Read CPU Temperature ( temp_remote_in )
> 	- Set minimum CPU fan speed ( fan_rpm )
> 	- Read CPU fan speed (pwm_input)
> 
> What is it supposed to do but not verified correctly:
> 	- temp_local_min, temp_local_range are the values to start the fan and
> the range to let the fan active. 
> 	- temp_remote_min, temp_remote_range are the values to start the fan
> and the range to let the fan active. 
> 
> Please give me your feedbacks,
> 
> Thanks,
> 
> Alex.
> 
> The code is following inlined :
> 
> ++++++++++++++++++++++++++ adm1030.c +++++++++++++++++++++++++++++++++++
> /*
>     adm1030.c - Part of lm_sensors, Linux kernel modules for hardware
>              monitoring
>     Based on lm75.c
>     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
>     Copyright (c) 2004 Alexandre d'Alton <alex@alexdalton.org>
> 
>     This program is free software; you can redistribute it and/or modify
>     it under the terms of the GNU General Public License as published by
>     the Free Software Foundation; either version 2 of the License, or
>     (at your option) any later version.
> 
>     This program is distributed in the hope that it will be useful,
>     but WITHOUT ANY WARRANTY; without even the implied warranty of
>     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>     GNU General Public License for more details.
> 
>     You should have received a copy of the GNU General Public License
>     along with this program; if not, write to the Free Software
>     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> */
> 
> #include <linux/config.h>
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/slab.h>
> #include <linux/i2c.h>
> #include <linux/i2c-sensor.h>
> #include "adm1030.h"
> 
> 
> /* Addresses to scan */
> static unsigned short normal_i2c[] = { I2C_CLIENT_END };
> static unsigned short normal_i2c_range[] = { 0x2e, I2C_CLIENT_END };
> static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
> static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
> 
> /* Insmod parameters */
> SENSORS_INSMOD_1(adm1030);
> 
> 
> /* Each client has this additional data */
> struct adm1030_data {
>   struct semaphore	update_lock;
>   char			valid;		/* !=0 if following fields are valid */
>   unsigned long		last_updated;	/* In jiffies */
>   u16			temp_local_in;	/* Register values */
>   u16			temp_remote_in;
>   u16			fan_rpm;
>   u16		        conf1;
>   u16			conf2;
>   u16			ftac;
>   u16			pwm;
>   u16                   temp_local_min;
>   u16                   temp_local_range;
>   u16                   temp_remote_min;
>   u16                   temp_remote_range;
> };
> 
> static int adm1030_attach_adapter(struct i2c_adapter *adapter);
> static int adm1030_detect(struct i2c_adapter *adapter, int address, int
> kind);
> static void adm1030_init_client(struct i2c_client *client);
> static int adm1030_detach_client(struct i2c_client *client);
> static int adm1030_read_value(struct i2c_client *client, u8 reg);
> static int adm1030_write_value(struct i2c_client *client, u8 reg, u16
> value);
> static struct adm1030_data *adm1030_update_device(struct device *dev);
> 
> 
> /* This is the driver that will be inserted */
> static struct i2c_driver adm1030_driver = {
> 	.owner		= THIS_MODULE,
> 	.name		= "adm1030",
> 	.id		= I2C_DRIVERID_ADM1030,
> 	.flags		= I2C_DF_NOTIFY,
> 	.attach_adapter	= adm1030_attach_adapter,
> 	.detach_client	= adm1030_detach_client,
> };
> 
> static int adm1030_id = 0;
> 
> #define show(value)	\
> static ssize_t show_##value(struct device *dev, char *buf)		\
> {									\
> 	struct adm1030_data *data = adm1030_update_device(dev);		\
> 	return sprintf(buf, "%d\n", data->value);	\
> }
> show(temp_local_in);
> show(temp_remote_in);
> show(conf1);
> show(conf2);
> show(ftac);
> show(pwm);
> show(temp_local_min);
> show(temp_local_range);
> show(temp_remote_min);
> show(temp_remote_range);
> 
> static ssize_t show_fan_rpm(struct device *dev, char *buf)		
> {									
>   int fan_speed;
>   struct adm1030_data *data = adm1030_update_device(dev);		
>   fan_speed = (11250 * 60) / (data->fan_rpm * 8);
>   return sprintf(buf, "%d\n", fan_speed);	
> }
> 
> #define set(value, reg)	\
> static ssize_t set_##value(struct device *dev, const char *buf, size_t
> count)	\
> {								\
> 	struct i2c_client *client = to_i2c_client(dev);		\
> 	struct adm1030_data *data = i2c_get_clientdata(client);	\
> 	int temp = simple_strtoul(buf, NULL, 10);		\
> 	data->value = temp;			\
> 	adm1030_write_value(client, reg, data->value);		\
> 	return count;						\
> }
> 
> set(conf1, ADM1030_REG_CONF1);
> set(conf2, ADM1030_REG_CONF2);
> set(ftac, ADM1030_REG_FTAC);
> set(pwm, ADM1030_REG_FSP);
> 
> void set_temp_min(struct i2c_client *client, int value, int reg)
> {
>   int val = adm1030_read_value(client, reg);
>   val = ( ( ( value >> 2 ) & 0x1f ) << 3 ) | ( val & 0x7 ); 
>   adm1030_write_value(client, reg, val);
> }
> void set_temp_range(struct i2c_client *client, int value, int reg)
> {
>   int val = adm1030_read_value(client, reg);
>   switch (value) {
>   case 5: value = 0; break;
>   case 10: value = 1; break;
>   case 20: value = 2; break;
>   case 40: value = 3; break;
>   case 80: value = 4; break;
>   default: return;
>   }
>   val = (val&0xf8) | (value & 0x7); 
>   adm1030_write_value(client, reg, val);
> }
> 
> static ssize_t set_temp_local_min(struct device *dev, const char *buf,
> size_t
> 				  count) 
> {
>   struct i2c_client * client = to_i2c_client(dev);
>   int temp = simple_strtoul(buf, NULL, 10);		
>   set_temp_min(client, temp, ADM1030_REG_LTR);
>   return count;
> }
> static ssize_t set_temp_local_range(struct device *dev, const char *buf,
> size_t
> 				  count) 
> {
>   struct i2c_client * client = to_i2c_client(dev);
>   int temp = simple_strtoul(buf, NULL, 10);		
>   set_temp_range(client, temp, ADM1030_REG_LTR);
>   return count;
>   
> }
> static ssize_t set_temp_remote_min(struct device *dev, const char *buf,
> size_t
> 				  count) 
> {
>   struct i2c_client * client = to_i2c_client(dev);
>   int temp = simple_strtoul(buf, NULL, 10);		
>   set_temp_min(client, temp, ADM1030_REG_RTR);
>   return count;  
> }
> 
> static ssize_t set_temp_remote_range(struct device *dev, const char
> *buf, size_t
> 				  count) 
> {
>   struct i2c_client * client = to_i2c_client(dev);
>   int temp = simple_strtoul(buf, NULL, 10);		
>   set_temp_range(client, temp, ADM1030_REG_RTR);
>   return count;
>   
> }
> 
> //static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
> set_temp_max);
> //static DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_hyst,
> set_temp_hyst);
> static DEVICE_ATTR(conf1, S_IWUSR | S_IRUGO, show_conf1, set_conf1);
> static DEVICE_ATTR(conf2, S_IWUSR | S_IRUGO, show_conf2, set_conf2);
> static DEVICE_ATTR(ftac, S_IWUSR | S_IRUGO, show_ftac, set_ftac);
> static DEVICE_ATTR(pwm, S_IWUSR | S_IRUGO, show_pwm, set_pwm);
> static DEVICE_ATTR(temp_local_in, S_IRUGO, show_temp_local_in, NULL);
> static DEVICE_ATTR(temp_remote_in, S_IRUGO, show_temp_remote_in, NULL);
> static DEVICE_ATTR(fan_rpm, S_IRUGO , show_fan_rpm, NULL);
> static DEVICE_ATTR(temp_local_min, S_IRUGO | S_IWUSR, 
> 		   show_temp_local_min, set_temp_local_min);
> static DEVICE_ATTR(temp_local_range, S_IRUGO | S_IWUSR, 
> 		   show_temp_local_range, set_temp_local_range);
> static DEVICE_ATTR(temp_remote_min, S_IRUGO | S_IWUSR, 
> 		   show_temp_remote_min, set_temp_remote_min);
> static DEVICE_ATTR(temp_remote_range, S_IRUGO | S_IWUSR, 
> 		   show_temp_remote_range, set_temp_remote_range);
> 
> static int adm1030_attach_adapter(struct i2c_adapter *adapter)
> {
> 	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
> 		return 0;
> 	return i2c_detect(adapter, &addr_data, adm1030_detect);
> }
> 
> /* This function is called by i2c_detect */
> static int adm1030_detect(struct i2c_adapter *adapter, int address, int
> kind)
> {
> 	int id, co;
> 	struct i2c_client *new_client;
> 	struct adm1030_data *data;
> 	int err = 0;
> 	const char *name = "";
> 
> 	/* Make sure we aren't probing the ISA bus!! This is just a safety
> check
> 	   at this moment; i2c_detect really won't call us. */
> #ifdef DEBUG
> 	if (i2c_is_isa_adapter(adapter)) {
> 		dev_dbg(&adapter->dev,
> 			"adm1030_detect called for an ISA bus adapter?!?\n");
> 		goto exit;
> 	}
> #endif
> 
> 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> 				     I2C_FUNC_SMBUS_WORD_DATA))
> 		goto exit;
> 
> 	/* OK. For now, we presume we have a valid client. We now create the
> 	   client structure, even though we cannot fill it completely yet.
> 	   But it allows us to access lm75_{read,write}_value. */
> 	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
> 				   sizeof(struct adm1030_data),
> 				   GFP_KERNEL))) {
> 		err = -ENOMEM;
> 		goto exit;
> 	}
> 	memset(new_client, 0x00, sizeof(struct i2c_client) +
> 				 sizeof(struct adm1030_data));
> 
> 	data = (struct adm1030_data *) (new_client + 1);
> 	i2c_set_clientdata(new_client, data);
> 	new_client->addr = address;
> 	new_client->adapter = adapter;
> 	new_client->driver = &adm1030_driver;
> 	new_client->flags = 0;
> 
> 	/* Now, we do the remaining detection. It is lousy. */
> 	if (kind < 0) {
> 		id = i2c_smbus_read_byte_data(new_client, 0x3d);
> 		co = i2c_smbus_read_byte_data(new_client, 0x3e);
> 		
> 		//		printk("read values@%x : %x %x\n", address, id, co);
> 		
> 		if((id != 0x30) && (co != 0x41))
> 		  goto exit_free;
> 	}
> 
> 	/* Determine the chip type - only one kind supported! */
> 	if (kind <= 0)
> 		kind = adm1030;
> 
> 	if (kind = adm1030) {
> 		name = "adm1030";
> 	}
> 
> 	/* Fill in the remaining client fields and put it into the global list
> */
> 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
> 
> 	new_client->id = adm1030_id++;
> 	data->valid = 0;
> 	init_MUTEX(&data->update_lock);
> 
> 	/* Tell the I2C layer a new client has arrived */
> 	if ((err = i2c_attach_client(new_client)))
> 		goto exit_free;
> 
> 	/* Initialize the LM75 chip */
> 	adm1030_init_client(new_client);
> 	
> 	/* Register sysfs hooks */
> 	device_create_file(&new_client->dev, &dev_attr_temp_local_in);
> 	device_create_file(&new_client->dev, &dev_attr_temp_remote_in);
> 	device_create_file(&new_client->dev, &dev_attr_fan_rpm);
> 
> 	/* Following entries are for debugging purpose only, commented
> 	 * out. These are access to HW configuration registers. 
> 	 */
> 	/*
> 	  device_create_file(&new_client->dev, &dev_attr_conf1);
> 	  device_create_file(&new_client->dev, &dev_attr_conf2);
> 	  device_create_file(&new_client->dev, &dev_attr_ftac);
> 	*/
> 	device_create_file(&new_client->dev, &dev_attr_pwm);
> 
> 	device_create_file(&new_client->dev, &dev_attr_temp_local_min);
> 	device_create_file(&new_client->dev, &dev_attr_temp_local_range);
> 	device_create_file(&new_client->dev, &dev_attr_temp_remote_min);
> 	device_create_file(&new_client->dev, &dev_attr_temp_remote_range);
> 
> 	return 0;
> 
> exit_free:
> 	kfree(new_client);
> exit:
> 	return err;
> }
> 
> static int adm1030_detach_client(struct i2c_client *client)
> {
> 	i2c_detach_client(client);
> 	kfree(client);
> 	return 0;
> }
> 
> static int adm1030_read_value(struct i2c_client *client, u8 reg)
> {
>   return i2c_smbus_read_byte_data(client, reg);
> }
> 
> static int adm1030_write_value(struct i2c_client *client, u8 reg, u16
> value)
> {
>   return i2c_smbus_write_byte_data(client, reg, value);
> }
> 
> static void adm1030_init_client(struct i2c_client *client)
> {
>   int read_val;
> 	/* Initialize the ADM1030 chip (enables fan speed reading )*/
> 	adm1030_write_value(client, ADM1030_REG_CONF2, 0x3f);
> 
> 	/* Increase the accuracy on rpm measurements */
> 	read_val = adm1030_read_value(client, ADM1030_REG_FCH);
> 	adm1030_write_value(client, ADM1030_REG_FCH, 0xc0 | read_val);
> 
> }
> 
> static struct adm1030_data *adm1030_update_device(struct device *dev)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	struct adm1030_data *data = i2c_get_clientdata(client);
> 	int temp_range;
> 	static unsigned short values[5] = {5, 10, 20, 40, 80};
> 	
> 	down(&data->update_lock);
> 
> 	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
> 	    (jiffies < data->last_updated) || !data->valid) {
> 		dev_dbg(&client->dev, "Starting adm1030 update\n");
> 
> 		data->temp_local_in = adm1030_read_value(client,
> ADM1030_REG_TEMP_INT);
> 		data->temp_remote_in = adm1030_read_value(client,
> ADM1030_REG_TEMP_EXT);
> 		data->fan_rpm      = adm1030_read_value(client,
> 							  ADM1030_REG_FAN_SPEED);
> 		temp_range = adm1030_read_value(client,	ADM1030_REG_LTR);
> 		data->temp_local_min = ((temp_range >> 3) & 0x1f) * 4;
> 		data->temp_local_range = (values[temp_range&0x7]);
> 
> 		temp_range = adm1030_read_value(client,	ADM1030_REG_RTR);
> 		data->temp_remote_min = ((temp_range >> 3) & 0x1f) * 4;
> 		data->temp_remote_range = (values[temp_range&0x7]);
> 
> 		data->conf1 = adm1030_read_value(client, ADM1030_REG_CONF1);
> 		data->conf2 = adm1030_read_value(client, ADM1030_REG_CONF2);
> 		data->ftac      = adm1030_read_value(client, ADM1030_REG_FTAC);
> 		data->pwm      = 0xf & adm1030_read_value(client, ADM1030_REG_FSP);
> 		data->last_updated = jiffies;
> 		data->valid = 1;
> 	}
> 
> 	up(&data->update_lock);
> 
> 	return data;
> }
> 
> static int __init sensors_adm1030_init(void)
> {
> 	return i2c_add_driver(&adm1030_driver);
> }
> 
> static void __exit sensors_adm1030_exit(void)
> {
> 	i2c_del_driver(&adm1030_driver);
> }
> 
> MODULE_AUTHOR("Alexandre d'Alton <alex@alexdalton.org>");
> MODULE_DESCRIPTION("ADM1030 driver");
> MODULE_LICENSE("GPL");
> 
> module_init(sensors_adm1030_init);
> module_exit(sensors_adm1030_exit);
> +++++++++++++++++++++++++ end adm1030.c ++++++++++++++++++++++++++++++++
> 
> 
> +++++++++++++++++++++++++++++ adm1030.h ++++++++++++++++++++++++++++++++
> /*
>     adm1030.h - Part of lm_sensors, Linux kernel modules for hardware
>              monitoring
>     Copyright (c) 2004 Alexandre d'Alton <alex@alexdalton.org>
> 
>     This program is free software; you can redistribute it and/or modify
>     it under the terms of the GNU General Public License as published by
>     the Free Software Foundation; either version 2 of the License, or
>     (at your option) any later version.
> 
>     This program is distributed in the hope that it will be useful,
>     but WITHOUT ANY WARRANTY; without even the implied warranty of
>     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>     GNU General Public License for more details.
> 
>     You should have received a copy of the GNU General Public License
>     along with this program; if not, write to the Free Software
>     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> */
> 
> /*
>     This file contains common code for encoding/decoding LM75 type
>     temperature readings, which are emulated by many of the chips
>     we support.  As the user is unlikely to load more than one driver
>     which contains this code, we don't worry about the wasted space.
> */
> 
> #include <linux/i2c-sensor.h>
> 
> /* Many ADM1030 constants specified below */
> /* The ADM1030 registers */
> /* Configuration register 1 */
> #define ADM1030_REG_CONF1		0x00
> #define ADM1030_CONF1_MEN               0x01 /* monitoring enable */
> #define ADM1030_CONF1_IEN               0x02 /* INT enable */
> #define ADM1030_CONF1_TMODE             0x04 /* Tach/Ain mode */
> #define ADM1030_CONF1_PINV              0x08 /* PWM Invert */
> #define ADM1030_CONF1_FFE               0x10 /* Fan Fault Enable */
> #define ADM1030_CONF1_PMODE             0x60 /* PWM Mode 00 = Remote
> 						control Fan (Select
> 						PWM when manual) 11 > 						Fastest Calc speed
> 						controls fan (Select
> 						RPM when manual)*/
> #define ADM1030_CONF1_AEN               0x80 /* Auto / SW Control */
> 
> /* Configuration register 2 */
> #define ADM1030_REG_CONF2		0x01
> #define ADM1030_CONF2_PEN               0x01 /* PWM1 Enable */
> #define ADM1030_CONF2_UN1               0x02 /* Unused */
> #define ADM1030_CONF2_TIEN              0x04 /* TACH input Enable  */
> #define ADM1030_CONF2_UN2               0x08 /* Unused */
> #define ADM1030_CONF2_LTE               0x10 /* Local temp enable */
> #define ADM1030_CONF2_RTE               0x20 /* Remote temp enable */
> #define ADM1030_CONF2_UN3               0x40 /* Unused */
> #define ADM1030_CONF2_SWR               0x80 /* SW Reset */
> 
> /* STATUS register 1 */
> #define ADM1030_REG_STAT1		0x02
> #define ADM1030_STAT1_ASP               0x01 /* Alarm Speed  */
> #define ADM1030_STAT1_FF                0x02 /* Fan Fault */
> #define ADM1030_STAT1_RTH               0x04 /* Remote Temp High  */
> #define ADM1030_STAT1_RTL               0x08 /* Remote Temp Low */
> #define ADM1030_STAT1_RTT               0x10 /* Remote Temp Therm */
> #define ADM1030_STAT1_RDE               0x20 /* Remote Diode Error */
> #define ADM1030_STAT1_LTH               0x40 /* Local Temp High */
> #define ADM1030_STAT1_LTL               0x80 /* Loc Temp Low */
> 
> /* STATUS register 2 */
> #define ADM1030_REG_STAT2		0x03
> #define ADM1030_STAT2_UN1               0x3f /* Unused  */
> #define ADM1030_STAT2_LTH               0x40 /* Local Temp Therm */
> #define ADM1030_STAT2_LTL               0x80 /* Therm Status */
> 
> /* Extended Temp register  */
> #define ADM1030_REG_EXT 		0x06
> #define ADM1030_EXT_ASP                 0x07 /* Remote extended temp
> range  */
> #define ADM1030_EXT_LTH                 0x38 /* Unused  */
> #define ADM1030_EXT_LTL                 0xc0 /* Local extended temp
> range */
> 
> /* Fan charasteristic register  */
> #define ADM1030_REG_FCH 		0x20
> #define ADM1030_FCH_FSU                 0x07 /* Fan spin up  */
> #define ADM1030_EXT_PWMF                0x38 /* PWM Freq  */
> #define ADM1030_EXT_SPR                 0xc0 /* Speed range */
> 
> /* Fan Speed register  */
> #define ADM1030_REG_FSP 		0x22
> #define ADM1030_FSP_NSP                 0x0f /* Fan min speed  */
> 
> /* Fan Filter register  */
> #define ADM1030_REG_FLT 		0x23
> #define ADM1030_FLT_SUD                 0x80 /* Spin up disable  */
> #define ADM1030_FLT_RR                  0x60 /* Ramp rate  */
> #define ADM1030_FLT_ASR                 0x1c /* ADC Sample rate  */
> #define ADM1030_FLT_UN1                 0x02 /* Unused  */
> #define ADM1030_FLT_FFE                 0x01 /* Fan Filter enable */
> 
> /* Local Temp Tmin / Trange  */
> #define ADM1030_REG_LTR 		0x24
> /* Remote Temp Tmin / Trange */
> #define ADM1030_REG_RTR 		0x25
> #define ADM1030_TR_TM                  0xf8 /* Local Temp Tmin  */
> #define ADM1030_TR_TR                  0x60 /* Local Temp Trange  */
> 
> /* Therm to Fan  */
> #define ADM1030_REG_TTF 		0x3f
> #define ADM1030_TTF_EN                  0x80 /* Therm to fan enable */
> 
> #define ADM1030_REG_FAN_SPEED   	0x08
> #define ADM1030_REG_FTAC		0x10
> 
> #define ADM1030_REG_TEMP_INT		0x0a
> #define ADM1030_REG_TEMP_EXT		0x0b
> 
> 
> +++++++++++++++++++++++++ end adm1030.h ++++++++++++++++++++++++++++++++
> 
> 
> 
