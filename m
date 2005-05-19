From: ondrej.cecak@centrum.cz (Ondrej Cecak)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: ne1619 (really almost solved)
Message-Id: <200307302008.04999.ondrej.cecak@centrum.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307292322.53518.ondrej.cecak@centrum.cz>
In-Reply-To: <200307292322.53518.ondrej.cecak@centrum.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dne st 30. ?ervence 2003 19:50 jste napsal(a):
> No reboot is necessary. The time I asked you to reboot was very
> particular (because some value set by your bios had to be preserved and
> had been overwritten once).

OK, great :o)

> > PC DIMM Serial Presence Detect Tester/Decoder
> > By Philip Edelbrock, Christian Zuckschwerdt and others
> > Version 2.6.6
> >
> > Number of SDRAM DIMMs detected and decoded      0
>
> Hm, strange. It should output values (with many bad values, but output
> anyway). Are you sure the eeprom module was loaded at the time you ran
> this?

my mistake - I thouht, that eeprom must be unloaded.
Full output is in attachement.

> > eeprom-i2c-0-50
> > Adapter: SMBus I801 adapter at efa0
> > Algorithm: Non-I2C SMBus adapter
> > Memory type:            DRDRAM RIMM
> > Memory size (MB):       256
> >
> > eeprom-i2c-0-51
> > Adapter: SMBus I801 adapter at efa0
> > Algorithm: Non-I2C SMBus adapter
> > Memory type:            DRDRAM RIMM
> > Memory size (MB):       256
>
> That's great.
>
> > btw: maybe one more small mistake in new driver ne1619, values of SYS
> > and CPU temp looks like changed. e.g. if I run "yes > /dev/null" and
> > load of CPU is 100%:
> >
> > SYS Temp:  +49.0?C  (min =   +5?C, max =  +65?C)
> > CPU Temp:  +43.0?C  (min =   +5?C, max =  +65?C)
>
> This is normal, I swapped both while modifying the script (for some
> coding convenience reason). You must use the new sensors.conf file in
> order to get correct labels.

all right, thanks.
-- 
Ondrej Cecak
-------------- next part --------------


PC DIMM Serial Presence Detect Tester/Decoder
By Philip Edelbrock, Christian Zuckschwerdt and others
Version 2.6.6

Decoding EEPROM	 /proc/sys/dev/sensors/eeprom-i2c-0-50
Guessing DIMM is in	bank 1

---== The Following is Required Data and is Applicable to all DIMM Types ==---
# of bytes written to SDRAM EEPROM	2
Total number of bytes in EEPROM	256
Fundamental Memory type	Direct Rambus [UNSUPPORTED]
Number of Row Address Bits (SDRAM only)	1/16
Number of Col Address Bits (SDRAM only)	151
Number of Module Rows	197
Data Width (SDRAM only)	Undefined!
Module Interface Signal Levels	HSTL 1.5
Cycle Time (SDRAM) highest CAS latency	0.5ns
Access Time (SDRAM)	0.8ns
Module Configuration Type	Undefined!
Refresh Type	Not Self Refreshing
Refresh Rate	Undefined!
Primary SDRAM Component Bank Config	No Bank2 OR Bank2 = Bank1 width
Primary SDRAM Component Widths	8
Error Checking SDRAM Component Bank Config	No Bank2 OR Bank2 = Bank1 width
Error Checking SDRAM Component Widths	8
Min Clock Delay for Back to Back Random Access	19

---== The Following Apply to SDRAM DIMMs ONLY ==---
Burst lengths supported	Burst Length = 2
		Burst Length = 4
		Burst Length = 8
		Undefined! (bit 4)
		
Number of Device Banks	89
Supported CAS Latencies	CAS Latency = 2
		CAS Latency = 4
		CAS Latency = 6
		Undefined (bit 7)
		
Supported CS Latencies	(None Supported)
		
Supported WE Latencies	(None Supported)
		
SDRAM Module Attributes	(None Reported)
		
SDRAM Device Attributes (General)	Lower VCC Tolerance:10%
		Upper VCC Tolerance:10%
		
SDRAM Cycle Time (2nd highest CAS)	Undefined!
SDRAM Access from Clock Time (2nd highest CAS)	Undefined!

---== The Following are Optional (may be Bogus) ==---
SDRAM Cycle Time (3rd highest CAS)	Undefined!
SDRAM Access from Clock Time (3rd highest CAS)	Undefined!

---== The Following are Required (for SDRAMs) ==---
Minumum Row Precharge Time	Undefined!
Row Active to Row Active Min	Undefined!
RAS to CAS Delay	Undefined!
Min RAS Pulse Width	Undefined!

