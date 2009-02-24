From: Juerg Haefliger <juergh@gmail.com>
Date: Tue, 24 Feb 2009 14:37:53 +0000
Subject: Re: [lm-sensors] module c7temp shows voltage, but no temperature
Message-Id: <191fb4ca0902240637i171dc3f1oae25aef31f0238bb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200902221052.31780.justin@justinzane.com>
In-Reply-To: <200902221052.31780.justin@justinzane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Michael,

Please also run cpuid -r.

Thanks
...juerg


On Mon, Feb 23, 2009 at 8:38 AM, Michael Reinelt <michael@reinelt.co.at> wrote:
> Hi Juerg,
>
>> You need a newer cpuid to display some additional data:
>> http://freshmeat.net/redir/cpuid_2/63002/url_tgz/cpuid-20060917.src.tar.gz
>
> Thanks for the hint! although the link you provided did not work, I
> found the package somewhere on the net, and here's the output:
>
>
> CPU:
>   vendor_id = "CentaurHauls"
>   version information (1/eax):
>      processor type  = primary processor (0)
>      family          = Intel Pentium Pro/II/III/Celeron, AMD
> Athlon/Duron, Cyrix M2, VIA C3 (6)
>      model           = 0xd (13)
>      stepping id     = 0x0 (0)
>      extended family = 0x0 (0)
>      extended model  = 0x0 (0)
>      (simple synth)  = VIA C3 / C3-M / C7 / C7-M / Eden ESP
> 7000/8000/10000 (unknown model)
>   miscellaneous (1/ebx):
>      process local APIC physical ID = 0x0 (0)
>      cpu count                      = 0x0 (0)
>      CLFLUSH line size              = 0x8 (8)
>      brand index                    = 0x0 (0)
>   brand id = 0x00 (0): unknown
>   feature information (1/edx):
>      x87 FPU on chip                        = true
>      virtual-8086 mode enhancement          = true
>      debugging extensions                   = true
>      page size extensions                   = true
>      time stamp counter                     = true
>      RDMSR and WRMSR support                = true
>      physical address extensions            = true
>      machine check exception                = true
>      CMPXCHG8B inst.                        = true
>      APIC on chip                           = true
>      SYSENTER and SYSEXIT                   = true
>      memory type range registers            = true
>      PTE global bit                         = true
>      machine check architecture             = false
>      conditional move/compare instruction   = true
>      page attribute table                   = true
>      page size extension                    = false
>      processor serial number                = false
>      CLFLUSH instruction                    = true
>      debug store                            = false
>      thermal monitor and clock ctrl         = true
>      MMX Technology                         = true
>      FXSAVE/FXRSTOR                         = true
>      SSE extensions                         = true
>      SSE2 extensions                        = true
>      self snoop                             = false
>      hyper-threading / multi-core supported = false
>      therm. monitor                         = true
>      IA64                                   = false
>      pending break event                    = true
>   feature information (1/ecx):
>      PNI/SSE3: Prescott New Instructions    = true
>      MONITOR/MWAIT                          = false
>      CPL-qualified debug store              = false
>      VMX: virtual machine extensions        = false
>      Enhanced Intel SpeedStep Technology    = true
>      thermal monitor 2                      = true
>      context ID: adaptive or shared L1 data = false
>      cmpxchg16b available                   = false
>      xTPR disable                           = true
>   extended processor signature (0x80000001/eax):
>      generation     = 0x0 (0)
>      model          = 0x0 (0)
>      stepping       = 0x0 (0)
>      (simple synth) = unknown
>   extended feature flags (0x80000001/edx):
>      x87 FPU on chip                       = false
>      virtual-8086 mode enhancement         = false
>      debugging extensions                  = false
>      page size extensions                  = false
>      time stamp counter                    = false
>      RDMSR and WRMSR support               = false
>      physical address extensions           = false
>      machine check exception               = false
>      CMPXCHG8B inst.                       = false
>      APIC on chip                          = false
>      SYSCALL and SYSRET instructions       = false
>      memory type range registers           = false
>      global paging extension               = false
>      machine check architecture            = false
>      conditional move/compare instruction  = false
>      page attribute table                  = false
>      page size extension                   = false
>      multiprocessing capable               = false
>      AMD multimedia instruction extensions = false
>      MMX Technology                        = false
>      extended MMX                          = false
>      SSE extensions                        = false
>      AA-64                                 = false
>      3DNow! instruction extensions         = false
>      3DNow! instructions                   = false
>   brand = "                       VIA C7 Processor 1500MHz"
>   L1 TLB/cache information: 2M/4M pages & L1 TLB (0x80000005/eax):
>      instruction # entries     = 0x0 (0)
>      instruction associativity = 0x0 (0)
>      data # entries            = 0x0 (0)
>      data associativity        = 0x0 (0)
>   L1 TLB/cache information: 4K pages & L1 TLB (0x80000005/ebx):
>      instruction # entries     = 0x80 (128)
>      instruction associativity = 0x8 (8)
>      data # entries            = 0x80 (128)
>      data associativity        = 0x8 (8)
>   L1 data cache information (0x80000005/ecx):
>      line size (bytes) = 0x40 (64)
>      lines per tag     = 0x1 (1)
>      associativity     = 0x4 (4)
>      size (Kb)         = 0x40 (64)
>   L1 instruction cache information (0x80000005/ecx):
>      line size (bytes) = 0x40 (64)
>      lines per tag     = 0x1 (1)
>      associativity     = 0x4 (4)
>      size (Kb)         = 0x40 (64)
>   L2 TLB/cache information: 2M/4M pages & L2 TLB (0x80000006/eax):
>      instruction # entries     = 0x0 (0)
>      instruction associativity = L2 off (0)
>      data # entries            = 0x0 (0)
>      data associativity        = L2 off (0)
>   L2 TLB/cache information: 4K pages & L2 TLB (0x80000006/ebx):
>      instruction # entries     = 0x0 (0)
>      instruction associativity = L2 off (0)
>      data # entries            = 0x0 (0)
>      data associativity        = L2 off (0)
>   L2 unified cache information (0x80000006/ecx):
>      line size (bytes) = 0x40 (64)
>      lines per tag     = 0x1 (1)
>      associativity     = 0xa (10)
>      size (Kb)         = 0x80 (128)
>   0xc0000001: eax=0x00000000
>   extended feature flags (0xc0000001/edx):
>      alternate instruction set                 = false
>      alternate instruction set enabled         = false
>      random number generator                   = true
>      random number generator enabled           = true
>      LongHaul MSR 0000_110Ah                   = false
>      FEMMS                                     = false
>      advanced cryptography engine (ACE)        = true
>      advanced cryptography engine (ACE)enabled = true
>   0xc0000002: eax=0x00000000 ebx=0x08000810 ecx=0x08100f13 edx=0x42040000
>   0xc0000003: eax=0x57762abe ebx=0xce237d7f ecx=0x5ee56564 edx=0xe8619e36
>   (multi-processing synth): none
>   (synth) = VIA C3 / C3-M / C7 / C7-M / Eden ESP 7000/8000/10000
> (unknown model)
>
> --
> Michael Reinelt <michael@reinelt.co.at>
> http://home.pages.at/reinelt
> GPG-Key 0xDF13BA50
> ICQ #288386781
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
