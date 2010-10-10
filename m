From: =?iso-8859-1?Q?=22Leonardo_Mar=EDn=22?= <el_lalomarin@gmx.com>
Date: Sun, 10 Oct 2010 02:52:01 +0000
Subject: [lm-sensors] Configuration MSI 975X Platinum (MS-7246)
Message-Id: <20101010030436.310360@gmx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7163870118419621273=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7163870118419621273==
Content-Type: multipart/alternative;
 boundary="========GMXBoundary310361286679876934962"

--========GMXBoundary310361286679876934962
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

# lm_sensors configuration file for the MSI 975X Platinum (MS-7246), Bios (v1.40)
# Sensor Chip, Winbond W83627EHF/EHG

#######################
### sensors3.conf ###

chip "w83627ehf-*" "w83627dhg-*"

 label in0 "VCore" # CPU Core Voltage
 label in1 "VPCIEx" # PCI Express Voltage
 label in2 "AVCC"
 label in3 "3VCC"
 label in6 "+ 5V" # +5V, or so i think
 label in7 "3VSB"
 label in8 "VBAT"
 label in9 "+12V" # +12V, or so i think

## +12V is in9 and +5V is in6 ##
 compute in9 @*(1+(56/10)), @/(1+(56/10))
 compute in6 @*(1+(22/10)), @/(1+(22/10))

 set in9_min 12.0*0.9
 set in9_max 12.0*1.1
 set in6_min 5.0*0.9
 set in6_max 5.0*1.1

 set in0_min 0.9
 set in0_max 1.7
 set in1_min 1.4
 set in1_max 2.0
 set in2_min 3.3*0.9
 set in2_max 3.3*1.1
 set in3_min 3.3*0.9
 set in3_max 3.3*1.1
 set in7_min 3.3*0.9
 set in7_max 3.3*1.1
 set in8_min 3.3*0.9
 set in8_max 3.3*1.1

 ignore in4
 ignore in5

## Temperatures ##

 label temp1 "Sys Temp"
 label temp2 "CPU Temp"
 label temp3 "AUX Temp"

 set temp1_max 55
 set temp1_max_hyst 48
 set temp2_max 55
 set temp2_max_hyst 47
 set temp3_max 55
 set temp3_max_hyst 50

## Fans ##

 label fan1 "PWR Fan"
 label fan2 "CPU Fan"
 label fan3 "NB Fan"
 label fan4 "Sys Fan"

 set fan2_min 800

 ignore fan1
 ignore fan3
 ignore fan4
 ignore fan5

### end of sensors3.conf ###
############################

############
### demo ###
#
# root@LM # sensors
# w83627ehf-isa-0290
# Adapter: ISA adapter
# VCore: +1.24 V (min = +0.90 V, max = +1.70 V) 
# VPCIEx: +1.54 V (min = +1.40 V, max = +2.00 V) 
# AVCC: +3.30 V (min = +2.98 V, max = +3.63 V) 
# 3VCC: +3.30 V (min = +2.98 V, max = +3.63 V) 
# + 5V: +5.02 V (min = +4.51 V, max = +5.50 V) 
# 3VSB: +3.25 V (min = +2.98 V, max = +3.63 V) 
# VBAT: +2.99 V (min = +2.98 V, max = +3.63 V) 
# +12V: +12.14 V (min = +10.82 V, max = +13.20 V) 
# CPU Fan: 3515 RPM (min = 803 RPM, div = 16)
# Sys Temp: +39.0°C (high = +55.0°C, hyst = +48.0°C) sensor = thermistor
# CPU Temp: +35.5°C (high = +55.0°C, hyst = +47.0°C) sensor = diode
# AUX Temp: +46.0°C (high = +55.0°C, hyst = +50.0°C) sensor = thermistor
# cpu0_vid: +1.288 V
#
#### end demo ###
#################



L.J.Marín
Linux Counter # 447624

--========GMXBoundary310361286679876934962
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns=3D"http://www.w3.org/1999/xhtml" xml:lang=3D"en" lang=3D"en"><h=
ead><title></title><meta http-equiv=3D"Content-type" content=3D"text/html; =
charset=3DUTF-8" /><style type=3D"text/css">p { margin:0px; padding:0px; }<=
/style></head><body style=3D'background-color:rgb(255, 255, 255);background=
-image:none;background-repeat:repeat;background-position:0% 0%;font-family:=
Verdana,Geneva,Arial,Helvetica,sans-serif;font-size:12px;margin-top:0px;mar=
gin-bottom:0px;margin-left:0px;margin-right:0px;padding-top:5px;padding-bot=
tom:5px;padding-left:5px;padding-right:5px;'><p style=3D"margin:0px; paddin=
g:0px;" ><span style=3D"font-family:Verdana;"><font size=3D"2"><font size=
=3D"3"></font></font></span></p><p style=3D"margin:0px; padding:0px;" ><spa=
n style=3D"font-family:Arial;"><font size=3D"4"></font></span></p># lm_sens=
ors configuration file for the MSI 975X Platinum (MS-7246), Bios (v1.40)<br=
 /># Sensor Chip, Winbond W83627EHF/EHG<br /><br />#######################<=
