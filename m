From: krunal patel <krunal_smiles@yahoo.com>
Date: Fri, 03 Jun 2011 06:13:32 +0000
Subject: [lm-sensors] sensor details for W83627HG-AW
Message-Id: <838315.8004.qm@web95806.mail.in.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2494948695941635401=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2494948695941635401==
Content-Type: multipart/alternative; boundary="0-1237887261-1307080892=:8004"

--0-1237887261-1307080892=:8004
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to run lm-sensor on my machine. It is having W83627HG-AW chip.
I am using linux-2.6.27.45.=20
Module loaded are hwmon, hwmon-vid, w83627hf. I am getting error in dmesg a=
s=20

w83627hf: Found W83627HF chip at 0x290
hwmon-vid: Unknown VRM version of your x86 CPU

output of cpuinfo:
# cat /proc/cpuinfo=20
processor=A0=A0=A0=A0=A0=A0 : 0
vendor_id=A0=A0=A0=A0=A0=A0 : CentaurHauls
cpu family=A0=A0=A0=A0=A0 : 6
model=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 13
model name=A0=A0=A0=A0=A0 : VIA Eden Processor=A0 500MHz
stepping=A0=A0=A0=A0=A0=A0=A0 : 0
cpu MHz=A0=A0=A0=A0=A0=A0=A0=A0 : 499.938
cache size=A0=A0=A0=A0=A0 : 128 KB
fdiv_bug=A0=A0=A0=A0=A0=A0=A0 : no
hlt_bug=A0=A0=A0=A0=A0=A0=A0=A0 : no
f00f_bug=A0=A0=A0=A0=A0=A0=A0 : no
coma_bug=A0=A0=A0=A0=A0=A0=A0 : no
fpu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : yes
fpu_exception=A0=A0 : yes
cpuid level=A0=A0=A0=A0 : 1
wp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : yes
flags=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 ap=
ic sep mtrr pge cmov pat clflush acpi mmx fxsr sse sse2 tm nx pni est tm2 x=
tpr rng rng_en ace ace_en ace2 ace2_en phe phe_en pmm pmm_en
bogomips=A0=A0=A0=A0=A0=A0=A0 : 999.87
clflush size=A0=A0=A0 : 64
power management:

Senors output :
w83627hf-isa-0290
Adapter: ISA adapter
in0:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.69 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+4.08 V)
in1:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.06 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 =
+4.08 V)
in2:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.82 V, max =3D=A0 =
+3.79 V)
in3:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +2.99 V=A0 (min =3D=A0 +3.57 V, max =3D=A0 =
+1.73 V)=A0 ALARM
in4:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.26 V=A0 (min =3D=A0 +1.98 V, max =3D=A0 =
+4.05 V)
in5:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.31 V=A0 (min =3D=A0 +3.57 V, max =3D=A0 =
+3.17 V)=A0 ALARM
in6:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.33 V=A0 (min =3D=A0 +1.78 V, max =3D=A0 =
+0.53 V)=A0 ALARM
in7:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.28 V=A0 (min =3D=A0 +0.26 V, max =3D=A0 =
+2.29 V)=A0 ALARM
in8:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.50 V=A0 (min =3D=A0 +2.99 V, max =3D=A0 =
+0.64 V)=A0 ALARM
fan1:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D 14062 RPM, div =3D 2)=
=A0 ALARM
fan2:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0 -1 RPM, div =3D=
 2)=A0 ALARM
fan3:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0 -1 RPM, div =3D=
 2)=A0 ALARM
temp1:=A0=A0=A0=A0=A0=A0=A0 +55.0 C=A0 (high =3D=A0 +9.0 C, hyst =3D +32.0 =
C)=A0 ALARM=A0 sensor =3D thermistor
temp2:=A0=A0=A0=A0=A0=A0=A0 +39.5 C=A0 (high =3D +120.0 C, hyst =3D +115.0 =
C)=A0 sensor =3D diode
temp3:=A0=A0=A0=A0=A0=A0=A0 -48.0 C=A0 (high =3D +120.0 C, hyst =3D +115.0 =
C)=A0 sensor =3D thermistor
cpu0_vid:=A0=A0=A0 +0.000 V
beep_enable: enabled

Values different then What i get in BIOS.
Bios system health:
System Temp : 52C / 125 F
CPU Temp : 43C/ 109F
FAN1 : 0
FAN2 : 0
FAN3 : 0
Vcore : 0.68V
Vccp : 1.05V
+3.3V : 3.29V
+5V : 5.05V
+12V : 12.40V
VBAT : 3.50V
5VSB : 4.99V
=0A=0A=0A=0A=09=0A=09=0A=09=0A=09=0A=09=0A=09=09

Regards,
Krunal

--0-1237887261-1307080892=:8004
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi,<br><br>I am trying to run lm-sensor on my=
 machine. It is having W83627HG-AW chip.<br>I am using linux-2.6.27.45. <br=
