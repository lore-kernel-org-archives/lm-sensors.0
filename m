From: achim <achim@ag-web.biz>
Date: Sat, 03 May 2008 15:27:34 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <1209828454.4289.1.camel@debian-9850.ag-home.muc>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-z8hpS1gwcURLbhjyf2O0"
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
To: lm-sensors@vger.kernel.org


--=-z8hpS1gwcURLbhjyf2O0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Jean and Pavel,

Thank you for the fast replies.

I run debian lenny 64bit which comes with sensors version 3.0.1. The
debian package version is 3.0.1-5.

The board has no special overclocking chip. It comes with an 8-pin
connector for the 12V rails so the cpu can use up to 36A and therefore
has more headroom for overclocking at my settings the cpu used max
11-12A. (I have an Gigabyte Odin PSU with monitoring software whom shows
the power usage of the single rails and tested this issue before).
Also it has few more memory settings and allows to adjust the cpu and nb
voltage in steps ov 0.0625V. Those features make it overclockers first
choice.

The cpu was abit overclocked while i ran sensors-detect. I used an 13.5
cpu multi instead of an 12.5 multi and had uppdet the cpu voltage from
1.3V to 1.3125V. Everything else was at stock.
Before I ran sensors-detect I ran the phoronix-test-suite for
benchmarking purpose whom showed no problems. Normaly one of the cores
stopps responding if I overclock the system too far, that did not happen
before at 2.7GHz, it started at around 2.8GHz.

I have not yet contacted Sapphire. The board however is a clone of the
DFI Lanparty UT790FX. On an overclocker forum I found an user report
whom had a similar problem. In his case speedfan caused his board/cpu 
not to post. He contacted DFI and they said it can be that lower io
access can cripple the bios. There are other users on that forum whom
reported similar issues after starting sandra or evereset. Sometimes it
is the bios getting corrupted sometimes it's the cpu getting stuck at C1
stage during post. Sometimes it helps to cool down the cpu below zero
and it posts back. In other cases it helped to use DDR2-800 ram instead
of DDR2-1066 ram. I tried to reflash the bios and cleared the cmos and
dmi area but it did not help. I also tried to use DDR2-800 memory
without luck. I can sort out a crippled bios in my case bcause the board
still works fine with an 9600BE. 

The board uses the ITC8716F-S chip and the it87 module works fine if i
load it manual. I'd like to look a little deeper into that sensor chip
reading issues so i'll start to read the source code now to find out
what happens. I attached the dmidecode and the lspci -nnv output.

---------- kenrel log output of the it87 module ----------------
it87: Found IT8716F chip at 0x228, revision 3
it87: in3 is VCC (+5V)
it87: in7 is VCCH (+5V Stand-By)
hwmon-vid: Unknown VRM version of your x86 CPU
----------------------------------------------------------------

achim~

