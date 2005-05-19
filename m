From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: Question about address 0x69
Message-Id: <3E540D91.6845AD00@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030219225521.GA32613@lfs.plusserver.de>
In-Reply-To: <20030219225521.GA32613@lfs.plusserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

many clock chips are write-only. See your datasheet to verify.


Maik Broemme wrote:
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hi,
>=20
> i have a small question about smbus block read/write because i start to w=
rite a utility to set the FSB. I have an ASUS TUSL2-C with an ICS94201 I?C =
and a ASUS A7V Mainboard. For both Mainboards the Clock Chip Generator is a=
t address 0x69, but if i use i2cdump 0 0x69 s to read data from an error oc=
curs.
>=20
> Feb 19 23:50:48 homer kernel: i2c-dev.o: opened i2c-1
> Feb 19 23:50:48 homer kernel: i2c-dev.o: i2c-1 ioctl, cmd: 0x705, arg: bf=
fff618.
> Feb 19 23:50:48 homer kernel: i2c-dev.o: i2c-1 ioctl, cmd: 0x706, arg: 69.
> Feb 19 23:50:53 homer kernel: i2c-dev.o: i2c-1 ioctl, cmd: 0x720, arg: bf=
fff720.
> Feb 19 23:50:53 homer kernel: i2c-i801.o: Block (pre 1): CNT=14, CMD=00, =
ADD=D3, DAT0q, BLKDAT=7F
> Feb 19 23:50:54 homer kernel: i2c-i801.o: SMBus Timeout!
> Feb 19 23:50:54 homer kernel: i2c-i801.o: Error: no response!
> Feb 19 23:50:54 homer kernel: i2c-i801.o: Block (post 1): CNT=14, CMD=00,=
 ADD=D3, DAT0q, BLKDAT=7F
> Feb 19 23:50:54 homer kernel: i2c-dev.o: Closed: i2c-1
>=20
> Thats the debug output from kernel log. It comes on both mainboards with =
different chipsets, does anyone knows this problem? The BUS is not busy or =
such things, also after coldstart of both systems it does not work. Don't k=
now exactly if this is a bug in the i2c code. :)
>=20
> - --
> Best regards
>=20
> Maik Broemme
> UNIX/Linux Developer
>=20
> WOLK Kernel Developer - http://wolk.sourceforge.net/
> TuxBox Developer - http://tuxbox.berlios.de/
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.7 (GNU/Linux)
>=20
> iD8DBQE+VAtUj7mZcU7rMfERArQfAKDCAl0AvUXFBcaQzHz4qAjN/y7qpACdFLTM
> 07+fZhhyvEWSAXkBQYJwn2k> =3DQ7sN
> -----END PGP SIGNATURE-----
