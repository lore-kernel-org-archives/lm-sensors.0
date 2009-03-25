From: Cristiano Barbaro <cristiano.barbaro@gmail.com>
Date: Wed, 25 Mar 2009 09:55:19 +0000
Subject: [lm-sensors] Issues with ACER Travelmate 2423wxm
Message-Id: <ea963e260903250255x37d75f24qac2fd0fb0b52a2f7@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6947246805233712352=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6947246805233712352==
Content-Type: multipart/alternative; boundary=000e0cd1ea6e4edf440465ee7f4c

--000e0cd1ea6e4edf440465ee7f4c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello everyone. I am unable to get lm-sensors to detect my laptop's sensors.
This is most annoying because in order to activate fan control to cool off
the processor I need to have lm-sensors to find the sensors themselves. As a
result, the laptop goes into some sort of slow mode after heating the
processor up to 96 degrees celsius(!), and  everything sloooows down to a
crawl including this  email that I'm typing. I have tried upgrading the bios
to the Phoenix 1.06 latest version, but the only benefit has been that the
temperature is correctly read by the system. The /proc/acpi/fan directory is
totally empty.
The system even overheats and slows down in Windows XP which I reinstalled
recently in order to upgrade the bios.

I am using Ubuntu 8.10 at the moment, with a small partition dedicated to
windoze for future bios upgrades.

Here is my lshw output:

# dmidecode 2.9
SMBIOS 2.31 present.
32 structures occupying 1056 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
    Vendor: Phoenix Technologies LTD
    Version: V1.06
    Release Date: 05/23/2006
    Address: 0xE5C90
    Runtime Size: 107376 bytes
    ROM Size: 512 kB
    Characteristics:
        ISA is supported
        PCI is supported
        PC Card (PCMCIA) is supported
        PNP is supported
        APM is supported
        BIOS is upgradeable
        BIOS shadowing is allowed
        ESCD support is available
        Boot from CD is supported
        ACPI is supported
        USB legacy is supported
        AGP is supported
        BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
    Manufacturer: Acer
    Product Name: TravelMate 2420
    Version: 0100
    Serial Number: LXTB2050976140176D2000
    UUID: 283CFC60-C3FD-11DA-B12D-87C5F6D9DBD1
    Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
    Manufacturer: Acer
    Product Name: Garda-910
    Version: Rev
    Serial Number: LXTB2050976140176D2000

Handle 0x0003, DMI type 3, 21 bytes
Chassis Information
    Manufacturer: Acer
    Type: Notebook
    Lock: Not Present
    Version: N/A
    Serial Number: None
    Asset Tag: None
    Boot-up State: Safe
    Power Supply State: Safe
    Thermal State: Safe
    Security Status: None
    OEM Information: 0x00000000
    Height: 52 U
    Number Of Power Cords: 18
    Contained Elements: 0

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
    Socket Designation: U1
    Type: Central Processor
    Family: Unknown
    Manufacturer: Intel
    ID: D8 06 00 00 FF FB E9 AF
    Version: A0
    Voltage: 3.3 V
    External Clock: 100 MHz
    Max Speed: 1600 MHz
    Current Speed: 1600 MHz
    Status: Populated, Enabled
    Upgrade: Socket 478
    L1 Cache Handle: 0x0008
    L2 Cache Handle: 0x0009
    L3 Cache Handle: Not Provided
    Serial Number: Not Specified
    Asset Tag: Not Specified
    Part Number: Not Specified

Handle 0x0005, DMI type 5, 20 bytes
Memory Controller Information
    Error Detecting Method: None
    Error Correcting Capabilities:
        None
    Supported Interleave: One-way Interleave
    Current Interleave: One-way Interleave
    Maximum Memory Module Size: 1024 MB
    Maximum Total Memory Size: 2048 MB
    Supported Speeds:
        70 ns
        60 ns
    Supported Memory Types:
        DIMM
        SDRAM
    Memory Module Voltage: 3.3 V
    Associated Memory Slots: 2
        0x0006
        0x0007
    Enabled Error Correcting Capabilities:
        Unknown

