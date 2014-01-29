From: Alun Evans <alun@badgerous.net>
Date: Wed, 29 Jan 2014 19:48:47 +0000
Subject: Re: [lm-sensors] Reading SPD on Intel Patsburg on Supermicro X9SRG-F board
Message-Id: <92E9784F-6262-4D54-BF2F-191AF7617196@badgerous.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5719977912855716941=="
List-Id: <lm-sensors.vger.kernel.org>
References: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
In-Reply-To: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
To: lm-sensors@vger.kernel.org


--===============5719977912855716941==
Content-Type: multipart/signed; boundary="Apple-Mail=_960C7A04-7637-4601-9487-659A1E4BFAC7"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_960C7A04-7637-4601-9487-659A1E4BFAC7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Thanks for the responses everyone, inline,

On 29 Jan 2014, at 10:25, Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Jan 29, 2014 at 05:42:24PM +0100, Jean Delvare wrote:
>> Hi Alun,
>>=20
>> On Tue, 28 Jan 2014 20:57:00 -0800, Alun Evans wrote:
>>> I=92m trying to get some sense out of this:
>>>=20
>>> 00:1f.3 SMBus: Intel Corporation C600/X79 series chipset SMBus Host =
Controller (rev 05)
>>>        Subsystem: Super Micro Computer Inc Device 0661
>>>        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx-
>>>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium =
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>>        Interrupt: pin C routed to IRQ 18
>>>        Region 0: Memory at fba20000 (64-bit, non-prefetchable) =
[size=3D256]
>>>        Region 4: I/O ports at 1180 [size=3D32]
>>>        Kernel driver in use: i801_smbus
>>>        Kernel modules: i2c-i801
>>>=20
>>> $ sudo i2cdetect -l
>>> i2c-0   smbus           SMBus I801 adapter at 1180              =
SMBus adapter
>>> i2c-1   i2c             igb BB                                  I2C =
adapter
>>> i2c-2   i2c             igb BB                                  I2C =
adapter
>>>=20
>>> The following doesn=92t make sense to me:
>>>=20
>>> $ sudo i2cdetect 0
>>> WARNING! This program can confuse your I2C bus, cause data loss and =
worse!
>>> I will probe file /dev/i2c-0.
>>> I will probe address range 0x03-0x77.
>>> Continue? [Y/n] Y
>>>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --=20
>>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- 2d -- --=20
>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
>>> 40: -- -- -- -- 44 -- -- -- 48 -- -- -- -- -- -- --=20
>>> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
>>> 60: -- -- -- -- -- -- -- -- 68 69 -- -- 6c -- -- --=20
>>> 70: -- -- -- -- -- -- -- --                        =20
>>>=20
>>> Since I have two RDIMMs on this board:
>>>=20
>>> $ sudo ./ipmicfg-linux.x86_64 -nm cpumemtemp
>>> CPU#0 =3D 35(c)
>>> [CPU#0]CHANNEL#2, DIMM#0(P1_DIMMC1) =3D 24(c)
>>> [CPU#0]CHANNEL#2, DIMM#1(P1_DIMMC2) =3D 24(c)
>>>=20
>>> And snooping the bus on boot up with a total phase Aardvark, I see =
that the DIMMs are on addr 0x50, and 0x51, and if I dump 0x50, I just =
see 256 bytes of 0xff, rather than the SPD eeprom data that I was =
expecting.
>>=20
>> This is a big board with many DDR3 slots.

Heh, this is a 8-DIMM board. We=92ve just ordered a 24-DIMM board, with =
an eye to a 48-DIMM board.

>> It is possible that
>> Supermicro put them being an I2C multiplexer. That would explain why
>> you don't "see" them, the multiplexer must enable the right branch
>> before you can see the SPD EEPROMs.
>>=20
> Agreed, especially since the SPD on 0x51 does not show up at all.
>=20
>> Please ask Supermicro about it.

I have put a request in=85 We=92ll see if I get a response.

>> If the memory slots are behind an I2C
>> multiplexer, ask them if the multiplexer is I2C-based or GPIO-based. =
If
>> I2C-based, ask for the multiplexer type and address. If GPIO-based, =
ask
>> for the chip name and pin numbers for the GPIOs. In both case, please
>> ask which GPIO combinations map to which memory slots.
>>=20
> I would suspect it is GPIO; the i2c muxes are typically at address =
0x7x
> which is empty in above i2cdetect log. The DSDT might give a hint if =
we
> are really lucky. Not that I am any good in decoding DSDTs, though =
;-).

I followed : https://01.org/linux-acpi/utilities

And there is this hunk:

    OperationRegion (GPIO, SystemIO, GPBS, 0x20)
    Field (GPIO, DWordAcc, NoLock, Preserve)
    {
        Offset (0x0C),=20
        GLVL,   32,=20
        Offset (0x18),=20
        GBLK,   32
    }



A.


--=20
Alun Evans

--Apple-Mail=_960C7A04-7637-4601-9487-659A1E4BFAC7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlLpWx8ACgkQDX2x+/Q7Ga0uxgCcCH/2+MyKw77pg1LY/9DCr7P4
Q7kAn0Y8dhCpMf3dsDdoh9HB5JQwF2hH
=8856
-----END PGP SIGNATURE-----

--Apple-Mail=_960C7A04-7637-4601-9487-659A1E4BFAC7--


--===============5719977912855716941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5719977912855716941==--
