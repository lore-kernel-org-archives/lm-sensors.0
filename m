From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Sep 2012 22:19:16 +0000
Subject: Re: [lm-sensors] No such subfeature known when sensors -s
Message-Id: <20120916221916.GA29366@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5051971B.7030608@iol.ie>
In-Reply-To: <5051971B.7030608@iol.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, Sep 16, 2012 at 09:03:17PM +0100, Jean-Pierre Thibert wrote:
> On 16/09/12 19:53, Guenter Roeck wrote:
> >On Sun, Sep 16, 2012 at 07:44:58AM +0100, Jean-Pierre Thibert wrote:
> >[ ... ]
> >>>
> >>I have an ASRock 970 Extreme4 UEFI version P2.00
> >>In the H/W Monitor page of the UEFI/BIOS, I have the following:
> >>CPU Temperature :    36.5 =B0C
> >>M/B Temperature :    28.0 =B0C
> >>
> >>CPU Fan 1 Speed :    1065 RPM (this is a pwm connector with 4 pins.
> >>I have a pwm fan) called CPU_FAN1 on the motherboard
> >>CPU Fan 2 Speed :    N/A (this is a 3 pins connector. No connected
> >>fan) called CPU_FAN2 on the motherboard
> >>Chassis Fan 1 Speed :    N/A (this is a pwm connector with 4 pins.
> >>No connected fan) called CHA_FAN1 on the motherboard
> >>Chassis Fan 2 Speed :    730 RPM (this is a 3 pins connector. I have
> >>a 3 pins connected fan) called CHA_FAN2 on the motherboard
> >>Chassis Fan 3 Speed :    760 RPM (this is a 3 pins connector. I have
> >>a 3 pins connected fan) called CHA_FAN3 on the motherboard
> >>Power Fan Speed :    N/A (this is a 3 pins connector. No connected
> >>fan) called PWR_FAN1 on the motherboard
> >>
> >>Vcore :    +1.328 V
> >>+ 12.00V :    +12.144 V
> >>+ 5.00V :    +5.136 V
> >>+ 3.30V :    +3.280 V
> >>
> >>lm-sensors has almost all the values but no fan speed.
> >>I don't know why I had the CPU_FAN2 for a short time and it disappeared.
> >>I can't understand what you suggest to have the value back. Could
> >I did not suggest anything.
> >
> >I found some information about the board. The chassis fans are connected=
 to
> >memory mapped IO, so there is nothing we can do there. There are two CPU=
 fans,
> >multiplexed to the SuperIO chip through GPIO pins. It _might be possible=
 that
> >we can manually set those pins.
> >
> >Please send the output of the following commands:
> >	isadump -y -k 0x87,0x87 0x2e 0x2f
> >	isadump -y -k 0x87,0x87 0x2e 0x2f 8
> >	dmidecode
> >
> >Thanks,
> >Guenter
> >
> >
> >
> >
> sudo isadump -y -k 0x87,0x87 0x2e 0x2f
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff 00 ff ff ff ff 0b ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff f8 ce 00 00 ff ff
> 20: c3 33 ff 00 5c 00 00 90 00 ff 60 04 81 00 00 01
> 30: e1 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: 02 90 00 00 ff ff ff ff ff ff ff ff ff ff ff ff
> 70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: 7f 7f ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: 00 00 00 a4 ff 10 00 87 47 00 00 ff ff ff ff ff
>=20
>=20
> sudo isadump -y -k 0x87,0x87 0x2e 0x2f 8
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff 00 ff ff ff ff 08 ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff f8 ce 00 00 ff ff
> 20: c3 33 ff 00 5c 00 00 90 00 ff 60 04 81 00 00 01
> 30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: f3 f3 00 ff 00 00 00 00 ff ff ff ff ff ff ff ff
>=20

I just noticed that you dropped the mailing list in your reply.
Please don't do that; others may need the information later on,
and I myself use it for searches.

I initially thought the above does not help, but it kind of makes sense.

You can try the following command sequence (at your own risk):

isaset -y -f 0x2e 0x87
isaset -y -f 0x2e 0x87
isaset -y 0x2e 0x2f 0x7 0x8
isaset -y 0x2e 0x2f 0xf0 0xb2
isaset -y 0x2e 0x2f 0xf1 0xb3

The 0xb3 in the last command should select CPUFANIN. Replace it with 0xf2 to
select CPUFANIN2.

