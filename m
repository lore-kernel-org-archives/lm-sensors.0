From: Matt Sheumack <matt@sheumack.com>
Date: Sat, 14 Nov 2009 19:38:52 +0000
Subject: [lm-sensors] ASUS P6T, 2.6.31-14, no pwm devices
Message-Id: <8c4290000911141138v161593b0u785895e5a7960587@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8408524910779765330=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8408524910779765330==
Content-Type: multipart/alternative; boundary=0016e6d77fa0212f33047859ed35

--0016e6d77fa0212f33047859ed35
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,

Been scanning the recent activity around how 2.6.31 has broken fan control
on many m/boards, and am hoping to make a contribution so this problem can
be fixed. Given that my coding skills are limited to Fortran 77, best I can
do is help with data and test. I've not (yet) enabled the "lax" workaround,
so I don't know if it works. Happy to follow instructions from here to
provide H/W input.

Regards

Matt

- i7-920 + ASUS P6T.

What worked:
- Under Ubuntu 9.0.4 with 2.6.14 through 2.6.16 (canonical distributions).
- Manual modprobe w83627ehf added to rc script
- lm-sensors 3.1.1 (tarball from sensors web-site). Fan control found 3 fan=
s
(1 CPU + 2 x chassis), with 2 x PWM devices (1 CPU + 1 chassis). The two m/=
b
connected fans were sucessfully controlled using:

      Settings for hwmon8/device/pwm2:
         Depends on hwmon8/device/temp2_input
         Controls hwmon8/device/fan4_input
<lm-sensors@lm-sensors.org>
What doesn't work:
- Under Ubuntu 9.10 with 2.6.31 (Canonical distribution, online upgrade fro=
m
9.0.4)
- sensors version 3.1.1 with libsensors version 3.1.1 (canonical
distributions)
- sensors sees CPU and core temps + 3 fans.
- There are no pwm-capable sensor modules installed devices found (hence no
fan-control)

# sensors
atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:      +1.05 V  (min =3D  +0.80 V, max =3D  +1.60 V)
 +3.3 Voltage:      +3.30 V  (min =3D  +2.97 V, max =3D  +3.63 V)
 +5 Voltage:        +4.97 V  (min =3D  +4.50 V, max =3D  +5.50 V)
 +12 Voltage:      +11.97 V  (min =3D +10.20 V, max =3D +13.80 V)
CPU FAN Speed:     2481 RPM  (min =3D  600 RPM)
CHASSIS1 FAN Speed:3590 RPM  (min =3D  600 RPM)
CHASSIS2 FAN Speed:3245 RPM  (min =3D  600 RPM)
POWER FAN Speed:      0 RPM  (min =3D    0 RPM)
CPU Temperature:    +45.0=B0C  (high =3D +60.0=B0C, crit =3D +75.0=B0C)
MB Temperature:     +40.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +46.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
...
coretemp-isa-0007
Adapter: ISA adapter
Core 7:      +43.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

