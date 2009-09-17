From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Sep 2009 13:34:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090917153450.57a75eae@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rodolfo,

On Fri, 11 Sep 2009 17:07:05 +0200, Rodolfo Giometti wrote:
> The file has been splitted up into two parts:

Spelling: split (it's an irregular verb.)

> 
> * drivers/mfd/w83627hf-core.c      - detects the chip and define proper
>                                      platform devices into mfd support
> 
> * drivers/hwmon/w83627hf.c         - implements the driver for hwmon
>                                      functionality only
> 
> The patch also fixes up some non reentrant code and some C-style issues.

Sounds wrong. Mixing coding style cleanups with real changes makes
reviewing much harder. You'll have to move these changes to a separate
patch I'm afraid.

> 
> Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> ---
>  drivers/hwmon/w83627hf.c     |  373 +++++++++---------------------------------
>  drivers/mfd/Kconfig          |   14 ++
>  drivers/mfd/Makefile         |    1 +
>  drivers/mfd/w83627hf-core.c  |  251 ++++++++++++++++++++++++++++
>  include/linux/mfd/w83627hf.h |   68 ++++++++
>  5 files changed, 409 insertions(+), 298 deletions(-)
>  create mode 100644 drivers/mfd/w83627hf-core.c
>  create mode 100644 include/linux/mfd/w83627hf.h

Review:

> 
> diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
> index 389150b..25f35ac 100644
> --- a/drivers/hwmon/w83627hf.c
> +++ b/drivers/hwmon/w83627hf.c
> @@ -1,6 +1,6 @@
>  /*
>      w83627hf.c - Part of lm_sensors, Linux kernel modules for hardware
> -                monitoring
> +		 monitoring

This kind of clean up is better done in a separate patch.

>      Copyright (c) 1998 - 2003  Frodo Looijaard <frodol@dds.nl>,
>      Philip Edelbrock <phil@netroedge.com>,
>      and Mark Studebaker <mdsxyz123@yahoo.com>
> @@ -51,13 +51,9 @@
>  #include <linux/mutex.h>
>  #include <linux/ioport.h>
>  #include <linux/acpi.h>
> -#include <asm/io.h>
> +#include <linux/io.h>

This is already fixed in my hwmon tree.

>  #include "lm75.h"
> -
> -static struct platform_device *pdev;
> -
> -#define DRVNAME "w83627hf"
> -enum chips { w83627hf, w83627thf, w83697hf, w83637hf, w83687thf };
> +#include <linux/mfd/w83627hf.h>
>  
>  static u16 force_addr;
>  module_param(force_addr, ushort, 0);
> @@ -76,88 +72,8 @@ static unsigned short force_id;
>  module_param(force_id, ushort, 0);
>  MODULE_PARM_DESC(force_id, "Override the detected device ID");

You have left module parameters force_addr and force_id in this driver
while they are no longer used anywhere. This is confusing.

>  
> -/* modified from kernel/include/traps.c */
> -static int REG;		/* The register to read/write */
> -#define	DEV	0x07	/* Register: Logical device select */
> -static int VAL;		/* The value to read/write */
> -
> -/* logical device numbers for superio_select (below) */
> -#define W83627HF_LD_FDC		0x00
> -#define W83627HF_LD_PRT		0x01
> -#define W83627HF_LD_UART1	0x02
> -#define W83627HF_LD_UART2	0x03
> -#define W83627HF_LD_KBC		0x05
> -#define W83627HF_LD_CIR		0x06 /* w83627hf only */
> -#define W83627HF_LD_GAME	0x07
> -#define W83627HF_LD_MIDI	0x07
> -#define W83627HF_LD_GPIO1	0x07
> -#define W83627HF_LD_GPIO5	0x07 /* w83627thf only */
> -#define W83627HF_LD_GPIO2	0x08
> -#define W83627HF_LD_GPIO3	0x09
> -#define W83627HF_LD_GPIO4	0x09 /* w83627thf only */
> -#define W83627HF_LD_ACPI	0x0a
> -#define W83627HF_LD_HWM		0x0b
> -
> -#define	DEVID	0x20	/* Register: Device ID */
> -
> -#define W83627THF_GPIO5_EN	0x30 /* w83627thf only */
> -#define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
> -#define W83627THF_GPIO5_DR	0xf4 /* w83627thf only */
> -
> -#define W83687THF_VID_EN	0x29 /* w83687thf only */
> -#define W83687THF_VID_CFG	0xF0 /* w83687thf only */
> -#define W83687THF_VID_DATA	0xF1 /* w83687thf only */
> -
> -static inline void
> -superio_outb(int reg, int val)
> -{
> -	outb(reg, REG);
> -	outb(val, VAL);
> -}
> -
> -static inline int
> -superio_inb(int reg)
> -{
> -	outb(reg, REG);
> -	return inb(VAL);
> -}
> -
> -static inline void
> -superio_select(int ld)
> -{
> -	outb(DEV, REG);
> -	outb(ld, VAL);
> -}
> -
> -static inline void
> -superio_enter(void)
> -{
> -	outb(0x87, REG);
> -	outb(0x87, REG);
> -}
> -
> -static inline void
> -superio_exit(void)
> -{
> -	outb(0xAA, REG);
> -}
> -
> -#define W627_DEVID 0x52
> -#define W627THF_DEVID 0x82
> -#define W697_DEVID 0x60
> -#define W637_DEVID 0x70
> -#define W687THF_DEVID 0x85
> -#define WINB_ACT_REG 0x30
> -#define WINB_BASE_REG 0x60
>  /* Constants specified below */
>  
> -/* Alignment of the base address */
> -#define WINB_ALIGNMENT		~7
> -
> -/* Offset & size of I/O region we are interested in */
> -#define WINB_REGION_OFFSET	5
> -#define WINB_REGION_SIZE	2
> -
>  /* Where are the sensors address/data registers relative to the region offset */
>  #define W83781D_ADDR_REG_OFFSET 0
>  #define W83781D_DATA_REG_OFFSET 1
> @@ -221,7 +137,7 @@ static const u8 W83627THF_PWM_ENABLE_SHIFT[] = { 2, 4, 1 };
>  
>  static const u8 regpwm_627hf[] = { W83627HF_REG_PWM1, W83627HF_REG_PWM2 };
>  static const u8 regpwm[] = { W83627THF_REG_PWM1, W83627THF_REG_PWM2,
> -                             W83627THF_REG_PWM3 };
> +				W83627THF_REG_PWM3 };
>  #define W836X7HF_REG_PWM(type, nr) (((type) = w83627hf) ? \
>  				    regpwm_627hf[nr] : regpwm[nr])
>  
> @@ -251,7 +167,7 @@ static const u8 BIT_SCFG2[] = { 0x10, 0x20, 0x40 };
>     variants. Note that you should be a bit careful with which arguments
>     these macros are called: arguments may be evaluated more than once.
>     Fixing this is just not worth it. */
> -#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) + 8)/16),0,255))
> +#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) + 8)/16), 0, 255))
>  #define IN_FROM_REG(val) ((val) * 16)
>  
>  static inline u8 FAN_TO_REG(long rpm, int div)
> @@ -264,25 +180,26 @@ static inline u8 FAN_TO_REG(long rpm, int div)
>  }
>  
>  #define TEMP_MIN (-128000)
> -#define TEMP_MAX ( 127000)
> +#define TEMP_MAX (127000)
>  
>  /* TEMP: 0.001C/bit (-128C to +127C)
>     REG: 1C/bit, two's complement */
>  static u8 TEMP_TO_REG(long temp)
>  {
> -        int ntemp = SENSORS_LIMIT(temp, TEMP_MIN, TEMP_MAX);
> -        ntemp += (ntemp<0 ? -500 : 500);
> -        return (u8)(ntemp / 1000);
> +	int ntemp = SENSORS_LIMIT(temp, TEMP_MIN, TEMP_MAX);
> +	ntemp += (ntemp < 0 ? -500 : 500);
> +	return (u8)(ntemp / 1000);
>  }
>  
>  static int TEMP_FROM_REG(u8 reg)
>  {
> -        return (s8)reg * 1000;
> +	return (s8)reg * 1000;
>  }
>  
> -#define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=255?0:1350000/((val)*(div)))
> +#define FAN_FROM_REG(val, div)	\
> +		((val) = 0 ? -1 : (val) = 255 ? 0 : 1350000 / ((val) * (div)))
>  
> -#define PWM_TO_REG(val) (SENSORS_LIMIT((val),0,255))
> +#define PWM_TO_REG(val) (SENSORS_LIMIT((val), 0, 255))
>  
>  static inline unsigned long pwm_freq_from_reg_627hf(u8 reg)
>  {
> @@ -312,7 +229,7 @@ static inline unsigned long pwm_freq_from_reg(u8 reg)
>  	/* This should not happen but anyway... */
>  	if (reg = 0)
>  		reg++;
> -	return (clock / (reg << 8));
> +	return clock / (reg << 8);
>  }
>  static inline u8 pwm_freq_to_reg(unsigned long val)
>  {
> @@ -320,11 +237,11 @@ static inline u8 pwm_freq_to_reg(unsigned long val)
>  	if (val >= 93750)	/* The highest we can do */
>  		return 0x01;
>  	if (val >= 720)	/* Use 24 MHz clock */
> -		return (24000000UL / (val << 8));
> +		return 24000000UL / (val << 8);
>  	if (val < 6)		/* The lowest we can do */
>  		return 0xFF;
>  	else			/* Use 180 kHz clock */
> -		return (0x80 | (180000UL / (val << 8)));
> +		return 0x80 | (180000UL / (val << 8));
>  }
>  
>  #define BEEP_MASK_FROM_REG(val)		((val) & 0xff7fff)
> @@ -341,7 +258,7 @@ static inline u8 DIV_TO_REG(long val)
>  			break;
>  		val >>= 1;
>  	}
> -	return ((u8) i);
> +	return (u8) i;
>  }
>  
>  /* For each registered chip, we need to keep some data in memory.
> @@ -380,10 +297,6 @@ struct w83627hf_data {
>  	u8 vrm_ovt;		/* Register value, 627THF/637HF/687THF only */
>  };
>  
> -struct w83627hf_sio_data {
> -	enum chips type;
> -};
> -
>  
>  static int w83627hf_probe(struct platform_device *pdev);
>  static int __devexit w83627hf_remove(struct platform_device *pdev);
> @@ -397,7 +310,7 @@ static void w83627hf_init_device(struct platform_device *pdev);
>  static struct platform_driver w83627hf_driver = {
>  	.driver = {
>  		.owner	= THIS_MODULE,
> -		.name	= DRVNAME,
> +		.name	= DRVNAME "_hwmon",
>  	},
>  	.probe		= w83627hf_probe,
>  	.remove		= __devexit_p(w83627hf_remove),
> @@ -484,28 +397,32 @@ static ssize_t show_in_0(struct w83627hf_data *data, char *buf, u8 reg)
>  		/* use VRM8 (standard) calculation */
>  		in0 = (long)IN_FROM_REG(reg);
>  
> -	return sprintf(buf,"%ld\n", in0);
> +	return sprintf(buf, "%ld\n", in0);
>  }
>  
> -static ssize_t show_regs_in_0(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_regs_in_0(struct device *dev,
> +				struct device_attribute *attr, char *buf)
>  {
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
>  	return show_in_0(data, buf, data->in[0]);
>  }
>  
> -static ssize_t show_regs_in_min0(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_regs_in_min0(struct device *dev,
> +				struct device_attribute *attr, char *buf)
>  {
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
>  	return show_in_0(data, buf, data->in_min[0]);
>  }
>  
> -static ssize_t show_regs_in_max0(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_regs_in_max0(struct device *dev,
> +				struct device_attribute *attr, char *buf)
>  {
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
>  	return show_in_0(data, buf, data->in_max[0]);
>  }
>  
> -static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *attr,
> +static ssize_t store_regs_in_min0(struct device *dev,
> +				struct device_attribute *attr,
>  	const char *buf, size_t count)
>  {
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
> @@ -514,7 +431,7 @@ static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *a
>  	val = simple_strtoul(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> -	
> +
>  	if ((data->vrm_ovt & 0x01) &&
>  		(w83627thf = data->type || w83637hf = data->type
>  		 || w83687thf = data->type))
> @@ -532,7 +449,8 @@ static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *a
>  	return count;
>  }
>  
> -static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *attr,
> +static ssize_t store_regs_in_max0(struct device *dev,
> +				struct device_attribute *attr,
>  	const char *buf, size_t count)
>  {
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
> @@ -545,7 +463,7 @@ static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *a
>  	if ((data->vrm_ovt & 0x01) &&
>  		(w83627thf = data->type || w83637hf = data->type
>  		 || w83687thf = data->type))
> -		
> +
>  		/* use VRM9 calculation */
>  		data->in_max[0] >  			SENSORS_LIMIT(((val * 100) - 70000 + 244) / 488, 0,
> @@ -701,7 +619,8 @@ show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
>  	return sprintf(buf, "%ld\n", (long) data->vrm);
>  }
>  static ssize_t
> -store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
> +store_vrm_reg(struct device *dev, struct device_attribute *attr,
> +					const char *buf, size_t count)
>  {
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
>  	u32 val;
> @@ -897,14 +816,16 @@ store_fan_div(struct device *dev, struct device_attribute *devattr,
>  
>  	data->fan_div[nr] = DIV_TO_REG(val);
>  
> -	reg = (w83627hf_read_value(data, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
> -	       & (nr=0 ? 0xcf : 0x3f))
> -	    | ((data->fan_div[nr] & 0x03) << (nr=0 ? 4 : 6));
> -	w83627hf_write_value(data, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
> +	reg = (w83627hf_read_value(data,
> +		nr = 2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
> +		& (nr = 0 ? 0xcf : 0x3f))
> +		| ((data->fan_div[nr] & 0x03) << (nr = 0 ? 4 : 6));

You are turning a properly indented expression into an unreadable mess,
I don't call this a improvement. Please revert.

> +	w83627hf_write_value(data,
> +		nr = 2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
>  
>  	reg = (w83627hf_read_value(data, W83781D_REG_VBAT)
> -	       & ~(1 << (5 + nr)))
> -	    | ((data->fan_div[nr] & 0x04) << (3 + nr));
> +		& ~(1 << (5 + nr)))
> +		| ((data->fan_div[nr] & 0x04) << (3 + nr));

Same here, the original code was much easier to read.

>  	w83627hf_write_value(data, W83781D_REG_VBAT, reg);
>  
>  	/* Restore fan_min */
> @@ -1018,7 +939,7 @@ store_pwm_freq(struct device *dev, struct device_attribute *devattr,
>  {
>  	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
> -	static const u8 mask[]={0xF8, 0x8F};
> +	static const u8 mask[] = {0xF8, 0x8F};
>  	u32 val;
>  
>  	val = simple_strtoul(buf, NULL, 10);
> @@ -1126,80 +1047,6 @@ show_name(struct device *dev, struct device_attribute *devattr, char *buf)
>  }
>  static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
>  
> -static int __init w83627hf_find(int sioaddr, unsigned short *addr,
> -				struct w83627hf_sio_data *sio_data)
> -{
> -	int err = -ENODEV;
> -	u16 val;
> -
> -	static const __initdata char *names[] = {
> -		"W83627HF",
> -		"W83627THF",
> -		"W83697HF",
> -		"W83637HF",
> -		"W83687THF",
> -	};
> -
> -	REG = sioaddr;
> -	VAL = sioaddr + 1;
> -
> -	superio_enter();
> -	val = force_id ? force_id : superio_inb(DEVID);
> -	switch (val) {
> -	case W627_DEVID:
> -		sio_data->type = w83627hf;
> -		break;
> -	case W627THF_DEVID:
> -		sio_data->type = w83627thf;
> -		break;
> -	case W697_DEVID:
> -		sio_data->type = w83697hf;
> -		break;
> -	case W637_DEVID:
> -		sio_data->type = w83637hf;
> -		break;
> -	case W687THF_DEVID:
> -		sio_data->type = w83687thf;
> -		break;
> -	case 0xff:	/* No device at all */
> -		goto exit;
> -	default:
> -		pr_debug(DRVNAME ": Unsupported chip (DEVID=0x%02x)\n", val);
> -		goto exit;
> -	}
> -
> -	superio_select(W83627HF_LD_HWM);
> -	force_addr &= WINB_ALIGNMENT;
> -	if (force_addr) {
> -		printk(KERN_WARNING DRVNAME ": Forcing address 0x%x\n",
> -		       force_addr);
> -		superio_outb(WINB_BASE_REG, force_addr >> 8);
> -		superio_outb(WINB_BASE_REG + 1, force_addr & 0xff);
> -	}
> -	val = (superio_inb(WINB_BASE_REG) << 8) |
> -	       superio_inb(WINB_BASE_REG + 1);
> -	*addr = val & WINB_ALIGNMENT;
> -	if (*addr = 0) {
> -		printk(KERN_WARNING DRVNAME ": Base address not set, "
> -		       "skipping\n");
> -		goto exit;
> -	}
> -
> -	val = superio_inb(WINB_ACT_REG);
> -	if (!(val & 0x01)) {
> -		printk(KERN_WARNING DRVNAME ": Enabling HWM logical device\n");
> -		superio_outb(WINB_ACT_REG, val | 0x01);
> -	}
> -
> -	err = 0;
> -	pr_info(DRVNAME ": Found %s chip at %#x\n",
> -		names[sio_data->type], *addr);
> -
> - exit:
> -	superio_exit();
> -	return err;
> -}
> -
>  #define VIN_UNIT_ATTRS(_X_)	\
>  	&sensor_dev_attr_in##_X_##_input.dev_attr.attr,		\
>  	&sensor_dev_attr_in##_X_##_min.dev_attr.attr,		\
> @@ -1281,7 +1128,7 @@ static const struct attribute_group w83627hf_group_opt = {
>  static int __devinit w83627hf_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct w83627hf_sio_data *sio_data = dev->platform_data;
> +	struct w83627hf_sio_data *sio_data = dev->parent->platform_data;
>  	struct w83627hf_data *data;
>  	struct resource *res;
>  	int err, i;
> @@ -1435,15 +1282,15 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -      ERROR4:
> +ERROR4:
>  	sysfs_remove_group(&dev->kobj, &w83627hf_group);
>  	sysfs_remove_group(&dev->kobj, &w83627hf_group_opt);
> -      ERROR3:
> +ERROR3:
>  	platform_set_drvdata(pdev, NULL);
>  	kfree(data);
> -      ERROR1:
> +ERROR1:
>  	release_region(res->start, WINB_REGION_SIZE);
> -      ERROR0:
> +ERROR0:

Nack. Labels aligned on column 0 make future patches harder to read.

>  	return err;
>  }
>  
> @@ -1511,20 +1358,22 @@ static int w83627hf_read_value(struct w83627hf_data *data, u16 reg)
>  
>  static int __devinit w83627thf_read_gpio5(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
> +	struct w83627hf_sio_data *sio_data = dev->parent->platform_data;
>  	int res = 0xff, sel;
>  
> -	superio_enter();
> -	superio_select(W83627HF_LD_GPIO5);
> +	superio_enter(sio_data);
> +	superio_select(sio_data, W83627HF_LD_GPIO5);
>  
>  	/* Make sure these GPIO pins are enabled */
> -	if (!(superio_inb(W83627THF_GPIO5_EN) & (1<<3))) {
> +	if (!(superio_inb(sio_data, W83627THF_GPIO5_EN) & (1<<3))) {
>  		dev_dbg(&pdev->dev, "GPIO5 disabled, no VID function\n");
>  		goto exit;
>  	}
>  
>  	/* Make sure the pins are configured for input
>  	   There must be at least five (VRM 9), and possibly 6 (VRM 10) */
> -	sel = superio_inb(W83627THF_GPIO5_IOSR) & 0x3f;
> +	sel = superio_inb(sio_data, W83627THF_GPIO5_IOSR) & 0x3f;
>  	if ((sel & 0x1f) != 0x1f) {
>  		dev_dbg(&pdev->dev, "GPIO5 not configured for VID "
>  			"function\n");
> @@ -1532,37 +1381,39 @@ static int __devinit w83627thf_read_gpio5(struct platform_device *pdev)
>  	}
>  
>  	dev_info(&pdev->dev, "Reading VID from GPIO5\n");
> -	res = superio_inb(W83627THF_GPIO5_DR) & sel;
> +	res = superio_inb(sio_data, W83627THF_GPIO5_DR) & sel;
>  
>  exit:
> -	superio_exit();
> +	superio_exit(sio_data);
>  	return res;
>  }

This looks wrong. The whole point of the MFD infrastructure is to
control who is accessing the common registers. Here you let the hwmon
driver access the Super-I/O configuration registers without any kind of
synchronisation. What if another user of w83627hf-core does the same at
the same moment?

You need a way to protect common registers. You'll need a mutex, for
sure. Then you can either export this mutex and count on all "children"
drivers' cooperation to properly request and release it. Or you can
move all the code accessing the common registers into w83627hf-core,
and stop exporting the superio_* functions. I don't know if there is a
recommended practice for MFD drivers. Samuel?

>  
>  static int __devinit w83687thf_read_vid(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
> +	struct w83627hf_sio_data *sio_data = dev->parent->platform_data;
>  	int res = 0xff;
>  
> -	superio_enter();
> -	superio_select(W83627HF_LD_HWM);
> +	superio_enter(sio_data);
> +	superio_select(sio_data, W83627HF_LD_HWM);
>  
>  	/* Make sure these GPIO pins are enabled */
> -	if (!(superio_inb(W83687THF_VID_EN) & (1 << 2))) {
> +	if (!(superio_inb(sio_data, W83687THF_VID_EN) & (1 << 2))) {
>  		dev_dbg(&pdev->dev, "VID disabled, no VID function\n");
>  		goto exit;
>  	}
>  
>  	/* Make sure the pins are configured for input */
> -	if (!(superio_inb(W83687THF_VID_CFG) & (1 << 4))) {
> +	if (!(superio_inb(sio_data, W83687THF_VID_CFG) & (1 << 4))) {
>  		dev_dbg(&pdev->dev, "VID configured as output, "
>  			"no VID function\n");
>  		goto exit;
>  	}
>  
> -	res = superio_inb(W83687THF_VID_DATA) & 0x3f;
> +	res = superio_inb(sio_data, W83687THF_VID_DATA) & 0x3f;
>  
>  exit:
> -	superio_exit();
> +	superio_exit(sio_data);
>  	return res;
>  }

Same problem here. And with proper locking, we would finally be able to
refresh the VID reading at run-time, instead of a one-shot at
initialization time!

>  
> @@ -1616,7 +1467,7 @@ static void __devinit w83627hf_init_device(struct platform_device *pdev)
>  
>  	/* Read VRM & OVT Config only once */
>  	if (type = w83627thf || type = w83637hf || type = w83687thf) {
> -		data->vrm_ovt = 
> +		data->vrm_ovt >  			w83627hf_read_value(data, W83627THF_REG_VRM_OVT_CFG);
>  	}
>  
> @@ -1636,7 +1487,7 @@ static void __devinit w83627hf_init_device(struct platform_device *pdev)
>  			break;
>  	}
>  
> -	if(init) {
> +	if (init) {
>  		/* Enable temp2 */
>  		tmp = w83627hf_read_value(data, W83627HF_REG_TEMP2_CONFIG);
>  		if (tmp & 0x01) {
> @@ -1724,8 +1575,8 @@ static struct w83627hf_data *w83627hf_update_device(struct device *dev)
>  		for (i = 0; i <= 2; i++) {
>  			u8 tmp = w83627hf_read_value(data,
>  				W836X7HF_REG_PWM(data->type, i));
> - 			/* bits 0-3 are reserved  in 627THF */
> - 			if (data->type = w83627thf)
> +			/* bits 0-3 are reserved  in 627THF */

While you're here: double space before "in".

> +			if (data->type = w83627thf)
>  				tmp &= 0xf0;
>  			data->pwm[i] = tmp;
>  			if (i = 1 &&
> @@ -1756,12 +1607,12 @@ static struct w83627hf_data *w83627hf_update_device(struct device *dev)
>  			}
>  		}
>  		for (i = 0; i < num_temps; i++) {
> -			data->temp[i] = w83627hf_read_value(
> -						data, w83627hf_reg_temp[i]);
> -			data->temp_max[i] = w83627hf_read_value(
> -						data, w83627hf_reg_temp_over[i]);
> -			data->temp_max_hyst[i] = w83627hf_read_value(
> -						data, w83627hf_reg_temp_hyst[i]);
> +			data->temp[i] = w83627hf_read_value(data,
> +						w83627hf_reg_temp[i]);
> +			data->temp_max[i] = w83627hf_read_value(data,
> +						w83627hf_reg_temp_over[i]);
> +			data->temp_max_hyst[i] = w83627hf_read_value(data,
> +						w83627hf_reg_temp_hyst[i]);
>  		}
>  
>  		w83627hf_update_fan_div(data);
> @@ -1783,94 +1634,20 @@ static struct w83627hf_data *w83627hf_update_device(struct device *dev)
>  	return data;
>  }
>  
> -static int __init w83627hf_device_add(unsigned short address,
> -				      const struct w83627hf_sio_data *sio_data)
> -{
> -	struct resource res = {
> -		.start	= address + WINB_REGION_OFFSET,
> -		.end	= address + WINB_REGION_OFFSET + WINB_REGION_SIZE - 1,
> -		.name	= DRVNAME,
> -		.flags	= IORESOURCE_IO,
> -	};
> -	int err;
> -
> -	err = acpi_check_resource_conflict(&res);
> -	if (err)
> -		goto exit;
> -
> -	pdev = platform_device_alloc(DRVNAME, address);
> -	if (!pdev) {
> -		err = -ENOMEM;
> -		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> -		goto exit;
> -	}
> -
> -	err = platform_device_add_resources(pdev, &res, 1);
> -	if (err) {
> -		printk(KERN_ERR DRVNAME ": Device resource addition failed "
> -		       "(%d)\n", err);
> -		goto exit_device_put;
> -	}
> -
> -	err = platform_device_add_data(pdev, sio_data,
> -				       sizeof(struct w83627hf_sio_data));
> -	if (err) {
> -		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
> -		goto exit_device_put;
> -	}
> -
> -	err = platform_device_add(pdev);
> -	if (err) {
> -		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
> -		       err);
> -		goto exit_device_put;
> -	}
> -
> -	return 0;
> -
> -exit_device_put:
> -	platform_device_put(pdev);
> -exit:
> -	return err;
> -}
> -
>  static int __init sensors_w83627hf_init(void)
>  {
> -	int err;
> -	unsigned short address;
> -	struct w83627hf_sio_data sio_data;
> -
> -	if (w83627hf_find(0x2e, &address, &sio_data)
> -	 && w83627hf_find(0x4e, &address, &sio_data))
> -		return -ENODEV;
> -
> -	err = platform_driver_register(&w83627hf_driver);
> -	if (err)
> -		goto exit;
> -
> -	/* Sets global pdev as a side effect */
> -	err = w83627hf_device_add(address, &sio_data);
> -	if (err)
> -		goto exit_driver;
> -
> -	return 0;
> -
> -exit_driver:
> -	platform_driver_unregister(&w83627hf_driver);
> -exit:
> -	return err;
> +	return platform_driver_register(&w83627hf_driver);
>  }
>  
>  static void __exit sensors_w83627hf_exit(void)
>  {
> -	platform_device_unregister(pdev);
>  	platform_driver_unregister(&w83627hf_driver);
>  }
>  
>  MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
>  	      "Philip Edelbrock <phil@netroedge.com>, "
>  	      "and Mark Studebaker <mdsxyz123@yahoo.com>");
> -MODULE_DESCRIPTION("W83627HF driver");
> +MODULE_DESCRIPTION("W83627HF hwmon driver");
>  MODULE_LICENSE("GPL");
>  
>  module_init(sensors_w83627hf_init);
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 491ac0f..b52d957 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -263,6 +263,20 @@ config EZX_PCAP
>  	  This enables the PCAP ASIC present on EZX Phones. This is
>  	  needed for MMC, TouchScreen, Sound, USB, etc..
>  
> +config MFD_W83627HF
> +	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
> +	help
> +	  If you say yes here you add support for the Winbond W836X7 series
> +	  of sensor chips: the W83627HF, W83627THF, W83637HF, W83687THF and

Super-I/O chips, not sensor chips.

> +	  W83697HF to your platform.
> +
> +	  This is a multi functional device and this support defines a new
> +	  platform device only. See other configurations submenu in order to

Spelling: configuration submenus?

> +	  enable the drivers of Winbond chip's functionalities.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called w83627hf-core.
> +

Shouldn't this option be selected automatically by the w83627hf (hwmon)
driver? Currently it is possible to select only the hwmon driver, but
that driver will never work because the required platform driver won't
be created. This is a problem for current users upgrading to a new
kernel, as CONFIG_MFD_W83627HF defaults to N.

But then again I don't know if there is already a policy regarding this
for MFD drivers. Samuel?

>  endmenu
>  
>  menu "Multimedia Capabilities Port drivers"
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 6f8a9a1..1401ac9 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o twl4030-irq.o
>  obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
>  
>  obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
> +obj-$(CONFIG_MFD_W83627HF)	+= w83627hf-core.o
>  
>  obj-$(CONFIG_MCP)		+= mcp-core.o
>  obj-$(CONFIG_MCP_SA11X0)	+= mcp-sa11x0.o
> diff --git a/drivers/mfd/w83627hf-core.c b/drivers/mfd/w83627hf-core.c
> new file mode 100644
> index 0000000..522add7
> --- /dev/null
> +++ b/drivers/mfd/w83627hf-core.c
> @@ -0,0 +1,251 @@
> +/*
> + *  w83627hf.c - platform device support
> + *  Copyright (c) 2009 Rodolfo Giometti <giometti@linux.it>
> + *
> + *  Based on drivers/hwmon/w83627hf.c
> + *
> + *  Original copyright note:
> + *    Copyright (c) 1998 - 2003  Frodo Looijaard <frodol@dds.nl>,
> + *    Philip Edelbrock <phil@netroedge.com>,
> + *    and Mark Studebaker <mdsxyz123@yahoo.com>
> + *    Ported to 2.6 by Bernhard C. Schrenk <clemy@clemy.org>
> + *    Copyright (c) 2007  Jean Delvare <khali@linux-fr.org>
> + *
> + *    This program is free software; you can redistribute it and/or modify
> + *    it under the terms of the GNU General Public License as published by
> + *    the Free Software Foundation; either version 2 of the License, or
> + *    (at your option) any later version.
> + *
> + *    This program is distributed in the hope that it will be useful,
> + *    but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *    GNU General Public License for more details.
> + *
> + *    You should have received a copy of the GNU General Public License
> + *    along with this program; if not, write to the Free Software
> + *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/ioport.h>
> +#include <linux/acpi.h>
> +#include <linux/io.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/w83627hf.h>
> +
> +static u16 force_addr;
> +module_param(force_addr, ushort, 0);
> +MODULE_PARM_DESC(force_addr,
> +		 "Initialize the base address of the sensors");

This needs to be renamed. The address in question is specific to the
hwmon part.

> +static u8 force_i2c = 0x1f;
> +module_param(force_i2c, byte, 0);
> +MODULE_PARM_DESC(force_i2c,
> +		 "Initialize the i2c address of the sensors");

Not used anywhere.

> +
> +static int init = 1;
> +module_param(init, bool, 0);
> +MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");

Ditto.

> +
> +static unsigned short force_id;
> +module_param(force_id, ushort, 0);
> +MODULE_PARM_DESC(force_id, "Override the detected device ID");

Note: I am curious how this will fly in practice. Originally this
option was meant to force on of the 5 available hardware monitoring
implementations. It didn't assume much about the other functions of the
chips. Now that the option moved to the core MFD w83627hf driver, it
would affect all "children" drivers, not only the hwmon one. This might
not be fine-grained enough.

> +
> +/*
> + * Devices definitions
> + */
> +
> +static struct platform_device *pdev;
> +
> +static struct resource hwmon_res = {
> +	.start  = /* address + */ WINB_REGION_OFFSET,
> +	.end    = /* address + */ WINB_REGION_OFFSET + WINB_REGION_SIZE - 1,
> +	.name   = DRVNAME "_hwmon",
> +	.flags  = IORESOURCE_IO,
> +};
> +
> +static struct mfd_cell cells[] = {
> +	{
> +		.name	   = DRVNAME "_hwmon",
> +		.num_resources  = 1,
> +		.resources      = &hwmon_res,
> +	},
> +};
> +
> +/*
> + * Local functions
> + */
> +
> +#define W627_DEVID 0x52
> +#define W627THF_DEVID 0x82
> +#define W697_DEVID 0x60
> +#define W637_DEVID 0x70
> +#define W687THF_DEVID 0x85
> +#define WINB_ACT_REG 0x30
> +#define WINB_BASE_REG 0x60
> +/* Constants specified below */
> +
> +/* Alignment of the base address */
> +#define WINB_ALIGNMENT		(~7)
> +
> +/* Offset & size of I/O region we are interested in */
> +#define WINB_REGION_OFFSET	5
> +#define WINB_REGION_SIZE	2
> +
> +static int __init w83627hf_find(int sioaddr, unsigned short *addr,
> +				struct w83627hf_sio_data *sio_data)
> +{
> +	int err = -ENODEV;
> +	u16 val;
> +
> +	static const __initdata char *names[] = {
> +		"W83627HF",
> +		"W83627THF",
> +		"W83697HF",
> +		"W83637HF",
> +		"W83687THF",
> +	};
> +
> +	sio_data->sioaddr = sioaddr;
> +
> +	superio_enter(sio_data);
> +	val = force_id ? force_id : superio_inb(sio_data, DEVID);
> +	switch (val) {
> +	case W627_DEVID:
> +		sio_data->type = w83627hf;
> +		break;
> +	case W627THF_DEVID:
> +		sio_data->type = w83627thf;
> +		break;
> +	case W697_DEVID:
> +		sio_data->type = w83697hf;
> +		break;
> +	case W637_DEVID:
> +		sio_data->type = w83637hf;
> +		break;
> +	case W687THF_DEVID:
> +		sio_data->type = w83687thf;
> +		break;
> +	case 0xff:	/* No device at all */
> +		goto exit;
> +	default:
> +		pr_debug(DRVNAME ": Unsupported chip (DEVID=0x%02x)\n", val);
> +		goto exit;
> +	}
> +
> +	superio_select(sio_data, W83627HF_LD_HWM);
> +	force_addr &= WINB_ALIGNMENT;
> +	if (force_addr) {
> +		printk(KERN_WARNING DRVNAME ": Forcing address 0x%x\n",
> +		       force_addr);
> +		superio_outb(sio_data, WINB_BASE_REG, force_addr >> 8);
> +		superio_outb(sio_data, WINB_BASE_REG + 1, force_addr & 0xff);
> +	}
> +	val = (superio_inb(sio_data, WINB_BASE_REG) << 8) |
> +	       superio_inb(sio_data, WINB_BASE_REG + 1);
> +	*addr = val & WINB_ALIGNMENT;
> +	if (*addr = 0) {
> +		printk(KERN_WARNING DRVNAME ": Base address not set, "
> +		       "skipping\n");
> +		goto exit;
> +	}
> +
> +	val = superio_inb(sio_data, WINB_ACT_REG);
> +	if (!(val & 0x01)) {
> +		printk(KERN_WARNING DRVNAME ": Enabling HWM logical device\n");
> +		superio_outb(sio_data, WINB_ACT_REG, val | 0x01);
> +	}
> +
> +	err = 0;
> +	pr_info(DRVNAME ": Found %s chip at %#x\n",
> +		names[sio_data->type], *addr);
> +
> + exit:
> +	superio_exit(sio_data);
> +	return err;
> +}
> +
> +static int __init w83627hf_device_add(unsigned short address,
> +				      const struct w83627hf_sio_data *sio_data)
> +{
> +	struct resource res = {
> +		.start	= address + WINB_REGION_OFFSET,
> +		.end	= address + WINB_REGION_OFFSET + WINB_REGION_SIZE - 1,
> +		.name	= DRVNAME,
> +		.flags	= IORESOURCE_IO,
> +	};
> +	int err;
> +
> +	hwmon_res.start += address;
> +	hwmon_res.end += address;

This is bad. The second time you enter this function, you add address
again and get totally wrong values. Why don't you just _set_ start and
end, instead of altering a pre-set value?

Anyway I don't get the point of the global hwmon_res resource, as you
have a local one (res). One should be enough, and less error-prone.

> +
> +	err = acpi_check_resource_conflict(&res);
> +	if (err)
> +		goto exit;

This should prevent the hwmon platform device from being registered,
_not_ the main MFD device.

> +
> +	pdev = platform_device_alloc(DRVNAME, address);
> +	if (!pdev) {
> +		err = -ENOMEM;
> +		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> +		goto exit;
> +	}
> +
> +	err = platform_device_add_data(pdev, sio_data,
> +				       sizeof(struct w83627hf_sio_data));
> +	if (err) {
> +		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
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
> +	err = mfd_add_devices(&pdev->dev, pdev->id, cells, ARRAY_SIZE(cells),
> +			(struct resource *) (address & 0xffff), -1);
> +	if (err) {
> +		printk(KERN_ERR DRVNAME ": Cannot add sub devices (%d)\n",
> +			err);
> +		goto exit_device_unregister;
> +	}

You never delete these devices? This means that unloading and reloading
the driver will fail.

> +
> +	return 0;
> +
> +exit_device_unregister:
> +	platform_device_unregister(pdev);
> +exit_device_put:
> +	platform_device_put(pdev);
> +exit:
> +	return err;
> +}
> +
> +static int __init w83627hf_init(void)
> +{
> +	unsigned short address;
> +	struct w83627hf_sio_data sio_data;
> +
> +	if (w83627hf_find(0x2e, &address, &sio_data)
> +	 && w83627hf_find(0x4e, &address, &sio_data))
> +		return -ENODEV;
> +
> +	/* Sets global pdev as a side effect */
> +	return w83627hf_device_add(address, &sio_data);
> +}
> +
> +static void __exit w83627hf_exit(void)
> +{
> +	platform_device_unregister(pdev);
> +}
> +
> +MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
> +MODULE_DESCRIPTION("W83627HF platform devices definitions");
> +MODULE_LICENSE("GPL");
> +
> +module_init(w83627hf_init);
> +module_exit(w83627hf_exit);
> diff --git a/include/linux/mfd/w83627hf.h b/include/linux/mfd/w83627hf.h
> new file mode 100644
> index 0000000..c41dea1
> --- /dev/null
> +++ b/include/linux/mfd/w83627hf.h
> @@ -0,0 +1,68 @@

No header comment? No description of what this file is for? No author,
no copyright?

> +#define DRVNAME "w83627hf"
> +
> +/* Offset & size of I/O region we are interested in */
> +#define WINB_REGION_OFFSET      5
> +#define WINB_REGION_SIZE	2

You should come up with a more unique prefix, and better names
altogether: these defines are specific to the hwmon part of the chips!

> +
> +enum chips { w83627hf, w83627thf, w83697hf, w83637hf, w83687thf };
> +struct w83627hf_sio_data {
> +	int sioaddr;
> +	enum chips type;
> +};
> +
> +/* logical device numbers for superio_select (below) */
> +#define W83627HF_LD_FDC		0x00
> +#define W83627HF_LD_PRT		0x01
> +#define W83627HF_LD_UART1	0x02
> +#define W83627HF_LD_UART2	0x03
> +#define W83627HF_LD_KBC		0x05
> +#define W83627HF_LD_CIR		0x06 /* w83627hf only */
> +#define W83627HF_LD_GAME	0x07
> +#define W83627HF_LD_MIDI	0x07
> +#define W83627HF_LD_GPIO1	0x07
> +#define W83627HF_LD_GPIO5	0x07 /* w83627thf only */
> +#define W83627HF_LD_GPIO2	0x08
> +#define W83627HF_LD_GPIO3	0x09
> +#define W83627HF_LD_GPIO4	0x09 /* w83627thf only */
> +#define W83627HF_LD_ACPI	0x0a
> +#define W83627HF_LD_HWM		0x0b
> +
> +#define W83627THF_GPIO5_EN	0x30 /* w83627thf only */
> +#define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
> +#define W83627THF_GPIO5_DR	0xf4 /* w83627thf only */
> +
> +#define W83687THF_VID_EN	0x29 /* w83687thf only */
> +#define W83687THF_VID_CFG	0xF0 /* w83687thf only */
> +#define W83687THF_VID_DATA	0xF1 /* w83687thf only */
> +
> +#define DEV			0x07    /* Register: Logical device select */

You don't really need a define for this register number: it's used only
once, and isn't particularly interesting.

> +#define DEVID			0x20    /* Register: Device ID */

This is only used by the core mfd driver, so there's no need to have it
in this header file.

> +
> +static inline void superio_outb(struct w83627hf_sio_data *sio, int reg, int val)
> +{
> +	outb(reg, sio->sioaddr);
> +	outb(val, sio->sioaddr + 1);
> +}

You need to include <linux/io.h> to have access to outb() and inb().

> +
> +static inline int superio_inb(struct w83627hf_sio_data *sio, int reg)
> +{
> +	outb(reg, sio->sioaddr);
> +	return inb(sio->sioaddr + 1);
> +}
> +
> +static inline void superio_select(struct w83627hf_sio_data *sio, int ld)
> +{
> +	outb(DEV, sio->sioaddr);
> +	outb(ld, sio->sioaddr + 1);
> +}
> +
> +static inline void superio_enter(struct w83627hf_sio_data *sio)
> +{
> +	outb(0x87, sio->sioaddr);
> +	outb(0x87, sio->sioaddr);
> +}
> +
> +static inline void superio_exit(struct w83627hf_sio_data *sio)
> +{
> +	outb(0xAA, sio->sioaddr);
> +}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
