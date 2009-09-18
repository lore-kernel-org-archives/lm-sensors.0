From: Rodolfo Giometti <giometti@enneenne.com>
Date: Fri, 18 Sep 2009 11:02:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090918110217.GP19578@gundam.enneenne.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6846952036134773748=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
To: lm-sensors@vger.kernel.org


--===============6846952036134773748==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3bc47Eih9dS+biPM"
Content-Disposition: inline


--3bc47Eih9dS+biPM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2009 at 04:34:45PM +0200, Samuel Ortiz wrote:
> On Thu, Sep 17, 2009 at 03:34:50PM +0200, Jean Delvare wrote:
>=20
> > > @@ -1532,37 +1381,39 @@ static int __devinit w83627thf_read_gpio5(str=
uct platform_device *pdev)
> > >  	}
> > > =20
> > >  	dev_info(&pdev->dev, "Reading VID from GPIO5\n");
> > > -	res =3D superio_inb(W83627THF_GPIO5_DR) & sel;
> > > +	res =3D superio_inb(sio_data, W83627THF_GPIO5_DR) & sel;
> > > =20
> > >  exit:
> > > -	superio_exit();
> > > +	superio_exit(sio_data);
> > >  	return res;
> > >  }
> >=20
> > This looks wrong. The whole point of the MFD infrastructure is to
> > control who is accessing the common registers. Here you let the hwmon
> > driver access the Super-I/O configuration registers without any kind of
> > synchronisation. What if another user of w83627hf-core does the same at
> > the same moment?
> >=20
> > You need a way to protect common registers. You'll need a mutex, for
> > sure. Then you can either export this mutex and count on all "children"
> > drivers' cooperation to properly request and release it. Or you can
> > move all the code accessing the common registers into w83627hf-core,
> > and stop exporting the superio_* functions. I don't know if there is a
> > recommended practice for MFD drivers. Samuel?
> The recommended practice is definitely to have your register accessing
> routines defined from the MFD core. That's what all MFD drivers do.

Looking at chip's documentation I suppose I have to add a mutex and
then count on all "children" drivers' cooperation to properly request
and release the configuration register access. I cannot define
functions to manage such registers since a children may do several
reads/writes to complish its task.

> > > +	  This driver can also be built as a module.  If so, the module
> > > +	  will be called w83627hf-core.
> > > +
> >=20
> > Shouldn't this option be selected automatically by the w83627hf (hwmon)
> > driver? Currently it is possible to select only the hwmon driver, but
> > that driver will never work because the required platform driver won't
> > be created. This is a problem for current users upgrading to a new
> > kernel, as CONFIG_MFD_W83627HF defaults to N.
> >=20
> > But then again I don't know if there is already a policy regarding this
> > for MFD drivers. Samuel?
> If your subdevice driver is calling some of the MFD core routines, or if
> there's a platform dependency, then your subdevice driver (w83627hf in th=
at
> case) Kconfig should depend on MFD_W83627HF.

Ok!

Thanks for your suggestions,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it

--3bc47Eih9dS+biPM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqzaLkACgkQQaTCYNJaVjNAAQCg4qp9/5rxiwd2R4K+4dIxA3Z7
rTgAn0FbkTKXUWM30vIuF0qO7IJgCfzK
=Zdof
-----END PGP SIGNATURE-----

--3bc47Eih9dS+biPM--


--===============6846952036134773748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6846952036134773748==--
