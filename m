From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: Question about address 0x69
Message-Id: <3E540E8B.5080303@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030219225521.GA32613@lfs.plusserver.de>
In-Reply-To: <20030219225521.GA32613@lfs.plusserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Yes, I'm very familiar with that.  It's an I2C chip which is on an=20
SMBus.  The two are somewhat compatible, but not completely.  The I2C=20
chip in this case is locking up and taking over the bus and not letting=20
go because it thinks the transaction is still pending (ironicly, the=20
clock chip has no time out).  The only way to make it stop is to power=20
it down and back up (complete system power down).  If you stick with=20
using SMBus commands which are compatible with this chip, you should be=20
OK.  But, using commands like a byte-read when the chip expects a=20
word-read (this is a hypothetical example and may not hold true) could=20
cause bad things like this to happen.


Phil


Maik Broemme wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Hi,
>
>i have a small question about smbus block read/write because i start to wr=
ite a utility to set the FSB. I have an ASUS TUSL2-C with an ICS94201 I?C a=
nd a ASUS A7V Mainboard. For both Mainboards the Clock Chip Generator is at=
 address 0x69, but if i use i2cdump 0 0x69 s to read data from an error occ=
urs.
>
>Feb 19 23:50:48 homer kernel: i2c-dev.o: opened i2c-1
>Feb 19 23:50:48 homer kernel: i2c-dev.o: i2c-1 ioctl, cmd: 0x705, arg: bff=
ff618.
>Feb 19 23:50:48 homer kernel: i2c-dev.o: i2c-1 ioctl, cmd: 0x706, arg: 69.
>Feb 19 23:50:53 homer kernel: i2c-dev.o: i2c-1 ioctl, cmd: 0x720, arg: bff=
ff720.
>Feb 19 23:50:53 homer kernel: i2c-i801.o: Block (pre 1): CNT=14, CMD=00, A=
DD=D3, DAT0q, BLKDAT=7F
>Feb 19 23:50:54 homer kernel: i2c-i801.o: SMBus Timeout!
>Feb 19 23:50:54 homer kernel: i2c-i801.o: Error: no response!
>Feb 19 23:50:54 homer kernel: i2c-i801.o: Block (post 1): CNT=14, CMD=00, =
ADD=D3, DAT0q, BLKDAT=7F
>Feb 19 23:50:54 homer kernel: i2c-dev.o: Closed: i2c-1
>
>Thats the debug output from kernel log. It comes on both mainboards with d=
ifferent chipsets, does anyone knows this problem? The BUS is not busy or s=
uch things, also after coldstart of both systems it does not work. Don't kn=
ow exactly if this is a bug in the i2c code. :)
>
>- --
>Best regards
>
>Maik Broemme
>UNIX/Linux Developer
>
>WOLK Kernel Developer - http://wolk.sourceforge.net/
>TuxBox Developer - http://tuxbox.berlios.de/=20
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.0.7 (GNU/Linux)
>
>iD8DBQE+VAtUj7mZcU7rMfERArQfAKDCAl0AvUXFBcaQzHz4qAjN/y7qpACdFLTM
>07+fZhhyvEWSAXkBQYJwn2k>=3DQ7sN
>-----END PGP SIGNATURE-----
>
> =20
>
