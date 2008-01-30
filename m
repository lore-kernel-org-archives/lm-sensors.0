From: Lee Harris <lee.r.harris@googlemail.com>
Date: Wed, 30 Jan 2008 07:28:50 +0000
Subject: Re: [lm-sensors] Help with readings (k8temp - dme1737)
Message-Id: <47A02732.6050701@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4946204343925101650=="
List-Id: <lm-sensors.vger.kernel.org>
References: <479F751E.6080707@gmail.com>
In-Reply-To: <479F751E.6080707@gmail.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============4946204343925101650==
Content-Type: multipart/alternative;
	boundary="------------060409020706020500040900"

This is a multi-part message in MIME format.
--------------060409020706020500040900
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi Juerg

Thanks for the reply. I will post the output of dmidecode and=20
/proc/cpuinfo below

The reading I posted is at idle ( I should have been more specific)
At full load core1 Temp rose to about 49=B0C (from 42=B0 idle) and CPU temp=
=20
to 68=B0C (from 60=B0 idle)

I was thinking 60=B0 at idle was to high to be a true figure, but it is a=20
long time since I took much notice of cpu temps so I am only guessing ?

The CPU is a Athlon 64 3500+ according to /proc/cpuinfo. I have come=20
across a linux cpuid program today and will also include the output from=20
this.

