From: mbroemme@plusserver.de (Maik Broemme)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: Question about address 0x69
Message-Id: <20030219225521.GA32613@lfs.plusserver.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

i have a small question about smbus block read/write because i start to wri=
te a utility to set the FSB. I have an ASUS TUSL2-C with an ICS94201 I?C an=
d a ASUS A7V Mainboard. For both Mainboards the Clock Chip Generator is at =
address 0x69, but if i use i2cdump 0 0x69 s to read data from an error occu=
rs.

Feb 19 23:50:48 homer kernel: i2c-dev.o: opened i2c-1
Feb 19 23:50:48 homer kernel: i2c-dev.o: i2c-1 ioctl, cmd: 0x705, arg: bfff=
f618.
Feb 19 23:50:48 homer kernel: i2c-dev.o: i2c-1 ioctl, cmd: 0x706, arg: 69.
Feb 19 23:50:53 homer kernel: i2c-dev.o: i2c-1 ioctl, cmd: 0x720, arg: bfff=
f720.
Feb 19 23:50:53 homer kernel: i2c-i801.o: Block (pre 1): CNT=14, CMD=00, AD=
D=D3, DAT0q, BLKDAT=7F
Feb 19 23:50:54 homer kernel: i2c-i801.o: SMBus Timeout!
Feb 19 23:50:54 homer kernel: i2c-i801.o: Error: no response!
Feb 19 23:50:54 homer kernel: i2c-i801.o: Block (post 1): CNT=14, CMD=00, A=
DD=D3, DAT0q, BLKDAT=7F
Feb 19 23:50:54 homer kernel: i2c-dev.o: Closed: i2c-1

Thats the debug output from kernel log. It comes on both mainboards with di=
fferent chipsets, does anyone knows this problem? The BUS is not busy or su=
ch things, also after coldstart of both systems it does not work. Don't kno=
w exactly if this is a bug in the i2c code. :)

- --
Best regards

Maik Broemme
UNIX/Linux Developer

WOLK Kernel Developer - http://wolk.sourceforge.net/
TuxBox Developer - http://tuxbox.berlios.de/=20
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+VAtUj7mZcU7rMfERArQfAKDCAl0AvUXFBcaQzHz4qAjN/y7qpACdFLTM
07+fZhhyvEWSAXkBQYJwn2k=3DQ7sN
-----END PGP SIGNATURE-----
