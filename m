From: Rob Coward <rob@jive-videos.net>
Date: Mon, 07 Jul 2008 09:52:34 +0000
Subject: Re: [lm-sensors] AMD K10 Driver progress
Message-Id: <20080707105234.yhmvslubk0o0sksg@www.jive-videos.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6530306679100894539=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4870E7C0.8030900@jive-videos.net>
In-Reply-To: <4870E7C0.8030900@jive-videos.net>
To: lm-sensors@vger.kernel.org

This message is in MIME format.

--===============6530306679100894539==
Content-Type: multipart/alternative;
	boundary="=_2w2olnjl42o0"
Content-Transfer-Encoding: 7bit

This message is in MIME format.

--=_2w2olnjl42o0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Description: Plaintext Version of Message
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



   Thanks again Rudolf.

   I tried the rhel5 rpm, and also compiled my own from the srpm, but =20
both are currently dying with a Segfault. I'll try debugging later =20
this evening when I have more time. Anyway, output prior to the crash =20
is below.

   Regards,

   Rob

   Quoting Rudolf Marek <r.marek@assembler.cz>:

> Hello,
>
>> Output of /proc/cpuinfo below. By 'cpuid utility', do you mean the=A0 =20
>> CPU-Z app from www.cpuid.com ? Unfortunatly the box is a linux=A0 =20
>> install without any windows in sight and that looks to be a =20
>> windows=A0 only app. If you were meaning a linux utility, my =20
>> appologies, and=A0 please do point me in the right direction and I'll =20
>> happily take a=A0 look.
>
> Of course Linux one ;)
>
> http://www.etallen.com/cpuid.html
>
> There might be some package for your distro. Should be named "cpuid".
> Or you can try x86info utillity=A0 with -r as parameter.
>
> Thanks,
> Rudolf
# cpuid

CPU:
=A0=A0 vendor_id =3D "AuthenticAMD"
=A0=A0 version information (1/eax):
=A0=A0=A0=A0=A0 processor type=A0 =3D primary processor (0)
=A0=A0=A0=A0=A0 family=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D Intel Pentium 4/Pentiu=
m D/Pentium Extreme =20
Edition/Celeron/Xeon/Xeon MP/Itanium2, AMD Athlon 64/Athlon =20
XP-M/Opteron/Sempron/Turion (15)
=A0=A0=A0=A0=A0 model=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0x2 (2)
=A0=A0=A0=A0=A0 stepping id=A0=A0=A0=A0 =3D 0x3 (3)
=A0=A0=A0=A0=A0 extended family =3D 0x1 (1)
=A0=A0=A0=A0=A0 extended model=A0 =3D 0x0 (0)
=A0=A0=A0=A0=A0 (simple synth)=A0 =3D unknown
=A0=A0 miscellaneous (1/ebx):
=A0=A0=A0=A0=A0 process local APIC physical ID =3D 0x3 (3)
=A0=A0=A0=A0=A0 cpu count=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D 0x4 (4)
=A0=A0=A0=A0=A0 CLFLUSH line size=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=
 0x8 (8)
=A0=A0=A0=A0=A0 brand index=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D 0x0 (0)
=A0=A0 brand id =3D 0x00 (0): unknown
=A0=A0 feature information (1/edx):
=A0=A0=A0=A0=A0 x87 FPU on chip=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 virtual-8086 mode enhancement=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=
 true