>Module loaded are hwmon, hwmon-vid, w83627hf. I am getting error in dmesg =
as <br><br>w83627hf: Found W83627HF chip at 0x290<br>hwmon-vid: Unknown VRM=
 version of your x86 CPU<br><br>output of cpuinfo:<br># cat /proc/cpuinfo <=
br>processor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<br>vendor_id&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; : CentaurHauls<br>cpu family&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; : 6<br>model&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; : 13<br>model name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : VIA Eden Proces=
sor&nbsp; 500MHz<br>stepping&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<=
br>cpu MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 499.938<br>cac=
he size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 128
 KB<br>fdiv_bug&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : no<br>hlt_bug&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : no<br>f00f_bug&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : no<br>coma_bug&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; : no<br>fpu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; : yes<br>fpu_exception&nbsp;&nbsp; : yes<br>cpuid l=
evel&nbsp;&nbsp;&nbsp;&nbsp; : 1<br>wp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : yes<br>flags&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : fpu vme de pse tsc msr pae mce =
cx8 apic sep mtrr pge cmov pat clflush acpi mmx fxsr sse sse2 tm nx pni est=
 tm2 xtpr rng rng_en ace ace_en ace2 ace2_en phe phe_en pmm pmm_en<br>bogom=
ips&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 999.87<br>clflush size&nbsp=
;&nbsp;&nbsp; : 64<br>power management:<br><br>Senors output :<br>w83627hf-=
isa-0290<br>Adapter: ISA
 adapter<br>in0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.6=
9 V&nbsp; (min =3D&nbsp; +0.00 V, max =3D&nbsp; +4.08 V)<br>in1:&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1.06 V&nbsp; (min =3D&nbsp; +0=
.00 V, max =3D&nbsp; +4.08 V)<br>in2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; +3.30 V&nbsp; (min =3D&nbsp; +2.82 V, max =3D&nbsp; +3.79 =
V)<br>in3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +2.99 V&nb=
sp; (min =3D&nbsp; +3.57 V, max =3D&nbsp; +1.73 V)&nbsp; ALARM<br>in4:&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.26 V&nbsp; (min =3D&nb=
sp; +1.98 V, max =3D&nbsp; +4.05 V)<br>in5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; +3.31 V&nbsp; (min =3D&nbsp; +3.57 V, max =3D&nbsp; =
+3.17 V)&nbsp; ALARM<br>in6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; +3.33 V&nbsp; (min =3D&nbsp; +1.78 V, max =3D&nbsp; +0.53 V)&nbsp; =
ALARM<br>in7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.28 V=
&nbsp; (min =3D&nbsp;
 +0.26 V, max =3D&nbsp; +2.29 V)&nbsp; ALARM<br>in8:&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.50 V&nbsp; (min =3D&nbsp; +2.99 V, max =
=3D&nbsp; +0.64 V)&nbsp; ALARM<br>fan1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =3D 14062 RPM, div =3D 2)&nbsp; A=
LARM<br>fan2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
 RPM&nbsp; (min =3D&nbsp;&nbsp; -1 RPM, div =3D 2)&nbsp; ALARM<br>fan3:&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 RPM&nbsp; (min =
=3D&nbsp;&nbsp; -1 RPM, div =3D 2)&nbsp; ALARM<br>temp1:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; +55.0 C&nbsp; (high =3D&nbsp; +9.0 C, hyst =3D +32.=
0 C)&nbsp; ALARM&nbsp; sensor =3D thermistor<br>temp2:&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; +39.5 C&nbsp; (high =3D +120.0 C, hyst =3D +115.0 C)&=
nbsp; sensor =3D diode<br>temp3:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-48.0 C&nbsp; (high =3D +120.0 C, hyst =3D +115.0 C)&nbsp; sensor =3D
 thermistor<br>cpu0_vid:&nbsp;&nbsp;&nbsp; +0.000 V<br>beep_enable: enabled=
<br><br>Values different then What i get in BIOS.<br>Bios system health:<br=
>System Temp : 52C / 125 F<br>CPU Temp : 43C/ 109F<br>FAN1 : 0<br>FAN2 : 0<=
br>FAN3 : 0<br>Vcore : 0.68V<br>Vccp : 1.05V<br>+3.3V : 3.29V<br>+5V : 5.05=
V<br>+12V : 12.40V<br>VBAT : 3.50V<br>5VSB : 4.99V<br>=0A=0A=0A=0A=09=0A=09=
<meta http-equiv=3D"CONTENT-TYPE" content=3D"text/html; charset=3Dutf-8">=
=0A=09<title></title>=0A=09<meta name=3D"GENERATOR" content=3D"OpenOffice.o=
rg 3.1  (Linux)">=0A=09<style>=0A=09=09<!-- =0A=09=09BODY,DIV,TABLE,THEAD,T=
BODY,TFOOT,TR,TH,TD,P { font-family:"Arial"; font-size:x-small }=0A=09=09 -=
-></style><br><br>Regards,<br>Krunal<br></td></tr></table>
--0-1237887261-1307080892=:8004--


--===============2494948695941635401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2494948695941635401==--
