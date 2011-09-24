From: Audio Phile <da_audiophile@yahoo.com>
Date: Sat, 24 Sep 2011 12:27:30 +0000
Subject: [lm-sensors] adjusting /etc/sensors.conf for a dual processor
Message-Id: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0778045677165442978=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============0778045677165442978==
Content-Type: multipart/alternative; boundary="-2114655128-1055467998-1316867250=:1306"

---2114655128-1055467998-1316867250=:1306
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I'd like to get my cores from the sensors output to be consistently numbere=
d (i.e. core0-core7) for a dual xeon motherboard (HP Z600 workstation). Her=
e is what the output looks like currently. Anyone have experience with this=
?=0A=0A$ sensors=0Acoretemp-isa-0000=0AAdapter: ISA adapter=0ACore 0:=A0=A0=
=A0=A0=A0=A0 +65.0=B0C=A0 (high =3D +85.0=B0C, crit =3D +95.0=B0C)=0ACore 1=
:=A0=A0=A0=A0=A0=A0 +65.0=B0C=A0 (high =3D +85.0=B0C, crit =3D +95.0=B0C)=
=0ACore 9:=A0=A0=A0=A0=A0=A0 +66.0=B0C=A0 (high =3D +85.0=B0C, crit =3D +95=
.0=B0C)=0ACore 10:=A0=A0=A0=A0=A0 +66.0=B0C=A0 (high =3D +85.0=B0C, crit =
=3D +95.0=B0C)=0A=0Acoretemp-isa-0004=0AAdapter: ISA adapter=0ACore 0:=A0=
=A0=A0=A0=A0=A0 +54.0=B0C=A0 (high =3D +85.0=B0C, crit =3D +95.0=B0C)=0ACor=
e 1:=A0=A0=A0=A0=A0=A0 +56.0=B0C=A0 (high =3D +85.0=B0C, crit =3D +95.0=B0C=
)=0ACore 9:=A0=A0=A0=A0=A0=A0 +60.0=B0C=A0 (high =3D +85.0=B0C, crit =3D +9=
5.0=B0C)=0ACore 10:=A0=A0=A0=A0=A0 +61.0=B0C=A0 (high =3D +85.0=B0C, crit =
=3D +95.0=B0C)=0A=0Asmsc47b397-isa-0480=0AAdapter: ISA adapter=0Afan1:=A0=
=A0=A0=A0=A0=A0=A0 1730 RPM=0Afan2:=A0=A0=A0=A0=A0=A0=A0 1746 RPM=0Afan3:=
=A0=A0=A0=A0=A0=A0=A0 1224 RPM=0Afan4:=A0=A0=A0=A0=A0=A0=A0 2825 RPM=0Atemp=
1:=A0=A0=A0=A0=A0=A0=A0 +46.0=B0C=0Atemp2:=A0=A0=A0=A0=A0=A0=A0 +37.0=B0C=
=0Atemp3:=A0=A0=A0=A0=A0=A0=A0 +23.0=B0C=0Atemp4:=A0=A0=A0=A0=A0=A0 -128.0=
=B0C =0A
---2114655128-1055467998-1316867250=:1306
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt">I'd like to get my co=
res from the sensors output to be consistently numbered (i.e. core0-core7) =
for a dual xeon motherboard (HP Z600 workstation). Here is what the output =
looks like currently. Anyone have experience with this?<br><br>$ sensors<br=
>coretemp-isa-0000<br>Adapter: ISA adapter<br>Core 0:&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; +65.0=B0C&nbsp; (high =3D +85.0=B0C, crit =3D +95.0=B0C)<br>=
Core 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +65.0=B0C&nbsp; (high =3D +85.0=
=B0C, crit =3D +95.0=B0C)<br>Core 9:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +6=
6.0=B0C&nbsp; (high =3D +85.0=B0C, crit =3D +95.0=B0C)<br>Core 10:&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; +66.0=B0C&nbsp; (high =3D +85.0=B0C, crit =3D +95.0=
=B0C)<br><br>coretemp-isa-0004<br>Adapter: ISA adapter<br>Core 0:&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; +54.0=B0C&nbsp; (high =3D +85.0=B0C, crit =3D +9=
5.0=B0C)<br>Core
 1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +56.0=B0C&nbsp; (high =3D +85.0=B0C=
, crit =3D +95.0=B0C)<br>Core 9:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +60.0=
=B0C&nbsp; (high =3D +85.0=B0C, crit =3D +95.0=B0C)<br>Core 10:&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; +61.0=B0C&nbsp; (high =3D +85.0=B0C, crit =3D +95.0=B0C)=
<br><br>smsc47b397-isa-0480<br>Adapter: ISA adapter<br>fan1:&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 1730 RPM<br>fan2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 1746 RPM<br>fan3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12=
24 RPM<br>fan4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2825 RPM<br>temp1=
:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +46.0=B0C<br>temp2:&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +37.0=B0C<br>temp3:&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; +23.0=B0C<br>temp4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -=
128.0=B0C <br></div></body></html>
---2114655128-1055467998-1316867250=:1306--


--===============0778045677165442978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0778045677165442978==--