=A0=A0=A0=A0=A0 debugging extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 page size extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 time stamp counter=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 RDMSR and WRMSR support=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 physical address extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 =3D true
=A0=A0=A0=A0=A0 machine check exception=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 CMPXCHG8B inst.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 APIC on chip=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 SYSENTER and SYSEXIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 memory type range registers=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 =3D true
=A0=A0=A0=A0=A0 PTE global bit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 machine check architecture=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D true
=A0=A0=A0=A0=A0 conditional move/compare instruction=A0=A0 =3D true
=A0=A0=A0=A0=A0 page attribute table=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 page size extension=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 processor serial number=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D false
=A0=A0=A0=A0=A0 CLFLUSH instruction=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 debug store=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D false
=A0=A0=A0=A0=A0 thermal monitor and clock ctrl=A0=A0=A0=A0=A0=A0=A0=A0 =3D f=
alse
=A0=A0=A0=A0=A0 MMX Technology=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 FXSAVE/FXRSTOR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 SSE extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 SSE2 extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 self snoop=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D false
=A0=A0=A0=A0=A0 hyper-threading / multi-core supported =3D true
=A0=A0=A0=A0=A0 therm. monitor=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D false
=A0=A0=A0=A0=A0 IA64=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D false
=A0=A0=A0=A0=A0 pending break event=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D false
=A0=A0 feature information (1/ecx):
=A0=A0=A0=A0=A0 PNI/SSE3: Prescott New Instructions=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 MONITOR/MWAIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 CPL-qualified debug store=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D false
=A0=A0=A0=A0=A0 VMX: virtual machine extensions=A0=A0=A0=A0=A0=A0=A0 =3D fal=
se
=A0=A0=A0=A0=A0 Enhanced Intel SpeedStep Technology=A0=A0=A0 =3D false
=A0=A0=A0=A0=A0 thermal monitor 2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =3D false
=A0=A0=A0=A0=A0 context ID: adaptive or shared L1 data =3D false
=A0=A0=A0=A0=A0 cmpxchg16b available=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 xTPR disable=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D false
=A0=A0 cache and TLB information (2):
=A0=A0 processor serial number: 0010-0F23-0000-0000-0000-0000
=A0=A0 deterministic cache parameters (4):
=A0=A0=A0=A0=A0 cache type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =3D no more caches (0)
=A0=A0=A0=A0=A0 cache level=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D 0x0 (0)
=A0=A0=A0=A0=A0 self-initializing cache level=A0=A0=A0=A0 =3D false
=A0=A0=A0=A0=A0 fully associative cache=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D fa=
lse
=A0=A0=A0=A0=A0 extra threads sharing this cache=A0 =3D 0x0 (0)
=A0=A0=A0=A0=A0 extra processor cores on this die =3D 0x0 (0)
=A0=A0=A0=A0=A0 system coherency line size=A0=A0=A0=A0=A0=A0=A0 =3D 0x0 (0)
=A0=A0=A0=A0=A0 physical line partitions=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0x0 =
(0)
=A0=A0=A0=A0=A0 ways of associativity=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D 0x0 (0)
=A0=A0=A0=A0=A0 number of sets - 1 (s)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
0
=A0=A0 MONITOR/MWAIT (5):
=A0=A0=A0=A0=A0 smallest monitor-line size (bytes)=A0=A0=A0=A0=A0 =3D 0x40 (=
64)
=A0=A0=A0=A0=A0 largest monitor-line size (bytes)=A0=A0=A0=A0=A0=A0 =3D 0x40=
 (64)
=A0=A0=A0=A0=A0 enum of Monitor-MWAIT exts supported=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 supports intrs as break-event for MWAIT =3D true
=A0=A0=A0=A0=A0 number of C0 sub C-states using MWAIT=A0=A0 =3D 0x0 (0)
=A0=A0=A0=A0=A0 number of C1 sub C-states using MWAIT=A0=A0 =3D 0x0 (0)
=A0=A0=A0=A0=A0 number of C2 sub C-states using MWAIT=A0=A0 =3D 0x0 (0)
=A0=A0=A0=A0=A0 number of C3 sub C-states using MWAIT=A0=A0 =3D 0x0 (0)
=A0=A0=A0=A0=A0 number of C4 sub C-states using MWAIT=A0=A0 =3D 0x0 (0)
=A0=A0 extended processor signature (0x80000001/eax):
=A0=A0=A0=A0=A0 generation=A0=A0=A0=A0 =3D AMD Athlon 64/Opteron/Sempron/Tur=
ion (15)
=A0=A0=A0=A0=A0 model=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0x2 (2)
=A0=A0=A0=A0=A0 stepping=A0=A0=A0=A0=A0=A0 =3D 0x3 (3)
=A0=A0=A0=A0=A0 (simple synth) =3D unknown
=A0=A0 extended feature flags (0x80000001/edx):
=A0=A0=A0=A0=A0 x87 FPU on chip=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 virtual-8086 mode enhancement=A0=A0=A0=A0=A0=A0=A0=A0 =3D tr=
ue
=A0=A0=A0=A0=A0 debugging extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 page size extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 time stamp counter=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 RDMSR and WRMSR support=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D true
=A0=A0=A0=A0=A0 physical address extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D true
=A0=A0=A0=A0=A0 machine check exception=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D true
=A0=A0=A0=A0=A0 CMPXCHG8B inst.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 APIC on chip=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 SYSCALL and SYSRET instructions=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 memory type range registers=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D true
=A0=A0=A0=A0=A0 global paging extension=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D true
=A0=A0=A0=A0=A0 machine check architecture=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D true
=A0=A0=A0=A0=A0 conditional move/compare instruction=A0 =3D true
=A0=A0=A0=A0=A0 page attribute table=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 page size extension=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 multiprocessing capable=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D false
=A0=A0=A0=A0=A0 no-execute page protection=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=3D true
=A0=A0=A0=A0=A0 AMD multimedia instruction extensions =3D true
=A0=A0=A0=A0=A0 MMX Technology=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 FXSAVE/FXRSTOR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 SSE extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 RDTSCP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 long mode (AA-64)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D true
=A0=A0=A0=A0=A0 3DNow! instruction extensions=A0=A0=A0=A0=A0=A0=A0=A0 =3D tr=
ue
=A0=A0=A0=A0=A0 3DNow! instructions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D true
=A0=A0 extended brand id =3D 0x613 (1555):
Segmentation fault




