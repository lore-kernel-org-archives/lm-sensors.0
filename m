From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Sep 2009 15:55:25 +0000
Subject: Re: [lm-sensors] unhide_ICH_SMBus: line 33:
Message-Id: <20090915175525.3d1d9cd2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9122E1.7010006@ribosome.natur.cuni.cz>
In-Reply-To: <4A9122E1.7010006@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 15 Sep 2009 17:43:19 +0200, Martin MOKREJ=A6 wrote:
> $ gzip -dc /proc/config.gz | grep THERMAL
> CONFIG_ACPI_THERMAL=3Dy
> CONFIG_THERMAL=3Dy
> CONFIG_THERMAL_HWMON=3Dy
> $ gzip -dc /proc/config.gz | grep ATK
> CONFIG_KEYBOARD_ATKBD=3Dy
> CONFIG_SENSORS_ATK0110=3Dy
> $
>=20
> These I have already in the kernel, so I can drop the whole SMbus thing?

Yes.

> Could sensors-detect give me an advice like this? Are these hidden in the=
 dmesg
> output I have provided recently?

I know that sensors-detect doesn't cope properly with non-native
hardware monitoring mechanism. This is something we must improve in the
future. I have some ideas but I need time and, if possible, affected
hardware to implement them.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
