From: Denny Schierz <linuxmail@4lin.net>
Date: Fri, 26 Mar 2010 00:48:11 +0000
Subject: Re: [lm-sensors] G760A not working korrekt on NAS dlink 323 HW C1
Message-Id: <1269564491.3051.293.camel@mac>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8552647657812467900=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1269292447.6810.21.camel@kusanagi>
In-Reply-To: <1269292447.6810.21.camel@kusanagi>
To: lm-sensors@vger.kernel.org


--===============8552647657812467900==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-S1mXbo5vA94HLXH3WAb6"


--=-S1mXbo5vA94HLXH3WAb6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi,

i was able to locate the chip on the board. His partnumber is AX3106
(PWM controller)

http://www.micro-bridge.com/data/Axelite/AX3106.pdf


Some debug:

nas:~# i2cdetect -l
i2c-0   i2c             mv64xxx_i2c adapter                     I2C
adapter

nas:~# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- 0c -- -- --=20
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU --=20
40: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --=20
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
60: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --=20
70: -- -- -- -- -- -- -- -- =20


so, that is the output, what now? I contacted the maintainer from the
file dns323-setup.c, but he has no time nor the hardware :-/

any suggestions?

cu denny


nas:~# i2cdump 0 0x0c=20
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0xc, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
10: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
20: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
30: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
40: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
50: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
60: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
70: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
80: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
90: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
a0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
b0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
c0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
d0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
e0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
f0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????


nas:~# i2cdump 0 0x3=20
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x3, mode byte
Continue? [Y/n]=20
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX


Am Dienstag, den 23.03.2010, 13:43 +0100 schrieb Jean Delvare:
> For the time being, arch/arm/mach-orion5x/dns323-setup.c should
> probably refrain from instantiating a g760a device on revision C1
> boards. You'll have to discuss this with whoever is in charge of this
> file.
>=20
> Then you can try running i2cdetect on the I2C adapter, to see if a
> mysterious device has been added. The I2C device map is supposed to
> be:
>=20
> /*
>  * On the DNS-323 the following devices are attached via I2C:
>  *
>  *  i2c addr | chip        | description
>  *  0x3e     | GMT G760Af  | fan speed PWM controller
>  *  0x48     | GMT G751-2f | temp. sensor and therm. watchdog (LM75
> compatible)
>  *  0x68     | ST M41T80   | RTC w/ alarm
>  */
>=20
> but I guess yours will be different.=20

--=-S1mXbo5vA94HLXH3WAb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkusBEcACgkQKlzhkqt9P+BIJwCfezbOqH5DZEaIUaEmjlPgV4Ub
O5MAn0QlhvhJF8wrXFnX6jYY5eZUE5ua
=DF/Y
-----END PGP SIGNATURE-----

--=-S1mXbo5vA94HLXH3WAb6--



--===============8552647657812467900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8552647657812467900==--

