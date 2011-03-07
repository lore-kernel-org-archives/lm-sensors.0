From: Munir Bandukwala <munirb@riverbed.com>
Date: Mon, 07 Mar 2011 19:10:00 +0000
Subject: [lm-sensors] Writing to AT24C64C EEPROM fails on RHEL based kernels
Message-Id: <4D752D88.20908@riverbed.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020606050704040604000706"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020606050704040604000706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hello i2c gurus,

I have a machine which has the AT24C64C eeprom chip, I have been trying to write to it via i2c and have been having issues on CentOS5.3 as well as "Red Hat Enterprise Linux Server release 6.0 Beta (Santiago)". I can write to the EEPROM succesfully when I use Ubuntu10.04LTS as well as upstream kernel v2.6.35 compiled from source on the same machine.

While looking for patches, I came accross https://bugzilla.redhat.com/show_bug.cgi?id=182687 and adding an extra delay in the piix4_transaction function fixes the problem for me as well.

Also it seems that the read operation to the chip succeeds, its only the write that fails consistently. If I try writes in a loop, it succeeds once in about 10-13 tries.

I think the problems are related, but any pointers would be appreciated. I am pasting information about my machine, please let me know if you guys needs any more information

Thanks
--Munir

Steps to repro:
==============
To test I have been using the eeprog program (http://codesink.org/eeprog.html)
Execute the following command to write to eeprom
[root@localhost eeprog-0.7.6]# echo "MMMMMM" | ./eeprog -16 -w 0x0 /dev/i2c-0 0x51 -f
eeprog 0.7.6, a 24Cxx EEPROM reader/writer
Copyright (c) 2003-2004 by Stefano Barbato - All rights reserved.
   Bus: /dev/i2c-0, Address: 0x51, Mode: 16bit
   Writing stdin starting at address 0x0
..Error i2c_write_3b: No such device or address
Error at line 150: write error



Information about the server:
============================
[root@localhost eeprog-0.7.6]# lsmod
Module                  Size  Used by
i2c_dev                 8697  0
autofs4                27683  3
nfs                   348825  8
lockd                  73984  1 nfs
fscache                46761  1 nfs
nfs_acl                 2677  1 nfs
auth_rpcgss            44862  1 nfs
sunrpc                241694  27 nfs,lockd,nfs_acl,auth_rpcgss
cpufreq_ondemand       10382  8
powernow_k8            16298  1
freq_table              4847  2 cpufreq_ondemand,powernow_k8
ipv6                  320850  54
dm_mirror              14003  0
dm_region_hash         12200  1 dm_mirror
dm_log                 10088  2 dm_mirror,dm_region_hash
edac_core              46087  0
edac_mce_amd            8949  0
i2c_piix4              12574  0
i2c_core               31274  2 i2c_dev,i2c_piix4
sg                     30154  0
shpchp                 33448  0
e1000e                137118  0
ext3                  133453  3
jbd                    54576  1 ext3
mbcache                 7918  1 ext3
sd_mod                 36960  5
crc_t10dif              1507  1 sd_mod
ata_generic             3611  0
pata_acpi               3667  0
pata_atiixp             4177  0
ahci                   38859  4
mpt2sas               151535  0
scsi_transport_sas     35036  1 mpt2sas
raid_class              4738  1 mpt2sas
dm_mod                 74162  2 dm_mirror,dm_log

[root@localhost eeprog-0.7.6]# lspci -nvv -s 00:14.0
00:14.0 0c05: 1002:4385 (rev 3d)
	Subsystem: 1002:4385
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium>TAbort-<TAbort-<MAbort->SERR-<PERR- INTx-
	Capabilities: [b0] HyperTransport: MSI Mapping Enable- Fixed+
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c-piix4
[root@localhost eeprog-0.7.6]# lspci
00:00.0 Host bridge: ATI Technologies Inc RD890 Northbridge only dual slot (2x16) PCI-e GFX Hydra part (rev 02)
00:04.0 PCI bridge: ATI Technologies Inc RD890 PCI to PCI bridge (PCI express gpp port D)
00:05.0 PCI bridge: ATI Technologies Inc RD890 PCI to PCI bridge (PCI express gpp port E)
00:06.0 PCI bridge: ATI Technologies Inc RD890 PCI to PCI bridge (PCI express gpp port F)
00:07.0 PCI bridge: ATI Technologies Inc RD890 PCI to PCI bridge (PCI express gpp port G)
00:09.0 PCI bridge: ATI Technologies Inc RD890 PCI to PCI bridge (PCI express gpp port H)
00:0a.0 PCI bridge: ATI Technologies Inc RD890 PCI to PCI bridge (external gfx1 port A)
00:0c.0 PCI bridge: ATI Technologies Inc Device 5a20
00:0d.0 PCI bridge: ATI Technologies Inc RD890 PCI to PCI bridge (external gfx1 port B)
00:11.0 SATA controller: ATI Technologies Inc SB700/SB800 SATA Controller [AHCI mode]
00:12.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Controller
00:12.1 USB Controller: ATI Technologies Inc SB700 USB OHCI1 Controller
00:12.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Controller
00:13.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Controller
00:13.1 USB Controller: ATI Technologies Inc SB700 USB OHCI1 Controller
00:13.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Controller
00:14.0 SMBus: ATI Technologies Inc SBx00 SMBus Controller (rev 3d)
00:14.1 IDE interface: ATI Technologies Inc SB700/SB800 IDE Controller
00:14.3 ISA bridge: ATI Technologies Inc SB700/SB800 LPC host controller
00:14.4 PCI bridge: ATI Technologies Inc SBx00 PCI to PCI Bridge
00:14.5 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI2 Controller
00:18.0 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] HyperTransport Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] Miscellaneous Control
00:18.4 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] Link Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] HyperTransport Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] Miscellaneous Control
00:19.4 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64, Sempron] Link Control
02:00.0 PCI bridge: ASPEED Technology, Inc. Device 1150 (rev 02)
03:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 10)
04:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon] (rev 03)
05:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
06:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
07:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
08:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
09:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
0a:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
40:00.0 Host bridge: ATI Technologies Inc RD890 PCI to PCI bridge (external gfx0 port A) (rev 02)

[root@localhost eeprog-0.7.6]# uname -a
Linux localhost.localdomain 2.6.32-37.el6.x86_64 #1 SMP Sun Jun 20 19:29:35 EDT 2010 x86_64 x86_64 x86_64 GNU/Linux
[root@localhost eeprog-0.7.6]# cat /etc/redhat-release
Red Hat Enterprise Linux Server release 6.0 Beta (Santiago)




--------------020606050704040604000706
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg"

Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.32-37.el6.x86_64 (mockbuild@x86-002.build.bos.redhat.com) (gcc version 4.4.4 20100611 (Red Hat 4.4.4-8) (GCC) ) #1 SMP Sun Jun 20 19:29:35 EDT 2010
Command line: ro root=UUID=f15716c4-e9ce-4c48-8801-c241a3d2bdf6 rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us crashkernel=auto rhgb quiet
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  Centaur CentaurHauls
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000094c00 (usable)
 BIOS-e820: 0000000000094c00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dfe90000 (usable)
 BIOS-e820: 00000000dfe90000 - 00000000dfea2000 (ACPI data)
 BIOS-e820: 00000000dfea2000 - 00000000dfed0000 (ACPI NVS)
 BIOS-e820: 00000000dfed0000 - 00000000dfee0000 (reserved)
 BIOS-e820: 00000000dfeed000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000420000000 (usable)
DMI present.
AMI BIOS detected: BIOS may corrupt low RAM, working around it.
e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
last_pfn = 0x420000 max_arch_pfn = 0x400000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-EFFFF uncachable
  F0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 000000000000 mask FFFF80000000 write-back
  1 base 000080000000 mask FFFFC0000000 write-back
  2 base 0000C0000000 mask FFFFE0000000 write-back
  3 disabled
  4 disabled
  5 disabled
  6 disabled
  7 disabled
