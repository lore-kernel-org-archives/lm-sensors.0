From: Dean Loros <autocrosser1@gmail.com>
Date: Mon, 08 Sep 2008 03:32:46 +0000
Subject: [lm-sensors] EVGA nForce 750i motherboard
Message-Id: <48C49CDE.7090800@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have just setup a EVGA nForce 750i motherboard for Ubuntu (8.10
testing) & have several ALARM sections. Question is how do I just report
the voltages/fan speeds without alarms?

I am using 3.02 supplied by Ubuntu--listed as sensors are:

lm78-i2c-1-2d, w83627dhg-isa-0290, coretemp & acpitz-virtual-0

The coretemp & acpitz-virtual-0 are working in range--most of the
readings for the lm78 & w83627dhg are throwing alarms even after I
spread the voltage/fanspeed ranges. Output follows:

acpitz-virtual-0
Adapter: Virtual device
temp1:       +40.0=B0C  (crit =3D +60.0=B0C)

lm78-i2c-1-2d
Adapter: SMBus nForce2 adapter at 1c80
VCore 1:     +2.53 V  (min =3D  +2.18 V, max =3D  +3.25 V)
VCore 2:     +2.10 V  (min =3D  +1.86 V, max =3D  +3.25 V)   ALARM
+3.3V:       +3.31 V  (min =3D  +2.30 V, max =3D  +3.47 V)   ALARM
+5V:         +3.31 V  (min =3D  +3.50 V, max =3D  +4.08 V)   ALARM
+12V:        +2.56 V  (min =3D  +4.08 V, max =3D  +4.08 V)   ALARM
-12V:        +3.10 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
-5V:         +3.66 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
fan1:       2986 RPM  (min =3D 2657 RPM, div =3D 2)  ALARM
fan2:       2556 RPM  (min =3D  998 RPM, div =3D 8)  ALARM
fan3:       4963 RPM  (min =3D 10714 RPM, div =3D 2)  ALARM
temp1:       +98.0=B0C  (high =3D +100.0=B0C, hyst =3D +120.0=B0C)  ALARM
cpu0_vid:   +3.100 V

w83627dhg-isa-0290
Adapter: ISA adapter
VCore:       +1.26 V  (min =3D  +1.09 V, max =3D  +1.62 V)
in1:         +6.86 V  (min =3D  +6.12 V, max =3D +10.72 V)
AVCC:        +3.31 V  (min =3D  +2.30 V, max =3D  +3.47 V)
3VCC:        +3.31 V  (min =3D  +3.50 V, max =3D  +4.08 V)   ALARM
in4:         +1.28 V  (min =3D  +2.04 V, max =3D  +2.04 V)   ALARM
in5:         +1.55 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
in6:         +5.86 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
VSB:         +3.31 V  (min =3D  +1.57 V, max =3D  +0.02 V)   ALARM
VBAT:        +3.02 V  (min =3D  +0.10 V, max =3D  +1.54 V)   ALARM
Case Fan:   3000 RPM  (min =3D 2657 RPM, div =3D 2)
CPU Fan:    2556 RPM  (min =3D  998 RPM, div =3D 8)
Aux Fan:    1240 RPM  (min =3D 2678 RPM, div =3D 8)  ALARM
fan4:       1622 RPM  (min =3D  912 RPM, div =3D 8)
fan5:          0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
Sys Temp:    +98.0=B0C  (high =3D +100.0=B0C, hyst =3D +120.0=B0C)  sensor =
thermistor
CPU Temp:    +52.5=B0C  (high =3D +127.0=B0C, hyst =3D  +0.0=B0C)  sensor =
=3D transistor
AUX Temp:    +37.0=B0C  (high =3D +127.0=B0C, hyst =3D  +0.0=B0C)  sensor =
=3D thermistor

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +60.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +61.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +64.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +65.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
