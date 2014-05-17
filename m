From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sat, 17 May 2014 20:02:12 +0000
Subject: [lm-sensors] [PATCH] sensord: do not fail if some sensor does not return data
Message-Id: <201405172202.12672@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1636802237379421861=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1636802237379421861==
Content-Type: multipart/signed;
  boundary="nextPart1833568.4PhUEbxdgn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1833568.4PhUEbxdgn
Content-Type: multipart/mixed;
  boundary="Boundary-01=_EB8dTZa77pFws/c"
Content-Transfer-Encoding: 7bit


--Boundary-01=_EB8dTZa77pFws/c
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I see very annoying bug in sensord. When some hwmon driver=20
returns -EINVAL (for any reason), sensord daemon will stop=20
reading next sensors values. This means if first hwmon device=20
fail to return value, sensord daemon will not log anything.

Returning -EINVAL from kernel driver is normal (e.g. when graphic=20
card with has internal temperature sensor is turned off) and=20
sensord should not fail on this.

Program sensors already handling this problem and will print N/A=20
if there is reading error.

I'm sending simple patch which just report NaN value when kernel=20
report error. And also sensord will continue to reading next=20
hwmon interfaces.

Without this patch I see only these lines logged:

sensord: Chip: radeon-pci-0100
sensord: Adapter: PCI adapter
sensord: Error getting sensor data: radeon/#0: Can't read
sensord: sensor read error (-1)

And all other sensors are ignored and nothing more is logged.

After my patch all hwmon sensors data are logged:

sensord: Chip: radeon-pci-0100
sensord: Adapter: PCI adapter
sensord:   temp1: nan C
sensord: Chip: i8k-virtual-0
sensord: Adapter: Virtual device
sensord:   Left Fan: 2685 RPM
sensord:   CPU: 49.0 C
sensord:   temp2: 55.0 C
sensord:   temp3: 39.0 C
sensord: Chip: coretemp-isa-0000
sensord: Adapter: ISA adapter
sensord:   Physical id 0: 50.0 C
sensord:   Core 0: 47.0 C
sensord:   Core 1: 50.0 C

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--Boundary-01=_EB8dTZa77pFws/c
Content-Type: text/x-patch;
  charset="UTF-8";
  name="sensord_nan.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sensord_nan.patch"

=2D-- lm-sensors-3.3.1/prog/sensord/sense.c.orig	2014-05-17 21:14:21.000000=
000 +0200
+++ lm-sensors-3.3.1/prog/sensord/sense.c	2014-05-17 21:45:27.677299361 +02=
00
@@ -93,11 +93,14 @@ static int get_features(const sensors_ch
 		ret =3D sensors_get_value(chip, feature->dataNumbers[i],
 					val + i);
 		if (ret) {
+#if 0
 			sensorLog(LOG_ERR,
 				  "Error getting sensor data: %s/#%d: %s",
 				  chip->prefix, feature->dataNumbers[i],
 				  sensors_strerror(ret));
 			return -1;
+#endif
+			val[i] =3D nan("");
 		}
 	}
=20
@@ -168,8 +171,10 @@ static int doKnownChip(const sensors_chi
=20
 	for (i =3D 0; features[i].format; i++) {
 		ret =3D do_features(chip, features + i, action);
+#if 0
 		if (ret =3D=3D -1)
 			break;
+#endif
 	}
=20
 	return ret;

--Boundary-01=_EB8dTZa77pFws/c--

--nextPart1833568.4PhUEbxdgn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlN3wEQACgkQi/DJPQPkQ1IP6ACcD2s4wmGbAiuibJCwB/mOUnBI
gdIAoKIFHmQbclM81+nLsQRALFTVR9AW
=6TBY
-----END PGP SIGNATURE-----

--nextPart1833568.4PhUEbxdgn--


--===============1636802237379421861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1636802237379421861==--