Handle 0x0006, DMI type 6, 12 bytes
Memory Module Information
    Socket Designation: M1
    Bank Connections: 0 1
    Current Speed: Unknown
    Type: DIMM SDRAM
    Installed Size: Not Installed
    Enabled Size: Not Installed
    Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes
Memory Module Information
    Socket Designation: M2
    Bank Connections: 2 3
    Current Speed: Unknown
    Type: DIMM SDRAM
    Installed Size: 512 MB (Double-bank Connection)
    Enabled Size: 512 MB (Double-bank Connection)
    Error Status: OK

Handle 0x0008, DMI type 7, 19 bytes
Cache Information
    Socket Designation: L1 Cache
    Configuration: Enabled, Not Socketed, Level 1
    Operational Mode: Write Back
    Location: Internal
    Installed Size: 32 KB
    Maximum Size: 32 KB
    Supported SRAM Types:
        Burst
        Pipeline Burst
        Asynchronous
    Installed SRAM Type: Asynchronous
    Speed: Unknown
    Error Correction Type: None
    System Type: Other
    Associativity: Other

Handle 0x0009, DMI type 7, 19 bytes
Cache Information
    Socket Designation: L2 Cache
    Configuration: Enabled, Not Socketed, Level 2
    Operational Mode: Write Back
    Location: Internal
    Installed Size: 1024 KB
    Maximum Size: 1024 KB
    Supported SRAM Types:
        Burst
        Pipeline Burst
        Asynchronous
    Installed SRAM Type: Burst
    Speed: Unknown
    Error Correction Type: Single-bit ECC
    System Type: Unified
    Associativity: Other

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: CN5
    Internal Connector Type: None
    External Reference Designator: USB
    External Connector Type: Access Bus (USB)
    Port Type: USB

Handle 0x000B, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: CN6
    Internal Connector Type: None
    External Reference Designator: USB
    External Connector Type: Access Bus (USB)
    Port Type: USB

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: CN7
    Internal Connector Type: None
    External Reference Designator: USB
    External Connector Type: Access Bus (USB)
    Port Type: USB

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: CN26
    Internal Connector Type: None
    External Reference Designator: MODEM
    External Connector Type: RJ-11
    Port Type: Modem Port

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: U49
    Internal Connector Type: None
    External Reference Designator: LAN
    External Connector Type: RJ-45
    Port Type: Network Port

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: CN24
    Internal Connector Type: None
    External Reference Designator: LINE-IN JACK
    External Connector Type: Mini Jack (headphones)
    Port Type: Audio Port

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: CN25
    Internal Connector Type: None
    External Reference Designator: HEADPHONE-OUT JACK
    External Connector Type: Mini Jack (headphones)
    Port Type: Audio Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
    Internal Reference Designator: CN2
    Internal Connector Type: None
    External Reference Designator: IEEE 1394
    External Connector Type: IEEE 1394
    Port Type: Firewire (IEEE P1394)

Handle 0x0012, DMI type 9, 13 bytes
System Slot Information
    Designation: PCMCIA Slot J07
    Type: 32-bit PC Card (PCMCIA)
    Current Usage: Unknown
    Length: Long
    ID: Adapter 0, Socket 0
    Characteristics:
        5.0 V is provided
        3.3 V is provided
        PC Card-16 is supported
        Cardbus is supported

Handle 0x0013, DMI type 10, 6 bytes
On Board Device Information
    Type: Sound
    Status: Disabled
    Description: ADI

Handle 0x0014, DMI type 11, 5 bytes
OEM Strings
    String 1: This is the Intel Alviso
    String 2: Chipset CRB Platform

Handle 0x0015, DMI type 12, 5 bytes
System Configuration Options
    Option 1: Jumper settings can be described here.

