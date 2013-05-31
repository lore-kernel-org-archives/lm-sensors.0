From: "Ki'Sak" <kisak42@gmail.com>
Date: Fri, 31 May 2013 21:29:55 +0000
Subject: [lm-sensors] sensors3.conf for GA-990FXA-UD3 Rev1.1
Message-Id: <CAL=yMgU7rMg6PhOStvx9wcACCwHHycTRjOo+NLRsYhRWNA53yQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4918423494550215935=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4918423494550215935==
Content-Type: multipart/alternative; boundary=f46d043bdee4eda50104de0a5086

--f46d043bdee4eda50104de0a5086
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The following config is for a GA-990FXA-UD3, the Gigabyte GA-970A-D3 Rev
1.x to the GA-990FXA-UD7 Rev 1.x share a very similar sensor layout.

Output:

it8720-isa-0228
Adapter: ISA adapter
Vcore:        +1.41 V  (min =3D  +0.78 V, max =3D  +1.50 V)
Vdram:        +1.49 V  (min =3D  +1.42 V, max =3D  +1.57 V)
+3.3V:        +3.36 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:          +5.00 V  (min =3D  +4.76 V, max =3D  +5.24 V)
+12V:        +12.24 V  (min =3D +11.41 V, max =3D +12.62 V)
5VSB:         +5.03 V  (min =3D  +4.76 V, max =3D  +5.24 V)
Vbat:         +3.10 V
CPU_FAN:     1028 RPM  (min =3D   10 RPM)
SYS_FAN1:     979 RPM  (min =3D   10 RPM)
SYS_FAN2:    1198 RPM  (min =3D   10 RPM)
PWR_FAN:     1247 RPM  (min =3D   10 RPM)
VRM Temp:     +39.0=B0C  (low  =3D  +0.0=B0C, high =3D +65.0=B0C)  sensor =
=3D thermistor
SB Temp:      +26.0=B0C  (low  =3D  +0.0=B0C, high =3D +50.0=B0C)  sensor =
=3D thermal
diode
CPU Temp:     +25.0=B0C  (low  =3D  +0.0=B0C, high =3D +65.0=B0C)  sensor =
=3D Intel PECI

# libsensors3 configuration file for the GA-990FXA-UD3 Rev. 1.1
# This is strongly based on the Gigabyte GA-790XTA-UD4 sensors3.conf

chip "it8720-isa-*"
### Voltages

   # in5 is mysterious. It is -12V in other uses of this chip, but unstable
here
   # -12V is in the ATX spec for ISA, which is use sparingly in modern
hardware

   label  in0  "Vcore"
   label  in1  "Vdram"    # "DDR3" in BIOS
   label  in2  "+3.3V"
   label  in3  "+5V"      # Not in BIOS
   label  in4  "+12V"
   ignore in5             # -12V unused
   ignore in6
   label  in7  "5VSB"     # Not in BIOS
   label  in8  "Vbat"     # Not in BIOS
   ignore cpu0_vid
   ignore intrusion0      # No panel switch

### Fan labels as found on the motherboard

   label  fan1 "CPU_FAN"  # controlled by temp3
   label  fan2 "SYS_FAN1" # controlled by temp1
   label  fan3 "SYS_FAN2"
   label  fan4 "PWR_FAN"  # unregulated max speed

   # Vcore, Vdram, +3.3V and Vbat are connected directly, so no compute
   # line is needed for these. +5V and 5VSB are internal so we use the
   # standard scaling factor. Scaling for +12V is apparently not standard,
   # factor 3.963 is guessed from BIOS and EasyTune values (3.943 was
   # another candidate.)
   # These values have not been rechecked from the GA-790XTA-UD4
   compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
   compute  in4  @ * 3.963,      @ / 3.963
   compute  in7  @ * (6.8/10+1), @ / (6.8/10+1)

   # The BIOS won't set any limit for voltages.

   set in0_min  0.825 * 0.95
   set in0_max  1.425 * 1.05
   set in1_min  1.5   * 0.95
   set in1_max  1.5   * 1.05
   set in2_min  3.3   * 0.95
   set in2_max  3.3   * 1.05
   set in3_min  5     * 0.95
   set in3_max  5     * 1.05
   set in4_min 12     * 0.95
   set in4_max 12     * 1.05
   set in7_min  5     * 0.95
   set in7_max  5     * 1.05

### Temperatures

   label temp1 "VRM Temp" # This is unconfirmed, Possibly near NB, but the
