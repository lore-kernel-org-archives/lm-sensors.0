From: Arun Raghavan <arraghav@gmail.com>
Date: Wed, 27 Jun 2012 18:28:34 +0000
Subject: [lm-sensors] Reducing fan speed for w83627ehf
Message-Id: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5896016810381934803=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5896016810381934803==
Content-Type: multipart/alternative; boundary=14dae9399b4d07b6d304c37862ea

--14dae9399b4d07b6d304c37862ea
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I need to get fairly fine grain control on my CPU fan speed for some
experiments, but I am currently unable to set the fan speed below 1054 RPM.
pwmconfig confirms the same across the divisor range. Processor is i7-2600,
motherboard

I tried setting pwm2_enable to 1 and pwm2 to 1 manually and I see that the
fan speed varies but the min RPM remains 1054.  Info below.

Any pointers on whether it is possible to reduce fan speed further, and if
so how would be very helpful.

thanks,
-arun

root@sandy:/sys/devices/platform/w83627ehf.656# echo 255 > pwm2
root@sandy:/sys/devices/platform/w83627ehf.656# sensors
coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +46.0=C2=B0C  (high =3D +78.0=C2=B0C, crit =3D +98.0=C2=B0C=
)  ALARM (CRIT)
Core 0:         +46.0=C2=B0C  (high =3D +78.0=C2=B0C, crit =3D +98.0=C2=B0C=
)  ALARM (CRIT)

nct6775-isa-0290
Adapter: ISA adapter
Vcore:         +0.82 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:           +1.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
AVCC:          +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:           +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in5:           +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in6:           +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
fan1:            0 RPM  (min =3D    0 RPM, div =3D 128)
fan2:         2109 RPM  (min =3D    0 RPM, div =3D 128)  ALARM <----
fan3:            0 RPM  (min =3D    0 RPM, div =3D 128)
fan4:            0 RPM  (div =3D 128)
SYSTIN:        +31.0=C2=B0C  (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)=
  ALARM  sensor
=3D CPU diode
CPUTIN:        +29.5=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)=
  sensor =3D CPU
diode
AUXTIN:        +22.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)=
  sensor =3D
thermistor
PECI Agent 0:  +45.5=C2=B0C
cpu0_vid:     +2.050 V
intrusion0:   OK

root@sandy:/sys/devices/platform/w83627ehf.656# echo 1 > pwm2
root@sandy:/sys/devices/platform/w83627ehf.656# sensors
coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +46.0=C2=B0C  (high =3D +78.0=C2=B0C, crit =3D +98.0=C2=B0C=
)  ALARM (CRIT)
Core 0:         +46.0=C2=B0C  (high =3D +78.0=C2=B0C, crit =3D +98.0=C2=B0C=
)  ALARM (CRIT)

nct6775-isa-0290
Adapter: ISA adapter
Vcore:         +0.85 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:           +1.12 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
AVCC:          +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:         +3.46 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:           +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in5:           +1.05 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in6:           +1.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
fan1:            0 RPM  (min =3D    0 RPM, div =3D 128)
fan2:         1054 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
fan3:            0 RPM  (min =3D    0 RPM, div =3D 128)
fan4:            0 RPM  (div =3D 128)
SYSTIN:        +30.0=C2=B0C  (high =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C)=
  ALARM  sensor
=3D CPU diode
CPUTIN:        +29.5=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)=
  sensor =3D CPU
diode
AUXTIN:        +22.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)=
  sensor =3D
thermistor
PECI Agent 0:  +44.5=C2=B0C
cpu0_vid:     +2.050 V
intrusion0:   OK

--14dae9399b4d07b6d304c37862ea
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I need to get fairly fine grain control on my CPU fan speed for =
some experiments, but I am currently unable to set the fan speed below 1054=
 RPM. pwmconfig confirms the same across the divisor range. Processor is i7=
-2600, motherboard <br>
<br>I tried setting pwm2_enable to 1 and pwm2 to 1 manually and I see that =
the fan speed varies but the min RPM remains 1054.=A0 Info below.<br><br>An=
y pointers on whether it is possible to reduce fan speed further, and if so=
 how would be very helpful.<br>
<br>thanks,<br>-arun<br><br>root@sandy:/sys/devices/platform/w83627ehf.656#=
 echo 255 &gt; pwm2<br>root@sandy:/sys/devices/platform/w83627ehf.656# sens=
