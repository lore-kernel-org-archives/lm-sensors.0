From: Simon Guinot <simon.guinot@sequanux.org>
Date: Thu, 25 Apr 2013 10:14:50 +0000
Subject: Re: [lm-sensors] [PATCHv1 1/3] hwmon: Add support for GMT G762/G763 PWM fan controller
Message-Id: <20130425101450.GD17771@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4741637977058477946=="
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366753420.git.arno@natisbad.org>
 <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
 <20130424053758.GC8710@lunn.ch>
 <87obd4wb4e.fsf@natisbad.org>
 <20130424133856.GA18851@roeck-us.net>
 <87li878ygw.fsf@natisbad.org>
 <20130424224731.GB7767@roeck-us.net>
In-Reply-To: <20130424224731.GB7767@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnaud Ebalard <arno@natisbad.org>, Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>


--===============4741637977058477946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2013 at 03:47:31PM -0700, Guenter Roeck wrote:
> On Wed, Apr 24, 2013 at 10:28:47PM +0200, Arnaud Ebalard wrote:
> > Hi,
> >=20
> > Guenter Roeck <linux@roeck-us.net> writes:
> >=20
> > >> > You could consider using regmap for holding this cache.
> > >> >
> > >> > http://elceurope2012.sched.org/event/100619b669ce5767341624253aa03=
659?iframe=3Dno&w=3D900&sidebar=3Dyes&bg=3Dno#.UXdspHLQ5jM
> > >> >
> > >> > http://elinux.org/ELCE_Europe_2012_Presentations
> > >>=20
> > >> Interesting. As I am not yet familiar w/ regmap I would prefer having
> > >> the driver accepted during merge window with current data structure =
and
> > >> then convert it to regmap. But I will take a look (e.g. will study
> > >> fca1dd03 for instance). Thanks for the pointers.=20
> > >>=20
> > > I have not had time for a detailed review, but adding regmap support
> > > will not be a requirement.
> > >
> > > Note that it is too late for 3.10, so the driver will have to wait for
> > > 3.11.
> >=20
> > Well, I think I can live with it; The only bad thing is that it kills my
> > excuses not to spend time on regmap ;-)
> >=20
> Your call.
>=20
> >=20
> > >> >> +/*
> > >> >> + * Helpers to import hardware characteristics from .dts file and=
 overload
> > >> >> + * default config values.
> > >> >> + */
> > >> >> +
> > >> >> +#ifdef CONFIG_OF
> > >> >
> > >> > Can the driver be used without device tree? Would it be simpler to
> > >> >  just add depends OF in the Kconfig entry?
> > >>=20
> > >> It can be used if the default params (or those configured by u-boot I
> > >> guess) fit your needs. I think it would be fairly easy to extend the
> > >> driver later to expose g762_config struct to allow parameters to be =
set
> > >> w/o using OF. If someone wants to do that, I think it is better to n=
ot
> > >> depend on OF in Kconfig at the moment but I have not strong argument
> > >> other that that one. I'll let you decide.
> > >>=20
> > > Agreed. As long as there are major platforms not supporting device tr=
ee,
> > > and as long as device tree overlays are not supported, it must not be=
 made
> > > mandatory. Especially for I2C and SPI devices I reserve the right to =
be able
> > > test the hardware on an X86 system and not require a reboot to do so.
> >=20
> > Understood. Following Simon's post, I think it's useful to implement
> > some init function for non DT-enabled platforms.=20
> >=20
> Sure, as long as Simon commits to test it and - if possible - to provide
> the necessary platform code.

Hi Guenter,

I commit to do whatever needed to have g762 support on the 2Big Network
v2 and 2Big NAS boards.

But note that I am can't test the options "pwm_enable" and "fan_target".
As we are using a two wire fan on this boards, this options are not
relevant.

Moreover except for the out_mode/pwm_mode setting, I am rather happy
with the default configuration.

Simon

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlF5AhoACgkQgtp0PDeOcDokAACdH2YGjFo/91YwNyozDTBGQ4fh
1XsAn0V+HMH2KdZsxWC/KVcfQDyqgrcR
=x6Ca
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--


--===============4741637977058477946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4741637977058477946==--
