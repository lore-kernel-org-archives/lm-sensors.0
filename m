From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Sun, 19 Oct 2008 16:54:15 +0000
Subject: [lm-sensors] abituguru3: Please send .. to the abituguru3 (see
Message-Id: <alpine.DEB.1.10.0810191251550.19058@p34.internal.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Kernel: 2.6.27.2:
[   10.242065] abituguru3: found Abit uGuru3, motherboard ID: 0016
[   10.242105] abituguru3: this motherboard was not detected using DMI. Please send the output of "dmidecode" to the abituguru3 maintainer(see MAINTAINERS)

Motherboard: AW9D-MAX as shown below.

DMI Decode:

# dmidecode 2.9
SMBIOS 2.2 present.
34 structures occupying 950 bytes.
Table at 0x000F0000.

Handle 0x0000, DMI type 0, 19 bytes
BIOS Information
 	Vendor: Phoenix Technologies, LTD
 	Version: 6.00 PG
 	Release Date: 03/03/2008
 	Address: 0xE0000
 	Runtime Size: 128 kB
 	ROM Size: 512 kB
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

Handle 0x0001, DMI type 1, 25 bytes
System Information
 	Manufacturer:
 	Product Name:
 	Version:
 	Serial Number:
 	UUID: 00000000-0000-0000-0000-00508D9C390D
 	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
 	Manufacturer: http://www.abit.com.tw/
 	Product Name: AW9D-MAX       (Intel i975-ICH7)
 	Version: 1.0
 	Serial Number:

Handle 0x0003, DMI type 3, 13 bytes
Chassis Information
 	Manufacturer:
 	Type: Desktop
 	Lock: Not Present
 	Version: Not Specified
 	Serial Number: Not Specified
 	Asset Tag: Not Specified
 	Boot-up State: Unknown
 	Power Supply State: Unknown
 	Thermal State: Unknown
 	Security Status: Unknown

Handle 0x0004, DMI type 4, 32 bytes
Processor Information
 	Socket Designation: Socket 775
 	Type: Central Processor
 	Family: Other
 	Manufacturer: Intel
 	ID: F6 06 00 00 FF FB EB BF
 	Version: Intel(R) Core(TM)2
 	Voltage: 0.0 V
 	External Clock: 272 MHz
 	Max Speed: 4000 MHz
 	Current Speed: 2720 MHz
 	Status: Populated, Enabled
 	Upgrade: ZIF Socket
 	L1 Cache Handle: 0x000A
 	L2 Cache Handle: 0x000B
 	L3 Cache Handle: No L3 Cache

Handle 0x0005, DMI type 5, 24 bytes
Memory Controller Information
 	Error Detecting Method: 8-bit Parity
 	Error Correcting Capabilities:
 		None
 	Supported Interleave: One-way Interleave
 	Current Interleave: One-way Interleave
 	Maximum Memory Module Size: 2048 MB
 	Maximum Total Memory Size: 8192 MB
 	Supported Speeds:
 		Other
 	Supported Memory Types:
 		Other
 	Memory Module Voltage: 3.3 V
 	Associated Memory Slots: 4
 		0x0006
 		0x0007
 		0x0008
 		0x0009
 	Enabled Error Correcting Capabilities:
 		None

Handle 0x0006, DMI type 6, 12 bytes
Memory Module Information
 	Socket Designation: A0
 	Bank Connections: 0 1
 	Current Speed: Unknown
 	Type: Other
 	Installed Size: 1024 MB (Double-bank Connection)
 	Enabled Size: 1024 MB (Double-bank Connection)
 	Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes
Memory Module Information
 	Socket Designation: A1
 	Bank Connections: 2 3
 	Current Speed: Unknown
 	Type: Other
 	Installed Size: 1024 MB (Double-bank Connection)
 	Enabled Size: 1024 MB (Double-bank Connection)
 	Error Status: OK

Handle 0x0008, DMI type 6, 12 bytes
Memory Module Information
 	Socket Designation: A2
 	Bank Connections: 4 5
 	Current Speed: Unknown
 	Type: Other
 	Installed Size: 1024 MB (Double-bank Connection)
 	Enabled Size: 1024 MB (Double-bank Connection)
 	Error Status: OK

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
 	Socket Designation: A3
 	Bank Connections: 6 7
 	Current Speed: Unknown
 	Type: Other
 	Installed Size: 1024 MB (Double-bank Connection)
 	Enabled Size: 1024 MB (Double-bank Connection)
 	Error Status: OK

Handle 0x000A, DMI type 7, 19 bytes
Cache Information
 	Socket Designation: Internal Cache
 	Configuration: Enabled, Not Socketed, Level 1
 	Operational Mode: Write Back
 	Location: Internal
 	Installed Size: 32 KB
 	Maximum Size: 32 KB
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
 	Location: External
 	Installed Size: 4096 KB
 	Maximum Size: 4096 KB
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
 	Internal Reference Designator: SECONDARY IDE
 	Internal Connector Type: On Board IDE
 	External Reference Designator: Not Specified
 	External Connector Type: None
 	Port Type: Other

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
 	Internal Reference Designator: FDD
 	Internal Connector Type: On Board Floppy
 	External Reference Designator: Not Specified
 	External Connector Type: None
 	Port Type: 8251 FIFO Compatible

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
 	Internal Reference Designator: Keyboard
 	Internal Connector Type: PS/2
 	External Reference Designator:
 	External Connector Type: PS/2
 	Port Type: Keyboard Port

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
 	Internal Reference Designator: PS/2 Mouse
 	Internal Connector Type: PS/2
 	External Reference Designator:
 	External Connector Type: PS/2
 	Port Type: Mouse Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
 	Internal Reference Designator: Not Specified
 	Internal Connector Type: None
 	External Reference Designator: USB0
 	External Connector Type: Other
 	Port Type: USB

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
 	Internal Reference Designator: Not Specified
 	Internal Connector Type: None
 	External Reference Designator: USB1
 	External Connector Type: Other
 	Port Type: USB

Handle 0x0013, DMI type 9, 13 bytes
System Slot Information
 	Designation: PCI1
 	Type: 32-bit PCI
 	Current Usage: Available
 	Length: Long
 	ID: 1
 	Characteristics:
 		5.0 V is provided
 		PME signal is supported

Handle 0x0014, DMI type 9, 13 bytes
System Slot Information
 	Designation: PCI2
 	Type: 32-bit PCI
 	Current Usage: Available
 	Length: Long
 	ID: 2
 	Characteristics:
 		5.0 V is provided
 		PME signal is supported

Handle 0x0015, DMI type 13, 22 bytes
BIOS Language Information
 	Installable Languages: 3
 		n|US|iso8859-1
 		n|US|iso8859-1
 		r|CA|iso8859-1
 	Currently Installed Language: n|US|iso8859-1

Handle 0x0016, DMI type 16, 15 bytes
Physical Memory Array
 	Location: System Board Or Motherboard
 	Use: System Memory
 	Error Correction Type: None
 	Maximum Capacity: 4 GB
 	Error Information Handle: Not Provided
 	Number Of Devices: 4

Handle 0x0017, DMI type 17, 21 bytes
Memory Device
 	Array Handle: 0x0016
 	Error Information Handle: Not Provided
 	Total Width: 64 bits
 	Data Width: 64 bits
 	Size: 1024 MB
 	Form Factor: DIMM
 	Set: None
 	Locator: A0
 	Bank Locator: Bank0/1
 	Type: DDR
 	Type Detail: Synchronous

Handle 0x0018, DMI type 17, 21 bytes
Memory Device
 	Array Handle: 0x0016
 	Error Information Handle: Not Provided
 	Total Width: 64 bits
 	Data Width: 64 bits
 	Size: 1024 MB
 	Form Factor: DIMM
 	Set: None
 	Locator: A1
 	Bank Locator: Bank2/3
 	Type: DDR
 	Type Detail: Synchronous

Handle 0x0019, DMI type 17, 21 bytes
Memory Device
 	Array Handle: 0x0016
 	Error Information Handle: Not Provided
 	Total Width: 64 bits
 	Data Width: 64 bits
 	Size: 1024 MB
 	Form Factor: DIMM
 	Set: None
 	Locator: A2
 	Bank Locator: Bank4/5
 	Type: DDR
 	Type Detail: Synchronous

Handle 0x001A, DMI type 17, 21 bytes
Memory Device
 	Array Handle: 0x0016
 	Error Information Handle: Not Provided
 	Total Width: 64 bits
 	Data Width: 64 bits
 	Size: 1024 MB
 	Form Factor: DIMM
 	Set: None
 	Locator: A3
 	Bank Locator: Bank6/7
 	Type: DDR
 	Type Detail: Synchronous

Handle 0x001B, DMI type 19, 15 bytes
Memory Array Mapped Address
 	Starting Address: 0x00000000000
 	Ending Address: 0x000FFFFFFFF
 	Range Size: 4 GB
 	Physical Array Handle: 0x0016
 	Partition Width: 0

Handle 0x001C, DMI type 20, 19 bytes
Memory Device Mapped Address
 	Starting Address: 0x00000000000
 	Ending Address: 0x0003FFFFFFF
 	Range Size: 1 GB
 	Physical Device Handle: 0x0017
 	Memory Array Mapped Address Handle: 0x001B
 	Partition Row Position: 1

Handle 0x001D, DMI type 20, 19 bytes
Memory Device Mapped Address
 	Starting Address: 0x00040000000
 	Ending Address: 0x0007FFFFFFF
 	Range Size: 1 GB
 	Physical Device Handle: 0x0018
 	Memory Array Mapped Address Handle: 0x001B
 	Partition Row Position: 1

Handle 0x001E, DMI type 20, 19 bytes
Memory Device Mapped Address
 	Starting Address: 0x00080000000
 	Ending Address: 0x000BFFFFFFF
 	Range Size: 1 GB
 	Physical Device Handle: 0x0019
 	Memory Array Mapped Address Handle: 0x001B
 	Partition Row Position: 1

Handle 0x001F, DMI type 20, 19 bytes
Memory Device Mapped Address
 	Starting Address: 0x000C0000000
 	Ending Address: 0x000FFFFFFFF
 	Range Size: 1 GB
 	Physical Device Handle: 0x001A
 	Memory Array Mapped Address Handle: 0x001B
 	Partition Row Position: 1

Handle 0x0020, DMI type 32, 11 bytes
System Boot Information
 	Status: No errors detected

Handle 0x0021, DMI type 127, 4 bytes
End Of Table


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
