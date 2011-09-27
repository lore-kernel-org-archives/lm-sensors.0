From: Matthew Gilbride <mgilbride1971@gmail.com>
Date: Tue, 27 Sep 2011 21:37:28 +0000
Subject: [lm-sensors] Fan Divisors and RPMS
Message-Id: <CAETpAZ7nyfwXLhULmd84yrRvSAdbOc1S0LeUfJ5TPhxe9Hd-Lw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7223051988622669052=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7223051988622669052==
Content-Type: multipart/alternative; boundary=001517740dae084a4804adf31531

--001517740dae084a4804adf31531
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello lm-sensor type people,

Loving lm-sensors with Gkrellm on an Asus Rampage Gene II Model CG5290
BP007. But am very new to Linux and am having trouble setting up fans. I
understand lm-sensor setup, pwmconfig, and the fancontrol script to a good
degree. I know I should be able to read/ control two fans on my system (not
including the GPU fan). I see/ hear all fans spinning, get proper rpm
readouts in the bios, and know my fans inside out from Everest in Windows
Vista. However, I can only control my Chasis fan and not my CPU fan in
Ubuntu 11.04. System details and sensors output at bottom.

I have installed lm-sensors, run sensors-detect, tried pwmconfig-failed, se=
t
linux option in grub to GRUB_CMDLINE_LINUX=3D"showopts
acpi_enforce_resources=3Dlax" and rerun pwmconfig-partial success. pwm1-3 n=
ow
shown. Can control pwm2 no problem. Fan-divisors are all 128 and rpms are 0
on all fans but pwm2. pwm2 divisor is 16. fancontrol works fine to control
the pwm2 fan. No ability to change divisors as suggested in older threads
but did try in my custom sensors file in sensors.d. all set statements fail
including on the working pwm. Again, these same fans are completely
controllable in Vista.

Have I skipped a major step somewhere. Is there a way I can start over and
retry the setup?

Many thanks in advance for help.

Matt


Motherboard ASUS Rampage Gene II
Chipset
CPU: Core i7 920
Linux Ditro: Ubuntu 11.04
kernel version: System-Product-Name 2.6.38-11-generic #50-Ubuntu SMP Mon Se=
p
12 21:17:25 UTC 2011 x86_64 x86_64 x86_64 GNU/Linux
lm_sensors version: sensors version 3.2.0 with libsensors version 3.2.0


Chip Drivers from Sensors-detect

adt7475
coretemp
w83627ehf


Sensors output

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +38.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +38.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +41.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +38.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)

w83667hg-isa-0290
Adapter: ISA adapter
Vcore:       +0.92 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:         +1.70 V  (min =3D  +0.82 V, max =3D  +0.39 V)   ALARM
AVCC:        +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:       +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:         +1.66 V  (min =3D  +1.60 V, max =3D  +1.66 V)
in5:         +2.04 V  (min =3D  +0.18 V, max =3D  +1.59 V)   ALARM
3VSB:        +3.39 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:        +3.31 V  (min =3D  +2.70 V, max =3D  +3.30 V)   ALARM
fan1:          0 RPM  (min =3D 7028 RPM, div =3D 128)  ALARM
fan2:       8880 RPM  (min =3D    0 RPM, div =3D 16)  ALARM
fan3:          0 RPM  (min =3D 42184 RPM, div =3D 128)  ALARM
fan4:          0 RPM  (min =3D 10544 RPM, div =3D 128)  ALARM
fan5:          0 RPM  (min =3D 21092 RPM, div =3D 128)  ALARM
temp1:       +32.0=B0C  (high =3D  +5.0=B0C, hyst =3D  +9.0=B0C)  ALARM  se=
nsor =3D
thermistor
temp2:       +31.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
temp3:        +7.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
cpu0_vid:   +0.000 V




--=20
Matthew Gilbride
Industrial Designer
919-264-7341

--001517740dae084a4804adf31531
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello lm-sensor type people,<br><br>Loving lm-sensors with Gkrellm on an As=
us Rampage Gene II Model CG5290 BP007. But am very new to Linux and am havi=
ng trouble setting up fans. I understand lm-sensor setup, pwmconfig, and th=
e fancontrol script to a good degree. I know I should be able to read/ cont=
rol two fans on my system (not including the GPU fan). I see/ hear all fans=
 spinning, get proper rpm readouts in the bios, and know my fans inside out=
 from Everest in Windows Vista. However, I can only control my Chasis fan a=