dmesg:
[   13.045551] Adding 19044984k swap on /dev/md2.  Priority:-1 extents:1
across:19044984k
[   13.178591] nvidia: module license 'NVIDIA' taints kernel.
[   13.178594] Disabling lock debugging due to kernel taint
[   13.203853] Bluetooth: Generic Bluetooth USB driver ver 0.5
[   13.203949] usbcore: registered new interface driver btusb
[   13.222574] lp: driver loaded but no devices found
[   13.431026]   alloc irq_desc for 24 on node 0
[   13.431028]   alloc kstat_irqs on node 0
[   13.431035] nvidia 0000:02:00.0: PCI INT A -> GSI 24 (level, low) -> IRQ
24
[   13.431040] nvidia 0000:02:00.0: setting latency timer to 64
[   13.431147] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  173.14.20
Thu Jun 25 18:15:32 PDT 2009
[   13.511995] coretemp coretemp.0: Using relative temperature scale!
[   13.512023] coretemp coretemp.1: Using relative temperature scale!
[   13.512044] coretemp coretemp.2: Using relative temperature scale!
[   13.512065] coretemp coretemp.3: Using relative temperature scale!
[   13.512089] coretemp coretemp.4: Using relative temperature scale!
[   13.512111] coretemp coretemp.5: Using relative temperature scale!
[   13.512136] coretemp coretemp.6: Using relative temperature scale!
[   13.512161] coretemp coretemp.7: Using relative temperature scale!
[   13.570109] cfg80211: Calling CRDA to update world regulatory domain
[   13.797234] ip_tables: (C) 2000-2006 Netfilter Core Team
[   14.204574] w83627ehf: Found W83627EHG chip at 0x290
[   14.204594] ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with
ACPI region HWRE [0x290-0x299]
[   14.204596] ACPI: If an ACPI driver is available for this device, you
should use it instead of the native driver

--=20
Matt Sheumack

--0016e6d77fa0212f33047859ed35
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,<br><br>Been scanning the recent activity around how 2.6.31 has brok=
en fan control on many m/boards, and am hoping to make a contribution so th=
is problem can be fixed. Given that my coding skills are limited to Fortran=
 77, best I can do is help with data and test. I&#39;ve not (yet) enabled t=
he &quot;lax&quot; workaround, so I don&#39;t know if it works. Happy to fo=
llow instructions from here to provide H/W input.<br>
<br>Regards <br><br>Matt<br><br>- i7-920 + ASUS P6T. <br><br>What worked:<b=
r>- Under Ubuntu 9.0.4 with 2.6.14 through 2.6.16 (canonical distributions)=
.<br>- Manual modprobe w83627ehf added to rc script<br>- lm-sensors 3.1.1 (=
tarball from sensors web-site). Fan control found 3 fans (1 CPU + 2 x chass=
is), with 2 x PWM devices (1 CPU + 1 chassis). The two m/b connected fans w=
ere sucessfully controlled using: <br>
<br>=A0=A0=A0=A0=A0 Settings for hwmon8/device/pwm2:<br>=A0=A0 =A0 =A0 =A0 =
Depends on hwmon8/device/temp2_input<br>=A0 =A0 =A0 =A0=A0 Controls hwmon8/=
device/fan4_input<br><a href=3D"mailto:lm-sensors@lm-sensors.org"></a><br>W=
hat doesn&#39;t work:<br>- Under Ubuntu 9.10 with 2.6.31 (Canonical distrib=
ution, online upgrade from 9.0.4)<br>
- sensors version 3.1.1 with libsensors version 3.1.1 (canonical distributi=
ons)<br>- sensors sees CPU and core temps + 3 fans. <br>- There are no pwm-=
capable sensor modules installed devices found (hence no fan-control)<br>
<br># sensors<br>atk0110-acpi-0<br clear=3D"all">Adapter: ACPI interface<br=
>Vcore Voltage:=A0=A0=A0=A0=A0 +1.05 V=A0 (min =3D=A0 +0.80 V, max =3D=A0 +=
1.60 V)<br>=A0+3.3 Voltage:=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.97 V, =
max =3D=A0 +3.63 V)<br>=A0+5 Voltage:=A0=A0=A0=A0=A0=A0=A0 +4.97 V=A0 (min =
=3D=A0 +4.50 V, max =3D=A0 +5.50 V)<br>
=A0+12 Voltage:=A0=A0=A0=A0=A0 +11.97 V=A0 (min =3D +10.20 V, max =3D +13.8=
0 V)<br>CPU FAN Speed:=A0=A0=A0=A0 2481 RPM=A0 (min =3D=A0 600 RPM)<br>CHAS=
SIS1 FAN Speed:3590 RPM=A0 (min =3D=A0 600 RPM)<br>CHASSIS2 FAN Speed:3245 =
RPM=A0 (min =3D=A0 600 RPM)<br>POWER FAN Speed:=A0=A0=A0=A0=A0 0 RPM=A0 (mi=
n =3D=A0=A0=A0 0 RPM)<br>
CPU Temperature:=A0=A0=A0 +45.0=B0C=A0 (high =3D +60.0=B0C, crit =3D +75.0=
=B0C)=A0 <br>MB Temperature:=A0=A0=A0=A0 +40.0=B0C=A0 (high =3D +45.0=B0C, =
crit =3D +75.0=B0C)=A0 <br><br>coretemp-isa-0000<br>Adapter: ISA adapter<br=
>Core 0:=A0=A0=A0=A0=A0 +46.0=B0C=A0 (high =3D +80.0=B0C, crit =3D +100.0=
=B0C)=A0 <br>
...<br>coretemp-isa-0007<br>Adapter: ISA adapter<br>Core 7:=A0=A0=A0=A0=A0 =
+43.0=B0C=A0 (high =3D +80.0=B0C, crit =3D +100.0=B0C) <br><br>dmesg:<br>[=
=A0=A0 13.045551] Adding 19044984k swap on /dev/md2.=A0 Priority:-1 extents=
:1 across:19044984k<br>[=A0=A0 13.178591] nvidia: module license &#39;NVIDI=
A&#39; taints kernel.<br>
[=A0=A0 13.178594] Disabling lock debugging due to kernel taint<br>[=A0=A0 =
13.203853] Bluetooth: Generic Bluetooth USB driver ver 0.5<br>[=A0=A0 13.20=
3949] usbcore: registered new interface driver btusb<br>[=A0=A0 13.222574] =
lp: driver loaded but no devices found<br>
[=A0=A0 13.431026]=A0=A0 alloc irq_desc for 24 on node 0<br>[=A0=A0 13.4310=
28]=A0=A0 alloc kstat_irqs on node 0<br>[=A0=A0 13.431035] nvidia 0000:02:0=
0.0: PCI INT A -&gt; GSI 24 (level, low) -&gt; IRQ 24<br>[=A0=A0 13.431040]=
 nvidia 0000:02:00.0: setting latency timer to 64<br>
