From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Sep 2009 18:10:02 +0000
Subject: Re: [lm-sensors] unhide_ICH_SMBus: line 33:
Message-Id: <20090916201002.226adac8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9122E1.7010006@ribosome.natur.cuni.cz>
In-Reply-To: <4A9122E1.7010006@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 16 Sep 2009 18:48:43 +0200, Martin MOKREJ=A6 wrote:
> Jean Delvare wrote:
> > On Tue, 15 Sep 2009 18:41:41 +0200, Martin MOKREJ=A6 wrote:
> >> Jean Delvare wrote:
> >>> On Tue, 15 Sep 2009 17:43:19 +0200, Martin MOKREJ=A6 wrote:
> >>>> $ gzip -dc /proc/config.gz | grep THERMAL
> >>>> CONFIG_ACPI_THERMAL=3Dy
> >>>> CONFIG_THERMAL=3Dy
> >>>> CONFIG_THERMAL_HWMON=3Dy
> >>>> $ gzip -dc /proc/config.gz | grep ATK
> >>>> CONFIG_KEYBOARD_ATKBD=3Dy
> >>>> CONFIG_SENSORS_ATK0110=3Dy
> >>>> $
> >>>>
> >>>> These I have already in the kernel, so I can drop the whole SMbus th=
ing?
> >>> Yes.
> >> Ooops, are we talking about I2C_I801=3DN, I2C=3DN or SENSORS_DS1621=3D=
N? ;-)
> >=20
> > ENSORS_DS1621=3DN and I2C_I801=3DN, yes. I2C=3DN, bad idea, you might n=
eed
> > I2C support for something else.
>=20
> $ sensors=20
> max6657-i2c-4-4c
> Adapter: SMBus I801 adapter at e800
> M/B Temp:  +39.1=B0C  (low  =3D   -55=B0C, high =3D  +127=B0C)  =20
> CPU Temp:  +49.2=B0C  (low  =3D +48.0=B0C, high =3D +62.0=B0C)  =20
> M/B Crit:    +85=B0C  (hyst =3D   +75=B0C)                 =20
> CPU Crit:    +75=B0C  (hyst =3D   +65=B0C)                 =20
>=20
> $
> >=20
> >> Actually I had SENSORS_LM90=3DY as it was also proposed by sensors-det=
ect.
> >> That one was also mis-detected?
> >=20
> > I can't tell as your sensors-detect report was incomplete (with ds1621
> > loaded, sensors-detect can't probe the chip). I'm not sure why you are
> > hard-building all the drivers that way, BTW, it makes investigating
> > problems much harder. Probably the LM90 detection was correct, as these
> > chips are much more reliably detected than the DS1621.
> >=20
> > Anyway, as further kernels say that ACPI is conflicting with the native
> > SMBus controller driver, the only safe bet is to drop i2c-i801 and go
> > with the ACPI thermal driver instead.
>=20
> So doing that lm90 driver does not find any hardware chip and sensors
> do not see therefore anything either. modprob-ing ATK0110 driver surprisi=
ngly
> doesn't give anything either (lsmod reports it is unused and nothing new =
in
> dmesg).=20
>=20
> Dropping i2c-i801 seems like a bad idea. ;-)
>=20
> What do you propose now? Some debug flags for insmod when inserting the a=
tk*
> driver?

I propose that you read again what I already wrote before, because
apparently you didn't pay attention.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
