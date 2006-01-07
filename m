From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Sat, 07 Jan 2006 12:54:30 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20060107125430.GA18574@dnil.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi All,

Back from vacationing, time to get this issue resolved :-)

On Thu, Dec 29, 2005 at 06:49:45PM +0100, Rudolf Marek wrote:
> > I suppose we could ask this but maybe I should just ask them to
> > reproduce the
> > problem on Linux themselves and tell me why it fails? In order to do so
> > though
> > I feel like we need to be pretty sure that the bug is not in Linux code
> > but in
> > code installed by their BIOS. Is there a way to prove that?
>=20
> SMI is completly transparent to OS. In fact you as OS dont notice,
> you cant catch it. It is simply out of OS control.

Sounds like I should put some pressure on Gigabyte to fix the route
cause, I don't think we will be able to do so but since this is a
server motherboard one would think the Gigabyte should be interested
in fixing the root cause... I'll try and let you all know how that goes.

> > Here's the dump:
> >=20
> > 0000:00:1f.0 ISA bridge: Intel Corp.: Unknown device 27b8 (rev 01)
> > 00: 86 80 b8 27 47 01 10 02 01 00 01 06 00 00 80 00
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 b0 27
> > 30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
> > 40: 01 10 00 00 80 00 00 00 81 11 00 00 10 00 00 00
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 60: 8a 8a 8a 8a d0 00 00 00 8a 80 80 85 00 00 00 00
> > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 80: 10 00 0f 3f 00 00 00 00 00 00 00 00 91 02 04 00
> > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > a0: 20 06 00 00 08 00 00 00 13 00 00 00 00 03 00 00
> > b0: 00 00 f0 00 00 00 00 00 00 40 01 18 00 00 00 00
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > d0: 33 22 11 00 67 45 00 00 cf ff 00 00 00 00 00 00
> > e0: 09 00 0c 10 00 00 20 00 00 00 00 00 00 00 00 00
> > f0: 01 c0 d1 fe 00 00 00 00 86 0f 01 00 00 00 00 00
> >=20
> > So the 32 bit value for register GPIO_ROUT @ offset B8h-BBh should be
> > 0x18014000
>=20
> 00 40 01 18 =3D>  18014000 GP7 is bit 15:14 -> 0100 0000 0000 0000 -> 01 =
-> SMI# ;)
>=20
> > if I understand correctly. That would indicate that GPIO7 is configured=
 for
> > SMI# which is what Gigabyte claims as well. Not sure I got the bytes
> > swapped
> > correctly though...=20
>=20
> Yes you did.
>=20
> Now, how do I write these register?
>=20
> setpci -s 00:1f.0 b8.l=18010000
>=20
> You can check it via lspci if it has been changed.

So setpci seems to work:

0000:00:1f.0 ISA bridge: Intel Corp.: Unknown device 27b8 (rev 01)
00: 86 80 b8 27 47 01 10 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 b0 27
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
40: 01 10 00 00 80 00 00 00 81 11 00 00 10 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 8a 8a 8a 8a d0 00 00 00 8a 80 80 85 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 10 00 0f 3f 00 00 00 00 00 00 00 00 91 02 04 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 20 06 00 00 08 00 00 00 13 00 00 00 00 03 00 00
b0: 00 00 f0 00 00 00 00 00 00 00 01 18 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 33 22 11 00 67 45 00 00 cf ff 00 00 00 00 00 00
e0: 09 00 0c 10 00 00 20 00 00 00 00 00 00 00 00 00
f0: 01 c0 d1 fe 00 00 00 00 86 0f 01 00 00 00 00 00

> When done, please test the stuff once again. If it is OK then please prov=
ide:
> lspci -v -v -v (of all devices) and also output of dmidecode utility.
> We will need this for the fix the symptom.

After shutting off that bit 14 for enabling SMI on GPIO7 that machine
does not hang any longer! I've tried a couple things that used to make
the machine hang and none of them did any harm any longer! To prove
that a different way I re-enabled that bit again using=20

setpci -s 00:1f.0 b8.l=18014000

