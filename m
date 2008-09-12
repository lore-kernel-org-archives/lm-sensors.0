From: Marco Chiappero <marco@absence.it>
Date: Fri, 12 Sep 2008 13:59:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (c7temp): new driver for VIA C7 CPU
Message-Id: <48CA75B3.8050606@absence.it>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060002080807010404030709"
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
In-Reply-To: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060002080807010404030709
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: Quoted-Printable

 > I had a colleague of mine (Cc'd, hi Wilken :)) test your driver. The
 > voltage part appears to work, we saw in0 change from 0.96 V at 800 MHz
 > to 1.00V at 1000 MHz. However the temperature is always reported as 0
 > degrees C. We dumped the value of eax after the cpuid() call and it's
 > 0x0.
 >
 > Does this mean that Wilken's CPU lacks the thermal diode? Or could
 > this
 > be a bug in your driver? For reference, the CPU in question is:
 >
 > processor  	: 0
 > vendor_id	: CentaurHauls
 > cpu family	: 6
 > model		: 10
 > model name	: VIA Esther processor 1000MHz
 > stepping	: 9

Same thing here with the same CPU on a VIA EPIA SN10000EG motherboard.=20
However I have CPU temperature reading through the SCH3112 chip.

vulcano:/usr/src ~> sensors
sch311x-isa-0a70
Adapter: ISA adapter
V5stby:      +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)   ALARM
Vccp:        +0.95 V  (min =3D  +0.00 V, max =3D  +1.99 V)
V3.3:        +3.27 V  (min =3D  +0.00 V, max =3D  +4.38 V)
V5:          +4.99 V  (min =3D  +0.00 V, max =3D  +6.64 V)
V12:        +12.19 V  (min =3D  +0.00 V, max =3D +15.94 V)
V3.3stby:    +3.30 V  (min =3D  +0.00 V, max =3D  +4.38 V)
Vbat:        +3.18 V  (min =3D  +0.00 V, max =3D  +4.38 V)
Case Fan:   1088 RPM  (min =3D    0 RPM)
PSU  Fan:   1459 RPM  (min =3D    0 RPM)
CPU Temp:    +47.2=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
Int Temp:    +35.8=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
NB  Temp:    +34.5=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)

c7temp-isa-0000
Adapter: ISA adapter
in0:         +0.96 V
temp1:        +0.0=B0C

Cpuid output attached


Regards,
Marco

--------------060002080807010404030709
Content-Type: text/plain;
 name="cpuid-c7"
Content-Disposition: inline;
 filename="cpuid-c7"
Content-Transfer-Encoding: 7Bit

