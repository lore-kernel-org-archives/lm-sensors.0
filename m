From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Oct 2010 09:31:50 +0000
Subject: Re: [lm-sensors] IT8721F/IT8758E support
Message-Id: <20101012113150.0bba96a2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101011221911.38c8a3d7@endymion.delvare>
In-Reply-To: <20101011221911.38c8a3d7@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Patrick,

On Mon, 11 Oct 2010 22:54:26 +0200, Patrick Nagelschmidt wrote:
> you're right:
> it87: Found IT8721F chip at 0x290, revision 1
> ACPI: resource it87 [io  0x0295-0x0296] conflicts with ACPI region SIOE [=
??? 0x00000290-0x000002af flags 0x45]
> ACPI: If an ACPI driver is available for this device, you should use it i=
nstead of the native driver
> but the asus_atk0110 did the trick:
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +25.2=B0C  (high =3D +70.0=B0C, crit =3D +99.5=B0C)
>=20
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:     +1.33 V  (min =3D  +0.85 V, max =3D  +1.60 V)
>  +3.3 Voltage:     +3.33 V  (min =3D  +2.97 V, max =3D  +3.63 V)
>  +5 Voltage:       +4.89 V  (min =3D  +4.50 V, max =3D  +5.50 V)
>  +12 Voltage:     +12.08 V  (min =3D +10.20 V, max =3D +13.80 V)
> CPU FAN Speed:    2280 RPM  (min =3D  600 RPM)
> CHASSIS FAN Speed: 511 RPM  (min =3D  600 RPM)
> CPU Temperature:   +34.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
> MB Temperature:    +37.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)
> Btw, can you detect the mainboard vendor?

Yes, we already do.

> If you can it would probably be a solution to recommend using this module=
 for asus-owners in general.

The problem is that not all Asus board use that driver. Old Asus boards
don't have the ATK0110 virtual drivers, some more recent boards do have
it but it isn't usable, and server boards need native drivers instead of
ACPI.

> As it seems lm-sensors is capable of much more than the scan makes you th=
ink in the first place when it announces it has no driver for the sensor fo=
und :)

We have a few tickets opened for this:
  http://www.lm-sensors.org/ticket/2374
  http://www.lm-sensors.org/ticket/2373
But this isn't trivial, it will take some time and thinking to get it
done properly.

Note that the asus_atk0110 driver normally loads automatically on
systems which need it, which mitigates the issue.

> Thanks for your efforts, greatly appreciate the fast reaction :)

You're welcome.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
