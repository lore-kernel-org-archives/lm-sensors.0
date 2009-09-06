From: Eric Schumann <e_r_i_c@gmx.net>
Date: Sun, 06 Sep 2009 17:22:08 +0000
Subject: [lm-sensors] I forgot 2 tell the W83687thf was on an EPoX EP-9HEAI
Message-Id: <20090906192208.e499759a.e_r_i_c@gmx.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Multipart=_Sun__6_Sep_2009_19_22_08_+0200_Jik/gDeZRbwrMaLt"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sun__6_Sep_2009_19_22_08_+0200_Jik/gDeZRbwrMaLt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
I sent this to you in January, but forgot to tell the MB model, sorry.
It was an EPoX EP-9HEAI. I hope the information is complete and OK now,
as I don't have it anymore. TX 
Eric Schumann

--Multipart=_Sun__6_Sep_2009_19_22_08_+0200_Jik/gDeZRbwrMaLt
Content-Type: text/plain;
 name="senunconf.txt"
Content-Disposition: attachment;
 filename="senunconf.txt"
Content-Transfer-Encoding: quoted-printable

acpitz-virtual-0
Adapter: Virtual device
temp1:       +33.0=C2=B0C  (crit =3D +70.0=C2=B0C)                 =20

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +19.0=C2=B0C                                   =20

w83687thf-isa-0290
Adapter: ISA adapter
in0:         +1.13 V  (min =3D  +0.70 V, max =3D  +1.87 V)  =20
in1:         +3.26 V  (min =3D  +0.62 V, max =3D  +1.01 V)   ALARM
in2:         +2.50 V  (min =3D  +2.37 V, max =3D  +3.94 V)  =20
in3:         +2.98 V  (min =3D  +4.06 V, max =3D  +3.30 V)   ALARM
in4:         +1.49 V  (min =3D  +3.97 V, max =3D  +2.42 V)   ALARM
in7:         +2.98 V  (min =3D  +3.06 V, max =3D  +0.29 V)   ALARM
in8:         +3.33 V  (min =3D  +1.97 V, max =3D  +4.03 V)  =20
fan1:          0 RPM  (min =3D  694 RPM, div =3D 8)  ALARM
fan2:       1814 RPM  (min =3D  688 RPM, div =3D 8)
fan3:          0 RPM  (min =3D  922 RPM, div =3D 8)  ALARM
temp1:       +27.0=C2=B0C  (high =3D -67.0=C2=B0C, hyst =3D -105.0=C2=B0C) =
 ALARM  sensor =3D thermistor
temp2:       +33.5=C2=B0C  (high =3D +72.0=C2=B0C, hyst =3D +70.0=C2=B0C)  =
sensor =3D thermistor
temp3:       +13.0=C2=B0C  (high =3D +70.0=C2=B0C, hyst =3D +65.0=C2=B0C)  =
sensor =3D thermistor
beep_enable:enabled



--Multipart=_Sun__6_Sep_2009_19_22_08_+0200_Jik/gDeZRbwrMaLt
Content-Type: text/plain;
 name="senconf.txt"
Content-Disposition: attachment;
 filename="senconf.txt"
Content-Transfer-Encoding: quoted-printable

acpitz-virtual-0
Adapter: Virtual device
temp1:       +33.0=C2=B0C  (crit =3D +70.0=C2=B0C)                 =20

k8temp-pci-00c3
Adapter: PCI adapter
temp1:       +18.0=C2=B0C                                   =20

w83687thf-isa-0290
Adapter: ISA adapter
VCore:                +1.14 V  (min =3D  +0.70 V, max =3D  +1.87 V)  =20
+3.3V:                +3.26 V  (min =3D  +3.14 V, max =3D  +3.47 V)  =20
Vdim:                 +2.50 V  (min =3D  +2.48 V, max =3D  +2.93 V)  =20
+5V:                  +5.03 V  (min =3D  +4.76 V, max =3D  +5.24 V)  =20
Chip:                 +1.49 V  (min =3D  +1.49 V, max =3D  +1.76 V)  =20
5VSB:                 +5.00 V  (min =3D  +4.76 V, max =3D  +5.24 V)  =20
VBat:                 +3.33 V  (min =3D  +2.40 V, max =3D  +3.60 V)  =20
Chassis Fan:          620 RPM  (min =3D  399 RPM, div =3D 16)
CPU Fan:             1757 RPM  (min =3D  688 RPM, div =3D 8)
Power Fan 2 B bought:   0 RPM  (min =3D  917 RPM, div =3D 16)  ALARM
System Temp:          +27.0=C2=B0C  (high =3D +50.0=C2=B0C, hyst =3D +45.0=
=C2=B0C)  sensor =3D thermistor
CPU Temp:             +33.5=C2=B0C  (high =3D +72.0=C2=B0C, hyst =3D +70.0=
=C2=B0C)  sensor =3D thermistor
Strange Temp:         +10.0=C2=B0C  (high =3D +70.0=C2=B0C, hyst =3D +65.0=
=C2=B0C)  sensor =3D thermistor
beep_enable:         enabled



--Multipart=_Sun__6_Sep_2009_19_22_08_+0200_Jik/gDeZRbwrMaLt
Content-Type: text/plain;
 name="sensors.conf.txt"
Content-Disposition: attachment;
 filename="sensors.conf.txt"
Content-Transfer-Encoding: quoted-printable

# W83687THF w83627hf 	2.10.0 	2.6.17 	Super I/O, mostly similar to the W836=
27THF. Support contributed by Jean Delvare.
#found on EPoX EP-9HEAI V3.0 VIA KT890 Socket 939
chip "w83687thf-*"
    label in0 "VCore"
    label in1 "+3.3V"
    label in2 "Vdim"
    label in3  "+5V"  # "+5V"
    label in4 "Chip"
    label in5 "not shown by sensors"
    label in6  "not shown by sensors"
    label in7 "5VSB"
    label in8 "VBat"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
#    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
#    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
#    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# adjust this if your vid is wrong; see doc/vid
#   set vrm 9.0

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

#    set in0_min vid*0.95
#    set in0_max vid*1.05
    set in1_min 3.3 * 0.95
    set in1_max 3.3 * 1.05
    set in2_min 2.5 * 0.99
    set in2_max 2.5 * 1.17
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min  1.5 * 0.99
    set in4_max  1.5 * 1.17
#    set in5_max -12 * 0.90
#    set in5_min -12 * 1.10
#    set in6_max -5 * 0.95
#    set in6_min -5 * 1.05
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    set in8_min 3.0 * 0.80
    set in8_max 3.0 * 1.20

# set up sensor types (thermistor is default)
# 1 =3D PII/Celeron Diode; 2 =3D 3904 transistor;
# 3435 =3D thermistor with Beta =3D 3435
# If temperature changes very little, try 1 or 2.
#   set sensor1 1
#   set sensor2 2
#   set sensor3 3435

# temperature limits
set temp1_max 50
set temp1_max_hyst 45
# temp 3 less than room temp (hopefully current: 8=C2=B0), perhaps wifi 2 f=
ridge
label temp1 "System Temp"
label temp2 "CPU Temp"
label temp3 "Strange Temp"
#       ignore temp3
label fan2 "CPU Fan"
label fan3 "Power Fan 2 B bought"
label fan1 "Chassis Fan"
set fan1_div 16
#set fan2_div 8
set fan3_div 16
set fan1_min 400


--Multipart=_Sun__6_Sep_2009_19_22_08_+0200_Jik/gDeZRbwrMaLt
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Multipart=_Sun__6_Sep_2009_19_22_08_+0200_Jik/gDeZRbwrMaLt--
