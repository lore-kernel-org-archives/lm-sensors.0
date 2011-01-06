From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 06 Jan 2011 20:21:42 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030 madc
Message-Id: <20110106202142.GC8018@opensource.wolfsonmicro.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294287457-2438-1-git-send-email-j-keerthy@ti.com>
 <20110106053328.GA7489@ericsson.com>
 <20110106120713.GD17184@sirena.org.uk>
 <20110106150430.GA9053@ericsson.com>
In-Reply-To: <20110106150430.GA9053@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Keerthy <j-keerthy@ti.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "balajitk@ti.com" <balajitk@ti.com>

On Thu, Jan 06, 2011 at 07:04:30AM -0800, Guenter Roeck wrote:
> On Thu, Jan 06, 2011 at 07:07:13AM -0500, Mark Brown wrote:

> > Why?  It's not like hwmon has an unreasonably large core or similar.

> Because it creates an unnecessary dependency, and because it is not hwmon's 
> responsibility to provide infrastructure for other subsystems or drivers.

hwmon isn't really doing anything, though.  The *driver* is doing
something but it doesn't really impact the core that much.  Not that I'm
particularly sold on putting the ADC core in here, but total NACK based
on that alone seems rather harsh.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
