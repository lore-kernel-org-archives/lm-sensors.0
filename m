From: nightseal pacafic <pacafic.seal@gmail.com>
Date: Sat, 12 Jan 2013 10:14:17 +0000
Subject: [lm-sensors] pwmcfg: no sensors installed
Message-Id: <CA+g4aOszKZh=vbbcfiRYGZv9tuasOa5jYPubGp1b0CZYDYvHcw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6818774493016440054=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6818774493016440054==
Content-Type: multipart/alternative; boundary=047d7bfd046ebeb58104d314aca4

--047d7bfd046ebeb58104d314aca4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi guys,

my cufan makes a big noise, while temp onstantly goes up into 60's and upto
80 C, even if i am doing mnial work.
i have an i7 and here is my mother bord configuration below,
ihave installed lm-sensors but when i run pwmconfig,i get 'no sensors
detected'.


here is motherboard info:

sudo hwinfo --bios

*01: None 00.0: 10105 BIOS
  [Created at bios.186]
  Unique ID: rdCR.lZF+r4EgHp4
  Hardware Class: bios
  BIOS Keyboard LED Status:
    Scroll Lock: off
    Num Lock: off
    Caps Lock: off
  Base Memory: 634 kB
  PnP BIOS: @@@0000
  BIOS: extended read supported
  MP spec rev 1.4 info:
    OEM id: "PEGANB"
    Product id: "PEGA"
    2 CPUs (0 disabled)
  SMBIOS Version: 2.6
  BIOS Info: #0
    Vendor: "American Megatrends Inc."
    Version: "300"
    Date: "12/22/2011"
    Start Address: 0xf0000
    ROM Size: 2048 kB
    Features: 0x0503000000053f899880
      PCI supported
      BIOS flashable
      BIOS shadowing allowed
      CD boot supported
      Selectable boot supported
      EDD spec supported
      1.2MB Floppy supported
      720kB Floppy supported
      2.88MB Floppy supported
      Print Screen supported
      8042 Keyboard Services supported
      Serial Services supported
      Printer Services supported
      ACPI supported
      USB Legacy supported
      BIOS Boot Spec supported
  Processor Info: #4
    Socket: "CPU 1"
    Socket Type: 0x01 (Other)
    Socket Status: Populated
    Type: 0x03 (CPU)
    Family: 0xc2 (Other)
    Manufacturer: "Intel"
    Version: "Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz"
    Serial: "To Be Filled By O.E.M."
    Asset Tag: "To Be Filled By O.E.M."
    Part Number: "To Be Filled By O.E.M."
    Processor ID: 0xbfebfbff000206a7
    Status: 0x01 (Enabled)
    External Clock: 100 MHz
    Max. Speed: 4000 MHz
    Current Speed: 2400 MHz
    L1 Cache: #5
    L2 Cache: #6
  Cache Info: #5
    Designation: "L1-Cache"
    Level: L1
    State: Enabled
    Mode: 0x01 (Write Back)
    Location: 0x00 (Internal, Not Socketed)
    ECC: 0x03 (None)
    Type: 0xff (Other)
    Supported SRAM Types: 0x0001 (Other)
    Current SRAM Type: 0x0001 (Other)
  Cache Info: #6
    Designation: "L2-Cache"
    Level: L2
    State: Enabled
    Mode: 0x02 (Varies with Memory Address)
    Location: 0x00 (Internal, Not Socketed)
    ECC: 0x03 (None)
    Type: 0xff (Other)
    Supported SRAM Types: 0x0001 (Other)
    Current SRAM Type: 0x0001 (Other)
  Inactive Record: #7
    Data 00: 7e 13 07 00 01 02 03 00 00 00 00 02 00 02 00 00
    Data 10: 02 02 02
    String 1: "L3-Cache"
  Port Connector: #8
    Type: 0x0e (Mouse Port)
    Internal Designator: "J1A1"
    External Designator: "PS2Mouse"
    External Connector: 0x0f (PS/2)
  Port Connector: #9
    Type: 0x0d (Keyboard Port)
    Internal Designator: "J1A1"
    External Designator: "Keyboard"
    External Connector: 0x0f (PS/2)
  Port Connector: #10
    Type: 0x09 (Serial Port 16550A Compatible)
    Internal Designator: "J1A2A"
    External Designator: "Serial Port"
    External Connector: 0x08 (DB-9 pin male)
  Port Connector: #11
    Type: 0x1c (Video Port)
    Internal Designator: "J1A2B"
    External Designator: "Video"
    External Connector: 0x07 (DB-15 pin female)
  Port Connector: #12
    Type: 0x1c (Video Port)
    Internal Designator: "J3A2"
    External Designator: "HDMI"
    External Connector: 0xff (Other)
  Port Connector: #13
    Type: 0x10 (USB)
    Internal Designator: "J3A3"
    External Designator: "USB1"
    External Connector: 0x12 (Access Bus [USB])
  Port Connector: #14
    Type: 0x10 (USB)
    Internal Designator: "J3A3"
    External Designator: "USB2"
    External Connector: 0x12 (Access Bus [USB])
  Port Connector: #15
    Type: 0x10 (USB)
    Internal Designator: "J3A3"
    External Designator: "USB3"
    External Connector: 0x12 (Access Bus [USB])
  Port Connector: #16
    Type: 0x10 (USB)
    Internal Designator: "J3A3"
    External Designator: "USB4"
    External Connector: 0x12 (Access Bus [USB])
  Port Connector: #17
    Type: 0x10 (USB)
    Internal Designator: "J4A1"
    External Designator: "USB5"
    External Connector: 0x12 (Access Bus [USB])
  Port Connector: #18
    Type: 0x10 (USB)
    Internal Designator: "J4A1"
    External Designator: "USB6"
    External Connector: 0x12 (Access Bus [USB])
  Port Connector: #19
    Type: 0x1f (Network Port)
    Internal Designator: "J4A1"
    External Designator: "LAN"
    External Connector: 0x0b (RJ-45)
  Port Connector: #20
    Type: 0xff (Other)
    Internal Designator: "J5A1"
    External Designator: "Motherboard DP"
    External Connector: 0xff (Other)
  Port Connector: #21
    Type: 0x20 (Other)
    Internal Designator: "J8J1"
    External Designator: "SATA Port 0 Direct Connect"
    External Connector: 0x22 (Other)
  Port Connector: #22
    Type: 0x20 (Other)
    Internal Designator: "J7J1"
    External Designator: "eSATA Port 4"
    External Connector: 0x22 (Other)
  Port Connector: #23
    Type: 0x20 (Other)
    Internal Designator: "J6J1"
    External Designator: "eSATA Port 3"
    External Connector: 0x22 (Other)
  Port Connector: #24
    Type: 0xff (Other)
    Internal Designator: "J1F2"
    External Designator: "AC IN"
    External Connector: 0xff (Other)
  Port Connector: #25
    Type: 0xff (Other)
    Internal Designator: "J5B1 - PCH JTAG"
    Internal Connector: 0xff (Other)
  Port Connector: #26
    Type: 0xff (Other)
    Internal Designator: "J9A1 - TPM/PORT 80"
    Internal Connector: 0xff (Other)
  Port Connector: #27
    Type: 0xff (Other)
    Internal Designator: "J9E4 - HDA 2X8 Header"
    Internal Connector: 0xff (Other)
  Port Connector: #28
    Type: 0xff (Other)
    Internal Designator: "J9E7 - HDA 8Pin Header"
    Internal Connector: 0xff (Other)
  Port Connector: #29
    Type: 0xff (Other)
    Internal Designator: "J8F1 - HDA HDMI"
    Internal Connector: 0xff (Other)
  Port Connector: #30
    Type: 0xff (Other)
    Internal Designator: "J9E3 - Scan Matrix Keyboard"
    Internal Connector: 0xff (Other)
  Port Connector: #31
    Type: 0xff (Other)
    Internal Designator: "J8E1 - SPI Program"
    Internal Connector: 0xff (Other)
  Port Connector: #32
    Type: 0xff (Other)
    Internal Designator: "J9E5 - LPC Hot Docking"
    Internal Connector: 0xff (Other)
  Port Connector: #33
    Type: 0xff (Other)
    Internal Designator: "J9G2 - LPC SIDE BAND"
    Internal Connector: 0xff (Other)
  Port Connector: #34
    Type: 0xff (Other)
    Internal Designator: "J8F2 - LPC Slot"
    Internal Connector: 0xff (Other)
  Port Connector: #35
    Type: 0xff (Other)
    Internal Designator: "J8H3 - PCH XDP"
    Internal Connector: 0xff (Other)
  Port Connector: #36
    Type: 0x20 (Other)
    Internal Designator: "J7G1 - SATA Port 2"
    Internal Connector: 0x22 (Other)
  Port Connector: #37
    Type: 0x20 (Other)
    Internal Designator: "J7G2 - SATA Port 1"
    Internal Connector: 0x22 (Other)
  Port Connector: #38
    Type: 0xff (Other)
    Internal Designator: "J6H1 - SATA Power"
    Internal Connector: 0xff (Other)
  Port Connector: #39
    Type: 0xff (Other)
    Internal Designator: "J5J1 - FP Header"
    Internal Connector: 0xff (Other)
  Port Connector: #40
    Type: 0xff (Other)
    Internal Designator: "J4H1 - ATX Power"
    Internal Connector: 0xff (Other)
  Port Connector: #41
    Type: 0xff (Other)
    Internal Designator: "J1J3 - AVMC"
    Internal Connector: 0xff (Other)
  Port Connector: #42
    Type: 0xff (Other)
    Internal Designator: "J1H1 - BATT B"
    Internal Connector: 0xff (Other)
  Port Connector: #43
    Type: 0xff (Other)
    Internal Designator: "J1H2 - BATT A"
    Internal Connector: 0xff (Other)
  Port Connector: #44
    Type: 0xff (Other)
    Internal Designator: "J2G1 - CPU Fan"
    Internal Connector: 0xff (Other)
  Port Connector: #45
    Type: 0xff (Other)
    Internal Designator: "J1D3 - XDP"
    Internal Connector: 0xff (Other)
  Port Connector: #46
    Type: 0xff (Other)
    Internal Designator: "J4V1 - Memory Slot 1"
    Internal Connector: 0xff (Other)
  Port Connector: #47
    Type: 0xff (Other)
    Internal Designator: "J4V2 - Memory Slot 2"
    Internal Connector: 0xff (Other)
  Port Connector: #48
    Type: 0xff (Other)
    Internal Designator: "J4C1 - FAN PWR"
    Internal Connector: 0xff (Other)
  System Slot: #49
    Designation: "J5C1"
    Type: 0xaa (Other)
    Bus Width: 0x0d (Other)
    Status: 0x03 (Available)
    Length: 0x04 (Long)
    Slot ID: 0
    Characteristics: 0x010c (3.3 V, Shared, PME#)
  System Slot: #50
    Designation: "J6C2"
    Type: 0xa5 (Other)
    Bus Width: 0x08 (Other)
    Status: 0x03 (Available)
    Length: 0x03 (Short)
    Slot ID: 1
    Characteristics: 0x010c (3.3 V, Shared, PME#)
  System Slot: #51
    Designation: "J6D2"
    Type: 0xa5 (Other)
    Bus Width: 0x08 (Other)
    Status: 0x04 (In Use)
    Length: 0x03 (Short)
    Slot ID: 2
    Characteristics: 0x010c (3.3 V, Shared, PME#)
  System Slot: #52
    Designation: "J7C1"
    Type: 0xa5 (Other)
    Bus Width: 0x08 (Other)
    Status: 0x03 (Available)
    Length: 0x03 (Short)
    Slot ID: 3
    Characteristics: 0x010c (3.3 V, Shared, PME#)
  System Slot: #53
    Designation: "J7D2"
    Type: 0xa5 (Other)
    Bus Width: 0x08 (Other)
    Status: 0x04 (In Use)
    Length: 0x03 (Short)
    Slot ID: 4
    Characteristics: 0x010c (3.3 V, Shared, PME#)
  System Slot: #54
    Designation: "J6C1"
    Type: 0xa5 (Other)
    Bus Width: 0x08 (Other)
    Status: 0x03 (Available)
    Length: 0x03 (Short)
    Slot ID: 5
    Characteristics: 0x010c (3.3 V, Shared, PME#)
  System Slot: #55
    Designation: "J8C2"
    Type: 0xaa (Other)
    Bus Width: 0x05 (32 bit)
    Status: 0x04 (In Use)
    Length: 0x04 (Long)
    Slot ID: 6
    Characteristics: 0x010c (3.3 V, Shared, PME#)
  On Board Devices: #60
    Video: "To Be Filled By O.E.M."
  On Board Devices: #61
    Ethernet: "To Be Filled By O.E.M." (disabled)
  On Board Devices: #62
    Sound: "To Be Filled By O.E.M."
  OEM Strings: #63
  System Config Options (Jumpers & Switches) #64:
    DSN:
  32bit-Memory Error Info: #66
    Type: 0x03 (OK)
    Granularity: 0x02 (Unknown)
    Operation: 0x02 (Unknown)
  32bit-Memory Error Info: #69
    Type: 0x03 (OK)
    Granularity: 0x02 (Unknown)
    Operation: 0x02 (Unknown)
  32bit-Memory Error Info: #72
    Type: 0x03 (OK)
    Granularity: 0x02 (Unknown)
    Operation: 0x02 (Unknown)
  Pointing Device: #74
    Type: 0x07 (Touch Pad)
    Interface: 0x04 (PS/2)
    Buttons: 2
  Type 32 Record: #75
    Data 00: 20 14 4b 00 00 00 00 00 00 00 00 00 00 00 00 00
    Data 10: 00 00 00 00
  System Info: #1
    Manufacturer: "NOVATECH LTD"
    Product: "A15A/HE/HC"
    Version: "1.0"
    Serial: "11APE2083146"
    UUID: undefined, but settable
    Wake-up: 0x06 (Power Switch)
  Board Info: #2
    Manufacturer: "Novatech Ltd"
    Product: "A15"
    Version: "1.0"
    Serial: "BSN12345678901234567"
    Asset Tag: "ATN12345678901234567"
    Type: 0x0a (Motherboard)
    Features: 0x09
      Hosting Board
      Replaceable
    Location: "MIDDLE"
    Chassis: #3
  Chassis Info: #3
    Manufacturer: "Novatech Ltd"
    Version: "1.0"
    Serial: "CSN12345678901234567"
    Asset Tag: "No Asset Tag"
    Type: 0x09 (LapTop)
    Bootup State: 0x03 (Safe)
    Power Supply State: 0x03 (Safe)
    Thermal State: 0x03 (Safe)
    Security Status: 0x03 (None)
  Physical Memory Array: #65
    Use: 0x03 (System memory)
    Location: 0x03 (Motherboard)
    Slots: 2
    Max. Size: 8 GB
    ECC: 0x03 (None)
    Error Info: #66
  Memory Device: #67
    Location: "DIMM0"
    Bank: "BANK 0"
    Manufacturer: "80CE"
    Serial: "65628DA3"
    Asset Tag: "Unknown"
    Part Number: "M471B5273CH0-CH9"
    Memory Array: #65
    Error Info: #69
    Form Factor: 0x0d (SODIMM)
    Type: 0x18 (Other)
    Type Detail: 0x0080 (Synchronous)
    Data Width: 64 bits
    Size: 4 GB
    Speed: 1333 MHz
  Memory Device Mapping: #68
    Memory Device: #67
    Array Mapping: #73
    Interleave Pos: 1
    Interleaved Depth: 1
    Start Address: 0x0000000000000000
    End Address: 0x0000000100000000
  Memory Device: #70
    Location: "DIMM2"
    Bank: "BANK 2"
    Manufacturer: "80CE"
    Serial: "62477F22"
    Asset Tag: "Unknown"
    Part Number: "M471B5273DH0-CH9"
    Memory Array: #65
    Error Info: No Error
    Form Factor: 0x0d (SODIMM)
    Type: 0x18 (Other)
    Type Detail: 0x0080 (Synchronous)
    Data Width: 64 bits
    Size: 4 GB
    Speed: 1333 MHz
  Memory Device Mapping: #71
    Memory Device: #70
    Array Mapping: #73
    Interleave Pos: 2
    Interleaved Depth: 1
    Start Address: 0x0000000000000000
    End Address: 0x0000000100000000
  Memory Array Mapping: #73
    Memory Array: #65
    Partition Width: 2
    Start Address: 0x0000000000000000
    End Address: 0x0000000100000000
  Language Info: #76
    Languages: eng
    Current: eng
  Config Status: cfg=3Dnew, avail=3Dyes, need=3Dno, active=3Dunknown*

when i use sensors ,i get,

*acpitz-virtual-0
Adapter: Virtual device
temp1:        +56.0=B0C  (crit =3D +99.0=B0C)*

when i use sensors-detect and and say yes to every step,i get,

*# sensors-detect revision 6085 (2012-10-30 18:18:45 +0100)
# System: NOVATECH LTD A15A/HE/HC [1.0] (laptop)
# Board: Novatech Ltd A15

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): y
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 15h power sensors...                             No
Intel digital thermal sensor...                             Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): y
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               Yes
Found unknown chip with ID 0x0202
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): y
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): y
Using driver `i2c-i801' for device 0000:00:1f.3: Intel Cougar Point (PCH)
Module i2c-dev loaded successfully.

Next adapter: SMBus I801 adapter at e040 (i2c-0)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter: i915 gmbus ssc (i2c-1)
Do you want to scan it? (yes/NO/selectively): y

Next adapter: i915 gmbus vga (i2c-2)
Do you want to scan it? (yes/NO/selectively): y

Next adapter: i915 gmbus panel (i2c-3)
Do you want to scan it? (yes/NO/selectively): y

Next adapter: i915 gmbus dpc (i2c-4)
Do you want to scan it? (yes/NO/selectively): y

Next adapter: i915 gmbus dpb (i2c-5)
Do you want to scan it? (yes/NO/selectively): y

Next adapter: i915 gmbus dpd (i2c-6)
Do you want to scan it? (yes/NO/selectively): y

Next adapter: DPDDC-D (i2c-7)
Do you want to scan it? (YES/no/selectively): y

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel digital thermal sensor' (confidence: 9)

Do you want to overwrite /etc/conf.d/lm_sensors? (YES/no): y
Unloading i2c-dev... OK
Unloading cpuid... OK*




i am getting high cpu temperatures and i feel fan speed is toohigh and
uncontrolled.
facontrolis installed but i cannot use it.
i am unable to controlcu emp and fan speed
pleae give us a steby step apprach to correct the problem.





sinc,

--047d7bfd046ebeb58104d314aca4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi guys,<br><br>my cufan makes a big noise, while temp onstantly goes up in=
to 60&#39;s and upto 80 C, even if i am doing mnial work.<br>i have an i7 a=
nd here is my mother bord configuration below,<br>ihave installed lm-sensor=
s but when i run pwmconfig,i get &#39;no sensors detected&#39;.<br>
<br><br>here is motherboard info:<br><br>sudo hwinfo --bios<br><br><i>01: N=
one 00.0: 10105 BIOS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>=A0 [Creat=
ed at bios.186]<br>=A0 Unique ID: rdCR.lZF+r4EgHp4<br>=A0 Hardware Class: b=
ios<br>
=A0 BIOS Keyboard LED Status:<br>=A0=A0=A0 Scroll Lock: off<br>=A0=A0=A0 Nu=
m Lock: off<br>=A0=A0=A0 Caps Lock: off<br>=A0 Base Memory: 634 kB<br>=A0 P=
nP BIOS: @@@0000<br>=A0 BIOS: extended read supported<br>=A0 MP spec rev 1.=
4 info:<br>=A0=A0=A0 OEM id: &quot;PEGANB&quot;<br>
=A0=A0=A0 Product id: &quot;PEGA&quot;<br>=A0=A0=A0 2 CPUs (0 disabled)<br>=
=A0 SMBIOS Version: 2.6<br>=A0 BIOS Info: #0<br>=A0=A0=A0 Vendor: &quot;Ame=
rican Megatrends Inc.&quot;<br>=A0=A0=A0 Version: &quot;300&quot;<br>=A0=A0=
=A0 Date: &quot;12/22/2011&quot;<br>
=A0=A0=A0 Start Address: 0xf0000<br>=A0=A0=A0 ROM Size: 2048 kB<br>=A0=A0=
=A0 Features: 0x0503000000053f899880<br>=A0=A0=A0=A0=A0 PCI supported<br>=
=A0=A0=A0=A0=A0 BIOS flashable<br>=A0=A0=A0=A0=A0 BIOS shadowing allowed<br=
>=A0=A0=A0=A0=A0 CD boot supported<br>=A0=A0=A0=A0=A0 Selectable boot suppo=
rted<br>
=A0=A0=A0=A0=A0 EDD spec supported<br>=A0=A0=A0=A0=A0 1.2MB Floppy supporte=
d<br>=A0=A0=A0=A0=A0 720kB Floppy supported<br>=A0=A0=A0=A0=A0 2.88MB Flopp=
y supported<br>=A0=A0=A0=A0=A0 Print Screen supported<br>=A0=A0=A0=A0=A0 80=
42 Keyboard Services supported<br>=A0=A0=A0=A0=A0 Serial Services supported=
<br>
=A0=A0=A0=A0=A0 Printer Services supported<br>=A0=A0=A0=A0=A0 ACPI supporte=
d<br>=A0=A0=A0=A0=A0 USB Legacy supported<br>=A0=A0=A0=A0=A0 BIOS Boot Spec=
 supported<br>=A0 Processor Info: #4<br>=A0=A0=A0 Socket: &quot;CPU 1&quot;=
<br>=A0=A0=A0 Socket Type: 0x01 (Other)<br>=A0=A0=A0 Socket Status: Populat=
ed<br>
=A0=A0=A0 Type: 0x03 (CPU)<br>=A0=A0=A0 Family: 0xc2 (Other)<br>=A0=A0=A0 M=
anufacturer: &quot;Intel&quot;<br>=A0=A0=A0 Version: &quot;Intel(R) Core(TM=
) i7-2760QM CPU @ 2.40GHz&quot;<br>=A0=A0=A0 Serial: &quot;To Be Filled By =
O.E.M.&quot;<br>=A0=A0=A0 Asset Tag: &quot;To Be Filled By O.E.M.&quot;<br>
=A0=A0=A0 Part Number: &quot;To Be Filled By O.E.M.&quot;<br>=A0=A0=A0 Proc=
essor ID: 0xbfebfbff000206a7<br>=A0=A0=A0 Status: 0x01 (Enabled)<br>=A0=A0=
=A0 External Clock: 100 MHz<br>=A0=A0=A0 Max. Speed: 4000 MHz<br>=A0=A0=A0 =
Current Speed: 2400 MHz<br>=A0=A0=A0 L1 Cache: #5<br>
=A0=A0=A0 L2 Cache: #6<br>=A0 Cache Info: #5<br>=A0=A0=A0 Designation: &quo=
t;L1-Cache&quot;<br>=A0=A0=A0 Level: L1<br>=A0=A0=A0 State: Enabled<br>=A0=
=A0=A0 Mode: 0x01 (Write Back)<br>=A0=A0=A0 Location: 0x00 (Internal, Not S=
ocketed)<br>=A0=A0=A0 ECC: 0x03 (None)<br>
=A0=A0=A0 Type: 0xff (Other)<br>=A0=A0=A0 Supported SRAM Types: 0x0001 (Oth=
er)<br>=A0=A0=A0 Current SRAM Type: 0x0001 (Other)<br>=A0 Cache Info: #6<br=
>=A0=A0=A0 Designation: &quot;L2-Cache&quot;<br>=A0=A0=A0 Level: L2<br>=A0=
=A0=A0 State: Enabled<br>=A0=A0=A0 Mode: 0x02 (Varies with Memory Address)<=
br>
=A0=A0=A0 Location: 0x00 (Internal, Not Socketed)<br>=A0=A0=A0 ECC: 0x03 (N=
one)<br>=A0=A0=A0 Type: 0xff (Other)<br>=A0=A0=A0 Supported SRAM Types: 0x0=
001 (Other)<br>=A0=A0=A0 Current SRAM Type: 0x0001 (Other)<br>=A0 Inactive =
Record: #7<br>=A0=A0=A0 Data 00: 7e 13 07 00 01 02 03 00 00 00 00 02 00 02 =
00 00<br>
=A0=A0=A0 Data 10: 02 02 02<br>=A0=A0=A0 String 1: &quot;L3-Cache&quot;<br>=
=A0 Port Connector: #8<br>=A0=A0=A0 Type: 0x0e (Mouse Port)<br>=A0=A0=A0 In=
ternal Designator: &quot;J1A1&quot;<br>=A0=A0=A0 External Designator: &quot=
;PS2Mouse&quot;<br>=A0=A0=A0 External Connector: 0x0f (PS/2)<br>
=A0 Port Connector: #9<br>=A0=A0=A0 Type: 0x0d (Keyboard Port)<br>=A0=A0=A0=
 Internal Designator: &quot;J1A1&quot;<br>=A0=A0=A0 External Designator: &q=
uot;Keyboard&quot;<br>=A0=A0=A0 External Connector: 0x0f (PS/2)<br>=A0 Port=
 Connector: #10<br>=A0=A0=A0 Type: 0x09 (Serial Port 16550A Compatible)<br>
=A0=A0=A0 Internal Designator: &quot;J1A2A&quot;<br>=A0=A0=A0 External Desi=
gnator: &quot;Serial Port&quot;<br>=A0=A0=A0 External Connector: 0x08 (DB-9=
 pin male)<br>=A0 Port Connector: #11<br>=A0=A0=A0 Type: 0x1c (Video Port)<=
br>=A0=A0=A0 Internal Designator: &quot;J1A2B&quot;<br>
=A0=A0=A0 External Designator: &quot;Video&quot;<br>=A0=A0=A0 External Conn=
ector: 0x07 (DB-15 pin female)<br>=A0 Port Connector: #12<br>=A0=A0=A0 Type=
: 0x1c (Video Port)<br>=A0=A0=A0 Internal Designator: &quot;J3A2&quot;<br>=
=A0=A0=A0 External Designator: &quot;HDMI&quot;<br>
=A0=A0=A0 External Connector: 0xff (Other)<br>=A0 Port Connector: #13<br>=
=A0=A0=A0 Type: 0x10 (USB)<br>=A0=A0=A0 Internal Designator: &quot;J3A3&quo=
t;<br>=A0=A0=A0 External Designator: &quot;USB1&quot;<br>=A0=A0=A0 External=
 Connector: 0x12 (Access Bus [USB])<br>
=A0 Port Connector: #14<br>=A0=A0=A0 Type: 0x10 (USB)<br>=A0=A0=A0 Internal=
 Designator: &quot;J3A3&quot;<br>=A0=A0=A0 External Designator: &quot;USB2&=
quot;<br>=A0=A0=A0 External Connector: 0x12 (Access Bus [USB])<br>=A0 Port =
Connector: #15<br>=A0=A0=A0 Type: 0x10 (USB)<br>
=A0=A0=A0 Internal Designator: &quot;J3A3&quot;<br>=A0=A0=A0 External Desig=
nator: &quot;USB3&quot;<br>=A0=A0=A0 External Connector: 0x12 (Access Bus [=
USB])<br>=A0 Port Connector: #16<br>=A0=A0=A0 Type: 0x10 (USB)<br>=A0=A0=A0=
 Internal Designator: &quot;J3A3&quot;<br>
=A0=A0=A0 External Designator: &quot;USB4&quot;<br>=A0=A0=A0 External Conne=
ctor: 0x12 (Access Bus [USB])<br>=A0 Port Connector: #17<br>=A0=A0=A0 Type:=
 0x10 (USB)<br>=A0=A0=A0 Internal Designator: &quot;J4A1&quot;<br>=A0=A0=A0=
 External Designator: &quot;USB5&quot;<br>
=A0=A0=A0 External Connector: 0x12 (Access Bus [USB])<br>=A0 Port Connector=
: #18<br>=A0=A0=A0 Type: 0x10 (USB)<br>=A0=A0=A0 Internal Designator: &quot=
;J4A1&quot;<br>=A0=A0=A0 External Designator: &quot;USB6&quot;<br>=A0=A0=A0=
 External Connector: 0x12 (Access Bus [USB])<br>
=A0 Port Connector: #19<br>=A0=A0=A0 Type: 0x1f (Network Port)<br>=A0=A0=A0=
 Internal Designator: &quot;J4A1&quot;<br>=A0=A0=A0 External Designator: &q=
uot;LAN&quot;<br>=A0=A0=A0 External Connector: 0x0b (RJ-45)<br>=A0 Port Con=
nector: #20<br>=A0=A0=A0 Type: 0xff (Other)<br>
=A0=A0=A0 Internal Designator: &quot;J5A1&quot;<br>=A0=A0=A0 External Desig=
nator: &quot;Motherboard DP&quot;<br>=A0=A0=A0 External Connector: 0xff (Ot=
her)<br>=A0 Port Connector: #21<br>=A0=A0=A0 Type: 0x20 (Other)<br>=A0=A0=
=A0 Internal Designator: &quot;J8J1&quot;<br>
=A0=A0=A0 External Designator: &quot;SATA Port 0 Direct Connect&quot;<br>=
=A0=A0=A0 External Connector: 0x22 (Other)<br>=A0 Port Connector: #22<br>=
=A0=A0=A0 Type: 0x20 (Other)<br>=A0=A0=A0 Internal Designator: &quot;J7J1&q=
uot;<br>=A0=A0=A0 External Designator: &quot;eSATA Port 4&quot;<br>
=A0=A0=A0 External Connector: 0x22 (Other)<br>=A0 Port Connector: #23<br>=
=A0=A0=A0 Type: 0x20 (Other)<br>=A0=A0=A0 Internal Designator: &quot;J6J1&q=
uot;<br>=A0=A0=A0 External Designator: &quot;eSATA Port 3&quot;<br>=A0=A0=
=A0 External Connector: 0x22 (Other)<br>
=A0 Port Connector: #24<br>=A0=A0=A0 Type: 0xff (Other)<br>=A0=A0=A0 Intern=
al Designator: &quot;J1F2&quot;<br>=A0=A0=A0 External Designator: &quot;AC =
IN&quot;<br>=A0=A0=A0 External Connector: 0xff (Other)<br>=A0 Port Connecto=
r: #25<br>=A0=A0=A0 Type: 0xff (Other)<br>
=A0=A0=A0 Internal Designator: &quot;J5B1 - PCH JTAG&quot;<br>=A0=A0=A0 Int=
ernal Connector: 0xff (Other)<br>=A0 Port Connector: #26<br>=A0=A0=A0 Type:=
 0xff (Other)<br>=A0=A0=A0 Internal Designator: &quot;J9A1 - TPM/PORT 80&qu=
ot;<br>=A0=A0=A0 Internal Connector: 0xff (Other)<br>
=A0 Port Connector: #27<br>=A0=A0=A0 Type: 0xff (Other)<br>=A0=A0=A0 Intern=
al Designator: &quot;J9E4 - HDA 2X8 Header&quot;<br>=A0=A0=A0 Internal Conn=
ector: 0xff (Other)<br>=A0 Port Connector: #28<br>=A0=A0=A0 Type: 0xff (Oth=
er)<br>=A0=A0=A0 Internal Designator: &quot;J9E7 - HDA 8Pin Header&quot;<br=
>
=A0=A0=A0 Internal Connector: 0xff (Other)<br>=A0 Port Connector: #29<br>=
=A0=A0=A0 Type: 0xff (Other)<br>=A0=A0=A0 Internal Designator: &quot;J8F1 -=
 HDA HDMI&quot;<br>=A0=A0=A0 Internal Connector: 0xff (Other)<br>=A0 Port C=
onnector: #30<br>=A0=A0=A0 Type: 0xff (Other)<br>
=A0=A0=A0 Internal Designator: &quot;J9E3 - Scan Matrix Keyboard&quot;<br>=
=A0=A0=A0 Internal Connector: 0xff (Other)<br>=A0 Port Connector: #31<br>=
=A0=A0=A0 Type: 0xff (Other)<br>=A0=A0=A0 Internal Designator: &quot;J8E1 -=
 SPI Program&quot;<br>=A0=A0=A0 Internal Connector: 0xff (Other)<br>
=A0 Port Connector: #32<br>=A0=A0=A0 Type: 0xff (Other)<br>=A0=A0=A0 Intern=
al Designator: &quot;J9E5 - LPC Hot Docking&quot;<br>=A0=A0=A0 Internal Con=
nector: 0xff (Other)<br>=A0 Port Connector: #33<br>=A0=A0=A0 Type: 0xff (Ot=
her)<br>=A0=A0=A0 Internal Designator: &quot;J9G2 - LPC SIDE BAND&quot;<br>
=A0=A0=A0 Internal Connector: 0xff (Other)<br>=A0 Port Connector: #34<br>=
=A0=A0=A0 Type: 0xff (Other)<br>=A0=A0=A0 Internal Designator: &quot;J8F2 -=
 LPC Slot&quot;<br>=A0=A0=A0 Internal Connector: 0xff (Other)<br>=A0 Port C=
onnector: #35<br>=A0=A0=A0 Type: 0xff (Other)<br>
=A0=A0=A0 Internal Designator: &quot;J8H3 - PCH XDP&quot;<br>=A0=A0=A0 Inte=
rnal Connector: 0xff (Other)<br>=A0 Port Connector: #36<br>=A0=A0=A0 Type: =
0x20 (Other)<br>=A0=A0=A0 Internal Designator: &quot;J7G1 - SATA Port 2&quo=
t;<br>=A0=A0=A0 Internal Connector: 0x22 (Other)<br>
=A0 Port Connector: #37<br>=A0=A0=A0 Type: 0x20 (Other)<br>=A0=A0=A0 Intern=
al Designator: &quot;J7G2 - SATA Port 1&quot;<br>=A0=A0=A0 Internal Connect=
or: 0x22 (Other)<br>=A0 Port Connector: #38<br>=A0=A0=A0 Type: 0xff (Other)=
<br>=A0=A0=A0 Internal Designator: &quot;J6H1 - SATA Power&quot;<br>
=A0=A0=A0 Internal Connector: 0xff (Other)<br>=A0 Port Connector: #39<br>=
=A0=A0=A0 Type: 0xff (Other)<br>=A0=A0=A0 Internal Designator: &quot;J5J1 -=
 FP Header&quot;<br>=A0=A0=A0 Internal Connector: 0xff (Other)<br>=A0 Port =
Connector: #40<br>=A0=A0=A0 Type: 0xff (Other)<br>
=A0=A0=A0 Internal Designator: &quot;J4H1 - ATX Power&quot;<br>=A0=A0=A0 In=
ternal Connector: 0xff (Other)<br>=A0 Port Connector: #41<br>=A0=A0=A0 Type=
: 0xff (Other)<br>=A0=A0=A0 Internal Designator: &quot;J1J3 - AVMC&quot;<br=
>=A0=A0=A0 Internal Connector: 0xff (Other)<br>
=A0 Port Connector: #42<br>=A0=A0=A0 Type: 0xff (Other)<br>=A0=A0=A0 Intern=
al Designator: &quot;J1H1 - BATT B&quot;<br>=A0=A0=A0 Internal Connector: 0=
xff (Other)<br>=A0 Port Connector: #43<br>=A0=A0=A0 Type: 0xff (Other)<br>=
=A0=A0=A0 Internal Designator: &quot;J1H2 - BATT A&quot;<br>
=A0=A0=A0 Internal Connector: 0xff (Other)<br>=A0 Port Connector: #44<br>=
=A0=A0=A0 Type: 0xff (Other)<br>=A0=A0=A0 Internal Designator: &quot;J2G1 -=
 CPU Fan&quot;<br>=A0=A0=A0 Internal Connector: 0xff (Other)<br>=A0 Port Co=
nnector: #45<br>=A0=A0=A0 Type: 0xff (Other)<br>
=A0=A0=A0 Internal Designator: &quot;J1D3 - XDP&quot;<br>=A0=A0=A0 Internal=
 Connector: 0xff (Other)<br>=A0 Port Connector: #46<br>=A0=A0=A0 Type: 0xff=
 (Other)<br>=A0=A0=A0 Internal Designator: &quot;J4V1 - Memory Slot 1&quot;=
<br>=A0=A0=A0 Internal Connector: 0xff (Other)<br>
=A0 Port Connector: #47<br>=A0=A0=A0 Type: 0xff (Other)<br>=A0=A0=A0 Intern=
al Designator: &quot;J4V2 - Memory Slot 2&quot;<br>=A0=A0=A0 Internal Conne=
ctor: 0xff (Other)<br>=A0 Port Connector: #48<br>=A0=A0=A0 Type: 0xff (Othe=
r)<br>=A0=A0=A0 Internal Designator: &quot;J4C1 - FAN PWR&quot;<br>
=A0=A0=A0 Internal Connector: 0xff (Other)<br>=A0 System Slot: #49<br>=A0=
=A0=A0 Designation: &quot;J5C1&quot;<br>=A0=A0=A0 Type: 0xaa (Other)<br>=A0=
=A0=A0 Bus Width: 0x0d (Other)<br>=A0=A0=A0 Status: 0x03 (Available)<br>=A0=
=A0=A0 Length: 0x04 (Long)<br>=A0=A0=A0 Slot ID: 0<br>
=A0=A0=A0 Characteristics: 0x010c (3.3 V, Shared, PME#)<br>=A0 System Slot:=
 #50<br>=A0=A0=A0 Designation: &quot;J6C2&quot;<br>=A0=A0=A0 Type: 0xa5 (Ot=
her)<br>=A0=A0=A0 Bus Width: 0x08 (Other)<br>=A0=A0=A0 Status: 0x03 (Availa=
ble)<br>=A0=A0=A0 Length: 0x03 (Short)<br>
=A0=A0=A0 Slot ID: 1<br>=A0=A0=A0 Characteristics: 0x010c (3.3 V, Shared, P=
ME#)<br>=A0 System Slot: #51<br>=A0=A0=A0 Designation: &quot;J6D2&quot;<br>=
=A0=A0=A0 Type: 0xa5 (Other)<br>=A0=A0=A0 Bus Width: 0x08 (Other)<br>=A0=A0=
=A0 Status: 0x04 (In Use)<br>=A0=A0=A0 Length: 0x03 (Short)<br>
=A0=A0=A0 Slot ID: 2<br>=A0=A0=A0 Characteristics: 0x010c (3.3 V, Shared, P=
ME#)<br>=A0 System Slot: #52<br>=A0=A0=A0 Designation: &quot;J7C1&quot;<br>=
=A0=A0=A0 Type: 0xa5 (Other)<br>=A0=A0=A0 Bus Width: 0x08 (Other)<br>=A0=A0=
=A0 Status: 0x03 (Available)<br>=A0=A0=A0 Length: 0x03 (Short)<br>
=A0=A0=A0 Slot ID: 3<br>=A0=A0=A0 Characteristics: 0x010c (3.3 V, Shared, P=
ME#)<br>=A0 System Slot: #53<br>=A0=A0=A0 Designation: &quot;J7D2&quot;<br>=
=A0=A0=A0 Type: 0xa5 (Other)<br>=A0=A0=A0 Bus Width: 0x08 (Other)<br>=A0=A0=
=A0 Status: 0x04 (In Use)<br>=A0=A0=A0 Length: 0x03 (Short)<br>
=A0=A0=A0 Slot ID: 4<br>=A0=A0=A0 Characteristics: 0x010c (3.3 V, Shared, P=
ME#)<br>=A0 System Slot: #54<br>=A0=A0=A0 Designation: &quot;J6C1&quot;<br>=
=A0=A0=A0 Type: 0xa5 (Other)<br>=A0=A0=A0 Bus Width: 0x08 (Other)<br>=A0=A0=
=A0 Status: 0x03 (Available)<br>=A0=A0=A0 Length: 0x03 (Short)<br>
=A0=A0=A0 Slot ID: 5<br>=A0=A0=A0 Characteristics: 0x010c (3.3 V, Shared, P=
ME#)<br>=A0 System Slot: #55<br>=A0=A0=A0 Designation: &quot;J8C2&quot;<br>=
=A0=A0=A0 Type: 0xaa (Other)<br>=A0=A0=A0 Bus Width: 0x05 (32 bit)<br>=A0=
=A0=A0 Status: 0x04 (In Use)<br>=A0=A0=A0 Length: 0x04 (Long)<br>
=A0=A0=A0 Slot ID: 6<br>=A0=A0=A0 Characteristics: 0x010c (3.3 V, Shared, P=
ME#)<br>=A0 On Board Devices: #60<br>=A0=A0=A0 Video: &quot;To Be Filled By=
 O.E.M.&quot;<br>=A0 On Board Devices: #61<br>=A0=A0=A0 Ethernet: &quot;To =
Be Filled By O.E.M.&quot; (disabled)<br>
=A0 On Board Devices: #62<br>=A0=A0=A0 Sound: &quot;To Be Filled By O.E.M.&=
quot;<br>=A0 OEM Strings: #63<br>=A0 System Config Options (Jumpers &amp; S=
witches) #64:<br>=A0=A0=A0 DSN:<br>=A0 32bit-Memory Error Info: #66<br>=A0=
=A0=A0 Type: 0x03 (OK)<br>
=A0=A0=A0 Granularity: 0x02 (Unknown)<br>=A0=A0=A0 Operation: 0x02 (Unknown=
)<br>=A0 32bit-Memory Error Info: #69<br>=A0=A0=A0 Type: 0x03 (OK)<br>=A0=
=A0=A0 Granularity: 0x02 (Unknown)<br>=A0=A0=A0 Operation: 0x02 (Unknown)<b=
r>=A0 32bit-Memory Error Info: #72<br>
=A0=A0=A0 Type: 0x03 (OK)<br>=A0=A0=A0 Granularity: 0x02 (Unknown)<br>=A0=
=A0=A0 Operation: 0x02 (Unknown)<br>=A0 Pointing Device: #74<br>=A0=A0=A0 T=
ype: 0x07 (Touch Pad)<br>=A0=A0=A0 Interface: 0x04 (PS/2)<br>=A0=A0=A0 Butt=
ons: 2<br>=A0 Type 32 Record: #75<br>=A0=A0=A0 Data 00: 20 14 4b 00 00 00 0=
0 00 00 00 00 00 00 00 00 00<br>
=A0=A0=A0 Data 10: 00 00 00 00<br>=A0 System Info: #1<br>=A0=A0=A0 Manufact=
urer: &quot;NOVATECH LTD&quot;<br>=A0=A0=A0 Product: &quot;A15A/HE/HC&quot;=
<br>=A0=A0=A0 Version: &quot;1.0&quot;<br>=A0=A0=A0 Serial: &quot;11APE2083=
146&quot;<br>=A0=A0=A0 UUID: undefined, but settable<br>
=A0=A0=A0 Wake-up: 0x06 (Power Switch)<br>=A0 Board Info: #2<br>=A0=A0=A0 M=
anufacturer: &quot;Novatech Ltd&quot;<br>=A0=A0=A0 Product: &quot;A15&quot;=
<br>=A0=A0=A0 Version: &quot;1.0&quot;<br>=A0=A0=A0 Serial: &quot;BSN123456=
78901234567&quot;<br>=A0=A0=A0 Asset Tag: &quot;ATN12345678901234567&quot;<=
br>
=A0=A0=A0 Type: 0x0a (Motherboard)<br>=A0=A0=A0 Features: 0x09<br>=A0=A0=A0=
=A0=A0 Hosting Board<br>=A0=A0=A0=A0=A0 Replaceable<br>=A0=A0=A0 Location: =
&quot;MIDDLE&quot;<br>=A0=A0=A0 Chassis: #3<br>=A0 Chassis Info: #3<br>=A0=
=A0=A0 Manufacturer: &quot;Novatech Ltd&quot;<br>
=A0=A0=A0 Version: &quot;1.0&quot;<br>=A0=A0=A0 Serial: &quot;CSN1234567890=
1234567&quot;<br>=A0=A0=A0 Asset Tag: &quot;No Asset Tag&quot;<br>=A0=A0=A0=
 Type: 0x09 (LapTop)<br>=A0=A0=A0 Bootup State: 0x03 (Safe)<br>=A0=A0=A0 Po=
wer Supply State: 0x03 (Safe)<br>
=A0=A0=A0 Thermal State: 0x03 (Safe)<br>=A0=A0=A0 Security Status: 0x03 (No=
ne)<br>=A0 Physical Memory Array: #65<br>=A0=A0=A0 Use: 0x03 (System memory=
)<br>=A0=A0=A0 Location: 0x03 (Motherboard)<br>=A0=A0=A0 Slots: 2<br>=A0=A0=
=A0 Max. Size: 8 GB<br>=A0=A0=A0 ECC: 0x03 (None)<br>
=A0=A0=A0 Error Info: #66<br>=A0 Memory Device: #67<br>=A0=A0=A0 Location: =
&quot;DIMM0&quot;<br>=A0=A0=A0 Bank: &quot;BANK 0&quot;<br>=A0=A0=A0 Manufa=
cturer: &quot;80CE&quot;<br>=A0=A0=A0 Serial: &quot;65628DA3&quot;<br>=A0=
=A0=A0 Asset Tag: &quot;Unknown&quot;<br>
=A0=A0=A0 Part Number: &quot;M471B5273CH0-CH9&quot;<br>=A0=A0=A0 Memory Arr=
ay: #65<br>=A0=A0=A0 Error Info: #69<br>=A0=A0=A0 Form Factor: 0x0d (SODIMM=
)<br>=A0=A0=A0 Type: 0x18 (Other)<br>=A0=A0=A0 Type Detail: 0x0080 (Synchro=
nous)<br>=A0=A0=A0 Data Width: 64 bits<br>
=A0=A0=A0 Size: 4 GB<br>=A0=A0=A0 Speed: 1333 MHz<br>=A0 Memory Device Mapp=
ing: #68<br>=A0=A0=A0 Memory Device: #67<br>=A0=A0=A0 Array Mapping: #73<br=
>=A0=A0=A0 Interleave Pos: 1<br>=A0=A0=A0 Interleaved Depth: 1<br>=A0=A0=A0=
 Start Address: 0x0000000000000000<br>=A0=A0=A0 End Address: 0x000000010000=
0000<br>
=A0 Memory Device: #70<br>=A0=A0=A0 Location: &quot;DIMM2&quot;<br>=A0=A0=
=A0 Bank: &quot;BANK 2&quot;<br>=A0=A0=A0 Manufacturer: &quot;80CE&quot;<br=
>=A0=A0=A0 Serial: &quot;62477F22&quot;<br>=A0=A0=A0 Asset Tag: &quot;Unkno=
wn&quot;<br>=A0=A0=A0 Part Number: &quot;M471B5273DH0-CH9&quot;<br>
=A0=A0=A0 Memory Array: #65<br>=A0=A0=A0 Error Info: No Error<br>=A0=A0=A0 =
Form Factor: 0x0d (SODIMM)<br>=A0=A0=A0 Type: 0x18 (Other)<br>=A0=A0=A0 Typ=
e Detail: 0x0080 (Synchronous)<br>=A0=A0=A0 Data Width: 64 bits<br>=A0=A0=
=A0 Size: 4 GB<br>=A0=A0=A0 Speed: 1333 MHz<br>
=A0 Memory Device Mapping: #71<br>=A0=A0=A0 Memory Device: #70<br>=A0=A0=A0=
 Array Mapping: #73<br>=A0=A0=A0 Interleave Pos: 2<br>=A0=A0=A0 Interleaved=
 Depth: 1<br>=A0=A0=A0 Start Address: 0x0000000000000000<br>=A0=A0=A0 End A=
ddress: 0x0000000100000000<br>=A0 Memory Array Mapping: #73<br>
=A0=A0=A0 Memory Array: #65<br>=A0=A0=A0 Partition Width: 2<br>=A0=A0=A0 St=
art Address: 0x0000000000000000<br>=A0=A0=A0 End Address: 0x000000010000000=
0<br>=A0 Language Info: #76<br>=A0=A0=A0 Languages: eng<br>=A0=A0=A0 Curren=
t: eng<br>=A0 Config Status: cfg=3Dnew, avail=3Dyes, need=3Dno, active=3Dun=
known</i><br>
<br>when i use sensors ,i get,<br><br><i>acpitz-virtual-0<br>Adapter: Virtu=
al device<br>temp1:=A0=A0=A0=A0=A0=A0=A0 +56.0=B0C=A0 (crit =3D +99.0=B0C)<=
/i><br><br>when i use sensors-detect and and say yes to every step,i get,<b=
r><br><i># sensors-detect revision 6085 (2012-10-30 18:18:45 +0100)<br>
# System: NOVATECH LTD A15A/HE/HC [1.0] (laptop)<br># Board: Novatech Ltd A=
15<br><br>This program will help you determine which kernel modules you nee=
d<br>to load to use lm_sensors most effectively. It is generally safe<br>
and recommended to accept the default answers to all questions,<br>unless y=
ou know what you&#39;re doing.<br><br>Some south bridges, CPUs or memory co=
ntrollers contain embedded sensors.<br>Do you want to scan for them? This i=
s totally safe. (YES/no): y<br>
Module cpuid loaded successfully.<br>Silicon Integrated Systems SIS5595...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>VI=
A VT82C686 Integrated Sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>VIA VT8231 Integrated Sensors...=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 No<br>
AMD K8 thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>AMD Family 10h=
 thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>AMD Family 11h thermal sensors...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br=
>AMD Family 12h and 14h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 No<br>
AMD Family 15h thermal sensors...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>AMD Family 15h power sensors...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 No<br>Intel digital thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Success!<br>=A0=
=A0=A0 (driver `coretemp&#39;)<br>
Intel AMB FB-DIMM thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>VIA C7 thermal sensor...=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 No<br>VIA Nano thermal sensor...=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 No<br><br>Some Super I/O chips contain embedded sensors. We have to wri=
te to<br>
standard I/O ports to probe them. This is usually safe.<br>Do you want to s=
can for Super I/O sensors? (YES/no): y<br>Probing for Super-I/O at 0x2e/0x2=
f<br>Trying family `National Semiconductor/ITE&#39;...=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 Yes<br>
Found unknown chip with ID 0x0202<br>Probing for Super-I/O at 0x4e/0x4f<br>=
Trying family `National Semiconductor/ITE&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 No<br>Trying family `SMSC&#39;...=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 No<br>Trying family `VIA/Winbond/Nuvoton/Fintek&#39;...=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Trying family `ITE&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br><br>S=
ome hardware monitoring chips are accessible through the ISA I/O ports.<br>=
We have to write to arbitrary I/O ports to probe them. This is usually<br>
safe though. Yes, you do have ISA I/O ports even if you do not have any<br>=
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): y<br>Probing fo=
r `National Semiconductor LM78&#39; at 0x290...=A0=A0=A0=A0=A0=A0 No<br>Pro=
bing for `National Semiconductor LM79&#39; at 0x290...=A0=A0=A0=A0=A0=A0 No=
<br>
Probing for `Winbond W83781D&#39; at 0x290...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `Winbond W83782D&#39; at 0x290..=
.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br><br>Lastly, w=
e can probe the I2C/SMBus adapters for connected hardware<br>monitoring dev=
ices. This is the most risky part, and while it works<br>
reasonably well on most systems, it has been reported to cause trouble<br>o=
n some systems.<br>Do you want to probe the I2C/SMBus adapters now? (YES/no=
): y<br>Using driver `i2c-i801&#39; for device 0000:00:1f.3: Intel Cougar P=
oint (PCH)<br>
Module i2c-dev loaded successfully.<br><br>Next adapter: SMBus I801 adapter=
 at e040 (i2c-0)<br>Do you want to scan it? (YES/no/selectively): y<br>Clie=
nt found at address 0x50<br>Probing for `Analog Devices ADM1033&#39;...=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Probing for `Analog Devices ADM1034&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `SPD EEPROM&#39;...=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Yes<br>=A0=A0=A0 (confidence 8, not a hardware monitoring c=
hip)<br>Probing for `EDID EEPROM&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>
Client found at address 0x52<br>Probing for `Analog Devices ADM1033&#39;...=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 No<br>Probing =
for `Analog Devices ADM1034&#39;...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 No<br>Probing for `SPD EEPROM&#39;...=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Yes<br>
=A0=A0=A0 (confidence 8, not a hardware monitoring chip)<br><br>Next adapte=
r: i915 gmbus ssc (i2c-1)<br>Do you want to scan it? (yes/NO/selectively): =
y<br><br>Next adapter: i915 gmbus vga (i2c-2)<br>Do you want to scan it? (y=
es/NO/selectively): y<br>
<br>Next adapter: i915 gmbus panel (i2c-3)<br>Do you want to scan it? (yes/=
NO/selectively): y<br><br>Next adapter: i915 gmbus dpc (i2c-4)<br>Do you wa=
nt to scan it? (yes/NO/selectively): y<br><br>Next adapter: i915 gmbus dpb =
(i2c-5)<br>
Do you want to scan it? (yes/NO/selectively): y<br><br>Next adapter: i915 g=
mbus dpd (i2c-6)<br>Do you want to scan it? (yes/NO/selectively): y<br><br>=
Next adapter: DPDDC-D (i2c-7)<br>Do you want to scan it? (YES/no/selectivel=
y): y<br>
<br>Now follows a summary of the probes I have just done.<br>Just press ENT=
ER to continue: <br><br>Driver `coretemp&#39;:<br>=A0 * Chip `Intel digital=
 thermal sensor&#39; (confidence: 9)<br><br>Do you want to overwrite /etc/c=
onf.d/lm_sensors? (YES/no): y<br>
Unloading i2c-dev... OK<br>Unloading cpuid... OK</i><br><br><br><br><br>i a=
m getting high cpu temperatures and i feel fan speed is toohigh and uncontr=
olled.<br>facontrolis installed but i cannot use it.<br>i am unable to cont=
rolcu emp and fan speed<br>
pleae give us a steby step apprach to correct the problem.<br><br><br><br><=
br><br>sinc,<br><br><br><br><br><br><br>

--047d7bfd046ebeb58104d314aca4--


--===============6818774493016440054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6818774493016440054==--
