From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: ADM1030 Driver
Message-Id: <1081455076.3948.4.camel@megapc>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All,

Updated version of the ADM1030 driver according to Jean's remarks.

	- removed adm1030.h header file
	- removed unused code.
	- cleaned registers accesses
	- try to respect the sysfs naming conventions.
	- renamed temp?_min to temp?_amin
	- added temp?_min, temp?_max and temp?_crit access

Thanks for the feedbacks.

Alex.




/*
    adm1030.c - Part of lm_sensors, Linux kernel modules for hardware
             monitoring
    Based on lm75.c
    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
    Copyright (c) 2004 Alexandre d'Alton <alex@alexdalton.org>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/i2c.h>
#include <linux/i2c-sensor.h>


/* Many ADM1030 constants specified below */
#define ADM1030_CONF1_MEN               0x01 /* monitoring enable */
#define ADM1030_CONF1_AEN               0x80 /* Auto / SW Control */

#define ADM1030_REG_FAN_SPEED(nr)   	(0x08 + (nr))

#define ADM1030_REG_FAN_DIV(nr)		(0x20  + (nr))
#define ADM1030_REG_FTAC(nr)		(0x10 + (nr))
#define ADM1030_REG_FSP(nr)		(0x22 + (nr))


#define ADM1030_REG_TEMP_HLM(nr)		(0x14  + 4*(nr))
#define ADM1030_REG_TEMP_LLM(nr)		(0x15  + 4*(nr))
#define ADM1030_REG_TEMP_TLM(nr)		(0x16  + 4*(nr))

/* Temperature values (nr = 1 (local) / 2 (remote)) */
#define ADM1030_REG_TEMP(nr)		        (0xa + (nr))
#define ADM1030_REG_TEMP_RNG(nr)		(0x24 + (nr))

/* Temperature values (nr = 1 (local) / 2 (remote)) */
#define ADM1030_REG_CONF(nr)		        (nr)


/* Addresses to scan */
static unsigned short normal_i2c[] = { I2C_CLIENT_END };
static unsigned short normal_i2c_range[] = { 0x2c, 0x2e, I2C_CLIENT_END
};
static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };

/* Insmod parameters */
SENSORS_INSMOD_1(adm1030);

static u16 adm1030_fan_div = 1;
 
/* Each client has this additional data */
struct adm1030_data {
  struct semaphore	update_lock;
  char			valid;		/* !=0 if following fields are valid */
  unsigned int		last_updated;	/* In jiffies */
  unsigned int		fan_input[1];
  unsigned int	       	fan_div[1];
  unsigned int	       	pwm[1];
  unsigned int          temp_input[2];
  unsigned int          temp_min[2];
  unsigned int          temp_range[2];
  unsigned int          temp_low_limit[2];
  unsigned int          temp_high_limit[2];
  unsigned int          temp_therm_limit[2];
};

static int adm1030_attach_adapter(struct i2c_adapter *adapter);
static int adm1030_detect(struct i2c_adapter *adapter, int address, int
kind);
static void adm1030_init_client(struct i2c_client *client);
static int adm1030_detach_client(struct i2c_client *client);
static int adm1030_read_value(struct i2c_client *client, u8 reg);
static int adm1030_write_value(struct i2c_client *client, u8 reg,
unsigned int value);
static struct adm1030_data *adm1030_update_device(struct device *dev);


/* This is the driver that will be inserted */
static struct i2c_driver adm1030_driver = {
	.owner		= THIS_MODULE,
	.name		= "adm1030",
	.flags		= I2C_DF_NOTIFY,
	.attach_adapter	= adm1030_attach_adapter,
	.detach_client	= adm1030_detach_client,
};

static int adm1030_id = 0;

/* These macros converts registers values to sysfs-sensors compliant
 * values
 */
