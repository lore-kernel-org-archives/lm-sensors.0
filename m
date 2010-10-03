From: Onkalo Samu <samu.p.onkalo@nokia.com>
Date: Sun, 03 Oct 2010 05:25:58 +0000
Subject: Re: [lm-sensors] [RFC PATCH 2/9] hwmon: lis3: regulator control
Message-Id: <1286083558.2064.35.camel@noppispoppis.nmp.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>
	 <1285933616-16044-3-git-send-email-samu.p.onkalo@nokia.com>
	 <4CA76CDA.4040803@cam.ac.uk>
In-Reply-To: <4CA76CDA.4040803-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: "eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org" <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org" <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On Sat, 2010-10-02 at 19:33 +0200, ext Jonathan Cameron wrote:
> On 10/01/10 12:46, Samu Onkalo wrote:
> > Based on pm_runtime control, turn lis3 regulators on and off.
> > Perform context save and restore on transitions.
> 
> As this is a simple save and restore state patch I'm happy to comment on it.
> 
> Mostly fine, though I have a couple of minor questions.
> > 
> > Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> > ---
> >  drivers/hwmon/lis3lv02d.c     |   48 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/hwmon/lis3lv02d.h     |   19 ++++++++++++++++
> >  drivers/hwmon/lis3lv02d_i2c.c |   43 +++++++++++++++++++++++++++++++++++-
> >  3 files changed, 109 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
> > index eaa5bf0..23d47ad 100644
> > --- a/drivers/hwmon/lis3lv02d.c
> > +++ b/drivers/hwmon/lis3lv02d.c
> > @@ -223,10 +223,46 @@ fail:
> >  	return ret;
> >  }
> >  
> > +/*
> > + * Order of registers in the list affects to order of the restore process.
> > + * Perhaps it is a good idea to set interrupt enable register as a last one
> > + * after all other configurations
> > + */
> > +static u8 lis3_wai8_regs[] = { FF_WU_CFG_1, FF_WU_THS_1, FF_WU_DURATION_1,
> > +			       FF_WU_CFG_2, FF_WU_THS_2, FF_WU_DURATION_2,
> > +			       CLICK_CFG, CLICK_SRC, CLICK_THSY_X, CLICK_THSZ,
> > +			       CLICK_TIMELIMIT, CLICK_LATENCY, CLICK_WINDOW,
> > +			       CTRL_REG1, CTRL_REG2, CTRL_REG3};
> > +
> > +static u8 lis3_wai12_regs[] = {FF_WU_CFG, FF_WU_THS_L, FF_WU_THS_H,
> > +			       FF_WU_DURATION, DD_CFG, DD_THSI_L, DD_THSI_H,
> > +			       DD_THSE_L, DD_THSE_H,
> > +			       CTRL_REG1, CTRL_REG3, CTRL_REG2};
> > +
> > +static inline void lis3_context_save(struct lis3lv02d *lis3)
> > +{
> > +	int i;
> > +	for (i = 0; i < lis3->regs_size; i++)
> > +		lis3->read(lis3, lis3->regs[i], &lis3->reg_cache[i]);
> > +	lis3->regs_stored = true;
> > +}
> > +
> > +static inline void lis3_context_restore(struct lis3lv02d *lis3)
> > +{
> > +	int i;
> > +	if (lis3->regs_stored)
> > +		for (i = 0; i < lis3->regs_size; i++)
> > +			lis3->write(lis3, lis3->regs[i], lis3->reg_cache[i]);
> > +}
> > +
> >  void lis3lv02d_poweroff(struct lis3lv02d *lis3)
> >  {
> > +	if (lis3->reg_ctrl)
> > +		lis3_context_save(lis3);
> >  	/* disable X,Y,Z axis and power down */
> >  	lis3->write(lis3, CTRL_REG1, 0x00);
> > +	if (lis3->reg_ctrl)
> > +		lis3->reg_ctrl(lis3, LIS3_REG_OFF);
> >  }
> >  EXPORT_SYMBOL_GPL(lis3lv02d_poweroff);
> >  
> > @@ -249,6 +285,8 @@ void lis3lv02d_poweron(struct lis3lv02d *lis3)
> >  		reg |= CTRL2_BDU;
> >  		lis3->write(lis3, CTRL_REG2, reg);
> >  	}
> > +	if (lis3->reg_ctrl)
> > +		lis3_context_restore(lis3);
> >  }
> >  EXPORT_SYMBOL_GPL(lis3lv02d_poweron);
> >  
> > @@ -718,6 +756,8 @@ int lis3lv02d_init_device(struct lis3lv02d *dev)
> >  		dev->odrs = lis3_12_rates;
> >  		dev->odr_mask = CTRL1_DF0 | CTRL1_DF1;
> >  		dev->scale = LIS3_SENSITIVITY_12B;
> > +		dev->regs = lis3_wai12_regs;
> > +		dev->regs_size = ARRAY_SIZE(lis3_wai12_regs);
> >  		break;
> >  	case WAI_8B:
> >  		printk(KERN_INFO DRIVER_NAME ": 8 bits sensor found\n");
> > @@ -727,6 +767,8 @@ int lis3lv02d_init_device(struct lis3lv02d *dev)
> >  		dev->odrs = lis3_8_rates;
> >  		dev->odr_mask = CTRL1_DR;
> >  		dev->scale = LIS3_SENSITIVITY_8B;
> > +		dev->regs = lis3_wai8_regs;
> > +		dev->regs_size = ARRAY_SIZE(lis3_wai8_regs);
> >  		break;
> >  	default:
> >  		printk(KERN_ERR DRIVER_NAME
> > @@ -734,6 +776,12 @@ int lis3lv02d_init_device(struct lis3lv02d *dev)
> >  		return -EINVAL;
> >  	}
> >  
> This is a little odd as runtime checks go.  Surely it can only occur in event
> of a clear driver bug?  Personally I'd just go with dynamically allocating
> the reg_cache to be the right size...

