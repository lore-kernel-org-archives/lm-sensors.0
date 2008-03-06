From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Mar 2008 08:31:09 +0000
Subject: Re: [lm-sensors] No sensors found >2.6.21, w83627hf, ICH6
Message-Id: <20080306093109.495aee14@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47CD5B89.1070302@gmx.de>
In-Reply-To: <47CD5B89.1070302@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 05 Mar 2008 18:25:50 +0100, Stefan Sassenberg wrote:
> Jean Delvare wrote:
> > On Wed, 05 Mar 2008 17:09:02 +0100, Stefan Sassenberg wrote:
> >> Bad news for me:
> >>
> >> Probing for `Analog Devices ADT7467 or ADT7468'...          Success!
> >>      (confidence 7, driver `to-be-written')
> >=20
> > No driver yet and nobody working on it as far as I know - but in the
> > meantime you may try forcing the lm85 driver, with chip type adm1027,
> > you should get some basic results.
> >=20
> After modprobing w83627hf, lm85, adm1021, adm1025, adm1026, adm1029,=20
> adm1031 the results are just the same.

Huu, that's not what I suggested. Leave the adm1021, adm1025, adm1026,
adm1029 and adm1031 drivers alone, they won't work for you. Instead,
try loading the lm85 driver that way:

modprobe lm85 force_adm1027=3D0,0x2e

The exact parameter depends on the I2C bus and address where
sensors-detect found the ADT7467/8 chip. The above is for bus i2c-0,
address 0x2e. Adjust the command if the bus number or the chip address
differ on your system.

As you are using lm-sensors 2.10.1 with a recent kernel, it is possible
that libsensors won't work properly with the forced ADM1027 chip, but
at least you should be able to read some temperature values directly
from /sys/class/hwmon.

> Meanwhile I connected the hard disk to a MSI W7231IMS. It has the same=20
> AD chip:
> Probing for `Analog Devices ADT7467 or ADT7468'...          Success!
> ...but a different Winbond:
> Found `Winbond W83627EHF/EHG Super IO Sensors'              Success!
> ...and shows no fan speed but three temperature values:
> Sys Temp:    +33=B0C  (high =3D   +45=B0C, hyst =3D   +40=B0C)
> CPU Temp:  +33.0=B0C  (high =3D +45.0=B0C, hyst =3D +40.0=B0C)
> temp3:     +32.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
>=20
> Not bad.

Yep, these temperatures look reasonable.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
