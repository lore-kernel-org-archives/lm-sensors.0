From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [sebastian.hesselbarth@stud.uni-hannover.de: i2c-sis5595.c, kernel
Message-Id: <20050122172918.GA7261@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

----- Forwarded message from Sebastian Hesselbarth <sebastian.hesselbarth@s=
tud.uni-hannover.de> -----

From: Sebastian Hesselbarth <sebastian.hesselbarth@stud.uni-hannover.de>
To: Frodo Looijaard <frodol@dds.nl>
Subject: i2c-sis5595.c, kernel 2.6.10
X-Virus-Scanned: ClamAV 0.80/646/Thu Dec 30 20:42:35 2004
	clamav-milter version 0.80j
	on morannon.frodo.local
X-Virus-Scanned: amavisd-new isd-holland.nl
X-Virus-Status: Clean
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on=20
	morannon.frodo.local
X-Spam-Status: No, score=3D-2.3 required=3D5.0 tests=BAYES_00,DNS_FROM_RFC_=
WHOIS=20
	autolearn=3Dno version=3D3.0.2
X-Spam-Level:=20

Hi,

I am currently debugging your i2c-sis5595 module because my brother=20
asked me why his sis540/5595 chipset is not recognized by this module.
I figured out that your setup code _may_ contain bugs especially when=20
reading from pci config registers. I searched the web an found out that=20
pci_read_config_xxx() returns 0 on success and negative values on error.
IMHO if you check the result like this:

if (!pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val))
  goto error;

the if-clause fails on successful reads, too!
I changed this to:
myret =3D pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val);

and printed myret and val to stdout. As expected myret is 0 and val=20
contains 0xF8 which is the correct value for acpi and other stuff enabled.

Maybe you should consider to check for values lower than 0 !?

Please correct me if I am wrong, because I am not very firm at C and=20
device driver development ;)

Regards,

Sebastian Hesselbarth

----- End forwarded message -----

--=20
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~fr=
odol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually follow=
ed
  by the installation of Linux or some other Unix-like operating system.
