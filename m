From: Alun Evans <alun@badgerous.net>
Date: Thu, 30 Jan 2014 03:39:47 +0000
Subject: Re: [lm-sensors] Reading SPD on Intel Patsburg on Supermicro X9SRG-F board
Message-Id: <A1BAC37A-7ED6-40AF-86C9-2B6EB6CFE2A9@badgerous.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8497593274611900279=="
List-Id: <lm-sensors.vger.kernel.org>
References: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
In-Reply-To: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
To: lm-sensors@vger.kernel.org


--===============8497593274611900279==
Content-Type: multipart/signed; boundary="Apple-Mail=_65E27BE7-C8F5-446B-8769-57B638EC3891"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_65E27BE7-C8F5-446B-8769-57B638EC3891
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On 29 Jan 2014, at 17:42, Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Jan 29, 2014 at 05:30:14PM -0800, Guenter Roeck wrote:
>> On Wed, Jan 29, 2014 at 05:12:48PM -0800, Alun Evans wrote:
>>>=20
>>> On 29 Jan 2014, at 11:48, Alun Evans <alun@badgerous.net> wrote:
>>>=20
>>>> Thanks for the responses everyone, inline,
>>>>=20
>>>> On 29 Jan 2014, at 10:25, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>=20
>>>>> On Wed, Jan 29, 2014 at 05:42:24PM +0100, Jean Delvare wrote:
>>>>>> Hi Alun,
>>>>>> <snip>
>>>>>=20
>>>>>> Please ask Supermicro about it.
>>>>=20
>>>> I have put a request in=85 We=92ll see if I get a response.
>>>>=20
>>>>>> If the memory slots are behind an I2C
>>>>>> multiplexer, ask them if the multiplexer is I2C-based or =
GPIO-based. If
>>>>>> I2C-based, ask for the multiplexer type and address. If =
GPIO-based, ask
>>>>>> for the chip name and pin numbers for the GPIOs. In both case, =
please
>>>>>> ask which GPIO combinations map to which memory slots.
>>>=20
>>> I inlined the above hunk with my question, and the first response =
was:
>>>=20
>>>> Received feedback; The memory address does not use mux.  It is =
hardware defined by Intel.
>>>=20
>>> So I went and clarified I was not talking about the DDR physical =
address setup by the memory reference code, and I got:
>>>=20
>>>> Per our engineer; There is no hardware connecting to DIMM.
>>>=20
>>> I=92m not sure I=92ve found the right help here...
>>>=20
>> Actually you might have. On some HW the DIMMs are connceted to a =
separate
>> SMBus channel which is not visible to SW.
>>=20
> I had a quick glance into the Patsburg (c600) datasheet. The chip has
> up to four SMBus channels, depending on chip variant. Are you sure
> that you are talking to the correct one ? What do you see with lspci ?

I am talking to that one:

$ sudo lspci -v -v -v -s 0000:00:1f.3
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

Whether or not the DIMMs are connected to it is a good question.

It=92s a C602:
http://www.supermicro.com/products/motherboard/xeon/c600/x9srg-f.cfm


Thinking about it, this Xeon has an integrated memory controller with 4 =
DDR3 channels, each of which can have 3 DIMMs per channel. That=92s =
potentially 12 DIMMs on a board, which exceeds the 8 addressable SPDs =
given the 3 pins for addressing (SA{0-2}). While this board only has 8 =
DIMMs, it would make some sense if they were split in half with a mux =
somewhere.



A.

--=20
Alun Evans

--Apple-Mail=_65E27BE7-C8F5-446B-8769-57B638EC3891
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlLpyYMACgkQDX2x+/Q7Ga3EmgCeMbzqKGxsNglcalTu71MRK+fI
oXQAnjgZB7xaYaAw4ZBDIjTPte8OG46Z
=LxNk
-----END PGP SIGNATURE-----

--Apple-Mail=_65E27BE7-C8F5-446B-8769-57B638EC3891--


--===============8497593274611900279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8497593274611900279==--
