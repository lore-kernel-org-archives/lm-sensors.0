From: Adam Rosi-Kessel <adam@rosi-kessel.org>
Date: Sat, 16 Mar 2013 17:58:21 +0000
Subject: [lm-sensors] Dell Inspiron 530 Chassis Fan Control?
Message-Id: <20130316175820.GA979@whitehail.bostoncoop.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0596552456494752044=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============0596552456494752044==
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Is it possible to control the chassis fan on a Dell Inspiron 530? That
fan appears to always run at full speed; would like to quiet it down when
system isn't busy.

Running Debian with a 3.2.0 kernel but willing to try anything for a
quieter system.

fancontrol/pwmconfig work for CPU fans with acpi_enforce_resources=3Dlax
boot option, but I can't find any documentation as to how (if at all) to
control CPu fan. There is also nothing applicable in BIOS (using latest
release -- 2/24/09 1.0.18).

i8k kernel module won't load without force; but with force, none of the
fan/temperature parameters are correct in /proc/i8k (only the BIOS
version).

sensors reports:

acpitz-virtual-0
Adapter: Virtual device
temp1:       +40.0=B0C  (crit =3D +120.0=B0C)                 =20

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +60.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C) =20
Core 1:      +58.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C) =20
Core 2:      +58.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C) =20
Core 3:      +66.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C) =20

it8718-isa-0290
Adapter: ISA adapter
in0:         +1.20 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in1:         +3.04 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in2:         +3.31 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
+5V:         +3.04 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in4:         +2.99 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in5:         +0.06 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in6:         +0.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
5VSB:        +2.98 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
Vbat:        +3.17 V
fan1:       1510 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
fan3:       1194 RPM  (min =3D    0 RPM)
temp1:       +87.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
temp2:       +38.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
temp3:       -43.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
cpu0_vid:   +0.000 V

Note /sys/devices/virtual/thermal/thermal_zone0/temp always reports 40000
(I assume this is the temp1 above).

/sys/devices/virtual/thermal shows cooling_device{0,1,2,3,4} and
thermal_zone0.

Changing cpufreq governor settings makes no difference.

CPU info (quad core -- all the same):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 23
model name      : Intel(R) Core(TM)2 Quad  CPU   Q9300  @ 2.50GHz
stepping        : 7
microcode       : 0x705
cpu MHz         : 2498.000
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 4
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm
constant_tsc arch_perfmon pebs bts aperfmperf pni dtes64 monitor ds_cpl
vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 lahf_lm dtherm tpr_shadow
vnmi flexpriority
bogomips        : 4988.03
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:


--===============0596552456494752044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0596552456494752044==--
