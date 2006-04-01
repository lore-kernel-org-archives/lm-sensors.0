From: trini@kernel.crashing.org (Tom Rini)
Date: Sat, 01 Apr 2006 20:11:39 +0000
Subject: [lm-sensors] PIIX4 and fix_hstcfg
Message-Id: <20060401201139.GS15423@smtp.west.cox.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <442E9B64.50909@sh.cvut.cz>
In-Reply-To: <442E9B64.50909@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 01, 2006 at 08:54:57PM +0200, Jean Delvare wrote:
> Hi Rudolf, Tom,
> 
> > > Note that I just use this as a crashbox now so if it's more trouble than
> > > it's worth, I wouldn't mind it being dropped.
> > 
> > Thanks for the lspci. It seems it has no PCI subsystem ID regs???
> > Because of this much easier would be just drop.
> 
> Maybe we can use DMI instead. Tom, can you please provide the output of
> dmidecode for this system? Maybe others still use it.

# dmidecode
# dmidecode 2.6
Legacy DMI 0.0 present.
34 structures occupying 1032 bytes.
Table at 0x000F6B4B.
Handle 0x0000
	DMI type 0, 18 bytes.
	BIOS Information
		Vendor: American Megatrends, Inc.
		Version: 0630
		Release Date: 07/15/95
		Address: 0xF0000
		Runtime Size: 64 kB
		ROM Size: 256 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			Selectable boot is supported
			EDD is supported
			Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
			5.25"/360 KB floppy services are supported (int 13h)
			5.25"/1.2 MB floppy services are supported (int 13h)
			3.5"/720 KB floppy services are supported (int 13h)
			3.5"/2.88 MB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
Handle 0x0001
	DMI type 1, 8 bytes.
	System Information
		Manufacturer: To be filled
		Product Name: To be filled
		Version: To be filled
		Serial Number:  
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: Intel 440LX
		Product Name: 2.00
		Version:  
		Serial Number: <BAD INDEX>
Handle 0x0003
	DMI type 3, 9 bytes.
	Chassis Information
		Manufacturer: To be filled
		Type: Unknown
		Lock: Not Present
		Version: To be filled
		Serial Number:  
		Asset Tag:  
Handle 0x0004
	DMI type 4, 26 bytes.
	Processor Information
		Socket Designation: Slot 1
		Type: Central Processor
		Family: 80386
		Manufacturer: INTEL           
		ID: 52 06 00 00 FF FB 83 01
		Signature: Type 0, Family 6, Major Stepping 5, Minor Stepping 2
		Version: Pentium II      
		Voltage: 3.3 V 2.9 V
		External Clock: 66 MHz
		Max Speed: 333 MHz
		Current Speed: 333 MHz
		Status: Populated, Enabled
		Upgrade: Slot 1
Handle 0x0005
	DMI type 4, 26 bytes.
	Processor Information
		Socket Designation: Slot 1
		Type: Central Processor
		Family: 80386
		Manufacturer: INTEL           
		ID: 52 06 00 00 FF FB 83 01
		Signature: Type 0, Family 6, Major Stepping 5, Minor Stepping 2
		Version: Pentium II      
		Voltage: 3.3 V 2.9 V
		External Clock: 66 MHz
		Max Speed: 333 MHz
		Current Speed: 333 MHz
		Status: Populated, Enabled
		Upgrade: Slot 1
Handle 0x0006
	DMI type 5, 31 bytes.
	Memory Controller Information
		Error Detecting Method: 64-bit ECC
		Error Correcting Capabilities:
			Single-bit Error Correcting
			Error Scrubbing
		Supported Interleave: One-way Interleave
		Current Interleave: One-way Interleave
		Maximum Memory Module Size: 256 MB
		Maximum Total Memory Size: 2048 MB
		Supported Speeds:
			70 ns
			60 ns
			50 ns
		Supported Memory Types:
			EDO
			Parity
			ECC
			DIMM
			SDRAM
		Memory Module Voltage: 3.3 V
		Associated Memory Slots: 8
			0x0007
			0x0008
			0x0009
			0x000A
			0x000B
			0x000C
			0x000D
			0x000E
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: Bank 1
		Bank Connections: 0 0
		Current Speed: 60 ns
		Type: DIMM SDRAM
		Installed Size: 64 MB (Single-bank Connection)
		Enabled Size: 64 MB (Single-bank Connection)
		Error Status: OK
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: Bank 2
		Bank Connections: 0 0
		Current Speed: 60 ns
		Type: DIMM SDRAM
		Installed Size: 64 MB (Single-bank Connection)
		Enabled Size: 64 MB (Single-bank Connection)
		Error Status: OK
