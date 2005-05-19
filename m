From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: ADM1031 Driver
Message-Id: <1082411316.656.34.camel@megapc>
List-Id: <lm-sensors.vger.kernel.org>
References: <6DEE94132593D41182D200508BDCA590A2C19F@mail.tricord.com>
In-Reply-To: <6DEE94132593D41182D200508BDCA590A2C19F@mail.tricord.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is the new version of the ADM1030/ADM1031 driver.

It does not support auto fan control yet.

I have modified the driver to be more inline with lm85 one. Hope that
version will satisfy Jean :)

Indentation is not yet compliant with linux coding rules... sorry.

Implementation of auto fan control comming next.

Alex.
 

/*
    adm1031.c - Part of lm_sensors, Linux kernel modules for hardware
             monitoring
    Based on lm75.c and lm85.c
    Support adm1030 / adm1031
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


/* Many ADM1031 constants specified below */
#define ADM1031_CONF1_MEN               0x01 /* monitoring enable */
#define ADM1031_CONF1_AEN               0x80 /* Auto / SW Control */

#define ADM1031_CONF2_TIEN              0x04 /* TACH input Enable  */

#define ADM1031_REG_FAN_SPEED(nr)   	(0x08 + (nr))

#define ADM1031_REG_FAN_DIV(nr)		(0x20  + (nr))
#define ADM1031_REG_PWM(nr)		(0x22)
#define ADM1031_REG_FAN_MIN(nr)		(0x10 + (nr))


#define ADM1031_REG_TEMP_MAX(nr)		(0x14  + 4*(nr))
#define ADM1031_REG_TEMP_MIN(nr)		(0x15  + 4*(nr))
#define ADM1031_REG_TEMP_CRIT(nr)		(0x16  + 4*(nr))

#define ADM1031_REG_TEMP(nr)		        (0xa + (nr))
#define ADM1031_REG_AUTO_TEMP(nr)		(0x24 + (nr))

#define ADM1031_REG_CONF(nr)		        (nr)


/* Addresses to scan */
static unsigned short normal_i2c[] = { I2C_CLIENT_END };
static unsigned short normal_i2c_range[] = { 0x2c, 0x2e, I2C_CLIENT_END
};
static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };

/* Insmod parameters */
SENSORS_INSMOD_2(adm1030, adm1031);

/* Each client has this additional data */
struct adm1031_data {
  struct semaphore	update_lock;
  int                   chip_type;
  char			valid;		/* !=0 if following fields are valid */
  unsigned int		last_updated;	/* In jiffies */
  unsigned int		conf;
  unsigned int		fan[2];
  unsigned int	       	fan_div[2];
  unsigned int	       	fan_min[2];
  unsigned int	       	pwm[2];
  unsigned int          temp[3];
  unsigned int          auto_temp[3];
  unsigned int          temp_min[3];
  unsigned int          temp_max[3];
  unsigned int          temp_crit[3];
};

static int 
adm1031_attach_adapter(struct i2c_adapter *adapter);
static int 
adm1031_detect(struct i2c_adapter *adapter, int address, int kind);
static void 
adm1031_init_client(struct i2c_client *client);
static int 
adm1031_detach_client(struct i2c_client *client);
static int 
adm1031_read_value(struct i2c_client *client, u8 reg);
static int 
adm1031_write_value(struct i2c_client *client, u8 reg, unsigned int
value);
static struct adm1031_data *
adm1031_update_device(struct device *dev);


/* This is the driver that will be inserted */
static struct i2c_driver adm1031_driver = {
	.owner		= THIS_MODULE,
	.name		= "adm1031",
	.flags		= I2C_DF_NOTIFY,
	.attach_adapter	= adm1031_attach_adapter,
	.detach_client	= adm1031_detach_client,
};

static int adm1031_id = 0;

#define TEMP_TO_REG(val)   ((val) / 1000)
#define TEMP_FROM_REG(val) ((val) * 1000)

#define FAN_FROM_REG(reg, div) ((reg) ? (11250 * 60) / ((reg) * (div)) :
0)
#define FAN_TO_REG(reg, div) FAN_FROM_REG(reg, div)

