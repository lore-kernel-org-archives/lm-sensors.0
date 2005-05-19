From: pirabhur@VerariSoft.Com (Pirabhu Raman)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: i2c-i801.o (fwd)
Message-Id: <Pine.GSO.4.58.0503171700270.26676@mpi.mpi-softtech.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I am not part of this group. So please email any replies with a cc to my
email address. I am trying to load i2c-i801.o module and get the following
output

i2c-i801.o version 2.6.5 (20020915)
i2c-i801.o: Error: Can't detect I801, function 3!
i2c-i801.o: I801 not detected, module not inserted.

while lspci gives the output
>>>00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller
   (rev 02)

>>>>addresses in i2c-i801.c file
#ifndef PCI_DEVICE_ID_INTEL_82801AA_3
#define PCI_DEVICE_ID_INTEL_82801AA_3   0x2413
#endif
#ifndef PCI_DEVICE_ID_INTEL_82801AB_3
#define PCI_DEVICE_ID_INTEL_82801AB_3   0x2423
#endif
#ifndef PCI_DEVICE_ID_INTEL_82801BA_2
#define PCI_DEVICE_ID_INTEL_82801BA_2   0x2443
#endif
#define PCI_DEVICE_ID_INTEL_82801CA_SMBUS       0x2483
#define PCI_DEVICE_ID_INTEL_82801DB_SMBUS       0x24C3

static int supported[] = {PCI_DEVICE_ID_INTEL_82801AA_3,
                          PCI_DEVICE_ID_INTEL_82801AB_3,
                          PCI_DEVICE_ID_INTEL_82801BA_2,
                          PCI_DEVICE_ID_INTEL_82801CA_SMBUS,
                          PCI_DEVICE_ID_INTEL_82801DB_SMBUS,
                          0 };


I saw your name on source file and was wondering if you can provide any
pointers? If I need to email someone else please ignore this email.

Thanks,
Pirabhu


The detailed output are below
>>>>>lspci
00:00.0 Host bridge: Intel Corp. Server Memory Controller Hub (rev 09)
00:00.1 Class ff00: Intel Corp. Memory Controller Hub Error Reporting
Register (rev 09)
00:01.0 System peripheral: Intel Corp. Memory Controller Hub DMA
Controller (rev 09)
00:02.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port A0
(rev 09)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1
(rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2
(rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3
(rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI
Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev
02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100
Storage Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev
02)
01:00.0 PCI bridge: Intel Corp. PCI Bridge Hub A (rev 09)
01:00.1 PIC: Intel Corp. PCI Bridge Hub I/OxAPIC Interrupt Controller A
(rev 09)
01:00.2 PCI bridge: Intel Corp. PCI Bridge Hub B (rev 09)
01:00.3 PIC: Intel Corp. PCI Bridge Hub I/OxAPIC Interrupt Controller B
(rev 09)
03:04.0 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet
Controller (rev 03)
03:04.1 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet
Controller (rev 03)
04:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)

>>>>>lsmod
i2c-proc                9232   0  (unused)
i2c-isa                 1836   0  (unused)
ipmi_smb_intf           9740   0  (unused)
i2c-algo-pcf            6204   0  (unused)
i2c-algo-bit            7176   0
i2c-dev                 5636   0  (unused)
i2c-core               19684   0  [i2c-proc i2c-isa ipmi_smb_intf
i2c-algo-pcf i2c-algo-bit i2c-dev]
dmi_scan                2500   0  (unused)
ipmi_watchdog          13190   0
ipmi_devintf            5160   0
ipmi_poweroff           5620   0  (unused)
ipmi_msghandler        28800   0  [ipmi_smb_intf ipmi_watchdog
ipmi_devintf ipmi_poweroff]
lp                      9124   0  (autoclean)

>>>>>>>lspci -n
[root@jarellNode2 i2c]# lspci -n
00:00.0 Class 0600: 8086:3590 (rev 09)
00:00.1 Class ff00: 8086:3591 (rev 09)
00:01.0 Class 0880: 8086:3594 (rev 09)
00:02.0 Class 0604: 8086:3595 (rev 09)
00:1d.0 Class 0c03: 8086:24d2 (rev 02)
00:1d.1 Class 0c03: 8086:24d4 (rev 02)
00:1d.2 Class 0c03: 8086:24d7 (rev 02)
00:1e.0 Class 0604: 8086:244e (rev c2)
00:1f.0 Class 0601: 8086:24d0 (rev 02)
00:1f.1 Class 0101: 8086:24db (rev 02)
00:1f.3 Class 0c05: 8086:24d3 (rev 02)
01:00.0 Class 0604: 8086:0329 (rev 09)
01:00.1 Class 0800: 8086:0326 (rev 09)
01:00.2 Class 0604: 8086:032a (rev 09)
01:00.3 Class 0800: 8086:0327 (rev 09)
03:04.0 Class 0200: 8086:1079 (rev 03)
03:04.1 Class 0200: 8086:1079 (rev 03)
04:0c.0 Class 0300: 1002:4752 (rev 27)


=====================================Pirabhu Raman
Software Engineer, Verari Systems Software, Inc.
Phone +1-205-397-3141 ext.3159  Fax +1-205-397-3142
http://www.verarisoft.com/

The information contained in this communication may be confidential and is
intended only for the use of the recipient(s) named above.  If the reader
of this communication is not the intended recipient(s), you are hereby
notified that any dissemination, distribution, or copying of this
communication, or any of its contents, is strictly prohibited.  If you are
not a named recipient or received this communication by mistake, please
notify the sender and delete the communication and all copies of it.

"You are not climbing the whole mountain at once. You are taking a step at a time.
The most important step is the next one!!"
