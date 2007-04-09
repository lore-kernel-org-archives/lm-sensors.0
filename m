From: Bob =?ISO-8859-1?Q?Schl=E4rmann?= <bob2@dsv.nl>
Date: Mon, 09 Apr 2007 18:31:11 +0000
Subject: Re: [lm-sensors] dynamic chip support in libsensors + generic chip
Message-Id: <20070409203111.75eb47ff@ws01.atreidis.nl.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <461A59D4.2050409@hhs.nl>
In-Reply-To: <461A59D4.2050409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 09 Apr 2007 17:20:52 +0200
Hans de Goede <j.w.r.degoede@hhs.nl> wrote:

> ...
> So please test this:
> 1) checkout the 3.0.0 branch:
>     svn checkout
> http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0 2)
> comment the entries for your chips int he table at the end of
> lib/chips.c and in the table near the end of progs/sensors/main.c 3)
Note that this isn't needed if you give sensors the -g argument. This
forces sensors to use the generic printing routines.

> compile and install as usual 4) run sensors and let me/us know how it
> works
>=20
> Regards,
>=20
> Hans
>=20
>=20
> p.s.
>=20
> I'm planning on doing several cleanups of the code as submitted the
> coming few days, as time permits. Plans so far:
> -cleanup the regex used to see if a sysfs entry actual is a sysfs
> sensor file, so that it doesn't match everything (including entries
> like: uevent, modalias, etc), but only matches the actual known /
> document sysfs sensor files -cleanup the new sensors_feature_get_type
> to be much more robust / do much exacter matching
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>=20
> !DSPAM:461a569c75901200214150!
>=20

--
Bob Schl=E4rmann

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
