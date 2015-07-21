From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 21 Jul 2015 07:31:11 +0000
Subject: Re: [lm-sensors] [PATCH] thermal: consistently use int for temperatures
Message-Id: <20150721073111.GH5161@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
 <9hhd1zrc9yb.fsf@e105922-lin.cambridge.arm.com>
In-Reply-To: <9hhd1zrc9yb.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Peter Feuerer <peter@piie.net>, Heiko Stuebner <heiko@sntech.de>, Lukasz Majewski <l.majewski@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Darren Hart <dvhart@infradead.org>, lm-sensors@lm-sensors.org

Hi Punit,

On Fri, Jul 17, 2015 at 12:14:36PM +0100, Punit Agrawal wrote:
> Hi Sascha,
>=20
> Sascha Hauer <s.hauer@pengutronix.de> writes:
>=20
> > The thermal code uses int, long and unsigned long for temperatures
> > in different places.
> >
> > Using an unsigned type limits the thermal framework to positive
> > temperatures without need. Also several drivers currently will report
> > temperatures near UINT_MAX for temperatures below 0=B0C. This will prob=
ably
> > immediately shut the machine down due to overtemperature if started bel=
ow
> > 0=B0C.
> >
> > 'long' is 64bit on several architectures. This is not needed since INT_=
MAX =B0mC
> > is above the melting point of all known materials.
> >
> > Consistently use a plain 'int' for temperatures throughout the thermal =
code and
> > the drivers. This only changes the places in the drivers where the temp=
erature
> > is passed around as pointer, when drivers internally use another type t=
his is
> > not changed.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> Thanks for moving over the thermal sub-system in Linux to consistently
> use a single type.
>=20
> In your patch, you missed migrating over power_allocator governor and
> it's associated trace events. It got merged for v4.2.
>=20
> Could you incorporate something like below in your next version?

It seems I have changed drivers/thermal/power_allocator.c but missed
include/trace/events/thermal_power_allocator.h. Please check out the v2
patch I just sent.

Sascha

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
