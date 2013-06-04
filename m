From: Simon Guinot <simon.guinot@sequanux.org>
Date: Tue, 04 Jun 2013 21:23:07 +0000
Subject: Re: [lm-sensors] [PATCHv2 1/3] Add support for GMT G762/G763 PWM fan controller
Message-Id: <20130604212306.GL7626@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0940694951417386619=="
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1369687670.git.arno@natisbad.org>
 <b44f55c4194f6cd8c94f8a3d63ad5c8bd1d1cfe0.1369687670.git.arno@natisbad.org>
 <20130531221616.GG7626@kw.sim.vm.gnt>
 <87fvx1pwrl.fsf@natisbad.org>
 <20130602215904.GH7626@kw.sim.vm.gnt>
 <87sj0yz7tv.fsf@natisbad.org>
In-Reply-To: <87sj0yz7tv.fsf@natisbad.org>
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Nicolas Perrin <nperrin@lacie.com>, Guenter Roeck <linux@roeck-us.net>


--===============0940694951417386619==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z1Z8UV8BNhgCynIS"
Content-Disposition: inline


--Z1Z8UV8BNhgCynIS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2013 at 08:52:12AM +0200, Arnaud Ebalard wrote:
> Hi Simon,
>=20
> Simon Guinot <simon.guinot@sequanux.org> writes:
>=20
> > On Sat, Jun 01, 2013 at 07:26:54PM +0200, Arnaud Ebalard wrote:
> >> Hi Simon and Guenter,
> >>=20
> >> Simon Guinot <simon.guinot@sequanux.org> writes:
> >>=20
> >> > On Tue, May 28, 2013 at 12:03:14AM +0200, Arnaud Ebalard wrote:
> >> >>=20
> >> >> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> >> >> ---
> >> >>  drivers/hwmon/Kconfig              |   10 +
> >> >>  drivers/hwmon/Makefile             |    1 +
> >> >>  drivers/hwmon/g762.c               | 1012 ++++++++++++++++++++++++=
++++++++++++
> >> >>  include/linux/platform_data/g762.h |   54 ++
> >> >>  4 files changed, 1077 insertions(+)
> >> >>  create mode 100644 drivers/hwmon/g762.c
> >> >>  create mode 100644 include/linux/platform_data/g762.h
> >> >
> >> > Hi Arnaud,
> >> >
> >> > After more tests on my 2Big Network v2 board, it appears that the fan
> >> > doesn't rotate when PWM mode (the preferred operating mode for this
> >> > board) is selected. Nevertheless, DC mode is usable (even if not ide=
al
> >> > given the hardware). After some investigations I noticed that an ext=
ra
> >> > initialization is needed to enable PWM mode on my board: the set_cnt
> >> > register must be set to 0 while the default value is 0xff. Is that
> >> > specific to my hardware ? Is PWM mode working on your ReadyNAS with
> >> > the default set_cnt value ?
> >>=20
> >> First, thanks for testing this!
> >>=20
> >> Regarding your problem, I first started by booting current version of =
my
> >> driver on the Duo v2 w/o touching chip registers (only clock reference
> >> value). This way, I inherit the values installed by (NETGEAR's) u-boot:
> >>=20
> >> $ for k in fan* pwm* ; do echo -n "$k:" ; echo `cat $k `; done
> >> fan1_alarm:0
> >> fan1_div:2
> >> fan1_fault:0
> >> fan1_input:1807
> >> fan1_target:1807
> >> pwm1:221
> >> pwm1_enable:2        /* closed-loop, i.e. config is done via set_cnt */
> >> pwm1_mode:1          /* PWM mode */=20
> >
> > Sorry, I realize that I have not been very accurate in my description of
> > the problem: The fan doesn't rotate when PWM _and_ open-loop control are
> > selected. On the 2Big2 board, 2 wires are used to drive the fan.
> >
> > Then with pwm1_mode=3D1, pwm1_enable=3D1 and set_cnt=3D0xff (default va=
lue),
> > nothing happen whatever the value I write in pwm1.
>=20
> After boot, with set_cnt and set_out untouched by me (set_cnt set to
> 0x5a by u-boot, i.e. 255-0x5a read on pwm1):
>=20
> fan1_alarm:0
> fan1_div:1
> fan1_fault:0
> fan1_input:1365
> fan1_target:1365
> pwm1:0                  /* set_out is 0 (considering fan1_target,
>                            set_cnt is 0x5a)*/
> pwm1_enable:2           /* closed-loop */
> pwm1_mode:0             /* DC mode */
>=20
> # echo 1 > pwm1_mode    /* PWM mode */       # fan rotates=20
> # echo 1 > pwm1_enable  /* open-loop */      # fan stops rotating
>=20
> At that point we have:
>=20
> fan1_alarm:0
> fan1_div:1
> fan1_fault:0
> fan1_input:0
> fan1_target:1365
> pwm1:0                  /* set_out is 0, set_cnt is still 0x5a */
> pwm1_enable:1
> pwm1_mode:1
>=20
> Then:
>=20
> # echo 100 > pwm1                            # fan rotates

OK you are lucky. Your bootloader initialize set_cnt with 0x5a. Mine
don't and it is precisely the issue: set_cnt is still 0xff (the default
value) when the driver controls the fan.

Please, could you try open-loop mode with set_cnt set to 0xff ?  Maybe
you can enforce this value for the test purpose ?

If you observe the same behaviour than me, then could modify the driver
to ensure that set_cnt is not 0xff when open-loop mode is selected ?
Maybe by systematically setting a different value (as 0) ?

>=20
>=20
> > By testing, I have discovered that writing 0 into set_cnt allows to work
> > around the issue. I can do this by using the closed-loop control:
> > pwm1_mode=3D1, pwm1_enable=3D2 and pwm=3D255. Now, set_cnt worths 0 and=
 if I
> > switch back to open-loop control, all works as expected.
> >
> > Can you try open-loop control and PWM mode with your board ? I wonder if
> > this issue is specific to the 2Big2 hardware.
>=20
> AFAICT, set_cnt has never been set to 0 in my test and PWM+open-loop
> works as expected, i.e. just by setting a non-zero value in set_out.
> Tell me if I missed something or if you want me to perform another
> test.

Actually, I have only problems when set_cnt worths 0xff. Please, could
you try the tests mentioned above ?

Thanks in advance,

Simon

>=20
> Cheers,
>=20
> a+
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--Z1Z8UV8BNhgCynIS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGuWroACgkQgtp0PDeOcDqrCQCeLRyl+c1GMrSwkYwgMiWR7UCW
9voAoIyAnw/tRfe4GD/7Zb9w5jqzeVZf
=BrEr
-----END PGP SIGNATURE-----

--Z1Z8UV8BNhgCynIS--


--===============0940694951417386619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0940694951417386619==--
