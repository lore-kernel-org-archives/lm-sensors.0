From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Dec 2009 08:37:51 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: add INA209 driver
Message-Id: <20091218093751.6d331aa8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090820214925.GC16733@ovro.caltech.edu>
In-Reply-To: <20090820214925.GC16733@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Wed, 16 Dec 2009 12:55:12 -0800, Ira W. Snyder wrote:
> On Thu, Aug 20, 2009 at 02:49:25PM -0700, Ira W. Snyder wrote:
> > Add Linux support for the TI / Burr-Brown INA209 voltage / current / power
> > monitor I2C interface.
> 
> Can someone please take a look at this and see if it OK for mainline, or
> if there are other changes that would be required. I'd like to stop
> maintaining it out of tree. I'm just checking to make sure that this
> patch didn't get forgotten, since I haven't gotten any feedback at all.

I think I tried reviewing your code a couple times in the past. The
problem is that your driver doesn't quite fit in the hwmon subsystem,
so I just don't know what to do with it.

Your driver is not using the standard unit for in0, it is reporting a
fake power1 just to let user-space compute it by itself, the unit used
for curr1 looks suspicious as well. No other driver dared do the same.
The whole "needs calibration factors" thing is pretty uncommon. Either
the hwmon subsystem and/or libsensors need to be extended to support
that kind of thing, or your driver simply doesn't belong there. Maybe
the upcoming industrial I/O subsystem would be more appropriate, I
don't know.

In the absence of a maintainer for the hwmon subsystem, it's pretty
hard to get that kind of different hardware support merged. It would
require decisions that it seems nobody wants to take, whatever the
reason. So I fear you're pretty much stuck for now, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