> 
> Hmm, that's bad. First report of this type as far as I remember. Which
> version of sensors-detect did you run exactly?
> 
> Do you know if the Sapphire AM2RD790 has some special chip on the
> SMBus? I see that this board is "the clear choice for overclocking
> enthusiasts", maybe some overclocking chip on the SMBus was accessed
> during SMBus probing of sensors-detect and it didn't like that... Do
> you have a contact at Sapphire who could answer such technical
> questions?
> 
> Was the CPU overclocked at the time you ran sensors-detect?
> 
> If you can provide the dmidecode output for the Sapphire AM2RD790,
> maybe we can blacklist it in sensors-detect or even prevent the SMBus
> driver from loading (we'll need the output of lspci -nnv for that). In
> the meantime I'll put a note on our website so that other users don't
> kill their CPUs too.
> 

--=-z8hpS1gwcURLbhjyf2O0
Content-Disposition: attachment; filename=sapphire-790FX-dmidecode.txt
Content-Type: text/plain; name=sapphire-790FX-dmidecode.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

# dmidecode 2.9
SMBIOS 2.5 present.
54 structures occupying 2272 bytes.
Table at 0x000F0000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies, LTD
	Version: 6.00 PG
	Release Date: 04/15/2008
	Address: 0xE0000
	Runtime Size: 128 kB
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
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

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Unknow
	Product Name: Unknow
	Version: Unknow
	Serial Number: Unknow
	UUID: Not Present
	Wake-up Type: Power Switch
	SKU Number:  
	Family:  

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: SAPPHIRE Inc.
	Product Name: PC-AM2RD790
	Version: 1.0
	Serial Number:  

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Unknow
	Type: Desktop
	Lock: Not Present
	Version: Unknow
	Serial Number:  
	Asset Tag:  
	Boot-up State: Unknown
	Power Supply State: Unknown
	Thermal State: Unknown
	Security Status: Unknown
	OEM Information: 0x00000000

Handle 0x0004, DMI type 4, 40 bytes
Processor Information
	Socket Designation: Socket AM2 
	Type: Central Processor
	Family: Pentium Pro
	Manufacturer: AMD
	ID: 22 0F 10 00 FF FB 8B 17
	Signature: Type 0, Family 16, Model 2, Stepping 2
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
		HTT (Hyper-threading technology)
	Version: AMD Phenom(tm) 9600 Quad-Core Processor
	Voltage: 1.5 V
	External Clock: 255 MHz
	Max Speed: 3000 MHz
	Current Speed: 1148 MHz
	Status: Populated, Enabled
	Upgrade: Socket 940
	L1 Cache Handle: 0x000A
	L2 Cache Handle: 0x000B
	L3 Cache Handle: Not Provided
	Serial Number:  
	Asset Tag:  
	Part Number:  
	Core Count: 2
	Core Enabled: 2
	Thread Count: 2
	Characteristics:
		64-bit capable

Handle 0x0005, DMI type 5, 24 bytes
Memory Controller Information
	Error Detecting Method: 64-bit ECC
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 4096 MB
	Maximum Total Memory Size: 16384 MB
	Supported Speeds:
		70 ns
		60 ns
		50 ns
	Supported Memory Types:
		Standard
		DIMM
	Memory Module Voltage: 2.9 V
	Associated Memory Slots: 4
		0x0006
		0x0007
		0x0008
		0x0009
	Enabled Error Correcting Capabilities: None

Handle 0x0006, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A0
	Bank Connections: None
	Current Speed: Unknown
	Type: Other Unknown EDO
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A1
	Bank Connections: None
	Current Speed: Unknown
	Type: Other Unknown EDO
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: OK

Handle 0x0008, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A2
	Bank Connections: 4 5
	Current Speed: Unknown
	Type: Other Unknown EDO
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: A3
	Bank Connections: 6 7
	Current Speed: Unknown
	Type: Other Unknown EDO
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x000A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 128 KB
	Maximum Size: 128 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000B, DMI type 7, 19 bytes
Cache Information
	Socket Designation: External Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 512 KB
	Maximum Size: 512 KB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PRIMARY IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: FDD
	Internal Connector Type: On Board Floppy
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: 8251 FIFO Compatible

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: COM1
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: COM2
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator:  
	External Connector Type: DB-9 male
	Port Type: Serial Port 16450 Compatible

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Keyboard
	Internal Connector Type: PS/2
	External Reference Designator:  
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PS/2 Mouse
	Internal Connector Type: PS/2
	External Reference Designator:  
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB0
	External Connector Type: Other
	Port Type: USB

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB1
	External Connector Type: Other
	Port Type: USB

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB2
	External Connector Type: Other
	Port Type: USB

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB3
	External Connector Type: Other
	Port Type: USB

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB4
	External Connector Type: Other
	Port Type: USB

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB5
	External Connector Type: Other
	Port Type: USB

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB6
	External Connector Type: Other
	Port Type: USB

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB7
	External Connector Type: Other
	Port Type: USB

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB8
	External Connector Type: Other
	Port Type: USB

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Specified
	Internal Connector Type: None
	External Reference Designator: USB9
	External Connector Type: Other
	Port Type: USB

Handle 0x001C, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI0
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 1
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001D, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 2
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001E, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI2
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 3
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x001F, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI3
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 4
	Characteristics:
		5.0 V is provided
		PME signal is supported

Handle 0x0020, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI-X
	Type: 32-bit PCI-X
	Current Usage: Available
	Length: Long
	ID: 1
	Characteristics:
		5.0 V is provided

Handle 0x0021, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI-X
	Type: 32-bit PCI-X
	Current Usage: Available
	Length: Long
	ID: 237
	Characteristics:
		5.0 V is provided

Handle 0x0022, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI-X
	Type: 32-bit PCI-X
	Current Usage: Available
	Length: Long
	ID: 7
	Characteristics:
		5.0 V is provided

Handle 0x0023, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI-X
	Type: 32-bit PCI-X
	Current Usage: Available
	Length: Long
	ID: 240
	Characteristics:
		5.0 V is provided

Handle 0x0024, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 3
		n|US|iso8859-1
		n|US|iso8859-1
		r|CA|iso8859-1
	Currently Installed Language: n|US|iso8859-1

Handle 0x0025, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 2 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0026, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0025
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: A0
	Bank Locator: Bank0/1
	Type: DDR2
	Type Detail: None
	Speed: 4198 MHz (0.2 ns)
	Manufacturer: <BAD INDEX>
	Serial Number: Not Specified
	Asset Tag: None
	Part Number: None

Handle 0x0027, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0025
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: A1
	Bank Locator: Bank2/3
	Type: DDR2
	Type Detail: None
	Speed: 4198 MHz (0.2 ns)
	Manufacturer: <BAD INDEX>
	Serial Number: Not Specified
	Asset Tag: None
	Part Number: None

Handle 0x0028, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0025
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: A2
	Bank Locator: Bank4/5
	Type: DDR2
	Type Detail: None
	Speed: 4198 MHz (0.2 ns)
	Manufacturer: <BAD INDEX>
	Serial Number: Not Specified
	Asset Tag: None
	Part Number: None

Handle 0x0029, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0025
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: DIMM
	Set: None
	Locator: A3
	Bank Locator: Bank6/7
	Type: DDR2
	Type Detail: None
	Speed: 4198 MHz (0.2 ns)
	Manufacturer: <BAD INDEX>
	Serial Number: Not Specified
	Asset Tag: None
	Part Number: None

Handle 0x002A, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Array Handle: 0x0025
	Partition Width: 0

Handle 0x002B, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0026
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: 1

Handle 0x002C, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0027
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: 1

Handle 0x002D, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0028
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: 1

Handle 0x002E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0029
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: 1

Handle 0x002F, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x0030, DMI type 11, 5 bytes
OEM Strings
	String 1:  

Handle 0x0031, DMI type 188, 212 bytes
OEM-specific Type
	Header and Data:
		BC D4 31 00 00 00 00 80 00 00 00 00 00 00 00 00
		00 00 00 00 00 06 16 00 00 00 00 00 08 00 00 00
		00 40 40 00 00 08 01 00 03 00 00 00 00 00 7F 00
		00 00 00 00 01 00 00 00 00 00 00 00 02 00 00 00
		00 00 00 00 03 00 00 00 00 00 00 00 04 00 00 00
		00 00 00 00 05 00 00 00 00 00 00 00 06 00 00 00
		00 00 00 00 07 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 01 00 00 00 01 01 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		E0 3E 78 00 00 00 00 00 00 00 00 00 05 00 80 0B
		00 00 00 00 20 00 00 00 40 00 00 00 24 91 14 AE
		45 00 82 20 00 08 01 00 00 02 00 00 00 00 00 00
		44 00 90 0A 0C 00 58 3F 00 00 00 00 00 00 00 00
		00 00 00 00

Handle 0x0032, DMI type 190, 212 bytes
OEM-specific Type
	Header and Data:
		BE D4 32 00 10 05 00 00 00 00 00 00 24 A4 40 04
		C0 0F E4 2F 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 0F 00 00 00 00 00 00 00
		00 00 00 00 02 55 93 31 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00

Handle 0x0033, DMI type 192, 244 bytes
OEM-specific Type
	Header and Data:
		C0 F4 33 00 05 00 00 00 22 32 11 20 20 25 20 00
		E7 88 71 0E F3 0D 0B 00 22 32 11 20 00 00 00 00
		11 11 12 11 00 00 00 00 00 00 00 00 0F 10 10 11
		00 00 00 00 00 11 00 20 25 20 00 2E 2E 2E 2E 0C
		0C 0C 0A 2E 2E 2E 2E 2E 2E 2E 2E 0C 0C 0C 0A 2E
		2E 2E 2E 00 0C 00 68 8C 41 06 F3 0D 0B 00 00 00
		00 00 00 00 00 00 00 00 84 00 82 00 82 00 81 00
		84 00 00 00 00 00 00 00 00 00 00 00 04 00 02 00
		02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
		80 00 84 00 83 00 85 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 04 00 03 00 05 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 15 15 12 13 13 13 15 16 12 00 00 00
		0B 01 00 00 DC 01 00 00 DC 01 00 00 DC 01 00 00
		00 00 00 00

Handle 0x0034, DMI type 194, 244 bytes
OEM-specific Type
	Header and Data:
		C2 F4 34 00 05 00 00 00 22 32 11 20 20 25 20 00
		69 8C 51 06 F3 0D 0B 00 22 32 11 20 00 00 00 00
		10 10 11 11 00 00 00 00 00 00 00 00 0F 0F 10 0F
		00 00 00 00 00 10 00 20 25 20 00 2E 2E 2E 2E 0A
		0C 0A 0C 2E 2E 2E 2E 2E 2E 2E 2E 0A 0C 0C 0A 2E
		2E 2E 2E 00 0A 00 69 90 51 06 F3 0D 0B 00 00 00
		00 00 00 00 00 00 00 00 77 00 77 00 72 00 73 00
		77 00 00 00 00 00 00 00 00 00 00 00 17 00 17 00
		12 00 13 00 00 00 00 00 00 00 00 00 00 00 00 00
		77 00 73 00 76 00 79 00 00 00 00 00 00 00 00 00
		00 00 00 00 17 00 13 00 16 00 19 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 13 15 13 13 12 13 14 15 13 00 00 00
		1C 00 00 00 DC 01 00 00 DC 01 00 00 DC 01 00 00
		00 00 00 00

Handle 0x0035, DMI type 127, 4 bytes
End Of Table


--=-z8hpS1gwcURLbhjyf2O0
Content-Disposition: attachment; filename=sapphire-790FX-lspci-nnv.txt
Content-Type: text/plain; name=sapphire-790FX-lspci-nnv.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge [0600]: ATI Technologies Inc RD790 Northbridge only dual slot PCI-e_GFX and HT3 K8 part [1002:5956]
	Subsystem: ATI Technologies Inc RD790 Northbridge only dual slot PCI-e_GFX and HT3 K8 part [1002:5956]
	Flags: bus master, 66MHz, medium devsel, latency 64
	Memory at <ignored> (64-bit, non-prefetchable)
	Capabilities: [c4] HyperTransport: Slave or Primary Interface
	Capabilities: [40] HyperTransport: Retry Mode
	Capabilities: [54] HyperTransport: UnitID Clumping
	Capabilities: [9c] HyperTransport: #1a

00:07.0 PCI bridge [0604]: ATI Technologies Inc RD790 PCI to PCI bridge (PCI express gpp port D) [1002:597d] (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fd800000-fd8fffff
	Prefetchable memory behind bridge: 00000000fde00000-00000000fdefffff
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot+), MSI 00
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [b0] Subsystem: ATI Technologies Inc Unknown device [1002:5956]
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information <?>
	Capabilities: [110] Virtual Channel <?>
	Kernel driver in use: pcieport-driver
	Kernel modules: shpchp

00:09.0 PCI bridge [0604]: ATI Technologies Inc RD790 PCI to PCI bridge (PCI express gpp port E) [1002:597e] (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fdd00000-fddfffff
	Prefetchable memory behind bridge: 00000000fdc00000-00000000fdcfffff
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot+), MSI 00
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [b0] Subsystem: ATI Technologies Inc Unknown device [1002:5956]
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information <?>
	Capabilities: [110] Virtual Channel <?>
	Kernel driver in use: pcieport-driver
	Kernel modules: shpchp

00:0a.0 PCI bridge [0604]: ATI Technologies Inc RD790 PCI to PCI bridge (PCI express gpp port F) [1002:597f] (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fdb00000-fdbfffff
	Prefetchable memory behind bridge: 00000000fda00000-00000000fdafffff
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot+), MSI 00
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [b0] Subsystem: ATI Technologies Inc Unknown device [1002:5956]
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information <?>
	Capabilities: [110] Virtual Channel <?>
	Kernel driver in use: pcieport-driver
	Kernel modules: shpchp

00:0b.0 PCI bridge [0604]: ATI Technologies Inc RD790 PCI to PCI bridge (external gfx1 port A) [1002:5980] (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fd900000-fd9fffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Root Port (Slot+), MSI 00
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [b0] Subsystem: ATI Technologies Inc Unknown device [1002:5956]
	Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100] Vendor Specific Information <?>
	Capabilities: [110] Virtual Channel <?>
	Kernel driver in use: pcieport-driver
	Kernel modules: shpchp

00:12.0 SATA controller [0106]: ATI Technologies Inc SB600 Non-Raid-5 SATA [1002:4380] (prog-if 01 [AHCI 1.0])
	Subsystem: ATI Technologies Inc SB600 Non-Raid-5 SATA [1002:4380]
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 22
	I/O ports at ff00 [size=8]
	I/O ports at fe00 [size=4]
	I/O ports at fd00 [size=8]
	I/O ports at fc00 [size=4]
	I/O ports at fb00 [size=16]
	Memory at fdfff000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [60] Power Management version 2
	Kernel driver in use: ahci
	Kernel modules: ahci

00:13.0 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI0) [1002:4387] (prog-if 10 [OHCI])
	Subsystem: ATI Technologies Inc SB600 USB (OHCI0) [1002:4387]
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
	Memory at fdffe000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd

