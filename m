From: Simon Guinot <simon@sequanux.org>
Date: Tue, 19 Oct 2010 19:30:43 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <20101019193043.GH29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5103806700655899638=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
	<20101018203610.GD29120@kw.sim.vm.gnt>
	<20101019065221.GA12406@ericsson.com>
	<20101019083656.GE29120@kw.sim.vm.gnt>
	<20101019151512.GB13908@ericsson.com>
In-Reply-To: <20101019151512.GB13908@ericsson.com>
To: linux-arm-kernel@lists.infradead.org


--===============5103806700655899638==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e5bfZ/T2xnjpUIbw"
Content-Disposition: inline


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Tue, Oct 19, 2010 at 08:15:12AM -0700, Guenter Roeck wrote:
> Hi Simon,
>=20
> On Tue, Oct 19, 2010 at 04:36:56AM -0400, Simon Guinot wrote:
>=20
> [ ... ]
>=20
> > /* Designed for fan 40x40x16: ADDA AD0412LB-D50 6000rpm@12v */
> > static struct gpio_fan_speed netspace_max_v2_fan_speed[] =3D {
> >         {    0,  0 },
> >         { 1500, 15 },
> >         { 1700, 14 },
> >         { 1800, 13 },
> >         { 2100, 12 },
> >         { 3100, 11 },
> >         { 3300, 10 },
> >         { 4300,  9 },
> >         { 5500,  8 },
> > };
> >=20
> > The function rpm_speed(index) is really not linear. I am not sure about
> > the resulting behaviour when this will be used by a userland fan control
> > process...
> >=20
> > If the pwm interface must be exported, I think we have to respect the
> > fan speed array. But as you said, maybe the work is rather on the
> > fancontrol script side.
> >=20
> Not sure if there is an expectation that the mapping pwm->speed has
> to be linear. One might as well argue that steps should be equally
> far apart to ensure that results are better predictable.
>=20
> > As a first step, we could keep the heavy pwm interface. Once the
> > fancontrol script (or something else) will be able to handle the rpm
> > attributes, we will drop the pwm compatibility.
> > Simply remove the gpio-fan pwm interface seems a good option too...
> >=20
> I think we should keep the pwm interface after all. Changing fancontrol
> is a possibility, but the change would take a while to make it upstream.

Yes, I understand. I will probably look soon into fancontrol.
Some of the cheapest LaCie board have a fan and no temperature sensors.
The embedded system get a more or less accurate temperature from the
hard drive sensor via SMART commands :)
I'd like to have some userspace fan support for this boards too.

>=20
> As for the actual code, I would prefer the simpler implementation, but I =
am willing=20
> to go with the complex one if you feel wtrongly about it. Only thing I wo=
uld ask you
> to do is to add an explanation of what is done and why.

Looking at the pwm_to_rpm() and rpm_to_pwm() functions, I can't feel
strongly a such implementation (but maybe wrongly).
So... I have changed my mind. The simpler implementation make sense:
the pwm value will simply map the speed index.
Moreover it appear to be very usable from a userspace point.

>=20
> Reminds me - you'll also have to provide Documentation/hwmon/gpio-fan.

Ok.

Thanks,

Simon

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky98eMACgkQgtp0PDeOcDr7cQCcDEYcxulrqrDHKgl5batuAFbb
HZgAn0ccLeGKVd0ijisJDAefJl7YySIt
=aX2O
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--


--===============5103806700655899638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5103806700655899638==--