Makes sense.

> > +	if (dev->regs_size > LIS3_NUM_MAX_REG) {
> > +		printk(KERN_ERR DRIVER_NAME
> > +			": register cache area is too small");
> > +		return -EINVAL;
> > +	}
> > +
> >  	mutex_init(&dev->mutex);
> >  
> >  	lis3lv02d_add_fs(dev);
> > diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
> > index 3e8a208..caf3ed1 100644
> > --- a/drivers/hwmon/lis3lv02d.h
> > +++ b/drivers/hwmon/lis3lv02d.h
> > @@ -20,6 +20,7 @@
> >   */
> >  #include <linux/platform_device.h>
> >  #include <linux/input-polldev.h>
> > +#include <linux/regulator/consumer.h>
> >  
> >  /*
> >   * This driver tries to support the "digital" accelerometer chips from
> > @@ -97,6 +98,15 @@ enum lis3_who_am_i {
> >  	WAI_8B		= 0x3B, /* 8 bits: LIS[23]02D[LQ]... */
> >  	WAI_6B		= 0x52, /* 6 bits: LIS331DLF - not supported */
> >  };
> > +/* Number of RW registers in each device for register caching purposes */
> You could just enforce this through review, but I guess it doesn't hurt
> to have sanity checks... 
> 

With runtime allocation these are not needed at all.