#define FAN_DIV_TO_REG(val) val = 8 ? 0xc0 :  \
	    val = 4 ? 0x80 :                  \
	    val = 2 ? 0x40 :                  \
	    val = 1 ? 0x00 : 0x00
#define FAN_DIV_FROM_REG(reg) (1<<(((reg)&0xc0)>>6))

#define PWM_TO_REG(val) (val)
#define PWM_FROM_REG(val) (val)

#define AUTO_TEMP_MIN_FROM_REG(reg) (1000 * ((((reg) >> 3) & 0x1f) <<
2))
#define AUTO_TEMP_MAX_FROM_REG(reg) (5000 * (1<<((reg)&0x07))) +
(AUTO_TEMP_MIN_FROM_REG(reg))

#define AUTO_TEMP_MIN_TO_REG(val, reg) ((((val)/500) & 0xf8)|((reg) &
0x7))
static int AUTO_TEMP_MAX_TO_REG(int val, int reg)
{
  int ret;
  int range = val - AUTO_TEMP_MIN_FROM_REG(reg);
  ret =  (((reg) & 0xf8) | \
	  (((range)<10000 ? 0 :                                   
	    (range)<20000 ? 1 :                                   
	    (range)<40000 ? 2 :                                   
	    (range)<80000 ? 3 : 4) & 7));
  return ret;
}

/* Fans */
static ssize_t show_fan(struct device *dev, char *buf, int nr)
{
	struct adm1031_data *data = adm1031_update_device(dev);
	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
						FAN_DIV_FROM_REG(data->fan_div[nr])) );
}
static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
{
	struct adm1031_data *data = adm1031_update_device(dev);
	return sprintf(buf,"%d\n", FAN_DIV_FROM_REG(data->fan_div[nr]) );
}
static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
{
	struct adm1031_data *data = adm1031_update_device(dev);
	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr], 
						FAN_DIV_FROM_REG(data->fan_div[nr])) );
}
static ssize_t set_fan_min(struct device *dev, const char *buf, 
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct adm1031_data *data = i2c_get_clientdata(client);
	int	val;

	down(&data->update_lock);
	val = simple_strtol(buf, NULL, 10);
	if (val)
	  data->fan_min[nr] = FAN_TO_REG(val,
FAN_DIV_FROM_REG(data->fan_div[nr]));
	else 
	  data->fan_min[nr] = 0xff;
	adm1031_write_value(client, ADM1031_REG_FAN_MIN(nr),
data->fan_min[nr]);
	up(&data->update_lock);
	return count;
}
static ssize_t set_fan_div(struct device *dev, const char *buf, 
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct adm1031_data *data = i2c_get_clientdata(client);
	int	val;
	int     reg = adm1031_read_value(client, ADM1031_REG_FAN_DIV(nr));
 	down(&data->update_lock);
	val = simple_strtol(buf, NULL, 10);
	data->fan_div[nr] = FAN_DIV_TO_REG(val);
	reg = (reg & 0x3f) | (data->fan_div[nr] & 0xc0);
	adm1031_write_value(client, ADM1031_REG_FAN_DIV(nr),
data->fan_div[nr]);
	up(&data->update_lock);
	return count;
}

#define show_fan_offset(offset)						\
static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
{									\
	return show_fan(dev, buf, 0x##offset - 1);			\
}									\
static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
{									\
	return show_fan_min(dev, buf, 0x##offset - 1);			\
}									\
static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
{									\
	return show_fan_div(dev, buf, 0x##offset - 1);			\
}									\
static ssize_t set_fan_##offset##_min (struct device *dev, 		\
	const char *buf, size_t count) 					\
{									\
	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
}									\
static ssize_t set_fan_##offset##_div (struct device *dev, 		\
	const char *buf, size_t count) 					\
{									\
	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
}									\
static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset,
NULL) \
static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, 		\
		show_fan_##offset##_min, set_fan_##offset##_min)        \
static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, 		\
		show_fan_##offset##_div, set_fan_##offset##_div)

show_fan_offset(1);
show_fan_offset(2);


/* pwm */

