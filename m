From: ondrej.cecak@centrum.cz (Ondrej Cecak)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: ne1619 (really almost solved)
Message-Id: <200307292322.53518.ondrej.cecak@centrum.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dne ?t 29. ?ervence 2003 21:57 jste napsal(a):
> > eeprom-i2c-0-50
> > Adapter: SMBus I801 adapter at efa0
> > Algorithm: Non-I2C SMBus adapter
> > Unknown EEPROM type (1)
> >
> > eeprom-i2c-0-51
> > Adapter: SMBus I801 adapter at efa0
> > Algorithm: Non-I2C SMBus adapter
> > Unknown EEPROM type (1)
>
> Hey, this isn't working as intended! (When will I leave you alone, you
> must be thinking.) You must have a special kind of memory chips we don't
> support yet. Could you please run the prog/eeprom/decode-dimms.pl? Also,
> a dump of one of your eeproms would be appreciated (unload the eeprom
> module, and run "i2cdump 0 0x50"). Thanks!

all right, full output of decode-dimms.pl:





PC DIMM Serial Presence Detect Tester/Decoder
By Philip Edelbrock, Christian Zuckschwerdt and others
Version 2.6.6

Decoding EEPROM  /proc/sys/dev/sensors/eeprom-i2c-0-50
Guessing DIMM is in     bank 1

---== The Following is Required Data and is Applicable to all DIMM Types 
==---
# of bytes written to SDRAM EEPROM      2
Total number of bytes in EEPROM 256
Fundamental Memory type ???
Number of Row Address Bits (SDRAM only) 1/16
Number of Col Address Bits (SDRAM only) 151
Number of Module Rows   197
Data Width (SDRAM only) Undefined!
Module Interface Signal Levels  HSTL 1.5
Cycle Time (SDRAM) highest CAS latency  0.5ns
Access Time (SDRAM)     0.8ns
Module Configuration Type       Undefined!
Refresh Type    Not Self Refreshing
Refresh Rate    Undefined!
Primary SDRAM Component Bank Config     No Bank2 OR Bank2 = Bank1 width
Primary SDRAM Component Widths  8
Error Checking SDRAM Component Bank Config      No Bank2 OR Bank2 = Bank1 
width
Error Checking SDRAM Component Widths   8
Min Clock Delay for Back to Back Random Access  19

---== The Following Apply to SDRAM DIMMs ONLY ==---
Burst lengths supported Burst Length = 2
                Burst Length = 4
                Burst Length = 8
                Undefined! (bit 4)

Number of Device Banks  89
Supported CAS Latencies CAS Latency = 2
                CAS Latency = 4
                CAS Latency = 6
                Undefined (bit 7)

Supported CS Latencies  (None Supported)

Supported WE Latencies  (None Supported)

SDRAM Module Attributes (None Reported)

SDRAM Device Attributes (General)       Lower VCC Tolerance:10%
                Upper VCC Tolerance:10%

SDRAM Cycle Time (2nd highest CAS)      Undefined!
SDRAM Access from Clock Time (2nd highest CAS)  Undefined!

---== The Following are Optional (may be Bogus) ==---
SDRAM Cycle Time (3rd highest CAS)      Undefined!
SDRAM Access from Clock Time (3rd highest CAS)  Undefined!

---== The Following are Required (for SDRAMs) ==---
Minumum Row Precharge Time      Undefined!
Row Active to Row Active Min    Undefined!
RAS to CAS Delay        Undefined!
Min RAS Pulse Width     Undefined!

---== The Following are Required and Apply to ALL DIMMs ==---
Row Densities   16 MByte


---== The Following are Proposed and Apply to SDRAM DIMMs ==---
Command and Address Signal Setup Time   -1.3nS
Command and Address Signal Hold Time    3.2nS
Data Signal Setup Time  2.8nS
Data Signal Hold Time   1.1nS
SPD Revision code       0
EEPROM Checksum of bytes 0-62   OK (0x09)
Manufacturer's JEDEC ID Code    0xCE59414858423030

Manufacturer's JEDEC ID Code    ("?YAHXB00")
Manufacturing Location Code     0x01

Manufacurer's Part Number       MR16R 1628AF0-CK8
Revision Code   0x3041

Manufacturing Date      0x6621

Intel Specification for Frequency       Undefined!

Intel Spec Details for 100MHz Support   Junction Temp B (100 degrees C)
                CLK 2 Connected
                CLK 0 Connected
                Single Sided DIMM

Decoding EEPROM  /proc/sys/dev/sensors/eeprom-i2c-0-51
Guessing DIMM is in     bank 2

