From: Jan Wagner <waja@cyconet.org>
Date: Mon, 16 May 2011 18:23:44 +0000
Subject: [lm-sensors] FAULT status of sensors
Message-Id: <201105162023.54718.waja@cyconet.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1836194106582243323=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1836194106582243323==
Content-Type: multipart/signed;
  boundary="nextPart1347974.9NZRoPCJ4b";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1347974.9NZRoPCJ4b
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi there,

we got a bugreport[1] against our nagios-plugins package. Unfortunately we =
are=20
unsure about what "FAULT" means.
In case this is a hardware problem of a sensor in form of it got damaged, w=
e=20
would report "CRITICAL", as a problem occured.
If this means there is a problem detecting the sensor or something software=
=20
like problem, we would report "UNKNOWN" as this not means a hardware proble=
m=20
happened.

Many thanks for your help. With kind regards, Jan.
P.S. Please cc me, I'm not subscribed to the list.
[1] http://bugs.debian.org/615133
=2D-=20
Never write mail to <waja@spamfalle.info>, you have been warned!
=2D----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GIT d-- s+: a C+++ UL++++ P+ L+++ E--- W+++ N+++ o++ K++ w--- O M V- PS PE =
Y++
PGP++ t-- 5 X R tv- b+ DI D+ G++ e++ h---- r+++ y++++=20
=2D-----END GEEK CODE BLOCK------

--nextPart1347974.9NZRoPCJ4b
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQBN0Wux9u6Dud+QFyQRAsffAKC1xuwJMhxrCqFG2RefI2U/RhhAlQCeK8G+
oywW7hJzzTS8vKRdmHOR2q0=
=77PK
-----END PGP SIGNATURE-----

--nextPart1347974.9NZRoPCJ4b--


--===============1836194106582243323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1836194106582243323==--
