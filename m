From: "Dev, Kapil" <kapil_dev@brown.edu>
Date: Tue, 13 Aug 2013 19:05:58 +0000
Subject: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3392335049458243915=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3392335049458243915==
Content-Type: multipart/alternative; boundary=089e0160cf925e220704e3d8eee6

--089e0160cf925e220704e3d8eee6
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I just changed the motherboard and the processor while the hard-disk is the
same. I am trying to read the on-die temperature of the AMD A10 5700
processor. Based on the output of "sensors-detect" command, I
installed f71882fg
driver, but the "sensors" command doesn't seem to give me the value of
core-temperature. IN particular, I am getting following output from sensors
command:

----------------------------------------------------------------------------------------------------
f71869-isa-0e80
Adapter: ISA adapter
in0:         +1.68 V
in1:         +1.05 V
in2:         +1.21 V
in3:         +1.22 V
in4:         +1.54 V
in5:         +1.19 V
in6:         +1.19 V
in7:         +1.73 V
in8:         +1.65 V
fan1:          0 RPM  ALARM
fan2:          0 RPM  ALARM
fan3:          0 RPM  ALARM
temp1:       +31.0 C  (high = +85.0 C, hyst = +81.0 C)
                      (crit = +100.0 C, hyst = +96.0 C)  sensor = thermistor
temp2:       +30.0 C  (high = +85.0 C, hyst = +81.0 C)
                      (crit = +100.0 C, hyst = +96.0 C)  sensor = thermistor
temp3:       +48.0 C  (high = +70.0 C, hyst = +68.0 C)
                      (crit = +85.0 C, hyst = +83.0 C)  sensor = thermistor
----------------------------------------------------------------------------------------------------

I am wondering if I have to install lm_sensors package all over again.
Also, I am wondering if "sensors-detect" is up-to-date to detect all
devices/drivers. I guess the fans' rpm readings are 0 because I am using a
custom liquid-based cooling system  instead of regular fan.

Thanks,
Kapil

--089e0160cf925e220704e3d8eee6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I just changed the motherboard and the processor whi=
le the hard-disk is the same. I am trying to read the on-die temperature of=
 the AMD A10 5700 processor. Based on the output of &quot;sensors-detect&qu=
