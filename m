From: Alun Evans <alun@badgerous.net>
Date: Wed, 29 Jan 2014 22:21:12 +0000
Subject: Re: [lm-sensors] Reading SPD on Intel Patsburg on Supermicro X9SRG-F board
Message-Id: <DAF7D913-FC23-4981-B966-38AE05919AEB@badgerous.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8822590115273143280=="
List-Id: <lm-sensors.vger.kernel.org>
References: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
In-Reply-To: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
To: lm-sensors@vger.kernel.org


--===============8822590115273143280==
Content-Type: multipart/signed; boundary="Apple-Mail=_C5811058-DE3B-4295-BB47-2D02FEA9F196"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_C5811058-DE3B-4295-BB47-2D02FEA9F196
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On 29 Jan 2014, at 11:55, Jean Delvare <khali@linux-fr.org> wrote:

> On Wed, 29 Jan 2014 11:48:47 -0800, Alun Evans wrote:
>>>> This is a big board with many DDR3 slots.
>>=20
>> Heh, this is a 8-DIMM board. We=92ve just ordered a 24-DIMM board, =
with an eye to a 48-DIMM board.
>=20
> Right, 8 DIMMs would normally not require multiplexing. But vendors
> like to reuse designs and your 8-DIMM board is probably a "small"
> version of something bigger. My Asus Z8NA-D6 has only 6 DIMMs but it
> has an I2C multiplexer anyway.

Ah, that is likely with an SM board certainly.

>=20
>>> (...)
>>> I would suspect it is GPIO; the i2c muxes are typically at address =
0x7x
>>> which is empty in above i2cdetect log. The DSDT might give a hint if =
we
>>> are really lucky. Not that I am any good in decoding DSDTs, though =
;-).
>>=20
>> I followed : https://01.org/linux-acpi/utilities
>>=20
>> And there is this hunk:
>>=20
>>    OperationRegion (GPIO, SystemIO, GPBS, 0x20)
>>    Field (GPIO, DWordAcc, NoLock, Preserve)
>>    {
>>        Offset (0x0C),=20
>>        GLVL,   32,=20
>>        Offset (0x18),=20
>>        GBLK,   32
>>    }
>=20
> And can you tell us what GPBS is?
>=20

Looks like it=92s GPIOBASE.

I=92ve never looked at ACPI/DSDT, so I=92ve not clue what I=92m doing =
here.

I could send the entire del file, but I don=92t want to trouble anyone =
unnecessarily.

A.

--=20
Alun Evans

--Apple-Mail=_C5811058-DE3B-4295-BB47-2D02FEA9F196
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlLpftgACgkQDX2x+/Q7Ga07BwCfdnbotoc29gZeYIxTOCNCjamg
+jsAnjvg5ZAjKXkqQqNmC2wZPK2dYNyn
=QIaT
-----END PGP SIGNATURE-----

--Apple-Mail=_C5811058-DE3B-4295-BB47-2D02FEA9F196--


--===============8822590115273143280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8822590115273143280==--
