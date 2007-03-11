From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 11 Mar 2007 08:33:37 +0000
Subject: [lm-sensors] get rid of i2c-isa - h now
Message-Id: <20070311093337.943188b7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F1E8C0.6040504@assembler.cz>
In-Reply-To: <45F1E8C0.6040504@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Sat, 10 Mar 2007 00:11:29 +0100, Rudolf Marek wrote:
> I'm attaching unfinished/untested patch in separate thread.

Comments:

First off all, you need to update drivers/hwmon/Kconfig to remove the
dependency with I2C and I2C_ISA.

> Index: linux-2.6.21-rc3/drivers/hwmon/w83627ehf.c
> =================================> --- linux-2.6.21-rc3.orig/drivers/hwmon/w83627ehf.c	2007-03-09 22:23:21.593831571 +0100
> +++ linux-2.6.21-rc3/drivers/hwmon/w83627ehf.c	2007-03-09 23:31:22.726402062 +0100
> @@ -41,8 +41,8 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> -#include <linux/i2c.h>
> -#include <linux/i2c-isa.h>
> +#include <linux/jiffies.h>
> +#include <linux/platform_device.h>
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
> @@ -50,8 +50,9 @@
>  #include <asm/io.h>
>  #include "lm75.h"
>  
> -/* The actual ISA address is read from Super-I/O configuration space */
> -static unsigned short address;
> +static struct platform_device *pdev;
> +
> +#define DRVNAME "w83627ehf/dhg"

Please stick to "w83627ehf". This is really the driver name, not the
list of all supported devices, we want here. Think of what it would
look like for the adm1021 driver otherwise...

And I'm pretty certain this is what causes the problem David reported
later in this thread. "/" is a the directory separator character, if
the driver core tried to create a file or directory by that name, I can
imagine it messed sysfs up.

