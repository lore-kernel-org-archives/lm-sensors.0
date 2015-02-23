From: Simon Guinot <simon.guinot@sequanux.org>
Date: Mon, 23 Feb 2015 14:40:49 +0000
Subject: Re: [lm-sensors] [PATCH] ARM: Kirkwood: enable GPIO fan alarm support for 2Big Network v2
Message-Id: <20150223144049.GU1509@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6410715148481879304=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696523-14855-1-git-send-email-simon.guinot@sequanux.org>
 <54EB34F3.4000500@roeck-us.net>
In-Reply-To: <54EB34F3.4000500@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org


--===============6410715148481879304==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mFM6r0jQWo48NPCK"
Content-Disposition: inline


--mFM6r0jQWo48NPCK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2015 at 06:10:59AM -0800, Guenter Roeck wrote:
> On 02/23/2015 05:02 AM, Simon Guinot wrote:
> >On the LaCie 2Big Network v2 (net2big_v2) board, the fan alarm is not
> >wired to the I2C fan controller but to a separe GPIO. This GPIO can be
> >controlled by using the gpio-fan driver.
> >
> >This patch adds the gpio-fan alarm description in the net2big_v2 DTS.
> >
> >Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> >---
> >  arch/arm/boot/dts/kirkwood-net2big.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/kirkwood-net2big.dts b/arch/arm/boot/dts/=
kirkwood-net2big.dts
> >index 53dc37a3b687..e4f7e497379f 100644
> >--- a/arch/arm/boot/dts/kirkwood-net2big.dts
> >+++ b/arch/arm/boot/dts/kirkwood-net2big.dts
> >@@ -27,6 +27,11 @@
> >  		device_type =3D "memory";
> >  		reg =3D <0x00000000 0x10000000>;
> >  	};
> >+
> >+	gpio_fan {
> >+		compatible =3D "gpio-fan";
> >+		alarm-gpios =3D <&gpio0 25 GPIO_ACTIVE_LOW>;
> >+	};
> >  };
> >
> >  &regulators {
> >
> Again, wrong solution, and conceptually wrong as well from a dt perspecti=
ve.
>=20
> The alarm signal should be handled by the g762 driver, and the alarm-gpios
> property should be added to the g762 description.

OK. Then you think it would be better to add support for alarm GPIOs
support in the g762. The problem is that we should have to find a
generic way to do that. After all, we could want the very same
modification for a bunch of fan drivers.

Simon

--mFM6r0jQWo48NPCK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlTrO/EACgkQgtp0PDeOcDo9hQCfRX08vn2NaG0Cs5KXjvcIGDrE
hj8AoJ8Jv4+6Ds/DsKnaBcqr+sZjuMG0
=TDc0
-----END PGP SIGNATURE-----

--mFM6r0jQWo48NPCK--


--===============6410715148481879304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6410715148481879304==--
