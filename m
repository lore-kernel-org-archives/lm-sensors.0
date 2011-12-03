From: Reartes Guillermo <rtguille@gmail.com>
Date: Sat, 03 Dec 2011 12:02:21 +0000
Subject: [lm-sensors] Sabertooth 990FX strange sensors reading in
Message-Id: <CAPVzhpzUgRXPcPi7JHOoppC86UgoesJv18t+Mjd+41FXrfnWdQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2876630335179123463=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2876630335179123463==
Content-Type: multipart/alternative; boundary=20cf307f35ea9ad3c504b32edbc6

--20cf307f35ea9ad3c504b32edbc6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello:

I am having problems with the sensors command on Fedora 16 X86_64. There
are to many 'alarmed' sensors. Also there are problems with the temperature
ranges, or at least this mobo is really weird.

The mobo is an Asus Sabertooth 990FX (BIOS 0813), I boot in non-efi mode fo=
r
now (since i upgraded the mobo and the cpu some), will try uefi with f16 in
the
future. I run sensor-detect when i first replaced the mobo and then when i
replaced the cpu.

it8721-isa-0290
Adapter: ISA adapter
in0:          +2.81 V  (min =3D  +1.84 V, max =3D  +2.29 V)  ALARM
in1:          +2.74 V  (min =3D  +2.58 V, max =3D  +2.41 V)  ALARM
in2:          +0.90 V  (min =3D  +2.65 V, max =3D  +1.04 V)  ALARM
+3.3V:        +3.26 V  (min =3D  +0.00 V, max =3D  +2.28 V)  ALARM
in4:          +2.66 V  (min =3D  +2.87 V, max =3D  +1.91 V)  ALARM
in5:          +2.52 V  (min =3D  +1.12 V, max =3D  +3.05 V)
in6:          +1.54 V  (min =3D  +3.05 V, max =3D  +3.01 V)  ALARM
3VSB:         +2.28 V  (min =3D  +0.00 V, max =3D  +3.74 V)
Vbat:         +3.34 V
fan1:        1534 RPM  (min =3D   15 RPM)
fan2:           0 RPM  (min =3D   10 RPM)  ALARM
fan3:         832 RPM  (min =3D   10 RPM)
temp1:        +46.0=B0C  (low  =3D +94.0=B0C, high =3D  -5.0=B0C)  ALARM  s=
ensor =3D
thermistor
temp2:        +38.0=B0C  (low  =3D +121.0=B0C, high =3D -41.0=B0C)  ALARM  =
sensor =3D
thermistor
temp3:       -128.0=B0C  (low  =3D  -1.0=B0C, high =3D  -7.0=B0C)  sensor =
=3D disabled
intrusion0:  OK

The sensors config file and other info was uploaded to:
https://bugzilla.redhat.com/show_bug.cgi?id=3D759667

About the fans, there 2 chassis TT ISCG200, with rpm set to
minimum manually. The cpu fan is the stock FX6100.

kernel             2.6.41.1-1.fc15.x86_64
lm_sensors.x86_64  3.3.1-1.fc15

--20cf307f35ea9ad3c504b32edbc6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello:<br><br>I am having problems with the sensors command on Fedora 16 X8=
6_64. There<br>are to many &#39;alarmed&#39; sensors. Also there are proble=
ms with the temperature<br>ranges, or at least this mobo is really weird.<b=
r>
<br>The mobo is an Asus Sabertooth 990FX (BIOS 0813), I boot in non-efi mod=
e for<br>now (since i upgraded the mobo and the cpu some), will try uefi wi=
th f16 in the<br>future. I run sensor-detect when i first replaced the mobo=
 and then when i <br>
replaced the cpu.<br><br>it8721-isa-0290<br>Adapter: ISA adapter<br>in0:=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 +2.81 V=A0 (min =3D=A0 +1.84 V, max =3D=A0 +2.29 V=
)=A0 ALARM<br>in1:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.74 V=A0 (min =3D=A0 +2.58 =
V, max =3D=A0 +2.41 V)=A0 ALARM<br>in2:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.90 V=
=A0 (min =3D=A0 +2.65 V, max =3D=A0 +1.04 V)=A0 ALARM<br>
+3.3V:=A0=A0=A0=A0=A0=A0=A0 +3.26 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +2.2=
8 V)=A0 ALARM<br>in4:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.66 V=A0 (min =3D=A0 +2.=
87 V, max =3D=A0 +1.91 V)=A0 ALARM<br>in5:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.52=
 V=A0 (min =3D=A0 +1.12 V, max =3D=A0 +3.05 V)<br>in6:=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 +1.54 V=A0 (min =3D=A0 +3.05 V, max =3D=A0 +3.01 V)=A0 ALARM<br>
3VSB:=A0=A0=A0=A0=A0=A0=A0=A0 +2.28 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +3=
.74 V)<br>Vbat:=A0=A0=A0=A0=A0=A0=A0=A0 +3.34 V=A0 <br>fan1:=A0=A0=A0=A0=A0=
=A0=A0 1534 RPM=A0 (min =3D=A0=A0 15 RPM)<br>fan2:=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0 RPM=A0 (min =3D=A0=A0 10 RPM)=A0 ALARM<br>fan3:=A0=A0=A0=A0=A0=A0=
=A0=A0 832 RPM=A0 (min =3D=A0=A0 10 RPM)<br>
temp1:=A0=A0=A0=A0=A0=A0=A0 +46.0=B0C=A0 (low=A0 =3D +94.0=B0C, high =3D=A0=
 -5.0=B0C)=A0 ALARM=A0 sensor =3D<br>thermistor<br>temp2:=A0=A0=A0=A0=A0=A0=
=A0 +38.0=B0C=A0 (low=A0 =3D +121.0=B0C, high =3D -41.0=B0C)=A0 ALARM=A0 se=
nsor =3D<br>thermistor<br>temp3:=A0=A0=A0=A0=A0=A0 -128.0=B0C=A0 (low=A0 =
=3D=A0 -1.0=B0C, high =3D=A0 -7.0=B0C)=A0 sensor =3D disabled<br>
intrusion0:=A0 OK <br><br>The sensors config file and other info was upload=
ed to:<br><a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D759667">=
https://bugzilla.redhat.com/show_bug.cgi?id=3D759667</a><br><br>About the f=
ans, there 2 chassis TT ISCG200, with rpm set to <br>
minimum manually. The cpu fan is the stock FX6100.<br><br>kernel=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 2.6.41.1-1.fc15.x86_64<br>lm_sensors.x86_64=A0 =
3.3.1-1.fc15<br>

--20cf307f35ea9ad3c504b32edbc6--


--===============2876630335179123463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2876630335179123463==--