which caused the machine to hang right away (ie, the setpci command
didn't return). Looks like we might have a workaround!

The output of dmidecode and lspci -v -v -v is attached since it is
rather long.=20

Best Regards
--=20
Daniel Nilsson
-------------- next part --------------
oden:~# dmidecode
# dmidecode 2.6
SMBIOS 2.3 present.
52 structures occupying 1994 bytes.
Table at 0x000F0440.
Handle 0x0000
        DMI type 0, 20 bytes.
        BIOS Information
                Vendor: Phoenix Technologies LTD
                Version: F2
                Release Date: 09/28/2005
                Address: 0xE5470
                Runtime Size: 109456 bytes
                ROM Size: 1024 kB
                Characteristics:
                        PCI is supported
                        PNP is supported
                        BIOS is upgradeable
                        BIOS shadowing is allowed
                        ESCD support is available
                        Boot from CD is supported
                        Selectable boot is supported
                        EDD is supported
                        Japanese floppy for NEC 9800 1.2 MB is supported (i=
nt 13h)
                        Japanese floppy for Toshiba 1.2 MB is supported (in=
t 13h)
                        3.5"/720 KB floppy services are supported (int 13h)
                        3.5"/2.88 MB floppy services are supported (int 13h)
                        8042 keyboard services are supported (int 9h)
                        Serial services are supported (int 14h)
                        Printer services are supported (int 17h)
                        ACPI is supported
                        USB legacy is supported
                        LS-120 boot is supported
                        BIOS boot specification is supported
                        Function key-initiated network boot is supported
Handle 0x0001
        DMI type 1, 25 bytes.
        System Information
                Manufacturer: GIGABYTE
                Product Name: R114
                Version: Revision A
                Serial Number: 012345678912
                UUID: 00148525-4510-0000-0000-000000000000
                Wake-up Type: Unknown
Handle 0x0002
        DMI type 2, 8 bytes.
        Base Board Information
                Manufacturer: GIGABYTE
                Product Name: R114
                Version: None
                Serial Number: 000000000000
Handle 0x0003
        DMI type 3, 17 bytes.
        Chassis Information
                Manufacturer: GIGABYTE
                Type: Other
                Lock: Not Present
                Version: None
                Serial Number:
                Asset Tag: No Asset Tag
                Boot-up State: Safe
                Power Supply State: Safe
                Thermal State: Safe
                Security Status: None
                OEM Information: 0x00000000
Handle 0x0004
        DMI type 4, 35 bytes.
        Processor Information
                Socket Designation: CPU#1
                Type: Central Processor
                Family: Pentium 4
                Manufacturer: Intel Corporation
                ID: 43 0F 00 00 FF FB EB BF
                Signature: Type 0, Family 15, Model 4, Stepping 3
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
                        PBE (Pending break enabled)
                Version: Intel(R) Pentium(R) 4 CPU 3.00GHz
                Voltage: 1.2 V
                External Clock: 200 MHz
                Max Speed: 3800 MHz
                Current Speed: 3000 MHz
                Status: Populated, Enabled
                Upgrade: Socket 478
                L1 Cache Handle: 0x0005
                L2 Cache Handle: 0x0006
                L3 Cache Handle: Not Provided
                Serial Number:
                Asset Tag:
                Part Number:
Handle 0x0005
        DMI type 7, 19 bytes.
        Cache Information
                Socket Designation: L1 Cache for CPU#1
                Configuration: Enabled, Not Socketed, Level 1
                Operational Mode: Write Back
                Location: Internal
                Installed Size: 16 KB
                Maximum Size: 16 KB
                Supported SRAM Types:
                        Burst
                        Synchronous
                Installed SRAM Type: Synchronous
                Speed: Unknown
                Error Correction Type: Parity
                System Type: Data
                Associativity: 4-way Set-associative
Handle 0x0006
        DMI type 7, 19 bytes.
        Cache Information
                Socket Designation: L2 Cache for CPU#1
                Configuration: Enabled, Not Socketed, Level 2
                Operational Mode: Write Back
                Location: Internal
                Installed Size: 2048 KB
                Maximum Size: 2048 KB
                Supported SRAM Types:
                        Burst
                        Synchronous
                Installed SRAM Type: Burst
                Speed: Unknown
                Error Correction Type: Single-bit ECC
                System Type: Unknown
                Associativity: 8-way Set-associative
Handle 0x0007
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Not Specified
                Internal Connector Type: None
                External Reference Designator: 1(Serial ICON)
                External Connector Type: DB-9 male
                Port Type: Serial Port 16550A Compatible
Handle 0x0008
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: COM2
                Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
                External Reference Designator: 2(Serial ICON)
                External Connector Type: DB-9 male
                Port Type: Serial Port 16550A Compatible
Handle 0x0009
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Not Specified
                Internal Connector Type: None
                External Reference Designator: (Parallel ICON)
                External Connector Type: DB-25 female
                Port Type: Parallel Port ECP/EPP
Handle 0x000A
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Not Specified
                Internal Connector Type: None
                External Reference Designator: (Keyboard ICON)
                External Connector Type: PS/2
                Port Type: Keyboard Port
Handle 0x000B
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Not Specified
                Internal Connector Type: None
                External Reference Designator: (Mouse ICON)
                External Connector Type: PS/2
                Port Type: Mouse Port
Handle 0x000C
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: FDC1
                Internal Connector Type: On Board Floppy
                External Reference Designator: (Floppy ICON)
                External Connector Type: None
                Port Type: Other
Handle 0x000D
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: IDE1
                Internal Connector Type: On Board IDE
                External Reference Designator: 1(IDE ICON)
                External Connector Type: None
                Port Type: Other
Handle 0x000E
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: SATA1
                Internal Connector Type: Other
                External Reference Designator: 1(S-ATA ICON)
                External Connector Type: None
                Port Type: Other
Handle 0x000F
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: SATA2
                Internal Connector Type: Other
                External Reference Designator: 2(S-ATA ICON)
                External Connector Type: None
                Port Type: Other
Handle 0x0010
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: SATA3
                Internal Connector Type: Other
                External Reference Designator: 3(S-ATA ICON)
                External Connector Type: None
                Port Type: Other
Handle 0x0011
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: SATA4
                Internal Connector Type: Other
                External Reference Designator: 4(S-ATA ICON)
                External Connector Type: None
                Port Type: Other
Handle 0x0012
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Not Specified
                Internal Connector Type: None
                External Reference Designator: 1(Network ICON)
                External Connector Type: RJ-45
                Port Type: Network Port
Handle 0x0013
        DMI type 126, 9 bytes.
        Inactive
Handle 0x0014
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Not Specified
                Internal Connector Type: None
                External Reference Designator: 1(USB ICON)
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x0015
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Not Specified
                Internal Connector Type: None
                External Reference Designator: 2(USB ICON)
                External Connector Type: Access Bus (USB)
                Port Type: USB
Handle 0x0016
        DMI type 126, 9 bytes.
        Inactive
Handle 0x0017
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: Not Specified
                Internal Connector Type: None
                External Reference Designator: (Video ICON)
                External Connector Type: DB-15 female
                Port Type: Video Port
Handle 0x0018
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCI-1
                Type: 64-bit PCI-X
                Current Usage: In Use
                Length: Long
                ID: 1
                Characteristics:
                        3.3 V is provided
                        PME signal is supported
                        SMBus signal is supported
Handle 0x0019
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCI-2
                Type: 64-bit PCI-X
                Current Usage: Available
                Length: Long
                ID: 2
                Characteristics:
                        3.3 V is provided
                        PME signal is supported
                        SMBus signal is supported
Handle 0x001A
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCI-3
                Type: Other
                Current Usage: Available
                Length: Short
                Characteristics: Unknown
Handle 0x001B
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCI-4
                Type: Other
                Current Usage: Unknown
                Length: Short
                Characteristics: Unknown
Handle 0x001C
        DMI type 9, 13 bytes.
        System Slot Information
                Designation: PCI-5
                Type: 32-bit PCI
                Current Usage: Available
                Length: Short
                ID: 5
                Characteristics:
                        5.0 V is provided
                        PME signal is supported
                        SMBus signal is supported
Handle 0x001D
        DMI type 10, 8 bytes.
        On Board Device 1 Information
                Type: Ethernet
                Status: Enabled
                Description: LAN1
        On Board Device 2 Information
                Type: Video
                Status: Enabled
                Description: VGA
Handle 0x001E
        DMI type 126, 6 bytes.
        Inactive
Handle 0x001F
        DMI type 11, 5 bytes.
        OEM Strings
                String 1:
                String 2:
Handle 0x0020
        DMI type 12, 5 bytes.
        System Configuration Options
                Option 1: RECOVERY: Close to run BIOS recovery
                Option 2: PASSWORD: Close to clear Password
                Option 3: TIME_HL: Close to stop FRB3 Timer
                Option 4: CLR_CMOS1: Close to clear CMOS
Handle 0x0021
        DMI type 13, 22 bytes.
        BIOS Language Information
                Installable Languages: 5
                        en|US|iso8859-1
                        fr|FR|iso8859-1
                        de|DE|iso8859-1
                        es|ES|iso8859-1
                        it|IT|iso8859-1
                Currently Installed Language: en|US|iso8859-1
Handle 0x0022
        DMI type 16, 15 bytes.
        Physical Memory Array
                Location: System Board Or Motherboard
                Use: System Memory
                Error Correction Type: Single-bit ECC
                Maximum Capacity: 4 GB
                Error Information Handle: No Error
                Number Of Devices: 4
Handle 0x0023
        DMI type 17, 27 bytes.
        Memory Device
                Array Handle: 0x0022
                Error Information Handle: No Error
                Total Width: Unknown
                Data Width: Unknown
                Size: No Module Installed
                Form Factor: DIMM
                Set: 1
                Locator: DIMM 1
                Bank Locator: BANK 1
                Type: Other
                Type Detail: Synchronous
                Speed: Unknown
                Manufacturer:
                Serial Number:
                Asset Tag:
                Part Number:
Handle 0x0024
        DMI type 17, 27 bytes.
        Memory Device
                Array Handle: 0x0022
                Error Information Handle: No Error
                Total Width: 72 bits
                Data Width: 64 bits
                Size: 512 MB
                Form Factor: DIMM
                Set: 2
                Locator: DIMM 2
                Bank Locator: BANK 2
                Type: Other
                Type Detail: Synchronous
                Speed: 533 MHz (1.9 ns)
                Manufacturer:
                Serial Number:
                Asset Tag:
                Part Number:
Handle 0x0025
        DMI type 17, 27 bytes.
        Memory Device
                Array Handle: 0x0022
                Error Information Handle: No Error
                Total Width: Unknown
                Data Width: Unknown
                Size: No Module Installed
                Form Factor: DIMM
                Set: 3
                Locator: DIMM 3
                Bank Locator: BANK 3
                Type: Other
                Type Detail: Synchronous
                Speed: Unknown
                Manufacturer:
                Serial Number:
                Asset Tag:
                Part Number:
Handle 0x0026
        DMI type 17, 27 bytes.
        Memory Device
                Array Handle: 0x0022
                Error Information Handle: No Error
                Total Width: 72 bits
                Data Width: 64 bits
                Size: 512 MB
                Form Factor: DIMM
                Set: 4
                Locator: DIMM 4
                Bank Locator: BANK 4
                Type: Other
                Type Detail: Synchronous
                Speed: 533 MHz (1.9 ns)
                Manufacturer:
                Serial Number:
                Asset Tag:
                Part Number:
Handle 0x0027
        DMI type 126, 23 bytes.
        Inactive
Handle 0x0028
        DMI type 18, 23 bytes.
        32-bit Memory Error Information
                Type: OK
                Granularity: Unknown
                Operation: Unknown
                Vendor Syndrome: Unknown
                Memory Array Address: Unknown
                Device Address: Unknown
                Resolution: Unknown
Handle 0x0029
        DMI type 126, 23 bytes.
        Inactive
Handle 0x002A
        DMI type 18, 23 bytes.
        32-bit Memory Error Information
                Type: OK
                Granularity: Unknown
                Operation: Unknown
                Vendor Syndrome: Unknown
                Memory Array Address: Unknown
                Device Address: Unknown
                Resolution: Unknown
Handle 0x002B
        DMI type 19, 15 bytes.
        Memory Array Mapped Address
                Starting Address: 0x00000000000
                Ending Address: 0x0003FFFFFFF
                Range Size: 1 GB
                Physical Array Handle: 0x0022
                Partition Width: 0
Handle 0x002C
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
                Starting Address: 0x00000000000
                Ending Address: 0x000000003FF
                Range Size: 1 kB
                Physical Device Handle: 0x0023
                Memory Array Mapped Address Handle: 0x002B
                Partition Row Position: Unknown
                Interleave Position: Unknown
                Interleaved Data Depth: Unknown
Handle 0x002D
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
                Starting Address: 0x00000000000
                Ending Address: 0x0001FFFFFFF
                Range Size: 512 MB
                Physical Device Handle: 0x0024
                Memory Array Mapped Address Handle: 0x002B
                Partition Row Position: Unknown
                Interleave Position: Unknown
                Interleaved Data Depth: Unknown
Handle 0x002E
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
                Starting Address: 0x0001FFFFC00
                Ending Address: 0x0001FFFFFFF
                Range Size: 1 kB
                Physical Device Handle: 0x0025
                Memory Array Mapped Address Handle: 0x002B
                Partition Row Position: Unknown
                Interleave Position: Unknown
                Interleaved Data Depth: Unknown
Handle 0x002F
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
                Starting Address: 0x00020000000
                Ending Address: 0x0003FFFFFFF
                Range Size: 512 MB
                Physical Device Handle: 0x0026
                Memory Array Mapped Address Handle: 0x002B
                Partition Row Position: Unknown
                Interleave Position: Unknown
                Interleaved Data Depth: Unknown
Handle 0x0030
        DMI type 24, 5 bytes.
        Hardware Security
                Power-On Password Status: Disabled
                Keyboard Password Status: Unknown
                Administrator Password Status: Disabled
                Front Panel Reset Status: Unknown
Handle 0x0031
        DMI type 32, 11 bytes.
        System Boot Information
                Status: No errors detected
Handle 0x0032
        DMI type 34, 11 bytes.
        Management Device
                Description: Winbond W83792D
                Type: Other
                Address: 0x0000005C
                Address Type: SMBus
Handle 0x0033
        DMI type 127, 4 bytes.
        End Of Table
-------------- next part --------------
oden:~# lspci -v -v -v
0000:00:00.0 Host bridge: Intel Corp.: Unknown device 2778 (rev 81)
        Subsystem: Giga-byte Technology: Unknown device 2778
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] #09 [4109]