ors<br>coretemp-isa-0000<br>Adapter: ISA adapter<br>Physical id 0:=A0 +46.0=
=C2=B0C=A0 (high =3D +78.0=C2=B0C, crit =3D +98.0=C2=B0C)=A0 ALARM (CRIT)<b=
r>
Core 0:=A0=A0=A0=A0=A0=A0=A0=A0 +46.0=C2=B0C=A0 (high =3D +78.0=C2=B0C, cri=
t =3D +98.0=C2=B0C)=A0 ALARM (CRIT)<br><br>nct6775-isa-0290<br>Adapter: ISA=
 adapter<br>Vcore:=A0=A0=A0=A0=A0=A0=A0=A0 +0.82 V=A0 (min =3D=A0 +0.00 V, =
max =3D=A0 +1.74 V)<br>in1:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.12 V=A0 (min =
=3D=A0 +0.00 V, max =3D=A0 +0.00 V)=A0 ALARM<br>
AVCC:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.46 V=A0 (min =3D=A0 +2.98 V, max =3D=A0=
 +3.63 V)<br>+3.3V:=A0=A0=A0=A0=A0=A0=A0=A0 +3.46 V=A0 (min =3D=A0 +2.98 V,=
 max =3D=A0 +3.63 V)<br>in4:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.06 V=A0 (min =
=3D=A0 +0.00 V, max =3D=A0 +0.00 V)=A0 ALARM<br>in5:=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 +1.05 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +0.00 V)=A0 ALARM<br>
in6:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.08 V=A0 (min =3D=A0 +0.00 V, max =3D=
=A0 +0.00 V)=A0 ALARM<br>3VSB:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.41 V=A0 (min =
=3D=A0 +2.98 V, max =3D=A0 +3.63 V)<br>Vbat:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.=
34 V=A0 (min =3D=A0 +2.70 V, max =3D=A0 +3.30 V)=A0 ALARM<br>fan1:=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)<br>
fan2:=A0=A0=A0=A0=A0=A0=A0=A0 2109 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D =
128)=A0 ALARM &lt;----<br>fan3:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (=
min =3D=A0=A0=A0 0 RPM, div =3D 128)<br>fan4:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0 RPM=A0 (div =3D 128)<br>SYSTIN:=A0=A0=A0=A0=A0=A0=A0 +31.0=C2=B0C=A0 =
(high =3D=A0 +0.0=C2=B0C, hyst =3D=A0 +0.0=C2=B0C)=A0 ALARM=A0 sensor =3D C=
PU diode<br>
CPUTIN:=A0=A0=A0=A0=A0=A0=A0 +29.5=C2=B0C=A0 (high =3D +80.0=C2=B0C, hyst =
=3D +75.0=C2=B0C)=A0 sensor =3D CPU diode<br>AUXTIN:=A0=A0=A0=A0=A0=A0=A0 +=
22.0=C2=B0C=A0 (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)=A0 sensor =3D=
 thermistor<br>PECI Agent 0:=A0 +45.5=C2=B0C=A0 <br>cpu0_vid:=A0=A0=A0=A0 +=
2.050 V<br>
intrusion0:=A0=A0 OK<br><br>root@sandy:/sys/devices/platform/w83627ehf.656#=
 echo 1 &gt; pwm2<br>root@sandy:/sys/devices/platform/w83627ehf.656# sensor=
s<br>coretemp-isa-0000<br>Adapter: ISA adapter<br>Physical id 0:=A0 +46.0=
=C2=B0C=A0 (high =3D +78.0=C2=B0C, crit =3D +98.0=C2=B0C)=A0 ALARM (CRIT)<b=
r>
Core 0:=A0=A0=A0=A0=A0=A0=A0=A0 +46.0=C2=B0C=A0 (high =3D +78.0=C2=B0C, cri=
t =3D +98.0=C2=B0C)=A0 ALARM (CRIT)<br><br>nct6775-isa-0290<br>Adapter: ISA=
 adapter<br>Vcore:=A0=A0=A0=A0=A0=A0=A0=A0 +0.85 V=A0 (min =3D=A0 +0.00 V, =
max =3D=A0 +1.74 V)<br>in1:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.12 V=A0 (min =
=3D=A0 +0.00 V, max =3D=A0 +0.00 V)=A0 ALARM<br>
AVCC:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.46 V=A0 (min =3D=A0 +2.98 V, max =3D=A0=
 +3.63 V)<br>+3.3V:=A0=A0=A0=A0=A0=A0=A0=A0 +3.46 V=A0 (min =3D=A0 +2.98 V,=
 max =3D=A0 +3.63 V)<br>in4:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.06 V=A0 (min =
=3D=A0 +0.00 V, max =3D=A0 +0.00 V)=A0 ALARM<br>in5:=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 +1.05 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +0.00 V)=A0 ALARM<br>
in6:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.08 V=A0 (min =3D=A0 +0.00 V, max =3D=
=A0 +0.00 V)=A0 ALARM<br>3VSB:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.41 V=A0 (min =
=3D=A0 +2.98 V, max =3D=A0 +3.63 V)<br>Vbat:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.=
34 V=A0 (min =3D=A0 +2.70 V, max =3D=A0 +3.30 V)=A0 ALARM<br>fan1:=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)<br>
fan2:=A0=A0=A0=A0=A0=A0=A0=A0 1054 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D =
128)=A0 ALARM<br>fan3:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=
=A0=A0=A0 0 RPM, div =3D 128)<br>fan4:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 R=
PM=A0 (div =3D 128)<br>SYSTIN:=A0=A0=A0=A0=A0=A0=A0 +30.0=C2=B0C=A0 (high =
=3D=A0 +0.0=C2=B0C, hyst =3D=A0 +0.0=C2=B0C)=A0 ALARM=A0 sensor =3D CPU dio=
de<br>
CPUTIN:=A0=A0=A0=A0=A0=A0=A0 +29.5=C2=B0C=A0 (high =3D +80.0=C2=B0C, hyst =
=3D +75.0=C2=B0C)=A0 sensor =3D CPU diode<br>AUXTIN:=A0=A0=A0=A0=A0=A0=A0 +=
22.0=C2=B0C=A0 (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)=A0 sensor =3D=
 thermistor<br>PECI Agent 0:=A0 +44.5=C2=B0C=A0 <br>cpu0_vid:=A0=A0=A0=A0 +=
2.050 V<br>
intrusion0:=A0=A0 OK<br><br><br><br><br>

--14dae9399b4d07b6d304c37862ea--


--===============5896016810381934803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5896016810381934803==--
