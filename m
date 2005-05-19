From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: Question about address 0x69
Message-Id: <3E542A21.90C07649@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030219225521.GA32613@lfs.plusserver.de>
In-Reply-To: <20030219225521.GA32613@lfs.plusserver.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

right you are Phil.

You want to use i2c block read, not smbus block read.
Support for i2c block read was added in the last year or so but it is
lightly tested.
Very few bus drivers support i2c block but i2c-i801 does.
Don't know if anyone has ever tried it through i2c-dev, though.

Try changing your ioctl to use i2c block.
Also try i2cdump which does support i2c block (i2cdump 0x69 i)

Philip Edelbrock wrote:
>=20
> Yes, I'm very familiar with that.  It's an I2C chip which is on an
> SMBus.  The two are somewhat compatible, but not completely.  The I2C
> chip in this case is locking up and taking over the bus and not letting
> go because it thinks the transaction is still pending (ironicly, the
> clock chip has no time out).  The only way to make it stop is to power
> it down and back up (complete system power down).  If you stick with
> using SMBus commands which are compatible with this chip, you should be
> OK.  But, using commands like a byte-read when the chip expects a
> word-read (this is a hypothetical example and may not hold true) could
> cause bad things like this to happen.
>=20
> Phil
>=20
> Maik Broemme wrote:
>=20
> >-----BEGIN PGP SIGNED MESSAGE-----
> >Hash: SHA1
> >
> >Hi,
> >
> >i have a small question about smbus block read/write because i start to =
write a utility to set the FSB. I have an ASUS TUSL2-C with an ICS94201 I?C=
 and a ASUS A7V Mainboard. For both Mainboards the Clock Chip Generator is =
at address 0x69, but if i use i2cdump 0 0x69 s to read data from an error o=
ccurs.
> >
> >Feb 19 23:50:48 homer kernel: i2c-dev.o: opened i2c-1
> >Feb 19 23:50:48 homer kernel: i2c-dev.o: i2c-1 ioctl, cmd: 0x705, arg: b=
ffff618.
> >Feb 19 23:50:48 homer kernel: i2c-dev.o: i2c-1 ioctl, cmd: 0x706, arg: 6=
9.
> >Feb 19 23:50:53 homer kernel: i2c-dev.o: i2c-1 ioctl, cmd: 0x720, arg: b=
ffff720.
> >Feb 19 23:50:53 homer kernel: i2c-i801.o: Block (pre 1): CNT=14, CMD=00,=
 ADD=D3, DAT0q, BLKDAT=7F
> >Feb 19 23:50:54 homer kernel: i2c-i801.o: SMBus Timeout!
> >Feb 19 23:50:54 homer kernel: i2c-i801.o: Error: no response!
> >Feb 19 23:50:54 homer kernel: i2c-i801.o: Block (post 1): CNT=14, CMD=00=
, ADD=D3, DAT0q, BLKDAT=7F
> >Feb 19 23:50:54 homer kernel: i2c-dev.o: Closed: i2c-1
> >
> >Thats the debug output from kernel log. It comes on both mainboards with=
 different chipsets, does anyone knows this problem? The BUS is not busy or=
 such things, also after coldstart of both systems it does not work. Don't =
know exactly if this is a bug in the i2c code. :)
> >
> >- --
> >Best regards
> >
> >Maik Broemme
> >UNIX/Linux Developer
> >
> >WOLK Kernel Developer - http://wolk.sourceforge.net/
> >TuxBox Developer - http://tuxbox.berlios.de/
> >-----BEGIN PGP SIGNATURE-----
> >Version: GnuPG v1.0.7 (GNU/Linux)
> >
> >iD8DBQE+VAtUj7mZcU7rMfERArQfAKDCAl0AvUXFBcaQzHz4qAjN/y7qpACdFLTM
> >07+fZhhyvEWSAXkBQYJwn2k> >=3DQ7sN
> >-----END PGP SIGNATURE-----
> >
> >
> >
