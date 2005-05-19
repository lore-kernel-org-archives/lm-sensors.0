From: rafael.espindola@ic.unicamp.br (Rafael =?iso-8859-1?q?=C1vila_de_Esp=EDndola?=)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: IBM hardware
Message-Id: <200403171005.05997.rafael.espindola@ic.unicamp.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <200403161623.00418.rafael.espindola@ic.unicamp.br>
In-Reply-To: <200403161623.00418.rafael.espindola@ic.unicamp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tuesday 16 March 2004 17:27, Jean Delvare wrote:
I have edited the sensors-detect script. I have also executed the programs 
from the dmidecode CVS. The results are in the attached file.

The machine is up and running with no problems. :)

Rafael ?vila de Esp?ndola

-------------- next part --------------
sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 System vendor: IBM
 BIOS version: 2AKT32ABR
 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation, just scanning
 the bus will break your Thinkpad forever!
 If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We have
 had users reporting system breakage on other IBM systems as well.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 18a0 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x31
Client found at address 0x44
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x6b81)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x6b81)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x6b81)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x6b)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x6b)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x6b)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x6b)
Probing for `Nat. Semi. PC87365 Super IO Sensors'
  Failed! (0x6b)
Probing for `Nat. Semi. PC87366 Super IO Sensors'
  Failed! (0x6b)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x6b)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x6b)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x6b)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x6b)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x6b)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x6b)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x6b)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x6b)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x6b)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x6b)