static ssize_t show_pwm(struct device *dev, char *buf, int nr)
{
	struct adm1031_data *data = adm1031_update_device(dev);
	return sprintf(buf,"%d\n", data->pwm[nr]);
}
static ssize_t set_pwm(struct device *dev, const char *buf, 
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct adm1031_data *data = i2c_get_clientdata(client);
	int	val;
	int     reg;
	down(&data->update_lock);
	val = simple_strtol(buf, NULL, 10);
	data->pwm[nr] = PWM_TO_REG(val);
	reg = adm1031_read_value(client, ADM1031_REG_PWM(nr));
	adm1031_write_value(client, ADM1031_REG_PWM(nr), 
			    nr ? ((data->pwm[nr] << 4) & 0xf0) | (reg&0xf) :
			    (data->pwm[nr] & 0xf) | (reg & 0xf0));
	up(&data->update_lock);
	return count;
}
#define show_pwm_reg(offset)						\
static ssize_t show_pwm_##offset (struct device *dev, char *buf)	\
{									\
	return show_pwm(dev, buf, 0x##offset - 1);			\
}									\
static ssize_t set_pwm_##offset (struct device *dev,			\
				 const char *buf, size_t count)		\
{									\
	return set_pwm(dev, buf, count, 0x##offset - 1);		\
}									\
static DEVICE_ATTR(fan##offset##_pwm, S_IRUGO | S_IWUSR, 			\
		show_pwm_##offset, set_pwm_##offset)

show_pwm_reg(1);
show_pwm_reg(2);

/* Temps */
static ssize_t show_temp(struct device *dev, char *buf, int nr)
{
	struct adm1031_data *data = adm1031_update_device(dev);
	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp[nr]) );
}
static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
{
	struct adm1031_data *data = adm1031_update_device(dev);
	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_min[nr]) );
}
static ssize_t set_temp_min(struct device *dev, const char *buf, 
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct adm1031_data *data = i2c_get_clientdata(client);
	int	val;

	down(&data->update_lock);
	val = simple_strtol(buf, NULL, 10);
	data->temp_min[nr] = TEMP_TO_REG(val);
	adm1031_write_value(client, ADM1031_REG_TEMP_MIN(nr),
data->temp_min[nr]);
	up(&data->update_lock);
	return count;
}
static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
{
	struct adm1031_data *data = adm1031_update_device(dev);
	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_max[nr]) );
}
static ssize_t show_temp_crit(struct device *dev, char *buf, int nr)
{
	struct adm1031_data *data = adm1031_update_device(dev);
	return sprintf(buf,"%d\n", TEMP_FROM_REG(data->temp_crit[nr]) );
}
static ssize_t set_temp_max(struct device *dev, const char *buf, 
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct adm1031_data *data = i2c_get_clientdata(client);
	int	val;

	down(&data->update_lock);
	val = simple_strtol(buf, NULL, 10);
	data->temp_max[nr] = TEMP_TO_REG(val);
	adm1031_write_value(client, ADM1031_REG_TEMP_MAX(nr),
data->temp_max[nr]);
	up(&data->update_lock);
	return count;
}
static ssize_t set_temp_crit(struct device *dev, const char *buf, 
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct adm1031_data *data = i2c_get_clientdata(client);
	int	val;

	down(&data->update_lock);
	val = simple_strtol(buf, NULL, 10);
	data->temp_max[nr] = TEMP_TO_REG(val);
	adm1031_write_value(client, ADM1031_REG_TEMP_CRIT(nr),
data->temp_crit[nr]);
	up(&data->update_lock);
	return count;
}

