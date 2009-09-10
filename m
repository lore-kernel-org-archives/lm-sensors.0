From: Eric Schumann <e_r_i_c@gmx.net>
Date: Thu, 10 Sep 2009 13:21:12 +0000
Subject: Re: [lm-sensors] I'm stuck in tweaking the config file for my ABIT
Message-Id: <20090910152112.24c19090.e_r_i_c@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090908133106.54403ca3.e_r_i_c@gmx.net>
In-Reply-To: <20090908133106.54403ca3.e_r_i_c@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,
I took a look what sensors version 3.1.1 does, according to the
standard output I got 4 more labels: it's AVCC, VCC, 3VSB, VBAT.

Is one of them the BIOS label ATX3,3V? Also unclear is if  AGP
VDQ Voltage is in5 or in in9, closer to the BIOS reads in5. What might
be the other value?=20

It might make sense to label in4 DDR VTT Voltage, but the not appearing
of the BIOS reading DDR Voltage still makes me wonder. I cannot find
the fitting value. And I'm still not convinced of my computation
formula, or even if it is in the right place.

just for completeness, this is the blank output from:

sensors version 3.1.1 with libsensors version 3.1.1
acpitz-virtual-0
Adapter: Virtual device
temp1:       +39.5=B0C  (crit =3D +85.0=B0C)                 =20

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +32.0=B0C                                   =20

w83627ehf-isa-0290
Adapter: ISA adapter
Vcore:       +1.38 V  (min =3D  +0.00 V, max =3D  +1.74 V)  =20
in1:         +1.31 V  (min =3D  +1.97 V, max =3D  +0.38 V)   ALARM
AVCC:        +3.25 V  (min =3D  +2.98 V, max =3D  +3.63 V)  =20
VCC:         +3.25 V  (min =3D  +2.98 V, max =3D  +3.63 V)  =20
in4:         +1.30 V  (min =3D  +0.22 V, max =3D  +0.28 V)   ALARM
in5:         +1.56 V  (min =3D  +0.25 V, max =3D  +1.60 V)  =20
in6:         +1.86 V  (min =3D  +1.40 V, max =3D  +0.38 V)   ALARM
3VSB:        +3.25 V  (min =3D  +2.98 V, max =3D  +3.63 V)  =20
Vbat:        +3.20 V  (min =3D  +2.70 V, max =3D  +3.30 V)  =20
in9:         +1.59 V  (min =3D  +0.16 V, max =3D  +0.08 V)   ALARM
fan1:        981 RPM  (min =3D  703 RPM, div =3D 16)
fan2:       1041 RPM  (min =3D  703 RPM, div =3D 16)
fan3:          0 RPM  (min =3D  703 RPM, div =3D 64)  ALARM
fan4:          0 RPM  (min =3D 10546 RPM, div =3D 64)  ALARM
fan5:          0 RPM  (min =3D  703 RPM, div =3D 64)
temp1:       +32.0=B0C  (high =3D -42.0=B0C, hyst =3D +53.0=B0C)  sensor th=
ermistor temp2:       +39.5=B0C  (high =3D +85.0=B0C, hyst =3D +80.0=B0C)
sensor =3D diode temp3:       +35.5=B0C  (high =3D +85.0=B0C, hyst =3D +80.=
0=B0C)
sensor =3D thermistor cpu0_vid:   +1.350 V

my actual label configuration is:
    label in0 "CPU Core Voltage"
    label in1 "ATX +12V"
    label in2 "AVCC" #according to standard output  =20
    label in3 "VCC"  #according to standard output
    label in4 "DDR VTT Voltage"
    label in5 "? AGP VDQ Voltage"
    label in6 "ATX +5V"
    label in7 "3VSB" #according to standard output  =20
    label in8 "VBAT" #according to standard output  =20
    label in9 "? AGP VDQ Voltage"

 compute in1 @*(1+(84.56/10)),  @/(1+(84.56/10))# too high
 compute in6 @*(1+(14.95/10)),  @/(1+(14.95/10))# too low


the resulting output is:
w83627ehf-isa-0290
Adapter: ISA adapter
CPU Core Voltage:  +1.11 V  (min =3D  +0.00 V, max =3D  +1.74 V)  =20
ATX +12V:         +12.33 V  (min =3D +18.61 V, max =3D  +3.63 V)   ALARM
AVCC:              +3.25 V  (min =3D  +1.58 V, max =3D  +2.53 V)   ALARM
VCC:               +3.25 V  (min =3D  +2.10 V, max =3D  +2.54 V)   ALARM
DDR VTT Voltage:   +1.30 V  (min =3D  +0.22 V, max =3D  +0.28 V)   ALARM
? AGP VDQ Voltage: +1.56 V  (min =3D  +0.25 V, max =3D  +1.63 V)  =20
ATX +5V:           +4.67 V  (min =3D  +3.81 V, max =3D  +0.96 V)   ALARM
3VSB:              +3.25 V  (min =3D  +3.14 V, max =3D  +2.02 V)   ALARM
VBAT:              +3.20 V  (min =3D  +2.32 V, max =3D  +0.66 V)   ALARM
? AGP VDQ Voltage: +1.58 V  (min =3D  +0.16 V, max =3D  +0.08 V)   ALARM
Case Fan:          981 RPM  (min =3D  351 RPM, div =3D 32)
CPU Fan:          1004 RPM  (min =3D  351 RPM, div =3D 32)
Aux Fan:             0 RPM  (min =3D 3515 RPM, div =3D 128)  ALARM
fan4:                0 RPM  (min =3D 10546 RPM, div =3D 32)  ALARM
fan5:                0 RPM  (min =3D  703 RPM, div =3D 128)  ALARM
Sys Temp:          +31.0=B0C  (high =3D -42.0=B0C, hyst =3D +53.0=B0C)  sen=
sor thermistor CPU Temp:          +35.0=B0C  (high =3D +85.0=B0C, hyst =3D =
+80.0=B0
C)  sensor =3D diode AUX Temp:          +31.0=B0C  (high =3D +85.0=B0C, hys=
t +80.0=B0C)  sensor =3D thermistor cpu0_vid:         +1.350 V

does this make sense?
regards
eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
