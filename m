From: klingler@newtec.de (klingler@newtec.de)
Date: Wed, 20 Jul 2005 13:24:41 +0000
Subject: [lm-sensors] WG: Ticket entry / SMBus Timeout with lm87 on ALI15x3
Message-Id: <70FE8182C709BD4F93E33B638E00F463075C63@merkur.newtec.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

=20


Hello!

I tried to start a new ticket with the problem described below, but i
could not find the ticket in the database after the entry. So i send the
content to you by email.

Maybe you could help us!

Thanks in advance!

best regards,
Claudio Klingler

We use the ali15x3 driver with the lm87 and have the same effect
described in Ticket #268. After a few readings, we get an smbus timeout:

Is there any hope to get those driver working? Accessing the lml87 over
i2c-pci-module does not work on this board. Maybe some of the
information below can help you.

This problem also occurs with the 2.4.25 kernel and the 2.9.1 i2c-driver
with lm-sensors 2.9.1.
---------
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT , CMD8, ADDY,
DAT0=7F, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT , CMD8, ADDY,
DAT0=00, DAT1=14
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT , CMD=13, ADDY,
DAT0=00, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT , CMD=13, ADDY,
DAT0F, DAT1=14
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT , CMD=17, ADDY,
DAT0F, DAT1=14
i2c_adapter i2c-0: SMBus Timeout!
i2c_adapter i2c-0: Transaction (post): STS=04, CNT , CMD=17, ADDY,
DAT0F, DAT1=14
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT , CMD=14, ADDY,
DAT0F, DAT1=14
i2c_adapter i2c-0: SMBus Timeout!
i2c_adapter i2c-0: Transaction (post): STS=04, CNT , CMD=14, ADDY,
DAT0F, DAT1=14
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT , CMD=18, ADDY,
DAT0F, DAT1=14
---------

Here is the output of lspci and lsmod after driver is loaded:

------
Module                  Size  Used by
eeprom                  6008  0=20
lm87                   18996  0=20
i2c_sensor              3456  2 eeprom,lm87
i2c_isa                 1600  0=20
i2c_ali15x3             7460  0=20
parport_pc             24836  0=20
parport                31432  1 parport_pc
rtc                     9528  0=20
rd                      4832  1=20

------
00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1651
(rev b0)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV] (rev c3)
00:09.0 Class ff00: Altera Corporation: Unknown device 0005 (rev 21)
00:0b.0 Multimedia audio controller: ESS Technology ES1969 Solo-1
Audiodrive (rev 01)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c2)
00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
00:12.0 VGA compatible controller: Silicon Motion, Inc. SM712 LynxEM+
(rev a0)
00:13.0 Ethernet controller: Intel Corp. 82559ER (rev 10)
00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1651
(rev b0)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV] (rev c3)
00:09.0 Class ff00: Altera Corporation: Unknown device 0005 (rev 21)
00:0b.0 Multimedia audio controller: ESS Technology ES1969 Solo-1
Audiodrive (rev 01)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c2)
00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
00:12.0 VGA compatible controller: Silicon Motion, Inc. SM712 LynxEM+
(rev a0)
00:13.0 Ethernet controller: Intel Corp. 82559ER (rev 10)

------

Here is my dmesg after the driver are loaded:

