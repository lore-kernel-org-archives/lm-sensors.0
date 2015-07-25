From: Pavel Machek <pavel@ucw.cz>
Date: Sat, 25 Jul 2015 07:01:32 +0000
Subject: Re: [lm-sensors] [PATCH v2] thermal: consistently use int for temperatures
Message-Id: <20150725070132.GA18328@amd>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437463292-24844-1-git-send-email-s.hauer@pengutronix.de>
 <20150723120759.GA17690@amd>
 <20150724062948.GK18700@pengutronix.de>
 <55B244BE.1060203@roeck-us.net>
 <20150724221102.GA31517@amd>
 <55B2C105.3040600@roeck-us.net>
In-Reply-To: <55B2C105.3040600@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>, Jean Delvare <jdelvare@suse.de>, Peter Feuerer <peter@piie.net>, Heiko Stuebner <heiko@sntech.de>, Lukasz Majewski <l.majewski@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Darren Hart <dvhart@infradead.org>, lm-sensors@lm-sensors.org

On Fri 2015-07-24 15:49:41, Guenter Roeck wrote:
> On 07/24/2015 03:11 PM, Pavel Machek wrote:
> >On Fri 2015-07-24 06:59:26, Guenter Roeck wrote:
> >>On 07/23/2015 11:29 PM, Sascha Hauer wrote:
> >>>On Thu, Jul 23, 2015 at 02:07:59PM +0200, Pavel Machek wrote:
> >>>>On Tue 2015-07-21 09:21:32, Sascha Hauer wrote:
> >>>>>The thermal code uses int, long and unsigned long for temperatures
> >>>>>in different places.
> >>>>>
> >>>>>Using an unsigned type limits the thermal framework to positive
> >>>>>temperatures without need. Also several drivers currently will report
> >>>>>temperatures near UINT_MAX for temperatures below 0=B0C. This will p=
robably
> >>>>>immediately shut the machine down due to overtemperature if started =
below
> >>>>>0=B0C.
> >>>>>
> >>>>>'long' is 64bit on several architectures. This is not needed since I=
NT_MAX =B0mC
> >>>>>is above the melting point of all known materials.
> >>>>
> >>>>Can we do something like
> >>>>
> >>>>typedef millicelsius_t int;
> >>>>
> >>>>...to document the units?
> >>>
> >>>I am not very fond of typedefs and I am not sure this adds any value. I
> >>>could change it when more people ask for it, but I just sent the new
> >>>version without this.
> >>>
> >>
> >>I thought we are supposed to not introduce new typedefs anyway.
> >
> >You are not supposed to typedef struct, but typedef for millicelsius_t
> >would be ok. And it is your only chance if you want people to pay
> >attention. If you make it int, someone will pass it to long or
> >something else..
>=20
> Seems to me that would be just lazyness. The same person might use 'long'
> even if millicelsius_t is defined. A typedef doesn't preclude people
> from ignoring it.

Well,  millicelsius_t will tell people that this is temperature, and
being "special" type, they'll try to preserve it. (And you could check
with sparse if you really wanted). int and long are common enough so
that people will not notice...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
