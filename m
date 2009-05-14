From: Hleb Valoshka <375gnu@gmail.com>
Date: Thu, 14 May 2009 19:14:36 +0000
Subject: Re: [lm-sensors] hwmon-vid driver from linux 2.6.29
Message-Id: <be6d22e0905141214l5658330ehedda25fae39c6d71@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A0C6BF7.9010107@assembler.cz>
In-Reply-To: <4A0C6BF7.9010107@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

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


On 5/14/09, Rudolf Marek <r.marek@assembler.cz> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi,
>
>
>
> I'm posting this to mailing list. I did no changes a long time. I need to
> check
> that. In the meanwhile can you give me an output of "cpuid" utility.
>
> Thanks,
> Rudolf
>
>
>
>
>
> Gnu Belarusian wrote:
>> Hallo!
>>
>> Module hwmon_vid (drivers/hwmon/hwmon-vid.c) from linux-2.6.29(.3) returns
>>
>> incorrect voltage for my CPU from it8716f sensor (real/2).
>> With module from 2.6.26 voltage is correct.
>>
>> Code changed between versions:
>>
>>  int vid_from_reg(int val, u8 vrm)
>>  {
>>         int vid;
>> @@ -96,9 +102,16 @@
>>                 if (val < 0x02 || val > 0xb2)
>>                         return 0;
>>                 return((1600000 - (val - 2) * 6250 + 500) / 1000);
>> -       case 24:                /* Opteron processor */
>> +
>> +       case 24:                /* Athlon64 & Opteron */
>>                 val &= 0x1f;
>> -               return(val = 0x1f ? 0 : 1550 - val * 25);
>> +               if (val = 0x1f)
>> +                       return 0;
>> +                               /* fall through */
>> +       case 25:                /* AMD NPT 0Fh */
>> +               val &= 0x3f;
>> +               return (val < 32) ? 1550 - 25 * val
>> +                       : 775 - (25 * (val - 31)) / 2;
>>
>> May be you should revert old code.
>>
>> My CPU is AMD BE-2350 stepping 01. IT87 sensor: IT8716F chip at 0x228,
>> revision 0.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkoMa/QACgkQ3J9wPJqZRNWzWwCfco9A7j9dMJhVoeFaHcgS6QSp
> vmkAn2l+5gDcPnsSbsa7/AKCpbLCtM/I
> =pf/j
> -----END PGP SIGNATURE-----
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