#define show_temp_reg(offset)						\
static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
{									\
	return show_temp(dev, buf, 0x##offset - 1);			\
}									\
static ssize_t show_temp_##offset##_min (struct device *dev, char
*buf)	\
{									\
	return show_temp_min(dev, buf, 0x##offset - 1);			\
}									\
static ssize_t show_temp_##offset##_max (struct device *dev, char
*buf)	\
{									\
	return show_temp_max(dev, buf, 0x##offset - 1);			\
}									\
static ssize_t show_temp_##offset##_crit (struct device *dev, char
*buf)	\
{									\
	return show_temp_crit(dev, buf, 0x##offset - 1);			\
}									\
static ssize_t set_temp_##offset##_min (struct device *dev, 		\
	const char *buf, size_t count) 					\
{									\
	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
}									\
static ssize_t set_temp_##offset##_max (struct device *dev, 		\
	const char *buf, size_t count) 					\
{									\
	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
}									\
static ssize_t set_temp_##offset##_crit (struct device *dev, 		\
	const char *buf, size_t count) 					\
{									\
	return set_temp_crit(dev, buf, count, 0x##offset - 1);		\
}									\
static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp_##offset,
NULL)	\
static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 		\
		show_temp_##offset##_min, set_temp_##offset##_min)	\
static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 		\
		show_temp_##offset##_max, set_temp_##offset##_max)      \
