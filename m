From: Sven Anders <anders@anduras.de>
Date: Mon, 10 Nov 2008 23:39:36 +0000
Subject: [lm-sensors] ipmisensors to use or not to use?
Message-Id: <4918C638.7010202@anduras.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0969938077809976567=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0969938077809976567==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEB7D5C0CDE2C83ED7911F3B4"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEB7D5C0CDE2C83ED7911F3B4
Content-Type: multipart/mixed; boundary="------------040307060504070503060905"

This is a multi-part message in MIME format.
--------------040307060504070503060905
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello!

I'm running Linux kernel 2.6.26 and want to get sensor
data from IPMI subsystem via lm-sensors.

In the documentation I read I should use the ipmisensors
modules (the successor of the bmcsensors module).

The latest patch I found, does not compile clearly with
newer kernels. I tried to fix the patch, but after that
failed, I took a closer look and it seems I have to
change too much. So here my question:

 Is the patch still the way to go or should I use
 any other way to get the data via lm-sensors (or
 direct access to /sys)?

Regards
 Sven Anders

--=20
 Sven Anders <anders@anduras.de>                 () Ascii Ribbon Campaign=

                                                 /\ Support plain text e-=
mail
 ANDURAS service solutions AG
 Innstra=DFe 71 - 94036 Passau - Germany
 Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90 5=
0-55

Rechtsform: Aktiengesellschaft - Sitz: Passau - Amtsgericht Passau HRB 60=
32
Mitglieder des Vorstands: Sven Anders, Marcus Junker
Vorsitzender des Aufsichtsrats: Mark Peters

--------------040307060504070503060905
Content-Type: text/x-vcard; charset=utf-8;
 name="anders.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="anders.vcf"

begin:vcard
fn:Sven Anders
n:Anders;Sven
org:ANDURAS AG;Research and Development
adr;quoted-printable:;;Innstra=3DC3=3D9Fe 71;Passau;Bavaria;94036;Germany=

email;internet:anders@anduras.de
title:Dipl. Inf.
tel;work:++49 (0)851 / 490 50 -0
tel;fax:++49 (0)851 / 590 50 - 55
x-mozilla-html:FALSE
url:http://www.anduras.de
version:2.1
end:vcard


--------------040307060504070503060905--

--------------enigEB7D5C0CDE2C83ED7911F3B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJGMY+5lKZ7Feg4EcRApKEAKCmkkdpmoAsy6Rr9O8potQrnc2+kgCeMLyq
QTHpysSrdHyPa/MJ6ks5HGo=
=535q
-----END PGP SIGNATURE-----

--------------enigEB7D5C0CDE2C83ED7911F3B4--


--===============0969938077809976567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0969938077809976567==--
