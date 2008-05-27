From: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Date: Tue, 27 May 2008 17:59:36 +0000
Subject: Re: [lm-sensors] [spi-devel-general] Accelerometer,
Message-Id: <483C4C08.5080402@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4832A211.4040206@gmail.com> <20080527164415.GA27584@polina.dev.rtsoft.ru>
In-Reply-To: <20080527164415.GA27584@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: avorontsov@ru.mvista.com
Cc: linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net, LM Sensors <lm-sensors@lm-sensors.org>

Hi Anton
>> Typical requirements within an application include simply polling for 
>> current
>> readings, and using device triggered interrupts to grab data 
>> continuously to a
>> ring buffer, for collection by suitable userspace code.  Obviously it 
>> would be
>> desirable to standardize sysfs controls for various calibration 
>> parameters as
>> much as possible across the various devices.
>>     
>
> Also, I'd mention that most ADC devices could report in "bunched" mode,
> i.e.
>
> 1. Request ADC readings from pins X, Y, Z1, Z2.
> 2. Wait for single IRQ
> 3. Read all the results
>   
Good point. I guess it's going to be a while before we work out an 
anywhere near
exhaustive list of such events that we might want to be able to control.
> At handhelds.org, we've wrote quite good (I think) ADC subsystem,
> that keeps in mind ADC capabilities. It implements two interfaces:
> in-kernel (e.g. for touchscreen drivers), and userspace interface via
> sysfs. I was planning to implement drivers/input/ interface too.
> I always don't find time to clean it up and submit, though.
>   
I know that feeling!
> Here is ADC subsystem itself:
> http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/adc.c
> http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/include/linux/adc.h
> ^ It is in drivers/misc/, but I think better placement would be
>   drivers/adc.
>   
Looking at the code (briefly admittedly, I'll have a closer look 
tomorrow) it looks like a nice simple and
effective interface. 

The question here, is what functionality of the system under discussion 
does it fulfill.  Again we are in the
territory of possibly having multiple drivers for a device depending on 
how it is being used in the kernel.
Not ideal, but may in fact be more maintainable in the long run.

The sysfs interface looks similar to that I was intending to implement, 
but obviously for your application you
don't need any of the buffering support etc and it makes sense to keep 
everything as simple as possible.

Perhaps if we aim to keep in mind the possibility of combining your ADC 
system with a more general
input device system, it may make sense to do so at a later stage. 

Anything I write is certainly going to share a considerable amount of 
functionality and approach with your code.
> Some drivers for this subsystem:
> http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/ads7846_adc_ssp.c
> ^ ADC driver for ADS7846 chips (HP iPaq hx4700 and some HTC phones, the
>   driver is using SSP subsystem, switching it to the SPI is still in my enless
>   TODO list).
>   
I'll keep these part in mind, as a the moment adding any component for 
testing involves me getting my soldering iron out
and I hate soldering!

> http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/samcop_adc.c
> ^ SAMCOP (HP iPaq H5xxx) ADC driver.
>
> http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/tsc2200_adc_ssp.c
> ^ TSC2200 ADC driver (used AFAIK in some HTC phones, or ASUS handhelds).
>
> http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/misc/adc/ad7877.c
> ^ AD7877 ADC driver (HTC phones too, IIRC).
>
> Now, The Generic ADC Touchscreen Driver (tested to work quite good with all
> above ADC drivers on appropriate hardware):
> http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/input/touchscreen/ts-adc.c
>
> And finally, ADC Battery driver ("backup" batteries in the iPaq devices
> usually report their voltage via ADC chip, the same used by the
> touchscreen).
> http://handhelds.org/cgi-bin/cvsweb.cgi/~checkout~/linux/kernel26/drivers/power/adc_battery.c
>
> p.s.
> I have more recent (for current Linus' tree) code for ADC subsystem, but
> it still needs some love to be submittable.
>   
Thanks.  I'll have a look at the stuff above and pester you if I need a 
more recent version.

Jonathan



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
