From: Igor Netkachev <netkachev@kolbas.it>
Date: Thu, 14 Jun 2012 13:33:01 +0000
Subject: [lm-sensors] w83627 driver bug report
Message-Id: <CAJWOtEk9=VgY_uS1ik91A1Pvh5iwM1vaC9rWGiGu3B+6wrajJw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6301407523041233506=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6301407523041233506==
Content-Type: multipart/alternative; boundary=bcaec554de6015a5bd04c26ebd5e

--bcaec554de6015a5bd04c26ebd5e
Content-Type: text/plain; charset=ISO-8859-1

Greetengs,


We experience permanent problem with w83627dhg driver on serveral machines.

Software version: lm_sensors-2.10.7-9.el5
Sensors driver name: w83627dhg-isa-0a10
OS: CentOS release 5.8 (Final)


============
Description:
============
We use lm_sensors together with nagios/nrpe check_sensors plugin in order
to monitor sensors' status. The problem is that after editing sensors.conf
according to our needs (e.g. ignoring inactive fans or setting min and max
values for specific sensors) and applying the changes with "sensors -s"
command, the sensor's configuration drops back to defaults at a random
moment usually within ~5-30 hours after "sensors -s" has been run. This
makes nagios/nrpe to set the false alarm and send an e-mail to the
customer, and this brings us a lot of pain as long as it happens almost
every night.

========
Example:
========
Below there's sensors' output right after it fell back to defaults:

root@working ~ # sensors
w83627dhg-isa-0a10
Adapter: ISA adapter
Case Fan: 11637 RPM  (min = 12053 RPM, div = 1) ALARM
CPU Fan:  11739 RPM  (min =    0 RPM, div = 1) ALARM
CPU Temp:  +38.0 C  (high =  +0.0 C, hyst = +60.0 C)  [CPU diode ]
AUX Temp:  +29.5 C  (high = +45.0 C, hyst = +60.0 C)  [thermistor]
vid:      +1.300 V

Running "sensors -s" again solves the problem...

root@working ~ # sensors -s
root@working ~ # sensors
w83627dhg-isa-0a10
Adapter: ISA adapter
Case Fan: 11440 RPM  (min = 6026 RPM, div = 2)
CPU Fan:  11637 RPM  (min = 6026 RPM, div = 2)
CPU Temp:  +38.0 C  (high = +56.0 C, hyst = +60.0 C)  [CPU diode ]
AUX Temp:  +29.5 C  (high = +45.0 C, hyst = +60.0 C)  [thermistor]
vid:      +1.300 V

but only for ~5-30 hours, until it drops back to defaults again.

At the moment we haven't found any dependencies between the bug itself and
os/chassis, it occurs on different machines and OSes (so far we had it on
CentOS 5/6 and Debian 5/6).
Please investigate. Feel free to request any additional information you
might need.


A piece of config file related to w83627dhg-isa-0a10 is below:

====
# Winbond W83627EHF configuration originally contributed by Leon Moonen
# This is for an Asus P5P800, voltages for A8V-E SE.
chip "w83627ehf-*" "w83627dhg-*"

#    set fan1_min    2000
#    set fan2_min    2000
    ignore in0
    ignore in1
    ignore in2
    ignore in3
    ignore in4
    ignore in5
    ignore in6
    ignore in7
    ignore in8
    ignore fan5
    label in0 "VCore"
    label in2 "AVCC"
    label in3 "3VCC"
    label in7 "VSB"
    label in8 "VBAT"

# The W83627DHG has no in9, uncomment the following line
#    ignore in9

# +12V is in1 and +5V is in6 as recommended by datasheet
    compute in1 @*(1+(56/10)),  @/(1+(56/10))
    compute in6 @*(1+(22/10)),  @/(1+(22/10))
#    set in1_min   12.0*0.9
#    set in1_max   12.0*1.1
#    set in6_min   5.0*0.95
#    set in6_max   5.0*1.05

# Set the 3.3V
#    set in2_min   3.3*0.95
#    set in2_max   3.3*1.05
#    set in3_min   3.3*0.95
#    set in3_max   3.3*1.05
#    set in7_min   3.3*0.95
#    set in7_max   3.3*1.05
#    set in8_min   3.3*0.95
#    set in8_max   3.3*1.05

# Fans
   label fan1      "Case Fan"
   label fan2      "CPU Fan"
   label fan3      "Aux Fan"
#   ignore fan1
#   ignore fan2
   ignore fan3
   ignore fan4
#   ignore fan5
#  ignore fan4

