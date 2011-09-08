From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 08 Sep 2011 18:39:46 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V4] hwmon: OMAP4: On die temperature
Message-Id: <20110908183946.GA15247@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
	<1314811510-15595-7-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1108311810280.26173@utopia.booyaka.com>
	<20110901014939.GB21986@ericsson.com>
	<alpine.DEB.2.00.1108312200260.26173@utopia.booyaka.com>
	<20110901044047.GB25878@ericsson.com>
In-Reply-To: <20110901044047.GB25878@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Wed, Aug 31, 2011 at 09:40:47PM -0700, Guenter Roeck wrote:
> On Thu, Sep 01, 2011 at 12:09:14AM -0400, Paul Walmsley wrote:

> > So based on your comments, it sounds like we should move that part of the 
> > code to a different driver, and just leave the basic software thermal 
> > monitoring here?

> Good point. This definitely requires some thought. hwmon is meant to
> be hw monitoring, as the name says, not thermal management. Maybe this
> entire driver should be a thermal driver instead ?

There's a lot of overlap between subsystems here - as well as the
thermal management stuff where the information hwmon gathers may be a
useful input to that the information exported by hwmon can also show up
in the power supply subsystem, and there's the possible overlap with
IIO as well as obviously the hardware monitoring may be being done using
something that's basically just a generic ADC.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
