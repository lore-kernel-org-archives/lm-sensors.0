From: "Paul Smith" <phhs80@gmail.com>
Date: Thu, 12 Jun 2008 13:13:50 +0000
Subject: [lm-sensors] Wrong CPU Temp
Message-Id: <6ade6f6c0806120613le2bdc27qa11a78448c8cf194@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <001201c33f14$0ee832a0$f265a8c0@gf01>
In-Reply-To: <001201c33f14$0ee832a0$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dear All,

In the output below, the value

CPU Temp:     -2.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
=3D transistor

seems unlikely:

$ sensors
it8712-isa-0290
Adapter: ISA adapter
VCore 1:     +1.28 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VCore 2:     +1.82 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+3.3V:       +3.38 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+5V:         +6.85 V  (min =3D  +0.00 V, max =3D  +6.85 V)   ALARM
+12V:       +11.84 V  (min =3D  +0.00 V, max =3D +16.32 V)
-12V:       -13.86 V  (min =3D -27.36 V, max =3D  +3.93 V)
-5V:         -7.34 V  (min =3D -13.64 V, max =3D  +4.03 V)
Stdby:       +6.85 V  (min =3D  +0.00 V, max =3D  +6.85 V)   ALARM
VBat:        +4.08 V
fan1:       1704 RPM  (min =3D    0 RPM, div =3D 8)
fan2:          0 RPM  (min =3D    0 RPM, div =3D 8)
fan3:          0 RPM  (min =3D    0 RPM, div =3D 8)
M/B Temp:    -55.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
=3D transistor
CPU Temp:     -2.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
=3D transistor
Temp3:       +47.0=B0C  (low  =3D +127.0=B0C, high =3D +90.0=B0C)  sensor =
=3D thermal diode
cpu0_vid:   +1.350 V

$

My motherboard is a GigaBite GA-81945PL-G, the processor is an Intel
Dual Core, and the operating system is Fedora 9.

Any ideas?

Thanks in advance,

Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
