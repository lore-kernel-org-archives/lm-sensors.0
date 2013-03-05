From: Fredrick O Jackson <fredrick.o.jackson@gmail.com>
Date: Tue, 05 Mar 2013 00:27:00 +0000
Subject: [lm-sensors] ASRock 990FX Extreme3
Message-Id: <201303041827.00388.fredrick.o.jackson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


I have an ASRock 990FX Extreme3 board that I'd REALLY like to be able to=20
monitor the temperature of.  I'm no expert at lmsensors and despite days of=
=20
effort, I cannot determine how to configure lmsensors for this board. My te=
mps=20
dont match the hardware monitor in the bios. Some of the fans and voltages =
are=20
also wrong.=20

I'd be willing to pay for some effective advice or a config file for this b=
oard.=20
I appreciate any help.

thanks
Fred




sample output of sensors after running sensors-detect


fam15h_power-pci-00c4
Adapter: PCI adapter
power1:       37.73 W  (crit =3D 124.95 W)

k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +20.6=B0C  (high =3D +70.0=B0C)
                       (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)

radeon-pci-0100
Adapter: PCI adapter
temp1:        +56.5=B0C =20

nct6776-isa-0290
Adapter: ISA adapter
Vcore:        +0.92 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:          +1.86 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
AVCC:         +3.28 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:        +3.28 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:          +1.51 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in5:          +1.74 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:         +3.47 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:         +3.38 V  (min =3D  +2.70 V, max =3D  +3.63 V)
fan1:           0 RPM  (min =3D    0 RPM)  ALARM
fan2:        2036 RPM  (min =3D    0 RPM)  ALARM
fan3:           0 RPM  (min =3D    0 RPM)  ALARM
fan4:           0 RPM  (min =3D    0 RPM)  ALARM
fan5:           0 RPM  (min =3D    0 RPM)  ALARM
SYSTIN:       +45.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  s=
ensor =3D=20
thermistor
CPUTIN:       +38.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
AUXTIN:        +2.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
cpu0_vid:    +0.000 V
intrusion0:  ALARM                                                         =
                              =20
intrusion1:  ALARM          =20



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
