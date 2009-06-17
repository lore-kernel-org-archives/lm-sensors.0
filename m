From: sbalfour@att.net
Date: Wed, 17 Jun 2009 22:23:15 +0000
Subject: [lm-sensors] sensors command output all wrong
Message-Id: <061720092223.13248.4A396CD3000447E2000033C022230647629B0A02D29B9B0EBF9D9A0100040E0D9C@att.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7480763379881173149=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============7480763379881173149==
Content-Type: multipart/alternative;
	boundary="NextPart_Webmail_9m3u9jl4l_13248_1245277395_0"


--NextPart_Webmail_9m3u9jl4l_13248_1245277395_0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Here's my sensors command output:

root@Belladonna:/etc# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +21.8=C2=B0C  (crit =3D +96.8=C2=B0C)

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +64.0=C2=B0C
Core1 Temp:  +63.0=C2=B0C

k8temp-pci-00cb
Adapter: PCI adapter
Core0 Temp:  +52.0=C2=B0C
Core1 Temp:  +49.0=C2=B0C

w83627thf-isa-0290
Adapter: ISA adapter
VCore:       +0.98 V  (min =3D  +0.70 V, max =3D  +1.87 V)
+12V:        +4.13 V  (min =3D  +3.10 V, max =3D  +0.97 V)   ALARM
+3.3V:       +1.89 V  (min =3D  +1.54 V, max =3D  +2.30 V)
+5V:         +4.83 V  (min =3D  +0.96 V, max =3D  +6.51 V)
-12V:       -10.30 V  (min =3D -13.43 V, max =3D  -8.33 V)
V5SB:        +4.97 V  (min =3D  +3.92 V, max =3D  +1.80 V)   ALARM
VBat:        +2.82 V  (min =3D  +0.00 V, max =3D  +0.13 V)   ALARM
fan1:          0 RPM  (min =3D 168750 RPM, div =3D 2)  ALARM
CPU Fan:       0 RPM  (min =3D   -1 RPM, div =3D 2)  ALARM
fan3:          0 RPM  (min =3D 10384 RPM, div =3D 2)  ALARM
M/B Temp:    +61.0=C2=B0C  (high =3D  +4.0=C2=B0C, hyst =3D  +2.0=C2=B0C)  =
ALARM  sensor =3D thermistor
CPU Temp:    +57.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)  =
sensor =3D thermistor
temp3:       +43.5=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)  =
sensor =3D thermistor
beep_enable:enabled

The only information there that's nearly correct is the values for +5V and=
=20
V5SB.  Maybe the Vbat is ok.  My CPU's are both running 100% usage, and=20
temps are more like 50C at idle, 70C at full usage (measured in Windows).
AMD spec for Vcore for Opteron 285 is 1.30-1.35V.  Bios says 1.29/1.34V.
CPU frequency scaling is @2.6GHZ.  My system periodically freezes, and
that's believable if Vcore is really 0.98V.  It does however, run fine at
2.2GHZ @Vcore 0.94V.
My MOBO is MSI K8N Master2-far; dual CPUs are Opteron 285 @2.6Mhz.
My sensor chip is reported as w83627thf, but I'm doubtful.  My PSU is
PC Power & Cooling Silencer 750, rated 750W,  peak 825W, single rail
+12V @60A.  It can deliver the juice.  My watt meter says the system is=20
consuming ~300W, so I'm not even close to drawing down the PSU.=20=20
I'm on Kubuntu 8.10.  Any help?

                                       Stuart
--NextPart_Webmail_9m3u9jl4l_13248_1245277395_0
Content-Type: multipart/related;
	boundary="NextPart_Webmail_9m3u9jl4l_13248_1245277395_1"


