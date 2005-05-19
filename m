From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Support for Intel BMC chipsets via IPMI
Message-Id: <3DD72665.39FD6E41@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <A5974D8E5F98D511BB910002A50A66470580D387@hdsmsx103.hd.intel.com>
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470580D387@hdsmsx103.hd.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > "Cress, Andrew R" wrote:
> > >
> > > Folks,
> > >
> > > I like the way your project ties together lots of types of sensors.
> > > I have a project that uses IPMI to do various things, including get
> > > sensor data and decode the readings.  It is compatible with either
> > > the /dev/ipmikcs (valinux) or /dev/imb (Intel) interfaces, and has
> > > been validated with Corey's IPMI driver.
> > > This code works with Intel BMC chipsets.
> > > See  http://panicsel.sourceforge.net  (sensors.c)
> > >
> > > I'm currently working on conforming the interface of these utilities
> > > to the saforum.org's Hardware Platform Interface.  So, I'd be interested
> > > in what interface you have now, and if you are planning to move to SA
> HPI
> > or
> > > not.
>

I downloaded the saforum document and spent enough time skimming
through it (about 30 seconds) to be able to answer your questions.

No we aren't doing that interface.

First of all, we focus on drivers.
Our drivers generally use direct access to devices, and
export the data in a relatively simple manner to /proc. From there,
we have a text program 'sensors'. Others (search sourceforge for
'sensors')
have developed GUI interfaces to the data, either with /proc accesses or
using our libsensors library.

What I am doing with IPMI is accessing the sensors that are hiding
behind
the BMC and exporting the data to /proc, following our API.
This allows people with Intel boards to find out their processor
temperature,
using all the existing userspace GUI's, etc. that have been developed.
But probably 90% of the features and richness of IPMI will be lost going
through our API. So if you were doing something like the saforum thing,
our package will just get in the way.

I encourage you to give our package a try. You may have the best results
on a non-IPMI motherboard, at least in the near future :)

mds
