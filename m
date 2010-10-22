From: Arun Raghavan <arraghav@gmail.com>
Date: Fri, 22 Oct 2010 22:56:42 +0000
Subject: [lm-sensors] Discrepancy between reported readings from different
Message-Id: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I'm running a core-i7 980x on ASUS Rampage III Extreme. I find that
the temperatures reported by the atk0110-acpi-0 and coretemp
interfaces to be quite different:

atk0110-acpi-0
Adapter: ACPI interface
CPU Temperature:       +56.5=B0C  (high =3D +60.0=B0C, crit =3D +65.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +52.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +47.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +45.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 8:      +50.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)

coretemp-isa-0004
Adapter: ISA adapter
Core 9:      +45.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)

coretemp-isa-0005
Adapter: ISA adapter
Core 10:     +51.0=B0C  (high =3D +81.0=B0C, crit =3D +101.0=B0C)


Apart from the 5 degree difference between the reported CPU
temperature from the ACPI interface and the max. reported coretemp,
the high and critical temperatures are drastically different. 65
degrees C seems to small for junction critical temperature 32nm Si.
Could you please advise as to what the differences represent. Are they
indeed very different things or do I need to calibrate the ACPI
(Winbond?) interface to be close to the coretemp readings?
thanks,
-arun

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
