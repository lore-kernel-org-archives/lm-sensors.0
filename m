From: Stefano Palmeri <rospolosco@tiscali.it>
Date: Wed, 26 Sep 2007 16:59:57 +0000
Subject: [lm-sensors] 3.0.0 error messages
Message-Id: <200709261859.57251.rospolosco@tiscali.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi.

I just downloaded and installed lm-sensors 3.0.0. I get
some error messages in sensor3 output.=20

kernel 2.6.21.6
modules: k8temp, it87

This the output (at the end of errors you see the temperature data):

stefano@macondo:~$ sensors3
Error: Line 272: Parse error in chip name
Error: Line 277: Label statement before first chip statement
Error: Line 278: Label statement before first chip statement
Error: Line 279: Label statement before first chip statement
Error: Line 280: Label statement before first chip statement
Error: Line 281: Label statement before first chip statement
Error: Line 282: Label statement before first chip statement
Error: Line 283: Label statement before first chip statement
Error: Line 316: Compute statement before first chip statement
Error: Line 317: Compute statement before first chip statement
Error: Line 318: Compute statement before first chip statement
Error: Line 319: Compute statement before first chip statement
Error: Line 323: Set statement before first chip statement
Error: Line 324: Set statement before first chip statement
Error: Line 325: Set statement before first chip statement
Error: Line 326: Set statement before first chip statement
Error: Line 327: Set statement before first chip statement
Error: Line 328: Set statement before first chip statement
Error: Line 329: Set statement before first chip statement
Error: Line 330: Set statement before first chip statement
Error: Line 331: Set statement before first chip statement
Error: Line 332: Set statement before first chip statement
Error: Line 333: Set statement before first chip statement
Error: Line 334: Set statement before first chip statement
Error: Line 335: Set statement before first chip statement
Error: Line 336: Set statement before first chip statement
Error: Line 1039: Parse error in chip name
Error: Line 1060: Parse error in chip name
Error: Line 1070: Parse error in chip name
Error: Line 1080: Parse error in chip name
Error: Line 1090: Parse error in chip name
k8temp-pci-00c3
Adapter: PCI adapter
temp1:       +31.0=B0C
temp3:       +31.0=B0C

it8716-isa-0290
Adapter: ISA adapter
in0:         +1.12 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in1:         +1.86 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in2:         +3.36 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in3:         +2.93 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in4:         +2.98 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in5:         +3.23 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in6:         +1.12 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in7:         +2.96 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in8:         +3.04 V
fan1:       1577 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
temp1:       +37.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
=3D transistor
temp2:       +32.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
=3D transistor
temp3:       +28.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
=3D thermal=20
diode
cpu0_vid:   +1.100 V

Also, sensor-detect suggests 'sensor' instead of 'sensor3'.

# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

Thanks.

Stefano



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
