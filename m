From: "John Smith" <Kidfromaussie@gmx.com>
Date: Thu, 14 Jul 2011 03:55:34 +0000
Subject: [lm-sensors] Config for MSI GF615M-P33 (MS-7597)
Message-Id: <20110714035535.131170@gmx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8987404133228954722=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8987404133228954722==
Content-Type: multipart/alternative;
 boundary="========GMXBoundary131171310615735101165"

--========GMXBoundary131171310615735101165
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello, this is a another configuration file for the MSI GF615M-P33 (MS-7597) motherboard, in case someone finds it usefull. ==========BEGIN sensors3.conf========== # lm_sensors configuration file for the MSI GF615M-P33 rev 1.3 (MS-7597)  # 2011-07-14 ,Kid from Belgrade
 # tweaked from config for MSI P35 Neo / MSI MS-7360 motherboard
 # 2007-09-21, Andre Jagusch
 # Comments welcome!

 chip "f71889ed-*"

 # Temperature
 label temp1 "CPU"
 label temp2 "System"
 ignore temp3

 # Fans
 label fan1 "CPU"
 label fan2 "System"
 label fan3 "Misc"
 # label fan3 "Power"
 # label fan4 "Aux"

 # sensors in2 in3 , in6 , in7 , in8 may be ignored since
 # they are not shown in BIOS for MS-7597
 # in6 is allways 0.00
 # Voltage
 label in0 "3.3V"
 label in1 "Vcore"
 # ignore in2
 # ignore in3
 label in2 "Vdimm"
 label in3 "Vchip"
 label in4 "+5V"
 ignore in6
 label in5 "12V"
 # ignore in7
 # ignore in8
 label in7 "3VSB"
 label in8 "Battery"

 # never change the in0, in7 and in8 compute, these are hardwired in the chip!
 # +5V +12V +3.3V computess looking fine for MS-7597 ,nothing changed
 compute in0 (@ * 2), (@ / 2)
 compute in2 (@ * 2), (@ / 2)
 compute in3 (@ * 2), (@ / 2)
 compute in4 (@ * 5.25), (@ / 5.25)
 compute in5 (@ * 11), (@ / 11)
 compute in6 (@ * 6.585), (@ / 6.585)
 compute in7 (@ * 2), (@ / 2)
 compute in8 (@ * 2), (@ / 2)


 # on fintek , first sensor is below or near the cpu socket (how to determine this?)
 # CPU temperature is also measurable by on-dye sensor on k10 series
 # now i have not find this anywhere and corection is corelated with fintek
 # tweaked for Athlon II x2 250 ,may defere for others
 chip "k10temp-*"

 label temp1 "CPU K10 Temp"

 compute temp1 (@ + 5.5), (@ - 5.5)

 ==========END sensors3.conf==========

--========GMXBoundary131171310615735101165
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<span style=3D'font-family:Verdana'><span style=3D'font-size:12px'><br />=
=20
<pre>=20
Hello,=20

this is a another configuration file for the MSI GF615M-P33 (MS-7597)=20
motherboard, in case someone finds it usefull.=20


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DBEGIN sensors3.conf=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=20
# lm_sensors configuration file for the MSI GF615M-P33 rev 1.3 (MS-7597)=20
</pre>=20
# 2011-07-14 ,Kid from Belgrade<br />=20
# tweaked from config for MSI P35 Neo / MSI MS-7360 motherboard<br />=20
# 2007-09-21, Andre Jagusch<br />=20
# Comments welcome!<br />=20
<br />=20
chip "f71889ed-*"<br />=20
<br />=20
# Temperature<br />=20
&nbsp;&nbsp;&nbsp; label temp1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "CPU"<br=
 />=20
