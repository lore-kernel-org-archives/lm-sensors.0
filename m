From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 12 Nov 2009 21:10:10 +0000
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon:driver support for Kionix
Message-Id: <4AFC79B2.6060203@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257877729-25647-1-git-send-email-chudson@kionix.com>
In-Reply-To: <1257877729-25647-1-git-send-email-chudson@kionix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: chudson@kionix.com
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-omap@vger.kernel.org

Hi Chris, 

Obviously a few things will change with your move over to input, but as I have
a few mins and might not then, here are a few comments.

The ones I'd really like to see acted upon are

*removing the global pointer that
restricts you to one device (all hell will break loose if you add a second one
currently!)
*Explanation or removal of the various 'retries' on the i2c bus. 
*justification or removal of the dedicated work queue
*Clean up and documenation of the platform data.

More detailed comments inline.

Do copy me in when you post version for input.

Thanks,

Jonathan

> From: Chris Hudson <chudson@kionix.com>
> 
> This is a request for comments for adding driver support for the Kionix KXTE9 
> digital tri-axis accelerometer.  This part features built-in tilt position 
> (orientation), wake-up and back-to-sleep algorithms, which can trigger a 
> user-configurable physical interrupt.  The driver uses i2c for device 
> communication, a misc node for IOCTLs, and input nodes for reporting 
> acceleration data and interrupt status information.
> 
> Signed-off-by: Chris Hudson <chudson@kionix.com>
> ---
>  drivers/hwmon/Kconfig  |   10 +
>  drivers/hwmon/Makefile |    1 +
>  drivers/hwmon/kxte9.c  |  998 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/kxte9.h  |   95 +++++
>  4 files changed, 1104 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/kxte9.c
>  create mode 100644 include/linux/kxte9.h
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 700e93a..f52e141 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -419,6 +419,16 @@ config SENSORS_IT87
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called it87.
>  
> +config SENSORS_KXTE9
> +	tristate "Kionix KXTE9 tri-axis digital accelerometer"
> +	depends on I2C && SYSFS
> +	help
> +	  If you say yes here you get support for the Kionix KXTE9 digital
> +	  tri-axis accelerometer.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called kxte9.
> +
>  config SENSORS_LM63
>  	tristate "National Semiconductor LM63"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 9f46cb0..65ce35e 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
>  obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
>  obj-$(CONFIG_SENSORS_IT87)	+= it87.o
>  obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
> +obj-$(CONFIG_SENSORS_KXTE9)	+= kxte9.o
>  obj-$(CONFIG_SENSORS_LIS3LV02D) += lis3lv02d.o hp_accel.o
>  obj-$(CONFIG_SENSORS_LIS3_SPI)	+= lis3lv02d.o lis3lv02d_spi.o
>  obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
> diff --git a/drivers/hwmon/kxte9.c b/drivers/hwmon/kxte9.c
> new file mode 100644
> index 0000000..29df50e
> --- /dev/null
> +++ b/drivers/hwmon/kxte9.c
> @@ -0,0 +1,998 @@
> +/*
> + * Copyright (C) 2009 Kionix, Inc.
> + * Written by Chris Hudson <chudson@kionix.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
> + * 02111-1307, USA
> + */
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input-polldev.h>
> +#include <linux/miscdevice.h>
> +#include <linux/uaccess.h>
> +#include <linux/workqueue.h>
> +#include <linux/irq.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kxte9.h>
> +
> +#define NAME			"kxte9"
> +#define G_MAX			2000
> +/* OUTPUT REGISTERS */
> +#define XOUT			0x12
> +#define INT_STATUS_REG		0x16
> +#define INT_SRC_REG2		0x17
> +#define TILT_POS_CUR		0x10
> +#define TILT_POS_PRE		0x11
> +#define INT_REL			0x1A
> +/* CONTROL REGISTERS */
> +#define CTRL_REG1		0x1B
> +#define CTRL_REG3		0x1D
> +#define INT_CTRL1		0x1E
> +#define TILT_TIMER		0x28
> +#define WUF_TIMER		0x29
> +#define B2S_TIMER		0x2A
> +#define WUF_THRESH		0x5A
> +#define B2S_THRESH		0x5B
> +/* CONTROL REGISTER 1 BITS */
> +#define PC1_OFF			0x00
> +#define PC1_ON			0x80
> +/* INTERRUPT SOURCE 1 BITS */
> +#define TPS			0x01
> +#define WUFS			0x02
> +#define B2SS			0x04
> +/* INPUT_ABS CONSTANTS */
> +#define FUZZ			32
> +#define FLAT			32
> +#define I2C_RETRY_DELAY		5
> +#define I2C_RETRIES		5
> +/* RESUME STATE INDICES */
> +#define RES_CTRL_REG1		0
> +#define RES_CTRL_REG3		1
> +#define RES_INT_CTRL1		2
> +#define RES_TILT_TIMER		3
> +#define RES_WUF_TIMER		4
> +#define RES_B2S_TIMER		5
> +#define RES_WUF_THRESH		6
> +#define RES_B2S_THRESH		7
> +#define RES_INTERVAL		8
> +#define RES_CURRENT_ODR		9
> +#define RESUME_ENTRIES		10
> +

Comment on what this is would be good.
> +struct {
> +	unsigned int cutoff;
> +	u8 mask;
> +} kxte9_odr_table[] = {
> +	{
> +	25,	ODR125}, {
> +	100,	ODR40}, {
> +	334,	ODR10}, {
> +	1000,	ODR3}, {
> +	0,	ODR1},};
> +
> +struct kxte9_data {
> +	struct i2c_client *client;
> +	struct kxte9_platform_data *pdata;
> +	struct mutex lock;
> +	struct delayed_work input_work;
> +	struct input_dev *input_dev;
> +	struct work_struct irq_work;
> +	struct workqueue_struct *irq_work_queue;
> +
> +	int hw_initialized;
> +	atomic_t enabled;
> +	u8 resume_state[RESUME_ENTRIES];
> +	int irq;
> +};

