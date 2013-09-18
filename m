From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 18 Sep 2013 11:28:22 +0000
Subject: Re: [lm-sensors] Measured Fan RPM Jumps Frequently to 675000 RPM
Message-Id: <20130918112822.GA9447@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130918105137.Horde.pcSHtQSX3xoA3EHBStt0YQ1@webmail.df.eu>
In-Reply-To: <20130918105137.Horde.pcSHtQSX3xoA3EHBStt0YQ1@webmail.df.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Sep 18, 2013 at 10:51:37AM +0200, Sascha Haupt wrote:
>=20
> Dear @ll,
>=20
> I am monitoring multiple systems (with Asus M5A78LE mainboards)
> using sensors and Munin.
>=20
> On one node I often get a value of 675000 RPM for the FAN2 speed.
> Usually, the value of FAN2 is approx 1950 RPM.
>=20
> The jump can frequently be seen if sensors is executed manually in a
> fast sequence:
>=20
The driver only reports what it gets from the system through ACPI.
I don't think there is anything we can do about it.

Luca, any idea ?

Guenter

>=20
> host:~ # sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +0.0=B0C  (high =3D +70.0=B0C, crit =3D +90.0=B0C)
>=20
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:       +1.42 V  (min =3D  +0.85 V, max =3D  +1.70 V)
>  +3.3 Voltage:       +3.40 V  (min =3D  +2.97 V, max =3D  +3.63 V)
>  +5 Voltage:         +5.08 V  (min =3D  +4.50 V, max =3D  +5.50 V)
>  +12 Voltage:       +12.40 V  (min =3D +10.20 V, max =3D +13.80 V)
> CPU FAN Speed:      3813 RPM  (min =3D  600 RPM)
> CHASSIS FAN Speed:  1406 RPM  (min =3D  600 RPM)
> CHASSIS FAN 2 Speed:675000 RPM  (min =3D  600 RPM)
> CPU Temperature:     +43.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
> MB Temperature:      +38.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)
>=20
> host:~ # sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +0.0=B0C  (high =3D +70.0=B0C, crit =3D +90.0=B0C)
>=20
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:       +1.42 V  (min =3D  +0.85 V, max =3D  +1.70 V)
>  +3.3 Voltage:       +3.40 V  (min =3D  +2.97 V, max =3D  +3.63 V)
>  +5 Voltage:         +5.08 V  (min =3D  +4.50 V, max =3D  +5.50 V)
>  +12 Voltage:       +12.40 V  (min =3D +10.20 V, max =3D +13.80 V)
> CPU FAN Speed:      3813 RPM  (min =3D  600 RPM)
> CHASSIS FAN Speed:  1406 RPM  (min =3D  600 RPM)
> CHASSIS FAN 2 Speed:675000 RPM  (min =3D  600 RPM)
> CPU Temperature:     +43.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
> MB Temperature:      +38.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)
>=20
> host:~ # sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +0.0=B0C  (high =3D +70.0=B0C, crit =3D +90.0=B0C)
>=20
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:       +1.42 V  (min =3D  +0.85 V, max =3D  +1.70 V)
>  +3.3 Voltage:       +3.40 V  (min =3D  +2.97 V, max =3D  +3.63 V)
>  +5 Voltage:         +5.08 V  (min =3D  +4.50 V, max =3D  +5.50 V)
>  +12 Voltage:       +12.42 V  (min =3D +10.20 V, max =3D +13.80 V)
> CPU FAN Speed:      3813 RPM  (min =3D  600 RPM)
> CHASSIS FAN Speed:  1409 RPM  (min =3D  600 RPM)
> CHASSIS FAN 2 Speed:1950 RPM  (min =3D  600 RPM)
> CPU Temperature:     +43.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
> MB Temperature:      +38.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)
>=20
> host:~ # sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +0.0=B0C  (high =3D +70.0=B0C, crit =3D +90.0=B0C)
>=20
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:       +1.42 V  (min =3D  +0.85 V, max =3D  +1.70 V)
>  +3.3 Voltage:       +3.40 V  (min =3D  +2.97 V, max =3D  +3.63 V)
>  +5 Voltage:         +5.08 V  (min =3D  +4.50 V, max =3D  +5.50 V)
>  +12 Voltage:       +12.42 V  (min =3D +10.20 V, max =3D +13.80 V)
> CPU FAN Speed:      3813 RPM  (min =3D  600 RPM)
> CHASSIS FAN Speed:  1409 RPM  (min =3D  600 RPM)
> CHASSIS FAN 2 Speed:1950 RPM  (min =3D  600 RPM)
> CPU Temperature:     +43.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
> MB Temperature:      +38.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)
>=20
> host:~ # sensors
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +0.0=B0C  (high =3D +70.0=B0C, crit =3D +90.0=B0C)
>=20
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:       +1.42 V  (min =3D  +0.85 V, max =3D  +1.70 V)
>  +3.3 Voltage:       +3.40 V  (min =3D  +2.97 V, max =3D  +3.63 V)
>  +5 Voltage:         +5.08 V  (min =3D  +4.50 V, max =3D  +5.50 V)
>  +12 Voltage:       +12.42 V  (min =3D +10.20 V, max =3D +13.80 V)
> CPU FAN Speed:      3813 RPM  (min =3D  600 RPM)
> CHASSIS FAN Speed:  1409 RPM  (min =3D  600 RPM)
> CHASSIS FAN 2 Speed:1950 RPM  (min =3D  600 RPM)
> CPU Temperature:     +43.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
> MB Temperature:      +38.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)
>=20
>=20
> This just happens on one node. On the other nodes the measured
> values seem to be stable.
>=20
> Thanks for your help.
>=20
> Regards
> Sascha Haupt
>=20
>=20
>=20
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
