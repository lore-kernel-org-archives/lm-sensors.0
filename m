From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Linux 2.6.0-test11 and lm_sensors 2.8.2
Message-Id: <3FDB43D8.DDCA2D7@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200312131634.hBDGYrix013282@twopit.underworld>
In-Reply-To: <200312131634.hBDGYrix013282@twopit.underworld>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

that's right, eeproms are not supported yet


Chris Rankin wrote:
> 
> Hi,
> 
> I am having trouble using the lm_sensors 2.8.2 user tools with the
> 2.6.0-test11 kernel. My machine has 2 built-in LM87 chips and 2 SDRAM
> EEPROMs, all of which worked fine under Linux 2.4.
> 
> The new 2.8.2 sensors tools are refusing to recognise my EEPROMs:
> 
> $ sensors
> eeprom-i2c-0-52
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Unavailable from sysfs
> Memory type: Unavailable
> 
> eeprom-i2c-0-50
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Unavailable from sysfs
> Memory type: Unavailable
> 
> (I haven't found a Linux 2.6 version of the lm87 driver yet, so I'm
> only using the eeprom driver right now.) The first problem seems to be
> that lib/chips.c does not set the "sysname" field in the lib/chips.c
> file, and so tries to open the file
> 
> "/sys/bus/i2c/devices/<number>/Memory type"
> 
> This file obiously doesn't exist, and I have fixed this by setting the
> "sysname" field to "eeprom":
> 
> static sensors_chip_feature eeprom_features[] >   {
>     { SENSORS_EEPROM_TYPE, "Memory type",
>                          NOMAP, NOMAP,
>                          R, EEPROM_SYSCTL1, VALUE(3), 0, "eeprom" },
> 
> However, things still don't work after I do this:
> 
> # prog/sensors/sensors
> eeprom-i2c-0-52
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Unavailable from sysfs
> Memory type:            EDO
> ERROR: data 2
> 
> eeprom-i2c-0-50
> Adapter: SMBus I801 adapter at efa0
> Algorithm: Unavailable from sysfs
> Unknown EEPROM type (-1)
> 
> For reference, both these EEPROMs are 512 MB SDRAM, PC100, 168 pin,
> 3.3V. Here is the data read from linux 2.4:
> 
> =================================> PC DIMM Serial Presence Detect Tester/Decoder
> Written by Philip Edelbrock.  Copyright 1998, 1999.
> Modified by Christian Zuckschwerdt <zany@triq.net>
> Version 2.6.3
> 
> Decoding EEPROM /proc/sys/dev/sensors/eeprom-i2c-0-50
> Guessing DIMM is in     bank 1
> 
> ---== The Following is Required Data and is Applicable to all DIMM Types ==---
> # of bytes written to SDRAM EEPROM      128
> Total number of bytes in EEPROM 256
> Fundemental Memory type SDRAM
> Number of Row Address Bits (SDRAM only) 13
> Number of Col Address Bits (SDRAM only) 10
> Number of Module Rows   2
> Data Width (SDRAM only) 64
> Module Interface Signal Levels  LVTTL
> Cycle Time (SDRAM) highest CAS latency  7.5ns
> Access Time (SDRAM)     5.4ns
> Module Configuration Type       No Parity
> Refresh Type    Self Refreshing
> Refresh Rate    Reduced (7.8uS)
> Primary SDRAM Component Bank Config     No Bank2 OR Bank2 = Bank1 width
> Primary SDRAM Component Widths  8
> Error Checking SDRAM Component Bank Config      No Bank2 OR Bank2 = Bank1 width
> Error Checking SDRAM Component Widths   Undefined!
> Min Clock Delay for Back to Back Random Access  1
> 
> ---== The Following Apply to SDRAM DIMMs ONLY ==---
> Burst lengths supported Burst Length = 1
>                 Burst Length = 2
>                 Burst Length = 4
>                 Burst Length = 8
> 
> Number of Device Banks  4
> Supported CAS Latencies CAS Latency = 2
>                 CAS Latency = 3
> 
> Supported CS Latencies  CS Latency = 0
> 
> Supported WE Latencies  WE Latency = 0
> 
> SDRAM Module Attributes (None Reported)
> 
> SDRAM Device Attributes (General)       Supports Auto-Precharge
>                 Supports Precharge All
>                 Supports Write1/Read Burst
>                 Lower VCC Tolerance:10%
>                 Upper VCC Tolerance:10%
> 
> SDRAM Cycle Time (2nd highest CAS)      10nS
> SDRAM Access from Clock Time (2nd highest CAS)  6nS
> 
> ---== The Following are Optional (may be Bogus) ==---
> SDRAM Cycle Time (3rd highest CAS)      63.75nS
> SDRAM Access from Clock Time (3rd highest CAS)  63.75nS
> 
> ---== The Following are Required (for SDRAMs) ==---
> Minumum Row Precharge Time      20nS
> Row Active to Row Active Min    15nS
> RAS to CAS Delay        20nS
> Min RAS Pulse Width     45nS
> 
> ---== The Following are Required and Apply to ALL DIMMs ==---
> Row Densities   256 MByte
> 
> 
> ---== The Following are Proposed and Apply to SDRAM DIMMs ==---
> Command and Address Signal Setup Time   1.5nS
> Command and Address Signal Hold Time    0.8nS
> Data Signal Setup Time  1.5nS
> Data Signal Hold Time   0.8nS
> SPD Revision code       12
> EEPROM Checksum of bytes 0-62   0x37 (verses calculated: 0x37)
> 
> Manufacturer's JEDEC ID Code    0xC1494E46494E454F
> 
> Manufacturer's JEDEC ID Code    ("?INFINEO")
> Manufacturing Location Code     0x56
> 
> Manufacurer's Part Number:"     HYS64V64220GU-7.5
> Revision Code   0xFF03
> 
> Manufacturing Date      0x5002
> 
> Intel Specification for Frequency       100MHz
> 
> Intel Spec Details for 100MHz Support   Intel Concurrent AutoPrecharge
>                 CAS Latency = 2
>                 CAS Latency = 3
>                 Junction Temp A (90 degrees C)
>                 CLK 3 Connected
>                 CLK 2 Connected
>                 CLK 1 Connected
>                 CLK 0 Connected
>                 Double Sided DIMM
> 
> Decoding EEPROM /proc/sys/dev/sensors/eeprom-i2c-0-52
> Guessing DIMM is in     bank 3
> 
> ---== The Following is Required Data and is Applicable to all DIMM Types ==---
> # of bytes written to SDRAM EEPROM      128
> Total number of bytes in EEPROM 256
> Fundemental Memory type SDRAM
> Number of Row Address Bits (SDRAM only) 13
> Number of Col Address Bits (SDRAM only) 10
> Number of Module Rows   2
> Data Width (SDRAM only) 64
> Module Interface Signal Levels  LVTTL
> Cycle Time (SDRAM) highest CAS latency  7.5ns
> Access Time (SDRAM)     5.4ns
> Module Configuration Type       No Parity
> Refresh Type    Self Refreshing
> Refresh Rate    Reduced (7.8uS)
> Primary SDRAM Component Bank Config     No Bank2 OR Bank2 = Bank1 width
> Primary SDRAM Component Widths  8
> Error Checking SDRAM Component Bank Config      No Bank2 OR Bank2 = Bank1 width
> Error Checking SDRAM Component Widths   Undefined!
> Min Clock Delay for Back to Back Random Access  1
> 
> ---== The Following Apply to SDRAM DIMMs ONLY ==---
> Burst lengths supported Burst Length = 1
>                 Burst Length = 2
>                 Burst Length = 4
>                 Burst Length = 8
> 
> Number of Device Banks  4
> Supported CAS Latencies CAS Latency = 2
>                 CAS Latency = 3
> 
> Supported CS Latencies  CS Latency = 0
> 
> Supported WE Latencies  WE Latency = 0
> 
> SDRAM Module Attributes (None Reported)
> 
> SDRAM Device Attributes (General)       Supports Auto-Precharge
>                 Supports Precharge All
>                 Supports Write1/Read Burst
>                 Lower VCC Tolerance:10%
>                 Upper VCC Tolerance:10%
> 
> SDRAM Cycle Time (2nd highest CAS)      10nS
> SDRAM Access from Clock Time (2nd highest CAS)  6nS
> 
> ---== The Following are Optional (may be Bogus) ==---
> SDRAM Cycle Time (3rd highest CAS)      63.75nS
> SDRAM Access from Clock Time (3rd highest CAS)  63.75nS
> 
> ---== The Following are Required (for SDRAMs) ==---
> Minumum Row Precharge Time      20nS
> Row Active to Row Active Min    15nS
> RAS to CAS Delay        20nS
> Min RAS Pulse Width     45nS
> 
> ---== The Following are Required and Apply to ALL DIMMs ==---
> Row Densities   256 MByte
> 
> 
> ---== The Following are Proposed and Apply to SDRAM DIMMs ==---
> Command and Address Signal Setup Time   1.5nS
> Command and Address Signal Hold Time    0.8nS
> Data Signal Setup Time  1.5nS
> Data Signal Hold Time   0.8nS
> SPD Revision code       12
> EEPROM Checksum of bytes 0-62   0x37 (verses calculated: 0x37)
> 
> Manufacturer's JEDEC ID Code    0xC1494E46494E454F
> 
> Manufacturer's JEDEC ID Code    ("?INFINEO")
> Manufacturing Location Code     0x56
> 
> Manufacurer's Part Number:"     HYS64V64220GU-7.5
> Revision Code   0xFF03
> 
> Manufacturing Date      0x5002
> 
> Intel Specification for Frequency       100MHz
> 
> Intel Spec Details for 100MHz Support   Intel Concurrent AutoPrecharge
>                 CAS Latency = 2
>                 CAS Latency = 3
>                 Junction Temp A (90 degrees C)
>                 CLK 3 Connected
>                 CLK 2 Connected
>                 CLK 1 Connected
>                 CLK 0 Connected
>                 Double Sided DIMM
> 
> Number of SDRAM DIMMs detected and decoded      2
> 
> Try '/usr/src/lm_sensors-2.6.5/prog/eeprom/decode-dimms.pl --format' for html output.
