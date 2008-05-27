From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Tue, 27 May 2008 16:44:15 +0000
Subject: Re: [lm-sensors] [spi-devel-general] Accelerometer,
Message-Id: <20080527164415.GA27584@polina.dev.rtsoft.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <4832A211.4040206@gmail.com>
In-Reply-To: <4832A211.4040206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Cc: linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net, LM Sensors <lm-sensors@lm-sensors.org>

Hi Jonathan,

On Tue, May 20, 2008 at 11:04:01AM +0100, Jonathan Cameron wrote:
> This email is basically a request for opinions on how and where such sensors
> should be integrated into the kernel.
> 
> To set the scene...
> 
> Increasing numbers of embedded devices are being supplied attached MEMS
> devices (www.xbow.com imote2 etc). Along with more traditional sensors such
> as ADC's not being used for hardware monitoring, these do not really 
> seem to
> fit with in an particular subsystem of the kernel.  A previous 
> discussion on
> lkml in 2006 considered the accelerometers to be found within some laptop
> hard drives, but I haven't been able to track down any more general 
> discussions
> of such non hardware monitoring sensors.
> 
> The obvious possibilities are:
> 
> * To place the various drivers within the spi / i2c etc subsystems as 
> relevant.
> 
> * To place within the hwmon subsystem as this is probably closest.
> (there is already at least one straight ADC driver in hwmon)
> 
> * To create a new subsystem, or perhaps merely sysfs class to contain these
>   elements.
> 
> Typical requirements within an application include simply polling for 
> current
> readings, and using device triggered interrupts to grab data 
> continuously to a
> ring buffer, for collection by suitable userspace code.  Obviously it 
> would be
> desirable to standardize sysfs controls for various calibration 
> parameters as
> much as possible across the various devices.

Also, I'd mention that most ADC devices could report in "bunched" mode,
i.e.

1. Request ADC readings from pins X, Y, Z1, Z2.
2. Wait for single IRQ
3. Read all the results

At handhelds.org, we've wrote quite good (I think) ADC subsystem,
that keeps in mind ADC capabilities. It implements two interfaces:
in-kernel (e.g. for touchscreen drivers), and userspace interface via
sysfs. I was planning to implement drivers/input/ interface too.

I always don't find time to clean it up and submit, though.

Here is ADC subsystem itself:
http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/adc.c
http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/include/linux/adc.h
^ It is in drivers/misc/, but I think better placement would be
  drivers/adc.

Some drivers for this subsystem:
http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/ads7846_adc_ssp.c
^ ADC driver for ADS7846 chips (HP iPaq hx4700 and some HTC phones, the
  driver is using SSP subsystem, switching it to the SPI is still in my enless
  TODO list).

http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/samcop_adc.c
^ SAMCOP (HP iPaq H5xxx) ADC driver.

http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/tsc2200_adc_ssp.c
^ TSC2200 ADC driver (used AFAIK in some HTC phones, or ASUS handhelds).

http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/ad7877.c
^ AD7877 ADC driver (HTC phones too, IIRC).

Now, The Generic ADC Touchscreen Driver (tested to work quite good with all
above ADC drivers on appropriate hardware):
http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/input/touchscreen/ts-adc.c

And finally, ADC Battery driver ("backup" batteries in the iPaq devices
usually report their voltage via ADC chip, the same used by the
touchscreen).
http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/power/adc_battery.c

p.s.
I have more recent (for current Linus' tree) code for ADC subsystem, but
it still needs some love to be submittable.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
