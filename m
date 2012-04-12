From: Michael Weingartner <michael.weingartner@tuwien.ac.at>
Date: Thu, 12 Apr 2012 14:43:58 +0000
Subject: [lm-sensors] Tempoutput changed
Message-Id: <20120412164358.11904yfhv5a44ai6@webmail.tuwien.ac.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dear Ladies and Gentlemen,

I have a Asus kfn4-dre mainboard. Ubuntu 8.04 was installed. =20
lm-sensors showed k8temp for all cores between 50-60 degrees celsius. =20
With load some degrees more, without load approximately 50 degrees.

I have done an upgrade to 10.04. I ran sensors-detect and now i have:
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +43.0=B0C
Core1 Temp:  +41.0=B0C

k8temp-pci-00cb
Adapter: PCI adapter
Core0 Temp:  +47.0=B0C
Core1 Temp:  +49.0=B0C

Version:
sensors version 3.1.2 with libsensors version 3.1.2

Kernel Verision:
2.6.35-32-generic-pae

/proc/cpu:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 65
model name	: Dual-Core AMD Opteron(tm) Processor 2212
stepping	: 2
cpu MHz		: 2000.000
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =20
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =20
rdtscp lm 3dnowext 3dnow extd_apicid pni cx16 lahf_lm cmp_legacy svm =20
extapic cr8_legacy
bogomips	: 4020.89
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 65
model name	: Dual-Core AMD Opteron(tm) Processor 2212
stepping	: 2
cpu MHz		: 2000.000
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =20
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =20
rdtscp lm 3dnowext 3dnow extd_apicid pni cx16 lahf_lm cmp_legacy svm =20
extapic cr8_legacy
bogomips	: 4020.89
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

processor	: 2
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 65
model name	: Dual-Core AMD Opteron(tm) Processor 2212
stepping	: 2
cpu MHz		: 2000.000
cache size	: 1024 KB
physical id	: 1
siblings	: 2
core id		: 0
cpu cores	: 2
apicid		: 2
initial apicid	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =20
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =20
rdtscp lm 3dnowext 3dnow extd_apicid pni cx16 lahf_lm cmp_legacy svm =20
extapic cr8_legacy
bogomips	: 4020.89
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

processor	: 3
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 65
model name	: Dual-Core AMD Opteron(tm) Processor 2212
stepping	: 2
cpu MHz		: 2000.000
cache size	: 1024 KB
physical id	: 1
siblings	: 2
core id		: 1
cpu cores	: 2
apicid		: 3
initial apicid	: 3
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =20
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt =20
rdtscp lm 3dnowext 3dnow extd_apicid pni cx16 lahf_lm cmp_legacy svm =20
extapic cr8_legacy
bogomips	: 4020.89
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc




Thanks with kind regards
mike


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