--=_2w2olnjl42o0
Content-Type: text/html;
	charset=ISO-8859-1
Content-Description: HTML Version of Message
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

<p>Thanks again Rudolf.</p><p>I tried the rhel5 rpm, and also compiled my ow=
n
from the srpm, but both are currently dying with a Segfault. I'll try debugg=
ing
later this evening when I have more time. Anyway, output prior to the crash =
is
below.</p><p></p><p>Regards,</p><p>Rob</p><p></p><p>
Quoting Rudolf Marek &lt;r.marek@assembler.cz&gt;:<br />
<br />
&gt; Hello,<br />
&gt;<br />
&gt;&gt; Output of /proc/cpuinfo below. By 'cpuid utility', do you mean the=
=A0 <br
/>
&gt;&gt; CPU-Z app from www.cpuid.com ? Unfortunatly the box is a linux=A0 <=
br />
&gt;&gt; install without any windows in sight and that looks to be a windows=
=A0
<br />
&gt;&gt; only app. If you were meaning a linux utility, my appologies, and=
=A0 <br
/>
&gt;&gt; please do point me in the right direction and I'll happily take a=
=A0 <br
/>
&gt;&gt; look.<br />
&gt;<br />
&gt; Of course Linux one ;)<br />
&gt;<br />
&gt; <a target=3D"_blank"
href=3D"http://www.etallen.com/cpuid.html">http://www.etallen.com/cpuid.html=
</a><br
/>
&gt;<br />
&gt; There might be some package for your distro. Should be named
&quot;cpuid&quot;.<br />
&gt; Or you can try x86info utillity=A0 with -r as parameter.<br />
&gt;<br />
&gt; Thanks,<br />
&gt; Rudolf<br />
# cpuid</p><p> <br /><font size=3D"1" face=3D"courier new,courier,monospace"=
>CPU:<br
/>=A0=A0 vendor_id =3D &quot;AuthenticAMD&quot;<br />=A0=A0 version informat=
ion
(1/eax):<br />=A0=A0=A0=A0=A0 processor type=A0 =3D primary processor (0)<br=
 />=A0=A0=A0=A0=A0
family=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D Intel Pentium 4/Pentium D/Pentium Extr=
eme
Edition/Celeron/Xeon/Xeon MP/Itanium2, AMD Athlon 64/Athlon
XP-M/Opteron/Sempron/Turion (15)<br />=A0=A0=A0=A0=A0 model=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D 0x2 (2)<br />=A0=A0=A0=A0=A0
stepping id=A0=A0=A0=A0 =3D 0x3 (3)<br />=A0=A0=A0=A0=A0 extended family =3D=
 0x1 (1)<br />=A0=A0=A0=A0=A0
