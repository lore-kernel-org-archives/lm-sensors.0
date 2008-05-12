From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 May 2008 12:53:38 +0000
Subject: Re: [lm-sensors] mapping AllSuperD.ini with sensors.conf events.
Message-Id: <20080512145338.52ba19b7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <FB8FDD92-F925-450B-A8A3-39B4045B9A89@eecs.utk.edu>
In-Reply-To: <FB8FDD92-F925-450B-A8A3-39B4045B9A89@eecs.utk.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Daniel,

On Tue, 6 May 2008 15:55:42 -0400, Daniel Lucio wrote:
> does anybody knows how can I map the following entries in my =20
> AllSuperD.ini for SuperDoctorII with entries in sensors.conf?
>=20
> [Item]
> BusType=3D8
> Item_Name=3DChassis Intrusion
> Comp_Name=3DIntrusion
> Item_ID=3DItem_SWITCH1
> Item_Cat=3DSWITCH
> ChipCode=11
> Slave.
> OffsetD
> Activate=01
> ResetI
> ParaIndex1=3DSWITCH1A
> ParaIndex2=3DSWITCH1C
> Monitor=3DTRUE
> Source=3D0

I think I already replied to this one in another thread.

> [Item]
> BusType=3D4
> Item_Name=3DPower Supply Failure
> Comp_Name=3DPower
> Item_ID=3DItem_SWITCH2
> Item_Cat=3DSWITCH
> ChipCode=3D4
> Slave=07
> Offset=F1
> Activate=00
> Reset=00
> ParaIndex1=3DSWITCH2A
> ParaIndex2=3DSWITCH2C
> Monitor=3DTRUE
> Source=3D0
>=20
> I am not sure if lm-sensors is reading these values at all. This  is =20
> for a SuperMicro X7DA8 using:
> Chip: w83793-i2c-0-2e
> Adapter: SMBus I801 adapter at 1100.

The slave address of the second item is 0x07, not 0x2e, so this feature
is not provided by the W83793. It's probably not an SMBus device as the
BusType value is different and I can't remember ever seeing an
I2C/SMBus chip at address 0x07. You'd have to ask SuperMicro for
technical documentation. If I had to guess, it could be a reference to
the Super-I/O chip, Slave=07 would mean LDN 7, Offset=F1 would be a
Super-I/O configuration register, maybe mapping to GPIOs. Take a look
at the datasheet for your Super-I/O (if you have it) and see if it
would make sense. Anyway, that's not something lm-sensors supports, nor
something it could support in a generic way as far as I can see. You'd
need a dedicated driver for your motherboard.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
