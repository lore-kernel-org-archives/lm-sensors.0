From: Simon Guinot <simon.guinot@sequanux.org>
Date: Wed, 25 Feb 2015 12:36:32 +0000
Subject: Re: [lm-sensors] [PATCH] ARM: Kirkwood: enable GPIO fan alarm support for 2Big Network v2
Message-Id: <20150225123632.GW1509@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6391635110584581724=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696523-14855-1-git-send-email-simon.guinot@sequanux.org>
 <54EB34F3.4000500@roeck-us.net>
 <20150223144049.GU1509@kw.sim.vm.gnt>
 <54EB3E0E.7070503@roeck-us.net>
In-Reply-To: <54EB3E0E.7070503@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org


--===============6391635110584581724==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b0bHyb0BmsSIM7d2"
Content-Disposition: inline


--b0bHyb0BmsSIM7d2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2015 at 06:49:50AM -0800, Guenter Roeck wrote:
> On 02/23/2015 06:40 AM, Simon Guinot wrote:
> >On Mon, Feb 23, 2015 at 06:10:59AM -0800, Guenter Roeck wrote:
> >>On 02/23/2015 05:02 AM, Simon Guinot wrote:
> >>>On the LaCie 2Big Network v2 (net2big_v2) board, the fan alarm is not
> >>>wired to the I2C fan controller but to a separe GPIO. This GPIO can be
> >>>controlled by using the gpio-fan driver.
> >>>
> >>>This patch adds the gpio-fan alarm description in the net2big_v2 DTS.
> >>>
> >>>Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> >>>---
> >>>  arch/arm/boot/dts/kirkwood-net2big.dts | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>>diff --git a/arch/arm/boot/dts/kirkwood-net2big.dts b/arch/arm/boot/dt=
s/kirkwood-net2big.dts
> >>>index 53dc37a3b687..e4f7e497379f 100644
> >>>--- a/arch/arm/boot/dts/kirkwood-net2big.dts
> >>>+++ b/arch/arm/boot/dts/kirkwood-net2big.dts
> >>>@@ -27,6 +27,11 @@
> >>>  		device_type =3D "memory";
> >>>  		reg =3D <0x00000000 0x10000000>;
> >>>  	};
> >>>+
> >>>+	gpio_fan {
> >>>+		compatible =3D "gpio-fan";
> >>>+		alarm-gpios =3D <&gpio0 25 GPIO_ACTIVE_LOW>;
> >>>+	};
> >>>  };
> >>>
> >>>  &regulators {
> >>>
> >>Again, wrong solution, and conceptually wrong as well from a dt perspec=
tive.
> >>
> >>The alarm signal should be handled by the g762 driver, and the alarm-gp=
ios
> >>property should be added to the g762 description.
> >
> >OK. Then you think it would be better to add support for alarm GPIOs
> >support in the g762. The problem is that we should have to find a
> >generic way to do that. After all, we could want the very same
> >modification for a bunch of fan drivers.
> >
> Can't help it. After all, the interrupt handling logic is different for e=
ach chip,
> and there are non-DT systems out there.
>=20
> The g762 property should probably be something like
>=20
> 	g762@3e {
>                 compatible =3D "gmt,g762";
>                 reg =3D <0x3e>;
>                 clocks =3D <&g762_clk>;
> 		interrupt-parent =3D <&gpio0>;
> 		interrupts =3D <25 GPIO_ACTIVE_LOW>;
>         };
>=20
> struct i2c_client has an irq field, and as far as I can see it is filled =
in
> automatically from the dt node. So all the driver should have to do is to
> implement an interrupt handler.

Is that OK to pass a GPIO line through the "interrupts" property ?
Moreover it seems to me that g763 controller (compatible) supports
alert interrupts through SMBus. Then maybe we should save the
"interrupts" property for this signal ?

Don't you think it would be more explicit to have a separate DT
property (such as "gpio-alarm") and also a dedicated field in the
g762 platform data structure ?

Simon

--b0bHyb0BmsSIM7d2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlTtwdAACgkQgtp0PDeOcDoGPgCfc+o/dCQ30gnfPQeqZxYrrQ11
KAUAni9kP2MazsYmicfaTaUeO6Itl6dm
=LFJk
-----END PGP SIGNATURE-----

--b0bHyb0BmsSIM7d2--


--===============6391635110584581724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6391635110584581724==--