br />###=C2=A0 sensors3.conf=C2=A0 ###<br /><br />chip &quot;w83627ehf-*&qu=
ot; &quot;w83627dhg-*&quot;<br /><br />=C2=A0=C2=A0=C2=A0 label in0 &quot;V=
Core&quot;=C2=A0=C2=A0=C2=A0 # CPU Core Voltage<br />=C2=A0=C2=A0=C2=A0 lab=
el in1 &quot;VPCIEx&quot;=C2=A0=C2=A0=C2=A0 # PCI Express Voltage<br />=C2=
=A0=C2=A0=C2=A0 label in2 &quot;AVCC&quot;<br />=C2=A0=C2=A0=C2=A0 label in=
3 &quot;3VCC&quot;<br />=C2=A0=C2=A0=C2=A0 label in6 &quot;+ 5V&quot;=C2=A0=
=C2=A0=C2=A0 # +5V, or so i think<br />=C2=A0=C2=A0=C2=A0 label in7 &quot;3=
VSB&quot;<br />=C2=A0=C2=A0=C2=A0 label in8 &quot;VBAT&quot;<br />=C2=A0=C2=
=A0=C2=A0 label in9 &quot;+12V&quot;=C2=A0=C2=A0=C2=A0 # +12V, or so i thin=
k<br /><br />## +12V is in9 and +5V is in6 ##<br />=C2=A0=C2=A0=C2=A0 compu=
te in9 @*(1+(56/10)),=C2=A0 @/(1+(56/10))<br />=C2=A0=C2=A0=C2=A0 compute i=
n6 @*(1+(22/10)),=C2=A0 @/(1+(22/10))<br /><br />=C2=A0=C2=A0=C2=A0 set in9=
_min=C2=A0=C2=A0 12.0*0.9<br />=C2=A0=C2=A0=C2=A0 set in9_max=C2=A0=C2=A0 1=
2.0*1.1<br />=C2=A0=C2=A0=C2=A0 set in6_min=C2=A0=C2=A0 5.0*0.9<br />=C2=A0=
=C2=A0=C2=A0 set in6_max=C2=A0=C2=A0 5.0*1.1<br /><br />=C2=A0=C2=A0=C2=A0 =
set in0_min=C2=A0=C2=A0 0.9<br />=C2=A0=C2=A0=C2=A0 set in0_max=C2=A0=C2=A0=
 1.7<br />=C2=A0=C2=A0=C2=A0 set in1_min=C2=A0=C2=A0 1.4<br />=C2=A0=C2=A0=
=C2=A0 set in1_max=C2=A0=C2=A0 2.0<br />=C2=A0=C2=A0=C2=A0 set in2_min=C2=
=A0=C2=A0 3.3*0.9<br />=C2=A0=C2=A0=C2=A0 set in2_max=C2=A0=C2=A0 3.3*1.1<b=
r />=C2=A0=C2=A0=C2=A0 set in3_min=C2=A0=C2=A0 3.3*0.9<br />=C2=A0=C2=A0=C2=
=A0 set in3_max=C2=A0=C2=A0 3.3*1.1<br />=C2=A0=C2=A0=C2=A0 set in7_min=C2=
=A0=C2=A0 3.3*0.9<br />=C2=A0=C2=A0=C2=A0 set in7_max=C2=A0=C2=A0 3.3*1.1<b=
r />=C2=A0=C2=A0=C2=A0 set in8_min=C2=A0=C2=A0 3.3*0.9<br />=C2=A0=C2=A0=C2=
=A0 set in8_max=C2=A0=C2=A0 3.3*1.1<br /><br />=C2=A0=C2=A0=C2=A0 ignore in=
4<br />=C2=A0=C2=A0=C2=A0 ignore in5<br /><br />## Temperatures ##<br /><br=
 />=C2=A0=C2=A0=C2=A0 label temp1=C2=A0=C2=A0=C2=A0=C2=A0 &quot;Sys Temp&qu=
