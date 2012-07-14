From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat, 14 Jul 2012 15:26:26 +0000
Subject: [lm-sensors] [PATCH]: i2c-tools/decode-dimms: fix cryptic error message
Message-Id: <20120714152626.GA24918@volta.aurel32.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2190072190934725501=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============2190072190934725501==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

decode-dimms doesn't handle correctly the case where the eeprom module
is loaded, but not eeprom is actually found (most of the cases when no
bus i2c driver exist for the system):

| # decode-dimms version 5929 (2011-02-16 14:58:38 +0100)
|=20
| Memory Serial Presence Detect Decoder
| By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner,
| Jean Delvare, Trent Piepho and others
| Can't use string ("") as a HASH ref while "strict refs" in use at /usr/bi=
n/decode-dimms line 178

This tends to be a cryptic error message, at least for the users. The
patch below fixes the issue by outputting an error message in that
case.

Regards,
Aurelien


Index: eeprom/decode-dimms
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- eeprom/decode-dimms	(r=E9vision 6060)
+++ eeprom/decode-dimms	(copie de travail)
@@ -1774,6 +1774,9 @@
 	} elsif (! -d '/sys/module/eeprom') {
 		print "No EEPROM found, are you sure the eeprom module is loaded?\n";
 		exit;
+	} else {
+		print "No EEPROM found, the kernel probably does not support your hardwa=
re.\n";
+		exit;
 	}
 }

--=20
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iD8DBQFQAY+iw3ao2vG823MRAkyVAJ9GKug217mOQrPUasAEqT+6DlN97wCfURcl
bVpEG3Q+JHDUuKfYImH8Jys=
=clLn
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--


--===============2190072190934725501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2190072190934725501==--
