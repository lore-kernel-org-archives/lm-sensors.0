From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Thu, 09 Aug 2007 06:38:29 +0000
Subject: Re: [lm-sensors] k8temp, BE-2350 CPU
Message-Id: <200708090738.29291.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <46BAABD3.5000103@assembler.cz>
In-Reply-To: <46BAABD3.5000103@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 09 August 2007 06:53:23 Rudolf Marek wrote:
> Hi,
>
> Sorry for the delay. I'm CCing the list too please do too.
>
> Alistair John Strachan wrote:
> > Hi,
> >
> > I've noticed a problem with the k8temp driver on a new BE-2350 processor.
> > It seems the sensors report bogus values on this CPU. This is when it is
> > idling:
> >
> > root@joyeuse:~# cat /sys/bus/pci/drivers/k8temp/0000\:00\:18.3/temp*
> > -5000
> > -5000
> > -3000
> > 1000
> >
> > And this is under load:
> >
> > root@joyeuse:~# cat /sys/bus/pci/drivers/k8temp/0000\:00\:18.3/temp*
> > 7000
> > 12000
> > 11000
> > 17000
> >
> > This is a socket AM2 processor. Any idea what's wrong? Using kernel
> > 2.6.23-rc1, but it's also broken on Debian's 2.6.22.
>
> Hmm perhaps the formula does not work anymore :/ Can you send me output of
> cat /proc/cpuinfo?

root@joyeuse:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 107
model name      : AMD Athlon(tm) X2 Dual Core Processor BE-2350
stepping        : 1
cpu MHz         : 2099.919
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp lm 3dnowext 3dnow rep_good pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy misalignsse
bogomips        : 4202.60
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 107
model name      : AMD Athlon(tm) X2 Dual Core Processor BE-2350
stepping        : 1
cpu MHz         : 2099.919
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp lm 3dnowext 3dnow rep_good pni cx16 lahf_lm cmp_legacy svm extapic cr8_legacy misalignsse
bogomips        : 4200.00
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps

> Or even better output of cpuid utillity?

root@joyeuse:~# cpuid
 eax in    eax      ebx      ecx      edx
00000000 00000001 68747541 444d4163 69746e65
00000001 00060fb1 01020800 00002001 178bfbff
80000000 80000018 68747541 444d4163 69746e65
80000001 00060fb1 0000464a 0000011f ebd3fbff
80000002 20444d41 6c687441 74286e6f 5820296d
80000003 75442032 43206c61 2065726f 636f7250
80000004 6f737365 45422072 3533322d 00000030
80000005 ff08ff08 ff20ff20 40020140 40020140
80000006 00000000 42004200 02008140 00000000
80000007 00000000 00000000 00000000 0000007f
80000008 00003028 00000000 00000001 00000000
80000009 00000000 00000000 00000000 00000000
8000000a 00000001 00000040 00000000 00000002
8000000b 00000000 00000000 00000000 00000000
8000000c 00000000 00000000 00000000 00000000
8000000d 00000000 00000000 00000000 00000000
8000000e 00000000 00000000 00000000 00000000
8000000f 00000000 00000000 00000000 00000000
80000010 00000000 00000000 00000000 00000000
80000011 00000000 00000000 00000000 00000000
80000012 00000000 00000000 00000000 00000000
80000013 00000000 00000000 00000000 00000000
80000014 00000000 00000000 00000000 00000000
80000015 00000000 00000000 00000000 00000000
80000016 00000000 00000000 00000000 00000000
80000017 00000000 00000000 00000000 00000000
80000018 00000000 00000000 00000000 00000000

Vendor ID: "AuthenticAMD"; CPUID level 1

AMD-specific functions
Version 00060fb1:
Family: 15 Model: 11 []

Standard feature flags 178bfbff:
Floating Point Unit
Virtual Mode Extensions
Debugging Extensions
Page Size Extensions
Time Stamp Counter (with RDTSC and CR4 disable bit)
Model Specific Registers with RDMSR & WRMSR
PAE - Page Address Extensions
Machine Check Exception
COMPXCHG8B Instruction
APIC
SYSCALL/SYSRET or SYSENTER/SYSEXIT instructions
MTRR - Memory Type Range Registers
Global paging extension
Machine Check Architecture
Conditional Move Instruction
PAT - Page Attribute Table
PSE-36 - Page Size Extensions
19 - reserved
MMX instructions
FXSAVE/FXRSTOR
25 - reserved
26 - reserved
28 - reserved
Generation: 15 Model: 11
Extended feature flags ebd3fbff:
Floating Point Unit
Virtual Mode Extensions
Debugging Extensions
Page Size Extensions
Time Stamp Counter (with RDTSC and CR4 disable bit)
Model Specific Registers with RDMSR & WRMSR
PAE - Page Address Extensions
Machine Check Exception
COMPXCHG8B Instruction
APIC
SYSCALL/SYSRET or SYSENTER/SYSEXIT instructions
MTRR - Memory Type Range Registers
Global paging extension
Machine Check Architecture
Conditional Move Instruction
PAT - Page Attribute Table
PSE-36 - Page Size Extensions
20 - reserved
AMD MMX Instruction Extensions
MMX instructions
FXSAVE/FXRSTOR
25 - reserved
27 - reserved
29 - reserved
3DNow! Instruction Extensions
3DNow instructions

Processor name string: AMD Athlon(tm) X2 Dual Core Processor BE-2350
L1 Cache Information:
2/4-MB Pages:
   Data TLB: associativity 255-way #entries 8
   Instruction TLB: associativity 255-way #entries 8
4-KB Pages:
   Data TLB: associativity 255-way #entries 32
   Instruction TLB: associativity 255-way #entries 32
L1 Data cache:
   size 64 KB associativity 2-way lines per tag 1 line size 64
L1 Instruction cache:
   size 64 KB associativity 2-way lines per tag 1 line size 64

L2 Cache Information:
2/4-MB Pages:
   Data TLB: associativity L2 off #entries 0
   Instruction TLB: associativity L2 off #entries 0
4-KB Pages:
   Data TLB: associativity 2-way #entries 0
   Instruction TLB: associativity 2-way #entries 0
   size 2 KB associativity L2 off lines per tag 129 line size 64

Advanced Power Management Feature Flags
Has temperature sensing diode
Supports Frequency ID control
Supports Voltage ID control
Maximum linear address: 48; maximum phys address 40

-- 
Cheers,
Alistair.

137/1 Warrender Park Road, Edinburgh, UK.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
