From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Oct 2010 18:00:05 +0000
Subject: Re: [lm-sensors] hwmon: (w83795) Exclude fan control feature by
Message-Id: <1288288805.9690.459.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101028175239.574d5a35@endymion.delvare>
In-Reply-To: <20101028175239.574d5a35@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thu, 2010-10-28 at 13:52 -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Thu, 28 Oct 2010 09:01:42 -0700, Guenter Roeck wrote:
> > On Thu, Oct 28, 2010 at 11:52:39AM -0400, Jean Delvare wrote:
> > > The fan control feature of the w83795 driver is insufficiently
> > > reviewed and tested for public consumption at this time, so make it
> > > optional and disabled by default. We will change the default when
> > > review and testing is deemed sufficient. Ultimately the option will
> > > go away.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> > 
> > Minor comment below. Otherwise
> > 	Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > 
> > > ---
> > > With this, the only non-standard attribute showing by default is "chassis". I'll
> > > fix it now and send a patch immediately.
> > > 
> > >  drivers/hwmon/Kconfig  |   17 +++++++++++++++++
> > >  drivers/hwmon/w83795.c |   10 ++++++++++
> > >  2 files changed, 27 insertions(+)
> > > 
> > > --- linux-2.6.37-rc0.orig/drivers/hwmon/Kconfig	2010-10-28 16:26:10.000000000 +0200
> > > +++ linux-2.6.37-rc0/drivers/hwmon/Kconfig	2010-10-28 17:24:25.000000000 +0200
> > > @@ -1041,6 +1041,23 @@ config SENSORS_W83795
> > >  	  This driver can also be built as a module.  If so, the module
> > >  	  will be called w83795.
> > >  
> > > +config SENSORS_W83795_FANCTRL
> > > +	boolean "Include fan control support (DANGEROUS)"
> > > +	depends on SENSORS_W83795 && EXPERIMENTAL
> > > +	default n
> > > +	help
> > > +	  If you say yes here, support for the both manual and automatic
> > > +	  fan control features will be included in the driver.
> > > +
> > > +	  This part of the code wasn't carefully reviewed and tested yet,
> > > +	  so enabling this option is strongly discouraged on production
> > > +	  servers. Only developers and testers should enable it for the
> > > +	  time being.
> > > +
> > > +	  Please also note that this option will create sysfs attribute
> > > +	  files which may change in the future, so you shouldn't rely
> > > +	  on them being stable.
> > > +
> > >  config SENSORS_W83L785TS
> > >  	tristate "Winbond W83L785TS-S"
> > >  	depends on I2C && EXPERIMENTAL
> > > --- linux-2.6.37-rc0.orig/drivers/hwmon/w83795.c	2010-10-28 16:41:32.000000000 +0200
> > > +++ linux-2.6.37-rc0/drivers/hwmon/w83795.c	2010-10-28 17:39:12.000000000 +0200
> > > @@ -1455,6 +1455,7 @@ store_in(struct device *dev, struct devi
> > >  }
> > >  
> > >  
> > > +#ifdef CONFIG_SENSORS_W83795_FANCTRL
> > >  static ssize_t
> > >  show_sf_setup(struct device *dev, struct device_attribute *attr, char *buf)
> > >  {
> > > @@ -1506,6 +1507,7 @@ store_sf_setup(struct device *dev, struc
> > >  	mutex_unlock(&data->update_lock);
> > >  	return count;
> > >  }
> > > +#endif
> > >  
> > >  
> > >  #define NOT_USED			-1
> > > @@ -1711,6 +1713,7 @@ static const struct sensor_device_attrib
> > >  		      store_chassis_clear, ALARM_STATUS, 46),
> > >  	SENSOR_ATTR_2(beep_enable, S_IWUSR | S_IRUGO, show_alarm_beep,
> > >  		      store_beep, BEEP_ENABLE, 47),
> > > +#ifdef CONFIG_SENSORS_W83795_FANCTRL
> > >  	SENSOR_ATTR_2(speed_cruise_tolerance, S_IWUSR | S_IRUGO, show_fanin,
> > >  		store_fanin, FANIN_TOL, NOT_USED),
> > >  	SENSOR_ATTR_2(pwm_default, S_IWUSR | S_IRUGO, show_sf_setup,
> > > @@ -1719,6 +1722,7 @@ static const struct sensor_device_attrib
> > >  		      store_sf_setup, SETUP_PWM_UPTIME, NOT_USED),
> > >  	SENSOR_ATTR_2(pwm_downtime, S_IWUSR | S_IRUGO, show_sf_setup,
> > >  		      store_sf_setup, SETUP_PWM_DOWNTIME, NOT_USED),
> > > +#endif
> > >  };
> > >  
> > >  /*
> > > @@ -1872,6 +1876,7 @@ static int w83795_handle_files(struct de
> > >  			return err;
> > >  	}
> > >  
> > > +#ifdef CONFIG_SENSORS_W83795_FANCTRL
> > >  	for (i = 0; i < data->has_pwm; i++) {
> > >  		for (j = 0; j < ARRAY_SIZE(w83795_pwm[0]); j++) {
> > >  			err = fn(dev, &w83795_pwm[i][j].dev_attr);
> > > @@ -1879,11 +1884,16 @@ static int w83795_handle_files(struct de
> > >  				return err;
> > >  		}
> > >  	}
> > > +#endif
> > >  
> > >  	for (i = 0; i < ARRAY_SIZE(w83795_temp); i++) {
> > >  		if (!(data->has_temp & (1 << i)))
> > >  			continue;
> > > +#ifdef CONFIG_SENSORS_W83795_FANCTRL
> > >  		for (j = 0; j < ARRAY_SIZE(w83795_temp[0]); j++) {
> > > +#else
> > > +		for (j = 0; j < 8; j++) {
> > > +#endif
> > 
> > Can you keep using ARRAY_SIZE here and if necessary make array elements conditional ?
> 
> Not easily. The array elements are filled in through preprocessing, and
> you can't put #ifdefs inside #defines. So we'd have to either duplicate
> part of the macro (which I don't want to do) or split the macro
> generating the elements.
> 
> I'm not particularly happy with the hard-coded 8 either, but the
> alternative isn't very appealing. After splitting the macro, I also
> have to comment out many callback functions to avoid build-time
> warnings. Thus clutters the code further...
> 
> I end up with the following. Do you really thing this is preferable
> over my first version? I don't, especially for an option we will get
> rid of after some (hopefully short) time.
> 
That is much worse. I agree, better stick with the hardcoded value.

Guenter

> ---
>  drivers/hwmon/Kconfig  |   17 +++++++++++++++++
>  drivers/hwmon/w83795.c |   47 +++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 54 insertions(+), 10 deletions(-)
> 
> --- linux-2.6.37-rc0.orig/drivers/hwmon/Kconfig	2010-10-28 16:26:10.000000000 +0200
> +++ linux-2.6.37-rc0/drivers/hwmon/Kconfig	2010-10-28 17:24:25.000000000 +0200
> @@ -1041,6 +1041,23 @@ config SENSORS_W83795
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called w83795.
>  
> +config SENSORS_W83795_FANCTRL
> +	boolean "Include fan control support (DANGEROUS)"
> +	depends on SENSORS_W83795 && EXPERIMENTAL
> +	default n
> +	help
> +	  If you say yes here, support for the both manual and automatic
> +	  fan control features will be included in the driver.
> +
> +	  This part of the code wasn't carefully reviewed and tested yet,
> +	  so enabling this option is strongly discouraged on production
> +	  servers. Only developers and testers should enable it for the
> +	  time being.
> +
> +	  Please also note that this option will create sysfs attribute
> +	  files which may change in the future, so you shouldn't rely
> +	  on them being stable.
> +
>  config SENSORS_W83L785TS
>  	tristate "Winbond W83L785TS-S"
>  	depends on I2C && EXPERIMENTAL
> --- linux-2.6.37-rc0.orig/drivers/hwmon/w83795.c	2010-10-28 16:41:32.000000000 +0200
> +++ linux-2.6.37-rc0/drivers/hwmon/w83795.c	2010-10-28 19:44:01.000000000 +0200
> @@ -914,6 +914,7 @@ store_pwm_enable(struct device *dev, str
>  	return count;
>  }
>  
> +#ifdef CONFIG_SENSORS_W83795_FANCTRL
>  static ssize_t
>  show_temp_src(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -1029,6 +1030,7 @@ store_temp_pwm_enable(struct device *dev
>  	}
>  	return count;
>  }
> +#endif
>  
>  #define FANIN_TARGET   0
>  #define FANIN_TOL      1
> @@ -1089,6 +1091,7 @@ store_fanin(struct device *dev, struct d
>  }
>  
> 
> +#ifdef CONFIG_SENSORS_W83795_FANCTRL
>  static ssize_t
>  show_temp_pwm(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -1221,6 +1224,7 @@ store_sf4_temp(struct device *dev, struc
>  
>  	return count;
>  }
> +#endif
>  
> 
>  static ssize_t
> @@ -1455,6 +1459,7 @@ store_in(struct device *dev, struct devi
>  }
>  
> 
> +#ifdef CONFIG_SENSORS_W83795_FANCTRL
>  static ssize_t
>  show_sf_setup(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -1506,6 +1511,7 @@ store_sf_setup(struct device *dev, struc
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> +#endif
>  
> 
>  #define NOT_USED			-1
> @@ -1569,7 +1575,7 @@ store_sf_setup(struct device *dev, struc
>  	SENSOR_ATTR_2(temp##index##_beep, S_IWUSR | S_IRUGO,		\
>  		show_alarm_beep, store_beep, BEEP_ENABLE, index + 17) }
>  
> -#define SENSOR_ATTR_TEMP(index) {					\
> +#define SENSOR_ATTR_TEMP(index)						\
>  	SENSOR_ATTR_2(temp##index##_type, S_IRUGO | (index < 4 ? S_IWUSR : 0), \
>  		show_temp_mode, store_temp_mode, NOT_USED, index - 1),	\
>  	SENSOR_ATTR_2(temp##index##_input, S_IRUGO, show_temp,		\
> @@ -1587,7 +1593,10 @@ store_sf_setup(struct device *dev, struc
>  		index + (index > 4 ? 11 : 17)),				\
>  	SENSOR_ATTR_2(temp##index##_beep, S_IWUSR | S_IRUGO,		\
>  		show_alarm_beep, store_beep, BEEP_ENABLE,		\
> -		index + (index > 4 ? 11 : 17)),				\
> +		index + (index > 4 ? 11 : 17))
> +
> +#ifdef CONFIG_SENSORS_W83795_FANCTRL
> +#define SENSOR_ATTR_TEMP_FANCTRL(index)					\
>  	SENSOR_ATTR_2(temp##index##_source_sel, S_IWUSR | S_IRUGO,	\
>  		show_temp_src, store_temp_src, NOT_USED, index - 1),	\
>  	SENSOR_ATTR_2(temp##index##_pwm_enable, S_IWUSR | S_IRUGO,	\
> @@ -1631,7 +1640,10 @@ store_sf_setup(struct device *dev, struc
>  	SENSOR_ATTR_2(temp##index##_auto_point6_temp, S_IRUGO | S_IWUSR,\
>  		show_sf4_temp, store_sf4_temp, 5, index - 1),		\
>  	SENSOR_ATTR_2(temp##index##_auto_point7_temp, S_IRUGO | S_IWUSR,\
> -		show_sf4_temp, store_sf4_temp, 6, index - 1) }
> +		show_sf4_temp, store_sf4_temp, 6, index - 1)
> +#else
> +#define SENSOR_ATTR_TEMP_FANCTRL(index)
> +#endif
>  
> 
>  static struct sensor_device_attribute_2 w83795_in[][5] = {
> @@ -1675,13 +1687,24 @@ static const struct sensor_device_attrib
>  	SENSOR_ATTR_FAN(14),
>  };
>  
> -static const struct sensor_device_attribute_2 w83795_temp[][29] = {
> -	SENSOR_ATTR_TEMP(1),
> -	SENSOR_ATTR_TEMP(2),
> -	SENSOR_ATTR_TEMP(3),
> -	SENSOR_ATTR_TEMP(4),
> -	SENSOR_ATTR_TEMP(5),
> -	SENSOR_ATTR_TEMP(6),
> +static const
> +#ifdef CONFIG_SENSORS_W83795_FANCTRL
> +struct sensor_device_attribute_2 w83795_temp[][29] = {
> +#else
> +struct sensor_device_attribute_2 w83795_temp[][8] = {
> +#endif
> +	{ SENSOR_ATTR_TEMP(1),
> +	  SENSOR_ATTR_TEMP_FANCTRL(1) },
> +	{ SENSOR_ATTR_TEMP(2),
> +	  SENSOR_ATTR_TEMP_FANCTRL(2) },
> +	{ SENSOR_ATTR_TEMP(3),
> +	  SENSOR_ATTR_TEMP_FANCTRL(3) },
> +	{ SENSOR_ATTR_TEMP(4),
> +	  SENSOR_ATTR_TEMP_FANCTRL(4) },
> +	{ SENSOR_ATTR_TEMP(5),
> +	  SENSOR_ATTR_TEMP_FANCTRL(5) },
> +	{ SENSOR_ATTR_TEMP(6),
> +	  SENSOR_ATTR_TEMP_FANCTRL(6) },
>  };
>  
>  static const struct sensor_device_attribute_2 w83795_dts[][8] = {
> @@ -1711,6 +1734,7 @@ static const struct sensor_device_attrib
>  		      store_chassis_clear, ALARM_STATUS, 46),
>  	SENSOR_ATTR_2(beep_enable, S_IWUSR | S_IRUGO, show_alarm_beep,
>  		      store_beep, BEEP_ENABLE, 47),
> +#ifdef CONFIG_SENSORS_W83795_FANCTRL
>  	SENSOR_ATTR_2(speed_cruise_tolerance, S_IWUSR | S_IRUGO, show_fanin,
>  		store_fanin, FANIN_TOL, NOT_USED),
>  	SENSOR_ATTR_2(pwm_default, S_IWUSR | S_IRUGO, show_sf_setup,
> @@ -1719,6 +1743,7 @@ static const struct sensor_device_attrib
>  		      store_sf_setup, SETUP_PWM_UPTIME, NOT_USED),
>  	SENSOR_ATTR_2(pwm_downtime, S_IWUSR | S_IRUGO, show_sf_setup,
>  		      store_sf_setup, SETUP_PWM_DOWNTIME, NOT_USED),
> +#endif
>  };
>  
>  /*
> @@ -1872,6 +1897,7 @@ static int w83795_handle_files(struct de
>  			return err;
>  	}
>  
> +#ifdef CONFIG_SENSORS_W83795_FANCTRL
>  	for (i = 0; i < data->has_pwm; i++) {
>  		for (j = 0; j < ARRAY_SIZE(w83795_pwm[0]); j++) {
>  			err = fn(dev, &w83795_pwm[i][j].dev_attr);
> @@ -1879,6 +1905,7 @@ static int w83795_handle_files(struct de
>  				return err;
>  		}
>  	}
> +#endif
>  
>  	for (i = 0; i < ARRAY_SIZE(w83795_temp); i++) {
>  		if (!(data->has_temp & (1 << i)))
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