TOM2: 0000000420000000 aka 16896M
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
e820 update range: 00000000e0000000 - 0000000100000000 (usable) ==> (reserved)
last_pfn = 0xdfe90 max_arch_pfn = 0x400000000
initial memory mapped : 0 - 20000000
Using GB pages for direct mapping
init_memory_mapping: 0000000000000000-00000000dfe90000
 0000000000 - 00c0000000 page 1G
 00c0000000 - 00dfe00000 page 2M
 00dfe00000 - 00dfe90000 page 4k
kernel direct mapping tables up to dfe90000 @ 10000-13000
init_memory_mapping: 0000000100000000-0000000420000000
 0100000000 - 0400000000 page 1G
 0400000000 - 0420000000 page 2M
kernel direct mapping tables up to 420000000 @ 12000-14000
RAMDISK: 3737d000 - 37fefe41
ACPI: RSDP 00000000000f98d0 00024 (v02 ACPIAM)
ACPI: XSDT 00000000dfe90100 00064 (v01 020911 XSDT1502 20110209 MSFT 00000097)
ACPI: FACP 00000000dfe90290 000F4 (v04 020911 FACP1502 20110209 MSFT 00000097)
ACPI Warning: Optional field Pm2ControlBlock has zero address or length: 0000000000000000/1 (20090903/tbfadt-557)
ACPI: DSDT 00000000dfe904a0 059D1 (v02  8229_ 8229_001 00000001 INTL 20051117)
ACPI: FACS 00000000dfea2000 00040
ACPI: APIC 00000000dfe90390 000CA (v02 020911 APIC1502 20110209 MSFT 00000097)
ACPI: MCFG 00000000dfe90460 0003C (v01 020911 OEMMCFG  20110209 MSFT 00000097)
ACPI: OEMB 00000000dfea2040 000CB (v01 020911 OEMB1502 20110209 MSFT 00000097)
ACPI: HPET 00000000dfe9a4a0 00038 (v01 020911 OEMHPET  20110209 MSFT 00000097)
ACPI: SRAT 00000000dfe9a4e0 00150 (v02 AMD    F10      00000001 AMD  00000001)
ACPI: SLIT 00000000dfe9a630 00030 (v01 AMD    F10      00000001 AMD  00000001)
ACPI: SSDT 00000000dfe9a660 0143C (v01 A M I  POWERNOW 00000001 AMD  00000001)
ACPI: Local APIC address 0xfee00000
SRAT: PXM 0 -> APIC 8 -> Node 0
SRAT: PXM 0 -> APIC 9 -> Node 0
SRAT: PXM 0 -> APIC 10 -> Node 0
SRAT: PXM 0 -> APIC 11 -> Node 0
SRAT: PXM 1 -> APIC 16 -> Node 1
SRAT: PXM 1 -> APIC 17 -> Node 1
SRAT: PXM 1 -> APIC 18 -> Node 1
SRAT: PXM 1 -> APIC 19 -> Node 1
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 100000-e0000000
SRAT: Node 0 PXM 0 100000000-220000000
SRAT: Node 1 PXM 1 220000000-420000000
NUMA: Allocated memnodemap from 13040 - 1b480
NUMA: Using 20 for the hash shift.
Bootmem setup node 0 0000000000000000-0000000220000000
  NODE_DATA [000000000001b480 - 000000000004f47f]
  bootmap [0000000000050000 -  0000000000093fff] pages 44
(10 early reservations) ==> bootmem [0000000000 - 0220000000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
  #2 [0001000000 - 0001cb7098]    TEXT DATA BSS ==> [0001000000 - 0001cb7098]
  #3 [003737d000 - 0037fefe41]          RAMDISK ==> [003737d000 - 0037fefe41]
  #4 [0000094c00 - 0000100000]    BIOS reserved ==> [0000094c00 - 0000100000]
  #5 [0001cb8000 - 0001cb81eb]              BRK ==> [0001cb8000 - 0001cb81eb]
  #6 [0000010000 - 0000012000]          PGTABLE ==> [0000010000 - 0000012000]
  #7 [0000012000 - 0000013000]          PGTABLE ==> [0000012000 - 0000013000]
  #8 [0000013000 - 0000013030]        ACPI SLIT ==> [0000013000 - 0000013030]
  #9 [0000013040 - 000001b480]       MEMNODEMAP ==> [0000013040 - 000001b480]
Bootmem setup node 1 0000000220000000-0000000420000000
  NODE_DATA [0000000220000000 - 0000000220033fff]
  bootmap [0000000220034000 -  0000000220073fff] pages 40
(10 early reservations) ==> bootmem [0220000000 - 0420000000]
  #0 [0000000000 - 0000001000]   BIOS data page
  #1 [0000006000 - 0000008000]       TRAMPOLINE
  #2 [0001000000 - 0001cb7098]    TEXT DATA BSS
  #3 [003737d000 - 0037fefe41]          RAMDISK
  #4 [0000094c00 - 0000100000]    BIOS reserved
  #5 [0001cb8000 - 0001cb81eb]              BRK
  #6 [0000010000 - 0000012000]          PGTABLE
  #7 [0000012000 - 0000013000]          PGTABLE
  #8 [0000013000 - 0000013030]        ACPI SLIT
  #9 [0000013040 - 000001b480]       MEMNODEMAP
found SMP MP-table at [ffff8800000ff780] ff780
Reserving 129MB of memory at 32MB for crashkernel (System RAM: 16896MB)
[ffffea0007700000-ffffea00077fffff] potential offnode page_structs
 [ffffea0000000000-ffffea00077fffff] PMD -> [ffff880028600000-ffff88002f7fffff] on node 0
 [ffffea0007800000-ffffea000e7fffff] PMD -> [ffff880220200000-ffff8802271fffff] on node 1
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  DMA32    0x00001000 -> 0x00100000
  Normal   0x00100000 -> 0x00420000
Movable zone start PFN for each node
early_node_map[4] active PFN ranges
    0: 0x00000010 -> 0x00000094
    0: 0x00000100 -> 0x000dfe90
    0: 0x00100000 -> 0x00220000
    1: 0x00220000 -> 0x00420000
On node 0 totalpages: 2096660
  DMA zone: 56 pages used for memmap
  DMA zone: 121 pages reserved
  DMA zone: 3795 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 898760 pages, LIFO batch:31
  Normal zone: 16128 pages used for memmap
  Normal zone: 1163520 pages, LIFO batch:31
On node 1 totalpages: 2097152
  Normal zone: 28672 pages used for memmap
  Normal zone: 2068480 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x08] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x09] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x0a] enabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x0b] enabled)
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x10] enabled)
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x11] enabled)
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x12] enabled)
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x13] enabled)
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x88] disabled)
ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x89] disabled)
ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x8a] disabled)
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x8b] disabled)
ACPI: LAPIC_NMI (acpi_id[0xff] high dfl lint[0x1])
ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x01] address[0xfec20000] gsi_base[24])
IOAPIC[1]: apic_id 1, version 33, address 0xfec20000, GSI 24-55
ACPI: IOAPIC (id[0x02] address[0xfa000000] gsi_base[56])
IOAPIC[2]: apic_id 2, version 33, address 0xfa000000, GSI 56-87
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8300 base: 0xfed00000
SMP: Allowing 12 CPUs, 4 hotplug CPUs
nr_irqs_gsi: 88
PM: Registered nosave memory: 0000000000094000 - 0000000000095000
PM: Registered nosave memory: 0000000000095000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000e6000
PM: Registered nosave memory: 00000000000e6000 - 0000000000100000
PM: Registered nosave memory: 00000000dfe90000 - 00000000dfea2000
PM: Registered nosave memory: 00000000dfea2000 - 00000000dfed0000
PM: Registered nosave memory: 00000000dfed0000 - 00000000dfee0000
PM: Registered nosave memory: 00000000dfee0000 - 00000000dfeed000
PM: Registered nosave memory: 00000000dfeed000 - 00000000f0000000
PM: Registered nosave memory: 00000000f0000000 - 00000000ffc00000
PM: Registered nosave memory: 00000000ffc00000 - 0000000100000000
Allocating PCI resources starting at f0000000 (gap: f0000000:fc00000)
Booting paravirtualized kernel on bare hardware
NR_CPUS:4096 nr_cpumask_bits:12 nr_cpu_ids:12 nr_node_ids:2
PERCPU: Embedded 31 pages/cpu @ffff880028200000 s94744 r8192 d24040 u262144
pcpu-alloc: s94744 r8192 d24040 u262144 alloc=1*2097152
pcpu-alloc: [0] 00 01 02 03 08 10 -- -- [1] 04 05 06 07 09 11 -- -- 
Built 2 zonelists in Zone order, mobility grouping on.  Total pages: 4134555
Policy zone: Normal
Kernel command line: ro root=UUID=f15716c4-e9ce-4c48-8801-c241a3d2bdf6 rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us crashkernel=129M@0M rhgb quiet
PID hash table entries: 4096 (order: 3, 32768 bytes)
Checking aperture...
No AGP bridge found
Node 0: aperture @ 2462000000 size 32 MB
Aperture beyond 4GB. Ignoring.
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 20000000
PM: Registered nosave memory: 0000000020000000 - 0000000024000000
Memory: 16317980k/17301504k available (4998k kernel code, 526256k absent, 457268k reserved, 3964k data, 1220k init)
Hierarchical RCU implementation.
NR_IRQS:33024 nr_irqs:1592
Extended CMOS year: 2000
Console: colour VGA+ 80x25
console [tty0] enabled
allocated 167772160 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
hpet clockevent registered
  alloc irq_desc for 88 on node 0
  alloc kstat_irqs on node 0
