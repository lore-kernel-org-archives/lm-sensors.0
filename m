From: Alun Evans <alun@badgerous.net>
Date: Thu, 30 Jan 2014 03:23:23 +0000
Subject: Re: [lm-sensors] Reading SPD on Intel Patsburg on Supermicro X9SRG-F board
Message-Id: <BD31E6F2-D971-4618-B18C-FEDD78678073@badgerous.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4509311166627802899=="
List-Id: <lm-sensors.vger.kernel.org>
References: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
In-Reply-To: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
To: lm-sensors@vger.kernel.org


--===============4509311166627802899==
Content-Type: multipart/signed; boundary="Apple-Mail=_A286C5FA-D845-4E20-8A83-94D978A92181"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_A286C5FA-D845-4E20-8A83-94D978A92181
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On 29 Jan 2014, at 17:30, Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Jan 29, 2014 at 05:12:48PM -0800, Alun Evans wrote:
>>=20
>> On 29 Jan 2014, at 11:48, Alun Evans <alun@badgerous.net> wrote:
>>=20
>>> Thanks for the responses everyone, inline,
>>>=20
>>> On 29 Jan 2014, at 10:25, Guenter Roeck <linux@roeck-us.net> wrote:
>>>=20
>>>> On Wed, Jan 29, 2014 at 05:42:24PM +0100, Jean Delvare wrote:
>>>>> Hi Alun,
>>>>> <snip>
>>>>=20
>>>>> Please ask Supermicro about it.
>>>=20
>>> I have put a request in=85 We=92ll see if I get a response.
>>>=20
>>>>> If the memory slots are behind an I2C
>>>>> multiplexer, ask them if the multiplexer is I2C-based or =
GPIO-based. If
>>>>> I2C-based, ask for the multiplexer type and address. If =
GPIO-based, ask
>>>>> for the chip name and pin numbers for the GPIOs. In both case, =
please
>>>>> ask which GPIO combinations map to which memory slots.
>>=20
>> I inlined the above hunk with my question, and the first response =
was:
>>=20
>>> Received feedback; The memory address does not use mux.  It is =
hardware defined by Intel.
>>=20
>> So I went and clarified I was not talking about the DDR physical =
address setup by the memory reference code, and I got:
>>=20
>>> Per our engineer; There is no hardware connecting to DIMM.
>>=20
>> I=92m not sure I=92ve found the right help here...
>>=20
> Actually you might have. On some HW the DIMMs are connceted to a =
separate
> SMBus channel which is not visible to SW.

hmm, that was my worry.

Seemingly though IPMI is going via the BMC chip over an I2C bus to pull =
the temperatures from the DIMMs.

I wonder if I=92m meant to be going that way as well to get the access =
to that I2C bus.


A.

--=20
Alun Evans

--Apple-Mail=_A286C5FA-D845-4E20-8A83-94D978A92181
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iEYEARECAAYFAlLpxasACgkQDX2x+/Q7Ga3w7wCeLFkcsWfLQgxAo0xoRBWAeguO
3HMAoIaFpX7mXNtNm+VIYRNAJd4+kefj
=8YVN
-----END PGP SIGNATURE-----

--Apple-Mail=_A286C5FA-D845-4E20-8A83-94D978A92181--


--===============4509311166627802899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4509311166627802899==--