extended model=A0 =3D 0x0 (0)<br />=A0=A0=A0=A0=A0 (simple synth)=A0 =3D unk=
nown<br />=A0=A0
miscellaneous (1/ebx):<br />=A0=A0=A0=A0=A0 process local APIC physical ID =
=3D 0x3 (3)<br
/>=A0=A0=A0=A0=A0 cpu count=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D 0x4 (4)<br />=A0=A0=A0=A0=A0 CLFLUSH line
size=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0x8 (8)<br />=A0=A0=A0=A0=A0=
 brand index=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0x=
0
(0)<br />=A0=A0 brand id =3D 0x00 (0): unknown<br />=A0=A0 feature informati=
on (1/edx):<br
/>=A0=A0=A0=A0=A0 x87 FPU on chip=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 virtual-8086
mode enhancement=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 de=
bugging
extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br=
 />=A0=A0=A0=A0=A0 page size
extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br=
 />=A0=A0=A0=A0=A0 time stamp
counter=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true=
<br />=A0=A0=A0=A0=A0 RDMSR and WRMSR
support=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=
=A0=A0 physical address extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
=3D true<br />=A0=A0=A0=A0=A0 machine check exception=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0
CMPXCHG8B inst.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 APIC on
chip=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 SYSENTER and
SYSEXIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=
=A0=A0=A0=A0=A0 memory type range
registers=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 PTE=
 global bit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D
true<br />=A0=A0=A0=A0=A0 machine check architecture=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0
conditional move/compare instruction=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 pag=
e attribute
table=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=
=A0=A0=A0=A0=A0 page size extension=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0
=3D true<br />=A0=A0=A0=A0=A0 processor serial number=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D false<br />=A0=A0=A0=A0=A0
CLFLUSH instruction=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 =3D true<br />=A0=A0=A0=A0=A0 debug
store=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D false<br />=A0=A0=A0=A0=A0 thermal monitor and clock
ctrl=A0=A0=A0=A0=A0=A0=A0=A0 =3D false<br />=A0=A0=A0=A0=A0 MMX Technology=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=
 true<br
/>=A0=A0=A0=A0=A0 FXSAVE/FXRSTOR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 SSE
extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 SSE2
extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D true<br />=A0=A0=A0=A0=A0 self
snoop=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D false<br />=A0=A0=A0=A0=A0 hyper-threading /
multi-core supported =3D true<br />=A0=A0=A0=A0=A0 therm. monitor=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D
false<br />=A0=A0=A0=A0=A0 IA64=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D false<br />=A0=
=A0=A0=A0=A0
pending break event=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 =3D false<br />=A0=A0 feature information
(1/ecx):<br />=A0=A0=A0=A0=A0 PNI/SSE3: Prescott New Instructions=A0=A0=A0 =
=3D true<br />=A0=A0=A0=A0=A0
MONITOR/MWAIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 CPL-qualified debug
store=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D false<br />=A0=A0=A0=A0=A0 =
VMX: virtual machine extensions=A0=A0=A0=A0=A0=A0=A0 =3D
false<br />=A0=A0=A0=A0=A0 Enhanced Intel SpeedStep Technology=A0=A0=A0 =3D =
false<br />=A0=A0=A0=A0=A0
thermal monitor 2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D false<br />=A0=A0=A0=A0=A0 context ID: adaptive
or shared L1 data =3D false<br />=A0=A0=A0=A0=A0 cmpxchg16b available=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D
true<br />=A0=A0=A0=A0=A0 xTPR disable=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D false<br />=A0=A0 cache and
TLB information (2):<br />=A0=A0 processor serial number:
0010-0F23-0000-0000-0000-0000<br />=A0=A0 deterministic cache parameters (4)=
:<br
/>=A0=A0=A0=A0=A0 cache type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =3D no more caches (0)<br />=A0=A0=A0=A0=A0 cache
level=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
0x0 (0)<br />=A0=A0=A0=A0=A0 self-initializing cache
level=A0=A0=A0=A0 =3D false<br />=A0=A0=A0=A0=A0 fully associative cache=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D false<br
/>=A0=A0=A0=A0=A0 extra threads sharing this cache=A0 =3D 0x0 (0)<br />=A0=
=A0=A0=A0=A0 extra processor
cores on this die =3D 0x0 (0)<br />=A0=A0=A0=A0=A0 system coherency line siz=
e=A0=A0=A0=A0=A0=A0=A0 =3D 0x0
(0)<br />=A0=A0=A0=A0=A0 physical line partitions=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 =3D 0x0 (0)<br />=A0=A0=A0=A0=A0 ways of
associativity=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0x0 (0)<br />=A0=A0=A0=
=A0=A0 number of sets - 1 (s)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
=3D 0<br />=A0=A0 MONITOR/MWAIT (5):<br />=A0=A0=A0=A0=A0 smallest monitor-l=
ine size
(bytes)=A0=A0=A0=A0=A0 =3D 0x40 (64)<br />=A0=A0=A0=A0=A0 largest monitor-li=
ne size (bytes)=A0=A0=A0=A0=A0=A0 =3D
0x40 (64)<br />=A0=A0=A0=A0=A0 enum of Monitor-MWAIT exts supported=A0=A0=A0=
 =3D true<br />=A0=A0=A0=A0=A0