Handle 0x0016, DMI type 16, 15 bytes
Physical Memory Array
    Location: System Board Or Motherboard
    Use: System Memory
    Error Correction Type: None
    Maximum Capacity: 1 GB
    Error Information Handle: Not Provided
    Number Of Devices: 2

Handle 0x0017, DMI type 17, 27 bytes
Memory Device
    Array Handle: 0x0016
    Error Information Handle: No Error
    Total Width: Unknown
    Data Width: Unknown
    Size: No Module Installed
    Form Factor: DIMM
    Set: 2
    Locator: M1
    Bank Locator: Bank 0
    Type: DDR2
    Type Detail: Synchronous
    Speed: Unknown
    Manufacturer: Not Specified
    Serial Number: Not Specified
    Asset Tag: Not Specified
    Part Number: Not Specified

Handle 0x0018, DMI type 17, 27 bytes
Memory Device
    Array Handle: 0x0016
    Error Information Handle: No Error
    Total Width: 64 bits
    Data Width: 64 bits
    Size: 512 MB
    Form Factor: DIMM
    Set: 2
    Locator: M2
    Bank Locator: Bank 1
    Type: DDR2
    Type Detail: Synchronous
    Speed: Unknown
    Manufacturer: Not Specified
    Serial Number: Not Specified
    Asset Tag: Not Specified
    Part Number: Not Specified

Handle 0x0019, DMI type 19, 15 bytes
Memory Array Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x0001FFFFFFF
    Range Size: 512 MB
    Physical Array Handle: 0x0016
    Partition Width: 0

Handle 0x001A, DMI type 20, 19 bytes
Memory Device Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x000000003FF
    Range Size: 1 kB
    Physical Device Handle: 0x0017
    Memory Array Mapped Address Handle: 0x0019
    Partition Row Position: 1

Handle 0x001B, DMI type 20, 19 bytes
Memory Device Mapped Address
    Starting Address: 0x00000000000
    Ending Address: 0x0001FFFFFFF
    Range Size: 512 MB
    Physical Device Handle: 0x0018
    Memory Array Mapped Address Handle: 0x0019
    Partition Row Position: 1

Handle 0x001C, DMI type 32, 11 bytes
System Boot Information
    Status: No errors detected

Handle 0x001D, DMI type 136, 6 bytes
OEM-specific Type
    Header and Data:
        88 06 1D 00 5A 5A

Handle 0x001E, DMI type 200, 7 bytes
OEM-specific Type
    Header and Data:
        C8 07 1E 00 01 02 03
    Strings:
        17C0

        0001

Handle 0x001F, DMI type 127, 4 bytes
End Of Table

--000e0cd1ea6e4edf440465ee7f4c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello everyone. I am unable to get lm-sensors to detect my laptop&#39;s sen=
sors. This is most annoying because in order to activate fan control to coo=
l off the processor I need to have lm-sensors to find the sensors themselve=
s. As a result, the laptop goes into some sort of slow mode after heating t=
he processor up to 96 degrees celsius(!), and=A0 everything sloooows down t=
o a crawl including this=A0 email that I&#39;m typing. I have tried upgradi=
ng the bios to the Phoenix 1.06 latest version, but the only benefit has be=
en that the temperature is correctly read by the system. The /proc/acpi/fan=
 directory is totally empty.<br>
The system even overheats and slows down in Windows XP which I reinstalled =
recently in order to upgrade the bios.<br><br>I am using Ubuntu 8.10 at the=
 moment, with a small partition dedicated to windoze for future bios upgrad=
