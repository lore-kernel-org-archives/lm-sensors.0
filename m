From: paul.aviles@palei.com (Paul Aviles)
Date: Sun, 20 Nov 2005 15:16:23 +0000
Subject: [lm-sensors] decode-dimms.pl
Message-Id: <000601c5eddd$372e8c80$3224050a@avilespaxp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Qucik question on decode-dimms,

I have 3 dimms insalled 512, 256 and 256 for a total of 1 Gb.

Is the total memory per dimm a combination of :

Total number of bytes in EEPROM 256
Number of Module Rows   2

The report is below. Is there maybe a different way to find out the amount 
if memory per simm installed?

Regards,

Paul Aviles

___________________


PC DIMM Serial Presence Detect Tester/Decoder
By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner and others
Version 2.9.2

Decoding EEPROM /sys/bus/i2c/drivers/eeprom/0-0050
Guessing DIMM is in     bank 1

---== The Following is Required Data and is Applicable to all DIMM Types 
==---
# of bytes written to SDRAM EEPROM      128
Total number of bytes in EEPROM 256
Fundamental Memory type DDR SDRAM
Number of Row Address Bits (SDRAM only) 13
Number of Col Address Bits (SDRAM only) 10
Number of Module Rows   2
Data Width (SDRAM only) 72
Module Interface Signal Levels  SSTL 2.5
Cycle Time (SDRAM) highest CAS latency  7.5ns
Maximum module speed    DDR 266MHz (PC2100)
Access Time (SDRAM)     7.5ns
Module Configuration Type       ECC
Refresh Type    Self Refreshing
Refresh Rate    Reduced (7.8uS)
Primary SDRAM Component Bank Config     No Bank2 OR Bank2 = Bank1 width
Primary SDRAM Component Widths  8
Error Checking SDRAM Component Bank Config      No Bank2 OR Bank2 = Bank1 
width
Error Checking SDRAM Component Widths   8
Min Clock Delay for Back to Back Random Access  1

---== The Following Apply to SDRAM DIMMs ONLY ==---
Burst lengths supported Burst Length = 2
                Burst Length = 4
                Burst Length = 8

Number of Device Banks  4
Supported CAS Latencies CAS Latency = 3
                CAS Latency = 4

Supported CS Latencies  CS Latency = 0

Supported WE Latencies  WE Latency = 1

SDRAM Module Attributes Differential Clock Input

SDRAM Device Attributes (General)       Lower VCC Tolerance:10%
                Upper VCC Tolerance:10%

SDRAM Cycle Time (2nd highest CAS)      10nS
SDRAM Access from Clock Time (2nd highest CAS)  7.5nS

---== The Following are Optional (may be Bogus) ==---
SDRAM Cycle Time (3rd highest CAS)      Undefined!
SDRAM Access from Clock Time (3rd highest CAS)  Undefined!

---== The Following are Required (for SDRAMs) ==---
Minimum Row Precharge Time      80nS
Row Active to Row Active Min    60nS
RAS to CAS Delay        80nS
Min RAS Pulse Width     45nS

---== The Following are Required and Apply to ALL DIMMs ==---
Row Densities   256 MByte


---== The Following are Proposed and Apply to SDRAM DIMMs ==---
Command and Address Signal Setup Time   -1nS
Command and Address Signal Hold Time    -1nS
Data Signal Setup Time  5nS
Data Signal Hold Time   5nS
SPD Revision code       0
EEPROM Checksum of bytes 0-62   OK (0xD2)
Manufacturer's JEDEC ID Code    0x7F98000000000000

Manufacturer's JEDEC ID Code    (")
Manufacturing Location Code     0x00

Manufacurer's Part Number       KVR266X72C25/512
Revision Code   0x0000

Manufacturing Date      0x0429

Intel Specification for Frequency       Undefined!

Intel Spec Details for 100MHz Support   Junction Temp B (100 degrees C)
                Single Sided DIMM

Decoding EEPROM /sys/bus/i2c/drivers/eeprom/0-0051
Guessing DIMM is in     bank 2

---== The Following is Required Data and is Applicable to all DIMM Types 
==---
# of bytes written to SDRAM EEPROM      128
Total number of bytes in EEPROM 256
Fundamental Memory type DDR SDRAM
Number of Row Address Bits (SDRAM only) 13
Number of Col Address Bits (SDRAM only) 10
Number of Module Rows   1
Data Width (SDRAM only) 64
Module Interface Signal Levels  SSTL 2.5
Cycle Time (SDRAM) highest CAS latency  7ns
Maximum module speed    DDR 285MHz (PC2200)
Access Time (SDRAM)     7.5ns
Module Configuration Type       No Parity
Refresh Type    Self Refreshing
Refresh Rate    Reduced (7.8uS)
Primary SDRAM Component Bank Config     No Bank2 OR Bank2 = Bank1 width
Primary SDRAM Component Widths  8
Error Checking SDRAM Component Bank Config      No Bank2 OR Bank2 = Bank1 
width
Error Checking SDRAM Component Widths   Undefined!
Min Clock Delay for Back to Back Random Access  1

---== The Following Apply to SDRAM DIMMs ONLY ==---
Burst lengths supported Burst Length = 2
                Burst Length = 4
                Burst Length = 8