vulcano:/usr/src/cpuid-20060917 ~> ./cpuid
CPU:
   vendor_id = "CentaurHauls"
   version information (1/eax):
      processor type  = primary processor (0)
      family          = Intel Pentium Pro/II/III/Celeron, AMD Athlon/Duron, Cyrix M2, VIA C3 (6)
      model           = 0xa (10)
      stepping id     = 0x9 (9)
      extended family = 0x0 (0)
      extended model  = 0x0 (0)
      (simple synth)  = VIA C7 / C7-M (Esther WinChip C5J core)
   miscellaneous (1/ebx):
      process local APIC physical ID = 0x0 (0)
      cpu count                      = 0x1 (1)
      CLFLUSH line size              = 0x8 (8)
      brand index                    = 0x0 (0)
   brand id = 0x00 (0): unknown
   feature information (1/edx):
      x87 FPU on chip                        = true
      virtual-8086 mode enhancement          = true
      debugging extensions                   = true
      page size extensions                   = true
      time stamp counter                     = true
      RDMSR and WRMSR support                = true
      physical address extensions            = true
      machine check exception                = true
      CMPXCHG8B inst.                        = true
      APIC on chip                           = true
      SYSENTER and SYSEXIT                   = true
      memory type range registers            = true
      PTE global bit                         = true
      machine check architecture             = false
      conditional move/compare instruction   = true
      page attribute table                   = true
      page size extension                    = false
      processor serial number                = false
      CLFLUSH instruction                    = true
      debug store                            = false
      thermal monitor and clock ctrl         = true
      MMX Technology                         = true
      FXSAVE/FXRSTOR                         = true
      SSE extensions                         = true
      SSE2 extensions                        = true
      self snoop                             = false
      hyper-threading / multi-core supported = false
      therm. monitor                         = true
      IA64                                   = false
      pending break event                    = true
   feature information (1/ecx):
      PNI/SSE3: Prescott New Instructions    = true
      MONITOR/MWAIT                          = false
      CPL-qualified debug store              = false
      VMX: virtual machine extensions        = false
      Enhanced Intel SpeedStep Technology    = true
      thermal monitor 2                      = true
      context ID: adaptive or shared L1 data = false
      cmpxchg16b available                   = false
      xTPR disable                           = false
   extended processor signature (0x80000001/eax):
      generation     = 0x0 (0)
      model          = 0x0 (0)
      stepping       = 0x0 (0)
      (simple synth) = unknown
   extended feature flags (0x80000001/edx):
      x87 FPU on chip                       = false
      virtual-8086 mode enhancement         = false
      debugging extensions                  = false
      page size extensions                  = false
      time stamp counter                    = false
      RDMSR and WRMSR support               = false
      physical address extensions           = false
      machine check exception               = false
      CMPXCHG8B inst.                       = false
      APIC on chip                          = false
      SYSCALL and SYSRET instructions       = false
      memory type range registers           = false
      global paging extension               = false
      machine check architecture            = false
      conditional move/compare instruction  = false
      page attribute table                  = false
      page size extension                   = false
      multiprocessing capable               = false
      AMD multimedia instruction extensions = false
      MMX Technology                        = false
      extended MMX                          = false
      SSE extensions                        = false
      AA-64                                 = false
      3DNow! instruction extensions         = false
      3DNow! instructions                   = false
   brand = "                   VIA Esther processor 1000MHz"
   L1 TLB/cache information: 2M/4M pages & L1 TLB (0x80000005/eax):
      instruction # entries     = 0x0 (0)
      instruction associativity = 0x0 (0)
      data # entries            = 0x0 (0)
      data associativity        = 0x0 (0)
   L1 TLB/cache information: 4K pages & L1 TLB (0x80000005/ebx):
      instruction # entries     = 0x80 (128)
      instruction associativity = 0x8 (8)
      data # entries            = 0x80 (128)
      data associativity        = 0x8 (8)
   L1 data cache information (0x80000005/ecx):
      line size (bytes) = 0x40 (64)
      lines per tag     = 0x1 (1)
      associativity     = 0x4 (4)
      size (Kb)         = 0x40 (64)
   L1 instruction cache information (0x80000005/ecx):
      line size (bytes) = 0x40 (64)
      lines per tag     = 0x1 (1)
      associativity     = 0x4 (4)
      size (Kb)         = 0x40 (64)
   L2 TLB/cache information: 2M/4M pages & L2 TLB (0x80000006/eax):
      instruction # entries     = 0x0 (0)
      instruction associativity = L2 off (0)
      data # entries            = 0x0 (0)
      data associativity        = L2 off (0)
   L2 TLB/cache information: 4K pages & L2 TLB (0x80000006/ebx):
      instruction # entries     = 0x0 (0)
      instruction associativity = L2 off (0)
      data # entries            = 0x0 (0)
      data associativity        = L2 off (0)
   L2 unified cache information (0x80000006/ecx):
      line size (bytes) = 0x40 (64)
      lines per tag     = 0x1 (1)
      associativity     = 0xa (10)
      size (Kb)         = 0x80 (128)
   0xc0000001: eax=0x00000000
   extended feature flags (0xc0000001/edx):
      alternate instruction set                 = false
      alternate instruction set enabled         = false
      random number generator                   = true
      random number generator enabled           = true
      LongHaul MSR 0000_110Ah                   = false
      FEMMS                                     = false
      advanced cryptography engine (ACE)        = true
      advanced cryptography engine (ACE)enabled = true
   0xc0000002: eax=0x00000000 ebx=0x08000810 ecx=0x08100a13 edx=0x42000000
   (multi-processing synth): none
   (synth) = VIA C7 / C7-M (Esther WinChip C5J core)

vulcano:/usr/src/cpuid-20060917 ~> ./cpuid -r
CPU:
   0x00000000: eax=0x00000001 ebx=0x746e6543 ecx=0x736c7561 edx=0x48727561
   0x00000001: eax=0x000006a9 ebx=0x00010800 ecx=0x00000181 edx=0xa7c9bbff
   0x80000000: eax=0x80000006 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
   0x80000001: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00100000
   0x80000002: eax=0x20202020 ebx=0x20202020 ecx=0x20202020 edx=0x20202020
   0x80000003: eax=0x56202020 ebx=0x45204149 ecx=0x65687473 edx=0x72702072
   0x80000004: eax=0x7365636f ebx=0x20726f73 ecx=0x30303031 edx=0x007a484d
   0x80000005: eax=0x00000000 ebx=0x08800880 ecx=0x40040140 edx=0x40040140
   0x80000006: eax=0x00000000 ebx=0x00000000 ecx=0x0080a140 edx=0x00000000
   0x80860000: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
   0xc0000000: eax=0xc0000002 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
   0xc0000001: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00003fcc
   0xc0000002: eax=0x00000000 ebx=0x08000810 ecx=0x08100a13 edx=0x42000000


--------------060002080807010404030709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060002080807010404030709--
