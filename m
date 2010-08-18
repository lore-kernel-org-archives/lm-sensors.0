From: Olaf Mandel <olaf@mandel.name>
Date: Wed, 18 Aug 2010 15:26:02 +0000
Subject: [lm-sensors] Config for MSI X58 Pro-E (MS-7522)
Message-Id: <4C6BFB8A.7060300@mandel.name>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4147086323076721372=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4147086323076721372==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC7F1F568C6A0FFA2DA597704"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC7F1F568C6A0FFA2DA597704
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello,

this is a partial configuration file for the MSI X58 Pro-E (MS-7522)
motherboard, in case someone else has the board. It works for me, but is
unfortunately incomplete:

* The System1 fan could be on either fan2 or fan3
* There are several 3.3V inputs, but which one corresponds to the one
shown in the BIOS?
* The calibration values for in1, in4 and in5 are only approximations
* No min, max or critical values are given here.

=3D=3D=3DBEGIN sensors3.conf=3D=3D=3D
# configuration for the Fintek f71882fg as used on the MSI X58 Pro-E
(MS-7522)
chip "f71882fg-*"

# Temperature
    label   temp1 "CPU"
    label   temp2 "IOH"
    label   temp3 "System"

# Fans
    label   fan1  "CPU"
    label   fan2  "System 1" # This is not confirmed
    label   fan3  "System 2"
    ignore  fan4

# Voltage
    label   in0   "3.3V"  # Which of these three to use?
    label   in1   "Vcore"
    ignore  in2
    ignore  in3
    label   in4   "5V"
    label   in5   "12V"
    ignore  in6
    label   in7   "3.3V"  # Which of these three to use?
    label   in8   "3.3V"  # Which of these three to use?
    compute in0   (@ * 2), (@ / 2) # Hardwired in chip, don't change
    compute in1   (@ * 1.35), (@ / 1.35)
    compute in4   (@ * 5.25), (@ / 5.25)
    compute in5   (@ * 10.9), (@ / 10.9)
    compute in7   (@ * 2), (@ / 2) # Hardwired in chip, don't change
    compute in8   (@ * 2), (@ / 2) # Hardwired in chip, don't change
=3D=3D=3DEnd sensors3.conf=3D=3D=3D

Best regards,
Olaf
--=20
Olaf Mandel   <olaf@mandel.name>   <http://www.olaf.mandel.name/>
PGP key:      1024D/33398848 2002-09-19
Fingerprint:  0E33 BEA6 1A71 9C5E 62BD  FC0E 99A7 D2C6 3339 8848


--------------enigC7F1F568C6A0FFA2DA597704
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkxr+48ACgkQmafSxjM5iEjzMgCgvvh/qh79S6iAqIM5csmaB7/D
YzcAoJweFotOk0lfRSKbws9aUphGMbIx
=hMgp
-----END PGP SIGNATURE-----

--------------enigC7F1F568C6A0FFA2DA597704--


--===============4147086323076721372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4147086323076721372==--
