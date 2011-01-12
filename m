From: Joris Creyghton <jorisctn@gmail.com>
Date: Wed, 12 Jan 2011 15:01:19 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <1294844479.1906.19.camel@Asus5>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-FUbB94N2RM6Tb8RSz6YW"
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
To: lm-sensors@vger.kernel.org


--=-FUbB94N2RM6Tb8RSz6YW
Content-Type: multipart/alternative; boundary="=-76t/gmfzuZzQpr+Q9PUM"


--=-76t/gmfzuZzQpr+Q9PUM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-01-12 at 15:03 +0100, Luca Tettamanti wrote:

> On Tue, Jan 11, 2011 at 3:23 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> > On Tue, Jan 11, 2011 at 3:07 PM, Joris Creyghton <jorisctn@gmail.com> wrote:
> >> Both display 4 fan's, they agree about the CPU fan, but the new interface
> >> assigns one value to a NB fan (North Bridge =? Memory Control Hub (MCH)).
> >> There is no such fan on the Sabertooth board. There are 2 chassis fans and a
> >> power fan though.
> >
> > The names are supplied by the BIOS, so this is another bug.
> > HWF2 is named "CHASSIS3" in the old interface and "Power" in the new.
> > HWF4 is "POWER" in the old interface but "NB" in the new one.
> > They probably swapped the labels... you can try and raise the issue with Asus.
> 
> Oh, BTW: is there an updated BIOS for the board? This issue should be
> visible also under Windows... I guess someone should have noticed.
> It might make sense to let the user override the labels, Jean what do you think?
> 
> Joris, can you also send me the output of dmidecode?
> 
> L

Hi Luca,

I have attached the output of dmidecode of the unmodified system.

I have also  looked into the BIOS output, and the assignment of the fans
corresponds with the output of the sensors command on the system with
the new driver.
I read them from the BIOS screen output:


        CPU fan            927
        Chassis fan 1    629
        Chassis fan 2    484
        Power fan        [N/A]
        NB fan             760

I have the latest BIOS version (0603) for the Sabertooth X58 board.
However, the Asus site has a 2010/11/09 update with the same version
number, while mine says build date 10/29/10.
I don't know if there is any difference between the two.

I'm prepaired to look into that, if you think that makes sense.



--=-76t/gmfzuZzQpr+Q9PUM
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.30.3">
</HEAD>
<BODY>
On Wed, 2011-01-12 at 15:03 +0100, Luca Tettamanti wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
On Tue, Jan 11, 2011 at 3:23 PM, Luca Tettamanti &lt;<A HREF="mailto:kronos.it@gmail.com">kronos.it@gmail.com</A>&gt; wrote:
&gt; On Tue, Jan 11, 2011 at 3:07 PM, Joris Creyghton &lt;<A HREF="mailto:jorisctn@gmail.com">jorisctn@gmail.com</A>&gt; wrote:
&gt;&gt; Both display 4 fan's, they agree about the CPU fan, but the new interface
&gt;&gt; assigns one value to a NB fan (North Bridge =? Memory Control Hub (MCH)).
&gt;&gt; There is no such fan on the Sabertooth board. There are 2 chassis fans and a
&gt;&gt; power fan though.
&gt;
&gt; The names are supplied by the BIOS, so this is another bug.
&gt; HWF2 is named &quot;CHASSIS3&quot; in the old interface and &quot;Power&quot; in the new.
&gt; HWF4 is &quot;POWER&quot; in the old interface but &quot;NB&quot; in the new one.
&gt; They probably swapped the labels... you can try and raise the issue with Asus.

Oh, BTW: is there an updated BIOS for the board? This issue should be
visible also under Windows... I guess someone should have noticed.
It might make sense to let the user override the labels, Jean what do you think?

Joris, can you also send me the output of dmidecode?

L
</PRE>
</BLOCKQUOTE>
Hi Luca,<BR>
<BR>
I have attached the output of dmidecode of the unmodified system.<BR>
<BR>
I have also&nbsp; looked into the BIOS output, and the assignment of the fans corresponds with the output of the sensors command on the system with the new driver.<BR>
I read them from the BIOS screen output:<BR>
<BR>
<BLOCKQUOTE>
    CPU fan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 927<BR>
    Chassis fan 1&nbsp;&nbsp;&nbsp; 629<BR>
    Chassis fan 2&nbsp;&nbsp;&nbsp; 484<BR>
    Power fan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [N/A]<BR>
    NB fan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 760<BR>
</BLOCKQUOTE>
I have the latest BIOS version (0603) for the Sabertooth X58 board.<BR>
However, the Asus site has a 2010/11/09 update with the same version number, while mine says build date 10/29/10.<BR>
I don't know if there is any difference between the two.<BR>
<BR>
I'm prepaired to look into that, if you think that makes sense.<BR>
<BR>
<BR>
</BODY>
</HTML>