HPET: 4 timers in total, 1 timers will be used for per-cpu timer
Fast TSC calibration using PIT
Detected 2300.419 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.. 4600.83 BogoMIPS (lpj=2300416)
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Mount-cache hash table entries: 256
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
Initializing cgroup subsys blkio
tseg: 00dff00000
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 6 MCE banks
Performance Events: AMD PMU driver.
... version:                0
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   0
... event mask:             000000000000000f
ACPI: Core revision 20090903
ftrace: converting mcount calls to 0f 1f 44 00 00
ftrace: allocating 20453 entries in 81 pages
Setting APIC routing to physical flat
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Embedded AMD Opteron(tm) Processor 41LE HE stepping 01
Booting Node   0, Processors  #1
------------[ cut here ]------------
WARNING: at arch/x86/kernel/cpu/perf_event_amd.c:326 amd_pmu_cpu_starting+0x120/0x160() (Not tainted)
Hardware name: empty
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.32-37.el6.x86_64 #1
Call Trace:
 [<ffffffff8106a703>] warn_slowpath_common+0x83/0xc0
 [<ffffffff8106a754>] warn_slowpath_null+0x14/0x20
 [<ffffffff81024e90>] amd_pmu_cpu_starting+0x120/0x160
 [<ffffffff814cec19>] x86_pmu_notifier+0x5c/0x6a
 [<ffffffff814dd285>] notifier_call_chain+0x55/0x80
 [<ffffffff81095bf6>] raw_notifier_call_chain+0x16/0x20
 [<ffffffff814d2a37>] notify_cpu_starting+0x36/0x38
 [<ffffffff814d0f49>] start_secondary+0x11a/0x23f
---[ end trace a7919e7f17c0a725 ]---
 #2 #3 Ok.