I think this restricts you to one kxte9 chip. Definitely
not a good thing for your sales ;) Don't ever use global
variable like this.
> +static struct kxte9_data *kxte9_misc_data;
> +
> +static int kxte9_i2c_read(struct kxte9_data *te9, u8 *buf, int len)
> +{
> +	int err;
> +	int tries = 0;
> +
> +	struct i2c_msg msgs[] = {
> +		{
> +		 .addr = te9->client->addr,
> +		 .flags = te9->client->flags & I2C_M_TEN,
> +		 .len = 1,
> +		 .buf = buf,
> +		 },
> +		{
> +		 .addr = te9->client->addr,
> +		 .flags = (te9->client->flags & I2C_M_TEN) | I2C_M_RD,
> +		 .len = len,
> +		 .buf = buf,
> +		 },
> +	};
> +	do {
> +		err = i2c_transfer(te9->client->adapter, msgs, 2);
> +		if (err != 2)
> +			msleep_interruptible(I2C_RETRY_DELAY);
> +	} while ((err != 2) && (++tries < I2C_RETRIES));
Why the retries?  Does the chip typically ignore some requests?
Unless something odd is going on, only ever try once.  If it doesn't
reply then it can be considered dead.  If you know particular odd cases
require this then you'll need extensive comments to explain it.

> +
> +	if (err != 2) {
> +		dev_err(&te9->client->dev, "read transfer error\n");

If err > 0 and not 2 then maybe. Otherwise you should be passing on whatever
error the i2c controller gave. Don't rewrite errors before pass up.
> +		err = -EIO;
> +	} else {
> +		err = 0;
> +	}
> +
> +	return err;
> +}