00:13.1 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI1) [1002:4388] (prog-if 10 [OHCI])
	Subsystem: ATI Technologies Inc SB600 USB (OHCI1) [1002:4388]
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 17
	Memory at fdffd000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd

00:13.2 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI2) [1002:4389] (prog-if 10 [OHCI])
	Subsystem: ATI Technologies Inc SB600 USB (OHCI2) [1002:4389]
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
	Memory at fdffc000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd

00:13.3 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI3) [1002:438a] (prog-if 10 [OHCI])
	Subsystem: ATI Technologies Inc SB600 USB (OHCI3) [1002:438a]
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 17
	Memory at fdffb000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd

00:13.4 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI4) [1002:438b] (prog-if 10 [OHCI])
	Subsystem: ATI Technologies Inc SB600 USB (OHCI4) [1002:438b]
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
	Memory at fdffa000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd
	Kernel modules: ohci-hcd

00:14.0 SMBus [0c05]: ATI Technologies Inc SBx00 SMBus Controller [1002:4385] (rev 14)
	Subsystem: ATI Technologies Inc SBx00 SMBus Controller [1002:4385]
	Flags: 66MHz, medium devsel
	I/O ports at 0b00 [size=16]
	Capabilities: [b0] HyperTransport: MSI Mapping Enable- Fixed+
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c-piix4

