From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: lm_sensors for sis and bug in sensors-detect (fwd)
Message-Id: <3D09043A.55F9E1ED@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.10.10206120010240.13158-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.10.10206120010240.13158-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

As it says in dmesg (and on our new drivers page) the 630 is not supported.=
 sorry.
But it doesn't have sensors in it anyway.
Most 630 boards have an it87xx on them, try the it87 module.
The most important thing is to find out what sensors are on the board,
then see if we support them, then if not get a datasheet and try
to write a driver.
Good luck.

Ky?sti M?lkki wrote:
>=20
> ---------- Forwarded message ----------
> Return-Path: <michal@michal.waw.pl>
> Received: from woland.mmm.ozarow-12.waw.pl (218-bem-2.acn.waw.pl
>     [62.121.81.218])
>         by taku.hut.fi (8.12.3/8.12.3) with ESMTP id g5BBndev524514
>         for <kmalkki@cc.hut.fi>; Tue, 11 Jun 2002 14:49:40 +0300 (EEST)
> Received: from wieszak.mmm.ozarow-12.waw.pl ([172.16.0.4] ident=3Dexim)
>         by woland.mmm.ozarow-12.waw.pl with esmtp (Exim 3.35 #1)
>         id 17Hk9b-0004RE-00
>         for kmalkki@cc.hut.fi; Tue, 11 Jun 2002 13:49:39 +0200
> Received: from misiek by wieszak.mmm.ozarow-12.waw.pl with local (Exim 3.=
36 #1)
>         id 17Hk9W-0001IB-00
>         for kmalkki@cc.hut.fi; Tue, 11 Jun 2002 13:49:34 +0200
> Date: Tue, 11 Jun 2002 13:49:34 +0200
> From: Michal Kochanowicz <michal@michal.waw.pl>
> To: =3D?iso-8859-1?Q?Ky=F6sti_M=E4lkki?=3D <kmalkki@cc.hut.fi>
> Subject: lm_sensors for sis and bug in sensors-detect
> Message-ID: <20020611114934.GA4534@wieszak.mmm.ozarow-12.waw.pl>
> Mime-Version: 1.0
> Content-Type: text/plain; charset=3Diso-8859-1
> Content-Disposition: inline
> Content-Transfer-Encoding: 8bit
> User-Agent: Mutt/1.4i
> Organization: Happy GNU/Linux Users
> X-Signature-Tagline-Copyright: Piotr Zientarski, 1999-2001
>=20
> Hi
>=20
> I found out you are involved in creation of sis drivers for lm_sensor,
> so maybe you will be able to help me.
>=20
> I've a laptop with SIS chipset:
> ------------------------------------------------------------------------
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 10)
> 00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d=
0)
> 00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
> 00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/1=
00 Ethernet (rev 80)
> 00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
> 00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
> 00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS=
 PCI Audio Accelerator (rev 01)
> 00:01.6 Modem: Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link =
HAMR5600 compatible) (rev a0)
> 00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
> 00:03.0 CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev 05)
> 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS63=
0 GUI Accelerator+3D (rev 10)
> ------------------------------------------------------------------------
>=20
> I'm trying to install lm_sensors. At first I've tried sensors-detect,
> but it seems there is some bug:
>=20
> ------------------------------------------------------------------------
> [root@blah tmp]# ./sensors-detect
>  This program will help you to determine which I2C/SMBus modules you need=
 to
>  load to use lm_sensors most effectively.
>  You need to have done a `make install', issued a `depmod -a' and made su=
re
>  `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
>  module path before you can use some functions of this utility. Read
>  doc/modules for more information.
>  Also, you need to be `root', or at least have access to the /dev/i2c[-/]=
* files
>  for some things. You can use prog/mkdev/mkdev.sh to create these /dev fi=
les
>  if you do not have them already.
>  If you have patched your kernel and have some drivers built-in you can
>  safely answer NO if asked to load some modules. In this case, things may
>  seem a bit confusing, but they will still work.
>=20
>  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
>  IBM Thinkpads have a severely broken i2c/SMBus implementation,  just sca=
nning
>  the bus will break your thinkpad forever!
>=20
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no): YES
> Probing for PCI bus adapters...
> Use driver `<To Be Written>' for device 00:00.0: Silicon Integrated Syste=
ms SIS630 (To be written - Do not use 5595 drivers)
> Use driver `i2c-sis5595' for device 00:01.0: Silicon Integrated Systems S=
IS5595
> Probe succesfully concluded.
>=20
>  We will now try to load each adapter module in turn.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in string eq at ./sensors-detect line 994, <ST=
DIN> line 1.
> Use of uninitialized value in concatenation (.) or string at ./sensors-de=
tect line 2804, <STDIN> line 1.
> Load `' (say NO if built into your kernel)? (YES/no):
> ------------------------------------------------------------------------
>=20
> I've tried loading i2c-sis5595 and sis5595 modules, but they won't load:
> ------------------------------------------------------------------------
> Jun 11 13:46:53 blah kernel: i2c-core.o: i2c core module
> Jun 11 13:46:53 blah kernel: i2c-sis5595.o version 2.6.3 (20020322)
> Jun 11 13:46:53 blah kernel: i2c-sis5595.o: Error: Looked for SIS5595 but=
 found unsupported device 0630
> Jun 11 13:46:53 blah kernel: i2c-sis5595.o: SIS5595 not detected, module =
not inserted.
>=20
> Jun 11 13:47:03 blah kernel: i2c-core.o: i2c core module
> Jun 11 13:47:03 blah kernel: i2c-proc.o version 2.6.1 (20010825)
> Jun 11 13:47:03 blah kernel: sis5595.o version 2.6.3 (20020322)
> Jun 11 13:47:03 blah kernel: sis5595.o: Error: Looked for SIS5595 but fou=
nd unsupported device 0630
> Jun 11 13:47:03 blah kernel: sis5595.o: SIS5595 not detected, module not =
inserted.
> ------------------------------------------------------------------------
>=20
> Is there any chance to make lm_sensors running on my hardware? I know it
> is hard to write a driver for hardware you don't have, but I have some
> programming experience (altough not with low level drivers) and maybe if
> you guide me we could make it work?
>=20
> Regards
>=20
> PS. I've tired sensors-detect from CVS and it seem to still have this
> bug.
> --
> --=3D Michal Kochanowicz=3D--=3D--=3DBOFH=3D--=3D--=3Dmichal@michal.waw.p=
l =3D--
> --=3D finger me for PGP public key or visit http://michal.waw.pl/PGP =3D--
> --=3D--=3D--=3D--=3D--=3D-- Vodka. Connecting people.--=3D--=3D--=3D--=3D=
--=3D--
> A chodzenie po g?rach SSIE!!!