es.<br>
<br>Here is my lshw output:<br><br># dmidecode 2.9<br>SMBIOS 2.31 present.<=
br>32 structures occupying 1056 bytes.<br>Table at 0x000DC010.<br><br>Handl=
e 0x0000, DMI type 0, 20 bytes<br>BIOS Information<br>=A0=A0=A0 Vendor: Pho=
enix Technologies LTD<br>
=A0=A0=A0 Version: V1.06=A0=A0=A0=A0 <br>=A0=A0=A0 Release Date: 05/23/2006=
<br>=A0=A0=A0 Address: 0xE5C90<br>=A0=A0=A0 Runtime Size: 107376 bytes<br>=
=A0=A0=A0 ROM Size: 512 kB<br>=A0=A0=A0 Characteristics:<br>=A0=A0=A0 =A0=
=A0=A0 ISA is supported<br>=A0=A0=A0 =A0=A0=A0 PCI is supported<br>
=A0=A0=A0 =A0=A0=A0 PC Card (PCMCIA) is supported<br>=A0=A0=A0 =A0=A0=A0 PN=
P is supported<br>=A0=A0=A0 =A0=A0=A0 APM is supported<br>=A0=A0=A0 =A0=A0=
=A0 BIOS is upgradeable<br>=A0=A0=A0 =A0=A0=A0 BIOS shadowing is allowed<br=
>=A0=A0=A0 =A0=A0=A0 ESCD support is available<br>=A0=A0=A0 =A0=A0=A0 Boot =
from CD is supported<br>
=A0=A0=A0 =A0=A0=A0 ACPI is supported<br>=A0=A0=A0 =A0=A0=A0 USB legacy is =
supported<br>=A0=A0=A0 =A0=A0=A0 AGP is supported<br>=A0=A0=A0 =A0=A0=A0 BI=
OS boot specification is supported<br><br>Handle 0x0001, DMI type 1, 25 byt=
es<br>System Information<br>=A0=A0=A0 Manufacturer: Acer<br>
=A0=A0=A0 Product Name: TravelMate 2420<br>=A0=A0=A0 Version: 0100=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0 Serial Number: LXTB2050976140176D2000<b=
r>=A0=A0=A0 UUID: 283CFC60-C3FD-11DA-B12D-87C5F6D9DBD1<br>=A0=A0=A0 Wake-up=
 Type: Power Switch<br><br>Handle 0x0002, DMI type 2, 8 bytes<br>
Base Board Information<br>=A0=A0=A0 Manufacturer: Acer<br>=A0=A0=A0 Product=
 Name: Garda-910=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0 Version: Rev=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 <br>=A0=A0=A0 Serial Number: LXTB2050976140176D2000<br><br>Handle 0x=
0003, DMI type 3, 21 bytes<br>
Chassis Information<br>=A0=A0=A0 Manufacturer: Acer=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>=
=A0=A0=A0 Type: Notebook<br>=A0=A0=A0 Lock: Not Present<br>=A0=A0=A0 Versio=
n: N/A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0 Serial Number: None=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0 Asset Tag: None=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
=A0=A0=A0 Boot-up State: Safe<br>=A0=A0=A0 Power Supply State: Safe<br>=A0=
=A0=A0 Thermal State: Safe<br>=A0=A0=A0 Security Status: None<br>=A0=A0=A0 =
OEM Information: 0x00000000<br>=A0=A0=A0 Height: 52 U<br>=A0=A0=A0 Number O=
f Power Cords: 18<br>=A0=A0=A0 Contained Elements: 0<br>
<br>Handle 0x0004, DMI type 4, 35 bytes<br>Processor Information<br>=A0=A0=
=A0 Socket Designation: U1<br>=A0=A0=A0 Type: Central Processor<br>=A0=A0=
=A0 Family: Unknown<br>=A0=A0=A0 Manufacturer: Intel<br>=A0=A0=A0 ID: D8 06=
 00 00 FF FB E9 AF<br>=A0=A0=A0 Version: A0<br>