> > +#define NUM_RW_REGS_12B 21
> > +#define NUM_RW_REGS_8B  15
> > +
> > +#if NUM_RW_REGS_8B > NUM_RW_REGS_12B
> > +#define LIS3_NUM_MAX_REG NUM_RW_REGS_8B
> > +#else
> > +#define LIS3_NUM_MAX_REG NUM_RW_REGS_12B
> > +#endif
> >  
> >  enum lis3lv02d_ctrl1_12b {
> >  	CTRL1_Xen	= 0x01,
> > @@ -206,6 +216,9 @@ enum lis3lv02d_click_src_8b {
> >  	CLICK_IA	= 0x40,
> >  };
> >  
> > +#define LIS3_REG_OFF	0x00
> > +#define LIS3_REG_ON	0x01
> I think the rest of these are done as enums.  Worth doing that here for
> consistency?

True

> > +
> >  struct axis_conversion {
> >  	s8	x;
> >  	s8	y;
> > @@ -218,8 +231,13 @@ struct lis3lv02d {
> >  	int (*init) (struct lis3lv02d *lis3);
> >  	int (*write) (struct lis3lv02d *lis3, int reg, u8 val);
> >  	int (*read) (struct lis3lv02d *lis3, int reg, u8 *ret);
> > +	int (*reg_ctrl) (struct lis3lv02d *lis3, bool state);
> >  
> >  	int                     *odrs;     /* Supported output data rates */
> > +	u8			*regs;	   /* Regs to store / restore */
> > +	int			regs_size;
> > +	bool			regs_stored;
> > +	u8                      reg_cache[LIS3_NUM_MAX_REG];
> >  	u8                      odr_mask;  /* ODR bit mask */
> >  	u8			whoami;    /* indicates measurement precision */
> >  	s16 (*read_data) (struct lis3lv02d *lis3, int reg);
> > @@ -232,6 +250,7 @@ struct lis3lv02d {
> >  
> >  	struct input_polled_dev	*idev;     /* input device */
> >  	struct platform_device	*pdev;     /* platform device */
> > +	struct regulator_bulk_data regulators[2];
> >  	atomic_t		count;     /* interrupt count after last read */
> >  	struct axis_conversion	ac;        /* hw -> logical axis */
> >  	int			mapped_btns[3];
> > diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
> > index b9ed1fb..0852bed 100644
> > --- a/drivers/hwmon/lis3lv02d_i2c.c
> > +++ b/drivers/hwmon/lis3lv02d_i2c.c
> > @@ -30,10 +30,29 @@
> >  #include <linux/err.h>
> >  #include <linux/i2c.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/delay.h>
> >  #include "lis3lv02d.h"
> >  
> >  #define DRV_NAME 	"lis3lv02d_i2c"
> >  
> > +static const char reg_vdd[]    = "Vdd";
> > +static const char reg_vdd_io[] = "Vdd_IO";
> > +
> > +static int lis3_reg_ctrl(struct lis3lv02d *lis3, bool state)
> > +{
> > +	int ret;
> > +	if (state = LIS3_REG_OFF) {
> > +		ret = regulator_bulk_disable(ARRAY_SIZE(lis3->regulators),
> > +					lis3->regulators);
> > +	} else {
> > +		ret = regulator_bulk_enable(ARRAY_SIZE(lis3->regulators),
> > +					lis3->regulators);
> > +		/* Chip needs time to wakeup. Not mentioned in datasheet */
> > +		usleep_range(5000, 10000);
> > +	}
> > +	return ret;
> > +}
> > +
> >  static inline s32 lis3_i2c_write(struct lis3lv02d *lis3, int reg, u8 value)
> >  {
> >  	struct i2c_client *c = lis3->bus_priv;
> > @@ -52,6 +71,12 @@ static int lis3_i2c_init(struct lis3lv02d *lis3)
> >  	u8 reg;
> >  	int ret;
> >  
> > +	lis3_reg_ctrl(lis3, LIS3_REG_ON);
> > +
> > +	lis3->read(lis3, WHO_AM_I, &reg);
> > +	if (lis3->whoami != 0 && reg != lis3->whoami)
> What is the purpose of the first test? How can we get here without that being set?

uumm.... there is no way. Init function is called first time after 
setting up the whoami value. 

> > +		printk(KERN_ERR "lis3: power on failure\n");
> > +
> >  	/* power up the device */
> >  	ret = lis3->read(lis3, CTRL_REG1, &reg);
> >  	if (ret < 0)
> > @@ -89,16 +114,29 @@ static int __devinit lis3lv02d_i2c_probe(struct i2c_client *client,
> >  			goto fail;
> >  	}
> >  
> > +	lis3_dev.regulators[0].supply = reg_vdd;
> > +	lis3_dev.regulators[1].supply = reg_vdd_io;
> > +	ret = regulator_bulk_get(&client->dev, ARRAY_SIZE(lis3_dev.regulators),
> > +				lis3_dev.regulators);
> > +	if (ret < 0)
> > +		goto fail;
> > +
> >  	lis3_dev.pdata	  = pdata;
> >  	lis3_dev.bus_priv = client;
> >  	lis3_dev.init	  = lis3_i2c_init;
> >  	lis3_dev.read	  = lis3_i2c_read;
> >  	lis3_dev.write	  = lis3_i2c_write;
> > +	lis3_dev.reg_ctrl = lis3_reg_ctrl;
> >  	lis3_dev.irq	  = client->irq;
> >  	lis3_dev.ac	  = lis3lv02d_axis_map;
> >  	lis3_dev.pm_dev	  = &client->dev;
> >  
> >  	i2c_set_clientdata(client, &lis3_dev);
> > +
> > +	/* Provide power over the init call */
> > +	lis3_reg_ctrl(&lis3_dev, LIS3_REG_ON);
> > +	lis3_reg_ctrl(&lis3_dev, LIS3_REG_OFF);
> > +
> >  	ret = lis3lv02d_init_device(&lis3_dev);
> >  fail:
> >  	return ret;
> > @@ -113,8 +151,11 @@ static int __devexit lis3lv02d_i2c_remove(struct i2c_client *client)
> >  		pdata->release_resources();
> >  
> >  	lis3lv02d_joystick_disable();
> > +	lis3lv02d_remove_fs(lis3);
> subtle change here... Out of intererst, why did the top level lis3_dev
> structure ever exist?  (you can tell I haven't looked closely at this driver
> before!) Can remove_fs return an error? 

Remove fs returns always 0. 

There are couple of bigger changes which somebody should do to this
driver:
- Change static lis3_dev structure to a dynamically allocated one
- Add proper error handling to the driver.



> >  
> > -	return lis3lv02d_remove_fs(&lis3_dev);
> > +	regulator_bulk_free(ARRAY_SIZE(lis3->regulators),
> > +			lis3_dev.regulators);
> > +	return 0;
> >  }
> >  
> >  #ifdef CONFIG_PM
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
