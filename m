From: Eduardo Valentin <edubezval@gmail.com>
Date: Tue, 18 Nov 2014 00:01:36 +0000
Subject: Re: [lm-sensors] [PATCHv2 1/1] thermal: of: improve of-thermal sensor registration API
Message-Id: <20141118000133.GA10027@developer>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1267188432949536063=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1416263769-6578-2-git-send-email-edubezval@gmail.com>
 <1416264255-10083-1-git-send-email-edubezval@gmail.com>
 <546A8EA9.5070001@kapsi.fi>
In-Reply-To: <546A8EA9.5070001-/1wQRMveznE@public.gmane.org>
To: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Cc: Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>


--===============1267188432949536063==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Mikko,

On Tue, Nov 18, 2014 at 02:11:21AM +0200, Mikko Perttunen wrote:

<big cut>

> > diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegra_s=
octherm.c
> > index 70f7e9e..893c39c 100644
> > --- a/drivers/thermal/tegra_soctherm.c
> > +++ b/drivers/thermal/tegra_soctherm.c
> > @@ -317,6 +317,10 @@ static int tegra_thermctl_get_temp(void *data, lon=
g *out_temp)
> >   	return 0;
> >   }
> >
> > +static const struct thermal_zone_of_device_ops tegra_of_thermal_ops =
=3D {
> > +	.get_trend =3D tegra_thermctl_get_temp,
> > +};
>=20
> This should probably read ".get_temp =3D tegra_thermctl_get_temp" instead=
=20
> of .get_trend :)

Indeed. Sending in v3.

>=20
> > ...
>=20
> Cheers,
> Mikko
>=20

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUaoxTAAoJEMLUO4d9pOJWJAAH/2qZa9BRjOyRJafxzuMVJsPq
n7vOsR67hXnAL0EI44g6GB6EWHT9dKlFz9P/9oQsdnVxwYJJdyX4w956ZW3Lu2XO
uPc+6hwtkd/iFNs9weunfNG1UzRR/N+F4EDZJZwui8cCqstnhQKwp95LXxCxsj/S
pcEjKbntS12X24HB759xsfKRE5YFlZ2HzBL5MDOBSR71Y583lya5vwShJQ+uuwRc
7ZWaHV26Wy0wiBnAbdDwlXSnkLPt/1E4rsFpM/gfGK5H0aXwpDaOzLHbvllIYrqO
obXnaciSf0t1tODk1U6LrQiN944jbY4iSpaugwRx8g3ndNqPDzHT6E/paexIazs=
=KoFZ
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--


--===============1267188432949536063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1267188432949536063==--
