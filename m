From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 08 Sep 2012 16:50:25 +0000
Subject: Re: [lm-sensors] Strange temperature of AMD FX4100 cpu and power consumption
Message-Id: <20120908165025.GA31945@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <504B7388.8020102@01019freenet.de>
In-Reply-To: <504B7388.8020102@01019freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Sep 08, 2012 at 06:34:16PM +0200, Andreas Hartmann wrote:
> Hello,
>=20
> I'm getting this temperature after more than one hour of activity
> (mostly idle, load of the machine is: 0,11, 0,17, 0,21):
>=20
> sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +14.5=B0C  (high =3D +70.0=B0C)
>                        (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)
>=20
> 14.5=B0C is completely impossible as the surrounding temperature is
> > 20=B0C.
>=20
>=20
> fam15h_power-pci-00c4
> Adapter: PCI adapter
> power1:       85.74 W
>=20
> I read about this value, which would be the power consumption of the
> CPU. If this would be correct, my cpu wouldn't be a cpu but a light bulb
> :-) and the fan would most probably run on maximum speed non stop (which
> it doesn't do - it's running on minimum).
>=20
If they have a built-in AC unit, both temperature and power consumption wou=
ld
make sense. Hmm ... maybe I should apply for a patent on that idea :).

> CPU:       AMD FX(tm)-4100 Quad-Core Processor
> Board:     Gigabyte GA-990XA-UD3
> Bios:      Award F11 05/17/2012
> Kernel:    3.4.10-1.1-desktop 64 bit (openSUSE)
> lmsensors: sensors-3.3.2-55.1.x86_64
>=20
>=20
> Do you need more information about the hardware? Feel free to ask!
>=20
>=20
>=20
>=20
> Thanks for any hint,
> kind regards,
> Andreas Hartmann
>=20
Copying the driver maintainers for feedback.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