[=A0=A0 13.431147] NVRM: loading NVIDIA UNIX x86_64 Kernel Module=A0 173.14=
.20=A0 Thu Jun 25 18:15:32 PDT 2009<br>[=A0=A0 13.511995] coretemp coretemp=
.0: Using relative temperature scale!<br>[=A0=A0 13.512023] coretemp corete=
mp.1: Using relative temperature scale!<br>
[=A0=A0 13.512044] coretemp coretemp.2: Using relative temperature scale!<b=
r>[=A0=A0 13.512065] coretemp coretemp.3: Using relative temperature scale!=
<br>[=A0=A0 13.512089] coretemp coretemp.4: Using relative temperature scal=
e!<br>[=A0=A0 13.512111] coretemp coretemp.5: Using relative temperature sc=
ale!<br>
[=A0=A0 13.512136] coretemp coretemp.6: Using relative temperature scale!<b=
r>[=A0=A0 13.512161] coretemp coretemp.7: Using relative temperature scale!=
<br>[=A0=A0 13.570109] cfg80211: Calling CRDA to update world regulatory do=
main<br>
[=A0=A0 13.797234] ip_tables: (C) 2000-2006 Netfilter Core Team<br>[=A0=A0 =
14.204574] w83627ehf: Found W83627EHG chip at 0x290<br>[=A0=A0 14.204594] A=
CPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI region HWRE [=
0x290-0x299]<br>
[=A0=A0 14.204596] ACPI: If an ACPI driver is available for this device, yo=
u should use it instead of the native driver<br><br>-- <br>Matt Sheumack<br=
>

--0016e6d77fa0212f33047859ed35--


--===============8408524910779765330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8408524910779765330==--
