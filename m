From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 06 Jan 2011 21:55:03 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030 madc
Message-Id: <1294350903.9786.103.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294287457-2438-1-git-send-email-j-keerthy@ti.com>
	 <20110106053328.GA7489@ericsson.com> <20110106120713.GD17184@sirena.org.uk>
	 <20110106150430.GA9053@ericsson.com>
	 <20110106202142.GC8018@opensource.wolfsonmicro.com>
In-Reply-To: <20110106202142.GC8018@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Keerthy <j-keerthy@ti.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "balajitk@ti.com" <balajitk@ti.com>

On Thu, 2011-01-06 at 15:21 -0500, Mark Brown wrote:
> On Thu, Jan 06, 2011 at 07:04:30AM -0800, Guenter Roeck wrote:
> > On Thu, Jan 06, 2011 at 07:07:13AM -0500, Mark Brown wrote:
> 
> > > Why?  It's not like hwmon has an unreasonably large core or similar.
> 
> > Because it creates an unnecessary dependency, and because it is not hwmon's 
> > responsibility to provide infrastructure for other subsystems or drivers.
> 
> hwmon isn't really doing anything, though.  The *driver* is doing
> something but it doesn't really impact the core that much.  Not that I'm
> particularly sold on putting the ADC core in here, but total NACK based
> on that alone seems rather harsh.

Possibly. However, I had suggested the following earlier (to the 1st
version of the patch):

> I commented on this a couple of times below - the driver mixes generic
> ADC reading functions with hwmon functionality. Generic ADC reading
> functionality should be moved into another driver, possibly to mfd.

Obviously that was ignored. Maybe someone is willing to listen this time
around.

I won't let people break modularity just for convenience in a subsystem
I am responsible for. And forcing the hwmon subsystem, and with it a
specific hwmon driver, to exist just because the adc functionality it
provides is needed by some other (most likely unrelated) subsystem /
driver _does_ break modularity. Worse, it is completely unnecessary to
do so. Other twl4030 functionality was extracted into generic code.
twl-core.c, twl4030-codec.c, twl4030-irq.c, twl4030-power.c are all in
mfd. I fail to see the problem with mfd/twl4030-adc.c.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