00:14.1 IDE interface [0101]: ATI Technologies Inc SB600 IDE [1002:438c] (prog-if 8a [Master SecP PriP])
	Subsystem: ATI Technologies Inc SB600 IDE [1002:438c]
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
	I/O ports at 01f0 [size=8]
	I/O ports at 03f4 [size=1]
	I/O ports at 0170 [size=8]
	I/O ports at 0374 [size=1]
	I/O ports at f900 [size=16]
	Kernel driver in use: ATIIXP_IDE
	Kernel modules: ata_generic, atiixp, generic

00:14.3 ISA bridge [0601]: ATI Technologies Inc SB600 PCI to LPC Bridge [1002:438d]
	Subsystem: ATI Technologies Inc SB600 PCI to LPC Bridge [1002:438d]
	Flags: bus master, 66MHz, medium devsel, latency 0

00:14.4 PCI bridge [0604]: ATI Technologies Inc SBx00 PCI to PCI Bridge [1002:4384] (prog-if 01 [Subtractive decode])
	Flags: bus master, VGA palette snoop, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=64
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: fd700000-fd7fffff
	Prefetchable memory behind bridge: fd600000-fd6fffff

00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] HyperTransport Configuration [1022:1200]
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] Address Map [1022:1201]
	Flags: fast devsel

