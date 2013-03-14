From: dag dg <dagofthedofg@gmail.com>
Date: Thu, 14 Mar 2013 15:26:39 +0000
Subject: [lm-sensors] Getting temps for all CPU cores to show up on an AMD chip
Message-Id: <CAO2Qn5nT3FPbyrzJCF3NfyQ2y4sgR62w5JhMQeVNsHEcWY5HDA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7826921216141587030=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7826921216141587030==
Content-Type: multipart/alternative; boundary=f46d043c7c9059471e04d7e4279a

--f46d043c7c9059471e04d7e4279a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I have an AMD Phenom II x4 that will show the individual core temps in a
few utilities in windows but for the life of me I can't get lm_sensors to
display them. I'm using the k10temp and w83627dhg-isa-0290 modules. This is
for Fedora 17 lm_sensors version 3.3.2 kernel 3.7.9-104.fc17.x86_64. Here's
what I'm seeing at the moment:

# sensors
k10temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:    +0.0=B0C  (high =3D +70.0=B0C)

w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:        +1.35 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:          +0.33 V  (min =3D  +0.58 V, max =3D  +1.10 V)  ALARM
AVCC:         +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:        +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:          +1.84 V  (min =3D  +0.49 V, max =3D  +0.90 V)  ALARM
in5:          +1.68 V  (min =3D  +1.48 V, max =3D  +0.06 V)  ALARM
in6:          +1.66 V  (min =3D  +1.71 V, max =3D  +0.09 V)  ALARM
3VSB:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:         +3.42 V  (min =3D  +2.70 V, max =3D  +3.63 V)
fan1:           0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
fan2:        4440 RPM  (min =3D 12980 RPM, div =3D 8)  ALARM
fan3:           0 RPM  (min =3D    0 RPM, div =3D 128)
fan5:           0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
temp1:        +41.0=B0C  (high =3D -40.0=B0C, hyst =3D +21.0=B0C)  ALARM  s=
ensor =3D
thermistor
temp2:        +49.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
temp3:        +31.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
intrusion0:  ALARM

Any help would be appreciated, thanks.

Sam P

--f46d043c7c9059471e04d7e4279a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have an AMD Phenom II x4 that will show the individual c=
ore temps in a few utilities in windows but for the life of me I can&#39;t =
get lm_sensors to display them. I&#39;m using the k10temp and=A0w83627dhg-i=
sa-0290 modules. This is for Fedora 17 lm_sensors version=A03.3.2 kernel=A0=
3.7.9-104.fc17.x86_64. Here&#39;s what I&#39;m seeing at the moment:<div>

<br></div><div><div><div># sensors</div><div>k10temp-pci-00c3</div><div>Ada=
pter: PCI adapter</div><div>Core0 Temp: =A0 =A0+0.0=B0C =A0(high =3D +70.0=
=B0C)</div><div><br></div><div>w83627dhg-isa-0290</div><div>Adapter: ISA ad=
apter</div>

<div>Vcore: =A0 =A0 =A0 =A0+1.35 V =A0(min =3D =A0+0.00 V, max =3D =A0+1.74=
 V)</div><div>in1: =A0 =A0 =A0 =A0 =A0+0.33 V =A0(min =3D =A0+0.58 V, max =
=3D =A0+1.10 V) =A0ALARM</div><div>AVCC: =A0 =A0 =A0 =A0 +3.33 V =A0(min =
=3D =A0+2.98 V, max =3D =A0+3.63 V)</div><div>+3.3V: =A0 =A0 =A0 =A0+3.33 V=
 =A0(min =3D =A0+2.98 V, max =3D =A0+3.63 V)</div>

<div>in4: =A0 =A0 =A0 =A0 =A0+1.84 V =A0(min =3D =A0+0.49 V, max =3D =A0+0.=
90 V) =A0ALARM</div><div>in5: =A0 =A0 =A0 =A0 =A0+1.68 V =A0(min =3D =A0+1.=
48 V, max =3D =A0+0.06 V) =A0ALARM</div><div>in6: =A0 =A0 =A0 =A0 =A0+1.66 =
V =A0(min =3D =A0+1.71 V, max =3D =A0+0.09 V) =A0ALARM</div><div>

3VSB: =A0 =A0 =A0 =A0 +3.46 V =A0(min =3D =A0+2.98 V, max =3D =A0+3.63 V)</=
div><div>Vbat: =A0 =A0 =A0 =A0 +3.42 V =A0(min =3D =A0+2.70 V, max =3D =A0+=
3.63 V)</div><div>fan1: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D 10546 RPM, di=
v =3D 128) =A0ALARM</div><div>fan2: =A0 =A0 =A0 =A04440 RPM =A0(min =3D 129=
80 RPM, div =3D 8) =A0ALARM</div>

<div>fan3: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D =A0 =A00 RPM, div =3D 128)=
</div><div>fan5: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D 10546 RPM, div =3D 1=
28) =A0ALARM</div><div>temp1: =A0 =A0 =A0 =A0+41.0=B0C =A0(high =3D -40.0=
=B0C, hyst =3D +21.0=B0C) =A0ALARM =A0sensor =3D thermistor</div>

<div>temp2: =A0 =A0 =A0 =A0+49.0=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.0=
=B0C) =A0sensor =3D thermistor</div><div>temp3: =A0 =A0 =A0 =A0+31.5=B0C =
=A0(high =3D +80.0=B0C, hyst =3D +75.0=B0C) =A0sensor =3D thermistor</div><=
div>intrusion0: =A0ALARM</div></div><div><br></div>

<div>Any help would be appreciated, thanks.<br><br>Sam P</div></div></div>

--f46d043c7c9059471e04d7e4279a--


--===============7826921216141587030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7826921216141587030==--