Booting Node   1, Processors  #4 #5 #6 #7
Brought up 8 CPUs
Total of 8 processors activated (36803.91 BogoMIPS).
Testing NMI watchdog ... OK.
sizeof(vma)=192 bytes
sizeof(page)=56 bytes
sizeof(inode)=592 bytes
sizeof(dentry)=192 bytes
sizeof(ext3inode)=800 bytes
sizeof(buffer_head)=104 bytes
sizeof(skbuff)=232 bytes
sizeof(task_struct)=2600 bytes
devtmpfs: initialized
regulator: core version 0.5
NET: Registered protocol family 16
node 0 link 0: io port [2000, efff]
TOM: 00000000e0000000 aka 3584M
Fam 10h mmconf [e0000000, efffffff]
node 0 link 0: mmio [fc000000, febfffff]
node 0 link 1: mmio [fa000000, fbffffff]
node 0 link 0: mmio [e0000000, f9ffffff] ==> [f0000000, f9ffffff]
node 0 link 0: mmio [a0000, bffff]
node 0 link 0: mmio [fec00000, ffffffff]
TOM2: 0000000420000000 aka 16896M
bus: [00,0a] on node 0 link 0
bus: 00 index 0 io port: [0, ffff]
bus: 00 index 1 mmio: [fc000000, ffffffff]
bus: 00 index 2 mmio: [f0000000, f9ffffff]
bus: 00 index 3 mmio: [a0000, bffff]
bus: 00 index 4 mmio: [420000000, fcffffffff]
bus: [40,40] on node 0 link 1
bus: 40 index 0 mmio: [fa000000, fbffffff]
ACPI: bus type pci registered
PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
PCI: MCFG area at e0000000 reserved in E820
PCI: Using MMCONFIG at e0000000 - efffffff
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI Error (psargs-0359): [ECEN] Namespace lookup failure, AE_NOT_FOUND
ACPI Error (psparse-0537): Method parse/execution failed [\] (Node ffffffff81c1b450), AE_NOT_FOUND
ACPI: Executed 2 blocks of module-level executable AML code
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: No dock devices found.
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
pci 0000:00:04.0: PME# disabled
pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
pci 0000:00:05.0: PME# disabled
pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
pci 0000:00:06.0: PME# disabled
pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
pci 0000:00:07.0: PME# disabled
pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
pci 0000:00:09.0: PME# disabled
pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
pci 0000:00:0a.0: PME# disabled
pci 0000:00:0c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:0c.0: PME# disabled
pci 0000:00:0d.0: PME# supported from D0 D3hot D3cold
pci 0000:00:0d.0: PME# disabled
pci 0000:00:11.0: reg 10 io port: [0x6000-0x6007]
pci 0000:00:11.0: reg 14 io port: [0x5000-0x5003]
pci 0000:00:11.0: reg 18 io port: [0x4000-0x4007]
pci 0000:00:11.0: reg 1c io port: [0x3000-0x3003]
pci 0000:00:11.0: reg 20 io port: [0x2000-0x200f]
pci 0000:00:11.0: reg 24 32bit mmio: [0xfe4fa400-0xfe4fa7ff]
pci 0000:00:12.0: reg 10 32bit mmio: [0xfe4f6000-0xfe4f6fff]
pci 0000:00:12.1: reg 10 32bit mmio: [0xfe4f7000-0xfe4f7fff]
pci 0000:00:12.2: reg 10 32bit mmio: [0xfe4fa800-0xfe4fa8ff]
pci 0000:00:12.2: supports D1 D2
pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
pci 0000:00:12.2: PME# disabled
pci 0000:00:13.0: reg 10 32bit mmio: [0xfe4f8000-0xfe4f8fff]
pci 0000:00:13.1: reg 10 32bit mmio: [0xfe4f9000-0xfe4f9fff]
pci 0000:00:13.2: reg 10 32bit mmio: [0xfe4fac00-0xfe4facff]
pci 0000:00:13.2: supports D1 D2
pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
pci 0000:00:13.2: PME# disabled
pci 0000:00:14.1: reg 10 io port: [0x00-0x07]
pci 0000:00:14.1: reg 14 io port: [0x00-0x03]
pci 0000:00:14.1: reg 18 io port: [0x00-0x07]
pci 0000:00:14.1: reg 1c io port: [0x00-0x03]
pci 0000:00:14.1: reg 20 io port: [0xff00-0xff0f]
pci 0000:00:14.5: reg 10 32bit mmio: [0xfe4fb000-0xfe4fbfff]
PCI: peer root bus 00 res updated from pci conf
pci 0000:0a:00.0: reg 10 32bit mmio: [0xfebe0000-0xfebfffff]
pci 0000:0a:00.0: reg 18 io port: [0xe800-0xe81f]
pci 0000:0a:00.0: reg 1c 32bit mmio: [0xfebdc000-0xfebdffff]
pci 0000:0a:00.0: PME# supported from D0 D3hot D3cold
pci 0000:0a:00.0: PME# disabled
pci 0000:00:04.0: bridge io port: [0xe000-0xefff]
pci 0000:00:04.0: bridge 32bit mmio: [0xfeb00000-0xfebfffff]
pci 0000:09:00.0: reg 10 32bit mmio: [0xfeae0000-0xfeafffff]
pci 0000:09:00.0: reg 18 io port: [0xd800-0xd81f]
pci 0000:09:00.0: reg 1c 32bit mmio: [0xfeadc000-0xfeadffff]
pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
pci 0000:09:00.0: PME# disabled
pci 0000:00:05.0: bridge io port: [0xd000-0xdfff]
pci 0000:00:05.0: bridge 32bit mmio: [0xfea00000-0xfeafffff]
pci 0000:08:00.0: reg 10 32bit mmio: [0xfe9e0000-0xfe9fffff]
pci 0000:08:00.0: reg 18 io port: [0xc800-0xc81f]
pci 0000:08:00.0: reg 1c 32bit mmio: [0xfe9dc000-0xfe9dffff]
pci 0000:08:00.0: PME# supported from D0 D3hot D3cold
pci 0000:08:00.0: PME# disabled
pci 0000:00:06.0: bridge io port: [0xc000-0xcfff]
pci 0000:00:06.0: bridge 32bit mmio: [0xfe900000-0xfe9fffff]
pci 0000:07:00.0: reg 10 32bit mmio: [0xfe8e0000-0xfe8fffff]
pci 0000:07:00.0: reg 18 io port: [0xb800-0xb81f]
pci 0000:07:00.0: reg 1c 32bit mmio: [0xfe8dc000-0xfe8dffff]
pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
pci 0000:07:00.0: PME# disabled
pci 0000:00:07.0: bridge io port: [0xb000-0xbfff]
pci 0000:00:07.0: bridge 32bit mmio: [0xfe800000-0xfe8fffff]
pci 0000:06:00.0: reg 10 32bit mmio: [0xfe7e0000-0xfe7fffff]
pci 0000:06:00.0: reg 18 io port: [0xa800-0xa81f]
pci 0000:06:00.0: reg 1c 32bit mmio: [0xfe7dc000-0xfe7dffff]
pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
pci 0000:06:00.0: PME# disabled
pci 0000:00:09.0: bridge io port: [0xa000-0xafff]
pci 0000:00:09.0: bridge 32bit mmio: [0xfe700000-0xfe7fffff]
pci 0000:05:00.0: reg 10 32bit mmio: [0xfe6e0000-0xfe6fffff]
pci 0000:05:00.0: reg 18 io port: [0x9800-0x981f]
pci 0000:05:00.0: reg 1c 32bit mmio: [0xfe6dc000-0xfe6dffff]
pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
pci 0000:05:00.0: PME# disabled
pci 0000:00:0a.0: bridge io port: [0x9000-0x9fff]
pci 0000:00:0a.0: bridge 32bit mmio: [0xfe600000-0xfe6fffff]
pci 0000:04:00.0: reg 10 io port: [0x8000-0x80ff]
pci 0000:04:00.0: reg 14 64bit mmio: [0xfe53c000-0xfe53ffff]
pci 0000:04:00.0: reg 1c 64bit mmio: [0xfe540000-0xfe57ffff]
pci 0000:04:00.0: reg 30 32bit mmio pref: [0xfe580000-0xfe5fffff]
pci 0000:04:00.0: supports D1 D2
pci 0000:00:0c.0: bridge io port: [0x8000-0x8fff]
pci 0000:00:0c.0: bridge 32bit mmio: [0xfe500000-0xfe5fffff]
pci 0000:02:00.0: supports D1 D2
pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:02:00.0: PME# disabled
pci 0000:00:0d.0: bridge io port: [0x7000-0x7fff]
pci 0000:00:0d.0: bridge 32bit mmio: [0xfd700000-0xfdffffff]
pci 0000:03:00.0: reg 10 32bit mmio: [0xfd800000-0xfdffffff]
pci 0000:03:00.0: reg 14 32bit mmio: [0xfd7e0000-0xfd7fffff]
pci 0000:03:00.0: reg 18 io port: [0x7800-0x787f]
pci 0000:03:00.0: supports D1 D2
pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:03:00.0: PME# disabled
pci 0000:02:00.0: bridge io port: [0x7000-0x7fff]
pci 0000:02:00.0: bridge 32bit mmio: [0xfd700000-0xfdffffff]
pci 0000:00:14.4: transparent bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC04._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC05._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC06._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC07._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC09._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC0A._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC0C._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PC0D._PRT]
ACPI: PCI Root Bridge [PC40] (0000:40)
PCI: peer root bus 40 res updated from pci conf
ACPI: PCI Interrupt Routing Table [\_SB_.PC40._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 *10 11 12 14 15)
vgaarb: device added: PCI:0000:03:00.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 88, 0
hpet0: 4 comparators, 32-bit 14.318180 MHz counter
Switching to clocksource tsc
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 18 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: iomem range 0xfec20000-0xfec200ff could not be reserved
system 00:02: iomem range 0xffffff00-0x100003eff could not be reserved
system 00:08: iomem range 0xfec00000-0xfec00fff could not be reserved
system 00:08: iomem range 0xfee00000-0xfee00fff has been reserved
system 00:09: ioport range 0x4d0-0x4d1 has been reserved
system 00:09: ioport range 0x40b-0x40b has been reserved
system 00:09: ioport range 0x4d6-0x4d6 has been reserved
system 00:09: ioport range 0xc00-0xc01 has been reserved
system 00:09: ioport range 0xc14-0xc14 has been reserved
system 00:09: ioport range 0xc50-0xc51 has been reserved
system 00:09: ioport range 0xc52-0xc52 has been reserved
system 00:09: ioport range 0xc6c-0xc6c has been reserved
system 00:09: ioport range 0xc6f-0xc6f has been reserved
system 00:09: ioport range 0xcd0-0xcd1 has been reserved
system 00:09: ioport range 0xcd2-0xcd3 has been reserved
system 00:09: ioport range 0xcd4-0xcd5 has been reserved
system 00:09: ioport range 0xcd6-0xcd7 has been reserved
system 00:09: ioport range 0xcd8-0xcdf has been reserved
system 00:09: ioport range 0x800-0x89f has been reserved
system 00:09: ioport range 0xb00-0xb0f has been reserved
system 00:09: ioport range 0xb20-0xb3f has been reserved
system 00:09: ioport range 0x900-0x90f has been reserved
system 00:09: ioport range 0x910-0x91f has been reserved
system 00:09: ioport range 0xfe00-0xfefe has been reserved
system 00:09: iomem range 0xffb80000-0xffbfffff has been reserved
system 00:09: iomem range 0xfec10000-0xfec1001f has been reserved
system 00:0c: iomem range 0xe0000000-0xefffffff has been reserved
system 00:0e: iomem range 0x0-0x9ffff could not be reserved
system 00:0e: iomem range 0xc0000-0xcffff has been reserved
system 00:0e: iomem range 0xe0000-0xfffff could not be reserved
system 00:0e: iomem range 0x100000-0xfbffffff could not be reserved
system 00:0e: iomem range 0xfec00000-0xffffffff could not be reserved
system 00:10: iomem range 0xfa000000-0xfa0000ff could not be reserved
system 00:11: iomem range 0xffffff00-0x100003eff could not be reserved
pci 0000:00:04.0: PCI bridge, secondary bus 0000:0a
pci 0000:00:04.0:   bridge window [0xe000-0xefff]
pci 0000:00:04.0:   bridge window [0xfeb00000-0xfebfffff]
pci 0000:00:04.0:   bridge window [mem pref disabled]
pci 0000:00:05.0: PCI bridge, secondary bus 0000:09
pci 0000:00:05.0:   bridge window [0xd000-0xdfff]
pci 0000:00:05.0:   bridge window [0xfea00000-0xfeafffff]
pci 0000:00:05.0:   bridge window [mem pref disabled]
pci 0000:00:06.0: PCI bridge, secondary bus 0000:08
pci 0000:00:06.0:   bridge window [0xc000-0xcfff]
pci 0000:00:06.0:   bridge window [0xfe900000-0xfe9fffff]
pci 0000:00:06.0:   bridge window [mem pref disabled]
pci 0000:00:07.0: PCI bridge, secondary bus 0000:07
pci 0000:00:07.0:   bridge window [0xb000-0xbfff]
pci 0000:00:07.0:   bridge window [0xfe800000-0xfe8fffff]
pci 0000:00:07.0:   bridge window [mem pref disabled]
pci 0000:00:09.0: PCI bridge, secondary bus 0000:06
pci 0000:00:09.0:   bridge window [0xa000-0xafff]
pci 0000:00:09.0:   bridge window [0xfe700000-0xfe7fffff]
pci 0000:00:09.0:   bridge window [mem pref disabled]
pci 0000:00:0a.0: PCI bridge, secondary bus 0000:05
pci 0000:00:0a.0:   bridge window [0x9000-0x9fff]
pci 0000:00:0a.0:   bridge window [0xfe600000-0xfe6fffff]
pci 0000:00:0a.0:   bridge window [mem pref disabled]
pci 0000:00:0c.0: PCI bridge, secondary bus 0000:04
pci 0000:00:0c.0:   bridge window [0x8000-0x8fff]
pci 0000:00:0c.0:   bridge window [0xfe500000-0xfe5fffff]
pci 0000:00:0c.0:   bridge window [mem pref disabled]
pci 0000:02:00.0: PCI bridge, secondary bus 0000:03
pci 0000:02:00.0:   bridge window [0x7000-0x7fff]
pci 0000:02:00.0:   bridge window [0xfd700000-0xfdffffff]
pci 0000:02:00.0:   bridge window [mem pref disabled]
pci 0000:00:0d.0: PCI bridge, secondary bus 0000:02
pci 0000:00:0d.0:   bridge window [0x7000-0x7fff]
pci 0000:00:0d.0:   bridge window [0xfd700000-0xfdffffff]
pci 0000:00:0d.0:   bridge window [mem pref disabled]
pci 0000:00:14.4: PCI bridge, secondary bus 0000:01
pci 0000:00:14.4:   bridge window [io  disabled]
pci 0000:00:14.4:   bridge window [mem disabled]
pci 0000:00:14.4:   bridge window [mem pref disabled]
  alloc irq_desc for 52 on node 0
  alloc kstat_irqs on node 0
