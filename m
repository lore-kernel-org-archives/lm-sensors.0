From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Oct 2010 15:10:56 +0000
Subject: Re: [lm-sensors] VIA EPIA PX10000G sensors
Message-Id: <20101023171056.1429adb1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1814810737.20101015204506@mail.ru>
In-Reply-To: <1814810737.20101015204506@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 15 Oct 2010 20:45:06 +0600, Beelzebubbie wrote:
> Hello,
>=20
>   I've  got VIA EPIA PX10000G motherboard (VIA C7 1.0GHz NanoBGA2, VIA
>   VX700 Unified Digital Media IGP chipset)
>=20
>   2.6.34-gentoo-r6, lm_sensors 3.1.2
>=20
>   Manufacturer's  block  diagram  shows  ADM1032 and VT1212 chips, but
>   sensors-detect finds only VIA C7 thermal sensor:
>=20
> # sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
> # System: VIA Technologies, Inc. CX700
>=20
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>=20
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no): y
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD Family 10h thermal sensors...                           No
> AMD Family 11h thermal sensors...                           No
> Intel Core family thermal sensor...                         No
> Intel Atom thermal sensor...                                No
> Intel AMB FB-DIMM thermal sensor...                         No
> VIA C7 thermal sensor...                                    Success!
>     (driver `via-cputemp')
> VIA Nano thermal sensor...                                  No
>=20
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): y
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
> Found unknown chip with ID 0xfc01

Unknown Super-I/O, even with the latest version of sensors-detect. The
VT1212 would be detected if present, as it is supported by the version
of sensors-detect you're using.

Note anyway that the VT1212 is not really important, as this device
does NOT include hardware monitoring features, contrary to its
predecessor (VT1211.)

> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      No
>=20
> Some systems (mainly servers) implement IPMI, a set of common interfaces
> through which system health data may be retrieved, amongst other things.
> We first try to get the information from SMBIOS. If we don't find it
> there, we have to read from arbitrary I/O ports to probe for such
> interfaces. This is normally safe. Do you want to scan for IPMI
> interfaces? (YES/no): y
> # DMI data unavailable, please consider installing dmidecode 2.7
> # or later for better results.
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>=20
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (YES/no): y
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
>=20
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no): y
> Using driver `i2c-viapro' for device 0000:00:11.0: VIA Technologies CX700=
 South Bridge
> Module i2c-dev loaded successfully.
>=20
> Next adapter: via_i2c (i2c-0)
> Do you want to scan it? (YES/no/selectively): y
>=20
> Next adapter: SMBus Via Pro adapter at 0500 (i2c-1)
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Probing for `EDID EEPROM'...                                No
>=20
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>=20
> Driver `via-cputemp':
>   * Chip `VIA C7 thermal sensor' (confidence: 9)
>=20
> ******************
> ******************
>=20
> sensors
> via_cputemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +42.0=B0C

At least this seems to be working.

>=20
> ******************
> ******************
>=20
> dmesg | grep i2c
> i2c /dev entries driver
> i2c i2c-1: Transaction error!

Possibly the result of probing address 0x73. The i2c-viapro driver
should be made quieter, I think. You can ignore this message anyway.

>=20
> ******************
> ******************
>=20
> i2cdetect -l do not listed anything

Because you didn't load module i2c-dev first. But anyway, i2cdetect is
unlikely to tell you anything sensors-detect didn't already.

>=20
> ******************
> ******************
>=20
> lspci -nn
> 00:00.0 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridg=
e [1106:0324] (rev 03)
> 00:00.1 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridg=
e [1106:1324]
> 00:00.2 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridg=
e [1106:2324]
> 00:00.3 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridg=
e [1106:3324]
> 00:00.4 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridg=
e [1106:4324]
> 00:00.7 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridg=
e [1106:7324]
> 00:01.0 PCI bridge [0604]: VIA Technologies, Inc. VT8237/VX700 PCI Bridge=
 [1106:b198]
> 00:0f.0 IDE interface [0101]: VIA Technologies, Inc. VX800 Serial ATA and=
 EIDE Controller [1106:5324]
> 00:10.0 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI USB =
1.1 Controller [1106:3038] (rev 90)
> 00:10.1 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI USB =
1.1 Controller [1106:3038] (rev 90)
> 00:10.2 USB Controller [0c03]: VIA Technologies, Inc. VT82xxxxx UHCI USB =
1.1 Controller [1106:3038] (rev 90)
> 00:10.4 USB Controller [0c03]: VIA Technologies, Inc. USB 2.0 [1106:3104]=
 (rev 90)
> 00:11.0 ISA bridge [0601]: VIA Technologies, Inc. CX700/VX700 PCI to ISA =
Bridge [1106:8324]
> 00:11.7 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Internal M=
odule Bus [1106:324e]
> 00:13.0 Host bridge [0600]: VIA Technologies, Inc. CX700/VX700 Host Bridg=
e [1106:324b]
> 00:13.1 PCI bridge [0604]: VIA Technologies, Inc. CX700/VX700 PCI to PCI =
Bridge [1106:324a]
> 01:00.0 VGA compatible controller [0300]: VIA Technologies, Inc. CX700/VX=
700 [S3 UniChrome Pro] [1106:3157] (rev 03)
> 02:06.0 Ethernet controller [0200]: VIA Technologies, Inc. VT6105/VT6106S=
 [Rhine-III] [1106:3106] (rev 8b)
>=20
> What is "unknown chip with ID 0xfc01"? ADM1032? Tried modprobe lm90
> and it loaded successfully, but no effect...

No, it can't be. The unknown device is a LPC chip, while the ADM1032 is
an I2C chip.

> How can I get HW monitoring values from ADM1032 and VT1212?

The output of sensors-detect strongly suggests that there are no
ADM1032 and no VT1212 chips in your system. Are you sure you looked at
the right documentation?

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
