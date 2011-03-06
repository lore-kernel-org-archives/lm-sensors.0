From: Lunar Cab <lunarcab@yahoo.com>
Date: Sun, 06 Mar 2011 14:46:55 +0000
Subject: [lm-sensors] GPU temp for Asus agp-v8200 deluxe graphics card
Message-Id: <62498.99181.qm@web55602.mail.re4.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2133685221338867471=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2133685221338867471==
Content-Type: multipart/alternative; boundary="0-1620049993-1299422815=:99181"

--0-1620049993-1299422815=:99181
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Dear friends,

I'd like to have your advice on how to get the GPU temperature for my graph=
ics card.

My system:
motherboard: Asus CUSL2
graphics card: Asus agp-v8200 deluxe
OS: Ubuntu 9.10 (Karmic) kernel 2.6.31-14
acpi_enforce_resources=3Dlax option activated in grub

The final output of sensors-detect is:

Driver `w83781d':
=A0 * Bus `NVIDIA i2c adapter '
=A0=A0=A0 Busdriver `nvidia', I2C address 0x2d (and 0x48 0x49)
=A0=A0=A0 Chip `Winbond W83781D' (confidence: 8)
=A0 * Bus `SMBus I801 adapter at e800'
=A0=A0=A0 Busdriver `i2c_i801', I2C address 0x2d (and 0x48 0x49)
=A0=A0=A0 Chip `Asus AS99127F (rev.1)' (confidence: 8)

After modprobe for all mentioned drivers "sensors" gives me:

administrator@UBUNTU:~$ sensors
as99127f-i2c-3-2d
Adapter: SMBus I801 adapter at e800
in0:=A0=A0=A0=A0=A0=A0=A0=A0 +1.68 V=A0 (min =3D=A0 +1.46 V, max =3D=A0 +1.=
84 V)=A0=A0=20
in1:=A0=A0=A0=A0=A0=A0=A0=A0 +1.68 V=A0 (min =3D=A0 +2.24 V, max =3D=A0 +2.=
74 V)=A0=A0 ALARM
in2:=A0=A0=A0=A0=A0=A0=A0=A0 +3.44 V=A0 (min =3D=A0 +2.96 V, max =3D=A0 +3.=
62 V)=A0=A0=20
in3:=A0=A0=A0=A0=A0=A0=A0=A0 +2.91 V=A0 (min =3D=A0 +2.67 V, max =3D=A0 +3.=
26 V)=A0=A0=20
in4:=A0=A0=A0=A0=A0=A0=A0=A0 +2.98 V=A0 (min =3D=A0 +2.40 V, max =3D=A0 +3.=
58 V)=A0=A0=20
in5:=A0=A0=A0=A0=A0=A0=A0=A0 +3.01 V=A0 (min =3D=A0 +2.42 V, max =3D=A0 +3.=
62 V)=A0=A0=20
in6:=A0=A0=A0=A0=A0=A0=A0=A0 +4.08 V=A0 (min =3D=A0 +2.66 V, max =3D=A0 +3.=
98 V)=A0=A0 ALARM
fan1:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D =
2)
fan2:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D =
2)
fan3:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D =
2)
temp1:=A0=A0=A0=A0=A0=A0 +34.0=B0C=A0 (high =3D +105.0=B0C, hyst =3D=A0 +0.=
0=B0C)=A0=20
temp2:=A0=A0=A0=A0=A0=A0 +24.0=B0C=A0 (high =3D +100.0=B0C, hyst =3D +92.0=
=B0C)=A0=20
temp3:=A0=A0=A0=A0=A0=A0 -31.5=B0C=A0 (high =3D +122.0=B0C, hyst =3D +121.0=
=B0C)=A0=20
cpu0_vid:=A0=A0 +1.650 V
beep_enable:enabled

So, there is no GPU temperature listing. I have recommended nvidia driver i=
nstalled (nvidia-96-kernel). Playing with nvidia-settings I have:

---------------
administrator@UBUNTU:~$ nvidia-settings -q gpucoretemp -t
administrator@UBUNTU:~$=20
---------------
administrator@UBUNTU:~$ nvidia-settings -q gpucoretemp


administrator@UBUNTU:~$=20
---------------
administrator@UBUNTU:~$ nvidia-settings -e gpucoretemp

Attribute 'GPUCoreTemp':
=A0 - Attribute is not written to the rc file.
=A0 Reports the current core temperature in Celsius of the GPU driving the =
X
=A0 screen.

administrator@UBUNTU:~$=20
---------------

Nothing. nvclock -T outputs:

administrator@UBUNTU:~$ sudo nvclock -T
[sudo] password for administrator:=20
Error: temperature monitoring isn't supported on your videocard.
administrator@UBUNTU:~$=20

I know for sure that my graphics card does have a thermal control chip; in =
Windows using Asus SmartDoctor software I can get temperature not only for =
GPU, but also for GRAM.

So, is there any way to enable temperature monitoring for agp-v8200 in ubun=
tu?




=0A=0A=0A      
--0-1620049993-1299422815=:99181
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Dear friends,<br><br>I'd like to have your ad=
vice on how to get the GPU temperature for my graphics card.<br><br>My syst=
em:<br>motherboard: Asus CUSL2<br>graphics card: Asus agp-v8200 deluxe<br>O=
S: Ubuntu 9.10 (Karmic) kernel 2.6.31-14<br>acpi_enforce_resources=3Dlax op=
tion activated in grub<br><br>The final output of sensors-detect is:<br><br=
>Driver `w83781d':<br>&nbsp; * Bus `NVIDIA i2c adapter '<br>&nbsp;&nbsp;&nb=
sp; Busdriver `nvidia', I2C address 0x2d (and 0x48 0x49)<br>&nbsp;&nbsp;&nb=
sp; Chip `Winbond W83781D' (confidence: 8)<br>&nbsp; * Bus `SMBus I801 adap=
ter at e800'<br>&nbsp;&nbsp;&nbsp; Busdriver `i2c_i801', I2C address 0x2d (=
and 0x48 0x49)<br>&nbsp;&nbsp;&nbsp; Chip `Asus AS99127F (rev.1)' (confiden=
ce: 8)<br><br>After modprobe for all mentioned drivers "sensors" gives me:<=
br><br>administrator@UBUNTU:~$ sensors<br>as99127f-i2c-3-2d<br>Adapter: SMB=
us
 I801 adapter at e800<br>in0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; +1.68 V&nbsp; (min =3D&nbsp; +1.46 V, max =3D&nbsp; +1.84 V)&nbsp;&nbsp;=
 <br>in1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.68 V&nbsp; (mi=
n =3D&nbsp; +2.24 V, max =3D&nbsp; +2.74 V)&nbsp;&nbsp; ALARM<br>in2:&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.44 V&nbsp; (min =3D&nbsp; +2.=
96 V, max =3D&nbsp; +3.62 V)&nbsp;&nbsp; <br>in3:&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; +2.91 V&nbsp; (min =3D&nbsp; +2.67 V, max =3D&nbsp; =
+3.26 V)&nbsp;&nbsp; <br>in4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; +2.98 V&nbsp; (min =3D&nbsp; +2.40 V, max =3D&nbsp; +3.58 V)&nbsp;&nbsp;=
 <br>in5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.01 V&nbsp; (mi=
n =3D&nbsp; +2.42 V, max =3D&nbsp; +3.62 V)&nbsp;&nbsp; <br>in6:&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.08 V&nbsp; (min =3D&nbsp; +2.66 V,=
 max =3D&nbsp; +3.98 V)&nbsp;&nbsp;
 ALARM<br>fan1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM=
&nbsp; (min =3D&nbsp;&nbsp;&nbsp; 0 RPM, div =3D 2)<br>fan2:&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D&nbsp;&nbsp;&nb=
sp; 0 RPM, div =3D 2)<br>fan3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0 RPM&nbsp; (min =3D&nbsp;&nbsp;&nbsp; 0 RPM, div =3D 2)<br>temp1=
:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +34.0=B0C&nbsp; (high =3D +105.0=B0C,=
 hyst =3D&nbsp; +0.0=B0C)&nbsp; <br>temp2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; +24.0=B0C&nbsp; (high =3D +100.0=B0C, hyst =3D +92.0=B0C)&nbsp; <br>tem=
p3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -31.5=B0C&nbsp; (high =3D +122.0=B0=
C, hyst =3D +121.0=B0C)&nbsp; <br>cpu0_vid:&nbsp;&nbsp; +1.650 V<br>beep_en=
able:enabled<br><br>So, there is no GPU temperature listing. I have recomme=
nded nvidia driver installed (nvidia-96-kernel). Playing with nvidia-settin=
gs I have:<br><br>---------------<br>administrator@UBUNTU:~$ nvidia-setting=
s -q gpucoretemp
 -t<br>administrator@UBUNTU:~$ <br>---------------<br>administrator@UBUNTU:=
~$ nvidia-settings -q gpucoretemp<br><br><br>administrator@UBUNTU:~$ <br>--=
-------------<br>administrator@UBUNTU:~$ nvidia-settings -e gpucoretemp<br>=
<br>Attribute 'GPUCoreTemp':<br>&nbsp; - Attribute is not written to the rc=
 file.<br>&nbsp; Reports the current core temperature in Celsius of the GPU=
 driving the X<br>&nbsp; screen.<br><br>administrator@UBUNTU:~$ <br>-------=
--------<br><br>Nothing. nvclock -T outputs:<br><br>administrator@UBUNTU:~$=
 sudo nvclock -T<br>[sudo] password for administrator: <br>Error: temperatu=
re monitoring isn't supported on your videocard.<br>administrator@UBUNTU:~$=
 <br><br>I know for sure that my graphics card does have a thermal control =
chip; in Windows using Asus SmartDoctor software I can get temperature not =
only for GPU, but also for GRAM.<br><br>So, is there any way to enable temp=
erature monitoring for agp-v8200 in
 ubuntu?<br><br><br><br><br></td></tr></table><br>=0A=0A      
--0-1620049993-1299422815=:99181--


--===============2133685221338867471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2133685221338867471==--