---== The Following is Required Data and is Applicable to all DIMM Types 
==---
# of bytes written to SDRAM EEPROM      2
Total number of bytes in EEPROM 256
Fundamental Memory type ???
Number of Row Address Bits (SDRAM only) 1/16
Number of Col Address Bits (SDRAM only) 151
Number of Module Rows   197
Data Width (SDRAM only) Undefined!
Module Interface Signal Levels  HSTL 1.5
Cycle Time (SDRAM) highest CAS latency  0.5ns
Access Time (SDRAM)     0.8ns
Module Configuration Type       Undefined!
Refresh Type    Not Self Refreshing
Refresh Rate    Undefined!
Primary SDRAM Component Bank Config     No Bank2 OR Bank2 = Bank1 width
Primary SDRAM Component Widths  8
Error Checking SDRAM Component Bank Config      No Bank2 OR Bank2 = Bank1 
width
Error Checking SDRAM Component Widths   8
Min Clock Delay for Back to Back Random Access  19

---== The Following Apply to SDRAM DIMMs ONLY ==---
Burst lengths supported Burst Length = 2
                Burst Length = 4
                Burst Length = 8
                Undefined! (bit 4)

Number of Device Banks  89
Supported CAS Latencies CAS Latency = 2
                CAS Latency = 4
                CAS Latency = 6
                Undefined (bit 7)

Supported CS Latencies  (None Supported)

Supported WE Latencies  (None Supported)

SDRAM Module Attributes (None Reported)

SDRAM Device Attributes (General)       Lower VCC Tolerance:10%
                Upper VCC Tolerance:10%

SDRAM Cycle Time (2nd highest CAS)      Undefined!
SDRAM Access from Clock Time (2nd highest CAS)  Undefined!

---== The Following are Optional (may be Bogus) ==---
SDRAM Cycle Time (3rd highest CAS)      Undefined!
SDRAM Access from Clock Time (3rd highest CAS)  Undefined!

---== The Following are Required (for SDRAMs) ==---
Minumum Row Precharge Time      Undefined!
Row Active to Row Active Min    Undefined!
RAS to CAS Delay        Undefined!
Min RAS Pulse Width     Undefined!

---== The Following are Required and Apply to ALL DIMMs ==---
Row Densities   16 MByte


---== The Following are Proposed and Apply to SDRAM DIMMs ==---
Command and Address Signal Setup Time   -1.3nS
Command and Address Signal Hold Time    3.2nS
Data Signal Setup Time  2.8nS
Data Signal Hold Time   1.1nS
SPD Revision code       0
EEPROM Checksum of bytes 0-62   OK (0x09)
Manufacturer's JEDEC ID Code    0xCE59414858423030

Manufacturer's JEDEC ID Code    ("?YAHXB00")
Manufacturing Location Code     0x01

Manufacurer's Part Number       MR16R 1628AF0-CK8
Revision Code   0x3041

Manufacturing Date      0x6621

Intel Specification for Frequency       Undefined!

Intel Spec Details for 100MHz Support   Junction Temp B (100 degrees C)
                CLK 2 Connected
                CLK 0 Connected
                Single Sided DIMM

Number of SDRAM DIMMs detected and decoded      2






btw: is possible send emails with attachment to sensors@...?
btw2: something about my memory:

PC 800 RIMM for intel desktop boards D850EMV2 and D850EMD2

http://developer.intel.com/technology/memory/rdram/valid/rmvalid.htm
http://developer.intel.com/design/motherbd/mv2/mv2_mem.htm

i2cdump of 0 0x50:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 02 08 01 01 97 c5 05 20 02 05 08 14 0a 08 08 13    ??????? ????????
10: 1e 59 aa 00 00 00 00 00 00 00 00 00 00 00 00 04    ?Y?............?
20: 8d 32 28 11 05 90 00 64 64 96 40 0a 66 55 5d 00    ?2(???.dd?@?fU].
30: 00 00 01 90 24 9c 50 3c 4d 28 1e 2a 20 00 00 09    ..??$?P<M(?* ..?
40: ce 59 41 48 58 42 30 30 01 4d 52 31 36 52 20 31    ?YAHXB00?MR16R 1
50: 36 32 38 41 46 30 2d 43 4b 38 00 30 41 66 21 fa    628AF0-CK8.0Af!?
60: 10 fd 00 08 10 ff 00 00 00 10 52 00 00 00 00 00    ??.??....?R.....
70: 00 00 00 00 30 31 32 42 52 00 00 00 00 00 00 a0    ....012BR......?
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

good night ...
-- 
Ondrej Cecak

