From: spmurphy@talk21.com
Date: Sun, 22 Nov 2009 12:32:32 +0000
Subject: [lm-sensors] atk0110/BIOS discrepancies
Message-Id: <951278.95878.qm@web86503.mail.ird.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4155992565819446763=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4155992565819446763==
Content-Type: multipart/alternative; boundary="0-746239133-1258893152=:95878"

--0-746239133-1258893152=:95878
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I have an Asus Maximus III Formula and I'm trying to work which set of sens=
or values is correct. My basic problem is I see one set of values in the BI=
OS and, in places, a different set of values once booted into Ubuntu 9.10. =
Most of these values I'm not interested in but one worries me slightly.

Below are my readings. The left hand labels and values come from "sensors",=
 the right hand column from the BIOS.

atk0110-acpi-0
Adapter: ACPI interface=A0=A0=A0=A0=A0=A0=A0=A0 sensors=A0=A0=A0=A0=A0=A0=
=A0=A0 bios
=A0+3.3 Voltage:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.34 V=
=A0=A0=A0=A0=A0=A0=A0=A0 3.328V
=A0+5 Voltage:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +5.=
09 V=A0=A0=A0=A0=A0=A0=A0=A0 5.094V
=A0+12 Voltage:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +12.3=
1 V=A0=A0=A0=A0=A0=A0=A0 12.306V
DRAM Voltage:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.60 V=
=A0=A0=A0=A0=A0=A0=A0=A0 1.601V
CPU Vcore Voltage:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.90 V=A0=A0=A0=
=A0=A0=A0=A0=A0 ?
CPU PLL Voltage:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.80 V=A0=A0=
=A0=A0=A0=A0=A0=A0 1.799V
VTT CPU Voltage:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.12 V=A0=A0=
=A0=A0=A0=A0=A0=A0 ?
DRAM Voltage:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.06 V=
=A0=A0=A0=A0=A0=A0=A0=A0 ?
DRAM Voltage:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.50 V=
=A0=A0=A0=A0=A0=A0=A0=A0 ?
DRAM Voltage:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.80 V=
=A0=A0=A0=A0=A0=A0=A0=A0 ?
DRAM Termination Voltage:=A0=A0=A0=A0=A0=A0 +0.79 V=A0=A0=A0=A0=A0=A0=A0=A0=
 0.794V
CPU FAN Speed:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM
CHA_FAN1 Speed:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM
CHA_FAN2 Speed:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM
CHA_FAN3 Speed:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM
PWR_FAN Speed:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 671 RPM=
=A0=A0=A0=A0=A0=A0=A0=A0 672 RPM
OPT_FAN1 Speed:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM
OPT_FAN2 Speed:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM
OPT_FAN3 Speed:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM
CPU Temperature:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +49.0=B0C=A0=
=A0=A0=A0=A0=A0=A0=A0 47C
MB Temperature:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +44.0=B0C=
=A0=A0=A0=A0=A0=A0=A0=A0 26C
PCH Temperature:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +26.0=B0C=A0=
=A0=A0=A0=A0=A0=A0=A0 26C
POWER Temperature:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +26.0=B0C=A0=A0=
=A0=A0=A0=A0=A0=A0 ?
OPT_TEMP1 Temperature:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0
OPT_TEMP2 Temperature:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0
OPT_TEMP3 Temperature:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ?=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.105V=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 CPU_VOLTAGE
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ?=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.058V=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 PCH_VOLTAGE
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 ?=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1.118V=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 IMC_VOLTAGE

The '?' are where I can't determine which sensors match which. The BIOS has=
 some extra values that you can see at the bottom which I assume map to som=
e of the sensor values but I don't know which ones. Ignore the FAN speed re=
adings, this is a water blocked machine so they're all disconnected. Out of=
 interest, I've tried all the fan connectors and all the values map across =
correctly.

CPU and PCH temperatures tie up nicely. The one that bothers me is "MB Temp=
erature" really. The BIOS shows 26C, sensors shows 44C. That's quite a jump=
; the machine is idle so I don't understand why the difference would be so =
marked. Sensors shows a reading for "POWER Temperature" which is 26C; this =
reading is missing from the BIOS despite the manual saying it should be sho=
wn. Assuming the BIOS is correct, is it possible that these 2 values are mi=
xed up? That would mean that MB is actually 26C and Power is 44C.