&nbsp;&nbsp;&nbsp; label temp2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "System"=
<br />=20
&nbsp;&nbsp;&nbsp; ignore temp3<br />=20
<br />=20
# Fans<br />=20
&nbsp;&nbsp;&nbsp; label fan1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "CP=
U"<br />=20
&nbsp;&nbsp;&nbsp; label fan2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "Sy=
stem"<br />=20
&nbsp;&nbsp;&nbsp; label fan3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "Mi=
sc"<br />=20
#&nbsp;&nbsp;&nbsp; label fan3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "P=
ower"<br />=20
#&nbsp;&nbsp;&nbsp; label fan4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "A=
ux"<br />=20
<br />=20
# sensors in2 in3&nbsp;&nbsp;&nbsp; , in6&nbsp;&nbsp;&nbsp; , in7 , in8&nbs=
p; may be ignored since<br />=20
# they are not shown in BIOS for MS-7597<br />=20
# in6 is allways 0.00<br />=20
# Voltage<br />=20
&nbsp;&nbsp;&nbsp; label in0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; "3.3V"<br />=20
&nbsp;&nbsp;&nbsp; label in1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; "Vcore"<br />=20
#&nbsp;&nbsp;&nbsp; ignore in2<br />=20
#&nbsp;&nbsp;&nbsp; ignore in3<br />=20
&nbsp;&nbsp;&nbsp; label in2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; "Vdimm"<br />=20
&nbsp;&nbsp;&nbsp; label in3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; "Vchip"<br />=20
&nbsp;&nbsp;&nbsp; label in4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; "+5V"<br />=20
&nbsp;&nbsp;&nbsp; ignore in6<br />=20
&nbsp;&nbsp;&nbsp; label in5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; "12V"<br />=20
#&nbsp;&nbsp;&nbsp; ignore in7<br />=20
#&nbsp;&nbsp;&nbsp; ignore in8<br />=20
&nbsp;&nbsp;&nbsp; label in7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; "3VSB"<br />=20
&nbsp;&nbsp;&nbsp; label in8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; "Battery"<br />=20
<br />=20
# never change the in0, in7 and in8 compute, these are hardwired in the chi=
p!<br />=20
# +5V +12V +3.3V computess looking fine for&nbsp; MS-7597 ,nothing changed<=
br />=20
&nbsp;&nbsp;&nbsp; compute in0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (@ * 2),=
 (@ / 2)<br />=20
&nbsp;&nbsp;&nbsp; compute in2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (@ * 2),=
 (@ / 2)<br />=20
&nbsp;&nbsp;&nbsp; compute in3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (@ * 2),=
 (@ / 2)<br />=20
&nbsp;&nbsp;&nbsp; compute in4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (@ * 5.2=
5), (@ / 5.25)<br />=20
&nbsp;&nbsp;&nbsp; compute in5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (@ * 11)=
, (@ / 11)<br />=20
&nbsp;&nbsp;&nbsp; compute in6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (@ * 6.5=
85), (@ / 6.585)<br />=20
&nbsp;&nbsp;&nbsp; compute in7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (@ * 2),=
 (@ / 2)<br />=20
&nbsp;&nbsp;&nbsp; compute in8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (@ * 2),=
 (@ / 2)<br />=20
<br />=20
<br />=20
# on fintek , first sensor is below or near the cpu socket (how to determin=
e this?)<br />=20
# CPU temperature is also measurable by on-dye sensor on k10 series<br />=
=20
# now i have not find this anywhere and corection is corelated with fintek<=
br />=20
# tweaked for Athlon II x2 250 ,may defere for others<br />=20
chip "k10temp-*"<br />=20
<br />=20
&nbsp;&nbsp; label temp1 "CPU K10 Temp"<br />=20
<br />=20
&nbsp;&nbsp; compute temp1 (@ + 5.5), (@ - 5.5)<br />=20
<br />=20
<pre>=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DEND   sensors3.conf=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=20
</pre>=20
</span></span>

--========GMXBoundary131171310615735101165--


--===============8987404133228954722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8987404133228954722==--