ot;<br />=C2=A0=C2=A0=C2=A0 label temp2=C2=A0=C2=A0=C2=A0=C2=A0 &quot;CPU T=
emp&quot;<br />=C2=A0=C2=A0=C2=A0 label temp3=C2=A0=C2=A0=C2=A0=C2=A0 &quot=
;AUX Temp&quot;<br /><br />=C2=A0=C2=A0=C2=A0 set temp1_max=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 55<br />=C2=A0=C2=A0=C2=A0 set temp1_max_hyst=C2=A0 4=
8<br />=C2=A0=C2=A0=C2=A0 set temp2_max=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 55<br />=C2=A0=C2=A0=C2=A0 set temp2_max_hyst=C2=A0 47<br />=C2=A0=C2=A0=
=C2=A0 set temp3_max=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 55<br />=C2=A0=C2=
=A0=C2=A0 set temp3_max_hyst=C2=A0 50<br /><br />## Fans ##<br /><br />=C2=
=A0=C2=A0=C2=A0 label fan1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;PWR Fan&quot=
;<br />=C2=A0=C2=A0=C2=A0 label fan2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;CP=
U Fan&quot;<br />=C2=A0=C2=A0=C2=A0 label fan3=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &quot;NB Fan&quot;<br />=C2=A0=C2=A0=C2=A0 label fan4=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 &quot;Sys Fan&quot;<br /><br />=C2=A0=C2=A0=C2=A0 set fan2_min=
=C2=A0=C2=A0=C2=A0 800<br /><br />=C2=A0=C2=A0=C2=A0 ignore fan1<br />=C2=
=A0=C2=A0=C2=A0 ignore fan3<br />=C2=A0=C2=A0=C2=A0 ignore fan4<br />=C2=A0=
=C2=A0=C2=A0 ignore fan5<br /><br />### end of sensors3.conf ###<br />#####=
#######################<br /><br />############<br />### demo ###<br />#<br=
 />#=C2=A0=C2=A0=C2=A0 root@LM # sensors<br />#=C2=A0=C2=A0=C2=A0 w83627ehf=
-isa-0290<br />#=C2=A0=C2=A0=C2=A0 Adapter: ISA adapter<br />#=C2=A0=C2=A0=
=C2=A0 VCore:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +1.24 V=C2=A0 (min =3D=C2=
=A0 +0.90 V, max =3D=C2=A0 +1.70 V)=C2=A0=C2=A0 <br />#=C2=A0=C2=A0=C2=A0 V=
PCIEx:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +1.54 V=C2=A0 (min =3D=C2=A0 +1.40 V, =
max =3D=C2=A0 +2.00 V)=C2=A0=C2=A0 <br />#=C2=A0=C2=A0=C2=A0 AVCC:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +3.30 V=C2=A0 (min =3D=C2=A0 +2.98 V, max=
 =3D=C2=A0 +3.63 V)=C2=A0=C2=A0 <br />#=C2=A0=C2=A0=C2=A0 3VCC:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +3.30 V=C2=A0 (min =3D=C2=A0 +2.98 V, max =
=3D=C2=A0 +3.63 V)=C2=A0=C2=A0 <br />#=C2=A0=C2=A0=C2=A0 + 5V:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +5.02 V=C2=A0 (min =3D=C2=A0 +4.51 V, max =
=3D=C2=A0 +5.50 V)=C2=A0=C2=A0 <br />#=C2=A0=C2=A0=C2=A0 3VSB:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +3.25 V=C2=A0 (min =3D=C2=A0 +2.98 V, max =
=3D=C2=A0 +3.63 V)=C2=A0=C2=A0 <br />#=C2=A0=C2=A0=C2=A0 VBAT:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +2.99 V=C2=A0 (min =3D=C2=A0 +2.98 V, max =
=3D=C2=A0 +3.63 V)=C2=A0=C2=A0 <br />#=C2=A0=C2=A0=C2=A0 +12V:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 +12.14 V=C2=A0 (min =3D +10.82 V, max =3D +13.20 V=
)=C2=A0=C2=A0 <br />#=C2=A0=C2=A0=C2=A0 CPU Fan:=C2=A0=C2=A0=C2=A0 3515 RPM=
=C2=A0 (min =3D=C2=A0 803 RPM, div =3D 16)<br />#=C2=A0=C2=A0=C2=A0 Sys Tem=
p:=C2=A0=C2=A0=C2=A0 +39.0=C2=B0C=C2=A0 (high =3D +55.0=C2=B0C, hyst =3D +4=
8.0=C2=B0C)=C2=A0 sensor =3D thermistor<br />#=C2=A0=C2=A0=C2=A0 CPU Temp:=
=C2=A0=C2=A0=C2=A0 +35.5=C2=B0C=C2=A0 (high =3D +55.0=C2=B0C, hyst =3D +47.=
0=C2=B0C)=C2=A0 sensor =3D diode<br />#=C2=A0=C2=A0=C2=A0 AUX Temp:=C2=A0=
=C2=A0=C2=A0 +46.0=C2=B0C=C2=A0 (high =3D +55.0=C2=B0C, hyst =3D +50.0=C2=
=B0C)=C2=A0 sensor =3D thermistor<br />#=C2=A0=C2=A0=C2=A0 cpu0_vid:=C2=A0=
=C2=A0 +1.288 V<br />#<br />#### end demo ###<br />#################<br /><=
br /><br /><br />L.J.Mar=C3=ADn<br />Linux Counter # 447624<br /></body></h=
tml>

--========GMXBoundary310361286679876934962--


--===============7163870118419621273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7163870118419621273==--
