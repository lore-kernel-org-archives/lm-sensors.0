From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jan 2012 15:21:46 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Add support for extra fan attributes
Message-Id: <20120113162146.45a04af7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120113155100.1e081f29@endymion.delvare>
In-Reply-To: <20120113155100.1e081f29@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 13 Jan 2012 07:13:36 -0800, Guenter Roeck wrote:
> On Fri, Jan 13, 2012 at 09:51:00AM -0500, Jean Delvare wrote:
> > Add support for fan[1-*]_max, fan[1-*]_min_alarm and fan[1-*]_max_alarm
> > attributes. These are defined in the standard sysfs interface for quite
> > some time, and at least three drivers (max6650, lm63 and applesmc)
> > implement them so we should support them.
> > ---
> >  doc/libsensors-API.txt |    3 +++
> >  lib/sensors.h          |    3 +++
> >  lib/sysfs.c            |    3 +++
> >  prog/sensors/chips.c   |   38 +++++++++++++++++++++++++-------------
> >  4 files changed, 34 insertions(+), 13 deletions(-)
> >=20
> Looks good.
>=20
> Maybe I should try to re-do that using the table based generic code. Wond=
er why I didn't earlier.

To be honest, I considered it first, and then saw that it was broken,
so we should fix it first. But lacking the time and energy to do that
today, I took the short path to where I needed to go.

The problem I see in the generic code is with power limits, "interval"
is considered a limit and will thus be printed with unit "W" instead of
"s". Likewise fan[1-*]_div would show up with unit RPM which is no
good. Apparently we need a way to force unit (or lack thereof) on a
per-limit basis. Maybe we can leverage the work done for temperatures
(=B0C vs. =B0F), but I'm not sure.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
