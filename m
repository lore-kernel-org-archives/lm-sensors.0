From: Simon Guinot <simon@sequanux.org>
Date: Tue, 12 Oct 2010 08:05:56 +0000
Subject: Re: [lm-sensors] hwmon and GPIO fan
Message-Id: <20101012080556.GE13596@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4303839805063922351=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101011142558.GD13596@kw.sim.vm.gnt>
In-Reply-To: <20101011142558.GD13596@kw.sim.vm.gnt>
To: lm-sensors@vger.kernel.org


--===============4303839805063922351==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 11, 2010 at 04:45:32PM +0200, Jean Delvare wrote:
> Salut Simon,
>=20
> On Mon, 11 Oct 2010 14:25:58 +0000, Simon Guinot wrote:
> > I am currently looking to add hwmon support for the fan device found on
> > Network Space Max v2 boards (ARM Kirkwood SoC).
> >=20
> > The fan speed can be configured trough GPIOs. The GPIO settings allow to
> > change the fan input voltage (via some resistors).
> > After a quick look at the hwmon sysfs interface, I have failed to find
> > the appropriate way to expose a non-pwm fan. If any, what is the
> > dedicated sysfs entry to set speed for a non-pwm fan ?
> > Maybe that a fake pwm interface is needed ?
>=20
> Don't let yourself be fooled by the "pwm[1-n]" and "pwm[1_n]_enable"
> files names. These are valid for all fan control outputs, be they PWM
> or DC. As a matter of fact, "pwm[1-n]_mode" lets you advertise whether
> the controller is using PWM or DC.
>=20
> All that really matters is that you use 0-255 as the pwm[1-n] range
> matching 0-100%.

Thank you.

Simon

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky0FuQACgkQgtp0PDeOcDo05ACfQNWNm+W1es6EYxmIAqtRXnT+
4REAoIwESXMCDuP6737a9ZKxmlsWqdok
=WbQ5
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--


--===============4303839805063922351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4303839805063922351==--
