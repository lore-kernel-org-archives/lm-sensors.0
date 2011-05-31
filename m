From: "Fred ." <eldmannen@gmail.com>
Date: Tue, 31 May 2011 17:31:45 +0000
Subject: [lm-sensors] bug, I get -2 minus temperature
Message-Id: <BANLkTikqbDkfbazwjWB4kd24Jn5AG=Aj3w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

$ sensors
it8718-isa-0290
Adapter: ISA adapter
in0:         +1.15 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in1:         +1.79 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in2:         +3.26 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+5V:         +2.96 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in4:         +0.19 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in5:         +0.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in6:         +0.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in7:         +3.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)
Vbat:        +3.12 V
fan1:       1901 RPM  (min =3D   10 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
fan3:          0 RPM  (min =3D    0 RPM)
fan4:          0 RPM  (min =3D    0 RPM)
temp1:       +54.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
=3D thermistor
temp2:       +36.0=B0C  (low  =3D +127.0=B0C, high =3D +60.0=B0C)  sensor =
=3D thermal diode
temp3:        -2.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
=3D thermistor

It says -2.0=B0C, thats crazy! It must be some bug!
Nothing in my computer is -2.0=B0C, thats ice cold!

Please fix this bug.

Also, the other values are they ok or bad?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
