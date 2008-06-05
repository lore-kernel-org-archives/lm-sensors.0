From: Eric Piel <eric.piel@tremplin-utc.net>
Date: Thu, 05 Jun 2008 08:28:53 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] hwmon: HP Mobile Data Protection
Message-Id: <4847A3C5.60600@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1212235533.3815.5.camel@localhost> <48479922.6050003@movial.fi>
In-Reply-To: <48479922.6050003@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Riku Voipio <riku.voipio@movial.fi>
Cc: Yan Burman <burman.yan@gmail.com>, LKML <linux-kernel@vger.kernel.org>, HWMON <lm-sensors@lm-sensors.org>, spi-devel-general@lists.sourceforge.net, jic23@cam.ac.uk, pau@eslack.org

Riku Voipio wrote:
> Yan Burman wrote:
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Supported chips:
>> +
>> +  * STMicroelectronics LIS3LV02DL and LIS3LV02DQ
>> +
> These chips are connected to either I2C or SPI - This is the 4th driver f=
or
> (apparently) these same chips:
>=20
> http://docwiki.gumstix.org/Lis3lv02dq_spi.c
> http://svn.openmoko.org/branches/src/target/kernel/2.6.24.x/patches/lis30=
2dl.patch=20
>=20
> http://article.gmane.org/gmane.linux.kernel.spi.devel/1010
Hi!
Thanks a lot for these links (which I was not aware of). They indeed=20
seem to handle the same hardware (all via spi). To be even more=20
complete, here is a link we received off-list for accessing the same=20
hardware via I=B2C:
http://pof.eslack.org/HTC/shift/i2c-gsensor.tar.gz

There are for sure some nice things we could borrow ;-)
>=20
>> +    depends on ACPI && INPUT && X86
>>  =20
>=20
>=20
>> +/* The actual chip is STMicroelectronics LIS3LV02DL or LIS3LV02DQ
>> + * that seems to be connected via SPI */
>>  =20
> Perhaps it would make more sense implement support for SPI
> bus on the laptop and use the SPI interface directly instead or
> routing via the ACPI hiding layer?
Getting rid of ACPI could be nice, as it tends to be rather slow.=20
However, so far we've stick to it because it ensures that for the ~15=20
different models of HP laptop, we can access the hardware exactly the=20
same way. I have the gut feeling that if HP spent some time to add an=20
interface in ACPI, there was some kind of reason.

However, I know nothing about SPI. Maybe you'll tell that if this chip=20
is on the SPI bus, it will always be accessed the same way, located at=20
the same address... or whatever that can ensure us that from the moment=20
we know this device is in the laptop (and that's easy via HPQ0004) we=20
cannot mess up. In that case, going to SPI would be definitely worthy.

Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