nd not my CPU fan in Ubuntu 11.04. System details and sensors output at bot=
tom.<br>
<br>I have installed lm-sensors, run sensors-detect, tried pwmconfig-failed=
, set linux option in grub to GRUB_CMDLINE_LINUX=3D&quot;showopts acpi_enfo=
rce_resources=3Dlax&quot; and rerun pwmconfig-partial success. pwm1-3 now s=
hown. Can control pwm2 no problem. Fan-divisors are all 128 and rpms are 0 =
on all fans but pwm2. pwm2 divisor is 16. fancontrol works fine to control =
the pwm2 fan. No ability to change divisors as suggested in older threads b=
ut did try in my custom sensors file in sensors.d. all set statements fail =
including on the working pwm. Again, these same fans are completely control=
lable in Vista. <br>
<br>Have I skipped a major step somewhere. Is there a way I can start over =
and retry the setup?<br><br>Many thanks in advance for help.<br><br>Matt<br=
><br>
<br>
Motherboard ASUS Rampage Gene II<br>
Chipset<br>
CPU: Core i7 920 <br>
Linux Ditro: Ubuntu 11.04<br>
kernel version: System-Product-Name 2.6.38-11-generic #50-Ubuntu SMP Mon Se=
p 12 21:17:25 UTC 2011 x86_64 x86_64 x86_64 GNU/Linux<br>
lm_sensors version: sensors version 3.2.0 with libsensors version 3.2.0<br>=
<br><br>Chip Drivers from Sensors-detect<br><br>adt7475<br>coretemp<br>w836=
27ehf<br><br><br>Sensors output<br><br>coretemp-isa-0000<br>Adapter: ISA ad=
apter<br>
Core 0:=A0=A0=A0=A0=A0 +38.0=B0C=A0 (high =3D +78.0=B0C, crit =3D +98.0=B0C=
)=A0 <br><br>coretemp-isa-0001<br>Adapter: ISA adapter<br>Core 1:=A0=A0=A0=
=A0=A0 +38.0=B0C=A0 (high =3D +78.0=B0C, crit =3D +98.0=B0C)=A0 <br><br>cor=
etemp-isa-0002<br>Adapter: ISA adapter<br>Core 2:=A0=A0=A0=A0=A0 +41.0=B0C=
=A0 (high =3D +78.0=B0C, crit =3D +98.0=B0C)=A0 <br>
<br>coretemp-isa-0003<br>Adapter: ISA adapter<br>Core 3:=A0=A0=A0=A0=A0 +38=
.0=B0C=A0 (high =3D +78.0=B0C, crit =3D +98.0=B0C)=A0 <br><br>w83667hg-isa-=
0290<br>Adapter: ISA adapter<br>Vcore:=A0=A0=A0=A0=A0=A0 +0.92 V=A0 (min =
=3D=A0 +0.00 V, max =3D=A0 +1.74 V)=A0=A0 <br>in1:=A0=A0=A0=A0=A0=A0=A0=A0 =
+1.70 V=A0 (min =3D=A0 +0.82 V, max =3D=A0 +0.39 V)=A0=A0 ALARM<br>
AVCC:=A0=A0=A0=A0=A0=A0=A0 +3.33 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3.63=
 V)=A0=A0 <br>+3.3V:=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =
=3D=A0 +3.63 V)=A0=A0 <br>in4:=A0=A0=A0=A0=A0=A0=A0=A0 +1.66 V=A0 (min =3D=
=A0 +1.60 V, max =3D=A0 +1.66 V)=A0=A0 <br>in5:=A0=A0=A0=A0=A0=A0=A0=A0 +2.=
04 V=A0 (min =3D=A0 +0.18 V, max =3D=A0 +1.59 V)=A0=A0 ALARM<br>
3VSB:=A0=A0=A0=A0=A0=A0=A0 +3.39 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3.63=
 V)=A0=A0 <br>Vbat:=A0=A0=A0=A0=A0=A0=A0 +3.31 V=A0 (min =3D=A0 +2.70 V, ma=
x =3D=A0 +3.30 V)=A0=A0 ALARM<br>fan1:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 =
(min =3D 7028 RPM, div =3D 128)=A0 ALARM<br>fan2:=A0=A0=A0=A0=A0=A0 8880 RP=
M=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 16)=A0 ALARM<br>
fan3:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D 42184 RPM, div =3D 128)=
=A0 ALARM<br>fan4:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D 10544 RPM, =
div =3D 128)=A0 ALARM<br>fan5:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=
 21092 RPM, div =3D 128)=A0 ALARM<br>temp1:=A0=A0=A0=A0=A0=A0 +32.0=B0C=A0 =
(high =3D=A0 +5.0=B0C, hyst =3D=A0 +9.0=B0C)=A0 ALARM=A0 sensor =3D thermis=
tor<br>
temp2:=A0=A0=A0=A0=A0=A0 +31.0=B0C=A0 (high =3D +80.0=B0C, hyst =3D +75.0=
=B0C)=A0 sensor =3D diode<br>temp3:=A0=A0=A0=A0=A0=A0=A0 +7.5=B0C=A0 (high =
=3D +80.0=B0C, hyst =3D +75.0=B0C)=A0 sensor =3D thermistor<br>cpu0_vid:=A0=
=A0 +0.000 V<br><br><br><br clear=3D"all"><br>-- <br>Matthew Gilbride<br>
Industrial Designer<br>919-264-7341<br>

--001517740dae084a4804adf31531--


--===============7223051988622669052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7223051988622669052==--
