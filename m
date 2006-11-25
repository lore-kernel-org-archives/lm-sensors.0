From: twb0@lymenet.org (Thomas Brown)
Date: Sat, 25 Nov 2006 22:34:42 +0000
Subject: [lm-sensors] HP Compaq ProLiant DL380 detect failure
Message-Id: <4568C502.6070305@lymenet.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Anyone have any luck getting lm_sensors to work with the HP/Compaq
ProLiant DL series (i.e. DL380)?  With the latest 'sensors-detect'
script I get "Sorry, no sensors were detected."

Here is some data for your perusal:


dmesg output:
piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 device
piix4_smbus 0000:00:0f.0: SMB base address uninitialized - upgrade BIOS
or use force_addr=0xaddr


lspci output:
00:00.0 Host bridge: Broadcom CNB20HE Host Bridge (rev 23)
00:00.1 Host bridge: Broadcom CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: Broadcom CNB20HE Host Bridge (rev 01)
00:00.3 Host bridge: Broadcom CNB20HE Host Bridge (rev 01)
00:01.0 RAID bus controller: Compaq Computer Corporation Smart Array
5i/532 (rev 01)
00:02.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 08)
00:04.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 08)
00:06.0 System peripheral: Compaq Computer Corporation Advanced System
Management Controller
00:0f.0 ISA bridge: Broadcom OSB4 South Bridge (rev 51)
00:0f.1 IDE interface: Broadcom OSB4 IDE Controller
00:0f.2 USB Controller: Broadcom OSB4/CSB5 OHCI USB Controller (rev 04)
01:03.0 PCI bridge: Intel Corporation 80960RP [i960 RP
Microprocessor/Bridge] (rev 05)
01:03.1 Memory controller: Intel Corporation 80960RP [i960RP
Microprocessor] (rev 05)
02:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC
215IIC [Mach64 GT IIC] (rev 7a)
07:03.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
100] (rev 08)
07:07.0 PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug
Controller (rev 12)


HP has a utility to read data from the Internal Lights Out Management board:
# hplog -t
ID     TYPE        LOCATION      STATUS    CURRENT  THRESHOLD
 1  ADM1022      Processor Zone  Nominal  113F/ 45C 143F/ 62C
 2  ADM1022      CPU (1)         Nominal  113F/ 45C 156F/ 69C
 3  ADM1022      I/O Zone        Nominal  113F/ 45C 145F/ 63C
 4  ADM1022      CPU (2)         Nominal  111F/ 44C 156F/ 69C
 5  ADM1022      Pwr. Supply Bay Nominal  100F/ 38C 129F/ 54C

# hplog -f
ID     TYPE        LOCATION      STATUS  REDUNDANT FAN SPEED
 1  Var. Speed   Processor Zone  Nominal    Yes     Low    ( 10)
 2  Var. Speed   Processor Zone  Nominal    Yes     Low    ( 10)
 3  Var. Speed   I/O Zone        Nominal    Yes     Low    ( 20)
 4  Var. Speed   I/O Zone        Nominal    Yes     Low    ( 20)
 5  Var. Speed   Processor Zone  Nominal    Yes     Low    ( 10)
 6  Var. Speed   Processor Zone  Nominal    Yes     Low    ( 10)
 7  Var. Speed   Pwr. Supply Bay Nominal    Yes     Low    ( 20)
 8  Var. Speed   Pwr. Supply Bay Nominal    Yes     Low    ( 20)

# hplog -p
ID     TYPE        LOCATION      STATUS  REDUNDANT
 1  Standard     Pwr. Supply Bay Nominal    No
 2  Standard     Pwr. Supply Bay Absent     No


Here is the full output of sensors-detect:

# wget
"http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt"
--16:58:03-- 
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
           => `sensors-detect?format=txt'
Resolving www.lm-sensors.org... 130.133.35.30
Connecting to www.lm-sensors.org|130.133.35.30|:80... connected.
HTTP request sent, awaiting response... 200 Ok
Length: 174,692 (171K) [text/plain]

100%[============================>]
174,692      136.51K/s

16:58:05 (136.06 KB/s) - `sensors-detect?format=txt' saved [174692/174692]

# perl "sensors-detect?format=txt"
# sensors-detect revision $Revision$

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 0000:00:0f.0: ServerWorks OSB4 South
Bridge

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): YES
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0xffbf
Trying family `National Semiconductor'...                   Yes
Found unknown chip with ID 0xffbf
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0xffbf
Trying family `VIA/Winbond/Fintek'...                       Yes
Found unknown chip with ID 0xffbf
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Some CPU may also contain embedded sensors.
Do you want to scan for CPU embedded sensors? (YES/no): YES
AMD K8 thermal sensors...                                   No
Intel Core family thermal sensor...                         No

Sorry, no sensors were detected.
Either your sensors are not supported, or they are connected to an
I2C or SMBus adapter that is not supported. See doc/FAQ,
doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
(FAQ #4.24.3) for further information.
If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.



Thanks much!
-Tom

