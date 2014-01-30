From: Alun Evans <alun@badgerous.net>
Date: Thu, 30 Jan 2014 04:14:00 +0000
Subject: Re: [lm-sensors] Reading SPD on Intel Patsburg on Supermicro X9SRG-F board
Message-Id: <4AADE829-D42D-478A-96E1-2A6E8AF2BF83@badgerous.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8345313403080268536=="
List-Id: <lm-sensors.vger.kernel.org>
References: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
In-Reply-To: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
To: lm-sensors@vger.kernel.org


--===============8345313403080268536==
Content-Type: multipart/signed; boundary="Apple-Mail=_6B537A9E-9CD0-41A1-8DDF-7C53009D58C7"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_6B537A9E-9CD0-41A1-8DDF-7C53009D58C7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On 29 Jan 2014, at 19:39, Alun Evans <alun@badgerous.net> wrote:

>=20
> On 29 Jan 2014, at 17:42, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
>> On Wed, Jan 29, 2014 at 05:30:14PM -0800, Guenter Roeck wrote:
>>> On Wed, Jan 29, 2014 at 05:12:48PM -0800, Alun Evans wrote:
>>>>=20
>>>> On 29 Jan 2014, at 11:48, Alun Evans <alun@badgerous.net> wrote:
>>>>=20
>>>>> Thanks for the responses everyone, inline,
>>>>>=20
>>>>> On 29 Jan 2014, at 10:25, Guenter Roeck <linux@roeck-us.net> =
wrote:
>>>>>=20
>>>>>> On Wed, Jan 29, 2014 at 05:42:24PM +0100, Jean Delvare wrote:
>>>>>>> Hi Alun,
>>>>>>> <snip>
>>>>>>=20
>>>>>>> Please ask Supermicro about it.
>>>>>=20
>>>>> I have put a request in=85 We=92ll see if I get a response.
>>>>>=20
>>>>>>> If the memory slots are behind an I2C
>>>>>>> multiplexer, ask them if the multiplexer is I2C-based or =
GPIO-based. If
>>>>>>> I2C-based, ask for the multiplexer type and address. If =
GPIO-based, ask
>>>>>>> for the chip name and pin numbers for the GPIOs. In both case, =
please
>>>>>>> ask which GPIO combinations map to which memory slots.
>>>>=20
>>>> I inlined the above hunk with my question, and the first response =
was:
>>>>=20
>>>>> Received feedback; The memory address does not use mux.  It is =
hardware defined by Intel.
>>>>=20
>>>> So I went and clarified I was not talking about the DDR physical =
address setup by the memory reference code, and I got:
>>>>=20
>>>>> Per our engineer; There is no hardware connecting to DIMM.
>>>>=20
>>>> I=92m not sure I=92ve found the right help here...
>>>>=20
>>> Actually you might have. On some HW the DIMMs are connceted to a =
separate
>>> SMBus channel which is not visible to SW.
>>>=20
>> I had a quick glance into the Patsburg (c600) datasheet. The chip has
>> up to four SMBus channels, depending on chip variant. Are you sure
>> that you are talking to the correct one ? What do you see with lspci =
?
>=20
> I am talking to that one:
>=20
> $ sudo lspci -v -v -v -s 0000:00:1f.3
> 00:1f.3 SMBus: Intel Corporation C600/X79 series chipset SMBus Host =
Controller (rev 05)
>        Subsystem: Super Micro Computer Inc Device 0661
>        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium =
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Interrupt: pin C routed to IRQ 18
>        Region 0: Memory at fba20000 (64-bit, non-prefetchable) =
[size=3D256]
>        Region 4: I/O ports at 1180 [size=3D32]
>        Kernel driver in use: i801_smbus
>        Kernel modules: i2c-i801
>=20
> Whether or not the DIMMs are connected to it is a good question.
>=20
> It=92s a C602:
> http://www.supermicro.com/products/motherboard/xeon/c600/x9srg-f.cfm
>=20
>=20
> Thinking about it, this Xeon has an integrated memory controller with =
4 DDR3 channels, each of which can have 3 DIMMs per channel. That=92s =
potentially 12 DIMMs on a board, which exceeds the 8 addressable SPDs =
given the 3 pins for addressing (SA{0-2}). While this board only has 8 =
DIMMs, it would make some sense if they were split in half with a mux =
somewhere.
>=20
>=20

With some debug hacks to ipmi_devintf, running this:


$ sudo ./ipmicfg-linux.x86_64 -nm cpumemtemp
CPU#0 =3D 35(c)
[CPU#0]CHANNEL#2, DIMM#0(P1_DIMMC1) =3D 24(c)
[CPU#0]CHANNEL#2, DIMM#1(P1_DIMMC2) =3D 24(c)

Gets me a ton of:
ipmi-req: type:0xc chan:15
ipmi-rsp: type:0xc chan:15

then exactly this:

ipmi-req: type:0x1 chan:0
ipmi-rsp: type:0x1 chan:0
ipmi-req: type:0x1 chan:0
ipmi-rsp: type:0x1 chan:0
ipmi-req: type:0x1 chan:0
ipmi-rsp: type:0x1 chan:0

That type is

/* An IPMB Address. */
#define IPMI_IPMB_ADDR_TYPE		0x01

So looks like I enter this hunk:

=
https://github.com/mirrors/linux/blob/master/drivers/char/ipmi/ipmi_msghan=
dler.c#L1559

And that bails if !=3D IPMI_CHANNEL_MEDIUM_IPMB, and from

=
http://www.intel.com/content/dam/www/public/us/en/documents/product-briefs=
/second-gen-interface-spec-v2-rev1-4.pdf

6.5 Channel Medium Type=20

1 IPMB (I2C)


Maybe I can convince the IPMI interface to take me out to the I2C bus =
then. Not sure how it is solving the addressing issue though.



A.

--=20
Alun Evans

--Apple-Mail=_6B537A9E-9CD0-41A1-8DDF-7C53009D58C7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlLp0YgACgkQDX2x+/Q7Ga3ROACff7Vgd5YVsT/D7bxjih4uqemP
RSwAni/bNAttB0Qgfjsk9GWn2bIF75gM
=64er
-----END PGP SIGNATURE-----

--Apple-Mail=_6B537A9E-9CD0-41A1-8DDF-7C53009D58C7--


--===============8345313403080268536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8345313403080268536==--
