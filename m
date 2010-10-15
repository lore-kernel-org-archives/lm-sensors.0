From: Beelzebubbie <Beelzebubbie@mail.ru>
Date: Fri, 15 Oct 2010 14:45:06 +0000
Subject: [lm-sensors] VIA EPIA PX10000G sensors
Message-Id: <1814810737.20101015204506@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

  I've  got VIA EPIA PX10000G motherboard (VIA C7 1.0GHz NanoBGA2, VIA
  VX700 Unified Digital Media IGP chipset)

  2.6.34-gentoo-r6, lm_sensors 3.1.2

  Manufacturer's  block  diagram  shows  ADM1032 and VT1212 chips, but
  sensors-detect finds only VIA C7 thermal sensor:

# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# System: VIA Technologies, Inc. CX700

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): y
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    Success!
    (driver `via-cputemp')
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): y
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found unknown chip with ID 0xfc01
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no): y
# DMI data unavailable, please consider installing dmidecode 2.7
# or later for better results.
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

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
Using driver `i2c-viapro' for device 0000:00:11.0: VIA Technologies CX700 S=
outh Bridge
Module i2c-dev loaded successfully.

Next adapter: via_i2c (i2c-0)
Do you want to scan it? (YES/no/selectively): y

Next adapter: SMBus Via Pro adapter at 0500 (i2c-1)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `via-cputemp':
  * Chip `VIA C7 thermal sensor' (confidence: 9)

******************
******************

sensors
via_cputemp-isa-0000
Adapter: ISA adapter
Core 0:      +42.0=B0C

******************
******************

dmesg | grep i2c
i2c /dev entries driver
i2c i2c-1: Transaction error!

******************
******************

i2cdetect -l do not listed anything

******************
******************

lspci -nn
00:00.0 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge =
[1106:0324] (rev 03)
00:00.1 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge =
[1106:1324]
00:00.2 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge =
[1106:2324]
00:00.3 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge =
[1106:3324]
00:00.4 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge =
[1106:4324]
00:00.7 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge =
[1106:7324]
00:01.0 PCI bridge [0604]: VIA Technologies, Inc. VT8237/VX700 PCI Bridge [=
1106:b198]
00:0f.0 IDE interface [0101]: VIA Technologies, Inc. VX800 Serial ATA and E=
IDE Controller [1106:5324]
00:10.0 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.=
1 Controller [1106:3038] (rev 90)
00:10.1 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.=
1 Controller [1106:3038] (rev 90)
00:10.2 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.=
1 Controller [1106:3038] (rev 90)
00:10.4 USB Controller [0c03]: VIA Technologies, Inc. USB 2.0 [1106:3104] (=
rev 90)
00:11.0 ISA bridge [0601]: VIA Technologies, Inc. CX700/VX700 PCI to ISA Br=
idge [1106:8324]
00:11.7 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Internal Mod=
ule Bus [1106:324e]
00:13.0 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridge =
[1106:324b]
00:13.1 PCI bridge [0604]: VIA Technologies, Inc. CX700/VX700 PCI to PCI Br=
idge [1106:324a]
01:00.0 VGA compatible controller [0300]: VIA Technologies, Inc. CX700/VX70=
0 [S3 UniChrome Pro] [1106:3157] (rev 03)
02:06.0 Ethernet controller [0200]: VIA Technologies, Inc. VT6105/VT6106S [=
Rhine-III] [1106:3106] (rev 8b)

What is "unknown chip with ID 0xfc01"? ADM1032? Tried modprobe lm90
and it loaded successfully, but no effect...

How can I get HW monitoring values from ADM1032 and VT1212?

Thanks in advance.
--=20
 Beelzebubbie                          mailto:Beelzebubbie@mail.ru


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
