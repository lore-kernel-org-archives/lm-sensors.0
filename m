From: =?utf-8?Q?G=C3=B6ran_Uddeborg?= <goeran@uddeborg.se>
Date: Tue, 21 Aug 2012 15:04:54 +0000
Subject: Re: [lm-sensors] Chassis fan is reported incorrectly with M5A78L motherboard
Message-Id: <20531.41878.976346.746948@freddi.uddeborg>
List-Id: <lm-sensors.vger.kernel.org>
References: <20531.32769.603792.771925@freddi.uddeborg>
In-Reply-To: <20531.32769.603792.771925@freddi.uddeborg>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Luca Tettamanti:
> Unload the module and try reloading it with
> "new_if=3D1", like this:
>=20
> modprobe asus_atk0110 new_if=3D1
>=20
> And see if everything looks good.

It does indeed:

    freddi$ sensors
    atk0110-acpi-0
    Adapter: ACPI interface
    Vcore Voltage:      +1.00 V  (min =3D  +0.80 V, max =3D  +1.60 V)
    +3.3V Voltage:      +3.25 V  (min =3D  +2.97 V, max =3D  +3.63 V)
    +5V Voltage:        +4.98 V  (min =3D  +4.50 V, max =3D  +5.50 V)
    +12V Voltage:      +12.08 V  (min =3D +10.20 V, max =3D +13.80 V)
    CPU Fan Speed:     1683 RPM  (min =3D  600 RPM, max =3D 7200 RPM)
    Chassis Fan Speed:  847 RPM  (min =3D  600 RPM, max =3D 7200 RPM)
    CPU Temperature:    +39.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
    MB Temperature:     +38.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)

That makes much more sense.  Thanks for the help!  I'll add this
workaround option to a modprobe configuration file.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
