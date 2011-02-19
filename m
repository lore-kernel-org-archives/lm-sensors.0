From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Feb 2011 19:15:16 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] Let Kconfig handle lis3lv02d
Message-Id: <20110219201516.4756dafd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219182207.GB1038@ericsson.com>
In-Reply-To: <20110219182207.GB1038@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 19 Feb 2011 10:22:07 -0800, Guenter Roeck wrote:
> On Sat, Feb 19, 2011 at 08:22:57AM -0500, Jean Delvare wrote:
> > From: Jean Delvare <khali@linux-fr.org>
> > Subject: Let Kconfig handle lis3lv02d dependencies
> > 
> > The dependencies between the various lis3lv02d drivers make it
> > impossible to split them to different directories, while we really
> > want to do this. Move handling of dependencies from Makefile to
> > Kconfig, to make the move possible at all.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Eric Piel <eric.piel@tremplin-utc.net>
> > Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > Not tested due to lack of hardware.
> > 
> >  drivers/hwmon/Kconfig  |   43 +++++++++++++++++++------------------------
> >  drivers/hwmon/Makefile |    9 ++++++---
> >  2 files changed, 25 insertions(+), 27 deletions(-)
> > 
> > --- linux-2.6.38-rc5.orig/drivers/hwmon/Kconfig	2011-02-18 18:22:24.000000000 +0100
> > +++ linux-2.6.38-rc5/drivers/hwmon/Kconfig	2011-02-19 13:46:58.000000000 +0100
> > @@ -2,6 +2,12 @@
> >  # Hardware monitoring chip drivers configuration
> >  #
> >  
> > +config SENSORS_LIS3LV02D
> > +	tristate
> > +	depends on INPUT
> > +	select INPUT_POLLDEV
> > +	default n
> > +
> >  menuconfig HWMON
> >  	tristate "Hardware Monitoring support"
> >  	depends on HAS_IOMEM
> > @@ -1139,7 +1145,7 @@ config SENSORS_ULTRA45
> >  config SENSORS_LIS3_SPI
> >  	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (SPI)"
> >  	depends on !ACPI && SPI_MASTER && INPUT
> > -	select INPUT_POLLDEV
> > +	select SENSORS_LIS3LV02D
> >  	default n
> >  	help
> >  	  This driver provides support for the LIS3LV02Dx accelerometer connected
> > @@ -1156,7 +1162,7 @@ config SENSORS_LIS3_SPI
> >  config SENSORS_LIS3_I2C
> >  	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (I2C)"
> >  	depends on I2C && INPUT
> > -	select INPUT_POLLDEV
> > +	select SENSORS_LIS3LV02D
> >  	default n
> >  	help
> >  	  This driver provides support for the LIS3LV02Dx accelerometer connected
> > @@ -1217,35 +1223,24 @@ config SENSORS_ATK0110
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called asus_atk0110.
> >  
> > -config SENSORS_LIS3LV02D
> > -	tristate "STMicroeletronics LIS3* three-axis digital accelerometer"
> > +config HP_ACCEL
> > +	tristate "HP laptop accelerometer"
> >  	depends on INPUT
> > -	select INPUT_POLLDEV
> > +	select SENSORS_LIS3LV02D
> >  	select NEW_LEDS
> >  	select LEDS_CLASS
> >  	default n
> >  	help
> > -	  This driver provides support for the LIS3* accelerometers, such as the
> > -	  LIS3LV02DL or the LIS331DL. In particular, it can be found in a number
> > -	  of HP laptops, which have the "Mobile Data Protection System 3D" or
> > -	  "3D DriveGuard" feature. On such systems the driver should load
> > -	  automatically (via ACPI alias). The accelerometer might also be found
> > -	  in other systems, connected via SPI or I2C. The accelerometer data is
> > -	  readable via /sys/devices/platform/lis3lv02d.
> > -
> > -	  This driver also provides an absolute input class device, allowing
> > -	  a laptop to act as a pinball machine-esque joystick. It provides also
> > -	  a misc device which can be used to detect free-fall. On HP laptops,
> > -	  if the led infrastructure is activated, support for a led indicating
> > -	  disk protection will be provided as hp::hddprotect. For more
> > -	  information on the feature, refer to Documentation/hwmon/lis3lv02d.
> > +	  This driver provides support for the "Mobile Data Protection System 3D"
> > +	  or "3D DriveGuard" feature of HP laptops. On such systems the driver
> > +	  should load automatically (via ACPI alias).
> >  
> > -	  This driver can also be built as modules.  If so, the core module
> > -	  will be called lis3lv02d and a specific module for HP laptops will be
> > -	  called hp_accel.
> > +	  Support for a led indicating disk protection will be provided as
> > +	  hp::hddprotect. For more information on the feature, refer to
> > +	  Documentation/hwmon/lis3lv02d.
> >  
> > -	  Say Y here if you have an applicable laptop and want to experience
> > -	  the awesome power of lis3lv02d.
> > +	  To compile this driver as a module, choose M here: the module will
> > +	  be called hp_accel.
> >  
> >  endif # ACPI
>
> Looks good, only I wonder if there would be a means to specify that only one of 
> SENSORS_LIS3_SPI, SENSORS_LIS3_I2C, or HP_ACCEL is valid at any given time.

SENSORS_LIS3_SPI and HP_ACCEL are already mutually exclusive (they
depend on !ACPI and ACPI respectively, and ACPI is a boolean.) I am not
sure if they should also be exclusive with SENSORS_LIS3_I2C... In fact I
don't think the exclusive access should be handled at build time, it
would better be handled at run-time, and preferably on a per-device
basis.

But more importantly, my patches do _not_ change anything here. I left
things the way they were.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
