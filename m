From: "mint oreo" <mintoreowafer@gmail.com>
Date: Sat, 28 Jun 2008 10:37:14 +0000
Subject: [lm-sensors] No sensors - Intel 946 motherboard (82801G ICH7)
Message-Id: <ec82322b0806280337l5ab2648doa3d43db1c8795223@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Installed lm-sensors on my RHEL5 box from the ATRPMS repo:
 libsensors3             i386       2.10.6-55.el5    atrpms - testing   50 k
 lm_sensors              i386       2.10.6-55.el5    atrpms - testing  501 k

But cannot seem to get it to work. Here is the sensors-detect output
from the installed rpm package:

[root@media ~]# sensors-detect
# sensors-detect revision 5132 (2008-02-26 14:52:35 +0100)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 2000 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x2e
Probing for `Myson MTP008'...                               No
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM78-J'...              No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM85 or LM96000'...     No
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... No
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'...        No
Probing for `Analog Devices ADT7462'...                     No
Probing for `Analog Devices ADT7467 or ADT7468'...          No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Analog Devices ADT7473'...                     No
Probing for `Analog Devices ADT7475'...                     No
Probing for `Analog Devices ADT7476'...                     No
Probing for `Andigilog aSC7611'...                          Success!
    (confidence 5, driver `to-be-written')
Probing for `Andigilog aSC7621'...                          No
Probing for `National Semiconductor LM87'...                No
Probing for `National Semiconductor LM93'...                No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Winbond W83791SD'...                           No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG'...                          No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Winbond W83L785TS-S'...                        No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1026'...                     No
Probing for `Analog Devices ADM1025'...                     No
Probing for `Analog Devices ADM1029'...                     No
Probing for `Analog Devices ADM1030'...                     No
Probing for `Analog Devices ADM1031'...                     No
Probing for `Analog Devices ADM1022'...                     No
Probing for `Texas Instruments THMC50'...                   No
Probing for `Analog Devices ADM1028'...                     No
Probing for `ITE IT8712F'...                                No
Probing for `SMSC DME1737'...                               No
Probing for `SMSC SCH5027D-NW'...                           No
Probing for `Fintek F75373S/SG'...                          No
Probing for `Fintek F75375S/SP'...                          No
Probing for `Fintek F75387SG/RG'...                         No
Probing for `Analog Devices ADM1024'...                     No
Probing for `Winbond W83791D'...                            No
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   Yes
Found `Nat. Semi. PC8374L Super IO Sensors'
    (but not activated)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 2000'
    Busdriver `i2c-i801', I2C address 0x2e
    Chip `Andigilog aSC7611' (confidence: 5)

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
You should now start the lm_sensors service to load the required
kernel modules.


[root@media ~]# service lm_sensors start
Starting lm_sensors: loading module i2c-i801 coretemp No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.
                                                           [FAILED]

-----------------------------------------------------------------------------------------------

Searching the archives, there seems to be issues with other people
using boards with the same chipset? Mines an Intel D946GZIS Desktop
Board. So in the hope of finding a solution, I've put below outputs of
various commands that may help!


[root@media ~]# uname -a
Linux media 2.6.18-92.1.6.el5 #1 SMP Fri Jun 20 02:36:16 EDT 2008 i686
i686 i386 GNU/Linux

--------------------------

[root@media ~]# lspci -v
00:00.0 Host bridge: Intel Corporation 82946GZ/PL/GL Memory Controller
Hub (rev 02)
        Subsystem: Intel Corporation Unknown device 5354
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation 82946GZ/GL
Integrated Graphics Controller (rev 02) (prog-if 00 [VGA controller])
        Subsystem: Intel Corporation Unknown device 5354
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at 90100000 (32-bit, non-prefetchable) [size=1M]
        Memory at 80000000 (64-bit, prefetchable) [size%6M]
        I/O ports at 20e0 [size=8]
        Capabilities: [90] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
        Capabilities: [d0] Power Management version 2

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary , secondary, subordinate, sec-latency=0
        Memory behind bridge: 90300000-903fffff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary , secondary, subordinate, sec-latency=0
        Memory behind bridge: 90400000-904fffff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary , secondary, subordinate, sec-latency=0
        Memory behind bridge: 90500000-905fffff
        Capabilities: [40] Express Root Port (Slot+) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation Unknown device 5354
        Flags: bus master, medium devsel, latency 0, IRQ 225
        I/O ports at 2080 [size2]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation Unknown device 5354
        Flags: bus master, medium devsel, latency 0, IRQ 185
        I/O ports at 2060 [size2]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation Unknown device 5354
        Flags: bus master, medium devsel, latency 0, IRQ 177
        I/O ports at 2040 [size2]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #4 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation Unknown device 5354
        Flags: bus master, medium devsel, latency 0, IRQ 233
        I/O ports at 2020 [size2]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Intel Corporation Unknown device 5354
        Flags: bus master, medium devsel, latency 0, IRQ 225
        Memory at 90200400 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
(prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary , secondary, subordinate, sec-latency2
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 90000000-900fffff
        Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
        Subsystem: Intel Corporation Unknown device 5354
        Flags: bus master, medium devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corporation Unknown device 5354
        Flags: bus master, medium devsel, latency 0, IRQ 177
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 20b0 [size]

00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family)
SATA IDE Controller (rev 01) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Intel Corporation Unknown device 5354
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 185
        I/O ports at 20c8 [size=8]
        I/O ports at 20ec [size=4]
        I/O ports at 20c0 [size=8]
        I/O ports at 20e8 [size=4]
        I/O ports at 20a0 [size]
        Memory at 90200000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
        Subsystem: Intel Corporation Unknown device 5354
        Flags: medium devsel, IRQ 185
        I/O ports at 2000 [size2]

04:08.0 Ethernet controller: Intel Corporation PRO/100 VE Network
Connection (rev 01)
        Subsystem: Intel Corporation Unknown device 0001
        Flags: bus master, medium devsel, latency 32, IRQ 50
        Memory at 90000000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 1000 [sized]
        Capabilities: [dc] Power Management version 2

--------------------------

Ran an updated sensors-detect from
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
and also tried the ver3 one
(http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect?format=txt)
but end result is the same.

<snip>
Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 2000'
    Busdriver `i2c-i801', I2C address 0x2e
    Chip `Andigilog aSC7611' (confidence: 5)

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
Starting lm_sensors: loading module i2c-i801 coretemp No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.
                                                           [FAILED]

--------------------------

[root@media ~]# lsmod
Module                  Size  Used by
i2c_dev                12613  0
ipv6                  258273  33
xfrm_nalgo             13765  1 ipv6
crypto_api             11969  1 xfrm_nalgo
autofs4                24517  2
sunrpc                144893  1
cpufreq_ondemand       12493  2
dm_mirror              29253  0
dm_multipath           22089  0
dm_mod                 61661  2 dm_mirror,dm_multipath
video                  21193  0
sbs                    18533  0
backlight              10049  1 video
i2c_ec                  9025  1 sbs
button                 10705  0
battery                13637  0
asus_acpi              19289  0
ac                      9157  0
parport_pc             29157  0
lp                     15849  0
parport                37513  2 parport_pc,lp
i2c_i801               11597  0
e100                   36809  0
i2c_core               23745  3 i2c_dev,i2c_ec,i2c_i801
serio_raw              10693  0
mii                     9409  1 e100
ide_cd                 40033  0
cdrom                  36705  1 ide_cd
sg                     36189  0
pcspkr                  7105  0
ata_piix               22341  1
libata                143997  1 ata_piix
sd_mod                 24897  2
scsi_mod              134605  3 sg,libata,sd_mod
ext3                  123593  4
jbd                    56553  1 ext3
uhci_hcd               25421  0
ohci_hcd               23261  0
ehci_hcd               33357  0

--------------------------

[root@media ~]# modprobe i2c-dev
[root@media ~]# modprobe i2c-i801
[root@media ~]# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e --
30: 30 -- 32 -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
50: 50 -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- 61 -- -- -- -- -- -- -- 69 -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
