From: ci3nt <ci3nte@googlemail.com>
Date: Sun, 24 Apr 2011 22:25:02 +0000
Subject: [lm-sensors] coretemp
Message-Id: <4DB4A33E.3080305@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

I have a the Gigabyte GA-D525TUD mainboard with an Intel Atom D525. Now
I want to get the temparature of the CPU, but the output of sensors is:

$ sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:          N/A  (crit =3D +100.0=B0C)                =20

coretemp-isa-0001
Adapter: ISA adapter
Core 1:          N/A  (crit =3D +100.0=B0C)                =20

it8720-isa-0290
Adapter: ISA adapter
in0:         +1.10 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
in1:         +1.52 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
in2:         +3.33 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
+5V:         +2.98 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
in4:         +3.26 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
in5:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in6:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
5VSB:        +2.99 V  (min =3D  +0.00 V, max =3D  +4.08 V) =20
Vbat:        +3.12 V
fan1:       4017 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
temp1:       -55.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
thermistor
temp2:       +64.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
thermistor
temp3:       +29.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor =
thermal diode
cpu0_vid:   +1.850 V

The coretemp module is compiled in. If I try to figure it out manually,
this is the output:

$ cat /sys/class/hwmon/hwmon0/device/temp1_input
cat: /sys/class/hwmon/hwmon0/device/temp1_input: Die Ressource ist zur
Zeit nicht verf=FCgbar (Translation: ressource not available)

The kernel says this about coretemp:

$ dmesg | grep coretemp
[    1.381832] coretemp coretemp.0: Unable to read TjMax from CPU.
[    1.381944] coretemp coretemp.0: Using relative temperature scale!
[    1.382313] coretemp coretemp.1: Unable to read TjMax from CPU.
[    1.382422] coretemp coretemp.1: Using relative temperature scale!

versions:

$ sensors -v
sensors version 3.2.0 with libsensors version 3.2.0
$ uname -r
2.6.37-hardened-r7


If you need more information, ask or if you understand German look in
this thread: http://forums.gentoo.org/viewtopic.php?pf61395#6661395

Can you help to get an output?



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
