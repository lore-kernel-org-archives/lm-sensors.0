From: Florian Echtler <echtler@in.tum.de>
Date: Mon, 30 Jul 2007 13:07:32 +0000
Subject: [lm-sensors] w83627dhg and coretemp temperature mismatch?
Message-Id: <1185800852.23876.91.camel@pancake>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8433658639449765786=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============8433658639449765786==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-mIudC2WZMTK6iGtBEIRy"


--=-mIudC2WZMTK6iGtBEIRy
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: quoted-printable

Hello everybody,

I have a Asus P5B-VM and after some fiddling and upgrading to 2.6.22, I
now have all thermal sensors (w83627dhg and coretemp) up and running.

However, I noticed that the readings from coretemp are always
significantly lower than those from the Winbond chip - an example:

w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:     +1.29 V  (min =3D  +0.85 V, max =3D  +1.60 V)=20
+12V:     +12.30 V  (min =3D +10.19 V, max =3D +13.46 V)=20
+3.3V:     +3.23 V  (min =3D  +2.98 V, max =3D  +3.63 V)=20
+5.0V:     +4.99 V  (min =3D  +4.51 V, max =3D  +5.50 V)=20
Sys Temp:    +51=C2=B0C  (high =3D   +16=C2=B0C, hyst =3D   +90=C2=B0C) =20
CPU Temp:  +50.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C) =20

coretemp-isa-0000
Adapter: ISA adapter
temp1:       +43=C2=B0C  (high =3D   +85=C2=B0C)                    =20

coretemp-isa-0001
Adapter: ISA adapter
temp1:       +42=C2=B0C  (high =3D   +85=C2=B0C)                    =20

As I have a passively-cooled CPU, I am a bit nervous about temperatures,
so I'm curious if somebody can explain the difference (and which one is
closer to reality ;-).

Thanks, Yours, Florian

PS: Please CC me, as I am not on the mailing list.

--=-mIudC2WZMTK6iGtBEIRy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGreKS7CzyshGvatgRAkIMAKDospZNGWPfQKWstSiht+/JSmIppACfZJOo
ukEel7D1Dt52gXsUn57HHuI=
=R0Jj
-----END PGP SIGNATURE-----

--=-mIudC2WZMTK6iGtBEIRy--



--===============8433658639449765786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8433658639449765786==--

