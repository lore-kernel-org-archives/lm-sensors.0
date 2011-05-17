From: Jan Wagner <waja@cyconet.org>
Date: Tue, 17 May 2011 09:33:44 +0000
Subject: Re: [lm-sensors] FAULT status of sensors
Message-Id: <201105171133.48391.waja@cyconet.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3610581193038570826=="
List-Id: <lm-sensors.vger.kernel.org>
References: <201105162023.54718.waja@cyconet.org>
In-Reply-To: <201105162023.54718.waja@cyconet.org>
To: lm-sensors@vger.kernel.org

--===============3610581193038570826==
Content-Type: multipart/signed;
  boundary="nextPart1546508.g8RzjYMLXs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1546508.g8RzjYMLXs
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

thanks for your bugreport.

On Tuesday 17 May 2011 09:36:00 Jean Delvare wrote:
> On Mon, 16 May 2011 19:32:52 -0700, Guenter Roeck wrote:
> > On Mon, May 16, 2011 at 02:23:44PM -0400, Jan Wagner wrote:
> > > we got a bugreport[1] against our nagios-plugins package. Unfortunate=
ly
> > > we are unsure about what "FAULT" means.
> > > In case this is a hardware problem of a sensor in form of it got
> > > damaged, we would report "CRITICAL", as a problem occured.
> > > If this means there is a problem detecting the sensor or something
> > > software like problem, we would report "UNKNOWN" as this not means a
> > > hardware problem happened.
> >=20
> > It is supposed to indicate a HW problem. Here is the text describing the
> > sysfs attribute:
> >=20
> > "Each input channel may have an associated fault file. This can be used
> >=20
> >  to notify open diodes, unconnected fans etc. where the hardware
> >  supports it. When this boolean has value 1, the measurement for that
> >  channel should not be trusted."
> >=20
> > Note that "critical" in the hwmon ABI means that a critical limit has
> > been reached. You would get a "critical" alarm in this case. You might
> > have a terminology problem if you use "critical" for a hardware failure.
> >=20
> > An undetected sensor should not show up in the first place.
>=20
> In fact, FAULT can happen in two different cases. First case (most
> common) is unused channel by the manufacturer and the channel should
> indeed be ignored. Second case is thermal diode dying or fan stalling,
> and reporting this makes sense. So I would:
> * Ignore sensor channels which report FAULT when you start monitoring.
> * Report FAULT as an actual problem if it happens later during
>   monitoring, for a channel which reported real values before. The
>   terminology is up to you.

(Jean: many thanks for your clarification)

This means, that FAULT can be happen, if the hardware conditions are fine a=
nd=20
hardware is failing too.

On Saturday 26 February 2011 00:07:22 Jonathan Wiltshire wrote:
> The attached patch causes check_sensors to return a critical status if
> faulty sensors are detected.

=46or nagios-plugins this means, we don't know if there is exactly a proble=
m. We=20
should report "UNKNOWN" via check_sensors if "FAULT" is reported by the=20
sensor. As the source of this may also not a problem with the hardware=20
conditions itself, something like --ignore-fault needs to be implemented to=
o.

With kind regards, Jan.
=2D-=20
Never write mail to <waja@spamfalle.info>, you have been warned!
=2D----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GIT d-- s+: a C+++ UL++++ P+ L+++ E--- W+++ N+++ o++ K++ w--- O M V- PS PE =
Y++
PGP++ t-- 5 X R tv- b+ DI D+ G++ e++ h---- r+++ y++++=20
=2D-----END GEEK CODE BLOCK------

--nextPart1546508.g8RzjYMLXs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQBN0kD49u6Dud+QFyQRAn3MAJ9Vi7h/VMdgD3VCcBcqPtik6b3VmQCg10tq
JQvIrl/ibIigdQ93mkMTXyI=
=sZ4o
-----END PGP SIGNATURE-----

--nextPart1546508.g8RzjYMLXs--


--===============3610581193038570826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3610581193038570826==--
