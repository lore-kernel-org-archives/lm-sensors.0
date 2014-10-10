From: Felix Schulthess <fsch@truthbox.ch>
Date: Fri, 10 Oct 2014 14:08:59 +0000
Subject: [lm-sensors] Fan Control on 6027R TRF running Debian Wheezy
Message-Id: <5437E87B.8030206@truthbox.ch>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6392973809371750620=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6392973809371750620==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pp29rHu2D0R179R0M6L8s202lVU66Sq7i"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pp29rHu2D0R179R0M6L8s202lVU66Sq7i
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear lm-sensors Team,

on a 6027R TRF, I run the latest Debian Wheezy. I have a problem with
the server, because I cannot control fan speed anymore.

My plan was to control the drive bay LEDs via software, so I installed
i2c-tools and ledmon packages. While I was at it, I also installed
fancontrol and lm-sensors. As I now know, this was a very bad idea.

Then I ran the proprietar Superdoctor program (distributed on the
Supermicro website) that prints information on fan speed, temperatures
and system voltages. I ran it only once by executing the command "sdt"
as root. After the command completed, the 3 system fans started spinning
at max RPM. And this is extremely noisy! Note, that the program ran
flawlessly before I installed the packages listed above.

Since then I didn't manage to regain control of the fans. Even after a
reboot the fans start to speed. Also, removing the installed packages
again does not help.

I also tried to control the fans with the fancontrol package, but this
fails because I do not have a correct fancontrol config file. I am
supposed to run pwmconfig first to create such a file, but this fails as
well ("/usr/sbin/pwmconfig: There are no pwm-capable sensor modules
installed")

I have collected the output of sensors-detect, sensors and pwmconfig
here: http://pastebin.mozilla.org/6754878

If you could give any hints on what I am missing, I would be very
grateful. I must get rid of this deafening noise. Thanks in advance!

Best, Felix




--pp29rHu2D0R179R0M6L8s202lVU66Sq7i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJUN+h7AAoJEAiVgzBCINKEIoIIAMH9tUoJ2CT6qk0mS+979KXj
j30eNH5SibwepRW0IiNNGlb5Z6BIVB9JVFY6MOc9gUJZGAJPtV2Q/IoymY7RN4Pi
n6ieNLo99c3K6q2JM8mqHxz2I5p8D4Tsli9CgQPdAJzbGSn5yZZ4Ym/H07n7H9b3
4MjoNIlZtRgODErjwbM0fz4i/mbmQVN2Z7EPkbkan3ZFU+BjcVGYkOhVUMWJUz+F
I93//fjc/zz+wznGa29VID22/4/4+UzwvwhgsYF4SHvW3kNHY8ufN44ELvpjrlQU
CSMZ6WhmEADmZEa/49+gsna0QnCgXpoHE9fNFTxfHKNkPOWZvzQuL+eDdzlaKr8=
=s2La
-----END PGP SIGNATURE-----

--pp29rHu2D0R179R0M6L8s202lVU66Sq7i--


--===============6392973809371750620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6392973809371750620==--
