From: sukhdeep@gmail.com (Sukhdeep Johar)
Date: Tue, 14 Jun 2005 08:18:36 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address 0x49
Message-Id: <2ef564dc050613231773e39dd9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

And here is the dmidecode output : 

WS5K #./dmidecode
# dmidecode 1.8
SMBIOS 2.3 present.
DMI 2.3 present.
25 structures occupying 945 bytes.
DMI table at 0x000F0670.
Handle 0x0000
        DMI type 0, 20 bytes.
        BIOS Information Block
                Vendor: American Megatrends Inc.
                Version: 2.2
                Release: 07/09/02
                BIOS base: 0xF0000
                ROM size: 256K
                Capabilities:
                        Flags: 0x000000006FCBDE90
Handle 0x0001
        DMI type 1, 25 bytes.
        System Information Block
                Vendor: American Megatrends Inc.
                Product: Uknown
                Version: 1.0
                Serial Number: 1PCC5000RSWW0419S5450EC
Handle 0x0002
        DMI type 2, 8 bytes.
        Board Information Block
                Vendor: USI
                Product: PA-PR66T
                Version: 2.0
                Serial Number: SYMBOLWS-02-1.11
Handle 0x0003
        DMI type 3, 17 bytes.
        Chassis Information Block
                Vendor: Uknown Chassis Manufacture
                Chassis Type: Desktop
                Version: Version 1.00
                Serial Number: 123456890
                Asset Tag: 0123ABC
Handle 0x0004
        DMI type 4, 32 bytes.
        Processor
                Socket Designation: Socket-1
                Processor Type: Central Processor
                Processor Family:
                Processor Manufacturer: Intel                                   
                Processor Version: Pentium III                                  
Handle 0x0005
        DMI type 7, 19 bytes.
        Cache
                Socket: Internal Cache
                L1 Internal Cache: write-back
                L1 Cache Size: 32K
                L1 Cache Maximum: 1024K
                L1 Cache Type: Synchronous
Handle 0x0006
        DMI type 7, 19 bytes.
        Cache
                Socket: Internal Cache
                L2 Internal Cache: write-back
                L2 Cache Size: 256K
                L2 Cache Maximum: 1024K
                L2 Cache Type: Synchronous
Handle 0x0007
        DMI type 5, 24 bytes.
        Memory Controller
Handle 0x0008
        DMI type 6, 12 bytes.
        Memory Bank
                Socket: DIMM1
                Banks: 1 0
                Type:
                Installed Size: 128Mbyte
                Enabled Size: 128Mbyte
Handle 0x0009
        DMI type 6, 12 bytes.
        Memory Bank
                Socket: DIMM2
                Banks: 3 2
                Type: UNKNOWN
                Installed Size: Not Installed
                Enabled Size: Not Installed
Handle 0x000A
        DMI type 6, 12 bytes.
        Memory Bank
                Socket: DIMM3
                Banks: 5 4
                Type: UNKNOWN
                Installed Size: Not Installed
                Enabled Size: Not Installed
Handle 0x000B
        DMI type 6, 12 bytes.
        Memory Bank
                Socket: DIMM4
                Banks: 7 6
                Type: UNKNOWN
                Installed Size: Not Installed
                Enabled Size: Not Installed
Handle 0x000C
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI1
                Type: 32bit Long PCI
                Status: Available.
                Slot Features: 3.3v Shared
Handle 0x000D
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI2
                Type: 32bit Long PCI
                Status: Available.
                Slot Features: 3.3v Shared
Handle 0x000E
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI3
                Type: 32bit Long PCI
                Slot Features: 3.3v Shared
Handle 0x000F
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI4
                Type: 32bit Long PCI
                Slot Features: 3.3v Shared
Handle 0x0010
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI5
                Type: 32bit Long PCI
                Slot Features: 3.3v Shared
Handle 0x0011
        DMI type 9, 13 bytes.
        Card Slot
                Slot: ISA1
                Type: 16bit Long ISA
                Slot Features: 3.3v Shared
Handle 0x0012
        DMI type 9, 13 bytes.
        Card Slot
                Slot: ISA2
                Type: 16bit Long ISA
                Slot Features: 3.3v Shared
Handle 0x0013
        DMI type 11, 5 bytes.
        OEM Data
                SMBIOS Support from AMI
                Tested by James
Handle 0x0014
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: USB
                Internal Connector Type: Mini Centronics
                External Designator: Def
                External Connector Type: DB-25 pin male
                Port Type: SSA SCSI
Handle 0x0015
        DMI type 12, 5 bytes.
        Configuration Information
                System Management BIOS from Atlanta
                SMBIOS from AMI
Handle 0x0016
        DMI type 13, 22 bytes.
        BIOS Language Information
                Installable Languages: 4
                        English
                        Traditional Chinese
                        Simplified Chinese
                        Japanese
                Currently Installed Language: English
Handle 0x0017
        DMI type 15, 27 bytes.
        Event Log
                Log Area: 4096 bytes.
                Log Header At: 0.
                Log Data At: 0.
                Log Type: 4.
                Log Valid: Yes.
Handle 0x0018
        DMI type 127, 4 bytes.
        End-of-Table
PNP 1.0 present.
        Event Notification: Not Supported
        Real Mode Code Address: F000:6493
        Real Mode Data Address: F000:0000
        Protected Mode Code Address: 0x000F64BB
        Protected Mode Data Address: 0x000F0000
PCI Interrupt Routing 1.0 present.
        Table Size: 160 bytes
        Router ID: 00:11.0
        Exclusive IRQs: None
        Compatible Router: 1106:3074
BIOS32 Service Directory present.
        Calling Interface Address: 0x000FDB30

-sukhdeep
