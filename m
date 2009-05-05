From: Juerg Haefliger <juergh@gmail.com>
Date: Tue, 05 May 2009 04:03:01 +0000
Subject: Re: [lm-sensors] lm-sensor configuration for C7 processor
Message-Id: <191fb4ca0905042103s738b6255k1edcfc87548119d7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Vipul,

We can try to 'calibrate' the vt1211 reading. With an idle system,
read the raw c7 and vt1211 temp values:
cat /sys/devices/platform/vt1211*/temp?_input
cpuid -r (from http://etallen.com/cpuid.html)

Do the same with a busy system running cpuburn or some other stress
program and send the outputs to the list.

...juerg




On Thu, Apr 30, 2009 at 9:49 PM, Vipul Patel <vipul.mca.08@gmail.com> wrote:
> Hi,
>
> Motherbord= Portwell PPAP-2020VL
>
> stress:~ # cat /proc/cpuinfo
> processor       : 0
> vendor_id       : CentaurHauls
> cpu family      : 6
> model           : 13
> model name      : VIA C7 Processor 1500MHz
> stepping        : 0
> cpu MHz         : 798.055
> cache size      : 128 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge cmov
> pat clflush acpi mmx fxsr sse sse2 tm nx up pni est tm2 xtpr rng rng_en ace
> ace_en ace2 ace2_en phe phe_en pmm pmm_en
> bogomips        : 1598.25
> clflush size    : 64
>
>
> stress:/tmp/cpuid-20060917 # ./cpuid
> CPU:
>    vendor_id = "CentaurHauls"
>    version information (1/eax):
>       processor type  = primary processor (0)
>       family          = Intel Pentium Pro/II/III/Celeron, AMD Athlon/Duron,
> Cyrix M2, VIA C3 (6)
>       model           = 0xd (13)
>       stepping id     = 0x0 (0)
>       extended family = 0x0 (0)
>       extended model  = 0x0 (0)
>       (simple synth)  = VIA C3 / C3-M / C7 / C7-M / Eden ESP 7000/8000/10000
> (unknown model)
>    miscellaneous (1/ebx):
>       process local APIC physical ID = 0x0 (0)
>       cpu count                      = 0x0 (0)
>       CLFLUSH line size              = 0x8 (8)
>       brand index                    = 0x0 (0)
>    brand id = 0x00 (0): unknown
>    feature information (1/edx):
>       x87 FPU on chip                        = true
>       virtual-8086 mode enhancement          = true
>       debugging extensions                   = true
>       page size extensions                   = true
>       time stamp counter                     = true
>       RDMSR and WRMSR support                = true
>       physical address extensions            = true
>       machine check exception                = true
>       CMPXCHG8B inst.                        = true
>       APIC on chip                           = true
>       SYSENTER and SYSEXIT                   = true
>       memory type range registers            = true
>       PTE global bit                         = true
>       machine check architecture             = false
>       conditional move/compare instruction   = true
>       page attribute table                   = true
>       page size extension                    = false
>       processor serial number                = false
>       CLFLUSH instruction                    = true
>       debug store                            = false
>       thermal monitor and clock ctrl         = true
>       MMX Technology                         = true
>       FXSAVE/FXRSTOR                         = true
>       SSE extensions                         = true
>       SSE2 extensions                        = true
>       self snoop                             = false
>       hyper-threading / multi-core supported = false
>       therm. monitor                         = true
>       IA64                                   = false
>       pending break event                    = true
>    feature information (1/ecx):
>       PNI/SSE3: Prescott New Instructions    = true
>       MONITOR/MWAIT                          = false
>       CPL-qualified debug store              = false
>       VMX: virtual machine extensions        = false
>       Enhanced Intel SpeedStep Technology    = true
>       thermal monitor 2                      = true
>       context ID: adaptive or shared L1 data = false
>       cmpxchg16b available                   = false
>       xTPR disable                           = true
>    extended processor signature (0x80000001/eax):
>       generation     = 0x0 (0)
>       model          = 0x0 (0)
>       stepping       = 0x0 (0)
>       (simple synth) = unknown
>    extended feature flags (0x80000001/edx):
>       x87 FPU on chip                       = false
>       virtual-8086 mode enhancement         = false
>       debugging extensions                  = false
>       page size extensions                  = false
>       time stamp counter                    = false
>       RDMSR and WRMSR support               = false
>       physical address extensions           = false
>       machine check exception               = false
>       CMPXCHG8B inst.                       = false
>       APIC on chip                          = false
>       SYSCALL and SYSRET instructions       = false
>       memory type range registers           = false
>       global paging extension               = false
>       machine check architecture            = false
>       conditional move/compare instruction  = false
>       page attribute table                  = false
>       page size extension                   = false
>       multiprocessing capable               = false
>       AMD multimedia instruction extensions = false
>       MMX Technology                        = false
>       extended MMX                          = false
>       SSE extensions                        = false
>       AA-64                                 = false
>       3DNow! instruction extensions         = false
>       3DNow! instructions                   = false
>    brand = "                       VIA C7 Processor 1500MHz"
>    L1 TLB/cache information: 2M/4M pages & L1 TLB (0x80000005/eax):
>       instruction # entries     = 0x0 (0)
>       instruction associativity = 0x0 (0)
>       data # entries            = 0x0 (0)
>       data associativity        = 0x0 (0)
>    L1 TLB/cache information: 4K pages & L1 TLB (0x80000005/ebx):
>       instruction # entries     = 0x80 (128)
>       instruction associativity = 0x8 (8)
>       data # entries            = 0x80 (128)
>       data associativity        = 0x8 (8)
>    L1 data cache information (0x80000005/ecx):
>       line size (bytes) = 0x40 (64)
>       lines per tag     = 0x1 (1)
>       associativity     = 0x4 (4)
>       size (Kb)         = 0x40 (64)
>    L1 instruction cache information (0x80000005/ecx):
>       line size (bytes) = 0x40 (64)
>       lines per tag     = 0x1 (1)
>       associativity     = 0x4 (4)
>       size (Kb)         = 0x40 (64)
>    L2 TLB/cache information: 2M/4M pages & L2 TLB (0x80000006/eax):
>       instruction # entries     = 0x0 (0)
>       instruction associativity = L2 off (0)
>       data # entries            = 0x0 (0)
>       data associativity        = L2 off (0)
>    L2 TLB/cache information: 4K pages & L2 TLB (0x80000006/ebx):
>       instruction # entries     = 0x0 (0)
>       instruction associativity = L2 off (0)
>       data # entries            = 0x0 (0)
>       data associativity        = L2 off (0)
>    L2 unified cache information (0x80000006/ecx):
>       line size (bytes) = 0x40 (64)
>       lines per tag     = 0x1 (1)
>       associativity     = 0xa (10)
>       size (Kb)         = 0x80 (128)
>    0xc0000001: eax=0x00000000
>    extended feature flags (0xc0000001/edx):
>       alternate instruction set                 = false
>       alternate instruction set enabled         = false
>       random number generator                   = true
>       random number generator enabled           = true
>       LongHaul MSR 0000_110Ah                   = false
>       FEMMS                                     = false
>       advanced cryptography engine (ACE)        = true
>       advanced cryptography engine (ACE)enabled = true
>    0xc0000002: eax=0x00002200 ebx=0x08000813 ecx=0x08100f13 edx=0x42040000
>    0xc0000003: eax=0xd5f10197 ebx=0x2ac37d7f ecx=0x41967874 edx=0xee6ef6f3
>    (multi-processing synth): none
>    (synth) = VIA C3 / C3-M / C7 / C7-M / Eden ESP 7000/8000/10000 (unknown
> model)
>
>
> stress:/tmp/cpuid-20060917 # ./cpuid -r
> CPU:
>    0x00000000: eax=0x00000001 ebx=0x746e6543 ecx=0x736c7561 edx=0x48727561
>    0x00000001: eax=0x000006d0 ebx=0x00000800 ecx=0x00004181 edx=0xa7c9bbff
>    0x80000000: eax=0x80000006 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
>    0x80000001: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00100000
>    0x80000002: eax=0x20202020 ebx=0x20202020 ecx=0x20202020 edx=0x20202020
>    0x80000003: eax=0x20202020 ebx=0x56202020 ecx=0x43204149 edx=0x72502037
>    0x80000004: eax=0x7365636f ebx=0x20726f73 ecx=0x30303531 edx=0x007a484d
>    0x80000005: eax=0x00000000 ebx=0x08800880 ecx=0x40040140 edx=0x40040140
>    0x80000006: eax=0x00000000 ebx=0x00000000 ecx=0x0080a140 edx=0x00000000
>    0x80860000: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
>    0xc0000000: eax=0xc0000003 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
>    0xc0000001: eax=0x00000000 ebx=0x00000002 ecx=0x00000000 edx=0x0000ffcc
>    0xc0000002: eax=0x00002200 ebx=0x08000813 ecx=0x08100f13 edx=0x42040000
>    0xc0000003: eax=0xd5f10197 ebx=0x2ac37d7f ecx=0x41967874 edx=0xee6ef6f3
>
>
>
> Regards,
> Vipul Patel
>
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
