From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 29 Jan 2014 16:42:24 +0000
Subject: Re: [lm-sensors] Reading SPD on Intel Patsburg on Supermicro X9SRG-F board
Message-Id: <20140129174224.3852916d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
In-Reply-To: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Alun,

On Tue, 28 Jan 2014 20:57:00 -0800, Alun Evans wrote:
> I=92m trying to get some sense out of this:
>=20
> 00:1f.3 SMBus: Intel Corporation C600/X79 series chipset SMBus Host Contr=
oller (rev 05)
>         Subsystem: Super Micro Computer Inc Device 0661
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin C routed to IRQ 18
>         Region 0: Memory at fba20000 (64-bit, non-prefetchable) [size=3D2=
56]
>         Region 4: I/O ports at 1180 [size=3D32]
>         Kernel driver in use: i801_smbus
>         Kernel modules: i2c-i801
>=20
> $ sudo i2cdetect -l
> i2c-0   smbus           SMBus I801 adapter at 1180              SMBus ada=
pter
> i2c-1   i2c             igb BB                                  I2C adapt=
er
> i2c-2   i2c             igb BB                                  I2C adapt=
er
>=20
> The following doesn=92t make sense to me:
>=20
> $ sudo i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] Y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --=20
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- 2d -- --=20
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
> 40: -- -- -- -- 44 -- -- -- 48 -- -- -- -- -- -- --=20
> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
> 60: -- -- -- -- -- -- -- -- 68 69 -- -- 6c -- -- --=20
> 70: -- -- -- -- -- -- -- --                        =20
>=20
> Since I have two RDIMMs on this board:
>=20
> $ sudo ./ipmicfg-linux.x86_64 -nm cpumemtemp
> CPU#0 =3D 35(c)
> [CPU#0]CHANNEL#2, DIMM#0(P1_DIMMC1) =3D 24(c)
> [CPU#0]CHANNEL#2, DIMM#1(P1_DIMMC2) =3D 24(c)
>=20
> And snooping the bus on boot up with a total phase Aardvark, I see that t=
he DIMMs are on addr 0x50, and 0x51, and if I dump 0x50, I just see 256 byt=
es of 0xff, rather than the SPD eeprom data that I was expecting.

This is a big board with many DDR3 slots. It is possible that
Supermicro put them being an I2C multiplexer. That would explain why
you don't "see" them, the multiplexer must enable the right branch
before you can see the SPD EEPROMs.

Please ask Supermicro about it. If the memory slots are behind an I2C
multiplexer, ask them if the multiplexer is I2C-based or GPIO-based. If
I2C-based, ask for the multiplexer type and address. If GPIO-based, ask
for the chip name and pin numbers for the GPIOs. In both case, please
ask which GPIO combinations map to which memory slots.

I've done that before for the Asus Z8 series, so if you can get all the
technical details from Supermicro, I should be able to add support for
your board to the i2c-i801 drivers.

--=20
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
