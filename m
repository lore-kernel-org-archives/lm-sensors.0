From: Wilken Gottwalt <wgottwalt@suse.de>
Date: Mon, 07 Jul 2008 05:40:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (c7temp): new driver for VIA C7 CPU
Message-Id: <200807070740.39278.wgottwalt@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
In-Reply-To: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Samstag 05 Juli 2008 22:49:46 schrieb Juerg Haefliger:
> Here it is:
>
>    vendor_id = "CentaurHauls"
>    version information (1/eax):
>       processor type  = primary processor (0)
>       family          = Intel Pentium Pro/II/III/Celeron, AMD
> Athlon/Duron, Cyrix M2, VIA C3 (6)
>       model           = 0xa (10)
>       stepping id     = 0x9 (9)
>       extended family = 0x0 (0)
>       extended model  = 0x0 (0)
>       (simple synth)  = VIA C7 / C7-M (Esther WinChip C5J core)
>    miscellaneous (1/ebx):
>       process local APIC physical ID = 0x0 (0)
>       cpu count                      = 0x1 (1)
>       CLFLUSH line size              = 0x8 (8)
>       brand index                    = 0x0 (0)
>    brand id = 0x00 (0): unknown
>    feature information (1/edx):
>       x87 FPU on chip                        = true
>       virtual-8086 mode enhancement          = true
>       debugging extensions                   = true
>       page size extensions                   = true
>       time stamp counter                     = true
>       RDMSR and WRMSR support                = true
>       physical address extensions            = true
>       machine check exception                = true
>       CMPXCHG8B inst.                        = true
>       APIC on chip                           = true
>       SYSENTER and SYSEXIT                   = true
>       memory type range registers            = true
>       PTE global bit                         = true
>       machine check architecture             = false
>       conditional move/compare instruction   = true
>       page attribute table                   = true
>       page size extension                    = false
>       processor serial number                = false
>       CLFLUSH instruction                    = true
>       debug store                            = false
>       thermal monitor and clock ctrl         = true
>       MMX Technology                         = true
>       FXSAVE/FXRSTOR                         = true
>       SSE extensions                         = true
>       SSE2 extensions                        = true
>       self snoop                             = false
>       hyper-threading / multi-core supported = false
>       therm. monitor                         = false
>
> According to the datasheet, this should be 'true'.
>
>
>       IA64                                   = false
>       pending break event                    = true
>    feature information (1/ecx):
>       PNI/SSE3: Prescott New Instructions    = true
>       MONITOR/MWAIT                          = false
>       CPL-qualified debug store              = false
>       VMX: virtual machine extensions        = false
>       Enhanced Intel SpeedStep Technology    = true
>       thermal monitor 2                      = false
>
> Same here.
>
>
>       context ID: adaptive or shared L1 data = false
>       cmpxchg16b available                   = false
>       xTPR disable                           = false
>    extended processor signature (0x80000001/eax):
>       generation     = 0x0 (0)
>       model          = 0x0 (0)
>       stepping       = 0x0 (0)
>       (simple synth) = unknown
>    extended feature flags (0x80000001/edx):
>       x87 FPU on chip                       = false
>       virtual-8086 mode enhancement         = false
>       debugging extensions                  = false
>       page size extensions                  = false
>       time stamp counter                    = false
>       RDMSR and WRMSR support               = false
>       physical address extensions           = false
>       machine check exception               = false
>       CMPXCHG8B inst.                       = false
>       APIC on chip                          = false
>       SYSCALL and SYSRET instructions       = false
>       memory type range registers           = false
>       global paging extension               = false
>       machine check architecture            = false
>       conditional move/compare instruction  = false
>       page attribute table                  = false
>       page size extension                   = false
>       multiprocessing capable               = false
>       AMD multimedia instruction extensions = false
>       MMX Technology                        = false
>       extended MMX                          = false
>       SSE extensions                        = false
>       AA-64                                 = false
>       3DNow! instruction extensions         = false
>       3DNow! instructions                   = false
>    brand = "                   VIA Esther processor 1000MHz"
>    L1 TLB/cache information: 2M/4M pages & L1 TLB (0x80000005/eax):
>       instruction # entries     = 0x0 (0)
>       instruction associativity = 0x0 (0)
>       data # entries            = 0x0 (0)
>       data associativity        = 0x0 (0)
>    L1 TLB/cache information: 4K pages & L1 TLB (0x80000005/ebx):
>       instruction # entries     = 0x80 (128)
>       instruction associativity = 0x8 (8)
>       data # entries            = 0x80 (128)
>       data associativity        = 0x8 (8)
>    L1 data cache information (0x80000005/ecx):
>       line size (bytes) = 0x40 (64)
>       lines per tag     = 0x1 (1)
>       associativity     = 0x4 (4)
>       size (Kb)         = 0x40 (64)
>    L1 instruction cache information (0x80000005/ecx):
>       line size (bytes) = 0x40 (64)
>       lines per tag     = 0x1 (1)
>       associativity     = 0x4 (4)
>       size (Kb)         = 0x40 (64)
>    L2 TLB/cache information: 2M/4M pages & L2 TLB (0x80000006/eax):
>       instruction # entries     = 0x0 (0)
>       instruction associativity = L2 off (0)
>       data # entries            = 0x0 (0)
>       data associativity        = L2 off (0)
>    L2 TLB/cache information: 4K pages & L2 TLB (0x80000006/ebx):
>       instruction # entries     = 0x0 (0)
>       instruction associativity = L2 off (0)
>       data # entries            = 0x0 (0)
>       data associativity        = L2 off (0)
>    L2 unified cache information (0x80000006/ecx):
>       line size (bytes) = 0x40 (64)
>       lines per tag     = 0x1 (1)
>       associativity     = 0xa (10)
>       size (Kb)         = 0x80 (128)
>    0xc0000001: eax=0x00000000
>    extended feature flags (0xc0000001/edx):
>       alternate instruction set                 = false
>       alternate instruction set enabled         = false
>       random number generator                   = true
>       random number generator enabled           = true
>       LongHaul MSR 0000_110Ah                   = false
>       FEMMS                                     = false
>       advanced cryptography engine (ACE)        = true
>       advanced cryptography engine (ACE)enabled = true
>    0xc0000002: eax=0x00000000 ebx=0x08000810 ecx=0x08100a13 edx=0x42000000
>
>
> Wilken, what motherboard is this? Are there any BIOS settings (thermal
> management) that you can play around with? Try different thermal
> management settings and rerun cpuid and check if the thermal monitors
> show up as 'true'.
> I have a cpuid dump from Sergio (C7 on a LN10000 board) and the only
> difference between his dump and yours is that his shows 'true' for
> both thermal monitors. Maybe your BIOS disables these features on your
> CPU.

It's the Artigo-Box from Via with a PX10000 board 
(http://www.via.com.tw/en/products/embedded/artigo/).
No, there are no bios settings dealing with thermal or power management. There 
is nothing I can play with. The bios is very rudimentary.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
