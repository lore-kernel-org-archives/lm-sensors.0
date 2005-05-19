From: xuan--sensors--2003.12.20@baldauf.org (Xuan Baldauf)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Hidden and disabled SMBus SiS0016, please enable
Message-Id: <3FE4DB3C.8050504@baldauf.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Alex and Mark,

I'm referring to your discussions at 
http://archives.andrew.net.au/lm-sensors/msg01299.html

I have got a new notebook "Mitac 8640m". (The same as in 
http://archives.andrew.net.au/lm-sensors/msg03881.html ) It is based on 
a SiS645DX ("SiS646") northbridge and a SiS962 southbridge. There is a 
SMBus device 1039:0016 from SiS, but the BIOS (which does not seem very 
usable) seems to hide that device. (See 
http://archives.andrew.net.au/lm-sensors/msg01872.html ).

    * When using Linux 2.6, the device is unhidden at boot (
      http://archives.andrew.net.au/lm-sensors/msg02573.html ).
    * Under Linux 2.4, i2c-sis645 seems to unhide it (but not for the
      kernel, "lspci" won't show it, but "lspci -H1" will show it).
    * Under Windows, MBM seems to unhide it.

Unfortunately, the I/O-ports will not be enabled,

    * neither under Windows using MBM 5.3.5.0
    * nor under Linux 2.6 using i2c-sis96x (Linux 2.6.0)
    * nor under Linux 2.4 using i2c-sis645 (lm-sensors 2.8.2).

I can verify this by looking at the PCI config space word at byte offset 
0x04 ("PCI_COMMAND", see 
http://lxr.linux.no/source/include/linux/pci.h?v=2.6.0#L28 ).  For I/O 
ports being enabled bit 0 (PCI_COMMAND_IO) has to be set. This is not 
the case:

<MBM PCI Dump>
Bus :00 Device :02 Func :01 Vendor :1039 Device ID :0016

  $0000:  39 10 16 00 00 00 80 02 00 00 05 0C 00 00 00 00
</MBM PCI Dump>

Under Linux 2.4 and Linux 2.6, I can try to manually set 
PCI_COMMAND=0x01. This works, so that then modules "i2c-sis96x" and 
"i2c-sis645" respectively can be loaded.

    * But under Linux 2.6, "i2cdetect 0" returns only "XX" results and
      is pretty slow. I enabled the "#define DEBUG" in the sourcecode if
      "i2c-sis96x" and saw that every request to the SMBus times out.
    * Under Linux 2.4, "i2cdetect 0" or "sensors" crashes with a
      (recoverable) kernel oops

Under Windows, the pci device actually cannot be enabled manually (after 
running MBM 5, device manager will recognize an "SM-Bus-Controller", but 
I cannot find a driver for that device). When running "SMB Dump" in MBM, 
I get this:


------MBM SMB DUMP-------

SMB SiS0016 via SiS0008 @ $0000

SMBus Register :$10
  $0000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  $0010:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  $0020:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[...only zeros...]


So it seems that I'm missing something when manually enabling the 
device. MBM 5.3.5.0 also seems to misidentify the device (SiS5595 
instead of SiS962) and base I/O port address (the I/O-port-space of the 
SMBus device is at 0x1080).

So I'm asking you (Alex and Mark) wether it is possible to enable the 
device not just by unhiding it, but also by enabling I/O-ports and other 
stuff I'm not familiar with so that the SMBus device will get usable.

I'd like to get rid of the CPU fan noise by manually controlling the CPU 
fan based on CPU temperature (or by even unplugging the CPU fan and 
verifying success by reading the CPU temperature).

I'm willing to run tests, alpha versions and the like.

Thank you,
Xu?n.



----MBM SYSTEM INFO-----
 
MBM 5.3.5.0
MBM 5 Core EXE                : 5.3.5.0
MBM 5 Core DLL                : 5.3.5.1
MBM 5 Settings DLL            : 5.3.5.0
MBM 5 Dashboard DLL           : 5.3.5.0
MBM 5 Hibernation DLL         : 5.0.0.0
MBM 5 Ras DLL                 : 5.0.0.0
MBM 5 Logger DLL              : 5.3.4.0
MBM 5 Mail, FTP and UDP DLL   : 5.3.4.0
MBM 5 OSD DLL                 : 5.0.0.3
MBM 5 ASPI DLL                : 5.2.1.0
MBM 5 Heat Up EXE             : 5.0.0.0
MBM 5 Wizard                  : 5.3.5.0
MBMIO DLL                     : 1.0.0.2
MBMIO Driver                  : 1.1
 
DLL Folder Location           : C:\Programme\Motherboard Monitor 5\DLL\
Data Folder Location          : C:\Programme\Motherboard Monitor 5\Data\
Language Folder Location      : C:\Programme\Motherboard Monitor 5\Language\
Log Folder Location (Alarm)   : c:\programme\motherboard monitor 5\log\
Log Folder Location (High Low): c:\programme\motherboard monitor 5\log\
Log Folder Location (Interval): c:\programme\motherboard monitor 5\log\
 
Selected Language             : English
 
Info ChipInfo.ini             : 16576 bytes  24.10.2003 13:37:26
Info shdn.ini                 : 388 bytes    12.10.2000 18:47:06
Info Voltage.ini              : 31808 bytes  24.10.2003 13:09:22
Info Language file            : 22920 bytes  17.10.2003 08:33:40
 
Up Time MBM session           : 00:00:11:23
Up Time MBM total             : 00:00:32:02
 
------Sensor Chip-------
 
Main Sensor Chip              : Sis SiS5595
SMB Address                   : $0000
Used Bus                      : ISA
ISA Address                   : $8008
 
-Sensor Chip Selections-
 
Possible Temp Sensors[2]      : SiS5595
 
Selected Temp Sensors[1]      : SiS5595  (115)
Selected Temp Sensors[2]      : Custom  (185)
Selected Temp Sensors[3]      : Custom  (185)
 
Possible Voltage Sensors[2]   : MBM Fixed
 
Selected Voltage Sensors[1]   : MBM Fixed  (2)
Selected Voltage Sensors[2]   : MBM Fixed  (2)
Selected Voltage Sensors[3]   : MBM Fixed  (2)
Selected Voltage Sensors[4]   : MBM Fixed  (2)
Selected Voltage Sensors[5]   : MBM Fixed  (2)
Selected Voltage Sensors[6]   : MBM Fixed  (2)
Selected Voltage Sensors[7]   : MBM Fixed  (2)
 
Possible Fan Sensors[1]       : SiS5595-1
Possible Fan Sensors[2]       : SiS5595-2
 
Selected Fan Sensors[1]       : SiS5595-1  T1  D4  (32)
Selected Fan Sensors[2]       : SiS5595-2  T1  D4  (33)
Selected Fan Sensors[3]       : Asus-3  T1  D4  (31)
 
Possible Voltage Sub Types[0] : Sis 5595 Standard
Selected Voltage Sub Type     : Sis 5595 Standard  (0)
 
--Sensor Chip Readings--
 
Temperature Readout[1]        : 51
Temperature Readout[2]        : 51
Voltage Readout[1]            : 4,08
Voltage Readout[3]            : 4,08
Voltage Readout[4]            : 6,8544
Voltage Readout[5]            : 15,504
 
---------System---------
 
Operating System              : Microsoft Windows XP (NT 5.1) (Build 
2600) Service Pack 1
User                          : Administrator
Memory in use                 : 89%
Total Physical Memory         : 261616 KB
Available Physical Memory     : 28716 KB
 
----------CPU-----------
 
CPU Speed                     : 1792 MHz
Nr of CPU's                   : 1
 
-------3rd Party--------
 
ShutDownNow                   :
 
----Advanced Settings---
 
Fan Temp                      : 0
Custom Temp Table             : 0
Startup Delay                 : 0
2E 4E Enabled                 : 0
2E Forced                     : 0
4E Forced                     : 0
Do Not Reset                  : 1
SMB Scan Range                : $10 - $7F
