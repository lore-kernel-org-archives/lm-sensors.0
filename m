From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Sep 2009 16:55:45 +0000
Subject: Re: [lm-sensors] unhide_ICH_SMBus: line 33:
Message-Id: <20090915185545.5f87ca81@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9122E1.7010006@ribosome.natur.cuni.cz>
In-Reply-To: <4A9122E1.7010006@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 15 Sep 2009 18:41:41 +0200, Martin MOKREJ=A6 wrote:
> Jean Delvare wrote:
> > On Tue, 15 Sep 2009 17:43:19 +0200, Martin MOKREJ=A6 wrote:
> >> $ gzip -dc /proc/config.gz | grep THERMAL
> >> CONFIG_ACPI_THERMAL=3Dy
> >> CONFIG_THERMAL=3Dy
> >> CONFIG_THERMAL_HWMON=3Dy
> >> $ gzip -dc /proc/config.gz | grep ATK
> >> CONFIG_KEYBOARD_ATKBD=3Dy
> >> CONFIG_SENSORS_ATK0110=3Dy
> >> $
> >>
> >> These I have already in the kernel, so I can drop the whole SMbus thin=
g?
> >=20
> > Yes.
>=20
> Ooops, are we talking about I2C_I801=3DN, I2C=3DN or SENSORS_DS1621=3DN? =
;-)

ENSORS_DS1621=3DN and I2C_I801=3DN, yes. I2C=3DN, bad idea, you might need
I2C support for something else.

> Actually I had SENSORS_LM90=3DY as it was also proposed by sensors-detect.
> That one was also mis-detected?

I can't tell as your sensors-detect report was incomplete (with ds1621
loaded, sensors-detect can't probe the chip). I'm not sure why you are
hard-building all the drivers that way, BTW, it makes investigating
problems much harder. Probably the LM90 detection was correct, as these
chips are much more reliably detected than the DS1621.

Anyway, as further kernels say that ACPI is conflicting with the native
SMBus controller driver, the only safe bet is to drop i2c-i801 and go
with the ACPI thermal driver instead.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
