From: Alun Evans <alun@badgerous.net>
Date: Thu, 30 Jan 2014 01:12:48 +0000
Subject: Re: [lm-sensors] Reading SPD on Intel Patsburg on Supermicro X9SRG-F board
Message-Id: <F315E2E8-E1FC-4782-91B7-649A6D929CBB@badgerous.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0884675897660044782=="
List-Id: <lm-sensors.vger.kernel.org>
References: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
In-Reply-To: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
To: lm-sensors@vger.kernel.org


--===============0884675897660044782==
Content-Type: multipart/signed; boundary="Apple-Mail=_F87980B1-BBBF-4B0E-B7AE-AB0BCD6D6CD6"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_F87980B1-BBBF-4B0E-B7AE-AB0BCD6D6CD6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On 29 Jan 2014, at 11:48, Alun Evans <alun@badgerous.net> wrote:

> Thanks for the responses everyone, inline,
>=20
> On 29 Jan 2014, at 10:25, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
>> On Wed, Jan 29, 2014 at 05:42:24PM +0100, Jean Delvare wrote:
>>> Hi Alun,
>>> <snip>
>>=20
>>> Please ask Supermicro about it.
>=20
> I have put a request in=85 We=92ll see if I get a response.
>=20
>>> If the memory slots are behind an I2C
>>> multiplexer, ask them if the multiplexer is I2C-based or GPIO-based. =
If
>>> I2C-based, ask for the multiplexer type and address. If GPIO-based, =
ask
>>> for the chip name and pin numbers for the GPIOs. In both case, =
please
>>> ask which GPIO combinations map to which memory slots.

I inlined the above hunk with my question, and the first response was:

> Received feedback; The memory address does not use mux.  It is =
hardware defined by Intel.

So I went and clarified I was not talking about the DDR physical address =
setup by the memory reference code, and I got:

> Per our engineer; There is no hardware connecting to DIMM.

I=92m not sure I=92ve found the right help here...


A.

--=20
Alun Evans

--Apple-Mail=_F87980B1-BBBF-4B0E-B7AE-AB0BCD6D6CD6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlLppxAACgkQDX2x+/Q7Ga1/1wCfXkzr9o+zD2k6IFVASC/ArH3u
r1IAnjK22cz98VZR37qWqeVsxSUpmNdC
=2CY4
-----END PGP SIGNATURE-----

--Apple-Mail=_F87980B1-BBBF-4B0E-B7AE-AB0BCD6D6CD6--


--===============0884675897660044782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0884675897660044782==--