-----------
Linux version 2.6.10 (root@rcf03) (gcc version 3.3.5 (Debian
1:3.3.5-12)) #1 Wed Jul 20 10:09:52 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28656 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 AWARD                                 ) @ 0x000f7200
ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x07ff3000
ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x07ff3040
ACPI: DSDT (v001 AWARD  AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x00000000
Built 1 zonelists
Kernel command line: root=3D/dev/hda1 ro console=3Dtty0
console=3DttyS0,115200n8 pci=3Dbiosirq
Initializing CPU#0
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 400.013 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 126776k/131008k available (1541k kernel code, 3720k reserved,
689k data, 120k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 786.43 BogoMIPS (lpj93216)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps:        0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Celeron(TM) CPU                 400MHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
 tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully
acquired
Parsing all Control
Methods:................................................................
.....................
Table [DSDT](id F004) - 266 Objects with 34 Devices 85 Methods 15
Regions
ACPI Namespace successfully loaded at root c035c760
ACPI: setting ELCR to 0200 (from 0c00)
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode
successful
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfad50, last bus=3D1
PCI: Using configuration type 1
ACPI: Subsystem revision 20041105
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on
int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 2 Wake, Enabled 1
Runtime GPEs in this block
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs on
int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0
Runtime GPEs in this block
Completing Region/Field/Buffer/Package
initialization:.......................................
Initialized 15/15 Regions 0/0 Fields 17/17 Buffers 7/9 Packages (275
nodes)
Executing all Device _STA and_INI
methods:.....................................
37 Devices found containing: 37 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for
object [c7fc1288]
acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for
object [c7fc3e08]
acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for
object [c7fc3c08]
acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for
object [c7fc37c8]
acpi_bus-0081 [03] acpi_bus_get_device   : Error getting context for
object [c7fc3588]
pnp: PnP ACPI: found 12 devices
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=3Drouteirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
ACPI: AC Adapter [AC] (on-line)
ACPI: Processor [CPU0] (supports 2 throttling states)
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:13.0[A] -> GSI 11 (level, low) -> IRQ 11
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
 pci_irq-0324 [02] acpi_pci_irq_derive   : Unable to derive IRQ for
device 0000:00:0f.0
ACPI: PCI interrupt 0000:00:0f.0[A]: no GSI
ALI15X3: chipset revision 194
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: Delkin Devices CF256MB, CFA DISK drive
elevator: using anticipatory as default io scheduler
[...]
i2c /dev entries driver
i2c-core: driver dev_driver registered.
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
 hda: hda1
ali15x3_smbus 0000:00:11.0: SMBREV =3D 0x0
ali15x3_smbus 0000:00:11.0: iALI15X3_smba =3D 0x500
i2c_adapter i2c-0: Registered as minor 0
i2c_adapter i2c-0: registered as adapter #0
i2c_adapter i2c-1: Registered as minor 1
i2c_adapter i2c-1: registered as adapter #1
i2c-core: driver lm87 registered.
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 2c
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD=1C, ADDX,
DAT07, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT=00, CMD=1C, ADDX,
DAT07, DAT1=14
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT , CMD?, ADDY,
DAT07, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT , CMD?, ADDY,
DAT0=06, DAT1=14
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT , CMD@, ADDY,
DAT0=06, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT , CMD@, ADDY,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT , CMD>, ADDY,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT , CMD>, ADDY,
DAT0=02, DAT1=14
i2c_adapter i2c-0: client [lm87] registered to adapter
registering 0-002c
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT , CMD=16, ADDY,
DAT0=02, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT , CMD=16, ADDY,
DAT0=00, DAT1=14
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT , CMD@, ADDY,
DAT0=00, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT , CMD@, ADDY,
DAT0=05, DAT1=14
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 2d
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADDZ,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Error: no response or bus collision ADDZ
i2c_adapter i2c-0: Transaction (post): STSD, CNT=00, CMD@, ADDZ,
DAT0=05, DAT1=14
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 2e
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADD\,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Error: no response or bus collision ADD\
i2c_adapter i2c-0: Transaction (post): STSD, CNT=00, CMD@, ADD\,
DAT0=05, DAT1=14
i2c-core: driver eeprom registered.
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 50
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADD=A0,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Error: no response or bus collision ADD=A0
i2c_adapter i2c-0: Transaction (post): STSD, CNT=00, CMD@, ADD=A0,
DAT0=05, DAT1=14
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 51
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADD=A2,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT=00, CMD@, ADD=A2,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADD=A2,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT=00, CMD@, ADD=A2,
DAT0=05, DAT1=14
i2c_adapter i2c-0: client [eeprom] registered to adapter
registering 0-0051
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 52
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADD=A4,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT=00, CMD@, ADD=A4,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADD=A4,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT=00, CMD@, ADD=A4,
DAT0=05, DAT1=14
i2c_adapter i2c-0: client [eeprom] registered to adapter
registering 0-0052
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 53
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADD=A6,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT=00, CMD@, ADD=A6,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADD=A6,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Transaction (post): STS=14, CNT=00, CMD@, ADD=A6,
DAT0=05, DAT1=14
i2c_adapter i2c-0: client [eeprom] registered to adapter
registering 0-0053
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 54
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADD=A8,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Error: no response or bus collision ADD=A8
i2c_adapter i2c-0: Transaction (post): STSD, CNT=00, CMD@, ADD=A8,
DAT0=05, DAT1=14
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 55
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADD=AA,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Error: no response or bus collision ADD=AA
i2c_adapter i2c-0: Transaction (post): STSD, CNT=00, CMD@, ADD=AA,
DAT0=05, DAT1=14
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 56
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADD=AC,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Error: no response or bus collision ADD=AC
i2c_adapter i2c-0: Transaction (post): STSD, CNT=00, CMD@, ADD=AC,
DAT0=05, DAT1=14
i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr 57
i2c_adapter i2c-0: Transaction (pre): STS=04, CNT=00, CMD@, ADD=AE,
DAT0=05, DAT1=14
i2c_adapter i2c-0: Error: no response or bus collision ADD=AE
i2c_adapter i2c-0: Transaction (post): STSD, CNT=00, CMD@, ADD=AE,
DAT0=05, DAT1=14