=A0=A0=A0 Voltage: 3.3 V<br>=A0=A0=A0 External Clock: 100 MHz<br>=A0=A0=A0 =
Max Speed: 1600 MHz<br>=A0=A0=A0 Current Speed: 1600 MHz<br>=A0=A0=A0 Statu=
s: Populated, Enabled<br>=A0=A0=A0 Upgrade: Socket 478<br>=A0=A0=A0 L1 Cach=
e Handle: 0x0008<br>=A0=A0=A0 L2 Cache Handle: 0x0009<br>
=A0=A0=A0 L3 Cache Handle: Not Provided<br>=A0=A0=A0 Serial Number: Not Spe=
cified<br>=A0=A0=A0 Asset Tag: Not Specified<br>=A0=A0=A0 Part Number: Not =
Specified<br><br>Handle 0x0005, DMI type 5, 20 bytes<br>Memory Controller I=
nformation<br>=A0=A0=A0 Error Detecting Method: None<br>
=A0=A0=A0 Error Correcting Capabilities:<br>=A0=A0=A0 =A0=A0=A0 None<br>=A0=
=A0=A0 Supported Interleave: One-way Interleave<br>=A0=A0=A0 Current Interl=
eave: One-way Interleave<br>=A0=A0=A0 Maximum Memory Module Size: 1024 MB<b=
r>=A0=A0=A0 Maximum Total Memory Size: 2048 MB<br>
=A0=A0=A0 Supported Speeds:<br>=A0=A0=A0 =A0=A0=A0 70 ns<br>=A0=A0=A0 =A0=
=A0=A0 60 ns<br>=A0=A0=A0 Supported Memory Types:<br>=A0=A0=A0 =A0=A0=A0 DI=
MM<br>=A0=A0=A0 =A0=A0=A0 SDRAM<br>=A0=A0=A0 Memory Module Voltage: 3.3 V<b=
r>=A0=A0=A0 Associated Memory Slots: 2<br>=A0=A0=A0 =A0=A0=A0 0x0006<br>=A0=
=A0=A0 =A0=A0=A0 0x0007<br>
=A0=A0=A0 Enabled Error Correcting Capabilities:<br>=A0=A0=A0 =A0=A0=A0 Unk=
nown<br><br>Handle 0x0006, DMI type 6, 12 bytes<br>Memory Module Informatio=
n<br>=A0=A0=A0 Socket Designation: M1<br>=A0=A0=A0 Bank Connections: 0 1<br=
>=A0=A0=A0 Current Speed: Unknown<br>
=A0=A0=A0 Type: DIMM SDRAM<br>=A0=A0=A0 Installed Size: Not Installed<br>=
=A0=A0=A0 Enabled Size: Not Installed<br>=A0=A0=A0 Error Status: OK<br><br>=
Handle 0x0007, DMI type 6, 12 bytes<br>Memory Module Information<br>=A0=A0=
=A0 Socket Designation: M2<br>
=A0=A0=A0 Bank Connections: 2 3<br>=A0=A0=A0 Current Speed: Unknown<br>=A0=
=A0=A0 Type: DIMM SDRAM<br>=A0=A0=A0 Installed Size: 512 MB (Double-bank Co=
nnection)<br>=A0=A0=A0 Enabled Size: 512 MB (Double-bank Connection)<br>=A0=
=A0=A0 Error Status: OK<br><br>Handle 0x0008, DMI type 7, 19 bytes<br>
Cache Information<br>=A0=A0=A0 Socket Designation: L1 Cache<br>=A0=A0=A0 Co=
nfiguration: Enabled, Not Socketed, Level 1<br>=A0=A0=A0 Operational Mode: =
Write Back<br>=A0=A0=A0 Location: Internal<br>=A0=A0=A0 Installed Size: 32 =
KB<br>=A0=A0=A0 Maximum Size: 32 KB<br>
=A0=A0=A0 Supported SRAM Types:<br>=A0=A0=A0 =A0=A0=A0 Burst<br>=A0=A0=A0 =
=A0=A0=A0 Pipeline Burst<br>=A0=A0=A0 =A0=A0=A0 Asynchronous<br>=A0=A0=A0 I=
nstalled SRAM Type: Asynchronous<br>=A0=A0=A0 Speed: Unknown<br>=A0=A0=A0 E=
rror Correction Type: None<br>=A0=A0=A0 System Type: Other<br>=A0=A0=A0 Ass=
ociativity: Other<br>
<br>Handle 0x0009, DMI type 7, 19 bytes<br>Cache Information<br>=A0=A0=A0 S=
ocket Designation: L2 Cache<br>=A0=A0=A0 Configuration: Enabled, Not Socket=
ed, Level 2<br>=A0=A0=A0 Operational Mode: Write Back<br>=A0=A0=A0 Location=
: Internal<br>=A0=A0=A0 Installed Size: 1024 KB<br>
=A0=A0=A0 Maximum Size: 1024 KB<br>=A0=A0=A0 Supported SRAM Types:<br>=A0=
=A0=A0 =A0=A0=A0 Burst<br>=A0=A0=A0 =A0=A0=A0 Pipeline Burst<br>=A0=A0=A0 =
=A0=A0=A0 Asynchronous<br>=A0=A0=A0 Installed SRAM Type: Burst<br>=A0=A0=A0=
 Speed: Unknown<br>=A0=A0=A0 Error Correction Type: Single-bit ECC<br>
