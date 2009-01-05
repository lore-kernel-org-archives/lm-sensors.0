From: Eric Schumann <e_r_i_c@gmx.net>
Date: Mon, 05 Jan 2009 18:32:34 +0000
Subject: [lm-sensors] W83687thf reads fine using sensors
Message-Id: <20090105193234.0b5d228c@Dominique>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/4ny_heC4YmLHLIWl_RZoank"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--MP_/4ny_heC4YmLHLIWl_RZoank
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I want to share with you, that sensors read W83687thf fine here. I
found it working on my new EPoX 939 mainboard, which is in fact some
years old, but new here. Kernel 2.6.26 and Debian running.I got some
values corresponding to the BIOS output and a strange temperature
reading. I tried to configure and hope I got it mostly right.
OK not perfect as I cut the core temp entry by accident ;-)

TX 
Eric Schumann
--MP_/4ny_heC4YmLHLIWl_RZoank
Content-Type: text/plain; name=senunconf.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=senunconf.txt

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


--MP_/4ny_heC4YmLHLIWl_RZoank
Content-Type: text/plain; name=senconf.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=senconf.txt

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


--MP_/4ny_heC4YmLHLIWl_RZoank
Content-Type: text/plain; name=sensors.conf.txt
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=sensors.conf.txt

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

--MP_/4ny_heC4YmLHLIWl_RZoank
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/4ny_heC4YmLHLIWl_RZoank--
