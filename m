From: Simon Guinot <simon@sequanux.org>
Date: Thu, 21 Oct 2010 22:35:55 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: add generic GPIO fan driver
Message-Id: <20101021223555.GT29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1503565271719225106=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1287592646-18109-1-git-send-email-sguinot@lacie.com>
	<1287592646-18109-2-git-send-email-sguinot@lacie.com>
	<20101021064145.GA25095@ericsson.com>
	<20101021140626.GQ29120@kw.sim.vm.gnt>
	<20101021144346.GA26460@ericsson.com>
	<20101021215928.GS29120@kw.sim.vm.gnt>
	<1287699373.9690.360.camel@groeck-laptop>
In-Reply-To: <1287699373.9690.360.camel@groeck-laptop>
To: linux-arm-kernel@lists.infradead.org


--===============1503565271719225106==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G2d+m75Tjo442KmM"
Content-Disposition: inline


--G2d+m75Tjo442KmM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 21, 2010 at 03:16:13PM -0700, Guenter Roeck wrote:
> Hi Simon,
>=20
> On Thu, 2010-10-21 at 17:59 -0400, Simon Guinot wrote:
> > Hi Guenter,
> >=20
> > On Thu, Oct 21, 2010 at 07:43:46AM -0700, Guenter Roeck wrote:
> > > > >=20
> > > > > The combination of DIV_ROUND_UP() and DIV_ROUND_CLOSEST() causes =
inconsistency.
> > > > >=20
> > > > > Assume num_speed =3D 8, pwm is set to 128.
> > > > >=20
> > > > > set: 128 * (8 - 1) / 255 =3D 3.513 =3D=3D> 4
> > > > > get: 4 * 255 / (8 - 1) =3D 145.7 =3D=3D> 146
> > > > > set: 146 * (8 - 1) / 255 =3D 4.007 =3D=3D> 5
> > > > > get: 5 * 255 / (8 - 1) =3D 182.142 =3D=3D> 182
> > > > > set: 182 * (8 - 1) / 255 =3D 4.996 =3D=3D> 5
> > > > >=20
> > > > > Unless there is a really good reason to use DIV_ROUND_UP(), you m=
ight
> > > > > want to use DIV_ROUND_CLOSEST() instead.
> > > >=20
> > > > This choice is coherent with the rpm interface one and the reason i=
s the
> > > > same: start the fan even with a low value. In your example, 36 is f=
irst
> > > > speed threshold.
> > > >=20
> > > Yes, but here it causes an inconsistency between setting and reportin=
g.
> > > I don't expect the speed to change if I set the same value that was r=
ead.
> > > Exactly this happens if one writes 146 in my example. That is much wo=
rse
> > > than a potential startup problem, or the observation that pwm values =
below X=20
> > > don't start the fan.
> >=20
> > Mmm. Convert a speed index into a low round pwm value (and not use
> > DIV_ROUND_CLOSEST() at all) fix the inconsistency too. If you agree,
> > I would prefer this option.
>=20
> Ok if it works. I am mostly concerned about inconsistencies.=20
>=20
> Not sure I understand what you mean with "low round pwm value", though.

I mean not using DIV_ROUND_CLOSEST() in the show_pwm() function:

u8 pwm =3D fan_data->speed_index * 255 / (fan_data->num_speed - 1);

I will send an updated version of the patch. This should address your
last comments.

Thanks,

Simon

--G2d+m75Tjo442KmM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzAwEsACgkQgtp0PDeOcDpn6QCfcgh4ty45Jt0Qb2ClKcnJogES
1M8AoI4QJqfCGxBpyCLu0+HkSk8xYp52
=nYMZ
-----END PGP SIGNATURE-----

--G2d+m75Tjo442KmM--


--===============1503565271719225106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1503565271719225106==--
