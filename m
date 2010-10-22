From: Simon Guinot <simon@sequanux.org>
Date: Fri, 22 Oct 2010 12:25:13 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: add generic GPIO fan driver
Message-Id: <20101022122513.GV29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2124424730381716176=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101021223555.GT29120@kw.sim.vm.gnt>
	<1287701059-2226-1-git-send-email-simon@sequanux.org>
	<1287712301.9690.376.camel@groeck-laptop>
In-Reply-To: <1287712301.9690.376.camel@groeck-laptop>
To: linux-arm-kernel@lists.infradead.org


--===============2124424730381716176==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ipiAXJWFVZGVDOzf"
Content-Disposition: inline


--ipiAXJWFVZGVDOzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Thu, Oct 21, 2010 at 06:51:41PM -0700, Guenter Roeck wrote:
> Hi Simon,
>=20
> On Thu, 2010-10-21 at 18:44 -0400, Simon Guinot wrote:
> > From: Simon Guinot <sguinot@lacie.com>
> >=20
> > This patch adds hwmon support for the GPIO connected fan.
> >=20
> I rephrased this to ".. for fans connected to GPIO pins."
>=20
> > Platform specific informations as GPIO pinout and speed conversion array
> > (rpm from/to GPIO value) are passed to the driver via platform_data.
> >=20
> > Signed-off-by: Simon Guinot <sguinot@lacie.com>
>=20
> [ ... ]
> > +static int __devinit gpio_fan_probe(struct platform_device *pdev)
> > +{
> > +       int err =3D 0;
>=20
> and this variable initialization is not needed.
>=20
> Otherwise looks good. Applied with the above changed to my -next tree.
>=20
> I'll let it rest there for a couple of days. Unless some unforeseen
> problems show up, it might just make it into .37.

Thanks for your help and your patience.

Simon

--ipiAXJWFVZGVDOzf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzBgqkACgkQgtp0PDeOcDosKgCgoliWBx7VuBp1L95HQRh8aNDv
p4IAn1bfQJX9a/+GlN65SduOndCQ5vQp
=NrWh
-----END PGP SIGNATURE-----

--ipiAXJWFVZGVDOzf--


--===============2124424730381716176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2124424730381716176==--