=A0=A0=A0 System Type: Unified<br>=A0=A0=A0 Associativity: Other<br><br>Han=
dle 0x000A, DMI type 8, 9 bytes<br>Port Connector Information<br>=A0=A0=A0 =
Internal Reference Designator: CN5<br>=A0=A0=A0 Internal Connector Type: No=
ne<br>=A0=A0=A0 External Reference Designator: USB<br>
=A0=A0=A0 External Connector Type: Access Bus (USB)<br>=A0=A0=A0 Port Type:=
 USB<br><br>Handle 0x000B, DMI type 8, 9 bytes<br>Port Connector Informatio=
n<br>=A0=A0=A0 Internal Reference Designator: CN6<br>=A0=A0=A0 Internal Con=
nector Type: None<br>
=A0=A0=A0 External Reference Designator: USB<br>=A0=A0=A0 External Connecto=
r Type: Access Bus (USB)<br>=A0=A0=A0 Port Type: USB<br><br>Handle 0x000C, =
DMI type 8, 9 bytes<br>Port Connector Information<br>=A0=A0=A0 Internal Ref=
erence Designator: CN7<br>
=A0=A0=A0 Internal Connector Type: None<br>=A0=A0=A0 External Reference Des=
ignator: USB<br>=A0=A0=A0 External Connector Type: Access Bus (USB)<br>=A0=
=A0=A0 Port Type: USB<br><br>Handle 0x000D, DMI type 8, 9 bytes<br>Port Con=
nector Information<br>
=A0=A0=A0 Internal Reference Designator: CN26<br>=A0=A0=A0 Internal Connect=
or Type: None<br>=A0=A0=A0 External Reference Designator: MODEM<br>=A0=A0=
=A0 External Connector Type: RJ-11<br>=A0=A0=A0 Port Type: Modem Port<br><b=
r>Handle 0x000E, DMI type 8, 9 bytes<br>
Port Connector Information<br>=A0=A0=A0 Internal Reference Designator: U49<=
br>=A0=A0=A0 Internal Connector Type: None<br>=A0=A0=A0 External Reference =
Designator: LAN<br>=A0=A0=A0 External Connector Type: RJ-45<br>=A0=A0=A0 Po=
rt Type: Network Port<br><br>
Handle 0x000F, DMI type 8, 9 bytes<br>Port Connector Information<br>=A0=A0=
=A0 Internal Reference Designator: CN24<br>=A0=A0=A0 Internal Connector Typ=
e: None<br>=A0=A0=A0 External Reference Designator: LINE-IN JACK<br>=A0=A0=
=A0 External Connector Type: Mini Jack (headphones)<br>
=A0=A0=A0 Port Type: Audio Port<br><br>Handle 0x0010, DMI type 8, 9 bytes<b=
r>Port Connector Information<br>=A0=A0=A0 Internal Reference Designator: CN=
25<br>=A0=A0=A0 Internal Connector Type: None<br>=A0=A0=A0 External Referen=
ce Designator: HEADPHONE-OUT JACK<br>
=A0=A0=A0 External Connector Type: Mini Jack (headphones)<br>=A0=A0=A0 Port=
 Type: Audio Port<br><br>Handle 0x0011, DMI type 8, 9 bytes<br>Port Connect=
