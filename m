From: "Virgil Gheorghiu" <virgilg@cs.uchicago.edu>
Date: Thu, 02 Sep 2010 17:08:19 +0000
Subject: [lm-sensors] Kernel support for ITE8758E
Message-Id: <op.vie0j5x7752aa5@microbe.cs.uchicago.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear lm-sensors team,

We have a variety of Shuttle machines we run Linux on.
The newest addition, an SX58J3, differs from the older SX58H7 in several  
ways.
In sensors' case, the old board has an ITE8720F, whereas the new one has  
an ITE8758E, which neither Google nor www.alldatasheet.com has any  
knowledge of.
dmidecode(8) reports both boards to be "SX58 V10" (Base Board  
Information/Product Name/Version), yet differences do not stop at sensors  
chips.
I've included a small 'lspci -nn' difference between the two at the end of  
this message.

I did a simple 'add device ID' in several places in it87.c, and added  
support for it in sensors-detect.
Without a sensors.conf config file in place, it87.ko reports temperature  
values matching the BIOS.
Voltages are all over the place, and so is the single fan.
While making the fan value obey wasn't bad but I need serious  
investigation to match voltages reported by it87 to the BIOS.
Since the machine is about to be deployed, I cannot do this at this time.

One other problem I noticed is an SNMP bulkwalk to this machine returns:
snmpbulkwalk -v2c -c****** new-sk58j3 LM-SENSORS-MIB::lmFanSensorsTable
LM-SENSORS-MIB::lmFanSensorsTable = No Such Object available on this agent  
at this OID
What is the connection between a new it87.ko kernel module and  
libsensors.4.2.1 (libsensors4 1:3.1.2-2 lenny/sid), and what do I need to  
do to support it8758 at libsensors4's level so that snmpd picks it up?

I would like to share the above patches (subject to more informed people's  
scrutiny) and also the sensors.conf for all motherboards we use here.
There are undoubtedly some miskates :-) but we use them with a good degree  
of success in monitoring a variety of machines (sensors.cs.uchicago.edu is  
one such publicly open example).
Please let me know where can I send a bunch of configuration files,  
patches and pictures of the ITE8758E chip, and in what format (*.tar.bz2  
?).

Thank you for your help and for making lm-sensors possible,
Virgil Gheorghiu
Systems Administrator
Department of Computer Science
The University of Chicago


--- begin lspci data 8x ---
sx58h7-shuttle# lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation 5520/5500/X58 I/O Hub to ESI  
Port [8086:3400] (rev 12)
00:01.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI  
Express Root Port 1 [8086:3408] (rev 12)
00:03.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI  
Express Root Port 3 [8086:340a] (rev 12)
00:07.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI  
Express Root Port 7 [8086:340e] (rev 12)
00:10.0 PIC [0800]: Intel Corporation 5520/5500/X58 Physical and Link  
Layer Registers Port 0 [8086:3425] (rev 12)
00:10.1 PIC [0800]: Intel Corporation 5520/5500/X58 Routing and Protocol  
Layer Registers Port 0 [8086:3426] (rev 12)
00:14.0 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub System  
Management Registers [8086:342e] (rev 12)
00:14.1 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub GPIO and  
Scratch Pad Registers [8086:3422] (rev 12)
00:14.2 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub Control Status  
and RAS Registers [8086:3423] (rev 12)
00:14.3 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub Throttle  
Registers [8086:3438] (rev 12)
00:1a.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB UHCI Controller #4 [8086:3a37]
00:1a.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB UHCI Controller #5 [8086:3a38]
00:1a.2 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB UHCI Controller #6 [8086:3a39]
00:1a.7 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB2 EHCI Controller #2 [8086:3a3c]
00:1b.0 Audio device [0403]: Intel Corporation 82801JI (ICH10 Family) HD  
Audio Controller [8086:3a3e]
00:1c.0 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI  
Express Root Port 1 [8086:3a40]
00:1c.2 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI  
Express Root Port 3 [8086:3a44]
00:1d.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB UHCI Controller #1 [8086:3a34]
00:1d.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB UHCI Controller #2 [8086:3a35]
00:1d.2 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB UHCI Controller #3 [8086:3a36]
00:1d.7 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB2 EHCI Controller #1 [8086:3a3a]
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e]  
(rev 90)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801JIR (ICH10R) LPC  
Interface Controller [8086:3a16]
00:1f.2 SATA controller [0106]: Intel Corporation 82801JI (ICH10 Family)  
SATA AHCI Controller [8086:3a22]
00:1f.3 SMBus [0c05]: Intel Corporation 82801JI (ICH10 Family) SMBus  
Controller [8086:3a30]
02:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.  
RTL8111/8168B PCI Express Gigabit Ethernet controller [10ec:8168] (rev 02)
03:00.0 IDE interface [0101]: JMicron Technology Corp. JMB368 IDE  
controller [197b:2368]
04:00.0 VGA compatible controller [0300]: nVidia Corporation GT200  
[GeForce GTX 260] [10de:05e2] (rev a1) # <- add-on card

sx58j3-shuttle# lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation 5520/5500/X58 I/O Hub to ESI  
Port [8086:3400] (rev 13)
00:01.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI  
Express Root Port 1 [8086:3408] (rev 13)
00:03.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI  
Express Root Port 3 [8086:340a] (rev 13)
00:07.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI  
Express Root Port 7 [8086:340e] (rev 13)
00:14.0 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub System  
Management Registers [8086:342e] (rev 13)
00:14.1 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub GPIO and  
Scratch Pad Registers [8086:3422] (rev 13)
00:14.2 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub Control Status  
and RAS Registers [8086:3423] (rev 13)
00:14.3 PIC [0800]: Intel Corporation 5520/5500/X58 I/O Hub Throttle  
Registers [8086:3438] (rev 13)
00:1a.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB UHCI Controller #4 [8086:3a37]
00:1a.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB UHCI Controller #5 [8086:3a38]
00:1a.2 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB UHCI Controller #6 [8086:3a39]
00:1a.7 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB2 EHCI Controller #2 [8086:3a3c]
00:1b.0 Audio device [0403]: Intel Corporation 82801JI (ICH10 Family) HD  
Audio Controller [8086:3a3e]
00:1c.0 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI  
Express Root Port 1 [8086:3a40]
00:1c.1 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI  
Express Port 2 [8086:3a42]
00:1c.2 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI  
Express Root Port 3 [8086:3a44]
00:1d.0 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB UHCI Controller #1 [8086:3a34]
00:1d.1 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB UHCI Controller #2 [8086:3a35]
00:1d.2 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB UHCI Controller #3 [8086:3a36]
00:1d.7 USB Controller [0c03]: Intel Corporation 82801JI (ICH10 Family)  
USB2 EHCI Controller #1 [8086:3a3a]
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e]  
(rev 90)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801JIR (ICH10R) LPC  
Interface Controller [8086:3a16]
00:1f.2 SATA controller [0106]: Intel Corporation 82801JI (ICH10 Family)  
SATA AHCI Controller [8086:3a22]
00:1f.3 SMBus [0c05]: Intel Corporation 82801JI (ICH10 Family) SMBus  
Controller [8086:3a30]
02:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8057  
PCI-E Gigabit Ethernet Controller [11ab:4380] (rev 10)
03:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8057  
PCI-E Gigabit Ethernet Controller [11ab:4380] (rev 10)
05:00.0 VGA compatible controller [0300]: nVidia Corporation G96 [GeForce  
9400 GT] [10de:0641] (rev a1) # <- add-on card

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