---== The Following are Required and Apply to ALL DIMMs ==---
Row Densities	16 MByte
		

---== The Following are Proposed and Apply to SDRAM DIMMs ==---
Command and Address Signal Setup Time	-1.3nS
Command and Address Signal Hold Time	3.2nS
Data Signal Setup Time	2.8nS
Data Signal Hold Time	1.1nS
SPD Revision code 	0
EEPROM Checksum of bytes 0-62	OK (0x09)
Manufacturer's JEDEC ID Code	0xCE59414858423030
		
Manufacturer's JEDEC ID Code	("?YAHXB00")
Manufacturing Location Code	0x01
		
Manufacurer's Part Number	MR16R 1628AF0-CK8
Revision Code	0x3041
		
Manufacturing Date	0x6621
		
Intel Specification for Frequency	Undefined!
		
Intel Spec Details for 100MHz Support	Junction Temp B (100 degrees C)
		CLK 2 Connected
		CLK 0 Connected
		Single Sided DIMM
		
Decoding EEPROM	 /proc/sys/dev/sensors/eeprom-i2c-0-51
Guessing DIMM is in	bank 2

---== The Following is Required Data and is Applicable to all DIMM Types ==---
# of bytes written to SDRAM EEPROM	2
Total number of bytes in EEPROM	256
Fundamental Memory type	Direct Rambus [UNSUPPORTED]
Number of Row Address Bits (SDRAM only)	1/16
Number of Col Address Bits (SDRAM only)	151
Number of Module Rows	197
Data Width (SDRAM only)	Undefined!
Module Interface Signal Levels	HSTL 1.5
Cycle Time (SDRAM) highest CAS latency	0.5ns
Access Time (SDRAM)	0.8ns
Module Configuration Type	Undefined!
Refresh Type	Not Self Refreshing
Refresh Rate	Undefined!
Primary SDRAM Component Bank Config	No Bank2 OR Bank2 = Bank1 width
Primary SDRAM Component Widths	8
Error Checking SDRAM Component Bank Config	No Bank2 OR Bank2 = Bank1 width
Error Checking SDRAM Component Widths	8
Min Clock Delay for Back to Back Random Access	19

---== The Following Apply to SDRAM DIMMs ONLY ==---
Burst lengths supported	Burst Length = 2
		Burst Length = 4
		Burst Length = 8
		Undefined! (bit 4)
		
Number of Device Banks	89
Supported CAS Latencies	CAS Latency = 2
		CAS Latency = 4
		CAS Latency = 6
		Undefined (bit 7)
		
Supported CS Latencies	(None Supported)
		
Supported WE Latencies	(None Supported)
		
SDRAM Module Attributes	(None Reported)
		
SDRAM Device Attributes (General)	Lower VCC Tolerance:10%
		Upper VCC Tolerance:10%
		
SDRAM Cycle Time (2nd highest CAS)	Undefined!
SDRAM Access from Clock Time (2nd highest CAS)	Undefined!

---== The Following are Optional (may be Bogus) ==---
SDRAM Cycle Time (3rd highest CAS)	Undefined!
SDRAM Access from Clock Time (3rd highest CAS)	Undefined!

---== The Following are Required (for SDRAMs) ==---
Minumum Row Precharge Time	Undefined!
Row Active to Row Active Min	Undefined!
RAS to CAS Delay	Undefined!
Min RAS Pulse Width	Undefined!

---== The Following are Required and Apply to ALL DIMMs ==---
Row Densities	16 MByte
		

---== The Following are Proposed and Apply to SDRAM DIMMs ==---
Command and Address Signal Setup Time	-1.3nS
Command and Address Signal Hold Time	3.2nS
Data Signal Setup Time	2.8nS
Data Signal Hold Time	1.1nS
SPD Revision code 	0
EEPROM Checksum of bytes 0-62	OK (0x09)
Manufacturer's JEDEC ID Code	0xCE59414858423030
		
Manufacturer's JEDEC ID Code	("?YAHXB00")
Manufacturing Location Code	0x01
		
Manufacurer's Part Number	MR16R 1628AF0-CK8
Revision Code	0x3041
		
Manufacturing Date	0x6621
		
Intel Specification for Frequency	Undefined!
		
Intel Spec Details for 100MHz Support	Junction Temp B (100 degrees C)
		CLK 2 Connected
		CLK 0 Connected
		Single Sided DIMM
		
Number of SDRAM DIMMs detected and decoded	2

Try './decode-dimms.pl --format' for html output.
