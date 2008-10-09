From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Oct 2008 10:31:17 +0000
Subject: Re: [lm-sensors] [PATCH 05/12] adt7470: Add documentation
Message-Id: <20081009123117.46844403@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011849.12701.53492.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011849.12701.53492.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

On Wed, 8 Oct 2008 11:50:08 -0700, Darrick J. Wong wrote:
> On Wed, Oct 08, 2008 at 11:46:47AM +0200, Jean Delvare wrote:
> > > +sensors or the fan control algorithm will not run.  The chip WILL NOT DO THIS
> > > +AUTOMATICALLY; this must be done from userspace.  This may be a bug in the chip
> > > +design, given that many other AD chips take care of this.  The driver will not
> > 
> > This is very weird. This pretty much voids the point of an automatic
> > fan control mode. If you have to read registers continuously for it to
> > work, you can as well control it completely in software.
> 
> Yes.  Given the _long_ time it takes to read the external sensors and
> the chip being locked during those reads, I could see why they don't
> want to do automatic sensor reads.  However, I only discovered this
> weird quirk by accident.  Most likely you'd attach this thing to a BMC
> that would know to poke the chip to read its sensors periodically. 
> 
> It does explain why the hw designers of the Z30 were complaining that
> the CPU fans wouldn't speed up even if they blew a hair dryer at the
> thermal sensor.  Apparently they got one of these things to overheat and
> explode the VRMs.
> 
> All said, the algorithm that picks the pwm output based on the
> temperature input seems to work provided that somebody makes the chip
> read its temperature inputs.

Should we implement a kernel thread / tasklet / whatever it is called
these days that would actively read the needed temperature values (and
only these) every 5 seconds as soon as automatic fan speed control is
enabled? The current implementation seems dangerous to me, as
illustrated by the report you quoted above.

Maybe this driver should be integrated with the generic thermal zone
framework that was added to the kernel a few months ago? I this this
framework already handles polling of the chips (to be confirmed.)

> > Out of curiosity: isn't it possible to detect how many thermal sensors
> > are actually connected, and only create sysfs files for these? Creating
> > files for sensors which do not exist is rather confusing.
> 
> I'm not sure.  Sensors that aren't present return a temperature of 0,
> and I have no way of distinguishing a sensor reporting 0 vs. no sensor
> at all.  For the Z30 I know that only temp1 and temp3 are actually
> hooked up, so I suppose we could special case it and any other machines
> we come across.

I don't really want to hard-code machine-specific configuration into
kernel drivers. I don't think this would scale over time.

0 doesn't seem like a terribly realistic temperature. So, maybe we can
have a heuristic that disables all sensors that report 0 when the
driver is loaded? To be totally safe, we can then provide a way for the
user to forcibly enable temperature sensors (either a module parameter
or a sysfs file.)

I know we usually don't do that, but OTOH this is the first hardware
monitoring chip which daisy-chains external thermal sensors like that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
