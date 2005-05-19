From: DarKRaveR@verfeiert.org (DarKRaveR@verfeiert.org)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Follow-UP to ticket 1578 as requested
Message-Id: <644593019.20040218220228@verfeiert.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
In-Reply-To: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

Sorry, it took me soem time, but I was kinda busy and involved with
some studying etc. - anyway:

The libs are in place and ldd sensors is linked against
libsensors.so.2

Maybe the followign helps, it's some info on libsensors.so.2:

/usr/lib/libsensors.so.2:     file format elf32-i386

Program Header:
    LOAD off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**12
         filesz 0x0000ce90 memsz 0x0000ce90 flags r-x
    LOAD off    0x0000d000 vaddr 0x0000d000 paddr 0x0000d000 align 2**12
         filesz 0x0000d2e0 memsz 0x0001e444 flags rw-
 DYNAMIC off    0x0001a090 vaddr 0x0001a090 paddr 0x0001a090 align 2**2
         filesz 0x000000d0 memsz 0x000000d0 flags rw-
   STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**2
         filesz 0x00000000 memsz 0x00000000 flags rwx

Dynamic Section:
  NEEDED      libc.so.6
  NEEDED      libm.so.6
  SONAME      libsensors.so.2
  INIT        0x4eec
  FINI        0xa750
  HASH        0xb4
  STRTAB      0xc54
  SYMTAB      0x444
  STRSZ       0x70d
  SYMENT      0x10
  PLTGOT      0x1a174
  PLTRELSZ    0x1d0
  PLTREL      0x11
  JMPREL      0x4d1c
  REL         0x14c4
  RELSZ       0x3858
  RELENT      0x8
  VERNEED     0x1464
  VERNEEDNUM  0x2
  VERSYM      0x1362
  RELCOUNT    0x6ed

Version References:
  required from libm.so.6:
    0x0d696910 0x00 03 GLIBC_2.0
  required from libc.so.6:
    0x09691f73 0x00 05 GLIBC_2.1.3
    0x0d696911 0x00 04 GLIBC_2.1
    0x0d696910 0x00 02 GLIBC_2.0

        libsensors.so.2 => /usr/lib/libsensors.so.2 (0x4002d000)
        libc.so.6 => /lib/libc.so.6 (0x40059000)
        libm.so.6 => /lib/libm.so.6 (0x40184000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

I gave thsi dump, since it reports the internal SO name and soem
version information (I hope/guess).

If I can investigate this any further, feel free to mail me.

Aside from this, I didn't have time yet do build it all on my own.

Anyway, since there seems to be soem problem, when I run sensors,
maybe we can get closer to the core of the problem this way ...

Thanx again, looking forward to hear from you

With best Regards

-Sven (DarKRaveR) E.

Monday, February 16, 2004, 11:14:18 AM, you wrote:

JD> [Please reply to the list, not to me]

JD> Quoting "Sven E." <dark@verfeiert.org>:

>> Driver `it87' (should be inserted):
>>   Detects correctly:
>>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>>     Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)
>>  
>> Driver `w83627hf' (may not be inserted):
>>   Misdetects:
>>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>>     Chip `Winbond W83627THF Super IO Sensors' (confidence: 8)

JD> We usually trust Super IO more than ISA. In newer versions of
JD> sensors-detect, Super IO have a confidence of 9, so it would have
JD> suggested w83627hf over it87 in your case.

>> As one can see now the Winbond is recommended as expected. yet, if I
>> use the recommended modules:
>> 
>> sensors
>> w83627thf-isa-0290
>> Adapter: ISA adapter
>> Algorithm: ISA algorithm
>> ERROR: Can't get alarm data!
>> ERROR: Can't get beep data!
>> ERROR: Can't get IN0 data!
>> ERROR: Can't get IN2 data!
>> ERROR: Can't get IN3 data!
>> ERROR: Can't get IN4 data!
>> ERROR: Can't get IN7 data!
>> ERROR: Can't get IN8 data!
>> ERROR: Can't get FAN1 data!
>> ERROR: Can't get FAN2 data!
>> ERROR: Can't get TEMP1 data!
>> ERROR: Can't get TEMP2 data!
>> 
>> Khali supposed the lib might be outdated, but where can I find the
>> lib.

JD> ls -l /usr/lib/libsensors*
JD> ls -l /usr/local/lib/libsensors*

JD> You can also do "$(which sensors)" and "ldd $(which sensors)" to see
JD> which library the sensors binary is linking to. If the library prefix
JD> differs from sensors one, there's something bad.

>> I am using gentoo, I patched the kernel since I need bttv I
>> installed all needed packages etc.

JD> We have a long history of problems with Gentoo. They have kernel patches
JD> that often make lm_sensors fail, although "sensors" alone usually works
JD> (this is "sensors -s" that usually fails).

JD> I'm not sure I understand what you mean with "I patched the kernel". Did
JD> you patch Gentoo kernel sources, or a vanilla kernel?

>> gentoo says I use lm-sensors 2.8.1 as well as i2c 2.8.1

JD> I would recommend that you clearly choose your side, and stick to it.
JD> Either use a Gentoo kernel and stick to their version of i2c and
JD> lm_sensors, or compile a vanilla kernel with my i2c patch, and install
JD> lm_sensors on your own (same version as i2c, preferably). Mixing Gentoo
JD> stuff with our own is likely to cause more trouble than it's worth.

-- 
Best regards,
 DarKRaveR                            mailto:DarKRaveR@verfeiert.org