NB
   set   temp1_min 0      # operates at significantly higher temps than
temp1
   set   temp1_max 65     # Default max fan speed reference point

   label temp2  "SB Temp" # This sensor reacts to nearby heat from the GPU
   set   temp2_min 0
   set   temp2_max 50     # Tropical ambient temperature plus a bit

   label temp3 "CPU Temp" # k10temp truncated to whole number +12C. k10temp
   set   temp3_min 0      # reports thermal margin, and reports -10C when
idle
   set   temp3_max 65     # Bulldozer Published limit +3C

--f46d043bdee4eda50104de0a5086
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>The following config is for a GA-990FXA-UD3, the=
 Gigabyte GA-970A-D3 Rev 1.x to the GA-990FXA-UD7 Rev 1.x share a very simi=
lar sensor layout.<br><br></div>Output:<br><br>it8720-isa-0228<br>Adapter: =
ISA adapter<br>
Vcore:=A0=A0=A0=A0=A0=A0=A0 +1.41 V=A0 (min =3D=A0 +0.78 V, max =3D=A0 +1.5=
0 V)<br>Vdram:=A0=A0=A0=A0=A0=A0=A0 +1.49 V=A0 (min =3D=A0 +1.42 V, max =3D=
=A0 +1.57 V)<br>+3.3V:=A0=A0=A0=A0=A0=A0=A0 +3.36 V=A0 (min =3D=A0 +3.14 V,=
 max =3D=A0 +3.47 V)<br>+5V:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +5.00 V=A0 (min =3D=
=A0 +4.76 V, max =3D=A0 +5.24 V)<br>
+12V:=A0=A0=A0=A0=A0=A0=A0 +12.24 V=A0 (min =3D +11.41 V, max =3D +12.62 V)=
<br>5VSB:=A0=A0=A0=A0=A0=A0=A0=A0 +5.03 V=A0 (min =3D=A0 +4.76 V, max =3D=
=A0 +5.24 V)<br>Vbat:=A0=A0=A0=A0=A0=A0=A0=A0 +3.10 V=A0 <br>CPU_FAN:=A0=A0=
=A0=A0 1028 RPM=A0 (min =3D=A0=A0 10 RPM)<br>SYS_FAN1:=A0=A0=A0=A0 979 RPM=
=A0 (min =3D=A0=A0 10 RPM)<br>
SYS_FAN2:=A0=A0=A0 1198 RPM=A0 (min =3D=A0=A0 10 RPM)<br>PWR_FAN:=A0=A0=A0=
=A0 1247 RPM=A0 (min =3D=A0=A0 10 RPM)<br>VRM Temp:=A0=A0=A0=A0 +39.0=B0C=
=A0 (low=A0 =3D=A0 +0.0=B0C, high =3D +65.0=B0C)=A0 sensor =3D thermistor<b=
r>SB Temp:=A0=A0=A0=A0=A0 +26.0=B0C=A0 (low=A0 =3D=A0 +0.0=B0C, high =3D +5=
0.0=B0C)=A0 sensor =3D thermal diode<br>
CPU Temp:=A0=A0=A0=A0 +25.0=B0C=A0 (low=A0 =3D=A0 +0.0=B0C, high =3D +65.0=
=B0C)=A0 sensor =3D Intel PECI<br><br># libsensors3 configuration file for =
the GA-990FXA-UD3 Rev. 1.1<br># This is strongly based on the Gigabyte GA-7=
90XTA-UD4 sensors3.conf<br>
<br>chip &quot;it8720-isa-*&quot;<br>### Voltages<br><br>=A0=A0 # in5 is my=
sterious. It is -12V in other uses of this chip, but unstable here<br>=A0=
=A0 # -12V is in the ATX spec for ISA, which is use sparingly in modern har=
dware<br>
<br>=A0=A0 label=A0 in0=A0 &quot;Vcore&quot;<br>=A0=A0 label=A0 in1=A0 &quo=
t;Vdram&quot;=A0=A0=A0 # &quot;DDR3&quot; in BIOS<br>=A0=A0 label=A0 in2=A0=
 &quot;+3.3V&quot;<br>=A0=A0 label=A0 in3=A0 &quot;+5V&quot;=A0=A0=A0=A0=A0=
 # Not in BIOS<br>=A0=A0 label=A0 in4=A0 &quot;+12V&quot;<br>
