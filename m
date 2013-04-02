From: Paul Menzel <paulepanter@users.sourceforge.net>
Date: Tue, 02 Apr 2013 09:24:26 +0000
Subject: [lm-sensors] Nuvoton NCT5572D incorrectly detected as NCT6775F
Message-Id: <1364894666.7911.23.camel@mattotaupa>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3917410457934095576=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============3917410457934095576==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-NjXqXaWCW29idEuwrg1P"


--=-NjXqXaWCW29idEuwrg1P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(please CC me as I am not subscribed)


Dear Linux hwmon folks,


lately I was fooled to think my board ASRock E350M1 has a Nuvoton 6775F.

                w83627ehf: Found NCT6775F chip at 0x290

Then I was pointed out that it actually has a Nuvoton NCT 5572D and
looking at the board, this is actually written on the chip. Searching
for that on the Web this was confirmed too [1][2][3].

Should the Linux message be changed to the following?

        w83627ehf: Found NCT6775F (or NCT5572D) chip at 0x290

Is it planned to add support for that the NCT5572D?


Thanks,

Paul


[1] http://review.coreboot.org/gitweb?p=3Dcoreboot.git;a=3Dcommit;h=3D63896=
e75b42697a8898c0386c492091318cf5c82
[2] http://www.spinics.net/lists/lm-sensors/msg32057.html
[3] http://www.coreboot.org/pipermail/coreboot/2013-April/075596.html

--=-NjXqXaWCW29idEuwrg1P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlFao8oACgkQPX1aK2wOHVhKxQCfU7Syh5qukJDVQupiunUvKE0v
Rn8AoIGYfaAXMaGLzngSUuwGobnzZIzX
=4joX
-----END PGP SIGNATURE-----

--=-NjXqXaWCW29idEuwrg1P--



--===============3917410457934095576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3917410457934095576==--

