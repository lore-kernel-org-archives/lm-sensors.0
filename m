From: Fulcrum <fulcrummike@hotmail.com>
Date: Sun, 28 Feb 2016 22:14:19 +0000
Subject: Re: [lm-sensors] Datasheet for Fintek F71868a
Message-Id: <BLU436-SMTP21232857A039BAD2FD2EFA4B3B90@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT147-W1A9746D160B8ED3C0290AB3A40@phx.gbl>
In-Reply-To: <SNT147-W1A9746D160B8ED3C0290AB3A40@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi

Please find  the output from 'sensors' utility on my PC towards the=20
bottom of this post. The sensor output from f71868a is very vague. I=20
can't tell which component does any reading correspond to. I failed to=20
find any information from MSI about the layout of the motherboard, and=20
thermal sensors.

Additionally, I ran aticonfig and hddtemp to see the temps of my ATI=20
graphics card and harddisk. Both those temps are almost always different=20
from those reported by sensors (f71868a). Some explanation would be=20
highly appreciated!

 >sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +20.6=B0C  (high =3D +70.0=B0C)
                        (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)

fam15h_power-pci-00c4
Adapter: PCI adapter
power1:           N/A  (crit =3D  95.09 W)

f71868a-isa-0290
Adapter: ISA adapter
in0:          +1.66 V
in1:          +0.90 V
in2:          +1.49 V
in3:          +0.96 V
in4:          +1.12 V
in5:          +1.10 V
in6:          +1.10 V
in7:          +1.66 V
in8:          +1.62 V
in9:          +1.65 V
fan1:        1997 RPM
fan2:           0 RPM  ALARM
fan3:           0 RPM  ALARM
temp1:        +42.0=B0C  (high =3D +85.0=B0C, hyst =3D +81.0=B0C)
                        (crit =3D +100.0=B0C, hyst =3D +96.0=B0C)  sensor =
=3D=20
thermistor
temp2:        +38.0=B0C  (high =3D +85.0=B0C, hyst =3D +81.0=B0C)
                        (crit =3D +100.0=B0C, hyst =3D +96.0=B0C)  sensor =
=3D=20
thermistor
temp3:        +29.0=B0C  (high =3D +70.0=B0C, hyst =3D +68.0=B0C)
                        (crit =3D +85.0=B0C, hyst =3D +83.0=B0C)  sensor =
=3D=20
transistor


Regards,
Fulcrum


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
