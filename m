From: =?ISO-8859-1?Q?J=FCrgen_Fuchsberger?= <juergen.fuchsberger@uni-graz.at>
Date: Tue, 18 Feb 2014 07:36:27 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <53030D7B.7010209@uni-graz.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5393914098643605575=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5393914098643605575==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LT9l1SiWvdQdLv5JO8mRO1ROITlnJ5pOe"

--LT9l1SiWvdQdLv5JO8mRO1ROITlnJ5pOe
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 02/18/2014 08:25 AM, Juerg Haefliger wrote:
>=20
>=20
>=20
> On Mon, Feb 17, 2014 at 4:55 PM, Jean Delvare <jdelvare@suse.de
> <mailto:jdelvare@suse.de>> wrote:
>>
>> Hallo J=FCrgen,
>>
>> On Mon, 17 Feb 2014 15:33:18 +0100, J=FCrgen Fuchsberger wrote:
>> > On 02/13/2014 08:32 AM, Jean Delvare wrote:
>> > > In your case, the native drivers are i2c-nforce2, dme1737 and
> lm85, and
>> > > the native tool is "sensors". The IPMI driver would be ipmi-si if =
I
>> > > remember correctly, and its tool is "ipmitool" or equivalent
> (there are
>> > > several IPMI packages out there, I don't know which ones are avail=
able
>> > > to you.) If you have a BMC card in the machine, that card would be=

>> > > accessing the monitoring chips over IPMI as well so it will happen=

> even
>> > > without any driver loaded.
>> > >
>> > > If you want to use IPMI (and if you have a BMC this is the only sa=
fe
>> > > option), blacklist i2c-nforce2 and delete your lm_sensors
> configuration
>> > > file (typically /etc/sysconfig/lm_sensors on a sysconfig-based sys=
tem,
>> > > might be different on your distributions, e.g. on Debian you'd jus=
t
>> > > delete the relevant modules from /etc/modules.) Then load ipmi-si =
and
>> > > use ipmitool or whatever IPMI tool you have installed.
>> >
>> > OK, where should I blacklist i2c-nforce2?
>>
>> Add the following statement to any .conf file under /etc/modprobe.d:
>>
>> blacklist i2c-nforce2
>>
>> > impitool does not work:
>> > wegc203094:/etc# ipmitool sensor
>> > Could not open device at /dev/ipmi0 or /dev/ipmi/0 or /dev/ipmidev/0=
: No
>> > such file or directory
>> > Get Device ID command failed
>> > Unable to open SDR for reading
>=20
> $ modprobe ipmi_si
> $ modprobe ipmi_devintf
>=20
Thanks! This worked.

Juergen.
>> I can't help with that, sorry, I don't know much about IPMI.
>=20
>=20
>> --
>> Jean Delvare
>> Suse L3 Support
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org <mailto:lm-sensors@lm-sensors.org>
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

--=20
| J=FCrgen Fuchsberger, M.Sc.
| Wegener Center for Climate and Global Change
| University of Graz
| Brandhofgasse 5, A-8010 Graz, Austria
| phone: +43-316-380-8438
|   web: www.wegcenter.at/wegenernet
|        www.wegenernet.org


--LT9l1SiWvdQdLv5JO8mRO1ROITlnJ5pOe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iF4EAREIAAYFAlMDDYMACgkQ4RNsce5/DgBn7AD/YCtfW34xc8w0W0IljyHpRNz3
a3mZZpl1CKHhrSbfjqEA/0jxprTElhwDdecnMXUcwjrJMCy7sjxXM/RAL5gLshgk
=PFlu
-----END PGP SIGNATURE-----

--LT9l1SiWvdQdLv5JO8mRO1ROITlnJ5pOe--


--===============5393914098643605575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5393914098643605575==--