supports intrs as break-event for MWAIT =3D true<br />=A0=A0=A0=A0=A0 number=
 of C0 sub
C-states using MWAIT=A0=A0 =3D 0x0 (0)<br />=A0=A0=A0=A0=A0 number of C1 sub=
 C-states using
MWAIT=A0=A0 =3D 0x0 (0)<br />=A0=A0=A0=A0=A0 number of C2 sub C-states using=
 MWAIT=A0=A0 =3D 0x0
(0)<br />=A0=A0=A0=A0=A0 number of C3 sub C-states using MWAIT=A0=A0 =3D 0x0=
 (0)<br />=A0=A0=A0=A0=A0
number of C4 sub C-states using MWAIT=A0=A0 =3D 0x0 (0)<br />=A0=A0 extended=
 processor
signature (0x80000001/eax):<br />=A0=A0=A0=A0=A0 generation=A0=A0=A0=A0 =3D =
AMD Athlon
64/Opteron/Sempron/Turion (15)<br />=A0=A0=A0=A0=A0 model=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D 0x2 (2)<br />=A0=A0=A0=A0=A0
stepping=A0=A0=A0=A0=A0=A0 =3D 0x3 (3)<br />=A0=A0=A0=A0=A0 (simple synth) =
=3D unknown<br />=A0=A0 extended
feature flags (0x80000001/edx):<br />=A0=A0=A0=A0=A0 x87 FPU on chip=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
=3D true<br />=A0=A0=A0=A0=A0 virtual-8086 mode enhancement=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0
debugging extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D =
true<br />=A0=A0=A0=A0=A0 page size
extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=
=A0=A0=A0=A0=A0 time stamp
counter=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br=
 />=A0=A0=A0=A0=A0 RDMSR and WRMSR
support=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=
=A0 physical address extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D
true<br />=A0=A0=A0=A0=A0 machine check exception=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0
CMPXCHG8B inst.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 APIC on
chip=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D true<br />=A0=A0=A0=A0=A0 SYSCALL and SYSRET
instructions=A0=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 memory type ran=
ge registers=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D
true<br />=A0=A0=A0=A0=A0 global paging extension=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 machine
check architecture=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=
=A0=A0 conditional move/compare
instruction=A0 =3D true<br />=A0=A0=A0=A0=A0 page attribute table=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br
/>=A0=A0=A0=A0=A0 page size extension=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 multiprocessing
capable=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D false<br />=A0=A0=A0=
=A0=A0 no-execute page protection=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D
true<br />=A0=A0=A0=A0=A0 AMD multimedia instruction extensions =3D true<br =
/>=A0=A0=A0=A0=A0 MMX
Technology=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D true<br />=A0=A0=A0=A0=A0
FXSAVE/FXRSTOR=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 SSE
extensions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D true<br />=A0=A0=A0=A0=A0
RDTSCP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 long mode
(AA-64)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D true=
<br />=A0=A0=A0=A0=A0 3DNow! instruction
extensions=A0=A0=A0=A0=A0=A0=A0=A0 =3D true<br />=A0=A0=A0=A0=A0 3DNow! inst=
ructions=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D
true<br />=A0=A0 extended brand id =3D 0x613 (1555):<br />Segmentation fault=
</font><br
/>
</p><br />
<br />

--=_2w2olnjl42o0--



--===============6530306679100894539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6530306679100894539==--

