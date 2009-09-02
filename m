From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Sep 2009 19:06:51 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <20090902210651.40d36626@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Karl,

On Wed, 02 Sep 2009 12:02:47 -0500, Karl Schmidt wrote:
> Jean Delvare wrote:
> > Please try this too, for example set in0_max to 1.0V and see if
> > in0_alarm gets raised.
>=20
> no joy..
> #sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +24.0=B0C
>=20
> lm85b-i2c-0-2e
> Adapter: SMBus nForce2 adapter at 1c00
> V1.5:        +1.30 V  (min =3D  +0.00 V, max =3D  +1.00 V)
> VCore:       +1.42 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:        +3.33 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> V5:          +5.08 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:        +12.06 V  (min =3D  +0.00 V, max =3D +15.94 V)
> CPU_Fan:    7826 RPM  (min =3D 8000 RPM)
> Fan2:       8181 RPM  (min =3D    0 RPM)
> Fan3:       7917 RPM  (min =3D    0 RPM)
> Fan4:       7929 RPM  (min =3D    0 RPM)
> CPU Temp:    +39.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
> Board Temp:  +28.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
> Remote Temp: +24.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
> cpu0_vid:   +1.550 V

> > (...)
> > Does "alarms" read 0 as well?
>=20
> yes - all alarms files read zero
> /sys/class/hwmon/hwmon1/device# cat alarms
> 0

OK, this rules out a user-space issue. The problem must be either at
the hardware level or in the lm85 driver.

Please unload the lm85 driver temporarily, load the i2c-dev driver, and
provide the output of the following command:

i2cdump 0 0x2e

This will dump all the device registers. I will then check against the
datasheet and see if I spot anything.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