You'll have to copy the commands into a file and execute it as shell script.

Do _not_ play with other settings of register 0xf0 or 0xf1. The information
in the ASRock tool suggests that one of the bits is used to control the DDR3
voltage.

Guenter

>  sudo dmidecode
> # dmidecode 2.11
> SMBIOS 2.6 present.
> 28 structures occupying 1531 bytes.
> Table at 0x000EF110.
>=20
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>     Manufacturer: To Be Filled By O.E.M.
>     Product Name: To Be Filled By O.E.M.
>     Version: To Be Filled By O.E.M.
>     Serial Number: To Be Filled By O.E.M.
>     UUID: 03000200-0400-0500-0006-000700080009
>     Wake-up Type: Power Switch
>     SKU Number: To Be Filled By O.E.M.
>     Family: To Be Filled By O.E.M.
>=20
> Handle 0x0002, DMI type 2, 15 bytes
> Base Board Information
>     Manufacturer: ASRock
>     Product Name: 970 Extreme4
>     Version:
>     Serial Number:
>     Asset Tag:
>     Features:
>         Board is a hosting board
>         Board is replaceable
>     Location In Chassis:
>     Chassis Handle: 0x0003
>     Type: Motherboard
>     Contained Object Handles: 0
>=20
> Handle 0x0003, DMI type 3, 21 bytes
> Chassis Information
>     Manufacturer: To Be Filled By O.E.M.
>     Type: Desktop
>     Lock: Not Present
>     Version: To Be Filled By O.E.M.
>     Serial Number: To Be Filled By O.E.M.
>     Asset Tag: To Be Filled By O.E.M.
>     Boot-up State: Safe
>     Power Supply State: Safe
>     Thermal State: Safe
>     Security Status: None
>     OEM Information: 0x00000000
>     Height: Unspecified
>     Number Of Power Cords: 1
>     Contained Elements: 0
>=20
> Handle 0x0004, DMI type 4, 42 bytes
> Processor Information
>     Socket Designation: CPUSocket
>     Type: Central Processor
>     Family: <OUT OF SPEC>
>     Manufacturer: AMD
>     ID: 12 0F 60 00 FF FB 8B 17
>     Version: AMD FX(tm)-8120 Eight-Core Processor
>     Voltage: 1.4 V
>     External Clock: 200 MHz
>     Max Speed: 3100 MHz
>     Current Speed: 3100 MHz
>     Status: Populated, Enabled
>     Upgrade: Socket AM3
>     L1 Cache Handle: 0x0005
>     L2 Cache Handle: 0x0006
>     L3 Cache Handle: 0x0007
>     Serial Number: To Be Filled By O.E.M.
>     Asset Tag: To Be Filled By O.E.M.
>     Part Number: To Be Filled By O.E.M.
>     Core Count: 8
>     Core Enabled: 8
>     Thread Count: 8
>     Characteristics:
>         64-bit capable
>=20
> Handle 0x0005, DMI type 7, 19 bytes
> Cache Information
>     Socket Designation: L1-Cache
>     Configuration: Enabled, Not Socketed, Level 1
>     Operational Mode: Write Back
>     Location: Internal
>     Installed Size: 384 kB
>     Maximum Size: 384 kB
>     Supported SRAM Types:
>         Pipeline Burst
>     Installed SRAM Type: Pipeline Burst
>     Speed: 1 ns
>     Error Correction Type: Multi-bit ECC
>     System Type: Unified
>     Associativity: 2-way Set-associative
>=20
> Handle 0x0006, DMI type 7, 19 bytes
> Cache Information
>     Socket Designation: L2-Cache
>     Configuration: Enabled, Not Socketed, Level 2
>     Operational Mode: Write Back
>     Location: Internal
>     Installed Size: 8192 kB
>     Maximum Size: 8192 kB
>     Supported SRAM Types:
>         Pipeline Burst
>     Installed SRAM Type: Pipeline Burst
>     Speed: 1 ns
>     Error Correction Type: Multi-bit ECC
>     System Type: Unified
>     Associativity: 16-way Set-associative
>=20
> Handle 0x0007, DMI type 7, 19 bytes
> Cache Information
>     Socket Designation: L3-Cache
>     Configuration: Enabled, Not Socketed, Level 3
>     Operational Mode: Write Back
>     Location: Internal
>     Installed Size: 8192 kB
>     Maximum Size: 8192 kB
>     Supported SRAM Types:
>         Pipeline Burst
>     Installed SRAM Type: Pipeline Burst
>     Speed: 1 ns
>     Error Correction Type: Multi-bit ECC
>     System Type: Unified
>     Associativity: 64-way Set-associative
>=20
> Handle 0x0008, DMI type 9, 17 bytes
> System Slot Information
>     Designation: PCI1
>     Type: 32-bit PCI
>     Current Usage: In Use
>     Length: Short
>     ID: 1
>     Characteristics:
>         3.3 V is provided
>         Opening is shared
>         PME signal is supported
>=20
> Handle 0x0009, DMI type 9, 17 bytes
> System Slot Information
>     Designation: PCI2
>     Type: 32-bit PCI
>     Current Usage: In Use
>     Length: Short
>     ID: 2
>     Characteristics:
>         3.3 V is provided
>         Opening is shared
>         PME signal is supported
>=20
> Handle 0x000A, DMI type 9, 17 bytes
> System Slot Information
>     Designation: PCIE1
>     Type: x1 PCI Express
>     Current Usage: In Use
>     Length: Short
>     ID: 17
>     Characteristics:
>         3.3 V is provided
>         Opening is shared
>         PME signal is supported
>     Bus Address: 0000:00:0f.0
>=20
> Handle 0x000B, DMI type 9, 17 bytes
> System Slot Information
>     Designation: PCIE2
>     Type: x16 PCI Express
>     Current Usage: In Use
>     Length: Short
>     ID: 18
>     Characteristics:
>         3.3 V is provided
>         Opening is shared
>         PME signal is supported
>     Bus Address: 0000:00:02.0
>=20
> Handle 0x000C, DMI type 9, 17 bytes
> System Slot Information
>     Designation: PCIE3
>     Type: x1 PCI Express
>     Current Usage: In Use
>     Length: Short
>     ID: 19
>     Characteristics:
>         3.3 V is provided
>         Opening is shared
>         PME signal is supported
>     Bus Address: 0000:00:0f.1
>=20
> Handle 0x000D, DMI type 9, 17 bytes
> System Slot Information
>     Designation: PCIE4
>     Type: x16 PCI Express
>     Current Usage: In Use
>     Length: Short
>     ID: 20
>     Characteristics:
>         3.3 V is provided
>         Opening is shared
>         PME signal is supported
>     Bus Address: 0000:00:0b.0
>=20
> Handle 0x000E, DMI type 9, 17 bytes
> System Slot Information
>     Designation: PCIE5
>     Type: x4 PCI Express
>     Current Usage: In Use
>     Length: Short
>     ID: 21
>     Characteristics:
>         3.3 V is provided
>         Opening is shared
>         PME signal is supported
>     Bus Address: 0000:00:0d.0
>=20
> Handle 0x000F, DMI type 11, 5 bytes
> OEM Strings
>     String 1: To Be Filled By O.E.M.
>=20
> Handle 0x0010, DMI type 16, 15 bytes
> Physical Memory Array
>     Location: System Board Or Motherboard
>     Use: System Memory
>     Error Correction Type: None
>     Maximum Capacity: 32 GB
>     Error Information Handle: Not Provided
>     Number Of Devices: 4
>=20
> Handle 0x0011, DMI type 19, 15 bytes
> Memory Array Mapped Address
>     Starting Address: 0x00000000000
>     Ending Address: 0x0021F0003FF
>     Range Size: 8688 MB
>     Physical Array Handle: 0x0010
>     Partition Width: 255
>=20
> Handle 0x0012, DMI type 17, 28 bytes
> Memory Device
>     Array Handle: 0x0010
>     Error Information Handle: Not Provided
>     Total Width: Unknown
>     Data Width: 64 bits
>     Size: No Module Installed
>     Form Factor: DIMM
>     Set: None
>     Locator: A1_DIMM0
>     Bank Locator: A1_BANK0
>     Type: Unknown
>     Type Detail: Synchronous
>     Speed: Unknown
>     Manufacturer: A1_Manufacturer0
>     Serial Number: A1_SerNum0
>     Asset Tag: A1_AssetTagNum0
>     Part Number: Array1_PartNumber0
>     Rank: Unknown
>=20
> Handle 0x0013, DMI type 126, 19 bytes
> Inactive
>=20
> Handle 0x0014, DMI type 17, 28 bytes
> Memory Device
>     Array Handle: 0x0010
>     Error Information Handle: Not Provided
>     Total Width: 64 bits
>     Data Width: 64 bits
>     Size: 4096 MB
>     Form Factor: DIMM
>     Set: None
>     Locator: A1_DIMM1
>     Bank Locator: A1_BANK1
>     Type: DDR3
>     Type Detail: Synchronous
>     Speed: 667 MHz
>     Manufacturer: Corsair
>     Serial Number: 00000000
>     Asset Tag: A1_AssetTagNum1
>     Part Number: CMZ8GX3M2A1600C9
>     Rank: 2
>=20
> Handle 0x0015, DMI type 20, 19 bytes
> Memory Device Mapped Address
>     Starting Address: 0x00000000000
>     Ending Address: 0x000FFFFFFFF
>     Range Size: 4 GB
>     Physical Device Handle: 0x0014
>     Memory Array Mapped Address Handle: 0x0011
>     Partition Row Position: 1
>=20
> Handle 0x0016, DMI type 17, 28 bytes
> Memory Device
>     Array Handle: 0x0010
>     Error Information Handle: Not Provided
>     Total Width: Unknown
>     Data Width: 64 bits
>     Size: No Module Installed
>     Form Factor: DIMM
>     Set: None
>     Locator: A1_DIMM2
>     Bank Locator: A1_BANK2
>     Type: Unknown
>     Type Detail: Synchronous
>     Speed: Unknown
>     Manufacturer: A1_Manufacturer2
>     Serial Number: A1_SerNum2
>     Asset Tag: A1_AssetTagNum2
>     Part Number: Array1_PartNumber2
>     Rank: Unknown
>=20
> Handle 0x0017, DMI type 126, 19 bytes
> Inactive
>=20
> Handle 0x0018, DMI type 17, 28 bytes
> Memory Device
>     Array Handle: 0x0010
>     Error Information Handle: Not Provided
>     Total Width: 64 bits
>     Data Width: 64 bits
>     Size: 4096 MB
>     Form Factor: DIMM
>     Set: None
>     Locator: A1_DIMM3
>     Bank Locator: A1_BANK3
>     Type: DDR3
>     Type Detail: Synchronous
>     Speed: 667 MHz
>     Manufacturer: Corsair
>     Serial Number: 00000000
>     Asset Tag: A1_AssetTagNum3
>     Part Number: CMZ8GX3M2A1600C9
>     Rank: 2
>=20
> Handle 0x0019, DMI type 20, 19 bytes
> Memory Device Mapped Address
>     Starting Address: 0x00100000000
>     Ending Address: 0x001FFFFFFFF
>     Range Size: 4 GB
>     Physical Device Handle: 0x0018
>     Memory Array Mapped Address Handle: 0x0011
>     Partition Row Position: 1
>=20
> Handle 0x001A, DMI type 32, 20 bytes
> System Boot Information
>     Status: No errors detected
>=20
> Handle 0x0000, DMI type 0, 24 bytes
> BIOS Information
>     Vendor: American Megatrends Inc.
>     Version: P2.00
>     Release Date: 08/30/2012
>     Address: 0xF0000
>     Runtime Size: 64 kB
>     ROM Size: 4096 kB
>     Characteristics:
>         PCI is supported
>         BIOS is upgradeable
>         BIOS shadowing is allowed
>         Boot from CD is supported
>         Selectable boot is supported
>         BIOS ROM is socketed
>         EDD is supported
>         5.25"/1.2 MB floppy services are supported (int 13h)
>         3.5"/720 kB floppy services are supported (int 13h)
>         3.5"/2.88 MB floppy services are supported (int 13h)
>         Print screen service is supported (int 5h)
>         8042 keyboard services are supported (int 9h)
>         Serial services are supported (int 14h)
>         Printer services are supported (int 17h)
>         ACPI is supported
>         USB legacy is supported
>         BIOS boot specification is supported
>         Targeted content distribution is supported
>     BIOS Revision: 4.6
>=20
> Handle 0x001B, DMI type 127, 4 bytes
> End Of Table
>=20
>=20
> Many thanks for you help.
> Don't hesitate to ask me more info if needed
>=20
> Jean-Pierre
>=20
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
