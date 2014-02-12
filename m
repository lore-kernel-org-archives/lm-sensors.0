From: =?ISO-8859-1?Q?J=FCrgen_Fuchsberger?= <juergen.fuchsberger@uni-graz.at>
Date: Wed, 12 Feb 2014 08:52:02 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <52FB3632.2060701@uni-graz.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4951706319109403178=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============4951706319109403178==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3x2XX69S2GA1PpuaoDGvD1wsLJxeO58j5"

--3x2XX69S2GA1PpuaoDGvD1wsLJxeO58j5
Content-Type: multipart/mixed;
 boundary="------------080506080905090801050304"

This is a multi-part message in MIME format.
--------------080506080905090801050304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 02/11/2014 08:24 PM, Guenter Roeck wrote:
> On Tue, Feb 11, 2014 at 10:54:55AM +0100, J=FCrgen Fuchsberger wrote:
>> Hi,
>>
>> On 02/11/2014 08:32 AM, Juerg Haefliger wrote:
>>> Hi Juergen,
>>>
>>> You're likely to get better help by contacting the LM sensors mailing=

>>> list (cc'ed). I've been out of it for a bit.
>>
>> Thanks!
>>>
>>>
>>>> Dear Juerg,
>>>>
>>>> I keep getting Errors of this kind:
>>>>
>>>> Feb 10 09:51:09 wegc203094 kernel: [  156.372033] dme1737 1-002c: Re=
ad
>>>> from register 0x6d failed! Please report to the driver maintainer.
>>>> Feb 10 09:53:09 wegc203094 kernel: [  276.472043] dme1737 1-002c: Re=
ad
>>>> from register 0x69 failed! Please report to the driver maintainer.
>>>
>>> Can you post all messages from the driver from the time it was loaded=
?
>>
>> Feb 10 09:48:47 wegc203094 kernel: [    8.368070] i2c i2c-1: Found a
>> DME1737 chip at 0x2c (rev 0x8a).
>> Feb 10 09:48:47 wegc203094 kernel: [    8.384103] dme1737 1-002c:
>> Optional features: pwm3=3Dno, pwm5=3Dno, pwm6=3Dno, fan3=3Dno, fan4=3D=
no, fan5=3Dno,
>> fan6=3Dno.
>> Feb 10 09:4
>>
>>
>>> What's the model of the machine you're using?
>> Hmm, unfortunately I don't know. Is there a way to find out without
>> opening the server? (I mean by sw-tools?)
>>
> If this is a PC, "sudo dmidecode" might tell you a lot.
>=20
OK, thanks. Looks like it's a Tyan S2932/S2932-E/S2932-SI board. I
attached the dmidecode info.

>>> What do you get when running the sensors-detect script?
>>
>> ~ % sensors
>>
>>
> sensors-detect, not sensors ;-).
>=20
> Anyway, can you provide the output of "sudo i2cdump -y -f 1 0x2c" ?
> That might actually help more.

Debian package lm-sensors does not provide i2cdump so I did sensors-detec=
t:

Driver `to-be-written':
  * ISA bus, address 0xca8
    Chip `IPMI BMC KCS' (confidence: 8)

Driver `dme1737':
  * Bus `SMBus nForce2 adapter at 2e00'
    Busdriver `i2c_nforce2', I2C address 0x2c
    Chip `dme1737' (confidence: 6)