=A0=A0 ignore in5=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # -12V unused<br>=A0=
=A0 ignore in6<br>=A0=A0 label=A0 in7=A0 &quot;5VSB&quot;=A0=A0=A0=A0 # Not=
 in BIOS<br>=A0=A0 label=A0 in8=A0 &quot;Vbat&quot;=A0=A0=A0=A0 # Not in BI=
OS<br>=A0=A0 ignore cpu0_vid<br>=A0=A0 ignore intrusion0=A0=A0=A0=A0=A0 # N=
o panel switch<br>
<br>### Fan labels as found on the motherboard<br><br>=A0=A0 label=A0 fan1 =
&quot;CPU_FAN&quot;=A0 # controlled by temp3<br>=A0=A0 label=A0 fan2 &quot;=
SYS_FAN1&quot; # controlled by temp1<br>=A0=A0 label=A0 fan3 &quot;SYS_FAN2=
&quot;<br>=A0=A0 label=A0 fan4 &quot;PWR_FAN&quot;=A0 # unregulated max spe=
ed<br>
<br>=A0=A0 # Vcore, Vdram, +3.3V and Vbat are connected directly, so no com=
pute<br>=A0=A0 # line is needed for these. +5V and 5VSB are internal so we =
use the<br>=A0=A0 # standard scaling factor. Scaling for +12V is apparently=
 not standard,<br>
=A0=A0 # factor 3.963 is guessed from BIOS and EasyTune values (3.943 was<b=
r>=A0=A0 # another candidate.)<br></div>=A0=A0 # These values have not been=
 rechecked from the GA-790XTA-UD4<div>=A0=A0 compute=A0 in3=A0 @ * (6.8/10+=
1), @ / (6.8/10+1)<br>
=A0=A0 compute=A0 in4=A0 @ * 3.963,=A0=A0=A0=A0=A0 @ / 3.963<br>=A0=A0 comp=
ute=A0 in7=A0 @ * (6.8/10+1), @ / (6.8/10+1)<br><br>=A0=A0 # The BIOS won&#=
39;t set any limit for voltages.<br><br>=A0=A0 set in0_min=A0 0.825 * 0.95<=
br>=A0=A0 set in0_max=A0 1.425 * 1.05<br>
=A0=A0 set in1_min=A0 1.5=A0=A0 * 0.95<br>=A0=A0 set in1_max=A0 1.5=A0=A0 *=
 1.05<br>=A0=A0 set in2_min=A0 3.3=A0=A0 * 0.95<br>=A0=A0 set in2_max=A0 3.=
3=A0=A0 * 1.05<br>=A0=A0 set in3_min=A0 5=A0=A0=A0=A0 * 0.95<br>=A0=A0 set =
in3_max=A0 5=A0=A0=A0=A0 * 1.05<br>=A0=A0 set in4_min 12=A0=A0=A0=A0 * 0.95=
<br>
=A0=A0 set in4_max 12=A0=A0=A0=A0 * 1.05<br>=A0=A0 set in7_min=A0 5=A0=A0=
=A0=A0 * 0.95<br>=A0=A0 set in7_max=A0 5=A0=A0=A0=A0 * 1.05<br><br>### Temp=
eratures<br><br>=A0=A0 label temp1 &quot;VRM Temp&quot; # This is unconfirm=
ed, Possibly near NB, but the NB <br>=A0=A0 set=A0=A0 temp1_min 0=A0=A0=A0=
=A0=A0 # operates at significantly higher temps than temp1<br>
=A0=A0 set=A0=A0 temp1_max 65=A0=A0=A0=A0 # Default max fan speed reference=
 point<br><br>=A0=A0 label temp2=A0 &quot;SB Temp&quot; # This sensor react=
s to nearby heat from the GPU<br>=A0=A0 set=A0=A0 temp2_min 0<br>=A0=A0 set=
=A0=A0 temp2_max 50=A0=A0=A0=A0 # Tropical ambient temperature plus a bit<b=
r>
<br>=A0=A0 label temp3 &quot;CPU Temp&quot; # k10temp truncated to whole nu=
mber +12C. k10temp<br>=A0=A0 set=A0=A0 temp3_min 0=A0=A0=A0=A0=A0 # reports=
 thermal margin, and reports -10C when idle<br>=A0=A0 set=A0=A0 temp3_max 6=
5=A0=A0=A0=A0 # Bulldozer Published limit +3C<br>
</div></div>

--f46d043bdee4eda50104de0a5086--


--===============4918423494550215935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4918423494550215935==--
