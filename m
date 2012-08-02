From: John <rippetoej@gmail.com>
Date: Thu, 02 Aug 2012 03:07:00 +0000
Subject: Re: [lm-sensors] Output problem with adcxx  on at91
Message-Id: <loom.20120802T045816-837@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5019526C.2030802@comconcepts.com>
In-Reply-To: <5019526C.2030802@comconcepts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter Roeck <linux <at> roeck-us.net> writes:
> 
> > >./arch/arm/mach-at91/board-electrum-100.c is not in mainline, so this is 
a bit
> > >difficult. Given the above, it may even be that there is a separate 
driver for
> > >the chip somewhere in your tree (ok, I think I found the patch, there 
isn't,
> > >but that means this never worked).
> > I could have sworn that I saw it in mainline, but now that I check I
> > see it is not there.  Sorry about that! I am not sure what you mean
> > as far as the driver never working and exactly what patch you are
> > talking about.  Could you clarify?
> 
> http://stoian.us/misc/files/linux-3.3.0-micromint.patch
> 
> Since the patch sets modalias to "adc128s052", and a driver with that name 
does
> not exist in the kernel, it can not have worked, at least not with this
> configuration.
> 

Oh, I see what you are referring to now.  That specicif modalias "adc128s052" 
is what I added to the adcxx driver in order to get it to bind to the device 
lsited there in that board configuration.  

> > >Other than that, there could be many things wrong. Chip select, bus 
number,
> > >clock speed, chip access mode. There is no example for a working 
instantiation
> > >in the upstream kernel, so I have no idea what the valid parameters might 
be.
> > >You mentioned user mode access worked - maybe you can compare it with the 
kernel
> > >settings.
> > As far as I can tell (and I may be wrong here, this is all still
> > pretty new to me) the bus and chip select are all correct.  Clock
> > speed could be an issue I suppose.  I just did the reverse math on
> > the value that the driver is reporting and realized that before it
> > is converted, the raw value is 2 bytes worth of 1's.  I am going to
> > trace through the spi_write_then_read() function in the adcxx driver
> > and compare its method to that used by the user mode program and the
> > atmel_spi driver.  I'm not sure how far I am going to get though.
> > 
> 
> Doesn't sound good, and I am not entirely sure if using spi_write_then_read
() is
> correct for this chip. You might try the access in single-channel mode to 
see if
> it makes a difference.


You are most definitely right.  After doing a little reading, I realize that I 
am going to be doing a little bit of driver 'rewriting' tomorrow.  More 
specifically, I am going to adapt the adcxx protocol driver to use the 
functions from the atmel_spi controller driver.  I will report back with 
results when finished, though I will more likely be back with more questions 
before than.  

Thanks again for the guidance.

John 


> 
> Guenter
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
