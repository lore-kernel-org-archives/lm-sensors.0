From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 29 Sep 2008 14:50:02 +0000
Subject: Re: [lm-sensors] Fwd: Re: Fwd: Re: c7temp module for lm-sensors
Message-Id: <191fb4ca0809290750u1016d21bv267d1a1dea4a5e9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0809062210i10fa6f47nb8fa43f2a6cda2e0@mail.gmail.com>
In-Reply-To: <191fb4ca0809062210i10fa6f47nb8fa43f2a6cda2e0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Justin,

Sorry for the late reply.

The temp value is returned in the EAX register (0xC000002) but in your
case it's all zero. I don't know why that is. I also noticed, that
your CPU has a 0xC000003 perf register whereas my datasheet only
defines perf registers up to 0xC0000002. I'll try to get a newer
datasheet from VIA, maybe something changed.

There's nothing more I can do at the moment, sorry.

...juerg


On Wed, Sep 10, 2008 at 10:29 AM, Justin Chudgar <justin@justinzane.com> wr=
ote:
> Summary: sensors with the c7temp module loaded on an HP MiniNote 2133 wit=
h a
> VIA C7 running Kubuntu Hardy 2.6.24-19-generic show the CPU voltage but
> always shows "0" for the temperature.
>
> Here is the output from uname, sensors, cpuid, cpuid -r, lspci:
>
> Linux justin-mininote 2.6.24-19-generic #1 SMP Wed Aug 20 22:56:21 UTC 20=
08
> i686 GNU/Linux
>
> -------------
>
> c7temp-isa-0000
>
> Adapter: ISA adapter
>
> in0: +0.80 V
>
> temp1: +0.0=C2=B0C
>
> -------------
>
> CPU:
>
> vendor_id =3D "CentaurHauls"
>
> version information (1/eax):
>
> processor type =3D primary processor (0)
>
> family =3D Intel Pentium Pro/II/III/Celeron, AMD Athlon/Duron, Cyrix M2, =
VIA
> C3 (6)
>
> model =3D 0xd (13)
>
> stepping id =3D 0x0 (0)
>
> extended family =3D 0x0 (0)
>
> extended model =3D 0x0 (0)
>
> (simple synth) =3D VIA C3 / C3-M / C7 / C7-M / Eden ESP 7000/8000/10000
> (unknown model)
>
> miscellaneous (1/ebx):
>
> process local APIC physical ID =3D 0x0 (0)
>
> cpu count =3D 0x0 (0)
>
> CLFLUSH line size =3D 0x8 (8)
>
> brand index =3D 0x0 (0)
>
> brand id =3D 0x00 (0): unknown
>
> feature information (1/edx):
>
> x87 FPU on chip =3D true
>
> virtual-8086 mode enhancement =3D true
>
> debugging extensions =3D true
>
> page size extensions =3D true
>
> time stamp counter =3D true
>
> RDMSR and WRMSR support =3D true
>
> physical address extensions =3D true
>
> machine check exception =3D true
>
> CMPXCHG8B inst. =3D true
>
> APIC on chip =3D true
>
> SYSENTER and SYSEXIT =3D true
>
> memory type range registers =3D true
>
> PTE global bit =3D true
>
> machine check architecture =3D false
>
> conditional move/compare instruction =3D true
>
> page attribute table =3D true
>
> page size extension =3D false
>
> processor serial number =3D false
>
> CLFLUSH instruction =3D true
>
> debug store =3D false
>
> thermal monitor and clock ctrl =3D true
>
> MMX Technology =3D true
>
> FXSAVE/FXRSTOR =3D true
>
> SSE extensions =3D true
>
> SSE2 extensions =3D true
>
> self snoop =3D false
>
> hyper-threading / multi-core supported =3D false
>
> therm. monitor =3D true
>
> IA64 =3D false
>
> pending break event =3D true
>
> feature information (1/ecx):
>
> PNI/SSE3: Prescott New Instructions =3D true
>
> MONITOR/MWAIT =3D false
>
> CPL-qualified debug store =3D false
>
> VMX: virtual machine extensions =3D false
>
> Enhanced Intel SpeedStep Technology =3D true
>
> thermal monitor 2 =3D true
>
> context ID: adaptive or shared L1 data =3D false
>
> cmpxchg16b available =3D false
>
> xTPR disable =3D true
>
> extended processor signature (0x80000001/eax):
>
> generation =3D 0x0 (0)
>
> model =3D 0x0 (0)
>
> stepping =3D 0x0 (0)
>
> (simple synth) =3D unknown
>
> extended feature flags (0x80000001/edx):
>
> x87 FPU on chip =3D false
>
> virtual-8086 mode enhancement =3D false
>
> debugging extensions =3D false
>
> page size extensions =3D false
>
> time stamp counter =3D false
>
> RDMSR and WRMSR support =3D false
>
> physical address extensions =3D false
>
> machine check exception =3D false
>
> CMPXCHG8B inst. =3D false
>
> APIC on chip =3D false
>
> SYSCALL and SYSRET instructions =3D false
>
> memory type range registers =3D false
>
> global paging extension =3D false
>
> machine check architecture =3D false
>
> conditional move/compare instruction =3D false
>
> page attribute table =3D false
>
> page size extension =3D false
>
> multiprocessing capable =3D false
>
> AMD multimedia instruction extensions =3D false
>
> MMX Technology =3D false
>
> extended MMX =3D false
>
> SSE extensions =3D false
>
> AA-64 =3D false
>
> 3DNow! instruction extensions =3D false
>
> 3DNow! instructions =3D false
>
> brand =3D " VIA C7-M Processor 1200MHz"
>
> L1 TLB/cache information: 2M/4M pages & L1 TLB (0x80000005/eax):
>
> instruction # entries =3D 0x0 (0)
>
> instruction associativity =3D 0x0 (0)
>
> data # entries =3D 0x0 (0)
>
> data associativity =3D 0x0 (0)
>
> L1 TLB/cache information: 4K pages & L1 TLB (0x80000005/ebx):
>
> instruction # entries =3D 0x80 (128)
>
> instruction associativity =3D 0x8 (8)
>
> data # entries =3D 0x80 (128)
>
> data associativity =3D 0x8 (8)
>
> L1 data cache information (0x80000005/ecx):
>
> line size (bytes) =3D 0x40 (64)
>
> lines per tag =3D 0x1 (1)
>
> associativity =3D 0x4 (4)
>
> size (Kb) =3D 0x40 (64)
>
> L1 instruction cache information (0x80000005/ecx):
>
> line size (bytes) =3D 0x40 (64)
>
> lines per tag =3D 0x1 (1)
>
> associativity =3D 0x4 (4)
>
> size (Kb) =3D 0x40 (64)
>
> L2 TLB/cache information: 2M/4M pages & L2 TLB (0x80000006/eax):
>
> instruction # entries =3D 0x0 (0)
>
> instruction associativity =3D L2 off (0)
>
> data # entries =3D 0x0 (0)
>
> data associativity =3D L2 off (0)
>
> L2 TLB/cache information: 4K pages & L2 TLB (0x80000006/ebx):
>
> instruction # entries =3D 0x0 (0)
>
> instruction associativity =3D L2 off (0)
>
> data # entries =3D 0x0 (0)
>
> data associativity =3D L2 off (0)
>
> L2 unified cache information (0x80000006/ecx):
>
> line size (bytes) =3D 0x40 (64)
>
> lines per tag =3D 0x1 (1)
>
> associativity =3D 0xa (10)
>
> size (Kb) =3D 0x80 (128)
>
> 0xc0000001: eax=3D0x00000000
>
> extended feature flags (0xc0000001/edx):
>
> alternate instruction set =3D false
>
> alternate instruction set enabled =3D false
>
> random number generator =3D true
>
> random number generator enabled =3D true
>
> LongHaul MSR 0000_110Ah =3D false
>
> FEMMS =3D false
>
> advanced cryptography engine (ACE) =3D true
>
> advanced cryptography engine (ACE)enabled =3D true
>
> 0xc0000002: eax=3D0x00000000 ebx=3D0x04000406 ecx=3D0x04060609 edx=3D0x41=
080000
>
> 0xc0000003: eax=3D0xfc1deab2 ebx=3D0xc220bebf ecx=3D0xd40711db edx=3D0xe9=
cfcd6a
>
> (multi-processing synth): none
>
> (synth) =3D VIA C3 / C3-M / C7 / C7-M / Eden ESP 7000/8000/10000 (unknown
> model)
>
> -------------
>
> CPU:
>
> 0x00000000: eax=3D0x00000001 ebx=3D0x746e6543 ecx=3D0x736c7561 edx=3D0x48=
727561
>
> 0x00000001: eax=3D0x000006d0 ebx=3D0x00000800 ecx=3D0x00004181 edx=3D0xa7=
c9bbff
>
> 0x80000000: eax=3D0x80000006 ebx=3D0x00000000 ecx=3D0x00000000 edx=3D0x00=
000000
>
> 0x80000001: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=3D0x00=
100000
>
> 0x80000002: eax=3D0x20202020 ebx=3D0x20202020 ecx=3D0x20202020 edx=3D0x20=
202020
>
> 0x80000003: eax=3D0x20202020 ebx=3D0x41495620 ecx=3D0x2d374320 edx=3D0x72=
50204d
>
> 0x80000004: eax=3D0x7365636f ebx=3D0x20726f73 ecx=3D0x30303231 edx=3D0x00=
7a484d
>
> 0x80000005: eax=3D0x00000000 ebx=3D0x08800880 ecx=3D0x40040140 edx=3D0x40=
040140
>
> 0x80000006: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x0080a140 edx=3D0x00=
000000
>
> 0x80860000: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=3D0x00=
000000
>
> 0xc0000000: eax=3D0xc0000003 ebx=3D0x00000000 ecx=3D0x00000000 edx=3D0x00=
000000
>
> 0xc0000001: eax=3D0x00000000 ebx=3D0x00000001 ecx=3D0x00000000 edx=3D0x00=
00ffcc
>
> 0xc0000002: eax=3D0x00000000 ebx=3D0x04000406 ecx=3D0x04060609 edx=3D0x41=
080000
>
> 0xc0000003: eax=3D0xfc1deab2 ebx=3D0xc220bebf ecx=3D0xd40711db edx=3D0xe9=
cfcd6a
>
> -------------
>
> 00:00.0 Host bridge: VIA Technologies, Inc. P4M900 Host Bridge
>
> 00:00.1 Host bridge: VIA Technologies, Inc. P4M900 Host Bridge
>
> 00:00.2 Host bridge: VIA Technologies, Inc. P4M900 Host Bridge
>
> 00:00.3 Host bridge: VIA Technologies, Inc. P4M900 Host Bridge
>
> 00:00.4 Host bridge: VIA Technologies, Inc. P4M900 Host Bridge
>
> 00:00.5 PIC: VIA Technologies, Inc. P4M900 I/O APIC Interrupt Controller
>
> 00:00.6 Host bridge: VIA Technologies, Inc. P4M900 Security Device
>
> 00:00.7 Host bridge: VIA Technologies, Inc. P4M900 Host Bridge
>
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
>
> 00:02.0 PCI bridge: VIA Technologies, Inc. P4M900 PCI to PCI Bridge
> Controller (rev 80)
>
> 00:03.0 PCI bridge: VIA Technologies, Inc. P4M900 PCI to PCI Bridge
> Controller (rev 80)
>
> 00:0f.0 IDE interface: VIA Technologies, Inc. Unknown device 5372
>
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev b0)
>
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev b0)
>
> 00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev b0)
>
> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 90)
>
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237S PCI to ISA Bridge
>
> 00:11.7 Host bridge: VIA Technologies, Inc. VT8251 Ultra VLINK Controller
>
> 00:13.0 Host bridge: VIA Technologies, Inc. VT8237A Host Bridge
>
> 00:13.1 PCI bridge: VIA Technologies, Inc. VT8237A PCI to PCI Bridge
>
> 01:00.0 VGA compatible controller: VIA Technologies, Inc. Chrome9 HC IGP
> (rev 01)
>
> 02:00.0 Network controller: Broadcom Corporation BCM4312 802.11a/b/g (rev
> 02)
>
> 07:03.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788 Gigab=
it
> Ethernet (rev 03)
>
> 80:01.0 Audio device: VIA Technologies, Inc. VIA High Definition Audio
> Controller (rev 10)
>
> --
>
> ________________________________
>
> Justin Chudgar
>
> IT Consultant
>
> 5040 Saddlehorn Rd, Weed, CA 96094
>
> ________________________________
>
>
> ---------- Forwarded message ----------
> From: "Juerg Haefliger" <juergh@gmail.com>
> To: "Justin Chudgar" <justin@justinzane.com>
> Date: Fri, 5 Sep 2008 13:29:49 -0700
> Subject: Re: [lm-sensors] Fwd: Re: c7temp module for lm-sensors
> Justin,
>
> Can you compile and run cpuid from http://www.etallen.com/cpuid.html?
> Please run it with and without the '-r' option and send the output to the
> list.
>
> Thanks
> ...juerg
>
>
> On Sat, Aug 30, 2008 at 5:03 PM, Justin Chudgar <justin@justinzane.com>
> wrote:
>>
>> --
>>
>> ________________________________
>>
>> Justin Chudgar
>>
>> IT Consultant
>>
>> 5040 Saddlehorn Rd, Weed, CA 96094
>>
>> ________________________________
>>
>> ---------- Forwarded message ----------
>> From: Hans de Goede <j.w.r.degoede@hhs.nl>
>> To: Justin Chudgar <justin@justinzane.com>
>> Date: Sat, 30 Aug 2008 08:11:47 +0200
>> Subject: Re: c7temp module for lm-sensors
>> Justin Chudgar wrote:
>>>
>>> Dear Hans:
>>>
>>> I am using this module on an HP Mini-note 2133 running Kubuntu 8.04.1 w/
>>> 2.6.24.19. I get a voltage reading but no temperature. I would like to
>>> help
>>> determine what is not working; but, I am unable to do so without
>>> assistance.
>>>
>>> Could you kindly direct me to the right resources. Thanks.
>>>
>>> Justin Chudgar
>>>
>>>
>>
>> Dear Justin,
>>
>> I'm not the maintainer of the c7temp driver, please send a mail to the
>> lm_sensors list.
>>
>> Regards,
>>
>> Hans
>>
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
