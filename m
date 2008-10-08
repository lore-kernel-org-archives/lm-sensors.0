From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 08 Oct 2008 18:50:08 +0000
Subject: Re: [lm-sensors] [PATCH 05/12] adt7470: Add documentation
Message-Id: <20081008185008.GG7726@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011849.12701.53492.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011849.12701.53492.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 08, 2008 at 11:46:47AM +0200, Jean Delvare wrote:

> > +This driver implements support for the Analog Devices ADT7470 chip family.
> 
> Family? The driver only supports one chip.

I've not exhaustively researched their other chips, so I don't know if
there are successor chips that adhere to the 7470's interface.  Given
that they have a history of doing that, I'm assuming that at some point
it will be a family.

<snip; will pick up the fixes>

> > +sensors or the fan control algorithm will not run.  The chip WILL NOT DO THIS
> > +AUTOMATICALLY; this must be done from userspace.  This may be a bug in the chip
> > +design, given that many other AD chips take care of this.  The driver will not
> 
> This is very weird. This pretty much voids the point of an automatic
> fan control mode. If you have to read registers continuously for it to
> work, you can as well control it completely in software.

Yes.  Given the _long_ time it takes to read the external sensors and
the chip being locked during those reads, I could see why they don't
want to do automatic sensor reads.  However, I only discovered this
weird quirk by accident.  Most likely you'd attach this thing to a BMC
that would know to poke the chip to read its sensors periodically. 

It does explain why the hw designers of the Z30 were complaining that
the CPU fans wouldn't speed up even if they blew a hair dryer at the
thermal sensor.  Apparently they got one of these things to overheat and
explode the VRMs.

All said, the algorithm that picks the pwm output based on the
temperature input seems to work provided that somebody makes the chip
read its temperature inputs.

<snip; will pick up the fixes>

> > +The ADT7470 have a 8-bit ADC and can therefore measure temperatures
> > +with 1 degC resolution.
> 
> This "therefore" is incorrect. You can't deduce the physical resolution
> from the ADC resolution, you need to additionally know the LSB weight
> for that.

"might be capable of measuring" ?

> Please send an updated patch.

Will do.

> Out of curiosity: isn't it possible to detect how many thermal sensors
> are actually connected, and only create sysfs files for these? Creating
> files for sensors which do not exist is rather confusing.

I'm not sure.  Sensors that aren't present return a temperature of 0,
and I have no way of distinguishing a sensor reporting 0 vs. no sensor
at all.  For the Z30 I know that only temp1 and temp3 are actually
hooked up, so I suppose we could special case it and any other machines
we come across.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
