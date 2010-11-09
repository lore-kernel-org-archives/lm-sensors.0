From: Simon Guinot <simon@sequanux.org>
Date: Tue, 09 Nov 2010 09:25:25 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) Fix fan_ctrl_init error
Message-Id: <20101109092525.GC32648@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0311965424942720899=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1289279919.14461.7.camel@mola>
 <20101109090147.155dd1e9@endymion.delvare>
 <AANLkTim9mNy+ocftWn0ZiGPyefjhc-eXj3gunFw1Q04s@mail.gmail.com>
In-Reply-To: <AANLkTim9mNy+ocftWn0ZiGPyefjhc-eXj3gunFw1Q04s@mail.gmail.com>
To: Axel Lin <axel.lin@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Simon Guinot <sguinot@lacie.com>, lm-sensors@lm-sensors.org


--===============0311965424942720899==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 09, 2010 at 04:22:02PM +0800, Axel Lin wrote:
> 2010/11/9 Jean Delvare <khali@linux-fr.org>:
> > On Tue, 09 Nov 2010 13:18:39 +0800, Axel Lin wrote:
> >> Remove sysfs entries before return -ENODEV.
> >>
> >> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> >> ---
> >> =C2=A0drivers/hwmon/gpio-fan.c | =C2=A0 =C2=A04 +++-
> >> =C2=A01 files changed, 3 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> >> index aa701a1..d2e66b4 100644
> >> --- a/drivers/hwmon/gpio-fan.c
> >> +++ b/drivers/hwmon/gpio-fan.c
> >> @@ -388,11 +388,13 @@ static int fan_ctrl_init(struct gpio_fan_data *f=
an_data,
> >> =C2=A0 =C2=A0 =C2=A0 fan_data->speed_index =3D get_fan_speed_index(fan=
_data);
> >> =C2=A0 =C2=A0 =C2=A0 if (fan_data->speed_index < 0) {
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -ENODEV;
> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_free_gpio;
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_remove_sysfs;
> >> =C2=A0 =C2=A0 =C2=A0 }
> >>
> >> =C2=A0 =C2=A0 =C2=A0 return 0;
> >>
> >> +err_remove_sysfs:
> >> + =C2=A0 =C2=A0 sysfs_remove_group(&pdev->dev.kobj, &gpio_fan_ctrl_gro=
up);
> >> =C2=A0err_free_gpio:
> >> =C2=A0 =C2=A0 =C2=A0 for (i =3D i - 1; i >=3D 0; i--)
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_free(ctrl[i]);
> >
> > Oh, and while you're here, fan_alarm_init() needs some love as well.
> > There's a "return 0" in the middle which clearly can't be correct.
> I think this part is correct. see the comment:
>         /*
>          * If the alarm GPIO don't support interrupts, just leave
>          * without initializing the fail notification support.
>          */
>=20

Yes, GPIO interrupts could not be supported. That's not an error case.

Simon

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzZE4UACgkQgtp0PDeOcDqOXQCgnCjAkgy0AaTNuIZGomQyc4nV
AdoAnjsydFGAbXu/PtzfYeGZ6HK3Q00Y
=QcAD
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--


--===============0311965424942720899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0311965424942720899==--
