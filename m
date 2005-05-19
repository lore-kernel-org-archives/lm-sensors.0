From: AAtallah@GMX.net (Antoine Atallah)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: Error message on IBM Aptiva
Message-Id: <200407060347.i663lBNF030338@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200402242045.i1OKjj1s020739@Stimpy.netroedge.com>
In-Reply-To: <200402242045.i1OKjj1s020739@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

	No problem for the delay :) 

	Actually, I looked at how your script worked a long time ago, and I
never had any problems with LM-Sensors. So, as I kept upgrading, I just kept
deleting the check for IBM and made the program run. So, I guess my Aptiva
works fine with LM-Sensors :)

	For the VPDDecode, the output is not really interesting; as it goes
like:
		Neptune dmidecode-2.4 # ./vpddecode
		# vpddecode 2.4
		# No VPD structure found, sorry.

	So, just to tell you, since this program doesn't seem to work, the
computer is an Aptiva 2274-38U, which comes with an IBM S21M motherboard,
which has a VIA686a chipset. So, you can see all this info from DMIDecode as
attached at the end of this email.

	Hope this helps out!

		Antoine Atallah


Neptune dmidecode-2.4 # dmidecode | more
# dmidecode 1.8
SMBIOS 2.3 present.
DMI 2.3 present.
35 structures occupying 968 bytes.
DMI table at 0x000F0800.
Handle 0x0000
        DMI type 2, 8 bytes.
        Board Information Block
                Vendor: IBM
                Product: S21M
                Version: -1
                Serial Number:
Handle 0x0001
        DMI type 3, 17 bytes.
        Chassis Information Block
                Vendor: Acer
                Chassis Type: Tower
                Version:
                Serial Number:
                Asset Tag:
Handle 0x0002
        DMI type 4, 35 bytes.
        Processor
                Socket Designation: Socket A
                Processor Type: Central Processor
                Processor Family: Other
                Processor Manufacturer: AMD
                Processor Version: AMD Duron(tm)
                Serial Number:
                Asset Tag:
                Vendor Part Number:
Handle 0x0003
        DMI type 5, 22 bytes.
        Memory Controller
Handle 0x0004
        DMI type 6, 12 bytes.
        Memory Bank
                Socket: BANK_0
                Banks: 0 1
                Speed: 70nS
                Type:
                Installed Size: 128Mbyte
                Enabled Size: 128Mbyte
Handle 0x0005
        DMI type 6, 12 bytes.
        Memory Bank
                Socket: BANK_1
                Banks: 2 3
                Speed: 70nS
                Type:
                Installed Size: 128Mbyte
                Enabled Size: 128Mbyte
Handle 0x0006
        DMI type 6, 12 bytes.
        Memory Bank
                Socket: BANK_2
                Banks: 4 5
                Speed: 70nS
                Type:
                Installed Size: 64Mbyte
                Enabled Size: 64Mbyte
Handle 0x0007
        DMI type 7, 19 bytes.
        Cache
                Socket: Internal Cache
                L1 Internal Cache: write-back
                L1 Cache Size: 32K
                L1 Cache Maximum: 32K
                L1 Cache Type: Synchronous
Handle 0x0008
        DMI type 7, 19 bytes.
        Cache
                Socket: Internal Cache
                L2 Internal Cache: write-back
                L2 Cache Size: 64K
                L2 Cache Maximum: 2048K
                L2 Cache Type: Synchronous
Handle 0x0009
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: PRIMARY IDE
                Internal Connector Type: On Board IDE
                External Designator:
                External Connector Type: None
                Port Type: Other
Handle 0x000A
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: SECONDARY IDE
                Internal Connector Type: On Board IDE
                External Designator:
                External Connector Type: None
                Port Type: Other
Handle 0x000B
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: FDD
                Internal Connector Type: On Board Floppy
                External Designator:
                External Connector Type: None
                Port Type: 8251 FIFO Compatible
Handle 0x000C
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: COM1
                Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
                External Designator:
                External Connector Type: DB-9 pin male
                Port Type: Serial Port 16450 Compatible
Handle 0x000D
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: LPT1
                Internal Connector Type: DB-25 pin female
                External Designator:
                External Connector Type: DB-25 pin female
                Port Type: Parallel Port ECP/EPP
Handle 0x000E
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: Keyboard
                Internal Connector Type: Other
                External Designator:
                External Connector Type: PS/2
                Port Type: Keyboard Port
Handle 0x000F
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: PS/2 Mouse
                Internal Connector Type: PS/2
                External Designator: Detected
                External Connector Type: PS/2
                Port Type: Mouse Port
Handle 0x0010
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI
                Type: 32bit Long PCI
                Status: In use.
                Slot Features: 5v
Handle 0x0011
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI
                Type: 32bit Long PCI
                Status: Available.
                Slot Features: 5v
Handle 0x0012
        DMI type 9, 13 bytes.
        Card Slot
                Slot: PCI
                Type: 32bit Long PCI
                Status: Available.
                Slot Features: 5v
