From: Alun Evans <alun@badgerous.net>
Date: Wed, 29 Jan 2014 04:57:00 +0000
Subject: [lm-sensors] Reading SPD on Intel Patsburg on Supermicro X9SRG-F board
Message-Id: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5921366557775692639=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============5921366557775692639==
Content-Type: multipart/signed; boundary="Apple-Mail=_31F15229-B726-47E5-ADA4-47AD3EFF293F"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_31F15229-B726-47E5-ADA4-47AD3EFF293F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello,

I=92m trying to get some sense out of this:

00:1f.3 SMBus: Intel Corporation C600/X79 series chipset SMBus Host =
Controller (rev 05)
        Subsystem: Super Micro Computer Inc Device 0661
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium =
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 18
        Region 0: Memory at fba20000 (64-bit, non-prefetchable) =
[size=3D256]
        Region 4: I/O ports at 1180 [size=3D32]
        Kernel driver in use: i801_smbus
        Kernel modules: i2c-i801

$ sudo i2cdetect -l
i2c-0   smbus           SMBus I801 adapter at 1180              SMBus =
adapter
i2c-1   i2c             igb BB                                  I2C =
adapter
i2c-2   i2c             igb BB                                  I2C =
adapter

The following doesn=92t make sense to me:

$ sudo i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and =
worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] Y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --=20
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
20: -- -- -- -- -- -- -- -- -- -- -- -- -- 2d -- --=20
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
40: -- -- -- -- 44 -- -- -- 48 -- -- -- -- -- -- --=20
50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
60: -- -- -- -- -- -- -- -- 68 69 -- -- 6c -- -- --=20
70: -- -- -- -- -- -- -- --                        =20

Since I have two RDIMMs on this board:

$ sudo ./ipmicfg-linux.x86_64 -nm cpumemtemp
CPU#0 =3D 35(c)
[CPU#0]CHANNEL#2, DIMM#0(P1_DIMMC1) =3D 24(c)
[CPU#0]CHANNEL#2, DIMM#1(P1_DIMMC2) =3D 24(c)

And snooping the bus on boot up with a total phase Aardvark, I see that =
the DIMMs are on addr 0x50, and 0x51, and if I dump 0x50, I just see 256 =
bytes of 0xff, rather than the SPD eeprom data that I was expecting.

I=92ve been hacking away at the kernel module, but I=92ve not been able =
to really make any progress. Looking for any pointers.


thanks,

A.

--=20
Alun Evans

--Apple-Mail=_31F15229-B726-47E5-ADA4-47AD3EFF293F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlLoihwACgkQDX2x+/Q7Ga24EwCeODnfnOhOkb+KJBItEaGyIiiT
wwYAniHMbm7EzN8yRmYl1LexMIu9tFwp
=meKQ
-----END PGP SIGNATURE-----

--Apple-Mail=_31F15229-B726-47E5-ADA4-47AD3EFF293F--


--===============5921366557775692639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5921366557775692639==--
