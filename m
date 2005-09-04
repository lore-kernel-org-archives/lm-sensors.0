From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Sep 2005 15:04:45 +0000
Subject: [lm-sensors] lm78 on ep-61lxa-m not detected (#2042)
Message-Id: <20050904150441.57f5efb0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
In-Reply-To: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Grant,

> Does this dmesg fragment mean anything?
> ...
> piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
> piix4_smbus 0000:00:07.3: Using Interrupt SMI# for SMBus.
> piix4_smbus 0000:00:07.3: SMBREV =3D 0x0
> piix4_smbus 0000:00:07.3: SMBA =3D 0x5000
> ...

It's from the PIIX4 SMBus, which we know isn't connected to the LM78
chip, so it's useless.

> >Try loading the lm78 module with force_lm78=9191,0x290. Also try
> >isadump 0x295 0x296. Both should give results if assertion #3 is
> >correct.
>=20
> root@silly:~# modprobe lm78 force_lm78=9191,0x290
> root@silly:~# sensors
> No sensors found!

Oh, did I mention that you needed to load i2c-isa then?

> root@silly:~# isadump 0x295 0x296
> WARNING! Running this program can cause system crashes, data loss and
> worse! I will probe address register 0x295 and data register 0x296.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 28 00 02 0a 00 50 00 0c e0 08 a1 00 0c 14 28 02
> 10: 0a 2a 40 41 00 00 58 2e 22 10 00 4c 23 10 62 00
> 20: 7f 5d d1 bd be b8 c1 19 ff ff ff 30 08 02 11 18
> 30: 1c 50 90 60 02 02 54 46 04 41 0c 00 00 02 01 80
> 40: 08 00 10 00 00 00 40 50 2d 40 40 40 40 40 40 00
> 50: 08 00 10 00 00 00 40 50 2d 40 40 40 40 40 40 00
> 60: 7f 5d d1 bd be b8 c1 19 ff ff ff 30 08 02 11 18
> 70: 1c 50 90 60 02 02 54 46 04 41 0c 00 00 02 01 80
> 80: 28 00 02 0a 00 50 00 0c e0 08 a1 00 0c 14 28 02
> 90: 0a 2a 40 41 00 00 58 2e 22 10 00 4c 23 10 62 00
> a0: 7f 5d d1 bd be b8 c1 19 ff ff ff 30 08 02 11 18
> b0: 1c 50 90 60 02 02 54 46 04 41 0c 00 00 02 01 80
> c0: 08 00 10 00 00 00 40 50 2d 40 40 40 40 40 40 00
> d0: 08 00 10 00 00 00 40 50 2d 40 40 40 40 40 40 00
> e0: 7f 5d d1 bd be b8 c1 19 ff ff ff 30 08 02 11 18
> f0: 1c 50 90 60 02 02 54 46 04 41 0c 00 00 02 01 80

This is a hardware monitoring chip for sure, so it's there, and we have
a misdetection problem.

Can you provide the output of:
isadump -y -f 0x290 8

--=20
Jean Delvare
