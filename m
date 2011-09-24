From: Audio Phile <da_audiophile@yahoo.com>
Date: Sat, 24 Sep 2011 16:07:36 +0000
Subject: Re: [lm-sensors] adjusting /etc/sensors.conf for a dual processor
Message-Id: <1316880456.51717.YahooMailNeo@web36607.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
In-Reply-To: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



> Create file /etc/sensors.d/cores.conf and put the
> following statements in it:
>=20
> chip "coretemp-isa-0000"
>=20
> =A0 =A0 label temp2 "Core 0"
> =A0 =A0 label temp3 "Core 1"
> =A0 =A0 label temp11 "Core 2"
> =A0 =A0 label temp12 "Core 3"
>=20
> chip "coretemp-isa-0004"
>=20
> =A0 =A0 label temp2 "Core 4"
> =A0 =A0 label temp3 "Core 5"
> =A0 =A0 label temp11 "Core 6"
> =A0 =A0 label temp12 "Core 7"

Jean - this is perfect and does exactly what I wanted.=A0 Thank you for tak=
ing the time to provide the solution for me :)

> The original core numbering is very odd to start with. Not the fact
> that core numbers are reused, this is as expected. What's odd is the
> jump from 1 to 9. I seem to remember a similar case being reported a
> few weeks or months ago. Can you attach the contents of /proc/cpuinfo?

Glad to but I don't see anything unusual here... perhaps a bug with lm-sens=
ors?

processor=A0=A0=A0 : 0
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 0
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 0
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 0
initial apicid=A0=A0=A0 : 0
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.57
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 1
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 0
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 1
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 2
initial apicid=A0=A0=A0 : 2
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.21
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 2
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 0
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 9
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 18
initial apicid=A0=A0=A0 : 18
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.20
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 3
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 0
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 10
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 20
initial apicid=A0=A0=A0 : 20
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.20
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 4
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 1
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 0
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 32
initial apicid=A0=A0=A0 : 32
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.24
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 5
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 1
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 1
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 34
initial apicid=A0=A0=A0 : 34
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.24
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 6
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 1
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 9
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 50
initial apicid=A0=A0=A0 : 50
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.25
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 7
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 1
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 10
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 52
initial apicid=A0=A0=A0 : 52
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.24
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 8
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 0
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 0
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 1
initial apicid=A0=A0=A0 : 1
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.23
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 9
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 0
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 1
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 3
initial apicid=A0=A0=A0 : 3
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.25
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 10
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 0
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 9
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 19
initial apicid=A0=A0=A0 : 19
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.25
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 11
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 0
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 10
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 21
initial apicid=A0=A0=A0 : 21
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.26
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 12
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 1
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 0
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 33
initial apicid=A0=A0=A0 : 33
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.24
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 13
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 1
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 1
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 35
initial apicid=A0=A0=A0 : 35
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.24
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 14
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 1
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 9
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 51
initial apicid=A0=A0=A0 : 51
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.24
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:

processor=A0=A0=A0 : 15
vendor_id=A0=A0=A0 : GenuineIntel
cpu family=A0=A0=A0 : 6
model=A0=A0=A0 =A0=A0=A0 : 44
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
620=A0 @ 2.40GHz
stepping=A0=A0=A0 : 2
cpu MHz=A0=A0=A0 =A0=A0=A0 : 2395.000
cache size=A0=A0=A0 : 12288 KB
physical id=A0=A0=A0 : 1
siblings=A0=A0=A0 : 8
core id=A0=A0=A0 =A0=A0=A0 : 10
cpu cores=A0=A0=A0 : 4
apicid=A0=A0=A0 =A0=A0=A0 : 53
initial apicid=A0=A0=A0 : 53
fpu=A0=A0=A0 =A0=A0=A0 : yes
fpu_exception=A0=A0=A0 : yes
cpuid level=A0=A0=A0 : 11
wp=A0=A0=A0 =A0=A0=A0 : yes
flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr=
 pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe sys=
call nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl =
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx sm=
x est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida ara=
t epb dts tpr_shadow vnmi flexpriority ept vpid
bogomips=A0=A0=A0 : 4789.23
clflush size=A0=A0=A0 : 64
cache_alignment=A0=A0=A0 : 64
address sizes=A0=A0=A0 : 40 bits physical, 48 bits virtual
power management:


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
