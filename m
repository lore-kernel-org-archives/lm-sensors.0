From: Simon Guinot <simon@sequanux.org>
Date: Tue, 19 Oct 2010 11:46:36 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <20101019114636.GF29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8658192711558531541=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
	<20101018203610.GD29120@kw.sim.vm.gnt>
	<20101018205034.GA10473@ericsson.com>
In-Reply-To: <20101018205034.GA10473@ericsson.com>
To: linux-arm-kernel@lists.infradead.org


--===============8658192711558531541==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Mon, Oct 18, 2010 at 01:50:34PM -0700, Guenter Roeck wrote:
> On Mon, Oct 18, 2010 at 04:36:10PM -0400, Simon Guinot wrote:
> [ ... ]
>=20
> > > I don't really understand the value of supporting pwm attributes,
> > > since you have to convert those to rpm anyway. Why not just stick
> > > with fan1_input and fan1_target ? This would simplify the code a lot.
> >=20
> > I don't know very well the hwmon API. I have simply been fooled by the
> > sysfs-interface document which claim that fan[1-*]_target only make
> > sense for a closed-loop fan. Moreover, I was expecting gpio-fan to be
> > compliant with the fancontrol shell script...
> >=20
> > But anyway, you are right. I just don't want the pwm interface.
> >=20
> If the fancontrol script doesn't support fanX_target, and a given fan=20
> doesn't support pwm, it might make sense to update it.=20
>=20
> Jean, any comments ?
>=20
> > > > +
> > > > +err_free_gpio:
> > > > +       for (i =3D i - 1; i >=3D 0; i--)
> > > > +               gpio_free(ctrl[i]);
> > > > +
> > > This misses the most recently allocated gpio pin if gpio_direction_ou=
tput() failed.
> >=20
> > The gpio is freed above while handling the gpio_direction_output() erro=
r.
> >=20
> I missed that. Thatks for the clarification.
>=20
> > > > +
> > > > +       dev_info(&pdev->dev, "GPIO fan initialized\n");
> > > > +
> > > Might be a good idea to add a notion of which fan was initialized.
> > > After all, there could be more than one.
> >=20
> > dev_info() don't do it for me ? anyway, I will check this too.
> >=20
> It probably does. Wonder what it actually shows. Can you check ?

If CONFIG_PRINTK is enabled, dev_info() end up in a dev_printk() call
with the level argument set to KERN_INFO.
The message format is:
${driver_name} ${device_name}: ${message}

Note that the device id number is part of the device name. So, if two
gpio-fan devices are initialized, you will see:

gpio-fan gpio-fan.0: GPIO fan initialized
gpio-fan gpio-fan.1: GPIO fan initialized

For a single fan device, you will see:

gpio-fan gpio-fan: GPIO fan initialized

Simon

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky9hRwACgkQgtp0PDeOcDpOgwCdGepqETQjM3dCcwI0E+RWrRau
KesAnA4m6BlTXU0M7tDW4N1kx9bPosYB
=y6DQ
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--


--===============8658192711558531541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8658192711558531541==--