set fan1_min 6000
set fan2_min 6000
set fan4_min 6000
set fan5_min 6000

# Temperatures
   #set temp2_max   90
   #set temp2_over  95
   #set temp2_hyst  110
   label temp1     "Sys Temp"
   label temp2     "CPU Temp"
   label temp3     "AUX Temp"

ignore temp1
#   ignore temp2
#   ignore temp3
#  ignore temp3
  set temp2_over  56
  set temp2_hyst  60

  set temp3_over  45
  set temp3_hyst  60
====


-- 
Best regards, Igor Netkachev
NK support
netkachev@nksupport.com
http://www.nksupport.com

--bcaec554de6015a5bd04c26ebd5e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Greetengs,<br><br><br>We experience permanent problem with w83627dhg driver=
 on serveral machines. <br><br>Software version: lm_sensors-2.10.7-9.el5<br=
>Sensors driver name: w83627dhg-isa-0a10<br>OS: CentOS release 5.8 (Final)<=
br>

<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Description:<br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>We
 use lm_sensors together with nagios/nrpe check_sensors plugin in order=20
to monitor sensors&#39; status. The problem is that after editing=20
sensors.conf according to our needs (e.g. ignoring inactive fans or=20
setting min and max values for specific sensors) and applying the=20
changes with &quot;sensors -s&quot; command, the sensor&#39;s configuration=
 drops back
 to defaults at a random moment usually within ~5-30 hours after=20
&quot;sensors -s&quot; has been run. This makes nagios/nrpe to set the fals=
e alarm
 and send an e-mail to the customer, and this brings us a lot of pain as
 long as it happens almost every night.<br>
<br>=3D=3D=3D=3D=3D=3D=3D=3D<br>Example:<br>=3D=3D=3D=3D=3D=3D=3D=3D<br>Bel=
ow there&#39;s sensors&#39; output right after it fell back to defaults:<br=
><br>root@working ~ # sensors<br>w83627dhg-isa-0a10<br>Adapter: ISA adapter=
<br>Case Fan: 11637 RPM=A0 (min =3D 12053 RPM, div =3D 1) ALARM<br>

CPU Fan:=A0 11739 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 1) ALARM<br>CPU T=
emp:=A0 +38.0 C=A0 (high =3D=A0 +0.0 C, hyst =3D +60.0 C)=A0 [CPU diode ]<b=
r>AUX Temp:=A0 +29.5 C=A0 (high =3D +45.0 C, hyst =3D +60.0 C)=A0 [thermist=
or]<br>vid:=A0=A0=A0=A0=A0 +1.300 V<br><br>

Running &quot;sensors -s&quot; again solves the problem... <br><br>root@wor=
king ~ # sensors -s<br>root@working ~ # sensors<br>w83627dhg-isa-0a10<br>Ad=
apter: ISA adapter<br>Case Fan: 11440 RPM=A0 (min =3D 6026 RPM, div =3D 2)<=
br>

CPU Fan:=A0 11637 RPM=A0 (min =3D 6026 RPM, div =3D 2)<br>CPU Temp:=A0 +38.=
0 C=A0 (high =3D +56.0 C, hyst =3D +60.0 C)=A0 [CPU diode ]<br>AUX Temp:=A0=
 +29.5 C=A0 (high =3D +45.0 C, hyst =3D +60.0 C)=A0 [thermistor]<br>vid:=A0=
=A0=A0=A0=A0 +1.300 V<br><br>but only for ~5-30 hours, until it drops back =
to defaults again.<br>

<br>At the moment we haven&#39;t found any dependencies between the bug=20
itself and os/chassis, it occurs on different machines and OSes (so far=20
we had it on CentOS 5/6 and Debian 5/6).<br>Please investigate. Feel free t=
o request any additional information you might need.<br><br><br>A piece of =
config file related to  w83627dhg-isa-0a10 is below:<br><br>=3D=3D=3D=3D<br=
># Winbond W83627EHF configuration originally contributed by Leon Moonen<br=
>
# This is for an Asus P5P800, voltages for A8V-E SE.<br>chip &quot;w83627eh=
f-*&quot; &quot;w83627dhg-*&quot;<br><br>#=A0=A0=A0 set fan1_min=A0=A0=A0 2=
000<br>#=A0=A0=A0 set fan2_min=A0=A0=A0 2000<br>=A0=A0=A0 ignore in0<br>=A0=
=A0=A0 ignore in1<br>=A0=A0=A0 ignore in2<br>
=A0=A0=A0 ignore in3<br>=A0=A0=A0 ignore in4<br>=A0=A0=A0 ignore in5<br>=A0=
=A0=A0 ignore in6<br>=A0=A0=A0 ignore in7<br>=A0=A0=A0 ignore in8<br>=A0=A0=
=A0 ignore fan5<br>=A0=A0=A0 label in0 &quot;VCore&quot;<br>=A0=A0=A0 label=
 in2 &quot;AVCC&quot;<br>=A0=A0=A0 label in3 &quot;3VCC&quot;<br>
