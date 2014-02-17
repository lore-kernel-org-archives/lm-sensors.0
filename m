From: =?ISO-8859-1?Q?J=FCrgen_Fuchsberger?= <juergen.fuchsberger@uni-graz.at>
Date: Mon, 17 Feb 2014 14:49:43 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <53022187.9010805@uni-graz.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3799048938143252186=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============3799048938143252186==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DIrKGd8p0kJJcGd7JQdt9wJk7ii1XkUJG"

--DIrKGd8p0kJJcGd7JQdt9wJk7ii1XkUJG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


On 02/17/2014 03:42 PM, Juerg Haefliger wrote:
>
> impitool does not work:
> wegc203094:/etc# ipmitool sensor
> Could not open device at /dev/ipmi0 or /dev/ipmi/0 or /dev/ipmidev/0: N=
o
> such file or directory

Did you try to load the ipmi driver(s)? What do you get in the logs?
>
Feb 17 11:05:51 wegc203094 kernel: [    8.828554] ipmi message handler
version 39.2
Feb 17 11:05:51 wegc203094 kernel: [    8.836419] IPMI System Interface
driver.
Feb 17 11:05:51 wegc203094 kernel: [    8.836494] ipmi_si: probing via
SMBIOS
Feb 17 11:05:51 wegc203094 kernel: [    8.836501] ipmi_si: SMBIOS: io
0xca8 regsize 1 spacing 4 irq 0
Feb 17 11:05:51 wegc203094 kernel: [    8.836507] ipmi_si: Adding
SMBIOS-specified kcs state machine
Feb 17 11:05:51 wegc203094 kernel: [    8.836517] ipmi_si: Trying
SMBIOS-specified kcs state machine at i/o address 0xca8, slave address
0x20, irq 0
Feb 17 11:05:51 wegc203094 kernel: [    8.971823] ipmi_si ipmi_si.0:
Found new BMC (man_id: 0x0019fd, prod_id: 0x0b74, dev_id: 0x20)
Feb 17 11:05:51 wegc203094 kernel: [    8.971845] ipmi_si ipmi_si.0:
IPMI kcs interface initialized


> ...Juerg
>
>
> > Get Device ID command failed
> > Unable to open SDR for reading
> >
> > Best,
> > Juergen
> >
> > >
> >

--=20
| J=FCrgen Fuchsberger, M.Sc.
| Wegener Center for Climate and Global Change
| University of Graz
| Brandhofgasse 5, A-8010 Graz, Austria
| phone: +43-316-380-8438
|   web: www.wegcenter.at/wegenernet
|        www.wegenernet.org



--DIrKGd8p0kJJcGd7JQdt9wJk7ii1XkUJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iF4EAREIAAYFAlMCIYcACgkQ4RNsce5/DgBfkQEAiuaN3WG9fdvu915RQFbbCCcI
/Nu8kdkclXgX34g32PYBAItnEoHuFsksheVtcx+Tr3DB3QmZHT846FOw+RPOWL/s
=TBN6
-----END PGP SIGNATURE-----

--DIrKGd8p0kJJcGd7JQdt9wJk7ii1XkUJG--


--===============3799048938143252186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3799048938143252186==--