Thanks Again
Lee
(By the way the server hasn't crashed so far :)   )

 cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 127
model name      : AMD Athlon(tm) 64 Processor 3500+
stepping        : 1
cpu MHz         : 2210.068
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=20
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt=20
rdtscp lm 3dnowext 3dnow up rep_good pni cx16 lahf_lm svm extapic=20
cr8_legacy 3dnowprefetch
bogomips        : 4423.07
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc 100mhzsteps

---------------------------------------------------------------------------=
-----------------------

root@s15258863:~# dmidecode
# dmidecode 2.9
SMBIOS 2.4 present.
61 structures occupying 1862 bytes.
Table at 0x3EF6B000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
        Vendor: FUJITSU SIEMENS // Phoenix Technologies Ltd.
        Version: 6.00 R1.11-04.2461.C1
        Release Date: 04/19/2007
        Address: 0xE6640
        Runtime Size: 104896 bytes
        ROM Size: 512 kB
        Characteristics:
                PCI is supported
                PNP is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                ESCD support is available
                Boot from CD is supported
                Selectable boot is supported
                Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
                Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
                5.25"/360 KB floppy services are supported (int 13h)
                5.25"/1.2 MB floppy services are supported (int 13h)
                3.5"/720 KB floppy services are supported (int 13h)
                3.5"/2.88 MB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                LS-120 boot is supported
                ATAPI Zip drive boot is supported
                BIOS boot specification is supported
                Targeted content distribution is supported
        BIOS Revision: 1.17

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: FUJITSU SIEMENS
        Product Name: D2461-C1
        Version:
        Serial Number:
        UUID: 00000000-0000-0000-0000-00199908E805
        Wake-up Type: Power Switch
        SKU Number: Not Specified
        Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: FUJITSU SIEMENS
        Product Name: D2461-C1
        Version: S26361-D2461-C1
        Serial Number: 23671342

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
        Manufacturer: FUJITSU SIEMENS
        Type: Mini Tower
        Lock: Present
        Version:
        Serial Number:
        Asset Tag:
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None
        OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
        Socket Designation: Socket AM2
        Type: Central Processor
        Family: Opteron
        Manufacturer: AMD
        ID: F1 0F 07 00 FF FB 8B 07
        Signature: Family 15, Model 127, Stepping 1
        Flags:
                FPU (Floating-point unit on-chip)
                VME (Virtual mode extension)
                DE (Debugging extension)
                PSE (Page size extension)
                TSC (Time stamp counter)
                MSR (Model specific registers)
                PAE (Physical address extension)
                MCE (Machine check exception)
                CX8 (CMPXCHG8 instruction supported)
                APIC (On-chip APIC hardware supported)
                SEP (Fast system call)
                MTRR (Memory type range registers)
                PGE (Page global enable)
                MCA (Machine check architecture)
                CMOV (Conditional move instruction supported)
                PAT (Page attribute table)
                PSE-36 (36-bit page size extension)
                CLFSH (CLFLUSH instruction supported)
                MMX (MMX technology supported)
                FXSR (Fast floating-point save and restore)
                SSE (Streaming SIMD extensions)
                SSE2 (Streaming SIMD extensions 2)
        Version: AMD
        Voltage: 1.6 V
        External Clock: 133 MHz
        Max Speed: 2200 MHz
        Current Speed: 2200 MHz
        Status: Populated, Enabled
        Upgrade: None
        L1 Cache Handle: 0x0005
        L2 Cache Handle: 0x0006
        L3 Cache Handle: Not Provided
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L1 Cache
        Configuration: Enabled, Not Socketed, Level 1
        Operational Mode: Write Back
        Location: Internal
        Installed Size: 64 KB
        Maximum Size: 64 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
                Asynchronous
        Installed SRAM Type: Asynchronous
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unknown
        Associativity: Unknown

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
        Socket Designation: L2 Cache
        Configuration: Enabled, Not Socketed, Level 2
        Operational Mode: Write Through
        Location: Internal
        Installed Size: 512 KB
        Maximum Size: 512 KB
        Supported SRAM Types:
                Burst
                Pipeline Burst
                Synchronous
        Installed SRAM Type: Synchronous
        Speed: Unknown
        Error Correction Type: Unknown
        System Type: Unified
        Associativity: Unknown

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: SMsC
        Internal Connector Type: None
        External Reference Designator: Serial-1
        External Connector Type: DB-9 male
        Port Type: Serial Port 16550 Compatible

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: MCP51
        Internal Connector Type: None
        External Reference Designator: LAN
        External Connector Type: RJ-45
        Port Type: Network Port

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: NVIDIA C51PVG
        Internal Connector Type: None
        External Reference Designator: Video
        External Connector Type: DB-15 female
        Port Type: Video Port

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: MCP51
        Internal Connector Type: None
        External Reference Designator: Rear: USB-1
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: MCP51
        Internal Connector Type: None
        External Reference Designator: Rear: USB-2
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: MCP51
        Internal Connector Type: None
        External Reference Designator: Rear: USB-3
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: MCP51
        Internal Connector Type: None
        External Reference Designator: Rear: USB-4
        External Connector Type: Access Bus (USB)
        Port Type: USB

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: NVIDIA C51PVG
        Internal Connector Type: None
        External Reference Designator: Video
        External Connector Type: DB-15 female
        Port Type: Video Port

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Realtek ALC260
        Internal Connector Type: None
        External Reference Designator: Rear: Line-In
        External Connector Type: Mini Jack (headphones)
        Port Type: Audio Port

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Realtek ALC260
        Internal Connector Type: None
        External Reference Designator: Rear: Line-Out
        External Connector Type: Mini Jack (headphones)
        Port Type: Audio Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: Realtek ALC260
        Internal Connector Type: None
        External Reference Designator: Rear: Mic-In
        External Connector Type: Mini Jack (headphones)
        Port Type: Audio Port

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: SMsC
        Internal Connector Type: On Board Floppy
        External Reference Designator: Floppy
        External Connector Type: None
        Port Type: None

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: MCP51
        Internal Connector Type: Other
        External Reference Designator: SATA-1
        External Connector Type: None
        Port Type: None

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: MCP51
        Internal Connector Type: Other
        External Reference Designator: SATA-2
        External Connector Type: None
        Port Type: None

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: MCP51
        Internal Connector Type: Other
        External Reference Designator: SATA-3
        External Connector Type: None
        Port Type: None

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
        Internal Reference Designator: MCP51
        Internal Connector Type: Other
        External Reference Designator: SATA-4
        External Connector Type: None
        Port Type: None

Handle 0x0017, DMI type 9, 13 bytes
System Slot Information
        Designation: PCIe x16
        Type: x16 PCI Express
        Current Usage: Available
        Length: Long
        ID: 1
        Characteristics:
                3.3 V is provided
                PME signal is supported

Handle 0x0018, DMI type 9, 13 bytes
System Slot Information
        Designation: PCIe-1 x1
        Type: x1 PCI Express
        Current Usage: Available
        Length: Long
        ID: 3
        Characteristics:
                3.3 V is provided
                PME signal is supported

Handle 0x0019, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Slot 1
        Type: 32-bit PCI
        Current Usage: Available
        Length: Long
        ID: 4
        Characteristics:
                3.3 V is provided
                PME signal is supported

Handle 0x001A, DMI type 9, 13 bytes
System Slot Information
        Designation: PCI Slot 2
        Type: 32-bit PCI
        Current Usage: Available
        Length: Long
        ID: 4
        Characteristics:
                3.3 V is provided
                PME signal is supported

Handle 0x001B, DMI type 10, 14 bytes
On Board Device 1 Information
        Type: Other
        Status: Disabled
        Description: SMsC SuperI/O
On Board Device 2 Information
        Type: Sound
        Status: Disabled
        Description: Realtek ALC260
On Board Device 3 Information
        Type: Video
        Status: Disabled
        Description: NVIDIA C51PVG
On Board Device 4 Information
        Type: Other
        Status: Disabled
        Description: Antaios
On Board Device 5 Information
        Type: Ethernet
        Status: Disabled
        Description: MCP51

Handle 0x001C, DMI type 11, 5 bytes
OEM Strings
        String 1: FUJITSU SIEMENS
        String 2: FUJITSU SIEMENS SYSTEM

Handle 0x001D, DMI type 12, 5 bytes
System Configuration Options
        Option 1: J18-20: Default position
        Option 2: J16-18: Reserved
        Option 3: J20-22: Recovery BIOS active

Handle 0x001E, DMI type 13, 22 bytes
BIOS Language Information
        Installable Languages: 1
                en|US|iso8859-1
        Currently Installed Language: en|US|iso8859-1

Handle 0x001F, DMI type 15, 29 bytes
System Event Log
        Area Length: 512 bytes
        Header Start Offset: 0x0000
        Header Length: 16 bytes
        Data Start Offset: 0x0010
        Access Method: Memory-mapped physical 32-bit address
        Access Address: 0xFFFF6027
        Status: Valid, Full
        Change Token: 0x0000000D
        Header Format: Type 1
        Supported Log Type Descriptors: 3
        Descriptor 1: POST error
        Data Format 1: POST results bitmap
        Descriptor 2: Single-bit ECC memory error
        Data Format 2: Multiple-event
        Descriptor 3: Multi-bit ECC memory error
        Data Format 3: Multiple-event

Handle 0x0020, DMI type 16, 15 bytes
Physical Memory Array
        Location: System Board Or Motherboard
        Use: System Memory
        Error Correction Type: None
        Maximum Capacity: 8 GB
        Error Information Handle: Not Provided
        Number Of Devices: 4

Handle 0x0021, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x0020
        Error Information Handle: No Error
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 512 MB
        Form Factor: DIMM
        Set: None
        Locator: Slot-1
        Bank Locator: Channel A
        Type: DDR2
        Type Detail: Synchronous
        Speed: 133 MHz (7.5 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0022, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x0020
        Error Information Handle: No Error
        Total Width: 64 bits
        Data Width: 64 bits
        Size: 512 MB
        Form Factor: DIMM
        Set: None
        Locator: Slot-2
        Bank Locator: Channel B
        Type: DDR2
        Type Detail: Unknown
        Speed: 133 MHz (7.5 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0023, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x0020
        Error Information Handle: No Error
        Total Width: Unknown
        Data Width: Unknown
        Size: No Module Installed
        Form Factor: DIMM
        Set: None
        Locator: Slot-3
        Bank Locator: Channel A
        Type: DDR2
        Type Detail: Unknown
        Speed: 133 MHz (7.5 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0024, DMI type 17, 27 bytes
Memory Device
        Array Handle: 0x0020
        Error Information Handle: No Error
        Total Width: Unknown
        Data Width: Unknown
        Size: No Module Installed
        Form Factor: DIMM
        Set: None
        Locator: Slot-4
        Bank Locator: Channel B
        Type: DDR2
        Type Detail: Unknown
        Speed: 133 MHz (7.5 ns)
        Manufacturer: Not Specified
        Serial Number: Not Specified
        Asset Tag: Not Specified
        Part Number: Not Specified

Handle 0x0025, DMI type 19, 15 bytes
Memory Array Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 GB
        Physical Array Handle: 0x0020
        Partition Width: 0

Handle 0x0026, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00000000000
        Ending Address: 0x0001FFFFFFF
        Range Size: 512 MB
        Physical Device Handle: 0x0021
        Memory Array Mapped Address Handle: 0x0025
        Partition Row Position: 1
        Interleaved Data Depth: 1

Handle 0x0027, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x00020000000
        Ending Address: 0x0003FFFFFFF
        Range Size: 512 MB
        Physical Device Handle: 0x0022
        Memory Array Mapped Address Handle: 0x0025
        Partition Row Position: 1
        Interleaved Data Depth: 1

Handle 0x0028, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x0003FFFFC00
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 kB
        Physical Device Handle: 0x0023
        Memory Array Mapped Address Handle: 0x0025
        Partition Row Position: 1
        Interleaved Data Depth: 1

Handle 0x0029, DMI type 20, 19 bytes
Memory Device Mapped Address
        Starting Address: 0x0003FFFFC00
        Ending Address: 0x0003FFFFFFF
        Range Size: 1 kB
        Physical Device Handle: 0x0024
        Memory Array Mapped Address Handle: 0x0025
        Partition Row Position: 1
        Interleaved Data Depth: 1

Handle 0x002A, DMI type 32, 11 bytes
System Boot Information
        Status: No errors detected

Handle 0x002B, DMI type 176, 16 bytes
OEM-specific Type
        Header and Data:
                B0 10 2B 00 10 00 61 24 00 19 FF FF 02 FF FF FF

Handle 0x002C, DMI type 177, 12 bytes
OEM-specific Type
        Header and Data:
                B1 0C 2C 00 11 04 11 01 00 00 00 00

Handle 0x002D, DMI type 185, 8 bytes
OEM-specific Type
        Header and Data:
                B9 08 2D 00 00 10 00 00

Handle 0x002E, DMI type 185, 8 bytes
OEM-specific Type
        Header and Data:
                B9 08 2E 00 01 10 00 00

Handle 0x002F, DMI type 185, 8 bytes
OEM-specific Type
        Header and Data:
                B9 08 2F 00 02 09 00 00

Handle 0x0030, DMI type 185, 8 bytes
OEM-specific Type
        Header and Data:
                B9 08 30 00 03 15 00 5C

Handle 0x0031, DMI type 185, 8 bytes
OEM-specific Type
        Header and Data:
                B9 08 31 00 07 15 00 5C

Handle 0x0032, DMI type 185, 8 bytes
OEM-specific Type
        Header and Data:
                B9 08 32 00 0F 10 00 00

Handle 0x0033, DMI type 185, 36 bytes
OEM-specific Type
        Header and Data:
                B9 24 33 00 13 07 01 14 00 00 00 02 31 00 00 00
                05 05 03 00 FB 07 02 00 00 00 08 19 A6 32 02 00
                00 00 00 00

Handle 0x0034, DMI type 185, 8 bytes
OEM-specific Type
        Header and Data:
                B9 08 34 00 15 10 00 00

Handle 0x0035, DMI type 185, 8 bytes
OEM-specific Type
        Header and Data:
                B9 08 35 00 18 15 01 5C

Handle 0x0036, DMI type 185, 36 bytes
OEM-specific Type
        Header and Data:
                B9 24 36 00 19 07 0C 05 03 00 FB 0D F5 0A F2 0D
                0E AC 0A B8 0D 10 0A 05 35 39 12 0A 05 4A 4D 00
                00 00 00 00

Handle 0x0037, DMI type 185, 8 bytes
OEM-specific Type
        Header and Data:
                B9 08 37 00 1E 02 17 5C

Handle 0x0038, DMI type 185, 16 bytes
OEM-specific Type
        Header and Data:
                B9 10 38 00 27 17 F0 02 DE 10 A2 00 11 22 10 00

Handle 0x0039, DMI type 185, 8 bytes
OEM-specific Type
        Header and Data:
                B9 08 39 00 FF 00 00 00

Handle 0x003A, DMI type 186, 15 bytes
OEM-specific Type
        Header and Data:
                BA 0F 3A 00 00 00 00 00 00 00 00 00 00 00 00

Handle 0x003B, DMI type 188, 8 bytes
OEM-specific Type
        Header and Data:
                BC 08 3B 00 38 38 31 24

Handle 0x003C, DMI type 127, 4 bytes
End Of Table

root@s15258863:~# cp
cp       cpan     cpgr     cpio     cpp      cpp-4.1  cppw
root@s15258863:~# cp
cp       cpan     cpgr     cpio     cpp      cpp-4.1  cppw
root@s15258863:~# cp
cp       cpan     cpgr     cpio     cpp      cpp-4.1  cppw

---------------------------------------------------------------------------=
--------------------------------

root@s15258863:~# cpuid-20060917/cpuid
CPU:
   vendor_id =3D "AuthenticAMD"
   version information (1/eax):
      processor type  =3D primary processor (0)
      family          =3D Intel Pentium 4/Pentium D/Pentium Extreme=20
Edition/Celeron/Xeon/Xeon MP/Itanium2, AMD Athlon 64/Athlon=20
XP-M/Opteron/Sempron/Turion (15)
      model           =3D 0xf (15)
      stepping id     =3D 0x1 (1)
      extended family =3D 0x0 (0)
      extended model  =3D 0x7 (7)
      (simple synth)  =3D AMD Opteron / Athlon 64 / Athlon 64 FX / Sempron =

/ Dual Core Opteron / Athlon 64 X2 / mobile Athlon 64 / mobile Sempron /=20
mobile Athlon XP-M (DP) (unknown model)
   miscellaneous (1/ebx):
      process local APIC physical ID =3D 0x0 (0)
      cpu count                      =3D 0x0 (0)
      CLFLUSH line size              =3D 0x8 (8)
      brand index                    =3D 0x0 (0)
   brand id =3D 0x00 (0): unknown
   feature information (1/edx):
      x87 FPU on chip                        =3D true
      virtual-8086 mode enhancement          =3D true
      debugging extensions                   =3D true
      page size extensions                   =3D true
      time stamp counter                     =3D true
      RDMSR and WRMSR support                =3D true
      physical address extensions            =3D true
      machine check exception                =3D true
      CMPXCHG8B inst.                        =3D true
      APIC on chip                           =3D true
      SYSENTER and SYSEXIT                   =3D true
      memory type range registers            =3D true
      PTE global bit                         =3D true
      machine check architecture             =3D true
      conditional move/compare instruction   =3D true
      page attribute table                   =3D true
      page size extension                    =3D true
      processor serial number                =3D false
      CLFLUSH instruction                    =3D true
      debug store                            =3D false
      thermal monitor and clock ctrl         =3D false
      MMX Technology                         =3D true
      FXSAVE/FXRSTOR                         =3D true
      SSE extensions                         =3D true
      SSE2 extensions                        =3D true
      self snoop                             =3D false
      hyper-threading / multi-core supported =3D false
      therm. monitor                         =3D false
      IA64                                   =3D false
      pending break event                    =3D false
   feature information (1/ecx):
      PNI/SSE3: Prescott New Instructions    =3D true
      MONITOR/MWAIT                          =3D false
      CPL-qualified debug store              =3D false
      VMX: virtual machine extensions        =3D false
      Enhanced Intel SpeedStep Technology    =3D false
      thermal monitor 2                      =3D false
      context ID: adaptive or shared L1 data =3D false
      cmpxchg16b available                   =3D true
      xTPR disable                           =3D false
   extended processor signature (0x80000001/eax):
      generation     =3D AMD Athlon 64/Opteron/Sempron/Turion (15)
      model          =3D 0xf (15)
      stepping       =3D 0x1 (1)
      (simple synth) =3D AMD Opteron / Athlon 64 / Sempron / Turion /=20
Athlon 64 FX / Athlon XP-M / mobile Athlon 64 / mobile Sempron / mobile=20
Athlon XP-M (unknown)
   extended feature flags (0x80000001/edx):
      x87 FPU on chip                       =3D true
      virtual-8086 mode enhancement         =3D true
      debugging extensions                  =3D true
      page size extensions                  =3D true
      time stamp counter                    =3D true
      RDMSR and WRMSR support               =3D true
      physical address extensions           =3D true
      machine check exception               =3D true
      CMPXCHG8B inst.                       =3D true
      APIC on chip                          =3D true
      SYSCALL and SYSRET instructions       =3D true
      memory type range registers           =3D true
      global paging extension               =3D true
      machine check architecture            =3D true
      conditional move/compare instruction  =3D true
      page attribute table                  =3D true
      page size extension                   =3D true
      multiprocessing capable               =3D false
      no-execute page protection            =3D true
      AMD multimedia instruction extensions =3D true
      MMX Technology                        =3D true
      FXSAVE/FXRSTOR                        =3D true
      SSE extensions                        =3D true
      RDTSCP                                =3D true
      long mode (AA-64)                     =3D true
      3DNow! instruction extensions         =3D true
      3DNow! instructions                   =3D true
   extended brand id =3D 0x894 (2196):
      MSB =3D desktop/DTR client, 32-bit (0b100010)
      NN  =3D 0x14 (20)
   AMD feature flags (0x80000001/ecx):
      LAHF/SAHF supported in 64-bit mode =3D true
      CMP Legacy                         =3D false
      SVM: secure virtual machine        =3D true
      AltMovCr8                          =3D true
   brand =3D "AMD Athlon(tm) 64 Processor 3500+"
   L1 TLB/cache information: 2M/4M pages & L1 TLB (0x80000005/eax):
      instruction # entries     =3D 0x8 (8)
      instruction associativity =3D 0xff (255)
      data # entries            =3D 0x8 (8)
      data associativity        =3D 0xff (255)
   L1 TLB/cache information: 4K pages & L1 TLB (0x80000005/ebx):
      instruction # entries     =3D 0x20 (32)
      instruction associativity =3D 0xff (255)
      data # entries            =3D 0x20 (32)
      data associativity        =3D 0xff (255)
   L1 data cache information (0x80000005/ecx):
      line size (bytes) =3D 0x40 (64)
      lines per tag     =3D 0x1 (1)
      associativity     =3D 0x2 (2)
      size (Kb)         =3D 0x40 (64)
   L1 instruction cache information (0x80000005/ecx):
      line size (bytes) =3D 0x40 (64)
      lines per tag     =3D 0x1 (1)
      associativity     =3D 0x2 (2)
      size (Kb)         =3D 0x40 (64)
   L2 TLB/cache information: 2M/4M pages & L2 TLB (0x80000006/eax):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D L2 off (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D L2 off (0)
   L2 TLB/cache information: 4K pages & L2 TLB (0x80000006/ebx):
      instruction # entries     =3D 0x200 (512)
      instruction associativity =3D 4-way (4)
      data # entries            =3D 0x200 (512)
      data associativity        =3D 4-way (4)
   L2 unified cache information (0x80000006/ecx):
      line size (bytes) =3D 0x40 (64)
      lines per tag     =3D 0x1 (1)
      associativity     =3D 16-way (8)
      size (Kb)         =3D 0x200 (512)
   Advanced Power Management Features (0x80000007/edx):
      temperature sensing diode      =3D 0x1 (1)
      frequency ID (FID) control     =3D 0x1 (1)
      voltage ID (VID) control       =3D 0x1 (1)
      thermal trip (TTP)             =3D 0x1 (1)
      thermal monitor (TM)           =3D 0x1 (1)
      software thermal control (STC) =3D 0x1 (1)
      TscInvariant                   =3D 0x0 (0)
   Physical Address and Linear Address Size (0x80000008/eax):
      maximum physical address =3D 0x28 (40)
      maximum linear address   =3D 0x30 (48)
   Logical CPU cores (0x80000008/ecx):
      number of logical CPU cores - 1 =3D 0x0 (0)
      ApicIdCoreIdSize                =3D 0x0 (0)
   SVM Secure Virtual Machine (0x8000000a/eax):
      SvmRev: SVM revision =3D 0x1 (1)
   SVM Secure Virtual Machine (0x8000000a/edx):
      LBR virtualization =3D false
   NASID: number of address space identifiers =3D 0x40 (64):
   (multi-processing synth): none
   (synth) =3D AMD Opteron / Athlon 64 / Athlon 64 FX / Sempron / Dual=20
Core Opteron / Athlon 64 X2 / mobile Athlon 64 / mobile Sempron / mobile=20
Athlon XP-M (DP) (unknown model) Processor 4400+

Juerg Haefliger wrote:
> Hi Lee,
>
>
> On Jan 29, 2008 10:49 AM, Lee Harris <lee.r.harris@googlemail.com> wrote:
>  =20
>> Hi
>>
>> I have installed lm-sensors on a remote server as it has been crashing
>> every few days and the logs show no obvious OS / software issues.
>>
>> I have got lm-sensors working I think ( after updating my kernel)
>>
>> My questions are:
>> What is RD1 temp ?
>>    =20
>
> Remote diode 1. Might be ambient.
>
>
>  =20
>> Which is the true cpu temp ? Core1 from K8temp or CPU temp from dme1737.
>>    =20
>
> What's the meaning of life? Who knows? No seriously, I can't speak for
> the k8temp but certain CPU types are broken and return bogus temp
> values. You might want to send the output of 'cat /proc/cpuinfo' to
> the list and have Rudolf M. take a look at it.
>
> For the dme1737 temps, either RD1 or RD2 can be the CPU temp, that
> depends on the board layout. It just happens that the current
> sensors.conf file labels RD2 as the CPU temp. But given the fact that
> RD2 (CPU) temp rises when you exercise the CPU and that it's the
> higher of the two is a strong indication that it is indeed the CPU
> temp. As for the accuracy of the reading, that depends on 2 factors
> which are controlled by the board manufacturer and BIOS
> implementation:
> 1) The conncted diode has to be of type 3904. If not, the reading will be=
 bogus.
> 2) The temp offset needs to be initialized properly by the BIOS. If
> not, the reading will be off.
>
> Check out the following link for guidlines on how to
> calibrate/validate your CPU temp readings:
> http://www.silentpcreview.com/article191-page1.html
>
>
>  =20
>> I ran a kernel compiling loop to 'burn' the cpu a little and both rose
>> about 8=B0C.
>> But is either a true figure ? Why the 20=B0 difference ?
>>
>> Sorry I can't give exact info on motherboard model as I have no physical
>> access to the server. I will include some lspci output below.
>> (I have set some sensors to Ignore in sensors.conf as they showed 0)
>>    =20
>
> Can you send the output of dmidecode to the list?
>
>
>  =20
>> Thanks for the software.
>> Lee
>>
>> ~# sensors
>> k8temp-pci-00c3
>> Adapter: PCI adapter
>> Core1 Temp:
>>              +42=B0C
>>    =20
>
> That's a little bit low for a CPU. What model/speed is it?
>
>
>  =20
>> dme1737-i2c-0-2e
>> Adapter: SMBus nForce2 adapter at 88c0
>> V3.3:      +3.35 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>> V3.3stby:  +3.31 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>> Vbat:      +3.01 V  (min =3D  +0.00 V, max =3D  +4.38 V)
>> RD1 Temp:    +40=B0C  (low  =3D  -127=B0C, high =3D   +61=B0C)
>> Int Temp:    +44=B0C  (low  =3D  -127=B0C, high =3D   +91=B0C)
>> CPU Temp:    +60=B0C  (low  =3D  -127=B0C, high =3D   +86=B0C)
>>    =20
>
> 60C looks like a real CPU temp to me.
>
> ...juerg
>
>
>  =20
>> CPU_Fan:  1680 RPM  (min =3D    0 RPM)
>> Fan3:     8557 RPM  (min =3D    0 RPM)
>> ERROR: Can't get fan5 data!
>> ERROR: Can't get fan6 data!
>> CPU_PWM:    67      (enable =3D 2, freq =3D  25000 Hz)
>> Fan3_PWM:   67      (enable =3D 2, freq =3D  25000 Hz)
>> ERROR: Can't get pwm5 data!
>> ERROR: Can't get pwm6 data!
>> cpu0_vid: +1.350 V  (VRM Version 2.4)
>>
>> --------------------------------------------
>>
>> 00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
>> 00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)
>> 00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)
>> 00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)
>> 00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)
>> 00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
>> 00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)
>> 00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)
>> 00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
>> 00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
>> 00:05.0 VGA compatible controller: nVidia Corporation C51 [GeForce 6150
>> LE] (rev a2)
>> 00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
>> 00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a3)
>> 00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
>> 00:0b.0 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
>> 00:0b.1 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
>> 00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev f1)
>> 00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller
>> (rev f1)
>> 00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2)
>> 00:14.0 Ethernet controller: nVidia Corporation MCP51 Ethernet
>> Controller (rev a3)
>> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
>> HyperTransport Technology Configuration
>> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
>> Address Map
>> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
>> DRAM Controller
>> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
>> Miscellaneous Control
>>
>> ------------------------------------------------
>>
>> 00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
>>         Subsystem: Fujitsu Siemens Computer GmbH Unknown device 10c6
>>         Flags: 66MHz, fast devsel, IRQ 10
>>         I/O ports at 88c0 [size=3D64]
>>         I/O ports at 8880 [size=3D64]
>>         Capabilities: [44] Power Management version 2
>>
>>
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>>    =20
>
>  =20

