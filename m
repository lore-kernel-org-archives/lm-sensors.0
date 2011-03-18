From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 18 Mar 2011 04:20:48 +0000
Subject: [lm-sensors] Update on DS1721, DS1631, DS1631A, DS1731
Message-Id: <20110318042048.GA8315@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,

I confirmed that DS1721, DS1631, DS1631A, and DS1731
work with the existing ds1621 driver:

DS1721 (2x):
ds1621-i2c-5-48
Adapter: i2c-devantech-iss at bus 002 device 034
temp1:        +23.5=B0C  (low  =3D +10.0=B0C, high =3D +70.0=B0C)

ds1621-i2c-5-49
Adapter: i2c-devantech-iss at bus 002 device 034
temp1:        +23.5=B0C  (low  =3D +10.0=B0C, high =3D +70.0=B0C)

DS1631:
ds1621-i2c-5-4a
Adapter: i2c-devantech-iss at bus 002 device 034
temp1:        +23.0=B0C  (low  =3D +10.0=B0C, high =3D +70.0=B0C)

DS1631A:
ds1621-i2c-5-4b
Adapter: i2c-devantech-iss at bus 002 device 034
temp1:        +23.0=B0C  (low  =3D +10.0=B0C, high =3D +70.0=B0C)

DS1731:
ds1621-i2c-5-4c
Adapter: i2c-devantech-iss at bus 002 device 034
temp1:        +23.5=B0C  (low  =3D +10.0=B0C, high =3D +70.0=B0C)

Output from sensors-detect:

Driver `ds1621':
  * Bus `i2c-devantech-iss at bus 002 device 034'
    Busdriver `i2c_devantech_iss', I2C address 0x48
    Chip `Dallas Semiconductor DS1621/DS1631' (confidence: 3)
  * Bus `i2c-devantech-iss at bus 002 device 034'
    Busdriver `i2c_devantech_iss', I2C address 0x49
    Chip `Dallas Semiconductor DS1621/DS1631' (confidence: 3)
  * Bus `i2c-devantech-iss at bus 002 device 034'
    Busdriver `i2c_devantech_iss', I2C address 0x4a
    Chip `Dallas Semiconductor DS1621/DS1631' (confidence: 3)
  * Bus `i2c-devantech-iss at bus 002 device 034'
    Busdriver `i2c_devantech_iss', I2C address 0x4b
    Chip `Dallas Semiconductor DS1621/DS1631' (confidence: 3)
  * Bus `i2c-devantech-iss at bus 002 device 034'
    Busdriver `i2c_devantech_iss', I2C address 0x4c
    Chip `Dallas Semiconductor DS1621/DS1631' (confidence: 3)

The chips still support register 0xee, even though that is not documented
in the datasheets.

Auto-detection and sensors-detect may or may not work depending
on chip configuration (it always works after power-up).
Explicit device instantiation always works.

I'll update the list of supported devices to reflect this information.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
