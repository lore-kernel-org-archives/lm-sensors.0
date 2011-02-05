From: Hans-Joachim Baader <hjb@pro-linux.de>
Date: Sat, 05 Feb 2011 14:57:14 +0000
Subject: [lm-sensors] Config for QNAP TS-509
Message-Id: <20110205145714.GH29679@kilauea.hjbaader.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7633110134344864661=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============7633110134344864661==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I just configured my QNAP TS-509 NAS and I'm happy to share the results
with you. Hopefully they find their way into the Wiki (I don't have an acco=
unt).
I think the original QNAP firmware doesn't use lm-sensors, so I had to
try myself.

System: Debian Squeeze
Kernel: 2.6.32
Drivers: coretemp, it87

Board info:
        Manufacturer: QNAP
        Product Name: TS-509-Q025MB(T187)
        Version: V1.00

Config:

chip "it87-*" "it8712-*" "it8716-*" "it8718-*" "it8720-*"

    label in0   " CPU Core"
    label in1   "  +1.80V"
    label in2   "  +3.30V"
    label in3   "  +5.00V"
    label in4   " +12.00V"
    label in5   "  +1.50V"
    label in6   "  +1.05V"
    label in7   "  +1.20V"
    label in8   "    Vbat"
    label temp1 "CPU Temp"
    label temp2 "SysTemp1"
    label temp3 "SysTemp2"
    label fan2  " SysFan1"

    compute in0  @ * (6 / 5),  @ / (6 / 5)
    compute in3  @ * (5 / 3),  @ / (5 / 3)
    compute in4  @ * (4 / 1),  @ / (4 / 1)

    set in0_max  1.25 * 1.05
    set in0_min  1.25 * 0.95
    set in1_max  1.8 * 1.05
    set in1_min  1.8 * 0.95
    set in2_max  3.3 * 1.05
    set in2_min  3.3 * 0.95
    set in3_max  5.0 * 1.05
    set in3_min  5.0 * 0.95
    set in4_max 12.0 * 1.05
    set in4_min 12.0 * 0.95
    set in5_max  1.5 * 1.05
    set in5_min  1.5 * 0.95
    set in6_max  1.05 * 1.05
    set in6_min  1.05 * 0.95
    set in7_max  1.2 * 1.05
    set in7_min  1.2 * 0.95

    set fan2_min 500

    set temp1_max 55
    set temp1_min 10
    set temp2_max 60
    set temp2_min 10
    set temp3_max 55
    set temp3_min 10

    ignore fan1
    ignore fan3
    ignore fan4
    ignore fan5


Some min and max values are a little arbitrary, and the calculation is
partly based on guessing. Change it if it doesn't work for you. If someone
has better data, please contribute!

Best regards,
hjb
--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFNTWVKLbySPj3b3eoRAiKoAJ9qG4EY1IH+yEwcGLKFHjtNlh5GpwCfQmJH
ArsmWp7CTPv9ir/AYyvY6Xo=
=ARZU
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--


--===============7633110134344864661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7633110134344864661==--