Number of Device Banks  4
Supported CAS Latencies CAS Latency = 3
                CAS Latency = 4

Supported CS Latencies  CS Latency = 0

Supported WE Latencies  WE Latency = 1

SDRAM Module Attributes Differential Clock Input

SDRAM Device Attributes (General)       Lower VCC Tolerance:10%
                Upper VCC Tolerance:10%

SDRAM Cycle Time (2nd highest CAS)      7.5nS
SDRAM Access from Clock Time (2nd highest CAS)  7.5nS

---== The Following are Optional (may be Bogus) ==---
SDRAM Cycle Time (3rd highest CAS)      Undefined!
SDRAM Access from Clock Time (3rd highest CAS)  Undefined!

---== The Following are Required (for SDRAMs) ==---
Minimum Row Precharge Time      80nS
Row Active to Row Active Min    60nS
RAS to CAS Delay        80nS
Min RAS Pulse Width     45nS

---== The Following are Required and Apply to ALL DIMMs ==---
Row Densities   256 MByte


---== The Following are Proposed and Apply to SDRAM DIMMs ==---
Command and Address Signal Setup Time   -1nS
Command and Address Signal Hold Time    -1nS
Data Signal Setup Time  5nS
Data Signal Hold Time   5nS
SPD Revision code       0
EEPROM Checksum of bytes 0-62   OK (0x8F)
Manufacturer's JEDEC ID Code    0x7F7F7F0B00000000

Manufacturer's JEDEC ID Code
                               ")
Manufacturing Location Code     0x01

Manufacurer's Part Number       NT256D64S88AAG-7K
Revision Code   0x0000

Manufacturing Date      0x022F

Intel Specification for Frequency       Undefined!

Intel Spec Details for 100MHz Support   Junction Temp B (100 degrees C)
                Single Sided DIMM

Decoding EEPROM /sys/bus/i2c/drivers/eeprom/0-0052
Guessing DIMM is in     bank 3

---== The Following is Required Data and is Applicable to all DIMM Types 
==---
# of bytes written to SDRAM EEPROM      128
Total number of bytes in EEPROM 256
Fundamental Memory type DDR SDRAM
Number of Row Address Bits (SDRAM only) 13
Number of Col Address Bits (SDRAM only) 10
Number of Module Rows   1
Data Width (SDRAM only) 64
Module Interface Signal Levels  SSTL 2.5
Cycle Time (SDRAM) highest CAS latency  6ns
Maximum module speed    DDR 333MHz (PC2600)
Access Time (SDRAM)     7ns
Module Configuration Type       No Parity
Refresh Type    Self Refreshing
Refresh Rate    Reduced (7.8uS)
Primary SDRAM Component Bank Config     No Bank2 OR Bank2 = Bank1 width
Primary SDRAM Component Widths  8
Error Checking SDRAM Component Bank Config      No Bank2 OR Bank2 = Bank1 
width
Error Checking SDRAM Component Widths   Undefined!
Min Clock Delay for Back to Back Random Access  1

---== The Following Apply to SDRAM DIMMs ONLY ==---
Burst lengths supported Burst Length = 2
                Burst Length = 4
                Burst Length = 8

Number of Device Banks  4
Supported CAS Latencies CAS Latency = 3
                CAS Latency = 4

Supported CS Latencies  CS Latency = 0

Supported WE Latencies  WE Latency = 1

SDRAM Module Attributes Differential Clock Input

SDRAM Device Attributes (General)       Lower VCC Tolerance:10%
                Upper VCC Tolerance:10%
                Undefined (bit 6)
                Undefined (bit 7)

SDRAM Cycle Time (2nd highest CAS)      7.5nS
SDRAM Access from Clock Time (2nd highest CAS)  7nS

---== The Following are Optional (may be Bogus) ==---
SDRAM Cycle Time (3rd highest CAS)      Undefined!
SDRAM Access from Clock Time (3rd highest CAS)  Undefined!

---== The Following are Required (for SDRAMs) ==---
Minimum Row Precharge Time      72nS
Row Active to Row Active Min    48nS
RAS to CAS Delay        72nS
Min RAS Pulse Width     42nS

---== The Following are Required and Apply to ALL DIMMs ==---
Row Densities   256 MByte


---== The Following are Proposed and Apply to SDRAM DIMMs ==---
Command and Address Signal Setup Time   7.5nS
Command and Address Signal Hold Time    7.5nS
Data Signal Setup Time  4.5nS
Data Signal Hold Time   4.5nS
SPD Revision code       0
EEPROM Checksum of bytes 0-62   OK (0x00)
Manufacturer's JEDEC ID Code    0x0000000000000000

Manufacturer's JEDEC ID Code    ("")
Manufacturing Location Code     0x00

Manufacurer's Part Number
Revision Code   0x0000

Manufacturing Date      0x0000

Intel Specification for Frequency       Undefined!

Intel Spec Details for 100MHz Support   Junction Temp B (100 degrees C)
                Single Sided DIMM

Number of SDRAM DIMMs detected and decoded      3

Try './decode-dimms.pl --format' for html output.
[root@andeya1 /]#