--=-76t/gmfzuZzQpr+Q9PUM--

--=-FUbB94N2RM6Tb8RSz6YW
Content-Disposition: attachment; filename="dmidecode.txt"
Content-Type: text/plain; name="dmidecode.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

# dmidecode 2.9
SMBIOS 2.5 present.
80 structures occupying 3027 bytes.
Table at 0x000F0700.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: American Megatrends Inc.
	Version: 0603   
	Release Date: 10/29/2010
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 2048 kB
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
		BIOS ROM is socketed
		EDD is supported
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
	BIOS Revision: 8.15

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: System manufacturer
	Product Name: System Product Name
	Version: System Version
	Serial Number: System Serial Number
	UUID: C0A1001F-C600-0007-10D5-BCAEC519E749
	Wake-up Type: Power Switch
	SKU Number: To Be Filled By O.E.M.
	Family: To Be Filled By O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
	Manufacturer: ASUSTeK Computer INC.
	Product Name: SABERTOOTH X58
	Version: Rev 1.xx
	Serial Number: 107765870002617
	Asset Tag: To Be Filled By O.E.M.
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: To Be Filled By O.E.M.
	Chassis Handle: 0x0003
	Type: Motherboard
	Contained Object Handles: 0

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
	Manufacturer: Chassis Manufacture
	Type: Desktop
	Lock: Not Present
	Version: Chassis Version
	Serial Number: Chassis Serial Number
	Asset Tag: Asset-1234567890
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000001
	Height: Unspecified
	Number Of Power Cords: 1
	Contained Elements: 0

Handle 0x0004, DMI type 4, 40 bytes
Processor Information
	Socket Designation: LGA1366
	Type: Central Processor
	Family: <OUT OF SPEC>
	Manufacturer: Intel            
	ID: A5 06 01 00 FF FB EB BF
	Version: Intel(R) Core(TM) i7 CPU 950 @ 3.07GHz              
	Voltage: 1.2 V
	External Clock: 133 MHz
	Max Speed: 3066 MHz
	Current Speed: 3066 MHz
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
	Thread Count: 8
	Characteristics:
		64-bit capable

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1-Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 256 KB
	Maximum Size: 256 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Instruction
	Associativity: 4-way Set-associative

Handle 0x0006, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2-Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0007, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3-Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 8192 KB
	Maximum Size: 8192 KB
	Supported SRAM Types:
		Other
	Installed SRAM Type: Other
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 16-way Set-associative

Handle 0x0008, DMI type 5, 28 bytes
Memory Controller Information
	Error Detecting Method: 64-bit ECC
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 4096 MB
	Maximum Total Memory Size: 24576 MB
	Supported Speeds:
		70 ns
		60 ns
	Supported Memory Types:
		DIMM
		SDRAM
	Memory Module Voltage: 3.3 V
	Associated Memory Slots: 6
		0x0009
		0x000A
		0x000B
		0x000C
		0x000D
		0x000E
	Enabled Error Correcting Capabilities:
		None

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM0
	Bank Connections: 1
	Current Speed: 1 ns
	Type: DIMM
	Installed Size: 2048 MB (Single-bank Connection)
	Enabled Size: 2048 MB (Single-bank Connection)
	Error Status: OK

Handle 0x000A, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM1
	Bank Connections: 2
	Current Speed: 1 ns
	Type: DIMM
	Installed Size: 2048 MB (Single-bank Connection)
	Enabled Size: 2048 MB (Single-bank Connection)
	Error Status: OK

Handle 0x000B, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM2
	Bank Connections: 3
	Current Speed: 1 ns
	Type: DIMM
	Installed Size: 2048 MB (Single-bank Connection)
	Enabled Size: 2048 MB (Single-bank Connection)
	Error Status: OK

Handle 0x000C, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM3
	Bank Connections: 4
	Current Speed: 1 ns
	Type: DIMM
	Installed Size: 2048 MB (Single-bank Connection)
	Enabled Size: 2048 MB (Single-bank Connection)
	Error Status: OK

Handle 0x000D, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM4
	Bank Connections: 5
	Current Speed: 1 ns
	Type: DIMM
	Installed Size: 2048 MB (Single-bank Connection)
	Enabled Size: 2048 MB (Single-bank Connection)
	Error Status: OK