#define to_display_temp_low_limit(reg) ((reg) * 1000)
#define to_display_temp_high_limit(reg) ((reg) * 1000)
#define to_display_temp_therm_limit(reg) ((reg) * 1000)
#define to_display_temp_input(reg) ((reg) * 1000)
#define to_display_temp_min(reg)   (1000 * ((((reg) >> 3) & 0x1f) << 2))
#define to_display_temp_range(reg) (5000 * (1<<((reg)&0x07)))
#define to_display_fan_input(reg)  ((reg) ? (11250 * 60) / ((reg)
*               \
						    adm1030_fan_div) : 0)
#define to_display_fan_div(reg)    (1 << (((reg) & 0xc0)>>6))
#define to_display_pwm(reg)        ((reg)<<4)

/* These macros converts sysfs-sensors compliant values into
 * corresponding register value.
 */
#define to_reg_temp_min(reg, val) ((((val)/500) & 0xf8)|((reg) & 0x7))
#define to_reg_temp_range(reg, val) (((reg) & 0xf8) | \
(((val)<10000 ? 0 :                                   \
  (val)<20000 ? 1 :                                   \
  (val)<40000 ? 2 :                                   \
  (val)<80000 ? 3 : 4) & 7))
static inline int to_reg_fan_div(unsigned int reg, unsigned int val) 
{
  adm1030_fan_div = val;
  return ((reg & 0x3f) | 
	  ((val = 8 ? 0xc0 :                                            
	    val = 4 ? 0x80 :                                                
	    val = 2 ? 0x40 :                                                
	    val = 1 ? 0x00 : reg & 0xc0))); 
}
#define to_reg_pwm(reg, val) ((val) >> 4)
#define to_reg_temp_low_limit(reg, val) ((val) / 1000)
#define to_reg_temp_high_limit(reg, val) ((val) / 1000)
#define to_reg_temp_therm_limit(reg, val) ((val) / 1000)

#define show(value, nr)	\
static ssize_t show_##value##_##nr(struct device *dev, char *buf)		\
{									\
	struct adm1030_data *data = adm1030_update_device(dev);		\
	return sprintf(buf, "%u\n", to_display_##value(data->value[(nr)-1]));	\
}
show(pwm, 1);
show(temp_min, 1);
show(temp_min, 2);
show(temp_low_limit, 1);
show(temp_low_limit, 2);
show(temp_high_limit, 1);
show(temp_high_limit, 2);
show(temp_therm_limit, 1);
show(temp_therm_limit, 2);
show(temp_range, 1);
show(temp_range, 2);
show(temp_input, 1);
show(temp_input, 2);
show(fan_input, 1);
show(fan_div, 1);

#define set(value, reg, nr)	\
static ssize_t set_##value##_##nr(struct device *dev, const char *buf,
size_t count)	\
{								                \
	struct i2c_client *client = to_i2c_client(dev);		                \
	int temp = simple_strtoul(buf, NULL, 10);		                \
        int old_val = adm1030_read_value(client,
reg((nr)-1));                          \
	adm1030_write_value(client, reg((nr)-1), to_reg_##value(old_val,
temp));	\
	return count;						                \
}
set(temp_min,   ADM1030_REG_TEMP_RNG, 1);
set(temp_min,   ADM1030_REG_TEMP_RNG, 2);
set(temp_range, ADM1030_REG_TEMP_RNG, 1);
set(temp_range, ADM1030_REG_TEMP_RNG, 2);
set(pwm,        ADM1030_REG_FSP,      1);
set(fan_div,    ADM1030_REG_FAN_DIV,  1);

set(temp_low_limit,     ADM1030_REG_TEMP_LLM, 1);
set(temp_high_limit,    ADM1030_REG_TEMP_HLM, 1);
set(temp_therm_limit,   ADM1030_REG_TEMP_TLM, 1);
set(temp_low_limit,     ADM1030_REG_TEMP_LLM, 2);
set(temp_high_limit,    ADM1030_REG_TEMP_HLM, 2);
set(temp_therm_limit,   ADM1030_REG_TEMP_TLM, 2);

static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input_1, NULL);
static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input_2, NULL);

static DEVICE_ATTR(pwm,         S_IWUSR | S_IRUGO, show_pwm_1,
		   set_pwm_1);