pci 0000:00:04.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
pci 0000:00:04.0: setting latency timer to 64
pci 0000:00:05.0: PCI INT A -> GSI 52 (level, low) -> IRQ 52
pci 0000:00:05.0: setting latency timer to 64
  alloc irq_desc for 53 on node 0
  alloc kstat_irqs on node 0
pci 0000:00:06.0: PCI INT A -> GSI 53 (level, low) -> IRQ 53
pci 0000:00:06.0: setting latency timer to 64
pci 0000:00:07.0: PCI INT A -> GSI 53 (level, low) -> IRQ 53
pci 0000:00:07.0: setting latency timer to 64
pci 0000:00:09.0: PCI INT A -> GSI 53 (level, low) -> IRQ 53
pci 0000:00:09.0: setting latency timer to 64
  alloc irq_desc for 54 on node 0
  alloc kstat_irqs on node 0
pci 0000:00:0a.0: PCI INT A -> GSI 54 (level, low) -> IRQ 54
pci 0000:00:0a.0: setting latency timer to 64
pci 0000:00:0c.0: PCI INT A -> GSI 54 (level, low) -> IRQ 54
pci 0000:00:0c.0: setting latency timer to 64
pci 0000:00:0d.0: PCI INT A -> GSI 54 (level, low) -> IRQ 54
pci 0000:00:0d.0: setting latency timer to 64
  alloc irq_desc for 40 on node 0
  alloc kstat_irqs on node 0