Handle 0x000E, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM5
	Bank Connections: 6
	Current Speed: 1 ns
	Type: DIMM
	Installed Size: 2048 MB (Single-bank Connection)
	Enabled Size: 2048 MB (Single-bank Connection)
	Error Status: OK

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PS/2 Keyboard
	Internal Connector Type: None
	External Reference Designator: PS/2 Keyboard
	External Connector Type: PS/2
	Port Type: Keyboard Port

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PS/2 Mouse
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: PS/2
	Port Type: Mouse Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB12
	Internal Connector Type: None
	External Reference Designator: USB12
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB34
	Internal Connector Type: None
	External Reference Designator: USB34
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB_3_12
	Internal Connector Type: None
	External Reference Designator: USB56
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: IE1394_1
	Internal Connector Type: None
	External Reference Designator: IEEE1394 1
	External Connector Type: IEEE 1394
	Port Type: Firewire (IEEE P1394)

Handle 0x0015, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: LAN1
	Internal Connector Type: None
	External Reference Designator: GbE LAN 1
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0016, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: AUDIO
	Internal Connector Type: None
	External Reference Designator: AUDIO
	External Connector Type: Other
	Port Type: Audio Port

Handle 0x0017, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Audio Line Out1
	Internal Connector Type: None
	External Reference Designator: Audio Line Out1
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0018, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Audio Line Out2
	Internal Connector Type: None
	External Reference Designator: Audio Line Out2
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0019, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Audio Line Out3
	Internal Connector Type: None
	External Reference Designator: Audio Line Out3
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x001A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Audio Line Out4
	Internal Connector Type: None
	External Reference Designator: Audio Line Out4
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Audio Line Out5
	Internal Connector Type: None
	External Reference Designator: Audio Line Out5
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x001C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Audio Line Out6
	Internal Connector Type: None
	External Reference Designator: Audio Line Out6
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x001D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: F_ESATA
	Internal Connector Type: None
	External Reference Designator: F_ESATA
	External Connector Type: SAS/SATA Plug Receptacle
	Port Type: SATA

Handle 0x001E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: ESATA
	Internal Connector Type: None
	External Reference Designator: ESATA
	External Connector Type: SAS/SATA Plug Receptacle
	Port Type: SATA

Handle 0x001F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SATA1
	Internal Connector Type: SAS/SATA Plug Receptacle
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: SATA

Handle 0x0020, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SATA2
	Internal Connector Type: SAS/SATA Plug Receptacle
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: SATA

Handle 0x0021, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SATA3
	Internal Connector Type: SAS/SATA Plug Receptacle
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: SATA

Handle 0x0022, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SATA4
	Internal Connector Type: SAS/SATA Plug Receptacle
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: SATA

Handle 0x0023, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SATA5
	Internal Connector Type: SAS/SATA Plug Receptacle
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: SATA

Handle 0x0024, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SATA6
	Internal Connector Type: SAS/SATA Plug Receptacle
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: SATA

Handle 0x0025, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SATA_6G_1
	Internal Connector Type: SAS/SATA Plug Receptacle
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: SATA

Handle 0x0026, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SATA_6G_2
	Internal Connector Type: SAS/SATA Plug Receptacle
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: SATA

Handle 0x0027, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB56
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x0028, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB78
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x0029, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB910
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x002A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: USB1112
	Internal Connector Type: Access Bus (USB)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: USB

Handle 0x002B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: IE1394_2
	Internal Connector Type: IEEE 1394
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Firewire (IEEE P1394)

Handle 0x002C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: AAFP
	Internal Connector Type: Mini Jack (headphones)
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Audio Port

Handle 0x002D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CPU_FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x002E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PWR_FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x002F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CHA_FAN1
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0030, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CHA_FAN2
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0031, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: CHA_FAN3
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0032, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: NB_FAN
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0033, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SPDIF_OUT
	Internal Connector Type: On Board Sound Input From CD-ROM
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Audio Port

Handle 0x0034, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: FP_AUDIO
	Internal Connector Type: On Board Sound Input From CD-ROM
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Audio Port

Handle 0x0035, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIEX1_1
	Type: 64-bit PCI Express
	Current Usage: In Use
	Length: Short
	ID: 1
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0036, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIEX1_2
	Type: 32-bit PCI Express
	Current Usage: In Use
	Length: Short
	ID: 2
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0037, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Short
	ID: 3
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0038, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIEX16_1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Short
	ID: 4
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x0039, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIEX16_2
	Type: 32-bit PCI Express
	Current Usage: Available
	Length: Short
	ID: 5
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x003A, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIEX16_3
	Type: 32-bit PCI Express
	Current Usage: Available
	Length: Short
	ID: 6
	Characteristics:
		3.3 V is provided
		Opening is shared
		PME signal is supported

Handle 0x003B, DMI type 10, 6 bytes
On Board Device Information
	Type: Ethernet
	Status: Enabled
	Description:  Onboard Ethernet

Handle 0x003C, DMI type 11, 5 bytes
OEM Strings
	String 1: To Be Filled By O.E.M.
	String 2: To Be Filled By O.E.M.
	String 3: To Be Filled By O.E.M.
	String 4: To Be Filled By O.E.M.

