From: Justin T Pryzby <justinp@norchemlab.com>
Date: Fri, 03 Apr 2009 22:37:13 +0000
Subject: [lm-sensors] sensors alarm, bad hw values?
Message-Id: <20090403223713.GA26020@norchemlab.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Output of sensors on one of our machines yields a few ALARMs.  Some of
those seem to be datafile problems:
  V5SB:        +5.59 V  (min =3D  +5.83 V, max =3D  +2.31 V)   ALARM

and some seem to be hardware problems (false positive?).
  +3.3V:       +1.87 V  (min =3D  +2.82 V, max =3D  +3.79 V)   ALARM

Could I do anything to resolve that?
This is linux 2.6.27-11-server and 1:3.0.2-1ubuntu2

Thanks,
Justin

w83793-i2c-0-2f
Adapter: SMBus I801 adapter at 1100
VCoreA:      +1.24 V  (min =3D  +0.92 V, max =3D  +1.49 V)  =20
VCoreB:      +1.21 V  (min =3D  +0.92 V, max =3D  +1.49 V)  =20
Vtt:         +1.19 V  (min =3D  +1.08 V, max =3D  +1.33 V)  =20
in3:         +0.51 V  (min =3D  +0.38 V, max =3D  +0.69 V)  =20
in4:         +1.49 V  (min =3D  +1.34 V, max =3D  +1.65 V)  =20
+3.3V:       +3.30 V  (min =3D  +2.96 V, max =3D  +3.63 V)  =20
+12V:       +11.90 V  (min =3D +10.75 V, max =3D +13.25 V)  =20
+5V:         +5.09 V  (min =3D  +4.64 V, max =3D  +5.65 V)  =20
5VSB:        +5.02 V  (min =3D  +4.64 V, max =3D  +5.65 V)  =20
VBAT:        +3.26 V  (min =3D  +2.99 V, max =3D  +3.66 V)  =20
fan1:       13235 RPM  (min =3D  712 RPM)
fan2:       9310 RPM  (min =3D  712 RPM)
fan3:       13235 RPM  (min =3D  712 RPM)
fan4:       9060 RPM  (min =3D  712 RPM)
fan5:       13106 RPM  (min =3D  712 RPM)
fan6:       9440 RPM  (min =3D  712 RPM)
fan7:       13235 RPM  (min =3D  712 RPM)
fan8:       9310 RPM  (min =3D  712 RPM)
fan9:          0 RPM  (min =3D  712 RPM)  ALARM
fan10:         0 RPM  (min =3D  712 RPM)  ALARM
CPU1 Temp:   +24.0=B0C  (high =3D +75.0=B0C, hyst =3D +70.0=B0C)  sensor =
=3D Intel PECI
CPU2 Temp:   +26.0=B0C  (high =3D +75.0=B0C, hyst =3D +70.0=B0C)  sensor =
=3D Intel PECI
temp3:       +21.5=B0C  (high =3D +75.0=B0C, hyst =3D +70.0=B0C)  sensor =
=3D Intel PECI
temp4:       +22.0=B0C  (high =3D +75.0=B0C, hyst =3D +70.0=B0C)  sensor =
=3D Intel PECI
temp5:       +29.0=B0C  (high =3D +50.0=B0C, hyst =3D +45.0=B0C)  sensor =
=3D thermistor
beep_enable:disabled

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:     +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
VCore 2:     +0.91 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
+3.3V:       +1.87 V  (min =3D  +2.82 V, max =3D  +3.79 V)   ALARM
+5V:         +5.13 V  (min =3D  +5.99 V, max =3D  +4.41 V)   ALARM
+12V:       +11.67 V  (min =3D  +5.59 V, max =3D +15.50 V)  =20
-12V:        -5.70 V  (min =3D  +6.06 V, max =3D  +5.07 V)   ALARM
-5V:         +3.04 V  (min =3D  +5.10 V, max =3D  +5.10 V)   ALARM
V5SB:        +5.59 V  (min =3D  +5.83 V, max =3D  +2.31 V)   ALARM
VBat:        +3.31 V  (min =3D  +4.08 V, max =3D  +4.08 V)   ALARM
fan1:       9246 RPM  (min =3D    0 RPM, div =3D 2)
fan2:          0 RPM  (min =3D    0 RPM, div =3D 2)
fan3:          0 RPM  (min =3D    0 RPM, div =3D 2)
temp1:       -48.0=B0C  (high =3D  -1.0=B0C, hyst =3D  -1.0=B0C)  sensor =
=3D thermistor
temp2:       -48.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
temp3:       -48.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
cpu0_vid:   +1.419 V
beep_enable:enabled

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +43.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +45.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +40.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +45.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0004
Adapter: ISA adapter
Core 4:      +37.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0005
Adapter: ISA adapter
Core 5:      +43.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0006
Adapter: ISA adapter
Core 6:      +42.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0007
Adapter: ISA adapter
Core 7:      +42.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C) =20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
