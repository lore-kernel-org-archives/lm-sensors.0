From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Mar 2011 07:57:58 +0000
Subject: Re: [lm-sensors] Update on DS1721, DS1631, DS1631A, DS1731
Message-Id: <20110318085758.3dfdb0e6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110318042048.GA8315@ericsson.com>
In-Reply-To: <20110318042048.GA8315@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 17 Mar 2011 21:20:48 -0700, Guenter Roeck wrote:
> Hi all,
>=20
> I confirmed that DS1721, DS1631, DS1631A, and DS1731
> work with the existing ds1621 driver:
>=20
> DS1721 (2x):
> ds1621-i2c-5-48
> Adapter: i2c-devantech-iss at bus 002 device 034
> temp1:        +23.5=B0C  (low  =3D +10.0=B0C, high =3D +70.0=B0C)
>=20
> ds1621-i2c-5-49
> Adapter: i2c-devantech-iss at bus 002 device 034
> temp1:        +23.5=B0C  (low  =3D +10.0=B0C, high =3D +70.0=B0C)
>=20
> DS1631:
> ds1621-i2c-5-4a
> Adapter: i2c-devantech-iss at bus 002 device 034
> temp1:        +23.0=B0C  (low  =3D +10.0=B0C, high =3D +70.0=B0C)
>=20
> DS1631A:
> ds1621-i2c-5-4b
> Adapter: i2c-devantech-iss at bus 002 device 034
> temp1:        +23.0=B0C  (low  =3D +10.0=B0C, high =3D +70.0=B0C)
>=20
> DS1731:
> ds1621-i2c-5-4c
> Adapter: i2c-devantech-iss at bus 002 device 034
> temp1:        +23.5=B0C  (low  =3D +10.0=B0C, high =3D +70.0=B0C)
>=20
> Output from sensors-detect:
>=20
> Driver `ds1621':
>   * Bus `i2c-devantech-iss at bus 002 device 034'
>     Busdriver `i2c_devantech_iss', I2C address 0x48
>     Chip `Dallas Semiconductor DS1621/DS1631' (confidence: 3)
>   * Bus `i2c-devantech-iss at bus 002 device 034'
>     Busdriver `i2c_devantech_iss', I2C address 0x49
>     Chip `Dallas Semiconductor DS1621/DS1631' (confidence: 3)
>   * Bus `i2c-devantech-iss at bus 002 device 034'
>     Busdriver `i2c_devantech_iss', I2C address 0x4a
>     Chip `Dallas Semiconductor DS1621/DS1631' (confidence: 3)
>   * Bus `i2c-devantech-iss at bus 002 device 034'
>     Busdriver `i2c_devantech_iss', I2C address 0x4b
>     Chip `Dallas Semiconductor DS1621/DS1631' (confidence: 3)
>   * Bus `i2c-devantech-iss at bus 002 device 034'
>     Busdriver `i2c_devantech_iss', I2C address 0x4c
>     Chip `Dallas Semiconductor DS1621/DS1631' (confidence: 3)
>=20
> The chips still support register 0xee, even though that is not documented
> in the datasheets.
>=20
> Auto-detection and sensors-detect may or may not work depending
> on chip configuration (it always works after power-up).
> Explicit device instantiation always works.
>=20
> I'll update the list of supported devices to reflect this information.

If memory serves, at least the DS1631 supports better resolution than
the ds1621 driver currently offers. So claiming that it is supported
isn't completely exact. What the driver supports is really the DS1621
and the other chips happen to emulate it.

It should really not be difficult to add proper support for all chips,
I just could never find the time to look into it. The chips I have here
are: one DS1621, two DS1631+ and two DS1624+.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