Handle 0x003D, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 6
		en|US|iso8859-1
		zh|ZH|iso8859-1
		de|DE|iso8859-1
		cn|CN|iso8859-1
		fr|FR|iso8859-1
		ja|JP|unicode-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x003E, DMI type 15, 55 bytes
System Event Log
	Area Length: 1008 bytes
	Header Start Offset: 0x2010
	Data Start Offset: 0x2010
	Access Method: OEM-specific
	Access Address: Unknown
	Status: Valid, Not Full
	Change Token: 0x00000000
	Header Format: No Header
	Supported Log Type Descriptors: 1
	Descriptor 1: OEM-specific
	Data Format 1: POST results bitmap

Handle 0x003F, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Multi-bit ECC
	Maximum Capacity: 24 GB
	Error Information Handle: Not Provided
	Number Of Devices: 6

Handle 0x0040, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Array Handle: 0x003F
	Partition Width: 0

Handle 0x0041, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x003F
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM0
	Bank Locator: BANK0
	Type: Other
	Type Detail: Other
	Speed: 1066 MHz (0.9 ns)
	Manufacturer: Manufacturer00
	Serial Number: SerNum00
	Asset Tag: AssetTagNum0
	Part Number: ModulePartNumber00

Handle 0x0042, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0041
	Memory Array Mapped Address Handle: 0x0040
	Partition Row Position: 1
	Interleave Position: Unknown
	Interleaved Data Depth: 2

Handle 0x0043, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x003F
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM1
	Bank Locator: BANK1
	Type: Other
	Type Detail: Other
	Speed: 1066 MHz (0.9 ns)
	Manufacturer: Manufacturer01
	Serial Number: SerNum01
	Asset Tag: AssetTagNum1
	Part Number: ModulePartNumber01

Handle 0x0044, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0043
	Memory Array Mapped Address Handle: 0x0040
	Partition Row Position: 1
	Interleave Position: Unknown
	Interleaved Data Depth: 2

Handle 0x0045, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x003F
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM2
	Bank Locator: BANK2
	Type: Other
	Type Detail: Other
	Speed: 1066 MHz (0.9 ns)
	Manufacturer: Manufacturer02
	Serial Number: SerNum02
	Asset Tag: AssetTagNum2
	Part Number: ModulePartNumber02

Handle 0x0046, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0045
	Memory Array Mapped Address Handle: 0x0040
	Partition Row Position: 1
	Interleave Position: Unknown
	Interleaved Data Depth: 2

Handle 0x0047, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x003F
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM3
	Bank Locator: BANK3
	Type: Other
	Type Detail: Other
	Speed: 1066 MHz (0.9 ns)
	Manufacturer: Manufacturer03
	Serial Number: SerNum03
	Asset Tag: AssetTagNum3
	Part Number: ModulePartNumber03

Handle 0x0048, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0047
	Memory Array Mapped Address Handle: 0x0040
	Partition Row Position: 1
	Interleave Position: Unknown
	Interleaved Data Depth: 2

Handle 0x0049, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x003F
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM4
	Bank Locator: BANK4
	Type: Other
	Type Detail: Other
	Speed: 1066 MHz (0.9 ns)
	Manufacturer: Manufacturer04
	Serial Number: SerNum04
	Asset Tag: AssetTagNum4
	Part Number: ModulePartNumber04

Handle 0x004A, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x0049
	Memory Array Mapped Address Handle: 0x0040
	Partition Row Position: 1
	Interleave Position: Unknown
	Interleaved Data Depth: 2

Handle 0x004B, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x003F
	Error Information Handle: Not Provided
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: DIMM
	Set: None
	Locator: DIMM5
	Bank Locator: BANK5
	Type: Other
	Type Detail: Other
	Speed: 1066 MHz (0.9 ns)
	Manufacturer: Manufacturer05
	Serial Number: SerNum05
	Asset Tag: AssetTagNum5
	Part Number: ModulePartNumber05

Handle 0x004C, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x004B
	Memory Array Mapped Address Handle: 0x0040
	Partition Row Position: 1
	Interleave Position: Unknown
	Interleaved Data Depth: 2

Handle 0x004D, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x004E, DMI type 139, 54 bytes
OEM-specific Type
	Header and Data:
		8B 36 4E 00 00 1F C6 00 00 07 10 D5 04 04 32 55
		F8 00 A2 02 A1 00 40 63 43 10 FE 81 03 DF 40 B2
		00 20 00 73 3C 10 08 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 01
	Strings:
		V1394GUID

Handle 0x004F, DMI type 127, 4 bytes
End Of Table


--=-FUbB94N2RM6Tb8RSz6YW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-FUbB94N2RM6Tb8RSz6YW--