>  
>  /*
>   * Super-I/O constants and functions
> @@ -255,7 +256,8 @@
>   */
>  
>  struct w83627ehf_data {
> -	struct i2c_client client;
> +	int addr;
> +	const char *name;
>  	struct class_device *class_dev;
>  	struct mutex lock;
>  
> @@ -303,121 +305,117 @@
>     nothing for registers which live in bank 0. For others, they respectively
>     set the bank register to the correct value (before the register is
>     accessed), and back to 0 (afterwards). */
> -static inline void w83627ehf_set_bank(struct i2c_client *client, u16 reg)
> +static inline void w83627ehf_set_bank(struct w83627ehf_data *data, u16 reg)
>  {
>  	if (reg & 0xff00) {
> -		outb_p(W83627EHF_REG_BANK, client->addr + ADDR_REG_OFFSET);
> -		outb_p(reg >> 8, client->addr + DATA_REG_OFFSET);
> +		outb_p(W83627EHF_REG_BANK, data->addr + ADDR_REG_OFFSET);
> +		outb_p(reg >> 8, data->addr + DATA_REG_OFFSET);
>  	}
>  }
>  
> -static inline void w83627ehf_reset_bank(struct i2c_client *client, u16 reg)
> +static inline void w83627ehf_reset_bank(struct w83627ehf_data *data, u16 reg)
>  {
>  	if (reg & 0xff00) {
> -		outb_p(W83627EHF_REG_BANK, client->addr + ADDR_REG_OFFSET);
> -		outb_p(0, client->addr + DATA_REG_OFFSET);
> +		outb_p(W83627EHF_REG_BANK, data->addr + ADDR_REG_OFFSET);
> +		outb_p(0, data->addr + DATA_REG_OFFSET);
>  	}
>  }
>  
> -static u16 w83627ehf_read_value(struct i2c_client *client, u16 reg)
> +static u16 w83627ehf_read_value(struct w83627ehf_data *data, u16 reg)
>  {
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
>  	int res, word_sized = is_word_sized(reg);
>  
>  	mutex_lock(&data->lock);
>  
> -	w83627ehf_set_bank(client, reg);
> -	outb_p(reg & 0xff, client->addr + ADDR_REG_OFFSET);
> -	res = inb_p(client->addr + DATA_REG_OFFSET);
> +	w83627ehf_set_bank(data, reg);
> +	outb_p(reg & 0xff, data->addr + ADDR_REG_OFFSET);
> +	res = inb_p(data->addr + DATA_REG_OFFSET);
>  	if (word_sized) {
>  		outb_p((reg & 0xff) + 1,
> -		       client->addr + ADDR_REG_OFFSET);
> -		res = (res << 8) + inb_p(client->addr + DATA_REG_OFFSET);
> +		       data->addr + ADDR_REG_OFFSET);
> +		res = (res << 8) + inb_p(data->addr + DATA_REG_OFFSET);
>  	}
> -	w83627ehf_reset_bank(client, reg);
> +	w83627ehf_reset_bank(data, reg);
>  
>  	mutex_unlock(&data->lock);
>  
>  	return res;
>  }
>  
> -static int w83627ehf_write_value(struct i2c_client *client, u16 reg, u16 value)
> +static int w83627ehf_write_value(struct w83627ehf_data *data, u16 reg, u16 value)
>  {
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
>  	int word_sized = is_word_sized(reg);
>  
>  	mutex_lock(&data->lock);
>  
> -	w83627ehf_set_bank(client, reg);
> -	outb_p(reg & 0xff, client->addr + ADDR_REG_OFFSET);
> +	w83627ehf_set_bank(data, reg);
> +	outb_p(reg & 0xff, data->addr + ADDR_REG_OFFSET);
>  	if (word_sized) {
> -		outb_p(value >> 8, client->addr + DATA_REG_OFFSET);
> +		outb_p(value >> 8, data->addr + DATA_REG_OFFSET);
>  		outb_p((reg & 0xff) + 1,
> -		       client->addr + ADDR_REG_OFFSET);
> +		       data->addr + ADDR_REG_OFFSET);
>  	}
> -	outb_p(value & 0xff, client->addr + DATA_REG_OFFSET);
> -	w83627ehf_reset_bank(client, reg);
> +	outb_p(value & 0xff, data->addr + DATA_REG_OFFSET);
> +	w83627ehf_reset_bank(data, reg);
>  
>  	mutex_unlock(&data->lock);
>  	return 0;
>  }
>  
>  /* This function assumes that the caller holds data->update_lock */
> -static void w83627ehf_write_fan_div(struct i2c_client *client, int nr)
> +static void w83627ehf_write_fan_div(struct w83627ehf_data *data, int nr)
>  {
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
>  	u8 reg;
>  
>  	switch (nr) {
>  	case 0:
> -		reg = (w83627ehf_read_value(client, W83627EHF_REG_FANDIV1) & 0xcf)
> +		reg = (w83627ehf_read_value(data, W83627EHF_REG_FANDIV1) & 0xcf)
>  		    | ((data->fan_div[0] & 0x03) << 4);
>  		/* fan5 input control bit is write only, compute the value */
>  		reg |= (data->has_fan & (1 << 4)) ? 1 : 0;
> -		w83627ehf_write_value(client, W83627EHF_REG_FANDIV1, reg);
> -		reg = (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0xdf)
> +		w83627ehf_write_value(data, W83627EHF_REG_FANDIV1, reg);
> +		reg = (w83627ehf_read_value(data, W83627EHF_REG_VBAT) & 0xdf)
>  		    | ((data->fan_div[0] & 0x04) << 3);
> -		w83627ehf_write_value(client, W83627EHF_REG_VBAT, reg);
> +		w83627ehf_write_value(data, W83627EHF_REG_VBAT, reg);
>  		break;
>  	case 1:
> -		reg = (w83627ehf_read_value(client, W83627EHF_REG_FANDIV1) & 0x3f)
> +		reg = (w83627ehf_read_value(data, W83627EHF_REG_FANDIV1) & 0x3f)
>  		    | ((data->fan_div[1] & 0x03) << 6);
>  		/* fan5 input control bit is write only, compute the value */
>  		reg |= (data->has_fan & (1 << 4)) ? 1 : 0;
> -		w83627ehf_write_value(client, W83627EHF_REG_FANDIV1, reg);
> -		reg = (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0xbf)
> +		w83627ehf_write_value(data, W83627EHF_REG_FANDIV1, reg);
> +		reg = (w83627ehf_read_value(data, W83627EHF_REG_VBAT) & 0xbf)
>  		    | ((data->fan_div[1] & 0x04) << 4);
> -		w83627ehf_write_value(client, W83627EHF_REG_VBAT, reg);
> +		w83627ehf_write_value(data, W83627EHF_REG_VBAT, reg);
>  		break;
>  	case 2:
> -		reg = (w83627ehf_read_value(client, W83627EHF_REG_FANDIV2) & 0x3f)
> +		reg = (w83627ehf_read_value(data, W83627EHF_REG_FANDIV2) & 0x3f)
>  		    | ((data->fan_div[2] & 0x03) << 6);
> -		w83627ehf_write_value(client, W83627EHF_REG_FANDIV2, reg);
> -		reg = (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0x7f)
> +		w83627ehf_write_value(data, W83627EHF_REG_FANDIV2, reg);
> +		reg = (w83627ehf_read_value(data, W83627EHF_REG_VBAT) & 0x7f)
>  		    | ((data->fan_div[2] & 0x04) << 5);
> -		w83627ehf_write_value(client, W83627EHF_REG_VBAT, reg);
> +		w83627ehf_write_value(data, W83627EHF_REG_VBAT, reg);
>  		break;
>  	case 3:
> -		reg = (w83627ehf_read_value(client, W83627EHF_REG_DIODE) & 0xfc)
> +		reg = (w83627ehf_read_value(data, W83627EHF_REG_DIODE) & 0xfc)
>  		    | (data->fan_div[3] & 0x03);
> -		w83627ehf_write_value(client, W83627EHF_REG_DIODE, reg);
> -		reg = (w83627ehf_read_value(client, W83627EHF_REG_SMI_OVT) & 0x7f)
> +		w83627ehf_write_value(data, W83627EHF_REG_DIODE, reg);
> +		reg = (w83627ehf_read_value(data, W83627EHF_REG_SMI_OVT) & 0x7f)
>  		    | ((data->fan_div[3] & 0x04) << 5);
> -		w83627ehf_write_value(client, W83627EHF_REG_SMI_OVT, reg);
> +		w83627ehf_write_value(data, W83627EHF_REG_SMI_OVT, reg);
>  		break;
>  	case 4:
> -		reg = (w83627ehf_read_value(client, W83627EHF_REG_DIODE) & 0x73)
> +		reg = (w83627ehf_read_value(data, W83627EHF_REG_DIODE) & 0x73)
>  		    | ((data->fan_div[4] & 0x03) << 3)
>  		    | ((data->fan_div[4] & 0x04) << 5);
> -		w83627ehf_write_value(client, W83627EHF_REG_DIODE, reg);
> +		w83627ehf_write_value(data, W83627EHF_REG_DIODE, reg);
>  		break;
>  	}
>  }
>  
>  static struct w83627ehf_data *w83627ehf_update_device(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  	int pwmcfg = 0, tolerance = 0; /* shut up the compiler */
>  	int i;
>  
> @@ -426,33 +424,33 @@
>  	if (time_after(jiffies, data->last_updated + HZ)
>  	 || !data->valid) {
>  		/* Fan clock dividers */
> -		i = w83627ehf_read_value(client, W83627EHF_REG_FANDIV1);
> +		i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
>  		data->fan_div[0] = (i >> 4) & 0x03;
>  		data->fan_div[1] = (i >> 6) & 0x03;
> -		i = w83627ehf_read_value(client, W83627EHF_REG_FANDIV2);
> +		i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV2);
>  		data->fan_div[2] = (i >> 6) & 0x03;
> -		i = w83627ehf_read_value(client, W83627EHF_REG_VBAT);
> +		i = w83627ehf_read_value(data, W83627EHF_REG_VBAT);
>  		data->fan_div[0] |= (i >> 3) & 0x04;
>  		data->fan_div[1] |= (i >> 4) & 0x04;
>  		data->fan_div[2] |= (i >> 5) & 0x04;
>  		if (data->has_fan & ((1 << 3) | (1 << 4))) {
> -			i = w83627ehf_read_value(client, W83627EHF_REG_DIODE);
> +			i = w83627ehf_read_value(data, W83627EHF_REG_DIODE);
>  			data->fan_div[3] = i & 0x03;
>  			data->fan_div[4] = ((i >> 2) & 0x03)
>  					 | ((i >> 5) & 0x04);
>  		}
>  		if (data->has_fan & (1 << 3)) {
> -			i = w83627ehf_read_value(client, W83627EHF_REG_SMI_OVT);
> +			i = w83627ehf_read_value(data, W83627EHF_REG_SMI_OVT);
>  			data->fan_div[3] |= (i >> 5) & 0x04;
>  		}
>  
>  		/* Measured voltages and limits */
>  		for (i = 0; i < w83627ehf_num_in; i++) {
> -			data->in[i] = w83627ehf_read_value(client,
> +			data->in[i] = w83627ehf_read_value(data,
>  				      W83627EHF_REG_IN(i));
> -			data->in_min[i] = w83627ehf_read_value(client,
> +			data->in_min[i] = w83627ehf_read_value(data,
>  					  W83627EHF_REG_IN_MIN(i));
> -			data->in_max[i] = w83627ehf_read_value(client,
> +			data->in_max[i] = w83627ehf_read_value(data,
>  					  W83627EHF_REG_IN_MAX(i));
>  		}
>  
> @@ -461,9 +459,9 @@
>  			if (!(data->has_fan & (1 << i)))
>  				continue;
>  
> -			data->fan[i] = w83627ehf_read_value(client,
> +			data->fan[i] = w83627ehf_read_value(data,
>  				       W83627EHF_REG_FAN[i]);
> -			data->fan_min[i] = w83627ehf_read_value(client,
> +			data->fan_min[i] = w83627ehf_read_value(data,
>  					   W83627EHF_REG_FAN_MIN[i]);
>  
>  			/* If we failed to measure the fan speed and clock
> @@ -471,16 +469,16 @@
>  			   time */
>  			if (data->fan[i] = 0xff
>  			 && data->fan_div[i] < 0x07) {
> -			 	dev_dbg(&client->dev, "Increasing fan %d "
> +			 	dev_dbg(dev, "Increasing fan %d "
>  					"clock divider from %u to %u\n",
>  					i, div_from_reg(data->fan_div[i]),
>  					div_from_reg(data->fan_div[i] + 1));
>  				data->fan_div[i]++;
> -				w83627ehf_write_fan_div(client, i);
> +				w83627ehf_write_fan_div(data, i);
>  				/* Preserve min limit if possible */
>  				if (data->fan_min[i] >= 2
>  				 && data->fan_min[i] != 255)
> -					w83627ehf_write_value(client,
> +					w83627ehf_write_value(data,
>  						W83627EHF_REG_FAN_MIN[i],
>  						(data->fan_min[i] /= 2));
>  			}
> @@ -489,9 +487,9 @@
>  		for (i = 0; i < 4; i++) {
>  			/* pwmcfg, tolarance mapped for i=0, i=1 to same reg */
>  			if (i != 1) {
> -				pwmcfg = w83627ehf_read_value(client,
> +				pwmcfg = w83627ehf_read_value(data,
>  						W83627EHF_REG_PWM_ENABLE[i]);
> -				tolerance = w83627ehf_read_value(client,
> +				tolerance = w83627ehf_read_value(data,
>  						W83627EHF_REG_TOLERANCE[i]);
>  			}
>  			data->pwm_mode[i] > @@ -500,14 +498,14 @@
>  			data->pwm_enable[i] >  					((pwmcfg >> W83627EHF_PWM_ENABLE_SHIFT[i])
>  						& 3) + 1;
> -			data->pwm[i] = w83627ehf_read_value(client,
> +			data->pwm[i] = w83627ehf_read_value(data,
>  						W83627EHF_REG_PWM[i]);
> -			data->fan_min_output[i] = w83627ehf_read_value(client,
> +			data->fan_min_output[i] = w83627ehf_read_value(data,
>  						W83627EHF_REG_FAN_MIN_OUTPUT[i]);
> -			data->fan_stop_time[i] = w83627ehf_read_value(client,
> +			data->fan_stop_time[i] = w83627ehf_read_value(data,
>  						W83627EHF_REG_FAN_STOP_TIME[i]);
>  			data->target_temp[i] > -				w83627ehf_read_value(client,
> +				w83627ehf_read_value(data,
>  					W83627EHF_REG_TARGET[i]) &
>  					(data->pwm_mode[i] = 1 ? 0x7f : 0xff);
>  			data->tolerance[i] = (tolerance >> (i = 1 ? 4 : 0))
> @@ -515,26 +513,26 @@
>  		}
>  
>  		/* Measured temperatures and limits */
> -		data->temp1 = w83627ehf_read_value(client,
> +		data->temp1 = w83627ehf_read_value(data,
>  			      W83627EHF_REG_TEMP1);
> -		data->temp1_max = w83627ehf_read_value(client,
> +		data->temp1_max = w83627ehf_read_value(data,
>  				  W83627EHF_REG_TEMP1_OVER);
> -		data->temp1_max_hyst = w83627ehf_read_value(client,
> +		data->temp1_max_hyst = w83627ehf_read_value(data,
>  				       W83627EHF_REG_TEMP1_HYST);
>  		for (i = 0; i < 2; i++) {
> -			data->temp[i] = w83627ehf_read_value(client,
> +			data->temp[i] = w83627ehf_read_value(data,
>  					W83627EHF_REG_TEMP[i]);
> -			data->temp_max[i] = w83627ehf_read_value(client,
> +			data->temp_max[i] = w83627ehf_read_value(data,
>  					    W83627EHF_REG_TEMP_OVER[i]);
> -			data->temp_max_hyst[i] = w83627ehf_read_value(client,
> +			data->temp_max_hyst[i] = w83627ehf_read_value(data,
>  						 W83627EHF_REG_TEMP_HYST[i]);
>  		}
>  
> -		data->alarms = w83627ehf_read_value(client,
> +		data->alarms = w83627ehf_read_value(data,
>  					W83627EHF_REG_ALARM1) |
> -			       (w83627ehf_read_value(client,
> +			       (w83627ehf_read_value(data,
>  					W83627EHF_REG_ALARM2) << 8) |
> -			       (w83627ehf_read_value(client,
> +			       (w83627ehf_read_value(data,
>  					W83627EHF_REG_ALARM3) << 16);
>  
>  		data->last_updated = jiffies;
> @@ -567,15 +565,14 @@
>  store_in_##reg (struct device *dev, struct device_attribute *attr, \
>  			const char *buf, size_t count) \
>  { \
> -	struct i2c_client *client = to_i2c_client(dev); \
> -	struct w83627ehf_data *data = i2c_get_clientdata(client); \
> +	struct w83627ehf_data *data = dev_get_drvdata(dev); \
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
>  	int nr = sensor_attr->index; \
>  	u32 val = simple_strtoul(buf, NULL, 10); \
>   \
>  	mutex_lock(&data->update_lock); \
>  	data->in_##reg[nr] = in_to_reg(val, nr); \
> -	w83627ehf_write_value(client, W83627EHF_REG_IN_##REG(nr), \
> +	w83627ehf_write_value(data, W83627EHF_REG_IN_##REG(nr), \
>  			      data->in_##reg[nr]); \
>  	mutex_unlock(&data->update_lock); \
>  	return count; \
> @@ -673,8 +670,7 @@
>  store_fan_min(struct device *dev, struct device_attribute *attr,
>  	      const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
>  	unsigned int val = simple_strtoul(buf, NULL, 10);
> @@ -725,9 +721,9 @@
>  			nr + 1, div_from_reg(data->fan_div[nr]),
>  			div_from_reg(new_div));
>  		data->fan_div[nr] = new_div;
> -		w83627ehf_write_fan_div(client, nr);
> +		w83627ehf_write_fan_div(data, nr);
>  	}
> -	w83627ehf_write_value(client, W83627EHF_REG_FAN_MIN[nr],
> +	w83627ehf_write_value(data, W83627EHF_REG_FAN_MIN[nr],
>  			      data->fan_min[nr]);
>  	mutex_unlock(&data->update_lock);
>  
> @@ -788,13 +784,12 @@
>  store_temp1_##reg(struct device *dev, struct device_attribute *attr, \
>  		  const char *buf, size_t count) \
>  { \
> -	struct i2c_client *client = to_i2c_client(dev); \
> -	struct w83627ehf_data *data = i2c_get_clientdata(client); \
> +	struct w83627ehf_data *data = dev_get_drvdata(dev); \
>  	u32 val = simple_strtoul(buf, NULL, 10); \
>   \
>  	mutex_lock(&data->update_lock); \
>  	data->temp1_##reg = temp1_to_reg(val, -128000, 127000); \
> -	w83627ehf_write_value(client, W83627EHF_REG_TEMP1_##REG, \
> +	w83627ehf_write_value(data, W83627EHF_REG_TEMP1_##REG, \
>  			      data->temp1_##reg); \
>  	mutex_unlock(&data->update_lock); \
>  	return count; \
> @@ -822,15 +817,14 @@
>  store_##reg(struct device *dev, struct device_attribute *attr, \
>  	    const char *buf, size_t count) \
>  { \
> -	struct i2c_client *client = to_i2c_client(dev); \
> -	struct w83627ehf_data *data = i2c_get_clientdata(client); \
> +	struct w83627ehf_data *data = dev_get_drvdata(dev); \
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
>  	int nr = sensor_attr->index; \
>  	u32 val = simple_strtoul(buf, NULL, 10); \
>   \
>  	mutex_lock(&data->update_lock); \
>  	data->reg[nr] = LM75_TEMP_TO_REG(val); \
> -	w83627ehf_write_value(client, W83627EHF_REG_TEMP_##REG[nr], \
> +	w83627ehf_write_value(data, W83627EHF_REG_TEMP_##REG[nr], \
>  			      data->reg[nr]); \
>  	mutex_unlock(&data->update_lock); \
>  	return count; \
> @@ -877,8 +871,7 @@
>  store_pwm_mode(struct device *dev, struct device_attribute *attr,
>  			const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
>  	u32 val = simple_strtoul(buf, NULL, 10);
> @@ -887,12 +880,12 @@
>  	if (val > 1)
>  		return -EINVAL;
>  	mutex_lock(&data->update_lock);
> -	reg = w83627ehf_read_value(client, W83627EHF_REG_PWM_ENABLE[nr]);
> +	reg = w83627ehf_read_value(data, W83627EHF_REG_PWM_ENABLE[nr]);
>  	data->pwm_mode[nr] = val;
>  	reg &= ~(1 << W83627EHF_PWM_MODE_SHIFT[nr]);
>  	if (!val)
>  		reg |= 1 << W83627EHF_PWM_MODE_SHIFT[nr];
> -	w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr], reg);
> +	w83627ehf_write_value(data, W83627EHF_REG_PWM_ENABLE[nr], reg);
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -901,15 +894,14 @@
>  store_pwm(struct device *dev, struct device_attribute *attr,
>  			const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
>  	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 255);
>  
>  	mutex_lock(&data->update_lock);
>  	data->pwm[nr] = val;
> -	w83627ehf_write_value(client, W83627EHF_REG_PWM[nr], val);
> +	w83627ehf_write_value(data, W83627EHF_REG_PWM[nr], val);
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -918,8 +910,7 @@
>  store_pwm_enable(struct device *dev, struct device_attribute *attr,
>  			const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
>  	u32 val = simple_strtoul(buf, NULL, 10);
> @@ -928,11 +919,11 @@
>  	if (!val || (val > 2))	/* only modes 1 and 2 are supported */
>  		return -EINVAL;
>  	mutex_lock(&data->update_lock);
> -	reg = w83627ehf_read_value(client, W83627EHF_REG_PWM_ENABLE[nr]);
> +	reg = w83627ehf_read_value(data, W83627EHF_REG_PWM_ENABLE[nr]);
>  	data->pwm_enable[nr] = val;
>  	reg &= ~(0x03 << W83627EHF_PWM_ENABLE_SHIFT[nr]);
>  	reg |= (val - 1) << W83627EHF_PWM_ENABLE_SHIFT[nr];
> -	w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr], reg);
> +	w83627ehf_write_value(data, W83627EHF_REG_PWM_ENABLE[nr], reg);
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -955,15 +946,14 @@
>  store_target_temp(struct device *dev, struct device_attribute *attr,
>  			const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
>  	u8 val = temp1_to_reg(simple_strtoul(buf, NULL, 10), 0, 127000);
>  
>  	mutex_lock(&data->update_lock);
>  	data->target_temp[nr] = val;
> -	w83627ehf_write_value(client, W83627EHF_REG_TARGET[nr], val);
> +	w83627ehf_write_value(data, W83627EHF_REG_TARGET[nr], val);
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -972,8 +962,7 @@
>  store_tolerance(struct device *dev, struct device_attribute *attr,
>  			const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
>  	u16 reg;
> @@ -981,13 +970,13 @@
>  	u8 val = temp1_to_reg(simple_strtoul(buf, NULL, 10), 0, 15000);
>  
>  	mutex_lock(&data->update_lock);
> -	reg = w83627ehf_read_value(client, W83627EHF_REG_TOLERANCE[nr]);
> +	reg = w83627ehf_read_value(data, W83627EHF_REG_TOLERANCE[nr]);
>  	data->tolerance[nr] = val;
>  	if (nr = 1)
>  		reg = (reg & 0x0f) | (val << 4);
>  	else
>  		reg = (reg & 0xf0) | val;
> -	w83627ehf_write_value(client, W83627EHF_REG_TOLERANCE[nr], reg);
> +	w83627ehf_write_value(data, W83627EHF_REG_TOLERANCE[nr], reg);
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -1058,14 +1047,13 @@
>  store_##reg(struct device *dev, struct device_attribute *attr, \
>  			    const char *buf, size_t count) \
>  {\
> -	struct i2c_client *client = to_i2c_client(dev); \
> -	struct w83627ehf_data *data = i2c_get_clientdata(client); \
> +	struct w83627ehf_data *data = dev_get_drvdata(dev); \
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
>  	int nr = sensor_attr->index; \
>  	u32 val = SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 1, 255); \
>  	mutex_lock(&data->update_lock); \
>  	data->reg[nr] = val; \
> -	w83627ehf_write_value(client, W83627EHF_REG_##REG[nr],  val); \
> +	w83627ehf_write_value(data, W83627EHF_REG_##REG[nr],  val); \
>  	mutex_unlock(&data->update_lock); \
>  	return count; \
>  }
> @@ -1087,15 +1075,14 @@
>  store_##reg(struct device *dev, struct device_attribute *attr, \
>  			const char *buf, size_t count) \
>  { \
> -	struct i2c_client *client = to_i2c_client(dev); \
> -	struct w83627ehf_data *data = i2c_get_clientdata(client); \
> +	struct w83627ehf_data *data = dev_get_drvdata(dev); \
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr); \
>  	int nr = sensor_attr->index; \
>  	u8 val = step_time_to_reg(simple_strtoul(buf, NULL, 10), \
>  					data->pwm_mode[nr]); \
>  	mutex_lock(&data->update_lock); \
>  	data->reg[nr] = val; \
> -	w83627ehf_write_value(client, W83627EHF_REG_##REG[nr], val); \
> +	w83627ehf_write_value(data, W83627EHF_REG_##REG[nr], val); \
>  	mutex_unlock(&data->update_lock); \
>  	return count; \
>  } \
> @@ -1126,7 +1113,7 @@
>  };
>  
>  /*
> - * Driver and client management
> + * Driver and platform management
>   */
>  
>  static void w83627ehf_device_remove_files(struct device *dev)
> @@ -1162,76 +1149,64 @@
>  		device_remove_file(dev, &sda_temp[i].dev_attr);
>  }
>  
> -static struct i2c_driver w83627ehf_driver;
> -
> -static void w83627ehf_init_client(struct i2c_client *client)
> +static void __devinit w83627ehf_init_device(struct w83627ehf_data *data)
>  {
>  	int i;
>  	u8 tmp;
>  
>  	/* Start monitoring is needed */
> -	tmp = w83627ehf_read_value(client, W83627EHF_REG_CONFIG);
> +	tmp = w83627ehf_read_value(data, W83627EHF_REG_CONFIG);
>  	if (!(tmp & 0x01))
> -		w83627ehf_write_value(client, W83627EHF_REG_CONFIG,
> +		w83627ehf_write_value(data, W83627EHF_REG_CONFIG,
>  				      tmp | 0x01);
>  
>  	/* Enable temp2 and temp3 if needed */
>  	for (i = 0; i < 2; i++) {
> -		tmp = w83627ehf_read_value(client,
> +		tmp = w83627ehf_read_value(data,
>  					   W83627EHF_REG_TEMP_CONFIG[i]);
>  		if (tmp & 0x01)
> -			w83627ehf_write_value(client,
> +			w83627ehf_write_value(data,
>  					      W83627EHF_REG_TEMP_CONFIG[i],
>  					      tmp & 0xfe);
>  	}
>  }
>  
> -static int w83627ehf_detect(struct i2c_adapter *adapter)
> +static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  {
> -	struct i2c_client *client;
>  	struct w83627ehf_data *data;
>  	struct device *dev;
> +	struct resource *res;
>  	u8 fan4pin, fan5pin;
>  	int i, err = 0;
>  
> -	if (!request_region(address + REGION_OFFSET, REGION_LENGTH,
> -	                    w83627ehf_driver.driver.name)) {
> -		err = -EBUSY;
> -		goto exit;
> -	}

Please leave the region request in. It will work even without my
pending patch (which Greg KH has already accepted [1]), you simply get a
warning message on driver unload, no big deal. The hwmon drivers should
be ported as if this patch was already in - it will be by the time we
push the patches.

[1] http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-01-driver/platform-reorder-platform_device_del.patch

> -
>  	if (!(data = kzalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
>  		err = -ENOMEM;
> -		goto exit_release;
> +		goto exit;
>  	}
>  
> -	client = &data->client;
> -	i2c_set_clientdata(client, data);
> -	client->addr = address;
> +	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	data->addr = res->start;
> +
>  	mutex_init(&data->lock);
> -	client->adapter = adapter;
> -	client->driver = &w83627ehf_driver;
> -	client->flags = 0;
> -	dev = &client->dev;
> -
> -	if (w83627ehf_num_in = 9)
> -		strlcpy(client->name, "w83627dhg", I2C_NAME_SIZE);
> -	else	/* just say ehf. 627EHG is 627EHF in lead-free packaging. */
> -		strlcpy(client->name, "w83627ehf", I2C_NAME_SIZE);
> +
> +	platform_set_drvdata(pdev, data);
> +	dev = &pdev->dev;
> +
> +	if (w83627ehf_num_in = 9) {
> +		data->name = "w83627dhg";
> +	} else {	/* just say ehf. 627EHG is 627EHF in lead-free packaging. */
> +		data->name = "w83627ehf";
> +	}

This must be changed. We no longer want to use random globals to store
device-related information, but platform data. See the f71805f driver
(or the w83627hf patch I'll post later today.) Both use a structure
named sio_data to store the device type and possibly other
configuration bits.

This can be made a separate patch if you want, but this needs to be
done. You don't really have a platform driver until the device
declaration part can be moved to a separate file entirely.

>  
>  	data->valid = 0;

Can be dropped, even though this isn't related to the driver conversion
itself.

>  	mutex_init(&data->update_lock);
>  
> -	/* Tell the i2c layer a new client has arrived */
> -	if ((err = i2c_attach_client(client)))
> -		goto exit_free;
> -
>  	/* Initialize the chip */
> -	w83627ehf_init_client(client);
> +	w83627ehf_init_device(data);
>  
>  	/* A few vars need to be filled upon startup */
>  	for (i = 0; i < 5; i++)
> -		data->fan_min[i] = w83627ehf_read_value(client,
> +		data->fan_min[i] = w83627ehf_read_value(data,
>  				   W83627EHF_REG_FAN_MIN[i]);
>  
>  	/* fan4 and fan5 share some pins with the GPIO and serial flash */
> @@ -1248,7 +1223,7 @@
>  	   is not the default. */
>  
>  	data->has_fan = 0x07; /* fan1, fan2 and fan3 */
> -	i = w83627ehf_read_value(client, W83627EHF_REG_FANDIV1);
> +	i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
>  	if ((i & (1 << 2)) && (!fan4pin))
>  		data->has_fan |= (1 << 3);
>  	if (!(i & (1 << 1)) && (!fan5pin))
> @@ -1318,40 +1293,74 @@
>  
>  exit_remove:
>  	w83627ehf_device_remove_files(dev);
> -	i2c_detach_client(client);
> -exit_free:
> +	platform_set_drvdata(pdev, NULL);
>  	kfree(data);
> -exit_release:
> -	release_region(address + REGION_OFFSET, REGION_LENGTH);
>  exit:
>  	return err;
>  }
>  
> -static int w83627ehf_detach_client(struct i2c_client *client)
> +
> +static int __devexit w83627ehf_remove(struct platform_device *pdev)
>  {
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> -	int err;
> +	struct w83627ehf_data *data = platform_get_drvdata(pdev);
>  
> +	platform_set_drvdata(pdev, NULL);
>  	hwmon_device_unregister(data->class_dev);
> -	w83627ehf_device_remove_files(&client->dev);
> -
> -	if ((err = i2c_detach_client(client)))
> -		return err;
> -	release_region(client->addr + REGION_OFFSET, REGION_LENGTH);
> +	w83627ehf_device_remove_files(&pdev->dev);
>  	kfree(data);
>  
>  	return 0;
>  }
>  
> -static struct i2c_driver w83627ehf_driver = {
> +

Extra blank line.

> +static struct platform_driver w83627ehf_driver = {
>  	.driver = {
>  		.owner	= THIS_MODULE,
> -		.name	= "w83627ehf",
> +		.name	= DRVNAME,
>  	},
> -	.attach_adapter	= w83627ehf_detect,
> -	.detach_client	= w83627ehf_detach_client,
> +	.probe		= w83627ehf_probe,
> +	.remove		= __devexit_p(w83627ehf_remove),
>  };
>  
> +static int __init w83627ehf_device_add(unsigned short address)
> +{
> +	struct resource res = {
> +		.start	= address,
> +		.end	= address + REGION_LENGTH - 1,
> +		.name	= DRVNAME,
> +		.flags	= IORESOURCE_IO,
> +	};
> +	int err;
> +
> +	pdev = platform_device_alloc(DRVNAME, address);
> +	if (!pdev) {
> +		err = -ENOMEM;
> +		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> +		goto exit;
> +	}
> +
> +	err = platform_device_add_resources(pdev, &res, 1);
> +	if (err) {
> +		printk(KERN_ERR DRVNAME ": Device resource addition failed "
> +		       "(%d)\n", err);
> +		goto exit_device_put;
> +	}
> +
> +	err = platform_device_add(pdev);
> +	if (err) {
> +		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
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
>  static int __init w83627ehf_find(int sioaddr, unsigned short *addr)
>  {
>  	u16 val;
> @@ -1397,16 +1406,34 @@
>  
>  static int __init sensors_w83627ehf_init(void)
>  {
> +	int err;
> +	unsigned short address;
> +
>  	if (w83627ehf_find(0x2e, &address)
>  	 && w83627ehf_find(0x4e, &address))
>  		return -ENODEV;
>  
> -	return i2c_isa_add_driver(&w83627ehf_driver);
> +	err = platform_driver_register(&w83627ehf_driver);
> +	if (err)
> +		goto exit;
> +
> +	/* Sets global pdev as a side effect */
> +	err = w83627ehf_device_add(address);
> +	if (err)
> +		goto exit_driver;
> +
> +	return 0;
> +
> +exit_driver:
> +	platform_driver_unregister(&w83627ehf_driver);
> +exit:
> +	return err;
>  }
>  
>  static void __exit sensors_w83627ehf_exit(void)
>  {
> -	i2c_isa_del_driver(&w83627ehf_driver);
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&w83627ehf_driver);
>  }
>  
>  MODULE_AUTHOR("Jean Delvare <khali at linux-fr.org>");
> 

Looks good otherwise, thanks for doing this!

-- 
Jean Delvare

