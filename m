From: Mark Brown <broonie@kernel.org>
Date: Sat, 16 Aug 2014 13:20:50 +0000
Subject: Re: [lm-sensors] power supply gating with ltc2978
Message-Id: <20140816132050.GH28623@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7551150336829097765=="
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.02.1408151623140.21645@atx-linux-37>
In-Reply-To: <alpine.DEB.2.02.1408151623140.21645@atx-linux-37>
To: atull <atull@opensource.altera.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>


--===============7551150336829097765==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X+8siUETKMkW99st"
Content-Disposition: inline


--X+8siUETKMkW99st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2014 at 04:34:49PM -0500, atull wrote:

> I am interested in adding functionality to be able to gate power supplies=
=20
> going through a ltc2978.  I see that there is a hwmon driver already=20
> existing (hwmon/pmbus/ltc2978.c).  I see some of the other hwmon drivers=
=20
> have MFD's.  It looks like this ltc driver would need a MFD and a=20
> regulator driver added.  However I don't see other pmbus hwmon drivers
> using MFD.

> So I am asking for recommendations and reservations on how to proceed her=
e=20
> before I get too far with this.

Without knowing anything at all about pmbus or this particular hardware
it's hard to comment but what you're saying here sounds sensible (though
I do see that apparently splitting the drivers may not actually be
sensible from Guenter's followup).

--X+8siUETKMkW99st
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT71qvAAoJELSic+t+oim9UtUQAILk6cTsI5EsOwTL3kJVu1h1
w1AfxlgenCdraYvyym7hAbdVWMiN0hO7tzpj4bOR+9kIdLufgzVzOK7irpiRxICs
mOCUz+de2vZAwaaRR/TDTmRKklnuZw00as516VAlI5d7PjPUe00QFsy+vfaADOds
dH7lIroVAj76cUMsgTEmYpxw8ZpgJS4Mh5KuDrG0BtT9mBvTttmZUTQOXz+ANEOk
/zSLCm2Vg9lFledplCKdAFCMqO452s4HlCJZMIO9tmM57/wyVN0sVcNXvAsl0WKc
Y6PzTLv72ONDB14+2vPKX4RWDXnmDWW8MxHscEaYK5/D7x1OepH0d/zCPvfRQ86T
4vQVIkDfQRX2cp46Fc3OJX4CxlUHS9rFByJ9LcgpKUoN7SDpI8UbCZPVwg8pqGWG
kiYqNxEqPZPlgC+dGeGvXMffypApXtOhFtX56IC03AIdP/3t90YoBjukmUQSbBZL
SGQvNTfXFvz0H6BICLABKBA+v7h+BYsLJWB/GrNT9W5hcKtGqrV/osMzQMH4afWj
aumeGocbpOf+DG9SJrLci6JBefakJdqRoQaw7mv8a5kQrKQiK5AVTNRZpMVJ2fUy
R3n98kAlF5hjakJfQoI12LiXPV7AUpnoff9Qxrjn2dDpsnXwRQApq6YUJj2/eLYA
NAwBJmMc1LJUQUPXILOH
=7gLL
-----END PGP SIGNATURE-----

--X+8siUETKMkW99st--


--===============7551150336829097765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7551150336829097765==--