0000:00:01.0 PCI bridge: Intel Corp.: Unknown device 2779 (rev 81) (prog-if=
 00 [Normal decode])
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=3D0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=3D0/0=
 Enable-
                Address: 00000000  Data: 0000
        Capabilities: [a0] #10 [0141]

0000:00:1c.0 PCI bridge: Intel Corp.: Unknown device 27d0 (rev 01) (prog-if=
 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=3D0
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: d8000000-d89fffff
        Prefetchable memory behind bridge: 0000000050000000-0000000050000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=3D0/0=
 Enable+
                Address: fee02004  Data: 40c1
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:1c.4 PCI bridge: Intel Corp.: Unknown device 27e0 (rev 01) (prog-if=
 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=3D0
        I/O behind bridge: 00005000-00005fff
        Memory behind bridge: d8a00000-d8afffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=3D0/0=
 Enable+
                Address: fee02004  Data: 40c9
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:1c.5 PCI bridge: Intel Corp.: Unknown device 27e2 (rev 01) (prog-if=
 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=3D0
        I/O behind bridge: 00006000-00006fff
        Memory behind bridge: d8b00000-d8bfffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=3D0/0=
 Enable+
                Address: fee02004  Data: 40d1
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:1d.0 USB Controller: Intel Corp.: Unknown device 27c8 (rev 01) (pro=
g-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 27c8
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 233
        Region 4: I/O ports at 3000 [size2]

0000:00:1d.1 USB Controller: Intel Corp.: Unknown device 27c9 (rev 01) (pro=
g-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 27c9
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 217
        Region 4: I/O ports at 3020 [size2]

0000:00:1d.2 USB Controller: Intel Corp.: Unknown device 27ca (rev 01) (pro=
g-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 27ca
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 50
        Region 4: I/O ports at 3040 [size2]

0000:00:1d.3 USB Controller: Intel Corp.: Unknown device 27cb (rev 01) (pro=
g-if 00 [UHCI])
        Subsystem: Giga-byte Technology: Unknown device 27cb
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 169
        Region 4: I/O ports at 3060 [size2]

0000:00:1d.7 USB Controller: Intel Corp.: Unknown device 27cc (rev 01) (pro=
g-if 20 [EHCI])
        Subsystem: Giga-byte Technology: Unknown device 27cc
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 233
        Region 0: Memory at d8f00000 (32-bit, non-prefetchable) [size=3D1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent75mA PME(D0+,D1-,D2-,=
D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev e1) (prog-if 01 =
[Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary
, subordinate
, sec-latency2
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: d8c00000-d8cfffff
        Prefetchable memory behind bridge: 00000000d0000000-00000000d7f00000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corp.: Unknown device 27b8 (rev 01)
        Subsystem: Giga-byte Technology: Unknown device 27b0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [e0] #09 [100c]

0000:00:1f.2 IDE interface: Intel Corp.: Unknown device 27c0 (rev 01) (prog=
-if 80 [Master])
        Subsystem: Giga-byte Technology: Unknown device 27c0
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 217
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 30b0 [size=16]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:00:1f.3 SMBus: Intel Corp.: Unknown device 27da (rev 01)
        Subsystem: Giga-byte Technology: Unknown device 27da
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 3080 [size2]

0000:02:00.0 PCI bridge: Intel Corp. PCI Bridge Hub (rev 09) (prog-if 00 [N=
ormal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=02, secondary=03, subordinate=03, sec-latencyH
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: d8000000-d88fffff
        Prefetchable memory behind bridge: 0000000050000000-0000000050000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=3D0/0=
 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [d8]
0000:02:00.1 PIC: Intel Corp. PCI Bridge Hub I/OxAPIC Interrupt Controller =
A (rev 09) (prog-if 20 [IO(X)-APIC])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d8900000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [44] #10 [0001]
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:03:01.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev=
 01)
        Subsystem: 3ware Inc 3ware Inc 3ware 7xxx/8xxx-series PATA/SATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr+=
 Stepping- SERR+ FastB2B+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (2250ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 225
        Region 0: I/O ports at 4000 [size=16]
        Region 1: Memory at d8800000 (32-bit, non-prefetchable) [size=16]
        Region 2: Memory at d8000000 (32-bit, non-prefetchable) [size=3D8M]
        Expansion ROM at 50000000 [disabled] [sizedK]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:04:00.0 Ethernet controller: Intel Corp.: Unknown device 108b (rev 03)
        Subsystem: Giga-byte Technology: Unknown device 108b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 58
        Region 0: Memory at d8a00000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at 5000 [size2]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=3D0/0=
 Enable+
                Address: 00000000fee01004  Data: 403a
        Capabilities: [e0] #10 [0001]

0000:05:00.0 Ethernet controller: Intel Corp.: Unknown device 108b (rev 03)
        Subsystem: Giga-byte Technology: Unknown device 108b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 66
        Region 0: Memory at d8b00000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at 6000 [size2]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2=
-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=3D0/0=
 Enable+
                Address: 00000000fee02004  Data: 4042
        Capabilities: [e0] #10 [0001]

0000:0a:03.0 VGA compatible controller: ATI Technologies Inc: Unknown devic=
e 515e (rev 01) (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology: Unknown device 515e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping+ SERR+ FastB2B+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 74
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 7000 [size%6]
        Region 2: Memory at d8c00000 (32-bit, non-prefetchable) [sizedK]
        Expansion ROM at d8c20000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