Equivalent comments to the read funciton.
> +static int kxte9_i2c_write(struct kxte9_data *te9, u8 * buf, int len)
> +{
> +	int err;
> +	int tries = 0;
> +
> +	struct i2c_msg msgs[] = {
> +		{
> +		 .addr = te9->client->addr,
> +		 .flags = te9->client->flags & I2C_M_TEN,
> +		 .len = len + 1,
> +		 .buf = buf,
> +		 },
> +	};
> +	do {
> +		err = i2c_transfer(te9->client->adapter, msgs, 1);
> +		if (err != 1)
> +			msleep_interruptible(I2C_RETRY_DELAY);
> +	} while ((err != 1) && (++tries < I2C_RETRIES));
> +
> +	if (err != 1) {
> +		dev_err(&te9->client->dev, "write transfer error\n");
> +		err = -EIO;
> +	} else {
> +		err = 0;
> +	}
> +
> +	return err;
> +}
> +
> +static int kxte9_hw_init(struct kxte9_data *te9)
> +{
> +	int err = -1;
Don't bother with assigning err a value. It's guaranteed to get one
anyway.

> +	u8 buf[2] = { CTRL_REG1, PC1_OFF };
> +
> +	err = kxte9_i2c_write(te9, buf, 1);
> +	if (err < 0)
> +		return err;
The way you are using the first element of buf for addresses
is somewhat tricky to follow.  Would probably be better to pass
the register address in a separate variable (similar to the smbus
commands in i2c.h)  Then you end up passing an array whose size
matches that of buf.   (even using sizeof to make that explicit
would be good).

Thinking about it, with so many single byte to register writes,
an eplicit function e.g. kxte9_i2c_write(chip_info, address, value)
would make this more readable. (Note the chip_info, would be an instance
specific structure, not the global one used currently, for what I mean
see most hwmon drivers.)
> +	buf[0] = CTRL_REG3;
> +	buf[1] = te9->resume_state[RES_CTRL_REG3];
> +	err = kxte9_i2c_write(te9, buf, 1);
> +	if (err < 0)
> +		return err;
> +	buf[0] = INT_CTRL1;
> +	buf[1] = te9->resume_state[RES_INT_CTRL1];
> +	err = kxte9_i2c_write(te9, buf, 1);
> +	if (err < 0)
> +		return err;
> +	buf[0] = TILT_TIMER;
> +	buf[1] = te9->resume_state[RES_TILT_TIMER];
> +	err = kxte9_i2c_write(te9, buf, 1);
> +	if (err < 0)
> +		return err;
> +	buf[0] = WUF_TIMER;
> +	buf[1] = te9->resume_state[RES_WUF_TIMER];
> +	err = kxte9_i2c_write(te9, buf, 1);
> +	if (err < 0)
> +		return err;
> +	buf[0] = B2S_TIMER;
> +	buf[1] = te9->resume_state[RES_B2S_TIMER];
> +	err = kxte9_i2c_write(te9, buf, 1);
> +	if (err < 0)
> +		return err;
> +	buf[0] = WUF_THRESH;
> +	buf[1] = te9->resume_state[RES_WUF_THRESH];
> +	err = kxte9_i2c_write(te9, buf, 1);
> +	if (err < 0)
> +		return err;
> +	buf[0] = B2S_THRESH;
> +	buf[1] = te9->resume_state[RES_B2S_THRESH];
> +	err = kxte9_i2c_write(te9, buf, 1);
> +	if (err < 0)
> +		return err;
> +	buf[0] = CTRL_REG1;
> +	buf[1] = (te9->resume_state[RES_CTRL_REG1] | PC1_ON);
> +	err = kxte9_i2c_write(te9, buf, 1);
> +	if (err < 0)
> +		return err;
> +	te9->resume_state[RES_CTRL_REG1] = buf[1];
> +	te9->hw_initialized = 1;
> +
> +	return 0;
> +}
> +
> +static void kxte9_device_power_off(struct kxte9_data *te9)
> +{
> +	int err;
> +	u8 buf[2] = { CTRL_REG1, PC1_OFF };
> +
> +	err = kxte9_i2c_write(te9, buf, 1);
> +	if (err < 0)
> +		dev_err(&te9->client->dev, "soft power off failed\n");
> +	disable_irq_nosync(te9->irq);
> +	if (te9->pdata->power_off)
> +		te9->pdata->power_off();
> +	te9->hw_initialized = 0;
> +}
> +
> +static int kxte9_device_power_on(struct kxte9_data *te9)
> +{
> +	int err;
> +
> +	if (te9->pdata->power_on) {
> +		err = te9->pdata->power_on();
> +		if (err < 0)
> +			return err;
> +	}
> +	enable_irq(te9->irq);
> +	if (!te9->hw_initialized) {
> +		mdelay(110);
> +		err = kxte9_hw_init(te9);
> +		if (err < 0) {
> +			kxte9_device_power_off(te9);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t kxte9_isr(int irq, void *dev)
> +{
> +	struct kxte9_data *te9 = dev;
> +
> +	disable_irq_nosync(irq);
> +	queue_work(te9->irq_work_queue, &te9->irq_work);
> +
> +	return IRQ_HANDLED;
> +}
> +static u8 kxte9_resolve_dir(struct kxte9_data *te9, u8 dir)
> +{
> +	switch (dir) {
> +	case 0x20:	/* -X */
> +		if (te9->pdata->negate_x)
> +			dir = 0x10;
> +		if (te9->pdata->axis_map_y = 0)
> +			dir >>= 2;
> +		if (te9->pdata->axis_map_z = 0)
> +			dir >>= 4;
> +		break;
> +	case 0x10:	/* +X */
> +		if (te9->pdata->negate_x)
> +			dir = 0x20;
> +		if (te9->pdata->axis_map_y = 0)
> +			dir >>= 2;
> +		if (te9->pdata->axis_map_z = 0)
> +			dir >>= 4;
> +		break;
> +	case 0x08:	/* -Y */
> +		if (te9->pdata->negate_y)
> +			dir = 0x04;
> +		if (te9->pdata->axis_map_x = 1)
> +			dir <<= 2;
> +		if (te9->pdata->axis_map_z = 1)
> +			dir >>= 2;
> +		break;
> +	case 0x04:	/* +Y */
> +		if (te9->pdata->negate_y)
> +			dir = 0x08;
> +		if (te9->pdata->axis_map_x = 1)
> +			dir <<= 2;
> +		if (te9->pdata->axis_map_z = 1)
> +			dir >>= 2;
> +		break;
> +	case 0x02:	/* -Z */
> +		if (te9->pdata->negate_z)
> +			dir = 0x01;
> +		if (te9->pdata->axis_map_x = 2)
> +			dir <<= 4;
> +		if (te9->pdata->axis_map_y = 2)
> +			dir <<= 2;
> +		break;
> +	case 0x01:	/* +Z */
> +		if (te9->pdata->negate_z)
> +			dir = 0x02;
> +		if (te9->pdata->axis_map_x = 2)
> +			dir <<= 4;
> +		if (te9->pdata->axis_map_y = 2)
> +			dir <<= 2;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return dir;
> +}
> +
> +static void kxte9_irq_work_func(struct work_struct *work)
> +{
> +/*
> + *	int_status output:
> + *	[INT_SRC_REG1][INT_SRC_REG2][TILT_POS_PRE][TILT_POS_CUR]
> + *	INT_SRC_REG2, TILT_POS_PRE, and TILT_POS_CUR directions are translated
> + *	based on platform data variables.
> + */
> +
> +	int err;
> +	int i;
> +	int int_status = 0;
> +	u8 status;
> +	u8 b2s_comp;
> +	u8 wuf_comp;
> +	u8 buf[2];
> +
> +	struct kxte9_data *te9 = container_of(work,
> +						struct kxte9_data, irq_work);
Guessing the light break is to keep under 80 chars. Might look better to break
before = ?
> +	if (!gpio_get_value(te9->pdata->gpio)) {
> +		enable_irq(te9->irq);
> +		return;
> +	}
This condition looks 'unusual'. Why would interrupt have triggered if this is
the case?  If it is needed, please document why. I haven't read the datasheet
so it might be obvious from there, but it is always good to document things
that are unusual like this in drivers as it stops people copying them inappropriately
in the future.

> +
> +	status = INT_STATUS_REG;
> +	err = kxte9_i2c_read(te9, &status, 1);
> +	if (err < 0)
> +		dev_err(&te9->client->dev, "read err int source\n");
> +	int_status = status << 24;
> +	if ((status & TPS) > 0) {
> +		buf[0] = TILT_POS_CUR;
> +		err = kxte9_i2c_read(te9, buf, 2);
> +		if (err < 0)
> +			dev_err(&te9->client->dev, "read err tilt dir\n");
> +		int_status |= kxte9_resolve_dir(te9, buf[0]);
> +		int_status |= (kxte9_resolve_dir(te9, buf[1])) << 8;
> +		/*** DEBUG OUTPUT - REMOVE ***/
> +		dev_info(&te9->client->dev, "IRQ TILT [%x]\n", kxte9_resolve_dir(te9, buf[0]));
> +		/*** <end> DEBUG OUTPUT - REMOVE ***/
> +	}
> +	if ((status & WUFS) > 0) {
> +		buf[0] = INT_SRC_REG2;
> +		err = kxte9_i2c_read(te9, buf, 1);
> +		if (err < 0)
> +			dev_err(&te9->client->dev, "reading err wuf dir\n");
> +		int_status |= (kxte9_resolve_dir(te9, buf[0])) << 16;
> +		/*** DEBUG OUTPUT - REMOVE ***/
> +		dev_info(&te9->client->dev, "IRQ WUF [%x]\n", kxte9_resolve_dir(te9, buf[0]));
> +		/*** <end> DEBUG OUTPUT - REMOVE ***/
I guess this what you mentioned in the other thread ;)

> +		b2s_comp = te9->resume_state[RES_CTRL_REG3] & 0x0C >> 2;
Some brackets might make this more readable? (I for one can never remember the precedence)
 
> +		wuf_comp = te9->resume_state[RES_CTRL_REG3] & 0x03;
> +		if (!te9->resume_state[RES_CURRENT_ODR] &&
> +				!(te9->resume_state[RES_CTRL_REG1] & ODR125) &&
> +						!(b2s_comp & wuf_comp)) {
> +			/* set the new poll interval based on wuf odr */
> +			for (i = 1; i < ARRAY_SIZE(kxte9_odr_table); i++) {
> +				te9->pdata->poll_interval > +						kxte9_odr_table[i - 1].cutoff;
> +				if (kxte9_odr_table[i].mask =	wuf_comp << 3)
> +						break;
> +			}
> +			if (te9->input_dev) {
> +				cancel_delayed_work_sync(&te9->input_work);
> +				schedule_delayed_work(&te9->input_work,
> +						msecs_to_jiffies(te9->pdata->
> +								poll_interval));
> +			}
> +		}
> +	}
> +	if ((status & B2SS) > 0) {
> +		/*** DEBUG OUTPUT - REMOVE ***/
> +		dev_info(&te9->client->dev, "IRQ B2S\n");
> +		/*** <end> DEBUG OUTPUT - REMOVE ***/
> +		b2s_comp = te9->resume_state[RES_CTRL_REG3] & 0x0C >> 2;
> +		wuf_comp = te9->resume_state[RES_CTRL_REG3] & 0x03;
> +		if (!te9->resume_state[RES_CURRENT_ODR] &&
> +				!(te9->resume_state[RES_CTRL_REG1] & ODR125) &&
> +						!(b2s_comp & wuf_comp)) {
> +			/* set the new poll interval based on b2s odr */
> +			for (i = 1; i < ARRAY_SIZE(kxte9_odr_table); i++) {
> +				te9->pdata->poll_interval > +						kxte9_odr_table[i - 1].cutoff;
> +				if (kxte9_odr_table[i].mask = b2s_comp << 3)
> +						break;
> +			}
> +			if (te9->input_dev) {
> +				cancel_delayed_work_sync(&te9->input_work);
> +				schedule_delayed_work(&te9->input_work,
> +						msecs_to_jiffies(te9->pdata->
> +								poll_interval));
> +			}
> +		}
> +	}
> +	input_report_abs(te9->input_dev, ABS_MISC, int_status);
> +	input_sync(te9->input_dev);
> +	buf[0] = INT_REL;
> +	err = kxte9_i2c_read(te9, buf, 1);
> +	if (err < 0)
> +		dev_err(&te9->client->dev, "error clearing interrupt\n");
> +	enable_irq(te9->irq);
> +}
> +
> +static int kxte9_update_odr(struct kxte9_data *te9, int poll_interval)
> +{
> +	int err = -1;
> +	int i;
> +	u8 config[2];
> +
> +	/*
> +	 *  Convert the poll interval into an output data rate configuration
> +	 *  that is as low as possible.  The ordering of these checks must be
> +	 *  maintained due to the cascading cut off values - poll intervals are
> +	 *  checked from shortest to longest.  At each check, if the next lower
> +	 *  ODR cannot support the current poll interval, we stop searching
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(kxte9_odr_table); i++) {
> +		config[1] = kxte9_odr_table[i].mask;
> +		if (poll_interval < kxte9_odr_table[i].cutoff)
> +			break;
> +	}
> +
> +	if (atomic_read(&te9->enabled)) {
> +		config[0] = CTRL_REG1;
> +		config[1] |= (te9->resume_state[RES_CTRL_REG1] & ~ODR40);
> +		err = kxte9_i2c_write(te9, config, 1);
> +		if (err < 0)
> +			return err;
> +		/*
> +		 *  Latch on input_dev - indicates that kxte9_input_init passed
> +		 *  and this workqueue is available
> +		 */
> +		if (te9->input_dev) {
> +			cancel_delayed_work_sync(&te9->input_work);
> +			schedule_delayed_work(&te9->input_work,
> +					msecs_to_jiffies(poll_interval));
> +		}
> +	}
> +	te9->resume_state[RES_CTRL_REG1] = config[1];
> +
> +	return 0;
> +}
> +
> +static int kxte9_get_acceleration_data(struct kxte9_data *te9, int *xyz)
> +{
> +	int err = -1;
> +	/* Data bytes from hardware x, y, z */
> +	u8 acc_data[3];
> +	/* x,y,z hardware values */
> +	int hw_d[3] = { 0 };
You are going to overwrite this anyway, so why assign? Only time it would
make difference during an error condition and then you shouldn't read the
values anyway.

> +	acc_data[0] = XOUT;
> +
> +	err = kxte9_i2c_read(te9, acc_data, 3);
> +	if (err < 0)
> +		return err;

Combine the next few sets of 3 lines?  That's a lot of code for something that to me looks
like
for (i = 0; i < 3; i++)
	hw_d[i] = ((int)(acc_data[i]>>2))-32) << 6)

or even (I think)

hw_d[i] = ((int)(acc_data[i]) - 160) << 4;
> +
> +	acc_data[0] >>= 2;
> +	acc_data[1] >>= 2;
> +	acc_data[2] >>= 2;
> +
> +	hw_d[0] = (int) acc_data[0];
> +	hw_d[1] = (int) acc_data[1];
> +	hw_d[2] = (int) acc_data[2];
> +
> +	hw_d[0] -= 32;
> +	hw_d[1] -= 32;
> +	hw_d[2] -= 32;
> +
> +	hw_d[0] <<= 6;
> +	hw_d[1] <<= 6;
> +	hw_d[2] <<= 6;

You'll get some negative comments on that sort of use of the ternary operator.
(personally don't mind but there we are)
> +	xyz[0] = ((te9->pdata->negate_x) ? (-hw_d[te9->pdata->axis_map_x])
> +		  : (hw_d[te9->pdata->axis_map_x]));
> +	xyz[1] = ((te9->pdata->negate_y) ? (-hw_d[te9->pdata->axis_map_y])
> +		  : (hw_d[te9->pdata->axis_map_y]));
> +	xyz[2] = ((te9->pdata->negate_z) ? (-hw_d[te9->pdata->axis_map_z])
> +		  : (hw_d[te9->pdata->axis_map_z]));
> +
> +	/*** DEBUG OUTPUT - REMOVE ***/
> +	dev_info(&te9->client->dev, "x:%d y:%d z:%d\n", xyz[0], xyz[1], xyz[2]);
> +	/*** <end> DEBUG OUTPUT - REMOVE ***/
> +
> +	return err;
> +}
> +
> +static void kxte9_report_values(struct kxte9_data *te9, int *xyz)
> +{
> +	input_report_abs(te9->input_dev, ABS_X, xyz[0]);
> +	input_report_abs(te9->input_dev, ABS_Y, xyz[1]);
> +	input_report_abs(te9->input_dev, ABS_Z, xyz[2]);
> +	input_sync(te9->input_dev);
> +}
> +
> +static int kxte9_enable(struct kxte9_data *te9)
> +{
> +	int err;
> +	int int_status = 0;
> +	u8 buf;
> +
I'd have used a spin lock but I guess this is cheaper.
> +	if (!atomic_cmpxchg(&te9->enabled, 0, 1)) {
> +		err = kxte9_device_power_on(te9);
> +		buf = INT_REL;
> +		err = kxte9_i2c_read(te9, &buf, 1);
> +		if (err < 0)
> +			dev_err(&te9->client->dev,
> +					"error clearing interrupt: %d\n", err);
> +		if (err < 0) {
> +			atomic_set(&te9->enabled, 0);
> +			return err;
> +		}
> +		if ((te9->resume_state[RES_CTRL_REG1] & TPS) > 0) {
> +			buf = TILT_POS_CUR;
> +			err = kxte9_i2c_read(te9, &buf, 1);
> +			if (err < 0)
> +				dev_err(&te9->client->dev,
> +					"kxte9 error reading current tilt\n");
> +			int_status |= kxte9_resolve_dir(te9, buf);
> +			input_report_abs(te9->input_dev, ABS_MISC, int_status);
> +			input_sync(te9->input_dev);
> +		}
> +
> +		schedule_delayed_work(&te9->input_work,
> +				      msecs_to_jiffies(te9->
> +						       pdata->poll_interval));
> +	}
> +
> +	return 0;
> +}
> +
> +static int kxte9_disable(struct kxte9_data *te9)
> +{
> +	if (atomic_cmpxchg(&te9->enabled, 1, 0)) {
> +		cancel_delayed_work_sync(&te9->input_work);
> +		kxte9_device_power_off(te9);
> +	}
> +
> +	return 0;
> +}
> +
> +static int kxte9_misc_open(struct inode *inode, struct file *file)
> +{
> +	int err;
> +
> +	err = nonseekable_open(inode, file);
> +	if (err < 0)
> +		return err;
> +	file->private_data = kxte9_misc_data;
> +
> +	return 0;
> +}

This is a lot of ioctls.  Would probably be preferable to use sysfs for this
sort of stuff.
> +static int kxte9_misc_ioctl(struct inode *inode, struct file *file,
> +				unsigned int cmd, unsigned long arg)
> +{
> +	void __user *argp = (void __user *)arg;
> +	u8 ctrl[2] = { CTRL_REG1, PC1_OFF };
> +	int err;
> +	int tmp;
> +	struct kxte9_data *te9 = file->private_data;
> +
> +	switch (cmd) {
> +	case KXTE9_IOCTL_GET_DELAY:
> +		tmp = te9->pdata->poll_interval;
> +		if (copy_to_user(argp, &tmp, sizeof(tmp)))
> +			return -EFAULT;
> +		break;
> +	case KXTE9_IOCTL_SET_DELAY:
> +		if (copy_from_user(&tmp, argp, sizeof(tmp)))
> +			return -EFAULT;
> +		if (tmp < 0)
> +			return -EINVAL;
> +		te9->pdata->poll_interval = max(tmp, te9->pdata->min_interval);
> +		err = kxte9_update_odr(te9, te9->pdata->poll_interval);
> +		if (err < 0)
> +			return err;
> +		ctrl[0] = CTRL_REG3;
> +		ctrl[1] = te9->resume_state[RES_CTRL_REG1] & 0x18;
> +		te9->resume_state[RES_CURRENT_ODR] = ctrl[1];
This looks 'interesting'. Perhaps a comment?
> +		ctrl[1] = (ctrl[1] >> 1) | (ctrl[1] >> 3);
> +		err = kxte9_i2c_write(te9, ctrl, 1);
> +		if (err < 0)
> +			return err;
> +		te9->resume_state[RES_CTRL_REG3] = ctrl[1];
> +		break;
> +	case KXTE9_IOCTL_SET_ENABLE:
> +		if (copy_from_user(&tmp, argp, sizeof(tmp)))
> +			return -EFAULT;
> +		if (tmp < 0 || tmp > 1)
> +			return -EINVAL;
> +
> +		if (tmp)
> +			kxte9_enable(te9);
> +		else
> +			kxte9_disable(te9);
> +		break;
> +	case KXTE9_IOCTL_GET_ENABLE:
> +		tmp = atomic_read(&te9->enabled);
> +		if (copy_to_user(argp, &tmp, sizeof(tmp)))
> +			return -EINVAL;
> +		break;
> +	case KXTE9_IOCTL_SET_TILT_ENABLE:
> +		if (copy_from_user(&tmp, argp, sizeof(tmp)))
> +			return -EFAULT;
> +		if (tmp < 0 || tmp > 1)
> +			return -EINVAL;
> +		if (tmp)
> +			te9->resume_state[RES_CTRL_REG1] |= TPE;
> +
> +		else
> +			te9->resume_state[RES_CTRL_REG1] &= (~TPE);
> +		ctrl[1] = te9->resume_state[RES_CTRL_REG1];
> +		err = kxte9_i2c_write(te9, ctrl, 1);
> +		if (err < 0)
> +			return err;
> +		break;
> +	case KXTE9_IOCTL_SET_WAKE_ENABLE:
> +		if (copy_from_user(&tmp, argp, sizeof(tmp)))
Return what copy_from_user does (can't remember, but I'm guessing it's an error code)
> +			return -EFAULT;
> +		if (tmp < 0 || tmp > 1)
> +			return -EINVAL;
> +		if (tmp) {
> +			te9->resume_state[RES_CTRL_REG1] |= (WUFE | B2SE);
> +			ctrl[1] = te9->resume_state[RES_CTRL_REG1];
> +			err = kxte9_i2c_write(te9, ctrl, 1);
> +			if (err < 0)
> +				return err;
> +		} else {
> +			te9->resume_state[RES_CTRL_REG1] &= (~WUFE & ~B2SE);
> +			ctrl[1] = te9->resume_state[RES_CTRL_REG1];
> +			err = kxte9_i2c_write(te9, ctrl, 1);
> +			if (err < 0)
> +				return err;
> +		}
> +		break;
> +	case KXTE9_IOCTL_SELF_TEST:
> +		if (copy_from_user(&tmp, argp, sizeof(tmp)))
> +			return -EFAULT;
> +		if (tmp < 0 || tmp > 1)
> +			return -EINVAL;
> +		ctrl[0] = 0x3A;
> +		if (tmp) {
> +			ctrl[1] = 0xCA;
> +			err = kxte9_i2c_write(te9, ctrl, 1);
> +			if (err < 0)
> +				return err;
> +		} else {
> +			ctrl[1] = 0x00;
> +			err = kxte9_i2c_write(te9, ctrl, 1);
> +			if (err < 0)
> +				return err;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct file_operations kxte9_misc_fops = {
> +	.owner = THIS_MODULE,
> +	.open = kxte9_misc_open,
> +	.ioctl = kxte9_misc_ioctl,
> +};
> +
> +static struct miscdevice kxte9_misc_device = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = NAME,
> +	.fops = &kxte9_misc_fops,
> +};
> +
> +static void kxte9_input_work_func(struct work_struct *work)
> +{
> +	struct kxte9_data *te9 = container_of((struct delayed_work *)work,
> +						struct kxte9_data, input_work);
> +	int xyz[3] = { 0 };
Why assigning?

> +	int err;
> +
> +	mutex_lock(&te9->lock);
> +	err = kxte9_get_acceleration_data(te9, xyz);
> +	if (err < 0)
> +		dev_err(&te9->client->dev, "get_acceleration_data failed\n");
> +	else
> +		kxte9_report_values(te9, xyz);
> +	schedule_delayed_work(&te9->input_work,
> +			      msecs_to_jiffies(te9->pdata->poll_interval));
> +	mutex_unlock(&te9->lock);
> +}
> +
> +#ifdef KXTE9_OPEN_ENABLE
> +int kxte9_input_open(struct input_dev *input)
> +{
> +	struct kxte9_data *te9 = input_get_drvdata(input);
> +
> +	return kxte9_enable(te9);
> +}
> +
> +void kxte9_input_close(struct input_dev *dev)
> +{
> +	struct kxte9_data *te9 = input_get_drvdata(dev);
> +
> +	kxte9_disable(te9);
> +}
> +#endif

Nice in a way, but would documentation not deal with this?
It is kind of accepted that if people introduce a bug in platform
data then it is their own fault.  Still, I guess it does no harm.  
> +
> +static int kxte9_validate_pdata(struct kxte9_data *te9)
> +{
> +	te9->pdata->poll_interval = max(te9->pdata->poll_interval,
> +					te9->pdata->min_interval);
> +	if (te9->pdata->axis_map_x > 2 ||
> +	    te9->pdata->axis_map_y > 2 || te9->pdata->axis_map_z > 2 ||
> +	    te9->pdata->axis_map_x = te9->pdata->axis_map_y ||
> +	    te9->pdata->axis_map_x = te9->pdata->axis_map_z ||
> +	    te9->pdata->axis_map_y = te9->pdata->axis_map_z) {
> +		dev_err(&te9->client->dev,
> +			"invalid axis_map value x:%u y:%u z:%u\n",
> +			te9->pdata->axis_map_x, te9->pdata->axis_map_y,
> +			te9->pdata->axis_map_z);
> +		return -EINVAL;
> +	}
> +	if (te9->pdata->negate_x > 1 || te9->pdata->negate_y > 1 ||
> +	    te9->pdata->negate_z > 1) {
> +		dev_err(&te9->client->dev,
> +			"invalid negate value x:%u y:%u z:%u\n",
> +			te9->pdata->negate_x, te9->pdata->negate_y,
> +			te9->pdata->negate_z);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int kxte9_input_init(struct kxte9_data *te9)
> +{
> +	int err;
> +
> +	INIT_DELAYED_WORK(&te9->input_work, kxte9_input_work_func);
> +	te9->input_dev = input_allocate_device();
> +	if (!te9->input_dev) {
> +		err = -ENOMEM;
> +		dev_err(&te9->client->dev, "input device allocate failed\n");
> +		goto err0;
> +	}
> +#ifdef KXTE9_OPEN_ENABLE
> +	te9->input_dev->open = kxte9_input_open;
> +	te9->input_dev->close = kxte9_input_close;
> +#endif
> +	input_set_drvdata(te9->input_dev, te9);
> +
> +	set_bit(EV_ABS, te9->input_dev->evbit);
> +	set_bit(ABS_MISC, te9->input_dev->absbit);
> +
> +	input_set_abs_params(te9->input_dev, ABS_X, -G_MAX, G_MAX, FUZZ, FLAT);
> +	input_set_abs_params(te9->input_dev, ABS_Y, -G_MAX, G_MAX, FUZZ, FLAT);
> +	input_set_abs_params(te9->input_dev, ABS_Z, -G_MAX, G_MAX, FUZZ, FLAT);

Might be worth checking whether something so generic is appropriate.
> +	te9->input_dev->name = "accelerometer";
> +
> +	err = input_register_device(te9->input_dev);
> +	if (err) {
> +		dev_err(&te9->client->dev,
> +			"unable to register input polled device %s\n",
> +			te9->input_dev->name);
> +		goto err1;
> +	}
> +
> +	return 0;
> +err1:
> +	input_free_device(te9->input_dev);
> +err0:
> +	return err;
> +}
> +
> +static void kxte9_input_cleanup(struct kxte9_data *te9)
> +{
> +	input_unregister_device(te9->input_dev);
> +	input_free_device(te9->input_dev);
> +}
> +
> +static int kxte9_probe(struct i2c_client *client,
> +			   const struct i2c_device_id *id)
> +{
> +	struct kxte9_data *te9;
> +	int err = -1;
> +
> +	if (client->dev.platform_data = NULL) {
> +		dev_err(&client->dev, "platform data is NULL. exiting.\n");
> +		err = -ENODEV;
> +		goto err0;
> +	}
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev, "client not i2c capable\n");
> +		err = -ENODEV;
> +		goto err0;
> +	}
> +	te9 = kzalloc(sizeof(*te9), GFP_KERNEL);
> +	if (te9 = NULL) {
> +		dev_err(&client->dev,
> +			"failed to allocate memory for module data\n");
> +		err = -ENOMEM;
> +		goto err0;
> +	}
> +
> +	mutex_init(&te9->lock);
> +	mutex_lock(&te9->lock);
> +	te9->client = client;
> +
> +	INIT_WORK(&te9->irq_work, kxte9_irq_work_func);
Why your own workqueue?  I'm not seeing anything timing critical enough
to justify not using the main kernel one.
> +	te9->irq_work_queue = create_singlethread_workqueue("kxte9_wq");
> +	if (!te9->irq_work_queue) {
> +		err = -ENOMEM;
> +		pr_err("%s: cannot create work queue: %d\n", __func__, err);
> +		goto err1;
> +	}
> +	te9->pdata = kmalloc(sizeof(*te9->pdata), GFP_KERNEL);
> +	if (te9->pdata = NULL)
> +		goto err2;
> +	memcpy(te9->pdata, client->dev.platform_data, sizeof(*te9->pdata));
> +	err = kxte9_validate_pdata(te9);
> +	if (err < 0) {
> +		dev_err(&client->dev, "failed to validate platform data\n");
> +		goto err3;
> +	}
> +	i2c_set_clientdata(client, te9);
> +	if (te9->pdata->init) {
> +		err = te9->pdata->init();
> +		if (err < 0)
> +			goto err3;
> +	}
> +
> +	te9->irq = gpio_to_irq(te9->pdata->gpio);

How many array elements are left? Other option would be an intial use of
kzalloc instead of kmalloc. 
> +	memset(te9->resume_state, 0, ARRAY_SIZE(te9->resume_state));
> +	te9->resume_state[RES_CTRL_REG1]    = te9->pdata->ctrl_reg1_init;
> +	te9->resume_state[RES_CTRL_REG3]    = te9->pdata->engine_odr_init;
> +	te9->resume_state[RES_INT_CTRL1]    = te9->pdata->int_ctrl_init;
> +	te9->resume_state[RES_TILT_TIMER]   = te9->pdata->tilt_timer_init;
> +	te9->resume_state[RES_WUF_TIMER]    = te9->pdata->wuf_timer_init;
> +	te9->resume_state[RES_B2S_TIMER]    = te9->pdata->b2s_timer_init;
> +	te9->resume_state[RES_WUF_THRESH]   = te9->pdata->wuf_thresh_init;
> +	te9->resume_state[RES_B2S_THRESH]   = te9->pdata->b2s_thresh_init;
This one really is pointless.
> +	te9->resume_state[RES_CURRENT_ODR]  = 0;
> +
> +	err = kxte9_device_power_on(te9);
> +	if (err < 0)
> +		goto err4;
> +	atomic_set(&te9->enabled, 1);
> +	err = kxte9_update_odr(te9, te9->pdata->poll_interval);
> +	if (err < 0) {
> +		dev_err(&client->dev, "update_odr failed\n");
> +		goto err5;
> +	}
> +	err = kxte9_input_init(te9);
> +	if (err < 0)
> +		goto err5;

Not the right way to handle this, see other drivers with similar problem (pretty
much anything with a chrdev)
> +	kxte9_misc_data = te9;
> +	err = misc_register(&kxte9_misc_device);
> +	if (err < 0) {
> +		dev_err(&client->dev, "te9_device register failed\n");
> +		goto err6;
> +	}
> +	kxte9_device_power_off(te9);
> +	atomic_set(&te9->enabled, 0);
> +	err = request_irq(te9->irq, kxte9_isr,
> +			  IRQF_TRIGGER_RISING,
> +			  "kxte9_irq", te9);
> +	if (err < 0) {
> +		pr_err("%s: request irq failed: %d\n", __func__, err);
> +		goto err7;
> +	}
Request it disabled in the first place (IRQF_DISABLED).
Could in theory get an interrupt before here.
> +	disable_irq_nosync(te9->irq);
> +
> +	mutex_unlock(&te9->lock);
> +
> +	dev_info(&client->dev, "kxte9 probed\n");
> +	/*** DEBUG ENABLE - REMOVE ***/
> +	if (kxte9_enable(te9) != 0)
> +		dev_err(&client->dev, "kxte9 enable error\n");
> +	/*** <end> DEBUG ENABLE - REMOVE ***/
> +
> +	return 0;
> +
> +err7:
> +	misc_deregister(&kxte9_misc_device);
> +err6:
> +	kxte9_input_cleanup(te9);
> +err5:
> +	kxte9_device_power_off(te9);
> +err4:
> +	if (te9->pdata->exit)
> +		te9->pdata->exit();
> +err3:
> +	kfree(te9->pdata);
> +err2:
> +	destroy_workqueue(te9->irq_work_queue);
> +err1:
> +	mutex_unlock(&te9->lock);
> +	kfree(te9);
> +err0:
> +	return err;
> +}
> +
> +static int __devexit kxte9_remove(struct i2c_client *client)
> +{
> +	struct kxte9_data *te9 = i2c_get_clientdata(client);
> +
> +	free_irq(te9->irq, te9);
> +	gpio_free(te9->pdata->gpio);
> +	misc_deregister(&kxte9_misc_device);
> +	kxte9_input_cleanup(te9);
> +	kxte9_device_power_off(te9);
> +	if (te9->pdata->exit)
> +		te9->pdata->exit();
> +	kfree(te9->pdata);
> +	destroy_workqueue(te9->irq_work_queue);
> +	kfree(te9);
> +
> +	return 0;
> +}
> +
> +static int kxte9_resume(struct i2c_client *client)
> +{
> +	struct kxte9_data *te9 = i2c_get_clientdata(client);
> +
> +	return kxte9_enable(te9);
> +}
> +
> +static int kxte9_suspend(struct i2c_client *client, pm_message_t mesg)
> +{
> +	struct kxte9_data *te9 = i2c_get_clientdata(client);
> +
> +	return kxte9_disable(te9);
> +}
> +
> +static const struct i2c_device_id kxte9_id[] = {
> +	{NAME, 0},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, kxte9_id);
> +
> +static struct i2c_driver kxte9_driver = {
> +	.driver = {
> +		   .name = NAME,
> +		   },
> +	.probe = kxte9_probe,
> +	.remove = __devexit_p(kxte9_remove),
> +	.resume = kxte9_resume,
> +	.suspend = kxte9_suspend,
> +	.id_table = kxte9_id,
> +};
> +
> +static int __init kxte9_init(void)
> +{
pr_info has already added a KERN_INFO to the resulting printk.
> +	pr_info(KERN_INFO "kxte9 accelerometer driver\n");
> +	return i2c_add_driver(&kxte9_driver);
> +}
> +
> +static void __exit kxte9_exit(void)
> +{
> +	i2c_del_driver(&kxte9_driver);
> +	return;
> +}
> +
> +module_init(kxte9_init);
> +module_exit(kxte9_exit);
> +
> +MODULE_DESCRIPTION("KXTE9 accelerometer driver");
> +MODULE_AUTHOR("Kionix, Inc.");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/kxte9.h b/include/linux/kxte9.h
> new file mode 100644
> index 0000000..5337202
> --- /dev/null
> +++ b/include/linux/kxte9.h
> @@ -0,0 +1,95 @@
> +/*
> + * Copyright (c) 2009, Kionix, Inc. All Rights Reserved.
> + * Written by Chris Hudson <chudson@kionix.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 3 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include <linux/ioctl.h>  /* For IOCTL macros */
> +
> +#ifndef __KXTE9_H__
> +#define __KXTE9_H__
> +
> +#define KXTE9_IOCTL_BASE 77
> +/** The following define the IOCTL command values via the ioctl macros */
> +#define KXTE9_IOCTL_SET_DELAY		_IOW(KXTE9_IOCTL_BASE, 0, int)
> +#define KXTE9_IOCTL_GET_DELAY		_IOR(KXTE9_IOCTL_BASE, 1, int)
> +#define KXTE9_IOCTL_SET_ENABLE		_IOW(KXTE9_IOCTL_BASE, 2, int)
> +#define KXTE9_IOCTL_GET_ENABLE		_IOR(KXTE9_IOCTL_BASE, 3, int)
> +#define KXTE9_IOCTL_SET_TILT_ENABLE	_IOW(KXTE9_IOCTL_BASE, 5, int)
> +#define KXTE9_IOCTL_SET_B2S_ENABLE	_IOW(KXTE9_IOCTL_BASE, 6, int)
> +#define KXTE9_IOCTL_SET_WAKE_ENABLE	_IOW(KXTE9_IOCTL_BASE, 7, int)
> +#define KXTE9_IOCTL_SELF_TEST		_IOW(KXTE9_IOCTL_BASE, 8, int)
> +
> +#define KXTE9_I2C_ADDR		0x0F
> +/* CONTROL REGISTER 1 BITS */
> +#define TPE			0x01	/* tilt position function enable bit */
> +#define WUFE			0x02	/* wake-up function enable bit */
> +#define B2SE			0x04	/* back-to-sleep function enable bit */
> +#define ODR125			0x20	/* 125Hz ODR mode */
> +#define ODR40			0x18	/* initial ODR masks */
> +#define ODR10			0x10
> +#define ODR3			0x08
> +#define ODR1			0x00
> +/* CONTROL REGISTER 3 BITS */
> +#define OB2S40			0x0C	/* back-to-sleep ODR masks */
> +#define OB2S10			0x08
> +#define OB2S3			0x04
> +#define OB2S1			0x00
> +#define OWUF40			0x03	/* wake-up ODR masks */
> +#define OWUF10			0x02
> +#define OWUF3			0x01
> +#define OWUF1			0x00
> +/* INTERRUPT CONTROL REGISTER 1 BITS */
> +#define KXTE9_IEN		0x10	/* interrupt enable */
> +#define KXTE9_IEA		0x08	/* interrupt polarity */
> +#define KXTE9_IEL		0x04	/* interrupt response */
> +
> +
> +#ifdef __KERNEL__

Really needs documentation. Quit a log of these are effectively boolean
so use bit fields and group them to save memory.
> +struct kxte9_platform_data {
> +	int poll_interval;
> +	int min_interval;
> +
> +	u8 g_range;
> +
> +	u8 axis_map_x;
> +	u8 axis_map_y;
> +	u8 axis_map_z;
> +
> +	u8 negate_x;
> +	u8 negate_y;
> +	u8 negate_z;

This is pretty uggly.  I'm guessing a lot of these are hear to allow minor
tweaks of particular settings.  To set these at the moment requires the data
sheet.  If you distil out the controls that you actually want available and
use them as parameters it would be much cleaner.
> +	u8 ctrl_reg1_init;
> +	u8 engine_odr_init;
> +	u8 int_ctrl_init;
> +	u8 tilt_timer_init;
> +	u8 wuf_timer_init;
> +	u8 b2s_timer_init;
> +	u8 wuf_thresh_init;
> +	u8 b2s_thresh_init;
> +
> +	int (*init)(void);
> +	void (*exit)(void);
> +	int (*power_on)(void);
> +	int (*power_off)(void);
> +
> +	int gpio;
> +};
> +#endif /* __KERNEL__ */
> +
> +#endif  /* __KXTE9_H__ */
> +


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
