From: Jon Sturm <jasturm002@aol.com>
Date: Tue, 28 Apr 2009 18:05:54 +0000
Subject: [lm-sensors] Sensors on an ECS A535 laptop
Message-Id: <49F74582.80102@aol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have an ECS A535 Laptop and I am trying to figure out how if at all I=20
can get some support for my sensors, currently sensors detect finds
Driver `it87':
  * ISA bus, address 0x290
    Chip `ITE IT8705F Super IO Sensors' (confidence: 9)

But upon running sensors I get mostly garbage output

in0:         +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in1:         +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in2:         +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in3:         +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in4:         +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in5:         +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in6:         +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
+5V:         +0.03 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
Vbat:        +4.08 V
fan1:          0 RPM  (min =3D    0 RPM)
Fan2:          0 RPM  (min =3D    0 RPM)
fan3:          0 RPM  (min =3D    0 RPM)
M/B Temp:    +68.0=B0C  (low  =3D +127.0=B0C, high =3D +85.0=B0C)  sensor =
=3D=20
thermal diode
CPU Temp:    +67.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor =
=3D thermistor
temp3:      -128.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor =
=3D disabled

If I run pwmconfig my fan does spin up but as sensors does not show any=20
fan speeds it just informs me that it can't do anything and exits. Under=20
windows I am able to view one of the fan's speed using speedfan and the=20
fan_div is detected as being 128. The Bios tells me nothing when it=20
comes to system temps so I was hoping someone would be able to at least=20
point me in the right direction.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