00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] DRAM Controller [1022:1202]
	Flags: fast devsel

00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] Miscellaneous Control [1022:1203]
	Flags: fast devsel
	Capabilities: [f0] Secure device <?>

00:18.4 Host bridge [0600]: Advanced Micro Devices [AMD] Family 10h [Opteron, Athlon64, Sempron] Link Control [1022:1204]
	Flags: fast devsel

01:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8053 PCI-E Gigabit Ethernet Controller [11ab:4362] (rev 22)
	Subsystem: Marvell Technology Group Ltd. Marvell RDK-8053 [11ab:5321]
	Flags: bus master, fast devsel, latency 0, IRQ 1275
	Memory at fd8fc000 (64-bit, non-prefetchable) [size=16K]
	I/O ports at de00 [size=256]
	[virtual] Expansion ROM at fde00000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data <?>
	Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
	Capabilities: [e0] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting <?>
	Kernel driver in use: sky2
	Kernel modules: sky2

02:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8052 PCI-E ASF Gigabit Ethernet Controller [11ab:4360] (rev 22)
	Subsystem: Marvell Technology Group Ltd. Marvell RDK-8052 [11ab:5221]
	Flags: bus master, fast devsel, latency 0, IRQ 1274
	Memory at fddfc000 (64-bit, non-prefetchable) [size=16K]
	I/O ports at ce00 [size=256]
	[virtual] Expansion ROM at fdc00000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data <?>
	Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable+
	Capabilities: [e0] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting <?>
	Kernel driver in use: sky2
	Kernel modules: sky2

