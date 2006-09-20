From: alejandro.riveira@gmail.com (Alejandro Riveira =?ISO-8859-1?Q?Fern=E1ndez?=)
Date: Wed, 20 Sep 2006 23:30:39 +0000
Subject: [lm-sensors] Module(s) ALI15** not loading
Message-Id: <1158795039.22021.4.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1158188393.9914.5.camel@localhost.localdomain>
In-Reply-To: <1158188393.9914.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

El mi?, 20-09-2006 a las 21:36 +0200, Rudolf Marek escribi?:
> Alejandro Riveira Fern?ndez wrote:
> >         Hi I have changed my mobo, now i have an uli1697 based asrock
> >         AM2xli-esataII=20
> >        =20
> >         i'm seeing this in the dmesg
> >        =20
> >         ali1535_smbus 0000:00:15.1: ALI1535_smb region uninitialized - =
upgrade BIOS?
> >         ali1535_smbus 0000:00:15.1: ALI1535 not detected, module not in=
serted.
> >         ali15x3_smbus 0000:00:15.1: ALI15X3_smb region uninitialized - =
upgrade BIOS or use force_addr=3D0xaddr
> >         ali15x3_smbus 0000:00:15.1: ALI15X3 not detected, module not in=
serted.
> >        =20
> >         ??Does anybody has an idea of how to make it work?
>=20
> Not yet. Please provide output of following (you need to to be root)
> lspci -xxx
> sensors-detect
>=20
> (with newest sensors-detect -=20
> http://www.lm-sensors.org/wiki/iwizard/NoSensorsDetected
>=20
> Regards
> Rudolf

Thanks for the response (note that i have updated the kernel since the
las msg is now 2.6.18 final)

lspci -xxx

0000:00:00.0 Host bridge: ALi Corporation M1697 HTT Host Bridge
00: b9 10 97 16 07 00 10 00 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 08 5c a0 00 20 00 11 11 50 00 00 00 25 05 f5 00
50: 02 00 00 00 00 00 00 01 00 00 00 00 08 68 00 a8
60: 00 00 e0 fe 00 00 00 00 08 74 00 90 00 00 00 00
70: 00 00 00 00 08 7c 00 80 66 01 3a f8 05 00 82 00
80: 00 00 e0 fe 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: ALi Corporation PCI Express Root Port
00: b9 10 4b 52 07 01 10 40 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 e0 00 00
20: 00 dc e0 de 00 c0 f0 cf 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 0b 00
40: 01 48 02 c8 00 00 00 00 05 58 82 00 00 00 e0 fe
50: 00 00 00 00 00 00 00 00 10 7c 41 01 20 00 00 00
60: 10 28 10 00 01 dd 02 00 00 00 01 11 00 00 00 00
70: c0 03 48 00 00 00 00 00 00 00 00 00 08 88 00 a8
80: 00 00 e0 fe 00 00 00 00 08 00 25 88 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 03 00 40 00 00 00 0c 02 08 3f 63 ed 70 2c
b0: 00 00 00 00 09 41 99 01 00 00 00 00 81 19 3f 1f
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 d0 0c 40 01 04 73 00 00 00 00 00 d1 00 77 30
e0: 00 00 00 00 98 00 00 00 01 00 00 00 ea f9 f3 10
f0: 0c bb 61 ec 7e 6b 66 5b f5 ff 72 26 4e c7 e4 93

0000:00:02.0 PCI bridge: ALi Corporation PCI Express Root Port
00: b9 10 4c 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 00
20: f0 ff 00 00 d0 da d0 da 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 03 00
40: 01 48 02 c8 00 00 00 00 05 58 82 00 00 00 e0 fe
50: 00 00 00 00 00 00 00 00 10 7c 41 01 20 00 00 00
60: 10 28 18 00 21 dc 02 00 00 00 10 10 00 00 00 00
70: c0 03 00 00 00 00 00 00 00 00 00 00 08 88 00 a8
80: 00 00 e0 fe 00 00 00 00 08 00 25 88 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 03 00 00 00 00 00 0c 02 09 3f 63 ed 70 2c
b0: 00 00 00 00 00 11 00 00 04 00 00 00 01 00 3f 1f
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 d0 0c 40 01 04 73 00 00 00 00 00 d1 00 77 30
e0: 00 00 00 00 01 00 00 00 01 00 00 00 9e db 6b fd
f0: e0 1b a2 fe d9 a0 80 7b fb 9d fc f0 ce c5 46 dd

0000:00:03.0 PCI bridge: ALi Corporation PCI Express Root Port
00: b9 10 4d 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 00 f0 00 00 00
20: f0 ff 00 00 e0 da e0 da 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 03 00
40: 01 48 02 c8 00 00 00 00 05 58 82 00 00 00 e0 fe
50: 00 00 00 00 00 00 00 00 10 7c 41 01 20 00 00 00
60: 10 28 18 00 11 dc 02 00 00 00 10 10 00 00 00 00
70: c0 03 00 00 00 00 00 00 00 00 00 00 08 88 00 a8
80: 00 00 e0 fe 00 00 00 00 08 00 25 88 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 03 00 00 00 00 00 0c 02 09 15 63 ed 70 2c
b0: 00 00 00 04 00 11 00 00 04 00 00 00 01 00 1f 0f
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 d0 0c 40 01 04 73 00 00 00 00 00 d1 00 77 30
e0: 00 00 00 00 01 00 00 00 01 00 00 00 44 90 58 a1
f0: af 13 b6 ed 74 0a 9f 4e 49 0e d2 d6 9e 7f c7 fa

0000:00:04.0 PCI bridge: ALi Corporation PCI Express Root Port
00: b9 10 4e 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 04 04 00 f0 00 00 00
20: f0 ff 00 00 f0 da f0 da 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 03 01 03 00
40: 01 48 02 c8 00 00 00 00 05 58 82 00 00 00 e0 fe
50: 00 00 00 00 00 00 00 00 10 7c 41 01 20 00 00 00
60: 10 28 18 00 11 dc 02 00 00 00 10 10 00 00 00 00
70: c0 03 00 00 00 00 00 00 00 00 00 00 08 88 00 a8
80: 00 00 e0 fe 00 00 00 00 08 00 25 88 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 03 00 00 00 00 00 0c 02 09 15 63 ed 70 2c
b0: 00 00 00 04 00 11 00 00 04 00 00 00 01 00 0f 07
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 d0 0c 40 01 04 73 00 00 00 00 00 d1 00 77 30
e0: 00 00 00 00 01 00 00 00 01 00 00 00 64 dd 9d 86
f0: 64 e6 ce bb 3c 1b 30 cc 0c 8f bd 2e bd 38 e8 18

0000:00:11.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge
00: b9 10 49 52 07 00 00 62 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 05 05 20 f0 00 00 e2
20: f0 de f0 de f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 03 00
40: 74 84 00 00 74 84 00 00 74 84 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
70: ee a2 b2 9e 68 de 6d ed bf 9d 9a 2e 00 00 00 00
80: eb c1 6f 97 c3 41 0f 10 00 00 00 00 00 00 00 00
90: 08 b0 31 00 00 00 00 00 d0 00 00 00 25 00 35 00
a0: 22 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 08 00 38 80 66 01 d9 f8 00 00 00 00 00 01 11 32
c0: 08 b0 00 a8 00 00 e0 fe 00 00 00 00 00 00 00 00
d0: 2a 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 08 c0 25 88 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:12.0 Ethernet controller: ALi Corporation ULi 1689,1573
integrated ethernet. (rev 60)
00: b9 10 63 52 17 01 10 02 60 00 00 02 10 20 00 00
10: 01 d8 00 00 00 fc fe db 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 63 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 14 28
40: 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 22 c0 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00: b9 10 37 52 17 01 a0 02 03 10 03 0c 10 20 80 00
10: 00 e0 fe db 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 50
40: 00 00 1f 00 e0 40 0a 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 fe 00 80 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00: b9 10 37 52 17 01 a0 02 03 10 03 0c 10 20 80 00
10: 00 d0 fe db 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 50
40: 00 00 1f 00 e0 48 0a 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:13.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00: b9 10 37 52 17 01 a0 02 03 10 03 0c 10 20 80 00
10: 00 c0 fe db 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 03 00 50
40: 00 00 10 00 e0 48 0a 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 fe 00 80 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
00: b9 10 39 52 16 01 b0 02 01 20 03 0c 10 20 80 00
10: 00 f8 fe db 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 39 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 04 10 20
40: f1 05 11 c4 81 02 10 c4 12 00 01 00 00 00 00 00
50: 01 58 02 c8 00 00 00 00 0a 00 90 20 00 00 00 00
60: 20 20 7f 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 00 00 00 00 08 80 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:14.0 Audio device: ALi Corporation High Definition Audio/AC'97
Host Controller (rev 01)
00: b9 10 61 54 06 01 10 02 01 00 03 04 00 20 00 00
10: 00 40 fd db 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 88 08
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 03 10 50
40: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 42 c8 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:15.0 ISA bridge: ALi Corporation PCI to LPC Controller (rev 10)
00: b9 10 73 15 0f 00 00 02 10 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 73 15
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 18
40: 00 00 00 00 3d 00 00 00 00 00 00 00 00 90 00 90
50: 33 00 00 fe 0d 21 01 00 00 00 00 00 80 00 00 05
60: d8 f8 f0 f3 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 01 73 15 00 0f 00 42 00 00 00 20 00 00 00 00
80: 03 50 00 00 21 0f 99 aa bb cc 00 00 ee dd 00 58
90: 00 00 00 00 00 00 00 00 ba 01 00 00 68 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 0e 00 02 00 00 00 de 05 00 00 00 00 00 00
c0: 88 88 88 88 00 00 00 00 08 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 80 07 f0 00 f0 00 c7 0f 00 00 04 01 00 00

0000:00:15.1 Bridge: ALi Corporation M7101 Power Management Controller
[PMU]
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 01 71
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 41 08 00 00 00 20 40 0c f8 17 00 00 00 00 00
50: 00 07 ff 7f 00 00 00 00 00 df 0f 10 00 00 00 00
60: 00 00 41 00 00 00 00 00 00 00 00 00 ff 3f 3f 3f
70: ff 07 00 00 00 00 00 08 17 31 00 88 7e fe ff ff
80: b3 62 00 00 00 05 05 05 05 0b 05 06 05 05 05 05
90: 06 0e 04 00 87 d2 92 50 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 01
b0: 00 44 00 20 00 ff 7f 83 ff 00 00 70 40 10 02 40
c0: 12 00 18 00 00 00 00 00 00 00 00 00 4c 00 00 00
d0: 00 42 00 00 40 0f 02 20 48 2f 00 00 81 00 00 00
e0: 00 40 00 00 e6 12 54 be b4 00 01 00 03 22 42 00
f0: 00 00 00 00 00 00 00 f0 00 00 00 00 00 00 00 00

0000:00:16.0 IDE interface: ALi Corporation M5229 IDE (rev c7)
00: b9 10 29 52 05 00 b0 02 c7 8a 01 01 00 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 49 18 29 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 00 00
40: 00 00 00 7a 4d 10 00 c0 00 80 64 cb 00 00 ba 1a
50: 00 00 00 0b 00 00 df aa 01 31 31 31 01 31 31 31
60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:16.1 SATA controller: ALi Corporation ULi M5288 SATA
00: b9 10 88 52 17 01 b0 02 00 01 06 01 08 20 80 00
10: 01 d4 00 00 01 d0 00 00 01 c8 00 00 01 c4 00 00
20: 01 c0 00 00 00 f4 fe db 00 00 00 00 49 18 88 52
30: 00 00 00 00 60 00 00 00 00 00 00 00 03 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 03 00 00 00 03 00 01 1f ff ff 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 7b 20 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 11 00 00 00 98 34 37 40 9c 90 d9 44 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: d2 13 04 14 0c 10 88 9d 00 00 00 00 00 00 00 00

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 00 00 01 00 e4 00 00 00 20 c8 0e 0f 3c 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 00 01 21 20 00 11 11 22 05 75 80 02 00 00 00
90: 56 04 51 02 00 00 ff 00 07 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 3f 00 00 00 00 00 01 00 00 00
50: 00 00 00 00 02 00 00 00 00 00 00 00 03 00 00 00
60: 00 00 00 00 04 00 00 00 00 00 00 00 05 00 00 00
70: 00 00 00 00 06 00 00 00 00 00 00 00 07 00 00 00
80: 03 00 e0 00 80 ff ef 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 03 0a 00 00 00 0b 00 00 03 00 40 00 00 ff ff 00
c0: 13 10 00 00 00 f0 ff 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 ff 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: e0 3f 38 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 46 00 00 00 00 00 00 00
80: 02 00 00 00 00 00 00 00 24 c2 aa 5d 20 03 13 00
90: 10 0c 01 00 5a 80 10 64 39 00 00 80 00 00 00 00
a0: e9 02 00 5d 00 00 00 00 00 00 00 00 00 00 00 00
b0: 50 f9 e9 81 e5 00 00 00 1f 3c 4e e0 b4 5f 02 18
c0: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 91 6f 09 36 89 7f c8 eb 8f 15 fc 08 8a 5b cc 5c
e0: d8 f7 6d f4 f7 6f dd ff 8a 00 de ba ba dd ce 6e
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
00: 22 10 03 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00
40: ff 3b 04 00 40 00 10 08 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 c0 26 21 fe
60: fb 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 02 51 11 80 00 50 00 38 00 08 1a 22 00 00
80: 00 00 07 23 13 21 13 21 00 00 00 00 00 00 00 00
90: 00 00 00 00 b5 5a 00 00 20 10 f1 d5 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 01 a7 0d 00 00 00 80 00 25 25 25 00
e0: 00 00 00 00 20 1b 4f 00 19 17 00 00 00 00 00 00
f0: 0f 00 10 00 00 04 00 00 02 00 00 00 b2 0f 04 00

0000:01:00.0 VGA compatible controller: nVidia Corporation G70 [GeForce
7300 GT] (rev a1)
00: de 10 93 03 07 01 10 00 a1 00 00 03 00 00 00 00
10: 00 00 00 dd 0c 00 00 c0 00 00 00 00 04 00 00 dc
20: 00 00 00 00 01 e8 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 00 00 01 00 00 00 ce d6 23 00 00 00 00 00
60: 01 68 02 00 00 00 00 00 05 78 80 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 10 00 01 00 00 05 00 00
80: 10 28 0a 00 01 4d 01 d5 08 00 01 11 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:05:0a.0 Network controller: RaLink RT2500 802.11g Cardbus/mini-PCI
(rev 01)
00: 14 18 01 02 17 01 10 04 01 00 80 02 10 20 00 00
10: 00 e0 ff de 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 01 06 00 00 48 19 01 3c
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00
40: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

sensors-detect

# sensors-detect revision $Revision$

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-ali15x3' for device 0000:00:15.1: Acer Labs 1533/1543
Use driver `i2c-ali1535' for device 0000:00:15.1: Acer Labs 1535

We will now try to load each adapter module in turn.
Module `i2c-ali15x3' already loaded.
Module `i2c-ali1535' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no):
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively): n

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively):
Adapter cannot be probed, skipping.

Next adapter: NVIDIA I2C Device
Do you want to scan it? (YES/no/selectively):
Adapter cannot be probed, skipping.

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     Success!
    (confidence 9, driver `k8temp')
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0x8863
    (logical device B has address 0x290, could be sensors)
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627EHF/EHG Super IO Sensors'              Success!
    (address 0x290, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `k8temp' (should be inserted):
  Detects correctly:
  * ISA bus, undetermined address (Busdriver `i2c-isa')
    Chip `AMD K8 thermal sensors' (confidence: 9)

Driver `w83627ehf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627EHF/EHG Super IO Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# Chip drivers
# Warning: the required module k8temp is not currently installed
# on your system. For status of 2.6 kernel ports see
# http://www.lm-sensors.org/wiki/SupportedDevices and
# http://www.lm-sensors.org/wiki/NewDrivers. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe k8temp
modprobe w83627ehf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):



--=20
Pandas are still around because of "survival of the cutest". Much like
OSX.
                                                    hclyff in Slashdot
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 199 bytes
Desc: Esta parte del mensaje =3D?ISO-8859-1?Q?est=E1?=3D firmada
	digitalmente
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060921=
/7b2a61a3/attachment-0001.bin=20
