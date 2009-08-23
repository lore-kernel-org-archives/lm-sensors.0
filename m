From: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
Date: Sun, 23 Aug 2009 11:07:13 +0000
Subject: [lm-sensors] unhide_ICH_SMBus: line 33:
Message-Id: <4A9122E1.7010006@ribosome.natur.cuni.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,
  I am trying to figure out how to setup lm-sensors on my ASUS L3C/S
laptop (ICH3-M chipset) with P4-M processor. It all started with these
lines in dmesg(1) output:

i2c /dev entries driver
i801_smbus 0000:00:1f.3: PCI INT B -> Link[LNKB] -> GSI 11 (level, low) -> =
IRQ 11
ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe81f] conflicts with ACPI region =
SMB0 [0xe800-0xe80f]
ACPI: Device needs an ACPI driver
i801_smbus: probe of 0000:00:1f.3 failed with error -16
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
input: AT Translated Set 2 keyboard as /class/input/input5
iTCO_wdt: Found a ICH3-M TCO device (Version=3D1, TCOBASE=3D0xe460)
iTCO_wdt: initialized. heartbeat0 sec (nowayout=3D0)
iTCO_vendor_support: vendor-support=3D0




  Apparently I do not have something enabled in my kernel (currently 2.6.31=
-rc6-git6).
;)

  Here is the output from
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/hotplug/unhide_ICH_=
SMBus?revB83&format=3Draw

# ~/bin/unhide_ICH_SMBus=20
Enabling SMBus PCI device ...
Rescanning the bus ...
/root/bin/unhide_ICH_SMBus: line 33: /sys/bus/pci/slots//0000:00:1f.0/power=
: No such file or directory
Failed to enable the SMBUS
# ls -la /sys/bus/pci/slots/
total 0
drwxr-xr-x 2 root root 0 Aug 23 12:29 .
drwxr-xr-x 5 root root 0 Aug 23  2009 ..
#

What kernel option should I enable?




Further, some more info:

# ~/bin/sensors-detect=20
# sensors-detect revision $Revision$
# Board: ASUSTeK Computer INC. P4_L3C

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):=20
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):=20
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   Yes
Found `Nat. Semi. PC8739x Super IO'                        =20
    (no hardware monitoring capabilities)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):=20
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):=20
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):=20
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801CA/CAM ICH3
WARNING: Deprecated config file /etc/modprobe.conf, all config files belong=
 into /etc/modprobe.d/.
WARNING: All config files need .conf: /etc/modprobe.d/ath_pci, it will be i=
gnored in a future release.
WARNING: All config files need .conf: /etc/modprobe.d/slmodem, it will be i=
gnored in a future release.
FATAL: Module i2c_i801 not found.
Failed to load module i2c-i801.

Next adapter: radeonfb monid (i2c-0)
Do you want to scan it? (YES/no/selectively):=20

Next adapter: radeonfb dvi (i2c-1)
Do you want to scan it? (YES/no/selectively):=20

Next adapter: radeonfb vga (i2c-2)
Do you want to scan it? (YES/no/selectively):=20

Next adapter: radeonfb crt2 (i2c-3)
Do you want to scan it? (YES/no/selectively):=20

Sorry, no sensors were detected.
Either your system has no sensors, or they are not supported, or
they are connected to an I2C or SMBus adapter that is not
supported. If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.
#


And snippets from lspci(1) output:

# lspci -vvv
00:00.0 Host bridge: Intel Corporation 82845 845 [Brookdale] Chipset Host B=
ridge (rev 04)
        Subsystem: ASUSTeK Computer Inc. Device 1626
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <TAb=
ort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size%6M]
        Capabilities: [e4] Vendor Specific Information <?>
        Capabilities: [a0] AGP version 2.0
                Status: RQ2 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64- HTr=
ans- 64bit- FW+ AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit- =
FW- Rate=3Dx4
        Kernel driver in use: agpgart-intel
        Kernel modules: intel-agp


00:1f.3 SMBus: Intel Corporation 82801CA/CAM SMBus Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc. Device 1628
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at e800 [size2]




Thank you for any comments,
Martin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
