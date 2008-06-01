From: "James Dietrich" <jdietrch@gmail.com>
Date: Sun, 01 Jun 2008 23:45:38 +0000
Subject: [lm-sensors] sensors3.conf for Intel DG35EC motherboard
Message-Id: <9dd1c6ea0806011645o354a7fddj61184498b5d47ad7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I recently purchased an Intel DG35EC motherboard, and am trying to
figure out the hardware monitoring capability included on that
motherboard. It seems that the hardware is being detected ok; I just
need help setting up sensors3.conf properly.

Here is the output from near the end of sensors-detect:
Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `w83627ehf' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x6e0
    Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

So I compiled those drivers into my kernel, and dmesg reports this:
coretemp coretemp.0: Using relative temperature scale!
coretemp coretemp.1: Using relative temperature scale!
w83627ehf: Found W83627DHG chip at 0x6e0

I have checked on the motherboard, and there is a Winbond 83627DHG-A
chip on there.

I have successfully adjusted the Fans section, but I'm having trouble
with the Voltage and Temperature readings. Running 'sensors' gives
values, but they don't seem to be right.

Here is the output of sensors with all lines commented out except for
fan-related ones:
arcturus:/etc# uname -a
Linux arcturus 2.6.25.4 #8 SMP Fri May 30 20:08:21 EDT 2008 i686 GNU/Linux
arcturus:/etc# sensors -v
sensors version 3.0.1 with libsensors version 3.0.1
arcturus:/etc# sensors -s
arcturus:/etc# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +45.0=B0C  (high =3D +78.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +45.0=B0C  (high =3D +78.0=B0C, crit =3D +100.0=B0C)

w83627dhg-isa-06e0
Adapter: ISA adapter
in0:         +0.87 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:         +1.54 V  (min =3D  +1.42 V, max =3D  +1.74 V)
in2:         +2.96 V  (min =3D  +3.58 V, max =3D  +2.94 V)   ALARM
in3:         +2.94 V  (min =3D  +0.96 V, max =3D  +1.86 V)   ALARM
in4:         +0.94 V  (min =3D  +0.26 V, max =3D  +1.58 V)
in5:         +1.29 V  (min =3D  +0.90 V, max =3D  +0.51 V)   ALARM
in6:         +0.37 V  (min =3D  +2.04 V, max =3D  +2.04 V)   ALARM
in7:         +2.96 V  (min =3D  +1.23 V, max =3D  +3.34 V)
in8:         +2.96 V  (min =3D  +0.70 V, max =3D  +1.54 V)   ALARM
Rear Fan:    827 RPM  (min =3D  502 RPM, div =3D 16)
CPU Fan:     888 RPM  (min =3D  502 RPM, div =3D 16)
Front Fan:  1125 RPM  (min =3D  502 RPM, div =3D 16)
temp1:       +79.0=B0C  (high =3D +47.0=B0C, hyst =3D +127.0=B0C)  sensor =
=3D thermistor
temp2:       +59.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
temp3:      -128.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
cpu0_vid:   +2.050 V

arcturus:/etc#

Probably I should ignore temp3, but temp1 and temp2 seem too high. The
BIOS gives values in the neighborhood of 43C for processor and 30C for
internal.

Then about the voltages, I don't know how to tell which ones to
ignore, nor how to compute the proper value of the rest. The BIOS
gives four values like these:
V12.0 -> 11.86
V5.0 -> 5.885
V1.25 -> 1.251
Vccp -> 1.109

Is there anyone who could help me figure out the proper label,
compute, and ignore lines for this motherboard? Please let me know if
I can supply any additional information.

Thank you very much for your help,
James Dietrich

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
