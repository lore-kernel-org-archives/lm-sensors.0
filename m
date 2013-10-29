From: Allen Weiner <alweiner7@hotmail.com>
Date: Tue, 29 Oct 2013 15:34:34 +0000
Subject: [lm-sensors] Seeking configuration for Gigabyte GA-970A-UD3
Message-Id: <BLU174-W46E11D045E59B1BDE499C9F7090@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I recently installed in my desktop PC a Gigabyte GA-970A-UD3 Rev 3.0 mother=
board. I'd like to find a lm-sensors configuration for this motherboard, sp=
ecifically, the scaling factors for the voltages. This particular board is =
not listed in the configurations on the lm-sensors wiki. I tried a few of t=
he other Gigabyte configurations listed on the wiki but the results were fa=
r off. The Super I/O chip is IT8728F. I read the "voltages and scaling" pag=
e on the lm-sensors wiki. It instructs to find BIOS screenshots using Googl=
e image search. I didn't find any useful BIOS screenshots for the GA-970A-U=
D3.

Sensors-detect ran without problem. Here is the "voltages" portion from the=
 "sensors" command (Fedora 19, kernel 3.11.6):

[root@localhost ~]# sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:=A0=A0=A0=A0=A0=A0=A0 +21.4=B0C=A0 (high =3D +70.0=B0C)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (crit =
=3D +80.0=B0C, hyst =3D +78.0=B0C)

it8728-isa-0228
Adapter: ISA adapter
in0:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.01 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+3.06 V)
in1:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.50 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+3.06 V)
in2:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.06 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+3.06 V)
in3:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.00 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+3.06 V)
in4:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.00 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+3.06 V)
in5:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.48 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+3.06 V)
in6:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.22 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+3.06 V)
3VSB:=A0=A0=A0=A0=A0=A0=A0=A0 +3.31 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +6=
.12 V)
Vbat:=A0=A0=A0=A0=A0=A0=A0=A0 +3.14 V =A0


This is what my BIOS reports in "PC Health Status":=20

VCore: 1.344V
Dram: 1.500V
+3.3: 3.304V
+5V: 5.010V
+12V: 12.312V

Any suggestions? 		 	   		 =20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