--------------060409020706020500040900
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Juerg<br>
<br>
Thanks for the reply. I will post the output of dmidecode and
/proc/cpuinfo below<br>
<br>
The reading I posted is at idle ( I should have been more specific)<br>
At full load core1 Temp rose to about 49&deg;C (from 42&deg; idle) and CPU temp
to 68&deg;C (from 60&deg; idle)<br>
<br>
I was thinking 60&deg; at idle was to high to be a true figure, but it is a
long time since I took much notice of cpu temps so I am only guessing ?<br>
<br>
The CPU is a Athlon 64 3500+ according to /proc/cpuinfo. I have come
across a linux cpuid program today and will also include the output
from this.<br>
<br>
Thanks Again <br>
Lee<br>
(By the way the server hasn't crashed so far :)&nbsp;&nbsp; )<br>
<br>
&nbsp;cat /proc/cpuinfo<br>
processor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0<br>
vendor_id&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : AuthenticAMD<br>
cpu family&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 15<br>
model&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 127<br>
model name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : AMD Athlon(tm) 64 Processor 3500+<br>
stepping&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 1<br>
cpu MHz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 2210.068<br>
cache size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 512 KB<br>
fpu&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : yes<br>
fpu_exception&nbsp;&nbsp; : yes<br>
cpuid level&nbsp;&nbsp;&nbsp;&nbsp; : 1<br>
wp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : yes<br>
flags&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt
rdtscp lm 3dnowext 3dnow up rep_good pni cx16 lahf_lm svm extapic
cr8_legacy 3dnowprefetch<br>
bogomips&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 4423.07<br>
TLB size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 1024 4K pages<br>
clflush size&nbsp;&nbsp;&nbsp; : 64<br>
cache_alignment : 64<br>
address sizes&nbsp;&nbsp; : 40 bits physical, 48 bits virtual<br>
power management: ts fid vid ttp tm stc 100mhzsteps<br>
<br>
--------------------------------------------------------------------------------------------------<br>
<br>
root@s15258863:~# dmidecode<br>
# dmidecode 2.9<br>
SMBIOS 2.4 present.<br>
61 structures occupying 1862 bytes.<br>
Table at 0x3EF6B000.<br>
<br>
Handle 0x0000, DMI type 0, 24 bytes<br>
BIOS Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Vendor: FUJITSU SIEMENS // Phoenix Technologies Ltd.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Version: 6.00 R1.11-04.2461.C1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Release Date: 04/19/2007<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Address: 0xE6640<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Runtime Size: 104896 bytes<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ROM Size: 512 kB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Characteristics:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PCI is supported<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PNP is supported<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIOS is upgradeable<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIOS shadowing is allowed<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ESCD support is available<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Boot from CD is supported<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Selectable boot is supported<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Japanese floppy for NEC 9800 1.2 MB is supported (int
13h)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Japanese floppy for Toshiba 1.2 MB is supported (int
13h)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.25"/360 KB floppy services are supported (int 13h)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.25"/1.2 MB floppy services are supported (int 13h)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.5"/720 KB floppy services are supported (int 13h)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.5"/2.88 MB floppy services are supported (int 13h)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Print screen service is supported (int 5h)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8042 keyboard services are supported (int 9h)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Serial services are supported (int 14h)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Printer services are supported (int 17h)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGA/mono video services are supported (int 10h)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACPI is supported<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USB legacy is supported<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LS-120 boot is supported<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ATAPI Zip drive boot is supported<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIOS boot specification is supported<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Targeted content distribution is supported<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIOS Revision: 1.17<br>
<br>
Handle 0x0001, DMI type 1, 27 bytes<br>
System Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: FUJITSU SIEMENS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Product Name: D2461-C1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Version:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Serial Number:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID: 00000000-0000-0000-0000-00199908E805<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Wake-up Type: Power Switch<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SKU Number: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Family: Not Specified<br>
<br>
Handle 0x0002, DMI type 2, 8 bytes<br>
Base Board Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: FUJITSU SIEMENS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Product Name: D2461-C1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Version: S26361-D2461-C1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Serial Number: 23671342<br>
<br>
Handle 0x0003, DMI type 3, 17 bytes<br>
Chassis Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: FUJITSU SIEMENS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: Mini Tower<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Lock: Present<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Version:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Serial Number:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Asset Tag:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Boot-up State: Safe<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Power Supply State: Safe<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thermal State: Safe<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Security Status: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OEM Information: 0x00000000<br>
<br>
Handle 0x0004, DMI type 4, 35 bytes<br>
Processor Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Socket Designation: Socket AM2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: Central Processor<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Family: Opteron<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: AMD<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ID: F1 0F 07 00 FF FB 8B 07<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Signature: Family 15, Model 127, Stepping 1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FPU (Floating-point unit on-chip)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VME (Virtual mode extension)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DE (Debugging extension)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSE (Page size extension)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TSC (Time stamp counter)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSR (Model specific registers)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAE (Physical address extension)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MCE (Machine check exception)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CX8 (CMPXCHG8 instruction supported)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; APIC (On-chip APIC hardware supported)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SEP (Fast system call)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTRR (Memory type range registers)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PGE (Page global enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MCA (Machine check architecture)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CMOV (Conditional move instruction supported)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAT (Page attribute table)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSE-36 (36-bit page size extension)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLFSH (CLFLUSH instruction supported)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMX (MMX technology supported)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FXSR (Fast floating-point save and restore)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SSE (Streaming SIMD extensions)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SSE2 (Streaming SIMD extensions 2)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Version: AMD<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Voltage: 1.6 V<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Clock: 133 MHz<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Max Speed: 2200 MHz<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Current Speed: 2200 MHz<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Populated, Enabled<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Upgrade: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L1 Cache Handle: 0x0005<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L2 Cache Handle: 0x0006<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L3 Cache Handle: Not Provided<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Serial Number: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Asset Tag: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Part Number: Not Specified<br>
<br>
Handle 0x0005, DMI type 7, 19 bytes<br>
Cache Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Socket Designation: L1 Cache<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Configuration: Enabled, Not Socketed, Level 1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Operational Mode: Write Back<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Location: Internal<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Installed Size: 64 KB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Maximum Size: 64 KB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supported SRAM Types:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Burst<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pipeline Burst<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Asynchronous<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Installed SRAM Type: Asynchronous<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Speed: Unknown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error Correction Type: Unknown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; System Type: Unknown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Associativity: Unknown<br>
<br>
Handle 0x0006, DMI type 7, 19 bytes<br>
Cache Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Socket Designation: L2 Cache<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Configuration: Enabled, Not Socketed, Level 2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Operational Mode: Write Through<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Location: Internal<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Installed Size: 512 KB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Maximum Size: 512 KB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supported SRAM Types:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Burst<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pipeline Burst<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Synchronous<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Installed SRAM Type: Synchronous<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Speed: Unknown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error Correction Type: Unknown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; System Type: Unified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Associativity: Unknown<br>
<br>
Handle 0x0007, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: SMsC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: Serial-1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: DB-9 male<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: Serial Port 16550 Compatible<br>
<br>
Handle 0x0008, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: MCP51<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: LAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: RJ-45<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: Network Port<br>
<br>
Handle 0x0009, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: NVIDIA C51PVG<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: Video<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: DB-15 female<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: Video Port<br>
<br>
Handle 0x000A, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: MCP51<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: Rear: USB-1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: Access Bus (USB)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: USB<br>
<br>
Handle 0x000B, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: MCP51<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: Rear: USB-2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: Access Bus (USB)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: USB<br>
<br>
Handle 0x000C, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: MCP51<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: Rear: USB-3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: Access Bus (USB)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: USB<br>
<br>
Handle 0x000D, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: MCP51<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: Rear: USB-4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: Access Bus (USB)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: USB<br>
<br>
Handle 0x000E, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: NVIDIA C51PVG<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: Video<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: DB-15 female<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: Video Port<br>
<br>
Handle 0x000F, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: Realtek ALC260<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: Rear: Line-In<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: Mini Jack (headphones)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: Audio Port<br>
<br>
Handle 0x0010, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: Realtek ALC260<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: Rear: Line-Out<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: Mini Jack (headphones)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: Audio Port<br>
<br>
Handle 0x0011, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: Realtek ALC260<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: Rear: Mic-In<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: Mini Jack (headphones)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: Audio Port<br>
<br>
Handle 0x0012, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: SMsC<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: On Board Floppy<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: Floppy<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: None<br>
<br>
Handle 0x0013, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: MCP51<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: Other<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: SATA-1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: None<br>
<br>
Handle 0x0014, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: MCP51<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: Other<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: SATA-2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: None<br>
<br>
Handle 0x0015, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: MCP51<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: Other<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: SATA-3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: None<br>
<br>
Handle 0x0016, DMI type 8, 9 bytes<br>
Port Connector Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Reference Designator: MCP51<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Internal Connector Type: Other<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Reference Designator: SATA-4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; External Connector Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Port Type: None<br>
<br>
Handle 0x0017, DMI type 9, 13 bytes<br>
System Slot Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Designation: PCIe x16<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: x16 PCI Express<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Current Usage: Available<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Length: Long<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ID: 1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Characteristics:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.3 V is provided<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PME signal is supported<br>
<br>
Handle 0x0018, DMI type 9, 13 bytes<br>
System Slot Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Designation: PCIe-1 x1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: x1 PCI Express<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Current Usage: Available<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Length: Long<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ID: 3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Characteristics:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.3 V is provided<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PME signal is supported<br>
<br>
Handle 0x0019, DMI type 9, 13 bytes<br>
System Slot Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Designation: PCI Slot 1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: 32-bit PCI<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Current Usage: Available<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Length: Long<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ID: 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Characteristics:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.3 V is provided<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PME signal is supported<br>
<br>
Handle 0x001A, DMI type 9, 13 bytes<br>
System Slot Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Designation: PCI Slot 2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: 32-bit PCI<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Current Usage: Available<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Length: Long<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ID: 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Characteristics:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.3 V is provided<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PME signal is supported<br>
<br>
Handle 0x001B, DMI type 10, 14 bytes<br>
On Board Device 1 Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: Other<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Disabled<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Description: SMsC SuperI/O<br>
On Board Device 2 Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: Sound<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Disabled<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Description: Realtek ALC260<br>
On Board Device 3 Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: Video<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Disabled<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Description: NVIDIA C51PVG<br>
On Board Device 4 Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: Other<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Disabled<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Description: Antaios<br>
On Board Device 5 Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: Ethernet<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Disabled<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Description: MCP51<br>
<br>
Handle 0x001C, DMI type 11, 5 bytes<br>
OEM Strings<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String 1: FUJITSU SIEMENS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String 2: FUJITSU SIEMENS SYSTEM<br>
<br>
Handle 0x001D, DMI type 12, 5 bytes<br>
System Configuration Options<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Option 1: J18-20: Default position<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Option 2: J16-18: Reserved<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Option 3: J20-22: Recovery BIOS active<br>
<br>
Handle 0x001E, DMI type 13, 22 bytes<br>
BIOS Language Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Installable Languages: 1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; en|US|iso8859-1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Currently Installed Language: en|US|iso8859-1<br>
<br>
Handle 0x001F, DMI type 15, 29 bytes<br>
System Event Log<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Area Length: 512 bytes<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header Start Offset: 0x0000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header Length: 16 bytes<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data Start Offset: 0x0010<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Access Method: Memory-mapped physical 32-bit address<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Access Address: 0xFFFF6027<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: Valid, Full<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Change Token: 0x0000000D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header Format: Type 1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supported Log Type Descriptors: 3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Descriptor 1: POST error<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data Format 1: POST results bitmap<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Descriptor 2: Single-bit ECC memory error<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data Format 2: Multiple-event<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Descriptor 3: Multi-bit ECC memory error<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data Format 3: Multiple-event<br>
<br>
Handle 0x0020, DMI type 16, 15 bytes<br>
Physical Memory Array<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Location: System Board Or Motherboard<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use: System Memory<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error Correction Type: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Maximum Capacity: 8 GB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error Information Handle: Not Provided<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Number Of Devices: 4<br>
<br>
Handle 0x0021, DMI type 17, 27 bytes<br>
Memory Device<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Array Handle: 0x0020<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error Information Handle: No Error<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Width: 64 bits<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data Width: 64 bits<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size: 512 MB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Form Factor: DIMM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Locator: Slot-1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bank Locator: Channel A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: DDR2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type Detail: Synchronous<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Speed: 133 MHz (7.5 ns)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Serial Number: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Asset Tag: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Part Number: Not Specified<br>
<br>
Handle 0x0022, DMI type 17, 27 bytes<br>
Memory Device<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Array Handle: 0x0020<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error Information Handle: No Error<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Width: 64 bits<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data Width: 64 bits<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size: 512 MB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Form Factor: DIMM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Locator: Slot-2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bank Locator: Channel B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: DDR2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type Detail: Unknown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Speed: 133 MHz (7.5 ns)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Serial Number: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Asset Tag: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Part Number: Not Specified<br>
<br>
Handle 0x0023, DMI type 17, 27 bytes<br>
Memory Device<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Array Handle: 0x0020<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error Information Handle: No Error<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Width: Unknown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data Width: Unknown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size: No Module Installed<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Form Factor: DIMM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Locator: Slot-3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bank Locator: Channel A<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: DDR2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type Detail: Unknown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Speed: 133 MHz (7.5 ns)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Serial Number: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Asset Tag: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Part Number: Not Specified<br>
<br>
Handle 0x0024, DMI type 17, 27 bytes<br>
Memory Device<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Array Handle: 0x0020<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Error Information Handle: No Error<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Width: Unknown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Data Width: Unknown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size: No Module Installed<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Form Factor: DIMM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set: None<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Locator: Slot-4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bank Locator: Channel B<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type: DDR2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type Detail: Unknown<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Speed: 133 MHz (7.5 ns)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Serial Number: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Asset Tag: Not Specified<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Part Number: Not Specified<br>
<br>
Handle 0x0025, DMI type 19, 15 bytes<br>
Memory Array Mapped Address<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Starting Address: 0x00000000000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ending Address: 0x0003FFFFFFF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Range Size: 1 GB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Physical Array Handle: 0x0020<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Partition Width: 0<br>
<br>
Handle 0x0026, DMI type 20, 19 bytes<br>
Memory Device Mapped Address<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Starting Address: 0x00000000000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ending Address: 0x0001FFFFFFF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Range Size: 512 MB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Physical Device Handle: 0x0021<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory Array Mapped Address Handle: 0x0025<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Partition Row Position: 1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interleaved Data Depth: 1<br>
<br>
Handle 0x0027, DMI type 20, 19 bytes<br>
Memory Device Mapped Address<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Starting Address: 0x00020000000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ending Address: 0x0003FFFFFFF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Range Size: 512 MB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Physical Device Handle: 0x0022<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory Array Mapped Address Handle: 0x0025<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Partition Row Position: 1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interleaved Data Depth: 1<br>
<br>
Handle 0x0028, DMI type 20, 19 bytes<br>
Memory Device Mapped Address<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Starting Address: 0x0003FFFFC00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ending Address: 0x0003FFFFFFF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Range Size: 1 kB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Physical Device Handle: 0x0023<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory Array Mapped Address Handle: 0x0025<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Partition Row Position: 1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interleaved Data Depth: 1<br>
<br>
Handle 0x0029, DMI type 20, 19 bytes<br>
Memory Device Mapped Address<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Starting Address: 0x0003FFFFC00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ending Address: 0x0003FFFFFFF<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Range Size: 1 kB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Physical Device Handle: 0x0024<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory Array Mapped Address Handle: 0x0025<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Partition Row Position: 1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Interleaved Data Depth: 1<br>
<br>
Handle 0x002A, DMI type 32, 11 bytes<br>
System Boot Information<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Status: No errors detected<br>
<br>
Handle 0x002B, DMI type 176, 16 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B0 10 2B 00 10 00 61 24 00 19 FF FF 02 FF FF FF<br>
<br>
Handle 0x002C, DMI type 177, 12 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B1 0C 2C 00 11 04 11 01 00 00 00 00<br>
<br>
Handle 0x002D, DMI type 185, 8 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 08 2D 00 00 10 00 00<br>
<br>
Handle 0x002E, DMI type 185, 8 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 08 2E 00 01 10 00 00<br>
<br>
Handle 0x002F, DMI type 185, 8 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 08 2F 00 02 09 00 00<br>
<br>
Handle 0x0030, DMI type 185, 8 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 08 30 00 03 15 00 5C<br>
<br>
Handle 0x0031, DMI type 185, 8 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 08 31 00 07 15 00 5C<br>
<br>
Handle 0x0032, DMI type 185, 8 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 08 32 00 0F 10 00 00<br>
<br>
Handle 0x0033, DMI type 185, 36 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 24 33 00 13 07 01 14 00 00 00 02 31 00 00 00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 05 05 03 00 FB 07 02 00 00 00 08 19 A6 32 02 00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 00 00 00<br>
<br>
Handle 0x0034, DMI type 185, 8 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 08 34 00 15 10 00 00<br>
<br>
Handle 0x0035, DMI type 185, 8 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 08 35 00 18 15 01 5C<br>
<br>
Handle 0x0036, DMI type 185, 36 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 24 36 00 19 07 0C 05 03 00 FB 0D F5 0A F2 0D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0E AC 0A B8 0D 10 0A 05 35 39 12 0A 05 4A 4D 00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00 00 00 00<br>
<br>
Handle 0x0037, DMI type 185, 8 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 08 37 00 1E 02 17 5C<br>
<br>
Handle 0x0038, DMI type 185, 16 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 10 38 00 27 17 F0 02 DE 10 A2 00 11 22 10 00<br>
<br>
Handle 0x0039, DMI type 185, 8 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; B9 08 39 00 FF 00 00 00<br>
<br>
Handle 0x003A, DMI type 186, 15 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BA 0F 3A 00 00 00 00 00 00 00 00 00 00 00 00<br>
<br>
Handle 0x003B, DMI type 188, 8 bytes<br>
OEM-specific Type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Header and Data:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BC 08 3B 00 38 38 31 24<br>
<br>
Handle 0x003C, DMI type 127, 4 bytes<br>
End Of Table<br>
<br>
root@s15258863:~# cp<br>
cp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpan&nbsp;&nbsp;&nbsp;&nbsp; cpgr&nbsp;&nbsp;&nbsp;&nbsp; cpio&nbsp;&nbsp;&nbsp;&nbsp; cpp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpp-4.1&nbsp; cppw<br>
root@s15258863:~# cp<br>
cp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpan&nbsp;&nbsp;&nbsp;&nbsp; cpgr&nbsp;&nbsp;&nbsp;&nbsp; cpio&nbsp;&nbsp;&nbsp;&nbsp; cpp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpp-4.1&nbsp; cppw<br>
root@s15258863:~# cp<br>
cp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpan&nbsp;&nbsp;&nbsp;&nbsp; cpgr&nbsp;&nbsp;&nbsp;&nbsp; cpio&nbsp;&nbsp;&nbsp;&nbsp; cpp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpp-4.1&nbsp; cppw<br>
<br>
-----------------------------------------------------------------------------------------------------------<br>
<br>
root@s15258863:~# cpuid-20060917/cpuid<br>
CPU:<br>
&nbsp;&nbsp; vendor_id = "AuthenticAMD"<br>
&nbsp;&nbsp; version information (1/eax):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; processor type&nbsp; = primary processor (0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; family&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = Intel Pentium 4/Pentium D/Pentium Extreme
Edition/Celeron/Xeon/Xeon MP/Itanium2, AMD Athlon 64/Athlon
XP-M/Opteron/Sempron/Turion (15)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; model&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0xf (15)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stepping id&nbsp;&nbsp;&nbsp;&nbsp; = 0x1 (1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extended family = 0x0 (0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extended model&nbsp; = 0x7 (7)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (simple synth)&nbsp; = AMD Opteron / Athlon 64 / Athlon 64 FX /
Sempron / Dual Core Opteron / Athlon 64 X2 / mobile Athlon 64 / mobile
Sempron / mobile Athlon XP-M (DP) (unknown model)<br>
&nbsp;&nbsp; miscellaneous (1/ebx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process local APIC physical ID = 0x0 (0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x0 (0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLFLUSH line size&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x8 (8)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brand index&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x0 (0)<br>
&nbsp;&nbsp; brand id = 0x00 (0): unknown<br>
&nbsp;&nbsp; feature information (1/edx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x87 FPU on chip&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtual-8086 mode enhancement&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugging extensions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page size extensions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; time stamp counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RDMSR and WRMSR support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; physical address extensions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; machine check exception&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CMPXCHG8B inst.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; APIC on chip&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SYSENTER and SYSEXIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memory type range registers&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PTE global bit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; machine check architecture&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conditional move/compare instruction&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page attribute table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page size extension&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; processor serial number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CLFLUSH instruction&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debug store&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thermal monitor and clock ctrl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMX Technology&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FXSAVE/FXRSTOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SSE extensions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SSE2 extensions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self snoop&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hyper-threading / multi-core supported = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; therm. monitor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IA64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pending break event&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp; feature information (1/ecx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PNI/SSE3: Prescott New Instructions&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MONITOR/MWAIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPL-qualified debug store&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMX: virtual machine extensions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Enhanced Intel SpeedStep Technology&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thermal monitor 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context ID: adaptive or shared L1 data = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmpxchg16b available&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xTPR disable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp; extended processor signature (0x80000001/eax):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; generation&nbsp;&nbsp;&nbsp;&nbsp; = AMD Athlon 64/Opteron/Sempron/Turion (15)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; model&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0xf (15)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stepping&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x1 (1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (simple synth) = AMD Opteron / Athlon 64 / Sempron / Turion /
Athlon 64 FX / Athlon XP-M / mobile Athlon 64 / mobile Sempron / mobile
Athlon XP-M (unknown)<br>
&nbsp;&nbsp; extended feature flags (0x80000001/edx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x87 FPU on chip&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtual-8086 mode enhancement&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugging extensions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page size extensions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; time stamp counter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RDMSR and WRMSR support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; physical address extensions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; machine check exception&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CMPXCHG8B inst.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; APIC on chip&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SYSCALL and SYSRET instructions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memory type range registers&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; global paging extension&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; machine check architecture&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conditional move/compare instruction&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page attribute table&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page size extension&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; multiprocessing capable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no-execute page protection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD multimedia instruction extensions = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MMX Technology&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FXSAVE/FXRSTOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SSE extensions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RDTSCP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long mode (AA-64)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3DNow! instruction extensions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3DNow! instructions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp; extended brand id = 0x894 (2196):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSB = desktop/DTR client, 32-bit (0b100010)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NN&nbsp; = 0x14 (20)<br>
&nbsp;&nbsp; AMD feature flags (0x80000001/ecx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LAHF/SAHF supported in 64-bit mode = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CMP Legacy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = false<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SVM: secure virtual machine&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AltMovCr8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = true<br>
&nbsp;&nbsp; brand = "AMD Athlon(tm) 64 Processor 3500+"<br>
&nbsp;&nbsp; L1 TLB/cache information: 2M/4M pages &amp; L1 TLB (0x80000005/eax):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instruction # entries&nbsp;&nbsp;&nbsp;&nbsp; = 0x8 (8)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instruction associativity = 0xff (255)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data # entries&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x8 (8)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data associativity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0xff (255)<br>
&nbsp;&nbsp; L1 TLB/cache information: 4K pages &amp; L1 TLB (0x80000005/ebx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instruction # entries&nbsp;&nbsp;&nbsp;&nbsp; = 0x20 (32)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instruction associativity = 0xff (255)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data # entries&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x20 (32)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data associativity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0xff (255)<br>
&nbsp;&nbsp; L1 data cache information (0x80000005/ecx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; line size (bytes) = 0x40 (64)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lines per tag&nbsp;&nbsp;&nbsp;&nbsp; = 0x1 (1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; associativity&nbsp;&nbsp;&nbsp;&nbsp; = 0x2 (2)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size (Kb)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x40 (64)<br>
&nbsp;&nbsp; L1 instruction cache information (0x80000005/ecx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; line size (bytes) = 0x40 (64)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lines per tag&nbsp;&nbsp;&nbsp;&nbsp; = 0x1 (1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; associativity&nbsp;&nbsp;&nbsp;&nbsp; = 0x2 (2)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size (Kb)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x40 (64)<br>
&nbsp;&nbsp; L2 TLB/cache information: 2M/4M pages &amp; L2 TLB (0x80000006/eax):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instruction # entries&nbsp;&nbsp;&nbsp;&nbsp; = 0x0 (0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instruction associativity = L2 off (0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data # entries&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x0 (0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data associativity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = L2 off (0)<br>
&nbsp;&nbsp; L2 TLB/cache information: 4K pages &amp; L2 TLB (0x80000006/ebx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instruction # entries&nbsp;&nbsp;&nbsp;&nbsp; = 0x200 (512)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instruction associativity = 4-way (4)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data # entries&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x200 (512)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data associativity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 4-way (4)<br>
&nbsp;&nbsp; L2 unified cache information (0x80000006/ecx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; line size (bytes) = 0x40 (64)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lines per tag&nbsp;&nbsp;&nbsp;&nbsp; = 0x1 (1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; associativity&nbsp;&nbsp;&nbsp;&nbsp; = 16-way (8)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size (Kb)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x200 (512)<br>
&nbsp;&nbsp; Advanced Power Management Features (0x80000007/edx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temperature sensing diode&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x1 (1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frequency ID (FID) control&nbsp;&nbsp;&nbsp;&nbsp; = 0x1 (1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voltage ID (VID) control&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x1 (1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thermal trip (TTP)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x1 (1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thermal monitor (TM)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x1 (1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; software thermal control (STC) = 0x1 (1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TscInvariant&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x0 (0)<br>
&nbsp;&nbsp; Physical Address and Linear Address Size (0x80000008/eax):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; maximum physical address = 0x28 (40)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; maximum linear address&nbsp;&nbsp; = 0x30 (48)<br>
&nbsp;&nbsp; Logical CPU cores (0x80000008/ecx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; number of logical CPU cores - 1 = 0x0 (0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ApicIdCoreIdSize&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0x0 (0)<br>
&nbsp;&nbsp; SVM Secure Virtual Machine (0x8000000a/eax):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SvmRev: SVM revision = 0x1 (1)<br>
&nbsp;&nbsp; SVM Secure Virtual Machine (0x8000000a/edx):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LBR virtualization = false<br>
&nbsp;&nbsp; NASID: number of address space identifiers = 0x40 (64):<br>
&nbsp;&nbsp; (multi-processing synth): none<br>
&nbsp;&nbsp; (synth) = AMD Opteron / Athlon 64 / Athlon 64 FX / Sempron / Dual
Core Opteron / Athlon 64 X2 / mobile Athlon 64 / mobile Sempron /
mobile Athlon XP-M (DP) (unknown model) Processor 4400+<br>
<br>
<pre wrap="">
</pre>
Juerg Haefliger wrote:
<blockquote
 cite="mid:191fb4ca0801291139x83b3043k9071ae44e245ed@mail.gmail.com"
 type="cite">
  <pre wrap="">Hi Lee,


On Jan 29, 2008 10:49 AM, Lee Harris <a class="moz-txt-link-rfc2396E" href="mailto:lee.r.harris@googlemail.com">&lt;lee.r.harris@googlemail.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi

I have installed lm-sensors on a remote server as it has been crashing
every few days and the logs show no obvious OS / software issues.

I have got lm-sensors working I think ( after updating my kernel)

My questions are:
What is RD1 temp ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Remote diode 1. Might be ambient.


  </pre>
  <blockquote type="cite">
    <pre wrap="">Which is the true cpu temp ? Core1 from K8temp or CPU temp from dme1737.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
What's the meaning of life? Who knows? No seriously, I can't speak for
the k8temp but certain CPU types are broken and return bogus temp
values. You might want to send the output of 'cat /proc/cpuinfo' to
the list and have Rudolf M. take a look at it.

For the dme1737 temps, either RD1 or RD2 can be the CPU temp, that
depends on the board layout. It just happens that the current
sensors.conf file labels RD2 as the CPU temp. But given the fact that
RD2 (CPU) temp rises when you exercise the CPU and that it's the
higher of the two is a strong indication that it is indeed the CPU
temp. As for the accuracy of the reading, that depends on 2 factors
which are controlled by the board manufacturer and BIOS
implementation:
1) The conncted diode has to be of type 3904. If not, the reading will be bogus.
2) The temp offset needs to be initialized properly by the BIOS. If
not, the reading will be off.

Check out the following link for guidlines on how to
calibrate/validate your CPU temp readings:
<a class="moz-txt-link-freetext" href="http://www.silentpcreview.com/article191-page1.html">http://www.silentpcreview.com/article191-page1.html</a>


  </pre>
  <blockquote type="cite">
    <pre wrap="">I ran a kernel compiling loop to 'burn' the cpu a little and both rose
about 8&deg;C.
But is either a true figure ? Why the 20&deg; difference ?

Sorry I can't give exact info on motherboard model as I have no physical
access to the server. I will include some lspci output below.
(I have set some sensors to Ignore in sensors.conf as they showed 0)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Can you send the output of dmidecode to the list?


  </pre>
  <blockquote type="cite">
    <pre wrap="">Thanks for the software.
Lee

~# sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core1 Temp:
             +42&deg;C
    </pre>
  </blockquote>
  <pre wrap=""><!---->
That's a little bit low for a CPU. What model/speed is it?


  </pre>
  <blockquote type="cite">
    <pre wrap="">dme1737-i2c-0-2e
Adapter: SMBus nForce2 adapter at 88c0
V3.3:      +3.35 V  (min =  +0.00 V, max =  +4.38 V)
V3.3stby:  +3.31 V  (min =  +0.00 V, max =  +4.38 V)
Vbat:      +3.01 V  (min =  +0.00 V, max =  +4.38 V)
RD1 Temp:    +40&deg;C  (low  =  -127&deg;C, high =   +61&deg;C)
Int Temp:    +44&deg;C  (low  =  -127&deg;C, high =   +91&deg;C)
CPU Temp:    +60&deg;C  (low  =  -127&deg;C, high =   +86&deg;C)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
60C looks like a real CPU temp to me.

...juerg


  </pre>
  <blockquote type="cite">
    <pre wrap="">CPU_Fan:  1680 RPM  (min =    0 RPM)
Fan3:     8557 RPM  (min =    0 RPM)
ERROR: Can't get fan5 data!
ERROR: Can't get fan6 data!
CPU_PWM:    67      (enable = 2, freq =  25000 Hz)
Fan3_PWM:   67      (enable = 2, freq =  25000 Hz)
ERROR: Can't get pwm5 data!
ERROR: Can't get pwm6 data!
cpu0_vid: +1.350 V  (VRM Version 2.4)

--------------------------------------------

00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)
00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)
00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)
00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)
00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)
00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)
00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
00:05.0 VGA compatible controller: nVidia Corporation C51 [GeForce 6150
LE] (rev a2)
00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a3)
00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
00:0b.0 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
00:0b.1 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev f1)
00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller
(rev f1)
00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2)
00:14.0 Ethernet controller: nVidia Corporation MCP51 Ethernet
Controller (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control

------------------------------------------------

00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
        Subsystem: Fujitsu Siemens Computer GmbH Unknown device 10c6
        Flags: 66MHz, fast devsel, IRQ 10
        I/O ports at 88c0 [size=64]
        I/O ports at 8880 [size=64]
        Capabilities: [44] Power Management version 2



_______________________________________________
lm-sensors mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a>
<a class="moz-txt-link-freetext" href="http://lists.lm-sensors.org/mailman/listinfo/lm-sensors">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a>

    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
</blockquote>
</body>
</html>

--------------060409020706020500040900--


--===============4946204343925101650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4946204343925101650==--
