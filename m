From: =?ISO-8859-1?Q?J=FCrgen_Fuchsberger?= <juergen.fuchsberger@uni-graz.at>
Date: Wed, 12 Feb 2014 10:10:54 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <52FB48AE.5050208@uni-graz.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3823544132479850256=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3823544132479850256==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wEpiNON72Wr6rdceoJN8hJ5BEolhFfpJM"

--wEpiNON72Wr6rdceoJN8hJ5BEolhFfpJM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 02/12/2014 10:37 AM, Juerg Haefliger wrote:
>=20
>=20
>=20
> On Wed, Feb 12, 2014 at 9:52 AM, J=FCrgen Fuchsberger
> <juergen.fuchsberger@uni-graz.at
> <mailto:juergen.fuchsberger@uni-graz.at>> wrote:
>>
>>
>>
>> On 02/11/2014 08:24 PM, Guenter Roeck wrote:
>> > On Tue, Feb 11, 2014 at 10:54:55AM +0100, J=FCrgen Fuchsberger wrote=
:
>> >> Hi,
>> >>
>> >> On 02/11/2014 08:32 AM, Juerg Haefliger wrote:
>> >>> Hi Juergen,
>> >>>
>> >>> You're likely to get better help by contacting the LM sensors mail=
ing
>> >>> list (cc'ed). I've been out of it for a bit.
>> >>
>> >> Thanks!
>> >>>
>> >>>
>> >>>> Dear Juerg,
>> >>>>
>> >>>> I keep getting Errors of this kind:
>> >>>>
>> >>>> Feb 10 09:51:09 wegc203094 kernel: [  156.372033] dme1737 1-002c:=

> Read
>> >>>> from register 0x6d failed! Please report to the driver maintainer=
=2E
>> >>>> Feb 10 09:53:09 wegc203094 kernel: [  276.472043] dme1737 1-002c:=

> Read
>> >>>> from register 0x69 failed! Please report to the driver maintainer=
=2E
>> >>>
>> >>> Can you post all messages from the driver from the time it was loa=
ded?
>> >>
>> >> Feb 10 09:48:47 wegc203094 kernel: [    8.368070] i2c i2c-1: Found =
a
>> >> DME1737 chip at 0x2c (rev 0x8a).
>> >> Feb 10 09:48:47 wegc203094 kernel: [    8.384103] dme1737 1-002c:
>> >> Optional features: pwm3=3Dno, pwm5=3Dno, pwm6=3Dno, fan3=3Dno, fan4=
=3Dno,
> fan5=3Dno,
>> >> fan6=3Dno.
>> >> Feb 10 09:4
>> >>
>> >>
>> >>> What's the model of the machine you're using?
>> >> Hmm, unfortunately I don't know. Is there a way to find out without=

>> >> opening the server? (I mean by sw-tools?)
>> >>
>> > If this is a PC, "sudo dmidecode" might tell you a lot.
>> >
>> OK, thanks. Looks like it's a Tyan S2932/S2932-E/S2932-SI board. I
>> attached the dmidecode info.
>>
>> >>> What do you get when running the sensors-detect script?
>> >>
>> >> ~ % sensors
>> >>
>> >>
>> > sensors-detect, not sensors ;-).
>> >
>> > Anyway, can you provide the output of "sudo i2cdump -y -f 1 0x2c" ?
>> > That might actually help more.
>>
>> Debian package lm-sensors does not provide i2cdump so I did
> sensors-detect:
>=20
> i2cdump is provided by the i2c-tools package.
>=20
ah, thanks.

Did not work:

sudo i2cdump -y -f 1 0x2c
No size specified (using byte-data access)
Error: Could not open file `/dev/i2c-1' or `/dev/i2c/1': No such file or
directory

Juergen.
>> Driver `to-be-written':
>>   * ISA bus, address 0xca8
>>     Chip `IPMI BMC KCS' (confidence: 8)
>>
>> Driver `dme1737':
>>   * Bus `SMBus nForce2 adapter at 2e00'
>>     Busdriver `i2c_nforce2', I2C address 0x2c
>>     Chip `dme1737' (confidence: 6)
>>
>> Driver `lm85':
>>   * Bus `SMBus nForce2 adapter at 2e00'
>>     Busdriver `i2c_nforce2', I2C address 0x2d
>>     Chip `emc6d103' (confidence: 6)
>>   * Bus `SMBus nForce2 adapter at 2e00'
>>     Busdriver `i2c_nforce2', I2C address 0x2e
>>     Chip `emc6d103' (confidence: 6)
>>
>> Note: there is no driver for IPMI BMC KCS yet.
>> Check http://www.lm-sensors.org/wiki/Devices for updates.
>>
>> To load everything that is needed, add this to /etc/modules:
>> #----cut here----
>> # Chip drivers
>> dme1737
>> lm85
>> #----cut here----
>> If you have some drivers built into your kernel, the list above will
>> contain too many modules. Skip the appropriate ones!
>>
>> Do you want to add these lines automatically to /etc/modules? (yes/NO)=

>>
>> Unloading i2c-dev... OK
>> Unloading cpuid... OK
>>
>>
>>
>> >
>> > Also, are the errors persistent or sporadic ?
>> >
>> Persistent, current messages contains 703 error lines.
>>
>> Juergen.
>>

--=20
| J=FCrgen Fuchsberger, M.Sc.
| Wegener Center for Climate and Global Change
| University of Graz
| Brandhofgasse 5, A-8010 Graz, Austria
| phone: +43-316-380-8438
|   web: www.wegcenter.at/wegenernet
|        www.wegenernet.org


--wEpiNON72Wr6rdceoJN8hJ5BEolhFfpJM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iF4EAREIAAYFAlL7SK4ACgkQ4RNsce5/DgAEUAD/Xce9sZrIcf19TizlfITpVGNN
Fmrws7RszQWlCDYTtqsA/j6Y2mpsSXZl3wrM7bKIEAbfp4AslFp1/5vB2bFJ4AP2
=U6Rb
-----END PGP SIGNATURE-----

--wEpiNON72Wr6rdceoJN8hJ5BEolhFfpJM--


--===============3823544132479850256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3823544132479850256==--
