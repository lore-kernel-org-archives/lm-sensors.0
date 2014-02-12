From: =?ISO-8859-1?Q?J=FCrgen_Fuchsberger?= <juergen.fuchsberger@uni-graz.at>
Date: Wed, 12 Feb 2014 11:07:24 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <52FB55EC.8020906@uni-graz.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9007659869510527181=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============9007659869510527181==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qpQmBLtbP8ltKblrK0dorpUihxH9htJI9"

--qpQmBLtbP8ltKblrK0dorpUihxH9htJI9
Content-Type: multipart/mixed;
 boundary="------------000804040107010909000106"

This is a multi-part message in MIME format.
--------------000804040107010909000106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 02/12/2014 11:33 AM, Juerg Haefliger wrote:
>=20
>=20
>=20
> On Wed, Feb 12, 2014 at 11:10 AM, J=FCrgen Fuchsberger
> <juergen.fuchsberger@uni-graz.at
> <mailto:juergen.fuchsberger@uni-graz.at>> wrote:
>>
>>
>>
>> On 02/12/2014 10:37 AM, Juerg Haefliger wrote:
>> >
>> >
>> >
>> > On Wed, Feb 12, 2014 at 9:52 AM, J=FCrgen Fuchsberger
>> > <juergen.fuchsberger@uni-graz.at
> <mailto:juergen.fuchsberger@uni-graz.at>
>> > <mailto:juergen.fuchsberger@uni-graz.at
> <mailto:juergen.fuchsberger@uni-graz.at>>> wrote:
>> >>
>> >>
>> >>
>> >> On 02/11/2014 08:24 PM, Guenter Roeck wrote:
>> >> > On Tue, Feb 11, 2014 at 10:54:55AM +0100, J=FCrgen Fuchsberger wr=
ote:
>> >> >> Hi,
>> >> >>
>> >> >> On 02/11/2014 08:32 AM, Juerg Haefliger wrote:
>> >> >>> Hi Juergen,
>> >> >>>
>> >> >>> You're likely to get better help by contacting the LM sensors
> mailing
>> >> >>> list (cc'ed). I've been out of it for a bit.
>> >> >>
>> >> >> Thanks!
>> >> >>>
>> >> >>>
>> >> >>>> Dear Juerg,
>> >> >>>>
>> >> >>>> I keep getting Errors of this kind:
>> >> >>>>
>> >> >>>> Feb 10 09:51:09 wegc203094 kernel: [  156.372033] dme1737 1-00=
2c:
>> > Read
>> >> >>>> from register 0x6d failed! Please report to the driver maintai=
ner.
>> >> >>>> Feb 10 09:53:09 wegc203094 kernel: [  276.472043] dme1737 1-00=
2c:
>> > Read
>> >> >>>> from register 0x69 failed! Please report to the driver maintai=
ner.
>> >> >>>
>> >> >>> Can you post all messages from the driver from the time it was
> loaded?
>> >> >>
>> >> >> Feb 10 09:48:47 wegc203094 kernel: [    8.368070] i2c i2c-1: Fou=
nd a
>> >> >> DME1737 chip at 0x2c (rev 0x8a).
>> >> >> Feb 10 09:48:47 wegc203094 kernel: [    8.384103] dme1737 1-002c=
:
>> >> >> Optional features: pwm3=3Dno, pwm5=3Dno, pwm6=3Dno, fan3=3Dno, f=
an4=3Dno,
>> > fan5=3Dno,
>> >> >> fan6=3Dno.
>> >> >> Feb 10 09:4
>> >> >>
>> >> >>
>> >> >>> What's the model of the machine you're using?
>> >> >> Hmm, unfortunately I don't know. Is there a way to find out with=
out
>> >> >> opening the server? (I mean by sw-tools?)
>> >> >>
>> >> > If this is a PC, "sudo dmidecode" might tell you a lot.
>> >> >
>> >> OK, thanks. Looks like it's a Tyan S2932/S2932-E/S2932-SI board. I
>> >> attached the dmidecode info.
>> >>
>> >> >>> What do you get when running the sensors-detect script?
>> >> >>
>> >> >> ~ % sensors
>> >> >>
>> >> >>
>> >> > sensors-detect, not sensors ;-).
>> >> >
>> >> > Anyway, can you provide the output of "sudo i2cdump -y -f 1 0x2c"=
 ?
