From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 06 Jan 2011 12:07:13 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030	madc
Message-Id: <20110106120713.GD17184@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294287457-2438-1-git-send-email-j-keerthy@ti.com> <20110106053328.GA7489@ericsson.com>
In-Reply-To: <20110106053328.GA7489@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Keerthy <j-keerthy@ti.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "balajitk@ti.com" <balajitk@ti.com>

On Wed, Jan 05, 2011 at 09:33:28PM -0800, Guenter Roeck wrote:

> [...]
> > +EXPORT_SYMBOL_GPL(twl4030_madc_conversion);
> [...]
> > +EXPORT_SYMBOL_GPL(twl4030_get_madc_conversion);

> No symbol export from hwmon drivers. Other parts of the kernel
> should not depend on HWMON configuration.

Why?  It's not like hwmon has an unreasonably large core or similar.

> I would suggest to check if drivers/staging/iio would be a better fit.

That does have the problem that it's in staging and constantly churning,
though.  When I've looked at it it seemed like awfully hard work to use
for devices like this.

What I've done in some of my drivers is put the ADC core in the MFD core
(it's used by both hwmon and power supply function drivers, plus any
board specific stuff people do).

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
