From: Raphael Clifford <drraph@gmail.com>
Date: Thu, 31 Jan 2013 11:00:33 +0000
Subject: [lm-sensors] ASrock 880GM-LE FX motherboard with an AMD 8350 cpu
Message-Id: <CAFHc1QZgMZKeLpds_+FY_FyRyrU_uk+AUsMLOVTzw5wru2uLGQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have an ASrock 880GM-LE FX motherboard with an AMD 8350 cpu.  I set
up sensors by saying Y to everything and now when I run sensors I get


    fam15h_power-pci-00c4
    Adapter: PCI adapter
    power1:       22.42 W  (crit =3D 125.19 W)

    w83627dhg-isa-0290
    Adapter: ISA adapter
    Vcore:        +0.91 V  (min =3D  +0.00 V, max =3D  +1.74 V)
    in1:          +0.00 V  (min =3D  +0.14 V, max =3D  +0.25 V)  ALARM
    AVCC:         +3.36 V  (min =3D  +2.98 V, max =3D  +3.63 V)
    +3.3V:        +3.36 V  (min =3D  +2.98 V, max =3D  +3.63 V)
    in4:          +1.68 V  (min =3D  +0.69 V, max =3D  +0.62 V)  ALARM
    in5:          +1.70 V  (min =3D  +2.03 V, max =3D  +0.42 V)  ALARM
    in6:          +1.86 V  (min =3D  +1.90 V, max =3D  +0.12 V)  ALARM
    3VSB:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
    Vbat:         +3.42 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
    fan1:           0 RPM  (min =3D  878 RPM, div =3D 128)  ALARM
    fan2:        6490 RPM  (min =3D 4687 RPM, div =3D 8)
    fan3:           0 RPM  (min =3D 1506 RPM, div =3D 128)  ALARM
    fan5:           0 RPM  (min =3D  703 RPM, div =3D 128)  ALARM
    temp1:        +42.0=B0C  (high =3D -119.0=B0C, hyst =3D +19.0=B0C)  ALA=
RM
sensor =3D thermistor
    temp2:        +40.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D thermistor
    temp3:        +32.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D thermistor
    intrusion0:  ALARM

    k10temp-pci-00c3
    Adapter: PCI adapter
    temp1:        +21.8=B0C  (high =3D +70.0=B0C)
                           (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)


I have

    sensors --version
    sensors version 3.3.1 with libsensors version 3.3.1

What can I do to get something more informative from sensors?

Raphael

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
