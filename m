From: Kenneth Cox <kencox1@gmail.com>
Date: Tue, 14 Feb 2012 00:46:33 +0000
Subject: [lm-sensors] help with setup / chip support
Message-Id: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2552600015843900739=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2552600015843900739==
Content-Type: multipart/alternative; boundary=f46d0447f1962ef07b04b8e1ed96

--f46d0447f1962ef07b04b8e1ed96
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am having trouble getting lm-sensors to work as it should I believe that
part of the problem is support for a newer chip set. here are the specs:

CPU: AMD A4-3400 APU with Radeon(tm) HD Graphics
family(18) model(1) stepping(0)

MoBo: ASRock A75M-HVS

I'm using the onboard Radeon graphics.

I ran the sensors-detect script saying yes to everything. The output of
sensors:
k10temp-pci-00c3
Adapter: PCI adapter
temp1:         +9.8=B0C  (high =3D +70.0=B0C)
                       (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)

That's much colder than room temp and only gives data for the PCI adapter.

I also tried downloading the latest version of sensors-detect from
http://www.lm-sensors.org/wiki/Devices and rerunning. It did not change
anything.

Is there a way to get sensor data for the CPU and accurate data from the
PCI adapter? Any help would be appreciated.

Thanks,
Ken

--f46d0447f1962ef07b04b8e1ed96
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div style>I am having trouble getting lm-sensors to work as it should I be=
lieve that part of the problem is support for a newer chip set. here are th=
e specs:<br><br>CPU: AMD A4-3400 APU with Radeon(tm) HD Graphics<br></div>
<span style>family(18) model(1) stepping(0)</span><div style><br></div><div=
 style>MoBo:=A0ASRock A75M-HVS</div><div style><br></div><div style>I&#39;m=
 using the onboard Radeon graphics.<br><br>I ran the sensors-detect script =
saying yes to everything. The output of sensors:<br>
k10temp-pci-00c3<br>Adapter: PCI adapter<br>temp1:=A0=A0=A0=A0=A0=A0=A0=A0 =
+9.8=B0C=A0 (high =3D +70.0=B0C)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)<br><br=
>That&#39;s much colder than room temp and only gives data for the PCI adap=
ter.=A0<br>
<br>I also tried downloading the latest version of sensors-detect from=A0<a=
 href=3D"http://www.lm-sensors.org/wiki/Devices" target=3D"_blank" style=3D=
"color:rgb(17,85,204)">http://www.lm-sensors.org/wiki/Devices</a>=A0and rer=
unning. It did not change anything.<br>
<br>Is there a way to get sensor data for the CPU and accurate data from th=
e PCI adapter? Any help would be appreciated.<br><br>Thanks,</div>Ken<br><b=
r>

--f46d0447f1962ef07b04b8e1ed96--


--===============2552600015843900739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2552600015843900739==--