pci 0000:02:00.0: PCI INT A -> GSI 40 (level, low) -> IRQ 40
pci 0000:02:00.0: setting latency timer to 64
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0xfc000000-0xffffffff]
pci_bus 0000:00: resource 2 mem: [0xf0000000-0xf9ffffff]
pci_bus 0000:00: resource 3 mem: [0x0a0000-0x0bffff]
pci_bus 0000:00: resource 4 mem: [0x420000000-0xfcffffffff]
pci_bus 0000:0a: resource 0 io:  [0xe000-0xefff]
pci_bus 0000:0a: resource 1 mem: [0xfeb00000-0xfebfffff]
pci_bus 0000:09: resource 0 io:  [0xd000-0xdfff]
pci_bus 0000:09: resource 1 mem: [0xfea00000-0xfeafffff]
pci_bus 0000:08: resource 0 io:  [0xc000-0xcfff]
pci_bus 0000:08: resource 1 mem: [0xfe900000-0xfe9fffff]
pci_bus 0000:07: resource 0 io:  [0xb000-0xbfff]
pci_bus 0000:07: resource 1 mem: [0xfe800000-0xfe8fffff]
pci_bus 0000:06: resource 0 io:  [0xa000-0xafff]
pci_bus 0000:06: resource 1 mem: [0xfe700000-0xfe7fffff]
pci_bus 0000:05: resource 0 io:  [0x9000-0x9fff]
pci_bus 0000:05: resource 1 mem: [0xfe600000-0xfe6fffff]
pci_bus 0000:04: resource 0 io:  [0x8000-0x8fff]
pci_bus 0000:04: resource 1 mem: [0xfe500000-0xfe5fffff]
pci_bus 0000:02: resource 0 io:  [0x7000-0x7fff]
pci_bus 0000:02: resource 1 mem: [0xfd700000-0xfdffffff]
pci_bus 0000:03: resource 0 io:  [0x7000-0x7fff]
pci_bus 0000:03: resource 1 mem: [0xfd700000-0xfdffffff]
pci_bus 0000:01: resource 3 io:  [0x00-0xffff]
pci_bus 0000:01: resource 4 mem: [0xfc000000-0xffffffff]
pci_bus 0000:01: resource 5 mem: [0xf0000000-0xf9ffffff]
pci_bus 0000:01: resource 6 mem: [0x0a0000-0x0bffff]
pci_bus 0000:01: resource 7 mem: [0x420000000-0xfcffffffff]
pci_bus 0000:40: resource 0 mem: [0xfa000000-0xfbffffff]
pci_bus 0000:40: resource 1 mem: [0x000000-0xffffffffffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
NET: Registered protocol family 1
pci 0000:03:00.0: Boot video device
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 12747k freed
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 20000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
audit: initializing netlink socket (disabled)
type=2000 audit(1299426374.087:1): initialized
HugeTLB registered 2 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
msgmni has been set to 31895
SELinux:  Registering netfilter hooks
alg: No test for stdrng (krng)
ksign: Installing public key data
Loading keyring
- Added public key 574259E21843CD4
- User ID: Red Hat, Inc. (Kernel Module GPG key)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
  alloc irq_desc for 89 on node 0
  alloc kstat_irqs on node 0
pcieport 0000:00:04.0: irq 89 for MSI/MSI-X
pcieport 0000:00:04.0: setting latency timer to 64
  alloc irq_desc for 90 on node 0
  alloc kstat_irqs on node 0
pcieport 0000:00:05.0: irq 90 for MSI/MSI-X
pcieport 0000:00:05.0: setting latency timer to 64
  alloc irq_desc for 91 on node 0
  alloc kstat_irqs on node 0
pcieport 0000:00:06.0: irq 91 for MSI/MSI-X
pcieport 0000:00:06.0: setting latency timer to 64
  alloc irq_desc for 92 on node 0
  alloc kstat_irqs on node 0
pcieport 0000:00:07.0: irq 92 for MSI/MSI-X
pcieport 0000:00:07.0: setting latency timer to 64
  alloc irq_desc for 93 on node 0
  alloc kstat_irqs on node 0
pcieport 0000:00:09.0: irq 93 for MSI/MSI-X
pcieport 0000:00:09.0: setting latency timer to 64
  alloc irq_desc for 94 on node 0
  alloc kstat_irqs on node 0
pcieport 0000:00:0a.0: irq 94 for MSI/MSI-X
pcieport 0000:00:0a.0: setting latency timer to 64
  alloc irq_desc for 95 on node 0
  alloc kstat_irqs on node 0
pcieport 0000:00:0c.0: irq 95 for MSI/MSI-X
pcieport 0000:00:0c.0: setting latency timer to 64
  alloc irq_desc for 96 on node 0
  alloc kstat_irqs on node 0
pcieport 0000:00:0d.0: irq 96 for MSI/MSI-X
pcieport 0000:00:0d.0: setting latency timer to 64
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
pci-stub: invalid id string ""
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
ACPI: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
ACPI: Power Button [PWRF]
processor LNXCPU:00: registered as cooling_device0
processor LNXCPU:01: registered as cooling_device1
processor LNXCPU:02: registered as cooling_device2
processor LNXCPU:03: registered as cooling_device3
processor LNXCPU:04: registered as cooling_device4
processor LNXCPU:05: registered as cooling_device5
processor LNXCPU:06: registered as cooling_device6
processor LNXCPU:07: registered as cooling_device7
xen-platform-pci: failed Xen IOPORT backend handshake: unrecognised magic value
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
crash memory driver: version 1.0
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
brd: module loaded
loop: module loaded
input: Macintosh mouse button emulation as /devices/virtual/input/input2
Fixed MDIO Bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
  alloc irq_desc for 17 on node 0
  alloc kstat_irqs on node 0
ehci_hcd 0000:00:12.2: PCI INT B -> GSI 17 (level, low) -> IRQ 17
ehci_hcd 0000:00:12.2: EHCI Host Controller
ehci_hcd 0000:00:12.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:12.2: debug port 1
ehci_hcd 0000:00:12.2: irq 17, io mem 0xfe4fa800
ehci_hcd 0000:00:12.2: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.32-37.el6.x86_64 ehci_hcd
usb usb1: SerialNumber: 0000:00:12.2
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
  alloc irq_desc for 19 on node 0
  alloc kstat_irqs on node 0
ehci_hcd 0000:00:13.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:13.2: debug port 1
ehci_hcd 0000:00:13.2: irq 19, io mem 0xfe4fac00
ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: EHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.32-37.el6.x86_64 ehci_hcd
usb usb2: SerialNumber: 0000:00:13.2
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
  alloc irq_desc for 16 on node 0
  alloc kstat_irqs on node 0
ohci_hcd 0000:00:12.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:00:12.0: OHCI Host Controller
ohci_hcd 0000:00:12.0: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:12.0: irq 16, io mem 0xfe4f6000
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.32-37.el6.x86_64 ohci_hcd
usb usb3: SerialNumber: 0000:00:12.0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ohci_hcd 0000:00:12.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:00:12.1: OHCI Host Controller
ohci_hcd 0000:00:12.1: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:12.1: irq 16, io mem 0xfe4f7000
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: OHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.32-37.el6.x86_64 ohci_hcd
usb usb4: SerialNumber: 0000:00:12.1
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 3 ports detected
  alloc irq_desc for 18 on node 0
  alloc kstat_irqs on node 0
ohci_hcd 0000:00:13.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:13.0: irq 18, io mem 0xfe4f8000
usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: OHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.32-37.el6.x86_64 ohci_hcd
usb usb5: SerialNumber: 0000:00:13.0
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 3 ports detected
ohci_hcd 0000:00:13.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 6
ohci_hcd 0000:00:13.1: irq 18, io mem 0xfe4f9000
usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb6: Product: OHCI Host Controller
usb usb6: Manufacturer: Linux 2.6.32-37.el6.x86_64 ohci_hcd
usb usb6: SerialNumber: 0000:00:13.1
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 3 ports detected
ohci_hcd 0000:00:14.5: PCI INT C -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:14.5: OHCI Host Controller
ohci_hcd 0000:00:14.5: new USB bus registered, assigned bus number 7
ohci_hcd 0000:00:14.5: irq 18, io mem 0xfe4fb000
usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb7: Product: OHCI Host Controller
usb usb7: Manufacturer: Linux 2.6.32-37.el6.x86_64 ohci_hcd
usb usb7: SerialNumber: 0000:00:14.5
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
PNP: No PS/2 controller found. Probing ports directly.
mice: PS/2 mouse device common for all mice
rtc_cmos 00:04: RTC can wake from S4
rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
nf_conntrack.acct=1 kernel parameter, acct=1 nf_conntrack module option or
sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
registered taskstats version 1
No TPM chip found, activating TPM-bypass!
rtc_cmos 00:04: setting system clock to 2011-03-06 15:46:15 UTC (1299426375)
Initalizing network drop monitor service
Freeing unused kernel memory: 1220k freed
Write protecting the kernel read-only data: 7276k
dracut: dracut-004-20.1.el6
dracut: rd_NO_LUKS: removing cryptoluks activation
dracut: rd_NO_LVM: removing LVM activation
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@redhat.com
udev: starting version 147
usb 2-5: new high speed USB device using ehci_hcd and address 2
dracut: Starting plymouth daemon
dracut: rd_NO_DM: removing DM RAID activation
dracut: rd_NO_MD: removing MD RAID activation
mpt2sas version 05.100.00.02 loaded
scsi0 : Fusion MPT SAS Host
  alloc irq_desc for 36 on node 0
  alloc kstat_irqs on node 0
mpt2sas 0000:04:00.0: PCI INT A -> GSI 36 (level, low) -> IRQ 36
mpt2sas 0000:04:00.0: setting latency timer to 64
mpt2sas0: 64 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (16331948 kB)
  alloc irq_desc for 97 on node 0
  alloc kstat_irqs on node 0
mpt2sas 0000:04:00.0: irq 97 for MSI/MSI-X
mpt2sas0: PCI-MSI-X enabled: IRQ 97
mpt2sas0: iomem(0x00000000fe53c000), mapped(0xffffc90012618000), size(16384)
mpt2sas0: ioport(0x0000000000008000), size(256)
usb 2-5: New USB device found, idVendor=046b, idProduct=ff01
usb 2-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-5: Product: Generic Hub
usb 2-5: Manufacturer: American Megatrends Inc.
usb 2-5: SerialNumber: serial
usb 2-5: configuration #1 chosen from 1 choice
hub 2-5:1.0: USB hub found
hub 2-5:1.0: 3 ports detected
mpt2sas0: sending message unit reset !!
mpt2sas0: message unit reset: SUCCESS
mpt2sas0: Allocated physical memory: size(1028 kB)
mpt2sas0: Current Controller Queue Depth(435), Max Controller Queue Depth(3999)
mpt2sas0: Scatter Gather Elements per IO(128)
mpt2sas0: LSISAS2008: FWVersion(07.00.00.00), ChipRevision(0x03), BiosVersion(07.07.00.00)
mpt2sas0: Protocol=(Initiator,Target), Capabilities=(TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
mpt2sas0: sending port enable !!
mpt2sas0: port enable: SUCCESS
mpt2sas0: host_add: handle(0x0001), sas_addr(0x0000111122225678), phys(8)
ahci 0000:00:11.0: version 3.0
  alloc irq_desc for 22 on node 0
  alloc kstat_irqs on node 0
ahci 0000:00:11.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:11.0: AHCI 0001.0100 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc 
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
scsi6 : ahci
ata1: SATA max UDMA/133 irq_stat 0x00400000, PHY RDY changed irq 22
ata2: SATA max UDMA/133 abar m1024@0xfe4fa400 port 0xfe4fa580 irq 22
ata3: SATA max UDMA/133 abar m1024@0xfe4fa400 port 0xfe4fa600 irq 22
ata4: SATA max UDMA/133 abar m1024@0xfe4fa400 port 0xfe4fa680 irq 22
ata5: SATA max UDMA/133 abar m1024@0xfe4fa400 port 0xfe4fa700 irq 22
ata6: SATA max UDMA/133 abar m1024@0xfe4fa400 port 0xfe4fa780 irq 22
usb 4-3: new low speed USB device using ohci_hcd and address 2
usb 4-3: New USB device found, idVendor=045e, idProduct=00dd
usb 4-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 4-3: Product: Comfort Curve Keyboard 2000
usb 4-3: Manufacturer: Microsoft
usb 4-3: configuration #1 chosen from 1 choice
input: Microsoft Comfort Curve Keyboard 2000 as /devices/pci0000:00/0000:00:12.1/usb4/4-3/4-3:1.0/input/input3
generic-usb 0003:045E:00DD.0001: input,hidraw0: USB HID v1.11 Keyboard [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:12.1-3/input0
input: Microsoft Comfort Curve Keyboard 2000 as /devices/pci0000:00/0000:00:12.1/usb4/4-3/4-3:1.1/input/input4
generic-usb 0003:045E:00DD.0002: input,hidraw1: USB HID v1.11 Device [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:12.1-3/input1
ata6: SATA link down (SStatus 0 SControl 300)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-8: WDC WD5003ABYX-01WERA0, 01.01S01, max UDMA/133
ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata4.00: configured for UDMA/133
ata3.00: ATA-8: WDC WD5003ABYX-01WERA0, 01.01S01, max UDMA/133
ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata3.00: configured for UDMA/133
ata2.00: ATA-8: WDC WD5003ABYX-01WERA0, 01.01S01, max UDMA/133
ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata2.00: configured for UDMA/133
usb 6-3: new full speed USB device using ohci_hcd and address 2
ata5.00: ATA-8: WDC WD1200BEVS-00VAT0, 11.01A11, max UDMA/133
ata5.00: 234441648 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata5.00: configured for UDMA/133
usb 6-3: device descriptor read/64, error -62
usb 6-3: device descriptor read/64, error -62
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: WDC WD5003ABYX-01WERA0, 01.01S01, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
ata1.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      WDC WD5003ABYX-0 01.0 PQ: 0 ANSI: 5
scsi 2:0:0:0: Direct-Access     ATA      WDC WD5003ABYX-0 01.0 PQ: 0 ANSI: 5
scsi 3:0:0:0: Direct-Access     ATA      WDC WD5003ABYX-0 01.0 PQ: 0 ANSI: 5
scsi 4:0:0:0: Direct-Access     ATA      WDC WD5003ABYX-0 01.0 PQ: 0 ANSI: 5
scsi 5:0:0:0: Direct-Access     ATA      WDC WD1200BEVS-0 11.0 PQ: 0 ANSI: 5
pata_atiixp 0000:00:14.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pata_atiixp 0000:00:14.1: setting latency timer to 64
scsi7 : pata_atiixp
scsi8 : pata_atiixp
ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
usb 6-3: new full speed USB device using ohci_hcd and address 3
usb 6-3: device descriptor read/64, error -62
sd 1:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 2:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 4:0:0:0: [sdd] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdc] 976773168 512-byte logical blocks: (500 GB/465 GiB)
sd 5:0:0:0: [sde] 234441648 512-byte logical blocks: (120 GB/111 GiB)
sd 4:0:0:0: [sdd] Write Protect is off
sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sde] Write Protect is off
sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb:
 sde:
 sdc:
 sdd: sdb1
sd 2:0:0:0: [sdb] Attached SCSI disk
 sdd1
sd 4:0:0:0: [sdd] Attached SCSI disk
 sdc1
sd 3:0:0:0: [sdc] Attached SCSI disk
 sda1 sda2 < sda5 >
sd 1:0:0:0: [sda] Attached SCSI disk
 sde1 sde2 sde3 sde4 < sde5 >
sd 5:0:0:0: [sde] Attached SCSI disk
usb 6-3: device descriptor read/64, error -62
usb 6-3: new full speed USB device using ohci_hcd and address 4
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
dracut: Mounted root filesystem /dev/sde2
dracut: Loading SELinux policy
usb 6-3: device not accepting address 4, error -62
usb 6-3: new full speed USB device using ohci_hcd and address 5
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
type=1404 audit(1299426378.139:2): selinux=0 auid=4294967295 ses=4294967295
dracut: /sbin/load_policy: Can't load policy: No such file or directory
dracut: Switching root
usb 6-3: device not accepting address 5, error -62
hub 6-0:1.0: unable to enumerate USB device on port 3
usb 2-5.1: new high speed USB device using ehci_hcd and address 4
usb 2-5.1: New USB device found, idVendor=046b, idProduct=ff10
usb 2-5.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-5.1: Product: Virtual Keyboard and Mouse
usb 2-5.1: Manufacturer: American Megatrends Inc.
usb 2-5.1: SerialNumber: serial
usb 2-5.1: configuration #1 chosen from 1 choice
input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:13.2/usb2/2-5/2-5.1/2-5.1:1.0/input/input5
generic-usb 0003:046B:FF10.0003: input,hidraw2: USB HID v1.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:13.2-5.1/input0
input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:13.2/usb2/2-5/2-5.1/2-5.1:1.1/input/input6
generic-usb 0003:046B:FF10.0004: input,hidraw3: USB HID v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:13.2-5.1/input1
udev: starting version 147
e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
e1000e: Copyright (c) 1999 - 2009 Intel Corporation.
e1000e 0000:0a:00.0: Disabling L1 ASPM
  alloc irq_desc for 44 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:0a:00.0: PCI INT A -> GSI 44 (level, low) -> IRQ 44
e1000e 0000:0a:00.0: setting latency timer to 64
  alloc irq_desc for 98 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:0a:00.0: irq 98 for MSI/MSI-X
  alloc irq_desc for 99 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:0a:00.0: irq 99 for MSI/MSI-X
  alloc irq_desc for 100 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:0a:00.0: irq 100 for MSI/MSI-X
0000:0a:00.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:0e:b6:9a:20:51
0000:0a:00.0: eth0: Intel(R) PRO/1000 Network Connection
0000:0a:00.0: eth0: MAC: 3, PHY: 8, PBA No: ffffff-0ff
e1000e 0000:09:00.0: Disabling L1 ASPM
  alloc irq_desc for 46 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:09:00.0: PCI INT A -> GSI 46 (level, low) -> IRQ 46
e1000e 0000:09:00.0: setting latency timer to 64
  alloc irq_desc for 101 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:09:00.0: irq 101 for MSI/MSI-X
  alloc irq_desc for 102 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:09:00.0: irq 102 for MSI/MSI-X
  alloc irq_desc for 103 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:09:00.0: irq 103 for MSI/MSI-X
0000:09:00.0: eth1: (PCI Express:2.5GB/s:Width x1) 00:0e:b6:9a:20:50
0000:09:00.0: eth1: Intel(R) PRO/1000 Network Connection
0000:09:00.0: eth1: MAC: 3, PHY: 8, PBA No: ffffff-0ff
e1000e 0000:08:00.0: Disabling L1 ASPM
  alloc irq_desc for 51 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:08:00.0: PCI INT A -> GSI 51 (level, low) -> IRQ 51
e1000e 0000:08:00.0: setting latency timer to 64
  alloc irq_desc for 104 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:08:00.0: irq 104 for MSI/MSI-X
  alloc irq_desc for 105 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:08:00.0: irq 105 for MSI/MSI-X
  alloc irq_desc for 106 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:08:00.0: irq 106 for MSI/MSI-X
0000:08:00.0: eth2: (PCI Express:2.5GB/s:Width x1) 00:0e:b6:9a:20:57
0000:08:00.0: eth2: Intel(R) PRO/1000 Network Connection
0000:08:00.0: eth2: MAC: 3, PHY: 8, PBA No: ffffff-0ff
e1000e 0000:07:00.0: Disabling L1 ASPM
  alloc irq_desc for 50 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:07:00.0: PCI INT A -> GSI 50 (level, low) -> IRQ 50
e1000e 0000:07:00.0: setting latency timer to 64
  alloc irq_desc for 107 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:07:00.0: irq 107 for MSI/MSI-X
  alloc irq_desc for 108 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:07:00.0: irq 108 for MSI/MSI-X
  alloc irq_desc for 109 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:07:00.0: irq 109 for MSI/MSI-X
0000:07:00.0: eth3: (PCI Express:2.5GB/s:Width x1) 00:0e:b6:9a:20:56
0000:07:00.0: eth3: Intel(R) PRO/1000 Network Connection
0000:07:00.0: eth3: MAC: 3, PHY: 8, PBA No: ffffff-0ff
e1000e 0000:06:00.0: Disabling L1 ASPM
  alloc irq_desc for 48 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:06:00.0: PCI INT A -> GSI 48 (level, low) -> IRQ 48
e1000e 0000:06:00.0: setting latency timer to 64
  alloc irq_desc for 110 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:06:00.0: irq 110 for MSI/MSI-X
  alloc irq_desc for 111 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:06:00.0: irq 111 for MSI/MSI-X
  alloc irq_desc for 112 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:06:00.0: irq 112 for MSI/MSI-X
0000:06:00.0: eth4: (PCI Express:2.5GB/s:Width x1) 00:0e:b6:9a:20:55
0000:06:00.0: eth4: Intel(R) PRO/1000 Network Connection
0000:06:00.0: eth4: MAC: 3, PHY: 8, PBA No: ffffff-0ff
e1000e 0000:05:00.0: Disabling L1 ASPM
  alloc irq_desc for 47 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:05:00.0: PCI INT A -> GSI 47 (level, low) -> IRQ 47
e1000e 0000:05:00.0: setting latency timer to 64
  alloc irq_desc for 113 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:05:00.0: irq 113 for MSI/MSI-X
  alloc irq_desc for 114 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:05:00.0: irq 114 for MSI/MSI-X
  alloc irq_desc for 115 on node 0
  alloc kstat_irqs on node 0
e1000e 0000:05:00.0: irq 115 for MSI/MSI-X
0000:05:00.0: eth5: (PCI Express:2.5GB/s:Width x1) 00:0e:b6:9a:20:54
0000:05:00.0: eth5: Intel(R) PRO/1000 Network Connection
0000:05:00.0: eth5: MAC: 3, PHY: 8, PBA No: ffffff-0ff
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
sd 1:0:0:0: Attached scsi generic sg0 type 0
sd 2:0:0:0: Attached scsi generic sg1 type 0
sd 3:0:0:0: Attached scsi generic sg2 type 0
sd 4:0:0:0: Attached scsi generic sg3 type 0
sd 5:0:0:0: Attached scsi generic sg4 type 0
piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
EDAC MC: Ver: 2.1.0 Jun 20 2010
EDAC amd64_edac:  Ver: 3.3.0 Jun 20 2010
EDAC amd64: This node reports that Memory ECC is currently disabled, set F3x44[22] (0000:00:18.3).
EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
 Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
 (Note that use of the override may cause unknown side effects.)
amd64_edac: probe of 0000:00:18.2 failed with error -22
EDAC amd64: This node reports that Memory ECC is currently disabled, set F3x44[22] (0000:00:19.3).
EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
 Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
 (Note that use of the override may cause unknown side effects.)
amd64_edac: probe of 0000:00:19.2 failed with error -22
EDAC amd64_edac:  Ver: 3.3.0 Jun 20 2010
EDAC amd64: This node reports that Memory ECC is currently disabled, set F3x44[22] (0000:00:18.3).
EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
 Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
 (Note that use of the override may cause unknown side effects.)
amd64_edac: probe of 0000:00:18.2 failed with error -22
EDAC amd64: This node reports that Memory ECC is currently disabled, set F3x44[22] (0000:00:19.3).
EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
 Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
 (Note that use of the override may cause unknown side effects.)
amd64_edac: probe of 0000:00:19.2 failed with error -22
EXT3 FS on sde2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sde1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sde5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 18563064k swap on /dev/sde3.  Priority:-1 extents:1 across:18563064k 
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth1: link is not ready
e1000e: eth1 NIC Link is Up 100 Mbps Full Duplex, Flow Control: None
0000:09:00.0: eth1: 10/100 speed: disabling TSO
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
powernow-k8: Found 2 Embedded AMD Opteron(tm) Processor 41LE HE processors (8 cpu cores) (version 2.20.00)
powernow-k8:    0 : pstate 0 (2300 MHz)
powernow-k8:    1 : pstate 1 (2000 MHz)
powernow-k8:    2 : pstate 2 (1600 MHz)
powernow-k8:    3 : pstate 3 (1200 MHz)
powernow-k8:    4 : pstate 4 (800 MHz)
powernow-k8:    0 : pstate 0 (2300 MHz)
powernow-k8:    1 : pstate 1 (2000 MHz)
powernow-k8:    2 : pstate 2 (1600 MHz)
powernow-k8:    3 : pstate 3 (1200 MHz)
powernow-k8:    4 : pstate 4 (800 MHz)
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Slow work thread pool: Starting up
Slow work thread pool: Ready
FS-Cache: Loaded
FS-Cache: Netfs 'nfs' registered for caching
eth1: no IPv6 routers present
ADDRCONF(NETDEV_UP): eth1: link is not ready
e1000e: eth1 NIC Link is Up 100 Mbps Full Duplex, Flow Control: None
0000:09:00.0: eth1: 10/100 speed: disabling TSO
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
eth1: no IPv6 routers present
i2c /dev entries driver

--------------020606050704040604000706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020606050704040604000706--