=A0=A0=A0 label in7 &quot;VSB&quot;<br>=A0=A0=A0 label in8 &quot;VBAT&quot;=
<br><br># The W83627DHG has no in9, uncomment the following line<br>#=A0=A0=
=A0 ignore in9<br><br># +12V is in1 and +5V is in6 as recommended by datash=
eet <br>=A0=A0=A0 compute in1 @*(1+(56/10)),=A0 @/(1+(56/10))<br>
=A0=A0=A0 compute in6 @*(1+(22/10)),=A0 @/(1+(22/10))<br>#=A0=A0=A0 set in1=
_min=A0=A0 12.0*0.9<br>#=A0=A0=A0 set in1_max=A0=A0 12.0*1.1<br>#=A0=A0=A0 =
set in6_min=A0=A0 5.0*0.95<br>#=A0=A0=A0 set in6_max=A0=A0 5.0*1.05<br><br>=
# Set the 3.3V<br>#=A0=A0=A0 set in2_min=A0=A0 3.3*0.95<br>
#=A0=A0=A0 set in2_max=A0=A0 3.3*1.05<br>#=A0=A0=A0 set in3_min=A0=A0 3.3*0=
.95<br>#=A0=A0=A0 set in3_max=A0=A0 3.3*1.05<br>#=A0=A0=A0 set in7_min=A0=
=A0 3.3*0.95<br>#=A0=A0=A0 set in7_max=A0=A0 3.3*1.05<br>#=A0=A0=A0 set in8=
_min=A0=A0 3.3*0.95<br>#=A0=A0=A0 set in8_max=A0=A0 3.3*1.05<br><br>
# Fans<br>=A0=A0 label fan1=A0=A0=A0=A0=A0 &quot;Case Fan&quot;<br>=A0=A0 l=
abel fan2=A0=A0=A0=A0=A0 &quot;CPU Fan&quot;<br>=A0=A0 label fan3=A0=A0=A0=
=A0=A0 &quot;Aux Fan&quot;<br>#=A0=A0 ignore fan1<br>#=A0=A0 ignore fan2<br=
>=A0=A0 ignore fan3<br>=A0=A0 ignore fan4<br>#=A0=A0 ignore fan5<br>
#=A0 ignore fan4<br><br>set fan1_min 6000<br>set fan2_min 6000<br>set fan4_=
min 6000<br>set fan5_min 6000<br><br># Temperatures<br>=A0=A0 #set temp2_ma=
x=A0=A0 90<br>=A0=A0 #set temp2_over=A0 95<br>=A0=A0 #set temp2_hyst=A0 110=
<br>=A0=A0 label temp1=A0=A0=A0=A0 &quot;Sys Temp&quot;<br>
=A0=A0 label temp2=A0=A0=A0=A0 &quot;CPU Temp&quot;<br>=A0=A0 label temp3=
=A0=A0=A0=A0 &quot;AUX Temp&quot;<br><br>ignore temp1<br>#=A0=A0 ignore tem=
p2 <br>#=A0=A0 ignore temp3<br>#=A0 ignore temp3<br>=A0 set temp2_over=A0 5=
6<br>=A0 set temp2_hyst=A0 60<br><br>=A0 set temp3_over=A0 45<br>
=A0 set temp3_hyst=A0 60<br>=3D=3D=3D=3D<br><div class=3D"yj6qo ajU"><div i=
d=3D":56" class=3D"ajR" tabindex=3D"0"><img class=3D"ajT" src=3D"https://ma=
il.google.com/mail/images/cleardot.gif"></div></div><div class=3D"adL"><br>=
</div><span class=3D"HOEnZb adL"><font color=3D"#888888">
<br>-- <br>Best regards, Igor Netkachev<br>NK support<br><a href=3D"mailto:=
netkachev@nksupport.com" target=3D"_blank">netkachev@nksupport.com</a><br><=
a href=3D"http://www.nksupport.com" target=3D"_blank">http://www.nksupport.=
com</a></font></span>

--bcaec554de6015a5bd04c26ebd5e--


--===============6301407523041233506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6301407523041233506==--
