From: David Mathog <dmathog@gmail.com>
Date: Sat, 20 Nov 2010 03:53:10 +0000
Subject: [lm-sensors] it8726 chip?
Message-Id: <AANLkTinP-Bk2MQugbyCz03uwEnLv3si5nvnYX1o-bJae@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

(Sent to the list without subscribing.)

I have a machine at home with an ECS AMD690GM-M2 motherboard.
sensors-detect said this:

Driver `it87' (should be inserted):
=A0 Detects correctly:
=A0 * ISA bus, address 0x228
=A0=A0=A0 Chip `ITE IT8726F Super IO Sensors' (confidence: 9)

Letting sensors-detect do its thing resulted in sensors showing this:


it8716-isa-0228
Adapter: ISA adapter
VCore:=A0=A0=A0=A0=A0=A0 +1.25 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +4.08 V)
VDDR:=A0=A0=A0=A0=A0=A0=A0 +1.23 V=A0 (min =3D=A0 +1.28 V, max =3D=A0 +1.68=
 V)=A0=A0 ALARM
+3.3V:=A0=A0=A0=A0=A0=A0 +1.87 V=A0 (min =3D=A0 +2.78 V, max =3D=A0 +3.78 V=
)=A0=A0 ALARM
+5V:=A0=A0=A0=A0=A0=A0=A0=A0 +4.89 V=A0 (min =3D=A0 +4.49 V, max =3D=A0 +5.=
48 V)
+12V:=A0=A0=A0=A0=A0=A0=A0 +4.86 V=A0 (min =3D=A0 +9.98 V, max =3D +13.95 V=
)=A0=A0 ALARM
in5:=A0=A0=A0=A0=A0=A0=A0=A0 +2.48 V=A0 (min =3D=A0 +0.58 V, max =3D=A0 +1.=
34 V)=A0=A0 ALARM
in6:=A0=A0=A0=A0=A0=A0=A0=A0 +1.81 V=A0 (min =3D=A0 +1.04 V, max =3D=A0 +1.=
36 V)=A0=A0 ALARM
5VSB:=A0=A0=A0=A0=A0=A0=A0 +4.73 V=A0 (min =3D=A0 +4.49 V, max =3D=A0 +5.48=
 V)
VBat:=A0=A0=A0=A0=A0=A0=A0 +2.99 V
CPU Fan:=A0=A0=A0 3443 RPM=A0 (min =3D=A0=A0 10 RPM)
fan2:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0 10 RPM)=A0 ALARM
fan3:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM)
CPU Temp:=A0=A0=A0 +16.0 C=A0 (low=A0 =3D +127.0 C, high =3D +75.0 C)=A0 se=
nsor =3D thermal diode
M/B Temp:=A0=A0 +127.0 C=A0 (low=A0 =3D +127.0 C, high =3D +75.0 C)=A0 ALAR=
M=A0 sensor
=3D thermal diode
cpu0_vid:=A0=A0 +1.000 V

Some of those values are presumably way off.=A0 At least I don't think the
machine would be running with +12V of 4.86V. Here is  the relevant
section of sensors3.conf:

chip "it8716-*"

# Voltages

=A0=A0=A0 label=A0 in0=A0 "VCore"
=A0=A0=A0 label=A0 in1=A0 "VDDR"
=A0=A0=A0 label=A0 in2=A0 "+3.3V"=A0=A0=A0 # VCC3
=A0=A0=A0 label=A0 in3=A0 "+5V"=A0=A0=A0=A0=A0 # VCC
=A0=A0=A0 label=A0 in4=A0 "+12V"
#=A0=A0 label=A0 in5=A0 "-12V"
#=A0=A0 label=A0 in6=A0 "-5V"
=A0=A0=A0 label=A0 in7=A0 "5VSB"=A0=A0=A0=A0 # VCCH
=A0=A0=A0 label=A0 in8=A0 "VBat"

=A0=A0=A0 compute in3=A0 ((6.8/10)+1)*@ , @/((6.8/10)+1)
=A0=A0=A0 compute in4=A0 ((30/10)+1)*@=A0 , @/((30/10)+1)
#=A0=A0 compute in5=A0 (1+232/56)*@ - 4.096*232/56 , (@ + 4.096*232/56)/(1+=
232/56)
#=A0=A0 compute in6=A0 (1+120/56)*@ - 4.096*120/56 , (@ + 4.096*120/56)/(1+=
120/56)
=A0=A0=A0 compute in7=A0 ((6.8/10)+1)*@ , @/((6.8/10)+1)

# If vid (nominal CPU voltage) isn't correct, hardcode the correct value
# instead.
#=A0=A0=A0 set in0_min=A0 cpu0_vid * 0.95
#=A0=A0=A0 set in0_max=A0 cpu0_vid * 1.05
#=A0=A0=A0 set in1_min=A0 1.8 * 0.95
#=A0=A0=A0 set in1_max=A0 1.8 * 1.05
#=A0=A0=A0 set in2_min=A0 3.3 * 0.95
#=A0=A0=A0 set in2_max=A0 3.3 * 1.05
#=A0=A0=A0 set in3_min=A0=A0=A0 5 * 0.95
#=A0=A0=A0 set in3_max=A0=A0=A0 5 * 1.05
#=A0=A0=A0 set in4_min=A0=A0 12 * 0.95
#=A0=A0=A0 set in4_max=A0=A0 12 * 1.05
#=A0=A0=A0 set in5_max=A0 -12 * 0.95
#=A0=A0=A0 set in5_min=A0 -12 * 1.05
#=A0=A0=A0 set in6_max=A0=A0 -5 * 0.95
#=A0=A0=A0 set in6_min=A0=A0 -5 * 1.05
#=A0=A0=A0 set in7_min=A0=A0=A0 5 * 0.95
#=A0=A0=A0 set in7_max=A0=A0=A0 5 * 1.05
# The chip does not support in8 min/max

# Temperatures

# If you are lucky, the BIOS has set the proper sensor types for you.
# If your temperature readings are completely whacky you probably
# need to change the sensor types. Adujst and uncomment the
# appropriate lines below.
#
# 2 =3D thermistor; 3 =3D thermal diode; 0 =3D unused
#=A0=A0 set temp1_type=A0 3
#=A0=A0 set temp2_type=A0 3
#=A0=A0 set temp3_type=A0 3

# If a given sensor isn't used, you will probably want to ignore it
# as well (see ignore statement right below).
# The CPU sensor can be any of temp1, temp2 or temp3 - it's motherboard
# dependent. Same for the motherboard temperature.

=A0=A0 label=A0 temp1=A0 "CPU Temp"
=A0=A0 label=A0 temp2=A0 "M/B Temp"
=A0=A0 ignore temp3

#=A0=A0 set temp1_max=A0 60
#=A0=A0 set temp1_min=A0 10
#=A0=A0 set temp2_max=A0 50
#=A0=A0 set temp2_min=A0 10

# Fans

# The CPU fan can be any of fan1, fan2 or fan3 - it's motherboard
# dependent. Same for the case fan.

=A0=A0 label=A0 fan1 "CPU Fan"
#=A0=A0 label=A0 fan2 "Case Fan"
#=A0=A0 ignore fan3

#=A0=A0 set fan1_min 2000
#=A0=A0 set fan2_min 2000


Kernel is from ubuntu 8.10, 2.6.27-11-generic.  Sensors is 3.0.2

Any suggestions for improving these readings?

Thanks,

David Mathog

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