Handle 0x000A
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: Bank 3
		Bank Connections: 0 0
		Current Speed: 60 ns
		Type: DIMM SDRAM
		Installed Size: 64 MB (Single-bank Connection)
		Enabled Size: 64 MB (Single-bank Connection)
		Error Status: OK
Handle 0x000B
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: Bank 4
		Bank Connections: 0 0
		Current Speed: 60 ns
		Type: DIMM SDRAM
		Installed Size: 64 MB (Single-bank Connection)
		Enabled Size: 64 MB (Single-bank Connection)
		Error Status: OK
Handle 0x000C
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: Bank 5
		Bank Connections: 0 0
		Current Speed: 60 ns
		Type: DIMM SDRAM
		Installed Size: 64 MB (Single-bank Connection)
		Enabled Size: 64 MB (Single-bank Connection)
		Error Status: OK
Handle 0x000D
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: Bank 6
		Bank Connections: 0 0
		Current Speed: 60 ns
		Type: DIMM SDRAM
		Installed Size: 64 MB (Single-bank Connection)
		Enabled Size: 64 MB (Single-bank Connection)
		Error Status: OK
Handle 0x000E
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: Bank 7
		Bank Connections: 0 0
		Current Speed: 60 ns
		Type: DIMM SDRAM
		Installed Size: 64 MB (Single-bank Connection)
		Enabled Size: 64 MB (Single-bank Connection)
		Error Status: OK
Handle 0x000F
	DMI type 7, 15 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 16 KB
		Maximum Size: 32 KB
		Supported SRAM Types:
			Pipeline Burst
			Synchronous
		Installed SRAM Type: Synchronous
Handle 0x0010
	DMI type 7, 15 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 512 KB
		Maximum Size: 512 KB
		Supported SRAM Types:
			Pipeline Burst
			Synchronous
		Installed SRAM Type: Synchronous
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Serial1
		Internal Connector Type: DB-9 male
		External Reference Designator: COMA
		External Connector Type: DB-9 male
		Port Type: Serial Port 16550A Compatible
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Serial2
		Internal Connector Type: DB-9 male
		External Reference Designator: COMB
		External Connector Type: DB-9 male
		Port Type: Serial Port 16550A Compatible
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Parallel
		Internal Connector Type: DB-25 male
		External Reference Designator: LPT
		External Connector Type: DB-25 male
		Port Type: Parallel Port ECP/EPP
Handle 0x0014
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator:  
		Internal Connector Type: PS/2
		External Reference Designator: Keyboard
		External Connector Type: PS/2
		Port Type: Keyboard Port
Handle 0x0015
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator:  
		Internal Connector Type: PS/2
		External Reference Designator: PS/2 Mouse
		External Connector Type: PS/2
		Port Type: Mouse Port
Handle 0x0016
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: ISA Slot1
		Type: 16-bit ISA
		Current Usage: Unknown
		Length: Long
		Characteristics: Unknown
Handle 0x0017
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: ISA Slot2
		Type: 16-bit ISA
		Current Usage: Unknown
		Length: Long
		Characteristics: Unknown
Handle 0x0018
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: PCI Slot1
		Type: 32-bit PCI
		Current Usage: In Use
		Length: Short
		ID: 1
		Characteristics: Unknown
Handle 0x0019
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: PCI Slot2
		Type: 32-bit PCI
		Current Usage: In Use
		Length: Long
		ID: 2
		Characteristics: Unknown
Handle 0x001A
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: PCI Slot3
		Type: 32-bit PCI
		Current Usage: In Use
		Length: Long
		ID: 3
		Characteristics: Unknown
Handle 0x001B
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: PCI Slot4
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 4
		Characteristics: Unknown
Handle 0x001C
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: PCI Slot5
		Type: 32-bit PCI
		Current Usage: In Use
		Length: Long
		ID: 5
		Characteristics: Unknown
Handle 0x001D
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: AGP Slot
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 6
		Characteristics: Unknown
Handle 0x001E
	DMI type 10, 12 bytes.
	On Board Device 1 Information
		Type: Video
		Status: Enabled
		Description: On Board VGA
	On Board Device 2 Information
		Type: SCSI Controller
		Status: Enabled
		Description: SCSI Controller 1
	On Board Device 3 Information
		Type: SCSI Controller
		Status: Enabled
		Description: SCSI Controller 2
	On Board Device 4 Information
		Type: Other
		Status: Enabled
		Description: USB with 2 connectors
Handle 0x001F
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: Today is a very fine day
Handle 0x0020
	DMI type 12, 5 bytes.
	System Configuration Options
		Option 1: This is the reference string 
Handle 0x0021
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 1
			English
		Currently Installed Language: English
Wrong DMI structures count: 34 announced, only 33 decoded.

> Tom, do you remember if any other system ever needed this option?

I don't recall, sorry.

-- 
Tom Rini
http://gate.crashing.org/~trini/