or Information<br>=A0=A0=A0 Internal Reference Designator: CN2<br>=A0=A0=A0=
 Internal Connector Type: None<br>
=A0=A0=A0 External Reference Designator: IEEE 1394<br>=A0=A0=A0 External Co=
nnector Type: IEEE 1394<br>=A0=A0=A0 Port Type: Firewire (IEEE P1394)<br><b=
r>Handle 0x0012, DMI type 9, 13 bytes<br>System Slot Information<br>=A0=A0=
=A0 Designation: PCMCIA Slot J07<br>
=A0=A0=A0 Type: 32-bit PC Card (PCMCIA)<br>=A0=A0=A0 Current Usage: Unknown=
<br>=A0=A0=A0 Length: Long<br>=A0=A0=A0 ID: Adapter 0, Socket 0<br>=A0=A0=
=A0 Characteristics:<br>=A0=A0=A0 =A0=A0=A0 5.0 V is provided<br>=A0=A0=A0 =
=A0=A0=A0 3.3 V is provided<br>=A0=A0=A0 =A0=A0=A0 PC Card-16 is supported<=
br>
=A0=A0=A0 =A0=A0=A0 Cardbus is supported<br><br>Handle 0x0013, DMI type 10,=
 6 bytes<br>On Board Device Information<br>=A0=A0=A0 Type: Sound<br>=A0=A0=
=A0 Status: Disabled<br>=A0=A0=A0 Description: ADI<br><br>Handle 0x0014, DM=
I type 11, 5 bytes<br>OEM Strings<br>
=A0=A0=A0 String 1: This is the Intel Alviso<br>=A0=A0=A0 String 2: Chipset=
 CRB Platform<br><br>Handle 0x0015, DMI type 12, 5 bytes<br>System Configur=
ation Options<br>=A0=A0=A0 Option 1: Jumper settings can be described here.=
<br><br>Handle 0x0016, DMI type 16, 15 bytes<br>
Physical Memory Array<br>=A0=A0=A0 Location: System Board Or Motherboard<br=
>=A0=A0=A0 Use: System Memory<br>=A0=A0=A0 Error Correction Type: None<br>=
=A0=A0=A0 Maximum Capacity: 1 GB<br>=A0=A0=A0 Error Information Handle: Not=
 Provided<br>=A0=A0=A0 Number Of Devices: 2<br>
<br>Handle 0x0017, DMI type 17, 27 bytes<br>Memory Device<br>=A0=A0=A0 Arra=
y Handle: 0x0016<br>=A0=A0=A0 Error Information Handle: No Error<br>=A0=A0=
=A0 Total Width: Unknown<br>=A0=A0=A0 Data Width: Unknown<br>=A0=A0=A0 Size=
: No Module Installed<br>=A0=A0=A0 Form Factor: DIMM<br>
=A0=A0=A0 Set: 2<br>=A0=A0=A0 Locator: M1<br>=A0=A0=A0 Bank Locator: Bank 0=
<br>=A0=A0=A0 Type: DDR2<br>=A0=A0=A0 Type Detail: Synchronous<br>=A0=A0=A0=
 Speed: Unknown<br>=A0=A0=A0 Manufacturer: Not Specified<br>=A0=A0=A0 Seria=