static DEVICE_ATTR(temp##offset##_crit, S_IRUGO | S_IWUSR, 		\
		show_temp_##offset##_crit, set_temp_##offset##_crit)

show_temp_reg(1);
show_temp_reg(2);
show_temp_reg(3);


/* Auto Temps */
static ssize_t show_auto_temp_off(struct device *dev, char *buf, int nr)
{
	struct adm1031_data *data = adm1031_update_device(dev);
	return sprintf(buf,"%d\n", AUTO_TEMP_MIN_FROM_REG(data->auto_temp[nr])
- 5000 );
}
static ssize_t show_auto_temp_min(struct device *dev, char *buf, int nr)
{
	struct adm1031_data *data = adm1031_update_device(dev);
	return sprintf(buf,"%d\n",AUTO_TEMP_MIN_FROM_REG(data->auto_temp[nr]));
}
static ssize_t set_auto_temp_min(struct device *dev, const char *buf, 
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct adm1031_data *data = i2c_get_clientdata(client);
	int	val;

	down(&data->update_lock);
	val = simple_strtol(buf, NULL, 10);
	data->auto_temp[nr] = AUTO_TEMP_MIN_TO_REG(val, data->auto_temp[nr]);
	adm1031_write_value(client, ADM1031_REG_AUTO_TEMP(nr),
data->auto_temp[nr]);
	up(&data->update_lock);
	return count;
}
static ssize_t show_auto_temp_max(struct device *dev, char *buf, int nr)
{
	struct adm1031_data *data = adm1031_update_device(dev);
	return sprintf(buf,"%d\n", AUTO_TEMP_MAX_FROM_REG(data->auto_temp[nr])
);
}
static ssize_t set_auto_temp_max(struct device *dev, const char *buf, 
		size_t count, int nr)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct adm1031_data *data = i2c_get_clientdata(client);
	int	val;

	down(&data->update_lock);
	val = simple_strtol(buf, NULL, 10);
	data->temp_max[nr] = AUTO_TEMP_MAX_TO_REG(val, data->auto_temp[nr]);
	adm1031_write_value(client, ADM1031_REG_AUTO_TEMP(nr),
data->temp_max[nr]);
	up(&data->update_lock);
	return count;
}
#define show_auto_temp_reg(offset)						\
static ssize_t show_auto_temp_##offset##_off (struct device *dev, char
*buf)	\
{									\
	return show_auto_temp_off(dev, buf, 0x##offset - 1);			\
}									\
static ssize_t show_auto_temp_##offset##_min (struct device *dev, char
*buf)	\
{									\
	return show_auto_temp_min(dev, buf, 0x##offset - 1);			\
}									\
static ssize_t show_auto_temp_##offset##_max (struct device *dev, char
*buf)	\
{									\
	return show_auto_temp_max(dev, buf, 0x##offset - 1);			\
}									\
static ssize_t set_auto_temp_##offset##_min (struct device *dev, 		\
	const char *buf, size_t count) 					\
{									\
	return set_auto_temp_min(dev, buf, count, 0x##offset - 1);		\
}									\
static ssize_t set_auto_temp_##offset##_max (struct device *dev, 		\
	const char *buf, size_t count) 					\
{									\
	return set_auto_temp_max(dev, buf, count, 0x##offset - 1);		\
}									\
static DEVICE_ATTR(auto_temp##offset##_off, S_IRUGO,
show_auto_temp_##offset##_off, NULL)	\
static DEVICE_ATTR(auto_temp##offset##_min, S_IRUGO | S_IWUSR, 		\
		show_auto_temp_##offset##_min, set_auto_temp_##offset##_min)	\
static DEVICE_ATTR(auto_temp##offset##_max, S_IRUGO | S_IWUSR, 		\
		show_auto_temp_##offset##_max, set_auto_temp_##offset##_max)      \

show_auto_temp_reg(1);
show_auto_temp_reg(2);
show_auto_temp_reg(3);


static int adm1031_attach_adapter(struct i2c_adapter *adapter)
{
	if (!(adapter->class & I2C_ADAP_CLASS_SMBUS))
		return 0;
	return i2c_detect(adapter, &addr_data, adm1031_detect);
}

/* This function is called by i2c_detect */
static int adm1031_detect(struct i2c_adapter *adapter, int address, int
kind)
{
	struct i2c_client *new_client;
	struct adm1031_data *data;
	int err = 0;
	const char *name = "";

	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
				     I2C_FUNC_SMBUS_WORD_DATA))
		goto exit;

	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
				   sizeof(struct adm1031_data),
				   GFP_KERNEL))) {
		err = -ENOMEM;
		goto exit;
	}
	memset(new_client, 0x00, sizeof(struct i2c_client) +
				 sizeof(struct adm1031_data));

	data = (struct adm1031_data *) (new_client + 1);
	i2c_set_clientdata(new_client, data);
	new_client->addr = address;
	new_client->adapter = adapter;
	new_client->driver = &adm1031_driver;
	new_client->flags = 0;

	if (kind < 0) {
	  int id, co;
	  id = i2c_smbus_read_byte_data(new_client, 0x3d);
	  co = i2c_smbus_read_byte_data(new_client, 0x3e);
	  
	  if(( (id != 0x31)||(id != 0x30)) && (co != 0x41))
	    goto exit_free;
	  kind = (id = 0x30) ? adm1030 : adm1031;
	}

	if (kind <= 0)
		kind = adm1031;

	if (kind = adm1030) {
		name = "adm1030";
	}
	if (kind = adm1031) {
		name = "adm1031";
	}
	data->chip_type = kind;

	strlcpy(new_client->name, name, I2C_NAME_SIZE);

	new_client->id = adm1031_id++;
	data->valid = 0;
	init_MUTEX(&data->update_lock);

	/* Tell the I2C layer a new client has arrived */
	if ((err = i2c_attach_client(new_client)))
		goto exit_free;

	/* Initialize the ADM1031 chip */
	adm1031_init_client(new_client);
	
	/* Register sysfs hooks */
	device_create_file(&new_client->dev, &dev_attr_fan1_input);
	device_create_file(&new_client->dev, &dev_attr_fan1_div);
	device_create_file(&new_client->dev, &dev_attr_fan1_min);
	device_create_file(&new_client->dev, &dev_attr_fan1_pwm);
	device_create_file(&new_client->dev, &dev_attr_temp1_input);
	device_create_file(&new_client->dev, &dev_attr_temp1_min);
	device_create_file(&new_client->dev, &dev_attr_temp1_max);
	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
	device_create_file(&new_client->dev, &dev_attr_temp2_input);
	device_create_file(&new_client->dev, &dev_attr_temp2_min);
	device_create_file(&new_client->dev, &dev_attr_temp2_max);
	device_create_file(&new_client->dev, &dev_attr_temp2_crit);
	
	device_create_file(&new_client->dev, &dev_attr_auto_temp1_off);
	device_create_file(&new_client->dev, &dev_attr_auto_temp1_min);
	device_create_file(&new_client->dev, &dev_attr_auto_temp1_max);
	
	device_create_file(&new_client->dev, &dev_attr_auto_temp2_off);
	device_create_file(&new_client->dev, &dev_attr_auto_temp2_min);
	device_create_file(&new_client->dev, &dev_attr_auto_temp2_max);
	
	if (kind = adm1031){
	  device_create_file(&new_client->dev, &dev_attr_fan2_input);
	  device_create_file(&new_client->dev, &dev_attr_fan2_div);
	  device_create_file(&new_client->dev, &dev_attr_fan2_min);
	  device_create_file(&new_client->dev, &dev_attr_fan2_pwm);
	  device_create_file(&new_client->dev, &dev_attr_temp3_input);
	  device_create_file(&new_client->dev, &dev_attr_temp3_min);
	  device_create_file(&new_client->dev, &dev_attr_temp3_max);
	  device_create_file(&new_client->dev, &dev_attr_temp3_crit);
	  device_create_file(&new_client->dev, &dev_attr_auto_temp3_off);
	  device_create_file(&new_client->dev, &dev_attr_auto_temp3_min);
	  device_create_file(&new_client->dev, &dev_attr_auto_temp3_max);
	}

	return 0;

