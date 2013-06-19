From: Simon Guinot <simon.guinot@sequanux.org>
Date: Wed, 19 Jun 2013 21:26:33 +0000
Subject: Re: [lm-sensors] [RESEND, PATCHv6 1/1] Add support for GMT G762/G763 PWM fan controllers
Message-Id: <20130619212633.GC7626@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3432062758687602039=="
List-Id: <lm-sensors.vger.kernel.org>
References: <87sj0jhuhn.fsf@natisbad.org>
 <20130617101948.GY7626@kw.sim.vm.gnt>
 <8761x9svpf.fsf@natisbad.org>
 <20130619205321.GA7625@roeck-us.net>
In-Reply-To: <20130619205321.GA7625@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnaud Ebalard <arno@natisbad.org>, Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>


--===============3432062758687602039==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dKeYJkA19bNVVKdr"
Content-Disposition: inline


--dKeYJkA19bNVVKdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 01:53:21PM -0700, Guenter Roeck wrote:
> On Wed, Jun 19, 2013 at 10:15:56PM +0200, Arnaud Ebalard wrote:
> > Hi Simon,
> >=20
> > Simon Guinot <simon.guinot@sequanux.org> writes:
> >=20
> > > I have tested this patch on my 2Big Network v2 board.
> > >
> > > Sometimes I get a weird "No such device" error while reading or writi=
ng
> > > the hwmon sysfs attributes. For example:
> > >
> > > # cat pwm1
> > > cat: read error: No such device
> > > # cat pwm1
> > > 0
> >=20
> This is odd, since ENODEV should not be returned as error code from i2c r=
ead
> operations.
>=20
> What is the i2c controller ?

The controller is the very same as for the ReadyNAS Duo v2. It is built
in the Marvell Kirkwood SoC and the driver is i2c-mv64xxx.

I will try an another board to see if I reproduce the error.

Regards,

Simon

>=20
> Thanks,
> Guenter
>=20
> > Weird, I cannot reproduce that at all on my ReadyNAS Duo v2.
> >=20
> > > Note, that if the same command is executed again (just after the faul=
ty
> > > one), then it will succeed most of the time. The errors seems to happ=
en
> > > quite randomly and not very often. I'd say one time over ten tries.
> > > I suppose this error is now visible due to the enhanced error path in
> > > g762_update_client. It looks like we learn something by checking the
> > > return value for i2c_smbus_read_byte_data :)
> > >
> > > Except that, all is working as expected. This new version fixes
> > > effectively open-loop driving when the set_cnt register is set to 0xf=
f.
> > >
> > > Also I am planning (hopefully this Wednesday) to test your patch on my
> > > 5Big Network v2 board. This last also embed a g762 controller but wit=
h a
> > > three wires fan instead. Then, I should be able to test the closed-lo=
op
> > > mode behaviour.
> >=20
> > Thanks for your tests, Simon.
> >=20
> > Cheers,
> >=20
> > a+=20
> >=20

--dKeYJkA19bNVVKdr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlHCIgkACgkQgtp0PDeOcDqrPgCfUajNe0ZTe+biXf+4Em8HEc70
fQsAn2WWO9TCwP++2hzQZYB/n5BxfbO8
=tpGH
-----END PGP SIGNATURE-----

--dKeYJkA19bNVVKdr--


--===============3432062758687602039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3432062758687602039==--
