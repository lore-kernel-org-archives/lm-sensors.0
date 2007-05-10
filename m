From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Date: Thu, 10 May 2007 23:42:40 +0000
Subject: [lm-sensors] hwmon K8 sensor in processor up to revision E.
Message-Id: <20070511014240.1a5bb02c.miknix@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0415244621461527377=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============0415244621461527377==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_May_2007_01_42_40_+0200_17YAf87eY=jHi8w2"

--Signature=_Fri__11_May_2007_01_42_40_+0200_17YAf87eY=jHi8w2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi all,

I have a AMD Athlon64 3500+ socket 754 and reading cpu temperatures using the k8 sensor is totally useful (thanks Rudolf). My ACPI is buggy and reading CPU temperature from it, is a mess.
More information about my processor:

$cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 4
model name      : AMD Athlon(tm) 64 Processor 3400+
stepping        : 10
cpu MHz         : 800.000
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 1602.36
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

Despite the K8 sensor my ACPI offers me two more sensors.
$cat /proc/acpi/thermal_zone/THRC/temperature
temperature:             55 C
$cat /proc/acpi/thermal_zone/THRS/temperature
temperature:             47 C

Since reading cpu temperature through acpi causes a lot of interrupts. It's near impossible to get a working system with ACPI temperature readouts with high sampling rates (lost ticks).

$cat /proc/acpi/thermal_zone/THRC/temperature && cat /sys/class/hwmon/
hwmon0/device/temp1_input
temperature:             55 C
30000

I readed that:
"Temperature known as TCaseMax was specified for processors up to revision E.
This temperature is defined as temperature between heat-spreader and CPU
case, so the internal CPU temperature supplied by this driver can be higher.
There is no easy way how to measure the temperature which will correlate
with TCaseMax temperature."

So I logged some ACPI VS K8Sensor:
"ACPI","K8"
51,28
52,28
53,28
54,29
55,29
56,30
57,30
58,31
59,32
60,30
61,35
62,35
63,38
64,33
65,35
66,39
68,38
73,48
74,42
75,43
76,43
77,46
78,44
79,44
80,46
81,48
82,48
83,48
84,49
85,50
86,51

It looks like the CPU temperature is more or less twice the K8 sensor temperature (?in my system?).

Thanks all
--
MiKNiX
miknix@gmail.com
http://miknix.homelinux.com

--Signature=_Fri__11_May_2007_01_42_40_+0200_17YAf87eY=jHi8w2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFGQ630NahyoD2SuwsRAuR/AKCoi6sKO18JRObgAQZyqnwLggNCMgCeOELB
hkMiqMc6YnWdJ6Tz8VFMM8I=
=ooA+
-----END PGP SIGNATURE-----

--Signature=_Fri__11_May_2007_01_42_40_+0200_17YAf87eY=jHi8w2--


--===============0415244621461527377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0415244621461527377==--