03:00.0 RAID bus controller [0104]: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller [1095:3132] (rev 01)
	Subsystem: Silicon Image, Inc. Unknown device [1095:7132]
	Flags: bus master, fast devsel, latency 0, IRQ 18
	Memory at fdbff000 (64-bit, non-prefetchable) [size=128]
	Memory at fdbf8000 (64-bit, non-prefetchable) [size=16K]
	I/O ports at bf00 [size=128]
	[virtual] Expansion ROM at fda00000 [disabled] [size=512K]
	Capabilities: [54] Power Management version 2
	Capabilities: [5c] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting <?>
	Kernel driver in use: sata_sil24
	Kernel modules: sata_sil24

04:00.0 VGA compatible controller [0300]: ATI Technologies Inc RV630 [Radeon HD 2600XT] [1002:9588] (prog-if 00 [VGA controller])
	Subsystem: PC Partner Limited Unknown device [174b:2e42]
	Flags: bus master, fast devsel, latency 0, IRQ 19
	Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Memory at fd9e0000 (64-bit, non-prefetchable) [size=64K]
	I/O ports at ee00 [size=256]
	[virtual] Expansion ROM at fd900000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Legacy Endpoint, MSI 00
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [100] Vendor Specific Information <?>
	Kernel driver in use: fglrx_pci
	Kernel modules: fglrx

04:00.1 Audio device [0403]: ATI Technologies Inc RV630/M76 audio device [Radeon HD 2600 Series] [1002:aa08]
	Subsystem: PC Partner Limited Unknown device [174b:aa08]
	Flags: bus master, fast devsel, latency 0, IRQ 5
	Memory at fd9fc000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 3
	Capabilities: [58] Express Legacy Endpoint, MSI 00
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [100] Vendor Specific Information <?>

05:08.0 FireWire (IEEE 1394) [0c00]: VIA Technologies, Inc. IEEE 1394 Host Controller [1106:3044] (rev 80) (prog-if 10 [OHCI])
	Subsystem: DFI Inc Unknown device [15bd:1006]
	Flags: bus master, stepping, medium devsel, latency 64, IRQ 23
	Memory at fd7ff000 (32-bit, non-prefetchable) [size=2K]
	I/O ports at af00 [size=128]
	Capabilities: [50] Power Management version 2
	Kernel driver in use: firewire_ohci
	Kernel modules: firewire-ohci


--=-z8hpS1gwcURLbhjyf2O0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-z8hpS1gwcURLbhjyf2O0--