exit_free:
	kfree(new_client);
exit:
	return err;
}

static int adm1031_detach_client(struct i2c_client *client)
{
  int ret;
  if ( (ret = i2c_detach_client(client)) != 0 ){
    return ret;
  }
  kfree(client);
  return 0;
}

static int adm1031_read_value(struct i2c_client *client, u8 reg)
{
  return i2c_smbus_read_byte_data(client, reg);
}

static int adm1031_write_value(struct i2c_client *client, u8 reg,
unsigned int value)
{
    return i2c_smbus_write_byte_data(client, reg, value);
}

static void adm1031_init_client(struct i2c_client *client)
{
    unsigned int read_val;

    /* Initialize the ADM1031 chip (enables fan speed reading )*/
    read_val = adm1031_read_value(client, ADM1031_REG_CONF(1));
    adm1031_write_value(client, ADM1031_REG_CONF(1), read_val |
			ADM1031_CONF2_TIEN);

}

static struct adm1031_data *adm1031_update_device(struct device *dev)
{
	struct i2c_client *client = to_i2c_client(dev);
	struct adm1031_data *data = i2c_get_clientdata(client);
	int chan;

	down(&data->update_lock);

	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
	    (jiffies < data->last_updated) || !data->valid) {
		dev_dbg(&client->dev, "Starting adm1031 update\n");
		
		for (chan = 0; chan < ((data->chip_type = adm1031) ? 3 : 2); chan++){
		  data->temp[chan] 		    adm1031_read_value(client, 
				       ADM1031_REG_TEMP(chan));
		  data->temp_min[chan] = 
		    adm1031_read_value(client, 
				       ADM1031_REG_TEMP_MIN(chan));
		  data->temp_max[chan] = 
		    adm1031_read_value(client, 
				       ADM1031_REG_TEMP_MAX(chan));
		  data->temp_crit[chan] = 
		    adm1031_read_value(client, 
				       ADM1031_REG_TEMP_CRIT(chan));

		  data->auto_temp[chan] 		    adm1031_read_value(client, 
				       ADM1031_REG_AUTO_TEMP(chan));
		}
		
		data->conf = 
		  adm1031_read_value(client,
				     ADM1031_REG_CONF(0)); 
		data->fan_div[0]   = 
		  adm1031_read_value(client,
				     ADM1031_REG_FAN_DIV(0)); 
		data->fan[0] 		  adm1031_read_value(client,
				     ADM1031_REG_FAN_SPEED(0));
		data->pwm[0]       = 0xf &
		    adm1031_read_value(client, ADM1031_REG_PWM(0));
		data->last_updated = jiffies;
		data->valid = 1;
	}

	up(&data->update_lock);

	return data;
}

static int __init sensors_adm1031_init(void)
{
	return i2c_add_driver(&adm1031_driver);
}

static void __exit sensors_adm1031_exit(void)
{
	i2c_del_driver(&adm1031_driver);
}

MODULE_AUTHOR("Alexandre d'Alton <alex@alexdalton.org>");
MODULE_DESCRIPTION("ADM1031 driver");
MODULE_LICENSE("GPL");

module_init(sensors_adm1031_init);
module_exit(sensors_adm1031_exit);

