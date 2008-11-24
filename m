From: Noel David Torres =?iso-8859-1?q?Ta=F1o?= <envite@rolamasao.org>
Date: Mon, 24 Nov 2008 19:27:12 +0000
Subject: [lm-sensors] Help with configuration on k7s41
Message-Id: <200811242027.19080.envite@rolamasao.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6241665728958018618=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6241665728958018618==
Content-Type: multipart/signed; boundary="nextPart1802825.95eTUiVS49";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1802825.95eTUiVS49
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Please CC me, I'm not suscribed.

I'm using your program with almost no problem in one of my computers (many =
thanks), but I have these results in the other one:

w83697hf-isa-0290
Adapter: ISA adapter
VCore:       +1.57 V  (min =3D  +1.71 V, max =3D  +1.89 V)   ALARM
+3.3V:       +3.22 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:         +4.89 V  (min =3D  +4.76 V, max =3D  +5.24 V)
+12V:       +11.49 V  (min =3D +10.82 V, max =3D +13.19 V)
=2D12V:        +0.72 V  (min =3D -13.18 V, max =3D -10.80 V)   ALARM
=2D5V:         +1.94 V  (min =3D  -5.25 V, max =3D  -4.75 V)   ALARM
V5SB:        +5.38 V  (min =3D  +4.76 V, max =3D  +5.24 V)   ALARM
VBat:        +3.36 V  (min =3D  +2.40 V, max =3D  +3.60 V)
fan1:          0 RPM  (min =3D 2163 RPM, div =3D 8)  ALARM
fan2:       2812 RPM  (min =3D 1875 RPM, div =3D 8)
temp1:       +35.0=B0C  (high =3D +70.0=B0C, hyst =3D +64.0=B0C)  sensor =
=3D thermistor
temp2:       +37.5=B0C  (high =3D +120.0=B0C, hyst =3D +120.0=B0C)  sensor =
=3D thermistor
beep_enable:enabled

It is running, so I suppose all these ALARMs are false.

Could you help me configuring the /etc/sensors3.conf ?

The motherboard is an ASROCK K7S41

Thanks

Noel Torres "Envite"

--nextPart1802825.95eTUiVS49
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkrABQACgkQcLQA8+7Hw3Kn6ACghCSS/d96BqeZCeudo8C2X4/1
h7UAn0Lira2iQHQxNhSfOai3LawbuvEx
=Du9F
-----END PGP SIGNATURE-----

--nextPart1802825.95eTUiVS49--


--===============6241665728958018618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6241665728958018618==--
