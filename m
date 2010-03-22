From: Denny Schierz <linuxmail@4lin.net>
Date: Mon, 22 Mar 2010 21:14:07 +0000
Subject: [lm-sensors] G760A not working korrekt on NAS dlink 323 HW C1
Message-Id: <1269292447.6810.21.camel@kusanagi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0163714215542012748=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============0163714215542012748==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-t2f5mmJXpWkSjKeDWDIY"


--=-t2f5mmJXpWkSjKeDWDIY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi

I have a NAS from D-Link called DNS-323=C2=B9 and it has a fan controller
G760A. the hardware revision ist C1. My problem is, after starting the
kernel (2.6.33.1 (* in .config, nit [M] ), the fan stops. I'm not able
to activate him, with echo, like:

nas:~# cat /sys/class/hwmon/hwmon0/device/pwm1
18

echo 0 >  /sys/class/hwmon/hwmon0/device/pwm1
nas:~# cat /sys/class/hwmon/hwmon0/device/pwm1
18


echo 255 >  /sys/class/hwmon/hwmon0/device/pwm1
nas:~# cat /sys/class/hwmon/hwmon0/device/pwm1
18

I do not know, what could be the problem, so I hope, anybody knows the
problem:

nas:~# sensors
g760a-i2c-0-3e
Adapter: mv64xxx_i2c adapter
fan1:       2073 RPM  ALARM

lm75-i2c-0-48
Adapter: mv64xxx_i2c adapter
temp1:       +48.5 C  (high =3D +80.0 C, hyst =3D +75.0 C)

=C2=B9 http://www.cyrius.com/debian/orion/d-link/dns-323/specs.html

The revision C1 seems to be a little different, but I don't know, how
can I figure out this.

Any suggestions?

cu denny

--=-t2f5mmJXpWkSjKeDWDIY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkun3ZsACgkQKlzhkqt9P+D6rgCeMuuhOC0oWK2cHSJwAyWDQdV1
+6gAoJ8dp9pN5fXRPUt/z8sR79nUlPKM
=eJ6i
-----END PGP SIGNATURE-----

--=-t2f5mmJXpWkSjKeDWDIY--



--===============0163714215542012748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0163714215542012748==--

