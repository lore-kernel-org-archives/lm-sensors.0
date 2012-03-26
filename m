From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Mon, 26 Mar 2012 18:07:49 +0000
Subject: Re: [lm-sensors] Location for ADC driver
Message-Id: <4F70B075.1020309@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <201203261733.38794.sr@denx.de>
In-Reply-To: <201203261733.38794.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/26/2012 04:33 PM, Stefan Roese wrote:
> Hi,
> 
> I'll start porting a driver for the ST SPEAr600 SoC internal ADC in a short 
> while. First I thought it would be located in drivers/hwmon with its 
> infrastructure. Then I noticed the drivers/staging/iio/adc directory.
> 
> So my question is, where should such an SoC internal ADC driver best be 
> placed? hwmon or iio/adc? Or can I choose freely?
> 
It rather depends on what the adc is used for.  Hwmon is unsurprisingly
suitable for monitoring hardware.  So typically it is relatively low
speed polling of the adc channels via sysfs.

IIO has this mode (and indeed there is a iio_hwmon driver that allows
an iio device to provide a child hwmon device for a selection of channels).

It adds,

1) Buffered support for faster reading of lots of samples.
2) Event handling (there is some alarm support in hwmon).
3) Interfaces to allow other kernel drivers to make use of
the services provided by the ADC.  Right now only interfaces
that poll are supported by mainline. Interfaces that use a callback
are undergoing review.

I'm not having much luck tracking down docs for the SPEAr600 adc, so
I'll guess it is similar to the SPEAr320 one?  Looks like a straight
forward adc without a conversion completion interrupt (which will make
the driver tedious as you'll have to dead reckon the conversion time)
It's not that clever, so I think whether to go with IIO or hwmon
directly is largely a matter of how quick you want to grab data from it...

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