ot; command, I installed=A0<span style=3D"background-color:rgb(255,255,255)=
;color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.727272033691=
406px">f71882fg driver, but the &quot;sensors&quot; command doesn&#39;t see=
m to give me the value of core-temperature. IN particular, I am getting fol=
lowing output from sensors command:</span></div>
<div><span style=3D"background-color:rgb(255,255,255);color:rgb(34,34,34);f=
ont-family:arial,sans-serif;font-size:12.727272033691406px"><br></span></di=
v><div><span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:12.727272033691406px;background-color:rgb(255,255,255)">-------------=
---------------------------------------------------------------------------=
------------</span></div>
<div><div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-si=
ze:12.727272033691406px;background-color:rgb(255,255,255)">f71869-isa-0e80<=
/div><div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-si=
ze:12.727272033691406px;background-color:rgb(255,255,255)">
Adapter: ISA adapter</div><div style=3D"color:rgb(34,34,34);font-family:ari=
al,sans-serif;font-size:12.727272033691406px;background-color:rgb(255,255,2=
55)">in0: =A0 =A0 =A0 =A0 +1.68 V</div><div style=3D"color:rgb(34,34,34);fo=
nt-family:arial,sans-serif;font-size:12.727272033691406px;background-color:=
rgb(255,255,255)">
in1: =A0 =A0 =A0 =A0 +1.05 V</div><div style=3D"color:rgb(34,34,34);font-fa=
mily:arial,sans-serif;font-size:12.727272033691406px;background-color:rgb(2=
55,255,255)">in2: =A0 =A0 =A0 =A0 +1.21 V</div><div style=3D"color:rgb(34,3=
4,34);font-family:arial,sans-serif;font-size:12.727272033691406px;backgroun=
d-color:rgb(255,255,255)">
in3: =A0 =A0 =A0 =A0 +1.22 V</div><div style=3D"color:rgb(34,34,34);font-fa=
mily:arial,sans-serif;font-size:12.727272033691406px;background-color:rgb(2=
55,255,255)">in4: =A0 =A0 =A0 =A0 +1.54 V</div><div style=3D"color:rgb(34,3=
4,34);font-family:arial,sans-serif;font-size:12.727272033691406px;backgroun=
d-color:rgb(255,255,255)">
in5: =A0 =A0 =A0 =A0 +1.19 V</div><div style=3D"color:rgb(34,34,34);font-fa=
mily:arial,sans-serif;font-size:12.727272033691406px;background-color:rgb(2=
55,255,255)">in6: =A0 =A0 =A0 =A0 +1.19 V</div><div style=3D"color:rgb(34,3=
4,34);font-family:arial,sans-serif;font-size:12.727272033691406px;backgroun=
d-color:rgb(255,255,255)">
in7: =A0 =A0 =A0 =A0 +1.73 V</div><div style=3D"color:rgb(34,34,34);font-fa=
mily:arial,sans-serif;font-size:12.727272033691406px;background-color:rgb(2=
55,255,255)">in8: =A0 =A0 =A0 =A0 +1.65 V</div><div style=3D"color:rgb(34,3=
4,34);font-family:arial,sans-serif;font-size:12.727272033691406px;backgroun=
d-color:rgb(255,255,255)">
fan1: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM</div><div style=3D"color:rgb(34,34,=
34);font-family:arial,sans-serif;font-size:12.727272033691406px;background-=
color:rgb(255,255,255)">fan2: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM</div><div s=
tyle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.72727=
2033691406px;background-color:rgb(255,255,255)">
fan3: =A0 =A0 =A0 =A0 =A00 RPM =A0ALARM</div><div style=3D"color:rgb(34,34,=
34);font-family:arial,sans-serif;font-size:12.727272033691406px;background-=
color:rgb(255,255,255)">temp1: =A0 =A0 =A0 +31.0 C =A0(high =3D +85.0 C, hy=
st =3D +81.0 C) =A0</div>
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12=
.727272033691406px;background-color:rgb(255,255,255)">=A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +100.0 C, hyst =3D +96.0 C) =A0sensor =3D=
 thermistor</div><div style=3D"color:rgb(34,34,34);font-family:arial,sans-s=
erif;font-size:12.727272033691406px;background-color:rgb(255,255,255)">
temp2: =A0 =A0 =A0 +30.0 C =A0(high =3D +85.0 C, hyst =3D +81.0 C) =A0</div=
><div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:1=
2.727272033691406px;background-color:rgb(255,255,255)">=A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +100.0 C, hyst =3D +96.0 C) =A0sensor =3D=
 thermistor</div>
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12=
.727272033691406px;background-color:rgb(255,255,255)">temp3: =A0 =A0 =A0 +4=
8.0 C =A0(high =3D +70.0 C, hyst =3D +68.0 C) =A0</div><div style=3D"color:=
rgb(34,34,34);font-family:arial,sans-serif;font-size:12.727272033691406px;b=
ackground-color:rgb(255,255,255)">
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (crit =3D +85.0 C, hyst =3D +83=
.0 C) =A0sensor =3D thermistor</div></div><div style=3D"color:rgb(34,34,34)=
;font-family:arial,sans-serif;font-size:12.727272033691406px;background-col=
or:rgb(255,255,255)">------------------------------------------------------=
----------------------------------------------</div>
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12=
.727272033691406px;background-color:rgb(255,255,255)"><br></div><div style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.727272033=
691406px;background-color:rgb(255,255,255)">
I am wondering if I have to install lm_sensors package all over again. Also=
, I am wondering if &quot;sensors-detect&quot; is up-to-date to detect all =
devices/drivers. I guess the fans&#39; rpm readings are 0 because I am usin=
g a custom liquid-based cooling system =A0instead of regular fan.</div>
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12=
.727272033691406px;background-color:rgb(255,255,255)"><br></div><div style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.727272033=
691406px;background-color:rgb(255,255,255)">
Thanks,</div><div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif=
;font-size:12.727272033691406px;background-color:rgb(255,255,255)">Kapil</d=
iv><div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size=
:12.727272033691406px;background-color:rgb(255,255,255)">
<br></div>

--089e0160cf925e220704e3d8eee6--


--===============3392335049458243915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3392335049458243915==--
