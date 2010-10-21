From: Simon Guinot <simon@sequanux.org>
Date: Thu, 21 Oct 2010 21:59:29 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: add generic GPIO fan driver
Message-Id: <20101021215928.GS29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0293010740970995709=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1287592646-18109-1-git-send-email-sguinot@lacie.com>
	<1287592646-18109-2-git-send-email-sguinot@lacie.com>
	<20101021064145.GA25095@ericsson.com>
	<20101021140626.GQ29120@kw.sim.vm.gnt>
	<20101021144346.GA26460@ericsson.com>
In-Reply-To: <20101021144346.GA26460@ericsson.com>
To: linux-arm-kernel@lists.infradead.org


--===============0293010740970995709==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3bhLwMadv7h6/J9"
Content-Disposition: inline


--O3bhLwMadv7h6/J9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Thu, Oct 21, 2010 at 07:43:46AM -0700, Guenter Roeck wrote:
> > >=20
> > > The combination of DIV_ROUND_UP() and DIV_ROUND_CLOSEST() causes inco=
nsistency.
> > >=20
> > > Assume num_speed =3D 8, pwm is set to 128.
> > >=20
> > > set: 128 * (8 - 1) / 255 =3D 3.513 =3D=3D> 4
> > > get: 4 * 255 / (8 - 1) =3D 145.7 =3D=3D> 146
> > > set: 146 * (8 - 1) / 255 =3D 4.007 =3D=3D> 5
> > > get: 5 * 255 / (8 - 1) =3D 182.142 =3D=3D> 182
> > > set: 182 * (8 - 1) / 255 =3D 4.996 =3D=3D> 5
> > >=20
> > > Unless there is a really good reason to use DIV_ROUND_UP(), you might
> > > want to use DIV_ROUND_CLOSEST() instead.
> >=20
> > This choice is coherent with the rpm interface one and the reason is the
> > same: start the fan even with a low value. In your example, 36 is first
> > speed threshold.
> >=20
> Yes, but here it causes an inconsistency between setting and reporting.
> I don't expect the speed to change if I set the same value that was read.
> Exactly this happens if one writes 146 in my example. That is much worse
> than a potential startup problem, or the observation that pwm values belo=
w X=20
> don't start the fan.

Mmm. Convert a speed index into a low round pwm value (and not use
DIV_ROUND_CLOSEST() at all) fix the inconsistency too. If you agree,
I would prefer this option.

Thanks,

Simon

--O3bhLwMadv7h6/J9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzAt8AACgkQgtp0PDeOcDqUGACgkr2SAX88OrSp4yJEDEe50gmO
/pMAmwZq8URJ2iTdLEZdY7HgvydEt0XN
=1UAL
-----END PGP SIGNATURE-----

--O3bhLwMadv7h6/J9--


--===============0293010740970995709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0293010740970995709==--
