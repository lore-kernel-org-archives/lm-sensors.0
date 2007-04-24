From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Apr 2007 17:58:49 +0000
Subject: Re: [lm-sensors] get rid of i2c-isa - h now - fixes of w82627ehf
Message-Id: <20070424195849.26d1f333@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F47B44.8010108@assembler.cz>
In-Reply-To: <45F47B44.8010108@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Thu, 29 Mar 2007 12:13:29 -0700, David Hubbard wrote:
> Here's a patch for your review.

Sorry for the delay, here's my review. Next time please avoid patches
as base64 attachments.

> This patch removes i2c-isa from the w83627ehf driver, moving over
> to a platform driver.
> 
> Signed-off-by: David Hubbard <david.c.hubbard@gmail.com>
> 
> Index: linux-2.6.21-rc3/drivers/hwmon/w83627ehf.c
> =================================> --- linux-2.6.21-rc5/drivers/hwmon/w83627ehf.c	2007-03-28 19:52:44.000000000 -0700
> +++ linux-2.6.21-rc5/drivers/hwmon/w83627ehf.c	2007-03-29 12:55:53.000000000 -0700
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
> @@ -50,25 +50,19 @@
>  #include <asm/io.h>
>  #include "lm75.h"
>  
> -/* The actual ISA address is read from Super-I/O configuration space */
> -static unsigned short address;
> +enum kinds { w83627ehf, w83627dhg };
>  
> -/*
> - * Super-I/O constants and functions
> - */
> +/* used to set data->name = w83627ehf_device_names[data->kind] */
> +static const char * w83627ehf_device_names[] = {
> +	"w83627ehf",
> +	"w83627dhg",
> +};
> +
> +#define DRVNAME "w83627ehf"
>  
>  /*
> - * The three following globals are initialized in w83627ehf_find(), before
> - * the i2c-isa device is created. Otherwise, they could be stored in
> - * w83627ehf_data. This is ugly, but necessary, and when the driver is next
> - * updated to become a platform driver, the globals will disappear.
> + * Super-I/O constants and functions
>   */
> -static int REG;		/* The register to read/write */
> -static int VAL;		/* The value to read/write */
> -/* The w83627ehf/ehg have 10 voltage inputs, but the w83627dhg has 9. This
> - * value is also used in w83627ehf_detect() to export a device name in sysfs
> - * (e.g. w83627ehf or w83627dhg) */
> -static int w83627ehf_num_in;
>  
>  #define W83627EHF_LD_HWM	0x0b
>  
> @@ -83,38 +77,38 @@
>  #define SIO_ID_MASK		0xFFF0
>  
>  static inline void
> -superio_outb(int reg, int val)
> +superio_outb(int ioreg, int reg, int val)
>  {
> -	outb(reg, REG);
> -	outb(val, VAL);
> +	outb(reg, ioreg);
> +	outb(val, ioreg + 1);
>  }
>  
>  static inline int
> -superio_inb(int reg)
> +superio_inb(int ioreg, int reg)
>  {
> -	outb(reg, REG);
> -	return inb(VAL);
> +	outb(reg, ioreg);
> +	return inb(ioreg + 1);
>  }
>  
>  static inline void
> -superio_select(int ld)
> +superio_select(int ioreg, int ld)
>  {
> -	outb(SIO_REG_LDSEL, REG);
> -	outb(ld, VAL);
> +	outb(SIO_REG_LDSEL, ioreg);
> +	outb(ld, ioreg + 1);
>  }
>  
>  static inline void
> -superio_enter(void)
> +superio_enter(int ioreg)
>  {
> -	outb(0x87, REG);
> -	outb(0x87, REG);
> +	outb(0x87, ioreg);
> +	outb(0x87, ioreg);
>  }
>  
>  static inline void
> -superio_exit(void)
> +superio_exit(int ioreg)
>  {
> -	outb(0x02, REG);
> -	outb(0x02, VAL);
> +	outb(0x02, ioreg);
> +	outb(0x02, ioreg + 1);
>  }
>  
>  /*
> @@ -255,7 +249,11 @@
>   */
>  
>  struct w83627ehf_data {
> -	struct i2c_client client;
> +	int sioreg;
> +	enum kinds kind;
> +	int addr;	/* IO base of hw monitor block */
> +	const char *name;
> +
>  	struct class_device *class_dev;
>  	struct mutex lock;
>  
> @@ -264,6 +262,7 @@
>  	unsigned long last_updated;	/* In jiffies */
>  
>  	/* Register values */
> +	u8 in_num;		/* number of in inputs we have */
>  	u8 in[10];		/* Register value */
>  	u8 in_max[10];		/* Register value */
>  	u8 in_min[10];		/* Register value */
> @@ -303,121 +302,117 @@
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
> @@ -426,33 +421,33 @@
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
> -		for (i = 0; i < w83627ehf_num_in; i++) {
> -			data->in[i] = w83627ehf_read_value(client,
> +		for (i = 0; i < data->in_num; i++) {
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
> @@ -461,9 +456,9 @@
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
> @@ -471,16 +466,16 @@
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
> @@ -489,9 +484,9 @@
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
>  			data->pwm_mode[i] > @@ -500,14 +495,14 @@
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
> @@ -515,26 +510,26 @@
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
> @@ -567,15 +562,14 @@
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
> @@ -673,8 +667,7 @@
>  store_fan_min(struct device *dev, struct device_attribute *attr,
>  	      const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
>  	unsigned int val = simple_strtoul(buf, NULL, 10);
> @@ -725,9 +718,9 @@
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
> @@ -788,13 +781,12 @@
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
> @@ -822,15 +814,14 @@
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
> @@ -877,8 +868,7 @@
>  store_pwm_mode(struct device *dev, struct device_attribute *attr,
>  			const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
>  	u32 val = simple_strtoul(buf, NULL, 10);
> @@ -887,12 +877,12 @@
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
> @@ -901,15 +891,14 @@
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
> @@ -918,8 +907,7 @@
>  store_pwm_enable(struct device *dev, struct device_attribute *attr,
>  			const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
>  	u32 val = simple_strtoul(buf, NULL, 10);
> @@ -928,11 +916,11 @@
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
> @@ -955,15 +943,14 @@
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
> @@ -972,8 +959,7 @@
>  store_tolerance(struct device *dev, struct device_attribute *attr,
>  			const char *buf, size_t count)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
>  	u16 reg;
> @@ -981,13 +967,13 @@
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
> @@ -1058,14 +1044,13 @@
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
> @@ -1087,21 +1072,29 @@
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
>  
>  fan_time_functions(fan_stop_time, FAN_STOP_TIME)
>  
> +static ssize_t show_name(struct device *dev, struct device_attribute
> +			 *devattr, char *buf)
> +{
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", data->name);
> +}
> +
> +static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
>  
>  static struct sensor_device_attribute sda_sf3_arrays_fan4[] = {
>  	SENSOR_ATTR(pwm4_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
> @@ -1126,7 +1119,7 @@
>  };
>  
>  /*
> - * Driver and client management
> + * Driver and platform management
>   */
>  
>  static void w83627ehf_device_remove_files(struct device *dev)
> @@ -1134,12 +1127,13 @@
>  	/* some entries in the following arrays may not have been used in
>  	 * device_create_file(), but device_remove_file() will ignore them */
>  	int i;
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  
>  	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
>  		device_remove_file(dev, &sda_sf3_arrays[i].dev_attr);
>  	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
>  		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
> -	for (i = 0; i < w83627ehf_num_in; i++) {
> +	for (i = 0; i < data->in_num; i++) {
>  		device_remove_file(dev, &sda_in_input[i].dev_attr);
>  		device_remove_file(dev, &sda_in_alarm[i].dev_attr);
>  		device_remove_file(dev, &sda_in_min[i].dev_attr);
> @@ -1160,86 +1154,73 @@
>  	}
>  	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
>  		device_remove_file(dev, &sda_temp[i].dev_attr);
> -}
>  
> -static struct i2c_driver w83627ehf_driver;
> +	device_remove_file(dev, &dev_attr_name);
> +}
>  
> -static void w83627ehf_init_client(struct i2c_client *client)
> +/* w83627ehf_init_device() gets the monitoring functions started */
> +static inline void __devinit w83627ehf_init_device(struct w83627ehf_data *data)
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
> +/* w83627ehf_probe() looks for a Super-I/O chip at known addresses */
> +static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  {
> -	struct i2c_client *client;
> -	struct w83627ehf_data *data;
> -	struct device *dev;
> +	struct device *dev = &pdev->dev;
> +	struct w83627ehf_data *data = dev_get_drvdata(dev);
>  	u8 fan4pin, fan5pin;
>  	int i, err = 0;
>  
> -	if (!request_region(address + REGION_OFFSET, REGION_LENGTH,
> -	                    w83627ehf_driver.driver.name)) {
> +	if (!request_region(data->addr + REGION_OFFSET, REGION_LENGTH,
> +			   DRVNAME)) {
>  		err = -EBUSY;
> +		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
> +			(unsigned long) (data->addr + REGION_OFFSET),
> +			(unsigned long) (
> +			data->addr + REGION_OFFSET + REGION_LENGTH - 1));
>  		goto exit;
>  	}
>  
> -	if (!(data = kzalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
> -		err = -ENOMEM;
> -		goto exit_release;
> -	}
> -
> -	client = &data->client;
> -	i2c_set_clientdata(client, data);
> -	client->addr = address;
> -	mutex_init(&data->lock);
> -	client->adapter = adapter;
> -	client->driver = &w83627ehf_driver;
> -	client->flags = 0;
> -	dev = &client->dev;
> -
> -	if (w83627ehf_num_in = 9)
> -		strlcpy(client->name, "w83627dhg", I2C_NAME_SIZE);
> -	else	/* just say ehf. 627EHG is 627EHF in lead-free packaging. */
> -		strlcpy(client->name, "w83627ehf", I2C_NAME_SIZE);
> +	/* fill in fields in *data so w83627ehf_read_value(), etc., work */
>  
>  	data->valid = 0;
> +	mutex_init(&data->lock);
>  	mutex_init(&data->update_lock);
>  
> -	/* Tell the i2c layer a new client has arrived */
> -	if ((err = i2c_attach_client(client)))
> -		goto exit_free;
> +	/* 627EHG and 627EHF have 10 voltage inputs; DHG has 9 */
> +	data->in_num = (data->kind = w83627dhg) ? 9 : 10;
>  
>  	/* Initialize the chip */
> -	w83627ehf_init_client(client);
> +	w83627ehf_init_device(data);
>  
> -	/* A few vars need to be filled upon startup */
>  	for (i = 0; i < 5; i++)
> -		data->fan_min[i] = w83627ehf_read_value(client,
> +		data->fan_min[i] = w83627ehf_read_value(data,
>  				   W83627EHF_REG_FAN_MIN[i]);
>  
>  	/* fan4 and fan5 share some pins with the GPIO and serial flash */
>  
> -	superio_enter();
> -	fan5pin = superio_inb(0x24) & 0x2;
> -	fan4pin = superio_inb(0x29) & 0x6;
> -	superio_exit();
> +	superio_enter(data->sioreg);
> +	fan5pin = superio_inb(data->sioreg, 0x24) & 0x2;
> +	fan4pin = superio_inb(data->sioreg, 0x29) & 0x6;
> +	superio_exit(data->sioreg);
>  
>  	/* It looks like fan4 and fan5 pins can be alternatively used
>  	   as fan on/off switches, but fan5 control is write only :/
> @@ -1248,7 +1229,7 @@
>  	   is not the default. */
>  
>  	data->has_fan = 0x07; /* fan1, fan2 and fan3 */
> -	i = w83627ehf_read_value(client, W83627EHF_REG_FANDIV1);
> +	i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
>  	if ((i & (1 << 2)) && (!fan4pin))
>  		data->has_fan |= (1 << 3);
>  	if (!(i & (1 << 1)) && (!fan5pin))
> @@ -1257,18 +1238,17 @@
>  	/* Register sysfs hooks */
>    	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
>  		if ((err = device_create_file(dev,
> -			&sda_sf3_arrays[i].dev_attr)))
> +				&sda_sf3_arrays[i].dev_attr)))
>  			goto exit_remove;
>  
>  	/* if fan4 is enabled create the sf3 files for it */
>  	if (data->has_fan & (1 << 3))
> -		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++) {
> +		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
>  			if ((err = device_create_file(dev,
> -				&sda_sf3_arrays_fan4[i].dev_attr)))
> +					&sda_sf3_arrays_fan4[i].dev_attr)))
>  				goto exit_remove;
> -		}

These are cleanups which do not belong to this patch.

>  
> -	for (i = 0; i < w83627ehf_num_in; i++)
> +	for (i = 0; i < data->in_num; i++)
>  		if ((err = device_create_file(dev, &sda_in_input[i].dev_attr))
>  			|| (err = device_create_file(dev,
>  				&sda_in_alarm[i].dev_attr))
> @@ -1308,6 +1288,10 @@
>  		if ((err = device_create_file(dev, &sda_temp[i].dev_attr)))
>  			goto exit_remove;
>  
> +	err = device_create_file(dev, &dev_attr_name);
> +	if (err)
> +		goto exit_remove;
> +
>  	data->class_dev = hwmon_device_register(dev);
>  	if (IS_ERR(data->class_dev)) {
>  		err = PTR_ERR(data->class_dev);
> @@ -1318,95 +1302,175 @@
>  
>  exit_remove:
>  	w83627ehf_device_remove_files(dev);
> -	i2c_detach_client(client);
> -exit_free:
> -	kfree(data);
> -exit_release:
> -	release_region(address + REGION_OFFSET, REGION_LENGTH);
> +	release_region(data->addr + REGION_OFFSET, REGION_LENGTH);
>  exit:
>  	return err;
>  }
>  
> -static int w83627ehf_detach_client(struct i2c_client *client)
> +static int __devexit w83627ehf_remove(struct platform_device *pdev)
>  {
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> -	int err;
> +	struct w83627ehf_data *data = platform_get_drvdata(pdev);
>  
>  	hwmon_device_unregister(data->class_dev);
> -	w83627ehf_device_remove_files(&client->dev);
> +	w83627ehf_device_remove_files(&pdev->dev);
> +	platform_set_drvdata(pdev, NULL);
>  
> -	if ((err = i2c_detach_client(client)))
> -		return err;
> -	release_region(client->addr + REGION_OFFSET, REGION_LENGTH);

You shouldn't remove this. You requested the region in .probe(), you
_must_ release it in .remove()!

>  	kfree(data);

OTOH it's weird to free data here while you did not allocate it
in .probe().

>  
>  	return 0;
>  }
>  
> -static struct i2c_driver w83627ehf_driver = {
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
> -static int __init w83627ehf_find(int sioaddr, unsigned short *addr)
> +/* w83627ehf_superio_probe() looks for a '627 in the Super-I/O config space */
> +static int __init w83627ehf_superio_probe(int sioaddr,
> +					  struct w83627ehf_data *data)
>  {
>  	u16 val;
>  
> -	REG = sioaddr;
> -	VAL = sioaddr + 1;
> -	superio_enter();
> +	static const char * __initdata sio_names[] = {
> +		"W83627EHF",
> +		"W83627EHG",
> +		"W83627DHG",
> +	};

This probably doesn't do what you think it does. Here the __initdata
only applies to the pointers, not to the strings. So you aren't saving
anything compared to putting the strings directly in the switch/case
code.

If you really want the strings themselves to be __initdata, then you
have to define an array of arrays of chars, not an array of pointers:

	static const char __initdata sio_names[][10] = {
		"W83627EHF",
		"W83627EHG",
		"W83627DHG",
	};

With the drawback that you have to be careful to size the buffers
properly. gcc will unfortunately not complain if the trailing \0
doesn't fit, so it seems safer to explicitly add it yourself. (I
consider it a bug in gcc.)

Quite frankly, I don't think this is worth the trouble, and I would put
the strings in the code directly.

> +
> +	const char * sio_name;
>  
> -	val = (superio_inb(SIO_REG_DEVID) << 8)
> -	    | superio_inb(SIO_REG_DEVID + 1);
> +	data->sioreg = sioaddr;
> +
> +	superio_enter(data->sioreg);
> +
> +	val = (superio_inb(data->sioreg, SIO_REG_DEVID) << 8)
> +	    | superio_inb(data->sioreg, SIO_REG_DEVID + 1);
>  	switch (val & SIO_ID_MASK) {
> -	case SIO_W83627DHG_ID:
> -		w83627ehf_num_in = 9;
> -		break;
>  	case SIO_W83627EHF_ID:
> +		data->kind = w83627ehf;
> +		sio_name = sio_names[0];
> +		break;
>  	case SIO_W83627EHG_ID:
> -		w83627ehf_num_in = 10;
> +		data->kind = w83627ehf;
> +		sio_name = sio_names[1];
> +		break;
> +	case SIO_W83627DHG_ID:
> +		data->kind = w83627dhg;
> +		sio_name = sio_names[2];
>  		break;
>  	default:
> -		printk(KERN_WARNING "w83627ehf: unsupported chip ID: 0x%04x\n",
> +		pr_info(DRVNAME ": unsupported chip ID: 0x%04x\n",
>  			val);
> -		superio_exit();
> +		superio_exit(data->sioreg);
>  		return -ENODEV;
>  	}
>  
> -	superio_select(W83627EHF_LD_HWM);
> -	val = (superio_inb(SIO_REG_ADDR) << 8)
> -	    | superio_inb(SIO_REG_ADDR + 1);
> -	*addr = val & REGION_ALIGNMENT;
> -	if (*addr = 0) {
> -		superio_exit();
> +	/* we have known chip find the HWMON base */
> +
> +	superio_select(data->sioreg, W83627EHF_LD_HWM);
> +	val = (superio_inb(data->sioreg, SIO_REG_ADDR) << 8)
> +	    | superio_inb(data->sioreg, SIO_REG_ADDR + 1);
> +	data->addr = val & REGION_ALIGNMENT;
> +	if (data->addr = 0) {
> +		superio_exit(data->sioreg);

Note for a future patch: it would be user-friendly to log the reason
why we're exiting here.

>  		return -ENODEV;
>  	}
>  
>  	/* Activate logical device if needed */
> -	val = superio_inb(SIO_REG_ENABLE);
> +	val = superio_inb(data->sioreg, SIO_REG_ENABLE);
>  	if (!(val & 0x01))
> -		superio_outb(SIO_REG_ENABLE, val | 0x01);
> +		superio_outb(data->sioreg, SIO_REG_ENABLE, val | 0x01);

Note for a future patch: it would be user-friendly to warn that the
device was forcibly enabled and that the readings may not make sense.

>  
> -	superio_exit();
> +	superio_exit(data->sioreg);
> +	pr_info(DRVNAME ": Found %s chip at %#x\n",
> +		sio_name, data->addr);
>  	return 0;
>  }
>  
> +/* when Super-I/O functions move to a separate file, the Super-I/O
> + * bus will manage the lifetime of the device and the w83627ehf driver
> + * but since we platform_device_alloc(), we must keep track of the device */

The "and the w83627ehf driver" part of your sentence doesn't make much
sense and should be removed? Either that, or a part is missing.

> +struct platform_device * pdev;

Should be declared static. Usually we leave no space between the "*"
and the variable name.

> +
>  static int __init sensors_w83627ehf_init(void)
>  {
> -	if (w83627ehf_find(0x2e, &address)
> -	 && w83627ehf_find(0x4e, &address))
> -		return -ENODEV;
> +	int err;
> +	struct resource res;
> +	struct w83627ehf_data *data;
> +
> +	if (!(data = kzalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}

This is an interesting approach. I did it differently in the other
drivers. Your way saves some memory and some code, but OTOH it breaks
the device driver model. The platform-specific data is supposed to be
stored in dev.platform_data, NOT dev.driver_data. The code which
instantiates the device isn't supposed to know how the driver is
implemented. Nothing prevents a given device from being supported by
more than one driver!

So setting dev.driver_dat before .probe() is called sounds bad, and I
suspect we will have to move this part to the .probe() function once
we have a superio subsystem, anyway. So we might as well do it now.
What do you think?

> +
> +	/* initialize data->kind, data->sioreg, and data->addr.
> +	 *
> +	 * when Super-I/O functions move to a separate file, the Super-I/O
> +	 * driver will probe 0x23 and 0x4e and auto-detect the presence of a

Typo: 0x2e, not Ox23.

> +	 * w83627ehf hardware monitor, and call probe() */
> +	if (w83627ehf_superio_probe(0x2e, data) &&
> +	    w83627ehf_superio_probe(0x4e, data)) {
> +		err = -ENODEV;
> +		goto exit_free;
> +	}
>  
> -	return i2c_isa_add_driver(&w83627ehf_driver);
> +	if ((err = platform_driver_register(&w83627ehf_driver))!=0)
> +		goto exit_free;

Please remove the "!=0".

> +
> +	if (!(pdev = platform_device_alloc(DRVNAME, data->addr))) {
> +		err = -ENOMEM;
> +		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> +		goto exit_unregister;
> +	}
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	memset(&res, 0, sizeof(res));
> +	data->name = w83627ehf_device_names[data->kind];
> +	res.name = data->name;
> +	res.start = data->addr + REGION_OFFSET;
> +	res.end   = data->addr + REGION_OFFSET + REGION_LENGTH - 1;

No alignment in code blocks please.

> +	res.flags = IORESOURCE_IO;
> +	err = platform_device_add_resources(pdev, &res, 1);
> +	if (err) {
> +		printk(KERN_ERR DRVNAME ": Device resource addition failed "
> +		       "(%d)\n", err);
> +		goto exit_device_put;
> +	}
> +
> +	/* platform_device_add calls probe() */
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
> +	pdev->dev.platform_data = NULL;
> +	platform_device_put(pdev);
> +exit_unregister:
> +	platform_driver_unregister(&w83627ehf_driver);
> +exit_free:
> +	kfree(data);
> +exit:
> +	return err;
>  }
>  
>  static void __exit sensors_w83627ehf_exit(void)
>  {
> -	i2c_isa_del_driver(&w83627ehf_driver);
> +	/* when Super-I/O functions move to a separate file, devices
> +	 * will be unregistered before unloading the module.

Not true. When Super-I/O handling is moved to a separate module,
devices will live their life independently from a driver being loaded
for them or not. So devices will survive the w83627ehf driver unloading.

> +	 *
> +	 * for now, only one device is added in sensors_w83627ehf_init */
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&w83627ehf_driver);
>  }
>  
>  MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");
> --- linux-2.6.21-rc5/drivers/hwmon/Kconfig	2007-03-28 17:25:43.000000000 -0700
> +++ linux-2.6.21-rc5/drivers/hwmon/Kconfig	2007-03-28 20:50:11.000000000 -0700
> @@ -527,7 +527,6 @@
>  config SENSORS_W83793
>  	tristate "Winbond W83793"
>  	depends on HWMON && I2C && EXPERIMENTAL
> -	select HWMON_VID
>  	help
>  	  If you say yes here you get support for the Winbond W83793
>  	  hardware monitoring chip.

You definitely don't want to do that.

> @@ -560,17 +559,15 @@
>  	  will be called w83627hf.
>  
>  config SENSORS_W83627EHF
> -	tristate "Winbond W83627EHF"
> -	depends on HWMON && I2C && EXPERIMENTAL
> -	select I2C_ISA
> +	tristate "Winbond W83627EHF/DHG"
> +	depends on HWMON && EXPERIMENTAL
>  	help
> -	  If you say yes here you get preliminary support for the hardware
> -	  monitoring functionality of the Winbond W83627EHF Super-I/O chip.
> -	  Only fan and temperature inputs are supported at the moment, while
> -	  the chip does much more than that.
> +	  If you say yes here you get support for the hardware
> +	  monitoring functionality of the Winbond W83627EHF/DHG Super-I/O chip.
>  
>  	  This driver also supports the W83627EHG, which is the lead-free
> -	  version of the W83627EHF.
> +	  version of the W83627EHF. The driver also supports the W83627DHG,
> +	  which is a version suited for specific Intel processor sensing (PECI).
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called w83627ehf.

Most of this doesn't belong to this patch and should be moved to a
separate patch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