--NextPart_Webmail_9m3u9jl4l_13248_1245277395_1
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
<!-- BEGIN WEBMAIL STATIONERY -->
<head></head>
<body>
<!-- WEBMAIL STATIONERY notheme -->
Here's my sensors command output:<br><br>root@Belladonna:/etc# sensors<br>a=
cpitz-virtual-0<br>Adapter: Virtual device<br>temp1:&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; +21.8=C2=B0C&nbsp; (crit =3D +96.8=C2=B0C)<br><br>k8temp-pci-=
00c3<br>Adapter: PCI adapter<br>Core0 Temp:&nbsp; +64.0=C2=B0C<br>Core1 Tem=
p:&nbsp; +63.0=C2=B0C<br><br>k8temp-pci-00cb<br>Adapter: PCI adapter<br>Cor=
e0 Temp:&nbsp; +52.0=C2=B0C<br>Core1 Temp:&nbsp; +49.0=C2=B0C<br><br>w83627=
thf-isa-0290<br>Adapter: ISA adapter<br>VCore:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; +0.98 V&nbsp; (min =3D&nbsp; +0.70 V, max =3D&nbsp; +1.87 V)<br>+12=
V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.13 V&nbsp; (min =3D&nbsp; +=
3.10 V, max =3D&nbsp; +0.97 V)&nbsp;&nbsp; ALARM<br>+3.3V:&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; +1.89 V&nbsp; (min =3D&nbsp; +1.54 V, max =3D&nbsp; +2.=
30 V)<br>+5V:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.83 V&nbsp;=
 (min =3D&nbsp; +0.96 V, max =3D&nbsp; +6.51 V)<br>-12V:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; -10.30 V&nbsp; (min =3D -13.43 V, max =3D&nbsp; -8.33 V)<=
br>V5SB:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +4.97 V&nbsp; (min =3D&n=
bsp; +3.92 V, max =3D&nbsp; +1.80 V)&nbsp;&nbsp; ALARM<br>VBat:&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.82 V&nbsp; (min =3D&nbsp; +0.00 V, max =
=3D&nbsp; +0.13 V)&nbsp;&nbsp; ALARM<br>fan1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D 168750 RPM, div =3D 2)&nbsp; =
ALARM<br>CPU Fan:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D&=
nbsp;&nbsp; -1 RPM, div =3D 2)&nbsp; ALARM<br>fan3:&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D 10384 RPM, div =3D 2)&n=
bsp; ALARM<br>M/B Temp:&nbsp;&nbsp;&nbsp; +61.0=C2=B0C&nbsp; (high =3D&nbsp=
; +4.0=C2=B0C, hyst =3D&nbsp; +2.0=C2=B0C)&nbsp; ALARM&nbsp; sensor =3D the=
rmistor<br>CPU Temp:&nbsp;&nbsp;&nbsp; +57.0=C2=B0C&nbsp; (high =3D +80.0=
=C2=B0C, hyst =3D +75.0=C2=B0C)&nbsp; sensor =3D thermistor<br>temp3:&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +43.5=C2=B0C&nbsp; (high =3D +80.0=C2=B0C, h=
yst =3D +75.0=C2=B0C)&nbsp; sensor =3D thermistor<br>beep_enable:enabled<br=
><br>The only information there that's nearly correct is the values for +5V=
 and <br>V5SB.&nbsp; Maybe the Vbat is ok.&nbsp; My CPU's are both running =
100% usage, and <br>temps are more like 50C at idle, 70C at full usage (mea=
sured in Windows).<br>AMD spec for Vcore for Opteron 285 is 1.30-1.35V.&nbs=
p; Bios says 1.29/1.34V.<br>CPU frequency scaling is @2.6GHZ.&nbsp; My syst=
em periodically freezes, and<br>that's believable if Vcore is really 0.98V.=
&nbsp; It does however, run fine at<br>2.2GHZ @Vcore 0.94V.<br>My MOBO is M=
SI K8N Master2-far; dual CPUs are Opteron 285 @2.6Mhz.<br>My sensor chip is=
 reported as w83627thf, but I'm doubtful.&nbsp; My PSU is<br>PC Power &amp;=
 Cooling Silencer 750, rated 750W,&nbsp; peak 825W, single rail<br>+12V @60=
A.&nbsp; It can deliver the juice.&nbsp; My watt meter says the system is <=
br>consuming ~300W, so I'm not even close to drawing down the PSU.&nbsp; <b=
r>I'm on Kubuntu 8.10.&nbsp; Any help?<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Stuart<br>
<!-- END WEBMAIL STATIONERY -->

</body>
</html>

--NextPart_Webmail_9m3u9jl4l_13248_1245277395_1--

--NextPart_Webmail_9m3u9jl4l_13248_1245277395_0--


--===============7480763379881173149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7480763379881173149==--