static DEVICE_ATTR(fan_div,     S_IRUGO | S_IWUSR, show_fan_div_1,
		   set_fan_div_1);
static DEVICE_ATTR(fan_input,   S_IRUGO          , show_fan_input_1,   
		   NULL);
static DEVICE_ATTR(temp1_min,   S_IRUGO | S_IWUSR,
show_temp_low_limit_1,    
		   set_temp_low_limit_1);
static DEVICE_ATTR(temp1_max,   S_IRUGO | S_IWUSR,
show_temp_high_limit_1,    
		   set_temp_high_limit_1);
static DEVICE_ATTR(temp1_crit,   S_IRUGO | S_IWUSR,
show_temp_therm_limit_1,    
		   set_temp_therm_limit_1);
static DEVICE_ATTR(temp2_min,   S_IRUGO | S_IWUSR,
show_temp_low_limit_2,    
		   set_temp_low_limit_2);
static DEVICE_ATTR(temp2_max,   S_IRUGO | S_IWUSR,
show_temp_high_limit_2,    
		   set_temp_high_limit_2);
static DEVICE_ATTR(temp2_crit,   S_IRUGO | S_IWUSR,
show_temp_therm_limit_2,    
		   set_temp_therm_limit_2);
static DEVICE_ATTR(temp1_amin,   S_IRUGO | S_IWUSR, show_temp_min_1,    
		   set_temp_min_1);
static DEVICE_ATTR(temp1_range, S_IRUGO | S_IWUSR, show_temp_range_1, 
		   set_temp_range_1);
static DEVICE_ATTR(temp2_amin,   S_IRUGO | S_IWUSR, show_temp_min_2,    
		   set_temp_min_2);
static DEVICE_ATTR(temp2_range, S_IRUGO | S_IWUSR, show_temp_range_2,  
		   set_temp_range_2);

static int adm1030_attach_adapter(struct i2c_adapter *adapter)
{
	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
		return 0;
	return i2c_detect(adapter, &addr_data, adm1030_detect);
}

/* This function is called by i2c_detect */
static int adm1030_detect(struct i2c_adapter *adapter, int address, int
kind)
{
	struct i2c_client *new_client;
	struct adm1030_data *data;
	int err = 0;
	const char *name = "";

	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
				     I2C_FUNC_SMBUS_WORD_DATA))
		goto exit;

	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
				   sizeof(struct adm1030_data),
				   GFP_KERNEL))) {
		err = -ENOMEM;
		goto exit;
	}
	memset(new_client, 0x00, sizeof(struct i2c_client) +
				 sizeof(struct adm1030_data));

	data = (struct adm1030_data *) (new_client + 1);
	i2c_set_clientdata(new_client, data);
	new_client->addr = address;
	new_client->adapter = adapter;
	new_client->driver = &adm1030_driver;
	new_client->flags = 0;

	/* Now, we do the remaining detection. It is lousy. */
	if (kind < 0) {
	  int id, co;
	  id = i2c_smbus_read_byte_data(new_client, 0x3d);
	  co = i2c_smbus_read_byte_data(new_client, 0x3e);
	  
	  if((id != 0x30) && (co != 0x41))
	    goto exit_free;
	}

	/* Determine the chip type - only one kind supported! */
	if (kind <= 0)
		kind = adm1030;

	if (kind = adm1030) {
		name = "adm1030";
	}

	/* Fill in the remaining client fields and put it into the global list
*/
	strlcpy(new_client->name, name, I2C_NAME_SIZE);

	new_client->id = adm1030_id++;
	data->valid = 0;
	init_MUTEX(&data->update_lock);

	/* Tell the I2C layer a new client has arrived */
	if ((err = i2c_attach_client(new_client)))
		goto exit_free;

	/* Initialize the LM75 chip */
	adm1030_init_client(new_client);
	
	/* Register sysfs hooks */
	device_create_file(&new_client->dev, &dev_attr_temp1_input);
	device_create_file(&new_client->dev, &dev_attr_temp2_input);
	device_create_file(&new_client->dev, &dev_attr_fan_input);
	device_create_file(&new_client->dev, &dev_attr_fan_div);
	device_create_file(&new_client->dev, &dev_attr_pwm);
	device_create_file(&new_client->dev, &dev_attr_temp1_amin);
	device_create_file(&new_client->dev, &dev_attr_temp1_range);
	device_create_file(&new_client->dev, &dev_attr_temp1_min);
	device_create_file(&new_client->dev, &dev_attr_temp1_max);
	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
	device_create_file(&new_client->dev, &dev_attr_temp2_amin);
	device_create_file(&new_client->dev, &dev_attr_temp2_range);
	device_create_file(&new_client->dev, &dev_attr_temp2_min);
	device_create_file(&new_client->dev, &dev_attr_temp2_max);
	device_create_file(&new_client->dev, &dev_attr_temp2_crit);

	return 0;