Handle 0x0013
        DMI type 10, 6 bytes.
        On Board Devices Information
                Description:   : Enabled
                Type: Sound
Handle 0x0014
        DMI type 9, 13 bytes.
        Card Slot
                Slot: AGP
                Type: 32bit Long AGP
                Status: In use.
                Slot Features: 5v
Handle 0x0015
        DMI type 8, 9 bytes.
        Port Connector
                Internal Designator: USB
                Internal Connector Type: None
                External Designator:
                External Connector Type: Other
                Port Type: USB
Handle 0x0016
        DMI type 13, 22 bytes.
        BIOS Language Information
                Installable Languages: 3
                        n|US|iso8859-1
                        n|US|iso8859-1
                        r|CA|iso8859-1
                Currently Installed Language: n|US|iso8859-1
Handle 0x0017
        DMI type 0, 20 bytes.
        BIOS Information Block
                Vendor: Award Software International, Inc.
                Version: S21M-E4
                Release: 10/09/2000
                BIOS base: 0xE0000
                ROM size: 256K
                Capabilities:
                        Flags: 0x000000007FCBDE80
Handle 0x0018
        DMI type 1, 25 bytes.
        System Information Block
                Vendor: IBM
                Product: 227438U
                Version: S21M
                Serial Number: AM81VKH
Handle 0x0019
        DMI type 16, 15 bytes.
        Physical Memory Array
                Location: System board or motherboard
                Use: Flash memory
                Error Correction Type: None
                Maximum Capacity: 524288 kB
                Error Information Handle: Not Provided
                Number of Devices: 3
Handle 0x001A
        DMI type 17, 21 bytes.
        Memory Device
                Array Handle: 0x0019
                Error Information Handle: Not Provided
                Total Width: Unknown
                Data Width: Unknown
                Size: 128 Mbyte
                Form Factor: DIMM
                Locator: BANK_0
                Bank Locator: Bank0/1
                Type: Unknown
Handle 0x001B
        DMI type 17, 21 bytes.
        Memory Device
                Array Handle: 0x0019
                Error Information Handle: Not Provided
                Total Width: Unknown
                Data Width: Unknown
                Size: 128 Mbyte
                Form Factor: DIMM
                Locator: BANK_1
                Bank Locator: Bank2/3
                Type: Unknown
Handle 0x001C
        DMI type 17, 21 bytes.
        Memory Device
                Array Handle: 0x0019
                Error Information Handle: Not Provided
                Total Width: Unknown
                Data Width: Unknown
                Size: 64 Mbyte
                Form Factor: DIMM
                Locator: BANK_2
                Bank Locator: Bank4/5
                Type: Unknown
Handle 0x001D
        DMI type 19, 15 bytes.
        Memory Array Mapped Address
Handle 0x001E
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
Handle 0x001F
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
Handle 0x0020
        DMI type 20, 19 bytes.
        Memory Device Mapped Address
Handle 0x0021
        DMI type 32, 11 bytes.
        System Boot Information
Handle 0x0022
        DMI type 127, 4 bytes.
        End-of-Table
ACPI 1.0 present.
        OEM ID: VIA694
        Memory Device Mapped Address
Handle 0x0021
        DMI type 32, 11 bytes.
        System Boot Information
Handle 0x0022
        DMI type 127, 4 bytes.
        End-of-Table
ACPI 1.0 present.
        OEM ID: VIA694
RSD table at 0x13FF3000.
BIOS32 Service Directory present.
        Calling Interface Address: 0x000FB320
PNP 1.0 present.
        Event Notification: Not Supported
        Real Mode Code Address: F000:BE68
        Real Mode Data Address: F000:0000
        Protected Mode Code Address: 0x000FBE40
        Protected Mode Data Address: 0x000F0000
PCI Interrupt Routing 1.0 present.
        Table Size: 128 bytes
        Router ID: 00:07.0
        Exclusive IRQs: 5 10 11
        Compatible Router: 1106:0596





-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: July 4, 2004 4:24 PM
To: Antoine Atallah
Cc: LM Sensors
Subject: Re: Error message on IBM Aptiva

Hi Antoine,

Sorry for the delay... to say the least.

> As the error message specifies, and to help you develop your
> great drivers, here is a copy of what my Aptiva 2274-38U (Duron 600MHz
> version) told me when I ran sensor detect. Also, it is on kernel
> 2.4.25(Gentoo Linux, recompiled and all). So, if that can help you,
> i'm happy :-)

OK. If you still want to help, here's what you can do.

1* Provide the output of vpddecode for your system. vpddecode is part of
the dmidecode package which can be found here:
  http://www.nongnu.org/dmidecode/

2* Get lm_sensors CVS:
  http://secure.netroedge.com/~lm78/download.html#cvs
Edit sensors-detect, last line of function safe_system_vendor, replace
"exit" with "return". Sensors-detect will now accept to run on your
system. Recent changes make us _believe_ that it is safe on all systems.
(We'll do the change permanently as soon as we are certain that the
change has no downside). Still don't do it if you consider your system
priceless.

And let us know how it goes.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
