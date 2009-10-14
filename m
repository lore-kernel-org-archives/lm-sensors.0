From: Sean Covel <sean.covel@gmail.com>
Date: Wed, 14 Oct 2009 14:06:20 +0000
Subject: [lm-sensors] Via Epia SP13000 Mobo, virtual device?
Message-Id: <1097a6730910140706q7dcba2a6j73cdbb0784b99c08@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2712236300098113637=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2712236300098113637==
Content-Type: multipart/alternative; boundary=00c09ffb5a67d6a3ee0475e5aa86

--00c09ffb5a67d6a3ee0475e5aa86
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Running Ubuntu 9.10 Beta.
Linux mythbuntu 2.6.31-13-generic #44-Ubuntu SMP Sat Oct 10 15:27:55 UTC
2009 i686 GNU/Linux
sensors version 3.0.2 with libsensors version 3.0.2

~$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:      -273.2=C2=B0C  (crit =3D +60.0=C2=B0C)

vt1211-isa-6000
Adapter: ISA adapter
+3.3V:       +3.31 V  (min =3D  +0.00 V, max =3D  +4.42 V)
+2.5V:       +2.42 V  (min =3D  +0.00 V, max =3D  +3.16 V)
VCore:       +1.38 V  (min =3D  +0.00 V, max =3D  +2.63 V)
+5V:         +4.46 V  (min =3D  +0.00 V, max =3D  +6.31 V)
+12V:       +11.90 V  (min =3D  +0.00 V, max =3D +14.99 V)
+3.3V:       +3.12 V  (min =3D  +3.13 V, max =3D  +3.46 V)   ALARM
Case Fan:      0 RPM  (min =3D    0 RPM, div =3D 2)
CPU Fan:    3640 RPM  (min =3D    0 RPM, div =3D 2)
CPU Temp:    +36.9=C2=B0C  (high =3D +190.1=C2=B0C, hyst =3D -77.5=C2=B0C)
Int Temp:    +50.0=C2=B0C  (high =3D +204.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
cpu0_vid:   +1.750 V

The value from acpitz-virtual-0 is abviously bad.  Is there a way to get
sensors to ignore the value?  It's really messing up my Munin monitoring of
the machine.  I looked around and didn't find any syntax to ignore virtual
devices in sensors3.conf.

Thanks,

Sean

--00c09ffb5a67d6a3ee0475e5aa86
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Running Ubuntu 9.10 Beta.=A0 <br>Linux mythbuntu 2.6.31-13-generic #44-Ubun=
tu SMP Sat Oct 10 15:27:55 UTC 2009 i686 GNU/Linux<br>sensors version 3.0.2=
 with libsensors version 3.0.2<br><br>~$ sensors<br>acpitz-virtual-0<br>Ada=
pter: Virtual device<br>
temp1:=A0=A0=A0=A0=A0 -273.2=C2=B0C=A0 (crit =3D +60.0=C2=B0C)<br><br>vt121=
1-isa-6000<br>Adapter: ISA adapter<br>+3.3V:=A0=A0=A0=A0=A0=A0 +3.31 V=A0 (=
min =3D=A0 +0.00 V, max =3D=A0 +4.42 V)<br>+2.5V:=A0=A0=A0=A0=A0=A0 +2.42 V=
=A0 (min =3D=A0 +0.00 V, max =3D=A0 +3.16 V)<br>VCore:=A0=A0=A0=A0=A0=A0 +1=
.38 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +2.63 V)<br>
+5V:=A0=A0=A0=A0=A0=A0=A0=A0 +4.46 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +6.=
31 V)<br>+12V:=A0=A0=A0=A0=A0=A0 +11.90 V=A0 (min =3D=A0 +0.00 V, max =3D +=
14.99 V)<br>+3.3V:=A0=A0=A0=A0=A0=A0 +3.12 V=A0 (min =3D=A0 +3.13 V, max =
=3D=A0 +3.46 V)=A0=A0 ALARM<br>Case Fan:=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=
=A0=A0=A0 0 RPM, div =3D 2)<br>
CPU Fan:=A0=A0=A0 3640 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 2)<br>CPU Te=
mp:=A0=A0=A0 +36.9=C2=B0C=A0 (high =3D +190.1=C2=B0C, hyst =3D -77.5=C2=B0C=
)<br>Int Temp:=A0=A0=A0 +50.0=C2=B0C=A0 (high =3D +204.0=C2=B0C, hyst =3D=
=A0 +0.0=C2=B0C)<br>cpu0_vid:=A0=A0 +1.750 V<br><br>The value from acpitz-v=
irtual-0 is abviously bad.=A0 Is there a way to get sensors to ignore the v=
alue?=A0 It&#39;s really messing up my Munin monitoring of the machine.=A0 =
I looked around and didn&#39;t find any syntax to ignore virtual devices in=
 sensors3.conf.<br>
<br>Thanks,<br><br>Sean<br><br>

--00c09ffb5a67d6a3ee0475e5aa86--


--===============2712236300098113637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2712236300098113637==--
