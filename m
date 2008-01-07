From: Ulf =?iso-8859-1?q?Bartholom=E4us?= <ulfbart@gmx.de>
Date: Mon, 07 Jan 2008 08:23:14 +0000
Subject: [lm-sensors] k8temp, BE-2300 CPU
Message-Id: <200801070923.18133.ulfbart@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I've seen the email thread "k8temp, BE-2350 CPU" from begin of Sep. 2007. I=
n=20
this was discussed that the output of sensors (with k8temp module) is wrong=
:=20
<http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021128.htm=
l>

On my PC is the same wrong output with a BE-2300 CPU. Is this known or only=
=20
the bug in the named BE-2350?

The ticket #2278 - "k8temp shows wrong temperature" - details:
<http://www.lm-sensors.org/ticket/2278>

I use a MSI K9AG Neo2 Digital Mainboard with Firmware Version 1.5 - details:
<http://global.msi.com.tw/index.php?func=3Dproddesc&prod_no=1241&maincat_no=
=3D1&cat2_no=171>

I use the package "sensors" Version 2.10.4-23 (x86_64) with build date: Sa =
22=20
Sep 2007 02:50:23 CEST - from the OpenSUSE 10.3 repository:
<http://download.opensuse.org/repositories/openSUSE:10.3/standard/>

# sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
              +4=B0C
Core0 Temp:
              -1=B0C
Core1 Temp:
              -2=B0C
Core1 Temp:
             -20=B0C


# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 107
model name      : AMD Athlon(tm) X2 Dual Core Processor BE-2300
stepping        : 2
cpu MHz         : 1000.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =

cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdts=
cp=20
lm 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy=20
misalignsse
bogomips        : 2067.29
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps

processor       : 1
[... the same - but "core id : 1" ...]


--=20
Ciao Ulf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