>> >> > That might actually help more.
>> >>
>> >> Debian package lm-sensors does not provide i2cdump so I did
>> > sensors-detect:
>> >
>> > i2cdump is provided by the i2c-tools package.
>> >
>> ah, thanks.
>>
>> Did not work:
>>
>> sudo i2cdump -y -f 1 0x2c
>> No size specified (using byte-data access)
>> Error: Could not open file `/dev/i2c-1' or `/dev/i2c/1': No such file =
or
>> directory
>=20
> try:
> sudo modprobe i2c-dev
>=20
now it worked (see attached file).
>=20
>> Juergen.
>> >> Driver `to-be-written':
>> >>   * ISA bus, address 0xca8
>> >>     Chip `IPMI BMC KCS' (confidence: 8)
>> >>
>> >> Driver `dme1737':
>> >>   * Bus `SMBus nForce2 adapter at 2e00'
>> >>     Busdriver `i2c_nforce2', I2C address 0x2c
>> >>     Chip `dme1737' (confidence: 6)
>> >>
>> >> Driver `lm85':
>> >>   * Bus `SMBus nForce2 adapter at 2e00'
>> >>     Busdriver `i2c_nforce2', I2C address 0x2d
>> >>     Chip `emc6d103' (confidence: 6)
>> >>   * Bus `SMBus nForce2 adapter at 2e00'
>> >>     Busdriver `i2c_nforce2', I2C address 0x2e
>> >>     Chip `emc6d103' (confidence: 6)
>> >>
>> >> Note: there is no driver for IPMI BMC KCS yet.
>> >> Check http://www.lm-sensors.org/wiki/Devices for updates.
>> >>
>> >> To load everything that is needed, add this to /etc/modules:
>> >> #----cut here----
>> >> # Chip drivers
>> >> dme1737
>> >> lm85
>> >> #----cut here----
>> >> If you have some drivers built into your kernel, the list above wil=
l
>> >> contain too many modules. Skip the appropriate ones!
>> >>
>> >> Do you want to add these lines automatically to /etc/modules? (yes/=
NO)
>> >>
>> >> Unloading i2c-dev... OK
>> >> Unloading cpuid... OK
>> >>
>> >>
>> >>
>> >> >
>> >> > Also, are the errors persistent or sporadic ?
>> >> >
>> >> Persistent, current messages contains 703 error lines.
>> >>
>> >> Juergen.
>> >>
>>
>> --
>> | J=FCrgen Fuchsberger, M.Sc.
>> | Wegener Center for Climate and Global Change
>> | University of Graz
>> | Brandhofgasse 5, A-8010 Graz, Austria
>> | phone: +43-316-380-8438
>> |   web: www.wegcenter.at/wegenernet <http://www.wegcenter.at/wegenern=
et>
>> |        www.wegenernet.org <http://www.wegenernet.org>
>>

--=20
| J=FCrgen Fuchsberger, M.Sc.
| Wegener Center for Climate and Global Change
| University of Graz
| Brandhofgasse 5, A-8010 Graz, Austria
| phone: +43-316-380-8438
|   web: www.wegcenter.at/wegenernet
|        www.wegenernet.org

--------------000804040107010909000106
Content-Type: text/plain; charset=UTF-8;
 name="i2cdump.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="i2cdump.txt"

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 36 00 c0 3a c4 80 27 80 ff ff ff ff ff ff ff ff    6.?:??'?........
30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 5c 8a    ..............\?
40: 0f db c0 20 ad d3 00 ff ad d3 ad d3 ad d3 81 7f    ??? ??..????????
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 cb    ????........bbb?
60: cb cb e0 00 80 80 80 80 80 80 64 64 64 44 40 00    ???.??????dddD@.
70: ff ff ff 09 09 09 09 09 09 00 00 00 40 00 ec 10    ...??????...@.??
80: 7e a4 0e 00 d3 00 87 74 e0 00 4d 4d 0b 0b 0d 00    ~??.?.?t?.MM???.
90: 04 04 04 04 0c 0c 0c 5a f1 c0 af ad d3 9d c0 00    ???????Z???????.
a0: 00 00 0c 00 02 ff ff 0b 0b fe ff fe ff ff ff ff    ..?.?..???.?....
b0: ff 00 00 00 00 00 28 28 0e 0e 0f 0f 00 00 00 00    ......((????....
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

--------------000804040107010909000106--

--qpQmBLtbP8ltKblrK0dorpUihxH9htJI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iF4EAREIAAYFAlL7VewACgkQ4RNsce5/DgATpAD/esrc5BsofMyfuDQVEyuddafA
NpP1mRqKsH843w/OzvEA/0rCzvJJkvT1Vo8/i7L7lyqR/zreUPtXyMsullUes964
=l+/g
-----END PGP SIGNATURE-----

--qpQmBLtbP8ltKblrK0dorpUihxH9htJI9--


--===============9007659869510527181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9007659869510527181==--