l Number: Not Specified<br>=A0=A0=A0 Asset Tag: Not Specified<br>
=A0=A0=A0 Part Number: Not Specified<br><br>Handle 0x0018, DMI type 17, 27 =
bytes<br>Memory Device<br>=A0=A0=A0 Array Handle: 0x0016<br>=A0=A0=A0 Error=
 Information Handle: No Error<br>=A0=A0=A0 Total Width: 64 bits<br>=A0=A0=
=A0 Data Width: 64 bits<br>=A0=A0=A0 Size: 512 MB<br>
=A0=A0=A0 Form Factor: DIMM<br>=A0=A0=A0 Set: 2<br>=A0=A0=A0 Locator: M2<br=
>=A0=A0=A0 Bank Locator: Bank 1<br>=A0=A0=A0 Type: DDR2<br>=A0=A0=A0 Type D=
etail: Synchronous<br>=A0=A0=A0 Speed: Unknown<br>=A0=A0=A0 Manufacturer: N=
ot Specified<br>=A0=A0=A0 Serial Number: Not Specified<br>
=A0=A0=A0 Asset Tag: Not Specified<br>=A0=A0=A0 Part Number: Not Specified<=
br><br>Handle 0x0019, DMI type 19, 15 bytes<br>Memory Array Mapped Address<=
br>=A0=A0=A0 Starting Address: 0x00000000000<br>=A0=A0=A0 Ending Address: 0=
x0001FFFFFFF<br>=A0=A0=A0 Range Size: 512 MB<br>
=A0=A0=A0 Physical Array Handle: 0x0016<br>=A0=A0=A0 Partition Width: 0<br>=
<br>Handle 0x001A, DMI type 20, 19 bytes<br>Memory Device Mapped Address<br=
>=A0=A0=A0 Starting Address: 0x00000000000<br>=A0=A0=A0 Ending Address: 0x0=
00000003FF<br>=A0=A0=A0 Range Size: 1 kB<br>
=A0=A0=A0 Physical Device Handle: 0x0017<br>=A0=A0=A0 Memory Array Mapped A=
ddress Handle: 0x0019<br>=A0=A0=A0 Partition Row Position: 1<br><br>Handle =
0x001B, DMI type 20, 19 bytes<br>Memory Device Mapped Address<br>=A0=A0=A0 =
Starting Address: 0x00000000000<br>
=A0=A0=A0 Ending Address: 0x0001FFFFFFF<br>=A0=A0=A0 Range Size: 512 MB<br>=
=A0=A0=A0 Physical Device Handle: 0x0018<br>=A0=A0=A0 Memory Array Mapped A=
ddress Handle: 0x0019<br>=A0=A0=A0 Partition Row Position: 1<br><br>Handle =
0x001C, DMI type 32, 11 bytes<br>
System Boot Information<br>=A0=A0=A0 Status: No errors detected<br><br>Hand=
le 0x001D, DMI type 136, 6 bytes<br>OEM-specific Type<br>=A0=A0=A0 Header a=
nd Data:<br>=A0=A0=A0 =A0=A0=A0 88 06 1D 00 5A 5A<br><br>Handle 0x001E, DMI=
 type 200, 7 bytes<br>
OEM-specific Type<br>=A0=A0=A0 Header and Data:<br>=A0=A0=A0 =A0=A0=A0 C8 0=
7 1E 00 01 02 03<br>=A0=A0=A0 Strings:<br>=A0=A0=A0 =A0=A0=A0 17C0<br>=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0 =A0=A0=
=A0 0001<br><br>Handle 0x001F, DMI type 127, 4 bytes<br>End Of Table<br><br=
>

--000e0cd1ea6e4edf440465ee7f4c--


--===============6947246805233712352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6947246805233712352==--