exit_free:
	kfree(new_client);
exit:
	return err;
}

static int adm1030_detach_client(struct i2c_client *client)
{
	i2c_detach_client(client);
	kfree(client);
	return 0;
}

static int adm1030_read_value(struct i2c_client *client, u8 reg)
{
  return i2c_smbus_read_byte_data(client, reg);
}

static int adm1030_write_value(struct i2c_client *client, u8 reg,
unsigned int value)
{
  return i2c_smbus_write_byte_data(client, reg, value);
}

static void adm1030_init_client(struct i2c_client *client)
{
  unsigned int read_val;
  /* Initialize the ADM1030 chip (enables fan speed reading )*/
  read_val = adm1030_read_value(client, ADM1030_REG_CONF(0));
  adm1030_write_value(client, ADM1030_REG_CONF(0), read_val |
		      ADM1030_CONF1_MEN);
  adm1030_fan_div = 
    to_display_fan_div(adm1030_read_value(client,
ADM1030_REG_FAN_DIV(0)));    

}

static struct adm1030_data *adm1030_update_device(struct device *dev)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct adm1030_data *data = i2c_get_clientdata(client);
	int chan;

	down(&data->update_lock);

	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
	    (jiffies < data->last_updated) || !data->valid) {
		dev_dbg(&client->dev, "Starting adm1030 update\n");
		
		for (chan = 0; chan < 2; chan++){
		  data->temp_input[chan] 		    adm1030_read_value(client, 
				       ADM1030_REG_TEMP(chan));
		  data->temp_range[chan] = data->temp_min[chan] 		    adm1030_read_value(client, 
				       ADM1030_REG_TEMP_RNG(chan));
		  data->temp_low_limit[chan] = 
		    adm1030_read_value(client, 
				       ADM1030_REG_TEMP_LLM(chan));
		  data->temp_high_limit[chan] = 
		    adm1030_read_value(client, 
				       ADM1030_REG_TEMP_HLM(chan));
		  data->temp_therm_limit[chan] = 
		    adm1030_read_value(client, 
				       ADM1030_REG_TEMP_TLM(chan));

		}
		
		data->fan_div[0]   = 
		  adm1030_read_value(client,
				     ADM1030_REG_FAN_DIV(0)); 
		data->fan_input[0] 		  adm1030_read_value(client,
				     ADM1030_REG_FAN_SPEED(0));
		data->pwm[0]       = 0xf & adm1030_read_value(client,
ADM1030_REG_FSP(0));
		data->last_updated = jiffies;
		data->valid = 1;
	}

	up(&data->update_lock);

	return data;
}

static int __init sensors_adm1030_init(void)
{
	return i2c_add_driver(&adm1030_driver);
}

static void __exit sensors_adm1030_exit(void)
{
	i2c_del_driver(&adm1030_driver);
}

MODULE_AUTHOR("Alexandre d'Alton <alex@alexdalton.org>");
MODULE_DESCRIPTION("ADM1030 driver");
MODULE_LICENSE("GPL");

module_init(sensors_adm1030_init);
module_exit(sensors_adm1030_exit);