Probing for `Winbond W83697UF Super IO PWM'
  Failed! (0x6b)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 18a0' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 18a0' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
# I2C chip drivers
eeprom
#----cut here----

Then, run /etc/init.d/modutils


To make the sensors modules behave correctly, add these lines to
/etc/modutils/local and run update-modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

-----------------------------------------------------------------

# biosdecode 2.3
SMBIOS 2.31 present.
        Structure Table Length: 2076 bytes
        Structure Table Address: 0x000EF930
        Number Of Structures: 57
        Maximum Structure Size: 508 bytes
BIOS32 Service Directory present.
        Revision: 0
        Calling Interface Address: 0x000FD71C
ACPI 1.0 present.
        OEM Identifier: PTLTD
        RSD Table 32-bit Address: 0x1F775110
PNP BIOS 1.0 present.
        Event Notification: Not Supported
        Real Mode 16-bit Code Address: F000:C232
        Real Mode 16-bit Data Address: 0040:0000
        16-bit Protected Mode Code Address: 0x000FC250
        16-bit Protected Mode Data Address: 0x00000400
PCI Interrupt Routing 1.0 present.
        Router ID: 00:1f.0
        Exclusive IRQs: None
        Compatible Router: 8086:122e
        Slot Entry 1: ID 00:00, on-board
        Slot Entry 2: ID 00:02, on-board
        Slot Entry 3: ID 00:01, on-board
        Slot Entry 4: ID 01:00, slot number 10
        Slot Entry 5: ID 00:1d, on-board
        Slot Entry 6: ID 00:1e, on-board
        Slot Entry 7: ID 03:0a, slot number 1
        Slot Entry 8: ID 03:09, slot number 2
        Slot Entry 9: ID 03:0c, slot number 3
        Slot Entry 10: ID 03:08, on-board
        Slot Entry 11: ID 03:0b, on-board
        Slot Entry 12: ID 00:1f, on-board
VPD present.
        BIOS Build ID: 2AKT32ABR
        Box Serial Number: 82AR7GX
        Motherboard Serial Number: IBM
        Machine Type/Model: 8188LPF

---------------------------------------------------------------

# dmidecode 2.3
SMBIOS 2.31 present.
57 structures occupying 2076 bytes.
Table at 0x000EF930.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: IBM
		Version: 2AKT32ABR
		Release Date: 10/23/2003
		Address: 0xE46D0
		Runtime Size: 112944 bytes
		ROM Size: 512 kB
		Characteristics:
			PCI is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			EDD is supported
			ACPI is supported
			USB legacy is supported
			AGP is supported
			LS-120 boot is supported
			Smart battery is supported
			BIOS boot specification is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: IBM
		Product Name: 8188LPF
		Version: Not Specified
		Serial Number: 82AR7GX
		UUID: BC8D750C-1E9D-2612-9EAE-8CE6090F0D09
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: IBM
		Product Name: IBM
		Version: Not Specified
		Serial Number: Not Specified
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: IBM
		Type: Desktop
		Lock: Not Present
		Version: Not Specified
		Serial Number: Not Specified
		Asset Tag: .........................
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00000000
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: WMT478/NWD
		Type: Central Processor
		Family: Pentium 4
		Manufacturer: GenuineIntel
		ID: 29 0F 00 00 FF FB EB BF
		Signature: Type 0, Family 15, Model 2, Stepping 9
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
			DS (Debug store)
			ACPI (ACPI supported)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
			SSE2 (Streaming SIMD extensions 2)
			SS (Self-snoop)
			HTT (Hyper-threading technology)
			TM (Thermal monitor supported)
			SBF (Signal break on FERR)
		Version: Intel(R) Pentium(R) 4 CPU 2.66GHz
		Voltage: 1.8 V
		External Clock: 133 MHz
		Max Speed: 3200 MHz
		Current Speed: 2667 MHz
		Status: Populated, Enabled
		Upgrade: Socket 478
		L1 Cache Handle: 0x0005
		L2 Cache Handle: 0x0006
		L3 Cache Handle: Not Provided
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 8 KB
		Maximum Size: 256 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Asynchronous
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Data
		Associativity: Unknown
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Socketed, Level 2
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 512 KB
		Maximum Size: 512 KB
		Supported SRAM Types:
			Burst
			Pipeline Burst
			Asynchronous
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unknown
		Associativity: Unknown
Handle 0x0007
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: J6
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator: COM 1
		External Connector Type: DB-9 male
		Port Type: Serial Port 16550A Compatible
Handle 0x0008
	DMI type 126, 9 bytes.
	Inactive
Handle 0x0009
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: J20
		Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
		External Reference Designator: Parallel
		External Connector Type: DB-25 female
		Port Type: Parallel Port ECP/EPP
Handle 0x000A
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: J1M1
		Internal Connector Type: None
		External Reference Designator: Keyboard
		External Connector Type: Circular DIN-8 male
		Port Type: Keyboard Port
Handle 0x000B
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: J1M1
		Internal Connector Type: None
		External Reference Designator: PS/2 Mouse
		External Connector Type: Circular DIN-8 male
		Port Type: Keyboard Port
Handle 0x000C
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: 4REARUSB/BOT
		Internal Connector Type: None
		External Reference Designator: USB 1
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x000D
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: 4REARUSB/MIDL
		Internal Connector Type: None
		External Reference Designator: USB 2
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: 4REARUSB/MIDH
		Internal Connector Type: None
		External Reference Designator: USB 3
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: 4REARUSB/TOP
		Internal Connector Type: None
		External Reference Designator: USB 4
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: 2REARUSB/BOT
		Internal Connector Type: None
		External Reference Designator: USB 5
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: 2REARUSB/TOP
		Internal Connector Type: None
		External Reference Designator: USB 6
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: FRONTUSB/BOT
		Internal Connector Type: None
		External Reference Designator: USB 7
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: FRONTUSB/TOP
		Internal Connector Type: None
		External Reference Designator: USB 8
		External Connector Type: Access Bus (USB)
		Port Type: USB
Handle 0x0014
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: Audio Line In
		External Connector Type: Mini Jack (headphones)
		Port Type: Audio Port
Handle 0x0015
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: Audio Line Out
		External Connector Type: Mini Jack (headphones)
		Port Type: Audio Port
Handle 0x0016
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: Not Specified
		Internal Connector Type: None
		External Reference Designator: Microphone
		External Connector Type: Mini Jack (headphones)
		Port Type: Audio Port
Handle 0x0017
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: J12
		Internal Connector Type: None
		External Reference Designator: Network
		External Connector Type: RJ-45
		Port Type: Network Port
Handle 0x0018
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: AGP
		Type: 32-bit AGP
		Current Usage: Available
		Length: Long
		ID: 10
		Characteristics:
			3.3 V is provided
Handle 0x0019
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot #1 - J1001I
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 1
		Characteristics:
			3.3 V is provided
Handle 0x001A
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot #2 - J901I
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 2
		Characteristics:
			3.3 V is provided
Handle 0x001B
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PCI Slot #3 - J901I
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 3
		Characteristics:
			3.3 V is provided
Handle 0x001C
	DMI type 10, 6 bytes.
	On Board Device Information
		Type: Other
		Status: Disabled
		Description: IBM Embedded Security Hardware Type 0
Handle 0x001D
	DMI type 10, 6 bytes.
	On Board Device Information
		Type: Sound
		Status: Enabled
		Description: AD1981
Handle 0x001E
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: BB:2A32A
Handle 0x001F
	DMI type 12, 5 bytes.
	System Configuration Options
		Option 1: JP 7: 1-2 Normal, 2-3 Clear CMOS/Boot Block Recovery
Handle 0x0020
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 1
			ptBR
		Currently Installed Language: ptBR
Handle 0x0021
	DMI type 15, 29 bytes.
	System Event Log
		Area Length: 240 bytes
		Header Start Offset: 0x0000
		Header Length: 16 bytes
		Data Start Offset: 0x0010
		Access Method: General-purpose non-volatile data functions
		Access Address: 0x0000
		Status: Valid, Not Full
		Change Token: 0x0000000E
		Header Format: Type 1
		Supported Log Type Descriptors: 3
		Descriptor 1: POST error
		Data Format 1: POST results bitmap
		Descriptor 2: Single-bit ECC memory error
		Data Format 2: Multiple-event
		Descriptor 3: Multi-bit ECC memory error
		Data Format 3: Multiple-event
Handle 0x0022
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 4 GB
		Error Information Handle: Not Provided
		Number Of Devices: 4
Handle 0x0023
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0022
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: DIMM
		Set: 1
		Locator: J4
		Bank Locator: CH_A_DIMM0
		Type: DDR
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0024
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0022
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: DIMM
		Set: 1
		Locator: J5
		Bank Locator: CH_A_DIMM1
		Type: DDR
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0025
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0022
		Error Information Handle: No Error
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: 1
		Locator: J15
		Bank Locator: CH_B_DIMM0
		Type: DDR
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0026
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x0022
		Error Information Handle: No Error
		Total Width: Unknown
		Data Width: Unknown
		Size: No Module Installed
		Form Factor: DIMM
		Set: 1
		Locator: J16
		Bank Locator: CH_B_DIMM1
		Type: DDR
		Type Detail: Synchronous
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0027
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x0022
		Partition Width: 0
Handle 0x0028
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x0023
		Memory Array Mapped Address Handle: 0x0027
		Partition Row Position: Unknown
		Interleave Position: Unknown
		Interleaved Data Depth: Unknown
Handle 0x0029
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00010000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x0024
		Memory Array Mapped Address Handle: 0x0027
		Partition Row Position: Unknown
		Interleave Position: Unknown
		Interleaved Data Depth: Unknown
Handle 0x002A
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x0001FFFFC00
		Ending Address: 0x0001FFFFFFF
		Range Size: 1 kB
		Physical Device Handle: 0x0025
		Memory Array Mapped Address Handle: 0x0027
		Partition Row Position: Unknown
		Interleave Position: Unknown
		Interleaved Data Depth: Unknown
Handle 0x002B
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x0001FFFFC00
		Ending Address: 0x0001FFFFFFF
		Range Size: 1 kB
		Physical Device Handle: 0x0026
		Memory Array Mapped Address Handle: 0x0027
		Partition Row Position: Unknown
		Interleave Position: Unknown
		Interleaved Data Depth: Unknown
Handle 0x002C
	DMI type 23, 13 bytes.
	System Reset
		Status: Enabled
		Watchdog Timer: Present
		Boot Option: Do Not Reboot
		Boot Option On Limit: Do Not Reboot
		Reset Count: Unknown
		Reset Limit: Unknown
		Timer Interval: Unknown
		Timeout: Unknown
Handle 0x002D
	DMI type 24, 5 bytes.
	Hardware Security
		Power-On Password Status: Enabled
		Keyboard Password Status: Enabled
		Administrator Password Status: Enabled
		Front Panel Reset Status: Not Implemented
Handle 0x002E
	DMI type 25, 9 bytes.
	System Power Controls
		Next Scheduled Power-on: 12-31 23:59:59
Handle 0x002F
	DMI type 26, 20 bytes.
	Voltage Probe
		Description: Voltage Probe
		Location: Processor
		Status: OK
		Maximum Value: Unknown
		Minimum Value: Unknown
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
Handle 0x0030
	DMI type 27, 12 bytes.
	Cooling Device
		Temperature Probe Handle: 0x0031
		Type: Fan
		Status: OK
		OEM-specific Information: 0x00000000
Handle 0x0031
	DMI type 28, 20 bytes.
	Temperature Probe
		Description: Temperature Probe
		Location: Processor
		Status: OK
		Maximum Value: Unknown
		Minimum Value Unknown
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
Handle 0x0032
	DMI type 29, 20 bytes.
	Electrical Current Probe
		Description: Electrical Current Probe
		Location: Processor
		Status: OK
		Maximum Value: Unknown
		Minimum Value: Unknown
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
Handle 0x0033
	DMI type 30, 6 bytes.
	Out-of-band Remote Access
		Manufacturer Name: Intel
		Inbound Connection: Enabled
		Outbound Connection: Disabled
Handle 0x0034
	DMI type 32, 20 bytes.
	System Boot Information
		Status: <OUT OF SPEC>
Handle 0x0035
	DMI type 126, 5 bytes.
	Inactive
Handle 0x0036
	DMI type 126, 4 bytes.
	Inactive
Handle 0x0037
	DMI type 127, 4 bytes.
	End Of Table
Handle 0x0038
	DMI type 127, 4 bytes.
	End Of Table
-------------------------------------------------
# vpddecode 2.3
BIOS Build ID: 2AKT32ABR
Product Name: Unknown, please report!
Box Serial Number: 82AR7GX
Motherboard Serial Number: IBM
Machine Type/Model: 8188LPF
