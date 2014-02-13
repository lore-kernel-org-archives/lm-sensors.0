From: =?ISO-8859-1?Q?J=FCrgen_Fuchsberger?= <juergen.fuchsberger@uni-graz.at>
Date: Thu, 13 Feb 2014 06:39:04 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <52FC6888.3050900@uni-graz.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4756370181965968494=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============4756370181965968494==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9TAIKwvxSkUR7ikjEvakiFh00d89K2PdM"

--9TAIKwvxSkUR7ikjEvakiFh00d89K2PdM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 02/12/2014 03:24 PM, Guenter Roeck wrote:
> On 02/12/2014 04:05 AM, Jean Delvare wrote:
>> On Wed, 12 Feb 2014 03:54:44 -0800, Guenter Roeck wrote:
>>> On 02/12/2014 03:07 AM, J=FCrgen Fuchsberger wrote:
>>>> i2cdump.txt
>>>>
>>>>
>>>>        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f  =20
>>>> 0123456789abcdef
>>>> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .............=
=2E..
>>>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .............=
=2E..
>>>> 20: 36 00 c0 3a c4 80 27 80 ff ff ff ff ff ff ff ff    6.?:??'?.....=
=2E..
>>>> 30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 5c 8a    .............=
=2E\?
>>>> 40: 0f db c0 20 ad d3 00 ff ad d3 ad d3 ad d3 81 7f    ??? ??..?????=
???
>>>> 50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 cb    ????........b=
bb?
>>>> 60: cb cb e0 00 80 80 80 80 80 80 64 64 64 44 40 00    ???.??????ddd=
D@.
>>>> 70: ff ff ff 09 09 09 09 09 09 00 00 00 40 00 ec 10    ...??????...@=
=2E??
>>>> 80: 7e a4 0e 00 d3 00 87 74 e0 00 4d 4d 0b 0b 0d 00    ~??.?.?t?.MM?=
??.
>>>> 90: 04 04 04 04 0c 0c 0c 5a f1 c0 af ad d3 9d c0 00    ???????Z?????=
??.
>>>> a0: 00 00 0c 00 02 ff ff 0b 0b fe ff fe ff ff ff ff    ..?.?..???.?.=
=2E..
>>>> b0: ff 00 00 00 00 00 28 28 0e 0e 0f 0f 00 00 00 00    ......((????.=
=2E..
>>>> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .............=
=2E..
>>>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .............=
=2E..
>>>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .............=
=2E..
>>>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .............=
=2E..
>>>
>>> That looks normal for the chip as far as I can see, and there are
>>> no errors.
>>
>> The board supports IPMI. I would guess that the errors happen when the=

>> native driver and IPMI attempt to access the SMBus at the same time.
>>
> Yes, that would explanin the problem.
>=20
>> As usual, my recommendation is to either use IPMI or native drivers bu=
t
>> not mix.
>>
> Agreed.
>=20
OK, how can I choose which driver to use?

Juergen.



--9TAIKwvxSkUR7ikjEvakiFh00d89K2PdM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iF4EAREIAAYFAlL8aIgACgkQ4RNsce5/DgAx6gD/c8v0uR5mDiTPNYOE6UBu4rwu
9cImC/XJ6E3nIaBv5kEA/ApHfw1CaEx4OxfQPX6tppvY0+RdA/U8UvW009A2W+vk
=E349
-----END PGP SIGNATURE-----

--9TAIKwvxSkUR7ikjEvakiFh00d89K2PdM--


--===============4756370181965968494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4756370181965968494==--
