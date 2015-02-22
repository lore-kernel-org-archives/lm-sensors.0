From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sun, 22 Feb 2015 11:50:49 +0000
Subject: [lm-sensors] i8k: move driver from char to hwmon
Message-Id: <201502221250.49466@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4379511184076869105=="
List-Id: <lm-sensors.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Honeyman <stevenhoneyman@gmail.com>, Jean Delvare <jdelvare@suse.de>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============4379511184076869105==
Content-Type: multipart/signed;
  boundary="nextPart8639756.QICyvGlI7y";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8639756.QICyvGlI7y
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

currently i8k driver for DELLDIAG SMM operations (charger,=20
battery, hotkeys, temperature and fan control) supports two=20
interfaces:

1) old /proc/i8k char device
2) new hwmon interface

Driver now lives in char subsystem, but nowadays I think lot of=20
people are interested only in hwmon interface which provides=20
temperature & fan control. Power management and hotkeys support=20
(which is missing in 2) but provided by 1)) is already handled by=20
ACPI or input subsystem for new laptops.

Also name "i8k" is really non intuitive what it means and=20
supports... (I was told it is abbreviation for Inspirion 8000=20
model which was probably first dell model supported by that=20
DELLDIAG interface). Now driver is used on Vostro, Latitude and=20
also Precision and XPS models. I think at least "dell" should be=20
part of driver name and config option.

So I have idea for some changes:

1) Move driver from char subsystem to hwmon

2) Rename driver from i8k to something like delldiag or dellsmm

3) Add new CONFIG_ option to enable/disable /proc/i8k device and=20
compile only hwmon interface support

What do you think about it?

I do not want to delete /proc/i8k interface (or break support for=20
it) as there are still userspace applications which use this old=20
interface and for old models it is probably only way how to=20
detect power supply and multimedia hotkeys...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart8639756.QICyvGlI7y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTpwpkACgkQi/DJPQPkQ1KmigCgpnyPy/wF3L6YESgV+o0AgRtL
lBYAnjdmkjkMjaiiJiIZ49vqugkSQkig
=HdsF
-----END PGP SIGNATURE-----

--nextPart8639756.QICyvGlI7y--


--===============4379511184076869105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4379511184076869105==--