Also can anyone tell me what these temperature sensors actually correspond =
to? I'd like to know what MB, PCH and POWER Temperature actually correspond=
 to.

This is with sensors version 3.1.1+SVN with libsensors version 3.1.1+SVN, l=
inux 2.6.31-15-generic, ubuntu 9.10.

If there's anything you need me to run to help answer, please just fire awa=
y.

Simon
=0A=0A=0A      
--0-746239133-1258893152=:95878
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi,<br><br>I have an Asus Maximus III Formula=
 and I'm trying to work which set of sensor values is correct. My basic pro=
blem is I see one set of values in the BIOS and, in places, a different set=
 of values once booted into Ubuntu 9.10. Most of these values I'm not inter=
ested in but one worries me slightly.<br><br>Below are my readings. The lef=
t hand labels and values come from "sensors", the right hand column from th=
e BIOS.<br><br>atk0110-acpi-0<br>Adapter: ACPI interface&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sensors&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bios<br>&nbsp;+3.3 Voltage:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.34 V&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.328V<br>&nbsp;+5
 Voltage:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +5.09 V&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.094V<br>&nbsp;+12 Voltage:&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; +12.31 V&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12.306V=
<br>DRAM Voltage:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.60 V&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.601V<br>CPU Vcore Voltage:&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.90 V&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ?<br>CPU PLL Voltage:&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; +1.80 V&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.799V<br>VT=
T CPU
 Voltage:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; +1.12 V&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ?<br>DRAM Voltage:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.06 V&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ?<br>DRAM Voltage:&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; +1.50 V&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ?<b=
r>DRAM Voltage:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.80 V&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ?<br>DRAM Termination Voltage:&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; +0.79 V&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0.794V<br>CPU FAN Speed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0
 RPM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM<br>C=
HA_FAN1 Speed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM<br>CHA_FAN2 Speed:&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
RPM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM<br>CH=
A_FAN3 Speed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM<br>PWR_FAN Speed:&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 671 RPM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 672 RPM<br>OPT_FA=
N1 Speed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0
 RPM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM<br>O=
PT_FAN2 Speed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM<br>OPT_FAN3 Speed:&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
RPM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM<br>CP=
U Temperature:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +49.0=B0C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 47C<br>MB Temperature:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +44.0=B0C&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 26C<br>PCH Temperature:&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; +26.0=B0C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 26C<br>POWER Temperature:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +26.0=B0C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ?<br>OPT_TEMP1 Temperature:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; +0.0=B0C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0<br>OPT_TEMP2 Temperature:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; +0.0=B0C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0<br>OPT_TEMP3 Temperature:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; +0.0=B0C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.105V&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 CPU_VOLTAGE<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.058V&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCH_VOLTAGE<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.118V&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; IMC_VOLTAGE<br><br>The '?' are where I can't determ=
ine which sensors match which. The BIOS has some extra values that you can =
see at the bottom which I assume map to some of the sensor values but I don=
't know which ones. Ignore the FAN speed readings, this is a water
 blocked machine so they're all disconnected. Out of interest, I've tried a=
ll the fan connectors and all the values map across correctly.<br><br>CPU a=
nd PCH temperatures tie up nicely. The one that bothers me is "MB Temperatu=
re" really. The BIOS shows 26C, sensors shows 44C. That's quite a jump; the=
 machine is idle so I don't understand why the difference would be so marke=
d. Sensors shows a reading for "POWER Temperature" which is 26C; this readi=
ng is missing from the BIOS despite the manual saying it should be shown. A=
ssuming the BIOS is correct, is it possible that these 2 values are mixed u=
p? That would mean that MB is actually 26C and Power is 44C.<br><br>Also ca=
n anyone tell me what these temperature sensors actually correspond to? I'd=
 like to know what MB, PCH and POWER Temperature actually correspond to.<br=
><br>This is with sensors version 3.1.1+SVN with libsensors version 3.1.1+S=
VN, linux 2.6.31-15-generic, ubuntu 9.10.<br><br>If there's anything
 you need me to run to help answer, please just fire away.<br><br>Simon<br>=
</td></tr></table><br>=0A=0A=0A=0A      
--0-746239133-1258893152=:95878--


--===============4155992565819446763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4155992565819446763==--