Driver `lm85':
  * Bus `SMBus nForce2 adapter at 2e00'
    Busdriver `i2c_nforce2', I2C address 0x2d
    Chip `emc6d103' (confidence: 6)
  * Bus `SMBus nForce2 adapter at 2e00'
    Busdriver `i2c_nforce2', I2C address 0x2e
    Chip `emc6d103' (confidence: 6)

Note: there is no driver for IPMI BMC KCS yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
dme1737
lm85
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)

Unloading i2c-dev... OK
Unloading cpuid... OK



>=20
> Also, are the errors persistent or sporadic ?
>=20
Persistent, current messages contains 703 error lines.

Juergen.


--------------080506080905090801050304
Content-Type: text/plain; charset=UTF-8;
 name="dmidecode.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="dmidecode.txt"

# dmidecode 2.11
SMBIOS 2.5 present.
62 structures occupying 2502 bytes.
Table at 0x000FC480.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: 'V2.05     '
	Release Date: 06/04/2009
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		PNP is supported
		APM is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 kB floppy services are supported (int 13h)
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
	BIOS Revision: 8.14

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: empty
	Product Name: empty
	Version: empty
	Serial Number: empty
	UUID: 00020003-0004-0005-0006-000700080009
	Wake-up Type: Power Switch
	SKU Number: empty
	Family: empty

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: TYAN Computer Corporation
	Product Name: S2932/S2932-E/S2932-SI
	Version: empty
	Serial Number: empty
	Asset Tag: empty
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: empty
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
	Manufacturer: empty
	Type: Desktop
	Lock: Not Present
	Version: empty
	Serial Number: empty
	Asset Tag: empty
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 4, 40 bytes
Processor Information
	Socket Designation: CPU 1
	Type: Central Processor
	Family: Quad-Core Opteron
	Manufacturer: AMD             =20
	ID: 23 0F 10 00 FF FB 8B 17
	Signature: Family 16, Model 2, Stepping 3
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
		FXSR (FXSAVE and FXSTOR instructions supported)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		HTT (Multi-threading)
	Version: Quad-Core AMD Opteron(tm) Processor 2346 HE        =20
	Voltage: 1.5 V
	External Clock: 200 MHz
	Max Speed: 1800 MHz
	Current Speed: 1800 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: 0x0007
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Part Number: To Be Filled By O.E.M.
	Core Count: 4
	Core Enabled: 4
	Characteristics:
		64-bit capable

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1-Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 512 kB
	Maximum Size: 512 kB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 4-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2-Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 2048 kB
	Maximum Size: 2048 kB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 4-way Set-associative

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3-Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Varies With Memory Address
	Location: Internal
	Installed Size: 2048 kB
	Maximum Size: 2048 kB
	Supported SRAM Types:
		Pipeline Burst
	Installed SRAM Type: Pipeline Burst
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 4-way Set-associative

Handle 0x0008, DMI type 4, 40 bytes
Processor Information
	Socket Designation: CPU 2
	Type: Central Processor
	Family: Other
	Manufacturer:                 =20
	ID: 00 00 00 00 00 00 00 00
	Version:                                                    =20
	Voltage: 3.3 V 2.9 V
	External Clock: Unknown
	Max Speed: 2000 MHz
	Current Speed: Unknown
	Status: Unpopulated
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0009
	L2 Cache Handle: 0x000A
	L3 Cache Handle: 0x000B
	Serial Number: To Be Filled By O.E.M.
	Asset Tag: To Be Filled By O.E.M.
	Part Number: To Be Filled By O.E.M.
	Characteristics: None

Handle 0x0009, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1-Cache
	Configuration: Disabled, Not Socketed, Level 1
	Operational Mode: Unknown
	Location: Internal
	Installed Size: 0 kB
	Maximum Size: 0 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2-Cache
	Configuration: Disabled, Not Socketed, Level 2
	Operational Mode: Unknown
	Location: Internal
	Installed Size: 0 kB
	Maximum Size: 0 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000B, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3-Cache
	Configuration: Disabled, Not Socketed, Level 3
	Operational Mode: Unknown
	Location: Internal
	Installed Size: 0 kB
	Maximum Size: 0 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: PS2Mouse
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2
	Internal Connector Type: None
	External Reference Designator: USB1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A2
	Internal Connector Type: None
	External Reference Designator: USB2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J4A1
	Internal Connector Type: None
	External Reference Designator: LPT 1
	External Connector Type: DB-25 male
	Port Type: Parallel Port ECP/EPP

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A1
	Internal Connector Type: None
	External Reference Designator: COM A
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6A1
	Internal Connector Type: None
	External Reference Designator: Audio Mic In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6A1
	Internal Connector Type: None
	External Reference Designator: Audio Line In
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6B1 - AUX IN
	Internal Connector Type: On Board Sound Input From CD-ROM
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Audio Port

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6B2 - CDIN
	Internal Connector Type: On Board Sound Input From CD-ROM
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Audio Port

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6J2 - PRI IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6J1 - SEC IDE
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J4J1 - FLOPPY
	Internal Connector Type: On Board Floppy
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9H1 - FRONT PNL
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1B1 - CHASSIS REAR FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2F1 - CPU FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J8B4 - FRONT FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9G2 - FNT USB
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J6C3 - FP AUD
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x001F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9G1 - CONFIG
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0020, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J8C1 - SCSI LED
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0021, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9J2 - INTRUDER
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0022, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J9G4 - ITP
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0023, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2H1 - MAIN POWER
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0024, DMI type 9, 13 bytes
System Slot Information
	Designation: AGP
	Type: 32-bit AGP 4x
	Current Usage: In Use
	Length: Short
	ID: 0
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0025, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Short
	ID: 1
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0026, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Enabled
	Description:   To Be Filled By O.E.M.

Handle 0x0027, DMI type 13, 22 bytes
BIOS Language Information
	Language Description Format: Abbreviated
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x0028, DMI type 15, 55 bytes
System Event Log
	Area Length: 1008 bytes
	Header Start Offset: 0x1810
	Data Start Offset: 0x1810
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0002
	Status: Valid, Not Full
	Change Token: 0x00000000
	Header Format: No Header
	Supported Log Type Descriptors: 9
	Descriptor 1: Single-bit ECC memory error
	Data Format 1: Multiple-event handle
	Descriptor 2: Multi-bit ECC memory error
	Data Format 2: Multiple-event handle
	Descriptor 3: Parity memory error
	Data Format 3: Multiple-event
	Descriptor 4: I/O channel block
	Data Format 4: Multiple-event
	Descriptor 5: POST error
	Data Format 5: POST results bitmap
	Descriptor 6: PCI parity error
	Data Format 6: Multiple-event handle
	Descriptor 7: PCI system error
	Data Format 7: Multiple-event handle
	Descriptor 8: System limit exceeded
	Data Format 8: Multiple-event system management
	Descriptor 9: OEM-specific
	Data Format 9: POST results bitmap

Handle 0x0029, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Single-bit ECC
	Maximum Capacity: 8 GB
	Error Information Handle: Not Provided
	Number Of Devices: 8

Handle 0x002A, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x00127FFFFFF
	Range Size: 4736 MB
	Physical Array Handle: 0x0029
	Partition Width: 1

Handle 0x002B, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 72 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz
	Manufacturer: Manufacturer0
	Serial Number: SerNum0
	Asset Tag: AssetTagNum0
	Part Number: PartNum0

Handle 0x002C, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0007FFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x002B
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: 1

Handle 0x002D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 72 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz
	Manufacturer: Manufacturer1
	Serial Number: SerNum1
	Asset Tag: AssetTagNum1
	Part Number: PartNum1

Handle 0x002E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00080000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x002D
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: 1

Handle 0x002F, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM2
	Bank Locator: BANK2
	Type: Unknown
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Manufacturer2
	Serial Number: SerNum2
	Asset Tag: AssetTagNum2
	Part Number: PartNum2

Handle 0x0030, DMI type 126, 19 bytes
Inactive

Handle 0x0031, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM3
	Bank Locator: BANK3
	Type: Unknown
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Manufacturer3
	Serial Number: SerNum3
	Asset Tag: AssetTagNum3
	Part Number: PartNum3

Handle 0x0032, DMI type 126, 19 bytes
Inactive

Handle 0x0033, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM4
	Bank Locator: BANK4
	Type: Unknown
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Manufacturer4
	Serial Number: SerNum4
	Asset Tag: AssetTagNum4
	Part Number: PartNum4

Handle 0x0034, DMI type 126, 19 bytes
Inactive

Handle 0x0035, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM5
	Bank Locator: BANK5
	Type: Unknown
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Manufacturer5
	Serial Number: SerNum5
	Asset Tag: AssetTagNum5
	Part Number: PartNum5

Handle 0x0036, DMI type 126, 19 bytes
Inactive

Handle 0x0037, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM6
	Bank Locator: BANK6
	Type: Unknown
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Manufacturer6
	Serial Number: SerNum6
	Asset Tag: AssetTagNum6
	Part Number: PartNum6

Handle 0x0038, DMI type 126, 19 bytes
Inactive

Handle 0x0039, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0029
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: DIMM7
	Bank Locator: BANK7
	Type: Unknown
	Type Detail: Unknown
	Speed: Unknown
	Manufacturer: Manufacturer7
	Serial Number: SerNum7
	Asset Tag: AssetTagNum7
	Part Number: PartNum7

Handle 0x003A, DMI type 126, 19 bytes
Inactive

Handle 0x003B, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x003C, DMI type 38, 18 bytes
IPMI Device Information
	Interface Type: KCS (Keyboard Control Style)
	Specification Version: 2.0
	I2C Slave Address: 0x10
	NV Storage Device: Not Present
	Base Address: 0x0000000000000CA8 (I/O)
	Register Spacing: 32-bit Boundaries

Handle 0x003D, DMI type 127, 4 bytes
End Of Table


--------------080506080905090801050304--

--3x2XX69S2GA1PpuaoDGvD1wsLJxeO58j5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iF4EAREIAAYFAlL7NjcACgkQ4RNsce5/DgDV5wD/T1ZTb6i8+CG5AhroybxC1vRb
NsJa8sfbZyt1KTPzYHgA/1HRFFDcnLv5X59ybdiPOTj2nXA8GCls+8BSJX4w7X63
=zThJ
-----END PGP SIGNATURE-----

--3x2XX69S2GA1PpuaoDGvD1wsLJxeO58j5--


--===============4951706319109403178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4951706319109403178==--
