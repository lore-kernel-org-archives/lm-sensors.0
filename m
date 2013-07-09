From: Harald Geyer <harald@ccbib.org>
Date: Tue, 09 Jul 2013 21:51:37 +0000
Subject: Re: [lm-sensors] humidity sensors
Message-Id: <E1Uwfov-0000cI-Mb@stardust.g4.wien.funkfeuer.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1UwWkL-0000pI-8V@stardust.g4.wien.funkfeuer.at> <51DC4FE0.1080402@kernel.org>
In-Reply-To: <51DC4FE0.1080402@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>

> > I'm working on a iio driver for the DHT11 (and DHT22)
> > humidity and temperature sensor. I believe this is the
> > first humidity sensor to be supported by the iio framework.
> Sure, previously these have been considered acceptable to hwmon
> (just about ;).  That has always  been controversial and with
> iio-hwmon in place, I doubt anyone will mind having it new
> ones in IIO.  I've cc'd a few people just in case they have
> strong views on this.

Thanks for the pointer. Obviously I should have researched that
better.

I didn't look into this in detail yet, but porting the driver to
hwmon probably isn't much more work than adding humidity
support to IIO. Which way do you prefer?

> > This poses the question how the iio API regarding humidity
> > values should be extended.
> > 
> > 1) Which string to use to construct filenames in sysfs, etc.:
> > My suggestion: "relhum"
> I wonder if humidtyrelative would be better (just in case someone
> produces a sensor to measure specific or absolute humidity as then
> they will be close together in names.  Also it's rarely worth
> abreviating these terms as it can only cause confusion at a later
> date and only costs a few characters here and there.

hwmon is using "humidity" it seems. Now I'm torn between using
the same and "humidityrelative" ;)

> > 2) What unit to use for values:
> > My suggestion: permil (0.1%)
> hmm.. Interesting question for a ratio quantity.  Perhaps a
> decimal ratio might work?  so 0.1% = 0.0001?
> Don't really have strong feelings but permil whilst common
> in some fields is a little unusual.

hwmon is using milli per cent units. I suggest following
that precedent.

> > I'll submit a formal patch for the DHT11 driver when the
> > iio framework is ready, but if you want to have a look at
> > the work in progress, you find it at
> > http://www.unet.univie.ac.at/~a0300802/files/dht11-gpio.c
> > and at the bottom of this mail.

[...]

> Have had a very quick look at the driver and looks fine in general.
> Will do a full review once it is complete.

Thanks for the feedback.

Harald

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
