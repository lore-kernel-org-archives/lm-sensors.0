From: achim <achim@ag-web.biz>
Date: Sat, 03 May 2008 21:18:48 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <1209849528.3420.18.camel@debian-9850.ag-home.muc>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-uCELGtxaeFqgApOKD7rP"
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
To: lm-sensors@vger.kernel.org


--=-uCELGtxaeFqgApOKD7rP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> I don't think that this rules out overclocking. The overclocked CPU
> died, the non-overclocked one froze but is still alive. If nothing
> else, it suggests that the overclocked CPU was more fragile against
> whatever happened.
It sorted out the coincidence theory. I agree with you that the
overclocked cpu was more fragile. I spotted a week ago that the cpu was
not as robust as at the beginning.While inspecting the capabilities of
the northbridge I ran stability testings for about ~30hrs with
northbridge voltages at around 1.4V (1.3V is stock). After that the
system was no longer stable at 2.8GHz with 1.3125V (1.3V stock). Going
back to 2.7GHz fixed the stability issues. I ran this for at least a
days without any problems till it froze. It was just a coincidence that
i used lm-sensors and not typical windows monitoring tools. 

> Looks a lot like that older bug report I mentioned where probing
> address 0x2e rebooted the machine. Probably designed by the same
> person, using the same or similar chip.
> 
Exactly in oposite to the user of the DFI Lanparty board with the nvidia
chipset i get no hangups when i load the it87 module manual without
parameters excluding 0x2e.
> > 

> > > The good news is that the motherboard DMI data is present:
> > > 
> > > Base Board Information
> > > 	Manufacturer: SAPPHIRE Inc.
> > > 	Product Name: PC-AM2RD790
> > > 
> > > So we can blacklist it from i2c-piix4. I'll prepare a patch later today..  

> In general, people using a BIOS which was not meant for their
> motherboard should know that they are doing something wrong and should
> be ready to face the consequences. That being said, it would be easy
> enough to blacklist this other motherboard as well, presumably it has
> the same problems. Can you provide the dmidecode information for the
> DFI board / BIOS?
> 
Other already tried to flash the dfi bios on the sapphire board and i
also used it for weeks because the bios the board was shipped with had
all type of issues.
So I switched to the latest stable DFI bios and attached a dmidecode
dump here.
I also tried i2cdump at 0x4e and 0x6e.
Same results as with the sapphire bios. Again the 0x6e dump stopped at
0x9e and outputs only XX till i reboot, a reload of the i2c-piix4 module
does not help here.


--=-uCELGtxaeFqgApOKD7rP
Content-Disposition: attachment; filename=sapphire-790FX-dmidecode-dfi-bios.txt
Content-Type: text/plain; name=sapphire-790FX-dmidecode-dfi-bios.txt;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

# dmidecode 2.9
SMBIOS 2.5 present.
54 structures occupying 2274 bytes.
Table at 0x000F0000.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: Phoenix Technologies, LTD
	Version: 6.00 PG
	Release Date: 04/16/2008
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
	Manufacturer: DFI Inc.
	Product Name: LP UT 790FX
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
	Family: Athlon 64 X2
	Manufacturer: AMD
	ID: B2 0F 06 00 FF FB 8B 17
	Signature: Family 15, Model 107, Stepping 2
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
	Version: AMD Athlon(tm) 64 X2 Dual Core Processor 5000+
	Voltage: 1.3 V
	External Clock: 200 MHz
	Max Speed: 3000 MHz
	Current Speed: 2600 MHz
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
	Bank Connections: None
	Current Speed: Unknown
	Type: Other Unknown EDO
	Installed Size: Not Installed
	Enabled Size: Not Installed
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
	ID: 232
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
	ID: 235
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
	Speed: 2048 MHz (0.5 ns)
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
	Speed: 2048 MHz (0.5 ns)
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
	Speed: 2048 MHz (0.5 ns)
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
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: A3
	Bank Locator: Bank6/7
	Type: DDR2
	Type Detail: None
	Speed: 2048 MHz (0.5 ns)
	Manufacturer: <BAD INDEX>
	Serial Number: Not Specified
	Asset Tag: None
	Part Number: None

Handle 0x002A, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0103FFFFFFF
	Range Size: 65 GB
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
	Starting Address: 0x01000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 4033 GB
	Physical Device Handle: 0x0028
	Memory Array Mapped Address Handle: 0x002A
	Partition Row Position: 1

Handle 0x002E, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
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
		00 00 00 00 01 06 16 00 00 00 00 00 03 00 00 00
		00 00 7F 00 00 00 00 00 01 00 00 00 00 00 00 00
		02 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00
		04 00 00 00 00 00 00 00 05 00 00 00 00 00 00 00
		06 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00
		40 00 10 0A 00 00 00 00 00 00 03 00 EB 02 00 AE
		00 00 00 00 00 00 00 00 01 00 00 00 01 01 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 E0 3E 78 00 00 00 00 00 00 00 00 00
		46 00 00 00 00 00 00 00 20 00 00 00 00 00 00 00
		24 F2 7D AE 20 13 82 20 10 08 01 00 7B 00 10 74
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00

Handle 0x0032, DMI type 190, 212 bytes
OEM-specific Type
	Header and Data:
		BE D4 32 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
		C0 F4 33 00 15 14 15 16 16 15 15 14 15 00 00 00
		14 13 14 13 12 12 12 13 14 00 00 00 00 40 00 00
		15 15 16 17 16 15 15 16 15 14 12 13 13 13 14 13
		14 14 00 38 00 00 22 32 11 20 20 25 20 10 22 32
		11 20 20 25 20 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00

Handle 0x0034, DMI type 194, 244 bytes
OEM-specific Type
	Header and Data:
		C2 F4 34 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		00 00 00 00

Handle 0x0035, DMI type 127, 4 bytes
End Of Table


--=-uCELGtxaeFqgApOKD7rP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-uCELGtxaeFqgApOKD7rP--

