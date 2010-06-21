From: Ulf Granlund <galsjo@hotmail.com>
Date: Mon, 21 Jun 2010 10:19:50 +0000
Subject: [lm-sensors] Too low temp readings on overclocked Intel Atom CPU
Message-Id: <BLU142-W26CE1E8D8E3AE3FD1983A1D3C30@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hello,
I am running an Asrock Ion computer under Ubuntu 10.4.=A0It has four Intel =
Atom CPU cores. In the Asrock BIOS thereis an option to introduce overclock=
ing. I have set the frequencyto 1800 MHz insetad of the standard 1600 MHz.
After having the computer switched on for several hours, but theCPU:s mainl=
y idle, the output from the sensors command is as below,in a room where amb=
ient temperature is about 22 C.
coretemp-isa-0000Adapter: ISA adapterCore 0: =A0 =A0 =A0 +4.0=B0C =A0(crit =
=3D +90.0=B0C) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
coretemp-isa-0001Adapter: ISA adapterCore 1: =A0 =A0 =A0+16.0=B0C =A0(crit =
=3D +90.0=B0C) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
coretemp-isa-0002Adapter: ISA adapterCore 2: =A0 =A0 =A0 +3.0=B0C =A0(crit =
=3D +90.0=B0C) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
coretemp-isa-0003Adapter: ISA adapterCore 3: =A0 =A0 =A0+16.0=B0C =A0(crit =
=3D +90.0=B0C)
Clearly these temperatures are way too low.However, if I set the processor =
frequency to the standard 1600 MHz,I get:
coretemp-isa-0000Adapter: ISA adapterCore 0: =A0 =A0 =A0+17.0=B0C =A0(crit =
=3D +90.0=B0C) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
coretemp-isa-0001Adapter: ISA adapterCore 1: =A0 =A0 =A0+25.0=B0C =A0(crit =
=3D +90.0=B0C) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
coretemp-isa-0002Adapter: ISA adapterCore 2: =A0 =A0 =A0+18.0=B0C =A0(crit =
=3D +90.0=B0C) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
coretemp-isa-0003Adapter: ISA adapterCore 3: =A0 =A0 =A0+25.0=B0C =A0(crit =
=3D +90.0=B0C)=A0
Which at least seems far more reasonable.
It seems that the more I overclock, the lower the temperature readings get.=
Can somebody explain how to get correct temp readings? It is of course more=
 importantto me to get correct readings in the overclocked situation than i=
n the standard situation...
The lm-sensors version used is 3.1.2 and the linux kernel version is 2.6.32.
Regards
Ulf 		 	   		 =20
_________________________________________________________________
Hotmail i mobilen p=E5 5 sekunder!
http://new.windowslivemobile.msn.com/SE-SE/windows-live-hotmail/default.aspx
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
