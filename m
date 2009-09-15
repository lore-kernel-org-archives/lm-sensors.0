From: Stefan Agner <falstaff@deheime.ch>
Date: Tue, 15 Sep 2009 19:43:36 +0000
Subject: [lm-sensors] Zotac ION Board support
Message-Id: <4AAFEE68.6040901@deheime.ch>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1566192821892615001=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a cryptographically signed message in MIME format.

--===============1566192821892615001==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms020106080200010005080108"

This is a cryptographically signed message in MIME format.

--------------ms020106080200010005080108
Content-Type: multipart/mixed; boundary="------------050504040808070401020009"

This is a multi-part message in MIME format.
--------------050504040808070401020009
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello,

I try to read the sensors on my Zotac ION Board. But I couldn't bring it to work. How can I find out which type of chips are used?

Motherboard vendor and model
Zotac ION, IONITX-D-E (NVIDIA MCP79)

Lm_sensors and kernel versions
$ sensors --version
sensors version 3.0.2 with libsensors version 3.0.2
$ uname -a
Linux atom 2.6.31-9-generic #29-Ubuntu SMP Sun Aug 30 17:39:23 UTC 2009 i686 GNU/Linux

(Tried also latest sensors-detect script)

The output of sensors
$ sudo sensors
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

Output of latest sensors-detect
(See attachement)

The dmesg or syslog output if applicable
(See attachement)

The output of lsmod
(See attachement)

If an I2C sensor chip problem: the output of (as root) i2cdetect X where X = the bus number (run i2cdetect -l to list the buses)
(See attachement)

Part numbers of chips on your motherboard you think are the sensor chips (look at your motherboard)
RT9214
APM7313
Several pairs of R402/R474
RT9199
APL1117
Some more are under a big heatsink i think... 

Would be nice to have support for this board... 

Thanks
Stefan

--------------050504040808070401020009
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.31-9-generic (buildd@palmer) (gcc version 4.4.1 (Ubuntu 4.4.1-3ubuntu3) ) #29-Ubuntu SMP Sun Aug 30 17:39:23 UTC 2009 (Ubuntu 2.6.31-9.29-generic)
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[    0.000000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cffa0000 (usable)
[    0.000000]  BIOS-e820: 00000000cffa0000 - 00000000cffae000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cffae000 - 00000000cfff0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cfff0000 - 00000000e0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff700000 - 0000000100000000 (reserved)
[    0.000000] DMI present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working around it.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xcffa0 max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0E0000000 mask 0E0000000 uncachable
[    0.000000]   1 base 000000000 mask 000000000 write-back
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009e800 (usable)
[    0.000000]  modified: 000000000009e800 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 00000000cffa0000 (usable)
[    0.000000]  modified: 00000000cffa0000 - 00000000cffae000 (ACPI data)
[    0.000000]  modified: 00000000cffae000 - 00000000cfff0000 (ACPI NVS)
[    0.000000]  modified: 00000000cfff0000 - 00000000e0000000 (reserved)
[    0.000000]  modified: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  modified: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  modified: 00000000ff700000 - 0000000100000000 (reserved)
[    0.000000] initial memory mapped : 0 - 00c00000
[    0.000000] init_memory_mapping: 0000000000000000-00000000377fe000
[    0.000000] Using x86 segment limits to approximate NX protection
[    0.000000]  0000000000 - 0000400000 page 4k
[    0.000000]  0000400000 - 0037400000 page 2M
[    0.000000]  0037400000 - 00377fe000 page 4k
[    0.000000] kernel direct mapping tables up to 377fe000 @ 10000-15000
[    0.000000] RAMDISK: 3783f000 - 37fef47d
[    0.000000] Allocated new RAMDISK: 0089e000 - 0104e47d
[    0.000000] Move RAMDISK from 000000003783f000 - 0000000037fef47c to 0089e000 - 0104e47c
[    0.000000] ACPI: RSDP 000fa810 00024 (v02 ACPIAM)
[    0.000000] ACPI: XSDT cffa0100 0005C (v01 050809 XSDT1106 20090508 MSFT 00000097)
[    0.000000] ACPI: FACP cffa0290 000F4 (v04 050809 FACP1106 20090508 MSFT 00000097)
[    0.000000] ACPI: DSDT cffa04a0 070E9 (v02  A108P A108PD08 00000D08 INTL 20051117)
[    0.000000] ACPI: FACS cffae000 00040
[    0.000000] ACPI: APIC cffa0390 00080 (v02 050809 APIC1106 20090508 MSFT 00000097)
[    0.000000] ACPI: MCFG cffa0410 0003C (v01 050809 OEMMCFG  20090508 MSFT 00000097)
[    0.000000] ACPI: WDRT cffa0450 00047 (v01 050809 NV-WDRT  20090508 MSFT 00000097)
[    0.000000] ACPI: OEMB cffae040 00079 (v01 050809 OEMB1106 20090508 MSFT 00000097)
[    0.000000] ACPI: HPET cffaa4a0 00038 (v01 050809 OEMHPET0 20090508 MSFT 00000097)
[    0.000000] ACPI: NVHD cffae0c0 00284 (v01 050809  NVHDCP  20090508 MSFT 00000097)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 2439MB HIGHMEM available.
[    0.000000] 887MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 377fe000
[    0.000000]   low ram: 0 - 377fe000
[    0.000000]   node 0 low ram: 00000000 - 377fe000
[    0.000000]   node 0 bootmap 00011000 - 00017f00
[    0.000000] (9 early reservations) ==> bootmem [0000000000 - 00377fe000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
[    0.000000]   #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
[    0.000000]   #3 [0000100000 - 0000899020]    TEXT DATA BSS ==> [0000100000 - 0000899020]
[    0.000000]   #4 [000009e800 - 0000100000]    BIOS reserved ==> [000009e800 - 0000100000]
[    0.000000]   #5 [000089a000 - 000089d1bf]              BRK ==> [000089a000 - 000089d1bf]
[    0.000000]   #6 [0000010000 - 0000011000]          PGTABLE ==> [0000010000 - 0000011000]
[    0.000000]   #7 [000089e000 - 000104e47d]      NEW RAMDISK ==> [000089e000 - 000104e47d]
[    0.000000]   #8 [0000011000 - 0000018000]          BOOTMAP ==> [0000011000 - 0000018000]
[    0.000000] found SMP MP-table at [c00ff780] ff780
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x000377fe
[    0.000000]   HighMem  0x000377fe -> 0x000cffa0
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009e
[    0.000000]     0: 0x00000100 -> 0x000cffa0
[    0.000000] On node 0 totalpages: 851758
[    0.000000] free_area_init_node: node 0, pgdat c0776c00, node_mem_map c104f200
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3950 pages, LIFO batch:0
[    0.000000]   Normal zone: 1744 pages used for memmap
[    0.000000]   Normal zone: 221486 pages, LIFO batch:31
[    0.000000]   HighMem zone: 4880 pages used for memmap
[    0.000000]   HighMem zone: 619666 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10de8201 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000009e000 - 000000000009f000
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at e0000000 (gap: e0000000:1ec00000)
[    0.000000] NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 14 pages at c2a5f000, static data 35036 bytes
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 845102
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-2.6.31-9-generic root=UUID=6a27e6f5-e4a0-40fc-896a-760518841f25 ro quiet splash
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] allocated 17037120 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] Initializing HighMem for node 0 (000377fe:000cffa0)
[    0.000000] Memory: 3346028k/3407488k available (4532k kernel code, 60040k reserved, 2120k data, 536k init, 2498184k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfff1d000 - 0xfffff000   ( 904 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
[    0.000000]       .init : 0xc0780000 - 0xc0806000   ( 536 kB)
[    0.000000]       .data : 0xc056d334 - 0xc077f568   (2120 kB)
[    0.000000]       .text : 0xc0100000 - 0xc056d334   (4532 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] NR_IRQS:2304 nr_irqs:440
[    0.000000] Extended CMOS year: 2000
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1600.063 MHz processor.
[    0.000019] spurious 8259A interrupt: IRQ7.
[    0.001930] Console: colour VGA+ 80x25
[    0.001936] console [tty0] enabled
[    0.002181] hpet clockevent registered
[    0.002190] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    0.002201] Calibrating delay loop (skipped), value calculated using timer frequency.. 3200.12 BogoMIPS (lpj=6400252)
[    0.002237] Security Framework initialized
[    0.002273] AppArmor: AppArmor initialized
[    0.002288] Mount-cache hash table entries: 512
[    0.002509] Initializing cgroup subsys ns
[    0.002519] Initializing cgroup subsys cpuacct
[    0.002528] Initializing cgroup subsys memory
[    0.002540] Initializing cgroup subsys freezer
[    0.002545] Initializing cgroup subsys net_cls
[    0.002570] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.002576] CPU: L2 cache: 512K
[    0.002581] CPU: Physical Processor ID: 0
[    0.002585] CPU: Processor Core ID: 0
[    0.002591] using mwait in idle threads.
[    0.002603] Performance Counters: Atom events, Intel PMU driver.
[    0.002617] ... version:                 3
[    0.002621] ... bit width:               40
[    0.002625] ... generic counters:        2
[    0.002630] ... value mask:              000000ffffffffff
[    0.002634] ... max period:              000000007fffffff
[    0.002639] ... fixed-purpose counters:  3
[    0.002643] ... counter mask:            0000000700000003
[    0.002652] Checking 'hlt' instruction... OK.
[    0.019845] ACPI: Core revision 20090521
[    0.039970] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.079672] CPU0: Intel(R) Atom(TM) CPU  330   @ 1.60GHz stepping 02
[    0.080001] Booting processor 1 APIC 0x2 ip 0x6000
[    0.004000] Initializing CPU#1
[    0.004000] Calibrating delay using timer specific routine.. 3199.97 BogoMIPS (lpj=6399946)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.004000] CPU: L2 cache: 512K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.164424] CPU1: Intel(R) Atom(TM) CPU  330   @ 1.60GHz stepping 02
[    0.164454] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.168166] Booting processor 2 APIC 0x1 ip 0x6000
[    0.004000] Initializing CPU#2
[    0.004000] Calibrating delay using timer specific routine.. 3199.92 BogoMIPS (lpj=6399858)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.004000] CPU: L2 cache: 512K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 0
[    0.256546] CPU2: Intel(R) Atom(TM) CPU  330   @ 1.60GHz stepping 02
[    0.256589] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    0.260206] Booting processor 3 APIC 0x3 ip 0x6000
[    0.004000] Initializing CPU#3
[    0.004000] Calibrating delay using timer specific routine.. 3199.95 BogoMIPS (lpj=6399904)
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.004000] CPU: L2 cache: 512K
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 1
[    0.348410] CPU3: Intel(R) Atom(TM) CPU  330   @ 1.60GHz stepping 02
[    0.348448] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
[    0.352023] Brought up 4 CPUs
[    0.352030] Total of 4 processors activated (12799.98 BogoMIPS).
[    0.352116] CPU0 attaching sched-domain:
[    0.352123]  domain 0: span 0,2 level SIBLING
[    0.352128]   groups: 0 2
[    0.352138]   domain 1: span 0-3 level CPU
[    0.352143]    groups: 0,2 1,3
[    0.352155] CPU1 attaching sched-domain:
[    0.352160]  domain 0: span 1,3 level SIBLING
[    0.352167]   groups: 1 3
[    0.352175]   domain 1: span 0-3 level CPU
[    0.352180]    groups: 1,3 0,2
[    0.352190] CPU2 attaching sched-domain:
[    0.352195]  domain 0: span 0,2 level SIBLING
[    0.352200]   groups: 2 0
[    0.352208]   domain 1: span 0-3 level CPU
[    0.352213]    groups: 0,2 1,3
[    0.352223] CPU3 attaching sched-domain:
[    0.352227]  domain 0: span 1,3 level SIBLING
[    0.352233]   groups: 3 1
[    0.352241]   domain 1: span 0-3 level CPU
[    0.352246]    groups: 1,3 0,2
[    0.352589] Booting paravirtualized kernel on bare hardware
[    0.352589] regulator: core version 0.5
[    0.352589] Time: 20:23:26  Date: 09/15/09
[    0.352589] NET: Registered protocol family 16
[    0.352589] EISA bus registered
[    0.352589] ACPI: bus type pci registered
[    0.356126] PCI: MCFG configuration 0: base fc000000 segment 0 buses 0 - 31
[    0.356126] PCI: Not using MMCONFIG.
[    0.356399] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=7
[    0.356404] PCI: Using configuration type 1 for base access
[    0.368158] bio: create slab <bio-0> at 0
[    0.374197] ACPI: EC: Look up EC in DSDT
[    0.403210] ACPI: Interpreter enabled
[    0.403225] ACPI: (supports S0 S1 S3 S4 S5)
[    0.403278] ACPI: Using IOAPIC for interrupt routing
[    0.403406] PCI: MCFG configuration 0: base fc000000 segment 0 buses 0 - 31
[    0.417514] PCI: MCFG area at fc000000 reserved in ACPI motherboard resources
[    0.417520] PCI: Using MMCONFIG for extended config space
[    0.456497] ACPI: No dock devices found.
[    0.457090] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.457344] pci 0000:00:03.0: reg 10 io port: [0x4f00-0x4fff]
[    0.457344] pci 0000:00:03.2: reg 10 io port: [0x4900-0x493f]
[    0.457344] pci 0000:00:03.2: reg 20 io port: [0x4d00-0x4d3f]
[    0.457344] pci 0000:00:03.2: reg 24 io port: [0x4e00-0x4e3f]
[    0.457344] pci 0000:00:03.2: PME# supported from D3hot D3cold
[    0.457344] pci 0000:00:03.2: PME# disabled
[    0.457344] pci 0000:00:03.5: reg 10 32bit mmio: [0xfae80000-0xfaefffff]
[    0.457344] pci 0000:00:04.0: reg 10 32bit mmio: [0xfae7f000-0xfae7ffff]
[    0.457344] pci 0000:00:04.0: supports D1 D2
[    0.457344] pci 0000:00:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.457344] pci 0000:00:04.0: PME# disabled
[    0.457344] pci 0000:00:04.1: reg 10 32bit mmio: [0xfae7ec00-0xfae7ecff]
[    0.457344] pci 0000:00:04.1: supports D1 D2
[    0.457344] pci 0000:00:04.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.457344] pci 0000:00:04.1: PME# disabled
[    0.457344] pci 0000:00:06.0: reg 10 32bit mmio: [0xfae7d000-0xfae7dfff]
[    0.457344] pci 0000:00:06.0: supports D1 D2
[    0.457344] pci 0000:00:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.457344] pci 0000:00:06.0: PME# disabled
[    0.457344] pci 0000:00:06.1: reg 10 32bit mmio: [0xfae7e800-0xfae7e8ff]
[    0.457344] pci 0000:00:06.1: supports D1 D2
[    0.457344] pci 0000:00:06.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.457344] pci 0000:00:06.1: PME# disabled
[    0.457344] pci 0000:00:08.0: reg 10 32bit mmio: [0xfae78000-0xfae7bfff]
[    0.457344] pci 0000:00:08.0: PME# supported from D3hot D3cold
[    0.457344] pci 0000:00:08.0: PME# disabled
[    0.457344] pci 0000:00:0a.0: reg 10 32bit mmio: [0xfae7c000-0xfae7cfff]
[    0.457344] pci 0000:00:0a.0: reg 14 io port: [0xd080-0xd087]
[    0.457345] pci 0000:00:0a.0: reg 18 32bit mmio: [0xfae7e400-0xfae7e4ff]
[    0.457355] pci 0000:00:0a.0: reg 1c 32bit mmio: [0xfae7e000-0xfae7e00f]
[    0.457387] pci 0000:00:0a.0: supports D1 D2
[    0.457393] pci 0000:00:0a.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.457401] pci 0000:00:0a.0: PME# disabled
[    0.457445] pci 0000:00:0b.0: reg 10 io port: [0xd000-0xd007]
[    0.457454] pci 0000:00:0b.0: reg 14 io port: [0xcc00-0xcc03]
[    0.457464] pci 0000:00:0b.0: reg 18 io port: [0xc880-0xc887]
[    0.457473] pci 0000:00:0b.0: reg 1c io port: [0xc800-0xc803]
[    0.457483] pci 0000:00:0b.0: reg 20 io port: [0xc480-0xc48f]
[    0.457492] pci 0000:00:0b.0: reg 24 32bit mmio: [0xfae76000-0xfae77fff]
[    0.457734] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.457745] pci 0000:00:0c.0: PME# disabled
[    0.457849] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.457856] pci 0000:00:10.0: PME# disabled
[    0.458088] pci 0000:00:15.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.458099] pci 0000:00:15.0: PME# disabled
[    0.458349] pci 0000:00:16.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.458361] pci 0000:00:16.0: PME# disabled
[    0.458608] pci 0000:00:17.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.458619] pci 0000:00:17.0: PME# disabled
[    0.460118] pci 0000:00:18.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.460130] pci 0000:00:18.0: PME# disabled
[    0.460237] pci 0000:00:09.0: transparent bridge
[    0.460383] pci 0000:03:00.0: reg 10 32bit mmio: [0xfb000000-0xfbffffff]
[    0.460399] pci 0000:03:00.0: reg 14 64bit mmio: [0xe0000000-0xefffffff]
[    0.460414] pci 0000:03:00.0: reg 1c 64bit mmio: [0xf8000000-0xf9ffffff]
[    0.460425] pci 0000:03:00.0: reg 24 io port: [0xec00-0xec7f]
[    0.460435] pci 0000:03:00.0: reg 30 32bit mmio: [0xfafe0000-0xfaffffff]
[    0.460510] pci 0000:00:10.0: bridge io port: [0xe000-0xefff]
[    0.460518] pci 0000:00:10.0: bridge 32bit mmio: [0xfaf00000-0xfbffffff]
[    0.460528] pci 0000:00:10.0: bridge 64bit mmio pref: [0xe0000000-0xf9ffffff]
[    0.460595] pci 0000:04:00.0: reg 10 64bit mmio: [0xfebf0000-0xfebfffff]
[    0.460664] pci 0000:04:00.0: supports D1
[    0.460669] pci 0000:04:00.0: PME# supported from D0 D1 D3hot
[    0.460677] pci 0000:04:00.0: PME# disabled
[    0.460768] pci 0000:00:15.0: bridge 32bit mmio: [0xfeb00000-0xfebfffff]
[    0.461142] pci_bus 0000:00: on NUMA node 0
[    0.461155] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.461594] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PBB0._PRT]
[    0.461771] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.IXVE._PRT]
[    0.461910] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
[    0.462103] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
[    0.462265] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
[    0.462426] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
[    0.462587] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
[    0.497597] ACPI: PCI Interrupt Link [LNKA] (IRQs 16 17 18 19) *0, disabled.
[    0.500152] ACPI: PCI Interrupt Link [LNKB] (IRQs 16 17 18 19) *0, disabled.
[    0.500721] ACPI: PCI Interrupt Link [LNKC] (IRQs 16 17 18 19) *0, disabled.
[    0.501301] ACPI: PCI Interrupt Link [LNKD] (IRQs 16 17 18 19) *0, disabled.
[    0.501869] ACPI: PCI Interrupt Link [LN0A] (IRQs 16 17 18 19) *0, disabled.
[    0.502439] ACPI: PCI Interrupt Link [LN0B] (IRQs 16 17 18 19) *0, disabled.
[    0.503008] ACPI: PCI Interrupt Link [LN0C] (IRQs 16 17 18 19) *0, disabled.
[    0.503584] ACPI: PCI Interrupt Link [LN0D] (IRQs 16 17 18 19) *0, disabled.
[    0.504174] ACPI: PCI Interrupt Link [LN1A] (IRQs 16 17 18 19) *0, disabled.
[    0.504744] ACPI: PCI Interrupt Link [LN1B] (IRQs 16 17 18 19) *0, disabled.
[    0.505314] ACPI: PCI Interrupt Link [LN1C] (IRQs 16 17 18 19) *0, disabled.
[    0.505884] ACPI: PCI Interrupt Link [LN1D] (IRQs 16 17 18 19) *0, disabled.
[    0.506452] ACPI: PCI Interrupt Link [LN2A] (IRQs 16 17 18 19) *0, disabled.
[    0.507023] ACPI: PCI Interrupt Link [LN2B] (IRQs 16 17 18 19) *0, disabled.
[    0.507599] ACPI: PCI Interrupt Link [LN2C] (IRQs 16 17 18 19) *0, disabled.
[    0.508186] ACPI: PCI Interrupt Link [LN2D] (IRQs 16 17 18 19) *0, disabled.
[    0.508768] ACPI: PCI Interrupt Link [LN3A] (IRQs 16 17 18 19) *11
[    0.509338] ACPI: PCI Interrupt Link [LN3B] (IRQs 16 17 18 19) *0, disabled.
[    0.509906] ACPI: PCI Interrupt Link [LN3C] (IRQs 16 17 18 19) *0, disabled.
[    0.510477] ACPI: PCI Interrupt Link [LN3D] (IRQs 16 17 18 19) *0, disabled.
[    0.511049] ACPI: PCI Interrupt Link [LN4A] (IRQs 16 17 18 19) *0, disabled.
[    0.511626] ACPI: PCI Interrupt Link [LN4B] (IRQs 16 17 18 19) *0, disabled.
[    0.512213] ACPI: PCI Interrupt Link [LN4C] (IRQs 16 17 18 19) *0, disabled.
[    0.512786] ACPI: PCI Interrupt Link [LN4D] (IRQs 16 17 18 19) *0, disabled.
[    0.513357] ACPI: PCI Interrupt Link [LN5A] (IRQs 16 17 18 19) *0, disabled.
[    0.513929] ACPI: PCI Interrupt Link [LN5B] (IRQs 16 17 18 19) *0, disabled.
[    0.514498] ACPI: PCI Interrupt Link [LN5C] (IRQs 16 17 18 19) *0, disabled.
[    0.515072] ACPI: PCI Interrupt Link [LN5D] (IRQs 16 17 18 19) *0, disabled.
[    0.515657] ACPI: PCI Interrupt Link [LN6A] (IRQs 16 17 18 19) *0, disabled.
[    0.516243] ACPI: PCI Interrupt Link [LN6B] (IRQs 16 17 18 19) *0, disabled.
[    0.516816] ACPI: PCI Interrupt Link [LN6C] (IRQs 16 17 18 19) *0, disabled.
[    0.517387] ACPI: PCI Interrupt Link [LN6D] (IRQs 16 17 18 19) *0, disabled.
[    0.517969] ACPI: PCI Interrupt Link [LUB0] (IRQs 20 21 22 23) *15
[    0.518549] ACPI: PCI Interrupt Link [LUB2] (IRQs 20 21 22 23) *10
[    0.519129] ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *10
[    0.519715] ACPI: PCI Interrupt Link [LAZA] (IRQs 20 21 22 23) *15
[    0.520312] ACPI: PCI Interrupt Link [SGRU] (IRQs 20 21 22 23) *10
[    0.520894] ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *11
[    0.521476] ACPI: PCI Interrupt Link [LPMU] (IRQs 20 21 22 23) *9
[    0.522057] ACPI: PCI Interrupt Link [LSA0] (IRQs 20 21 22 23) *5
[    0.522719] ACPI: PCI Interrupt Link [LATA] (IRQs 20 21 22 23) *0, disabled.
[    0.523305] ACPI: PCI Interrupt Link [UB11] (IRQs 20 21 22 23) *11
[    0.523895] ACPI: PCI Interrupt Link [UB12] (IRQs 20 21 22 23) *9
[    0.524498] ACPI: PCI Interrupt Link [LRP0] (IRQs 20 21 22 23) *10
[    0.525076] ACPI: PCI Interrupt Link [LRP1] (IRQs 20 21 22 23) *0, disabled.
[    0.525655] ACPI: PCI Interrupt Link [LRP2] (IRQs 20 21 22 23) *0, disabled.
[    0.526253] ACPI: PCI Interrupt Link [LRP3] (IRQs 20 21 22 23) *11
[    0.526839] ACPI: PCI Interrupt Link [LRP4] (IRQs 20 21 22 23) *9
[    0.527429] ACPI: PCI Interrupt Link [LRP5] (IRQs 20 21 22 23) *15
[    0.528029] ACPI: PCI Interrupt Link [LRP6] (IRQs 20 21 22 23) *14
[    0.528370] SCSI subsystem initialized
[    0.529815] libata version 3.00 loaded.
[    0.529815] usbcore: registered new interface driver usbfs
[    0.529815] usbcore: registered new interface driver hub
[    0.529815] usbcore: registered new device driver usb
[    0.529815] ACPI: WMI: Mapper loaded
[    0.529815] PCI: Using ACPI for IRQ routing
[    0.544024] Bluetooth: Core ver 2.15
[    0.544231] NET: Registered protocol family 31
[    0.544231] Bluetooth: HCI device and connection manager initialized
[    0.544231] Bluetooth: HCI socket layer initialized
[    0.544231] NetLabel: Initializing
[    0.544231] NetLabel:  domain hash size = 128
[    0.544231] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.544231] NetLabel:  unlabeled traffic allowed by default
[    0.544231] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 31, 31
[    0.544231] hpet0: 4 comparators, 64-bit 25.000000 MHz counter
[    0.556031] Switched to high resolution mode on CPU 0
[    0.556493] Switched to high resolution mode on CPU 1
[    0.556500] Switched to high resolution mode on CPU 3
[    0.556629] Switched to high resolution mode on CPU 2
[    0.565035] pnp: PnP ACPI init
[    0.565069] ACPI: bus type pnp registered
[    0.580309] pnp: PnP ACPI: found 13 devices
[    0.580317] ACPI: ACPI bus type pnp unregistered
[    0.580324] PnPBIOS: Disabled by ACPI PNP
[    0.580354] system 00:05: ioport range 0x4d0-0x4d1 has been reserved
[    0.580362] system 00:05: ioport range 0x800-0x80f has been reserved
[    0.580370] system 00:05: ioport range 0x4000-0x407f has been reserved
[    0.580377] system 00:05: ioport range 0x4080-0x40ff has been reserved
[    0.580384] system 00:05: ioport range 0x4400-0x447f has been reserved
[    0.580391] system 00:05: ioport range 0x4480-0x44ff has been reserved
[    0.580398] system 00:05: ioport range 0x4800-0x487f has been reserved
[    0.580406] system 00:05: ioport range 0x4880-0x48ff has been reserved
[    0.580416] system 00:05: iomem range 0xfefe2000-0xfefe3fff has been reserved
[    0.580423] system 00:05: iomem range 0xfefe1000-0xfefe1fff has been reserved
[    0.580431] system 00:05: iomem range 0xfee01000-0xfeefffff has been reserved
[    0.580447] system 00:08: iomem range 0xfec00000-0xfec00fff could not be reserved
[    0.580454] system 00:08: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.580468] system 00:0a: ioport range 0xa00-0xa0f has been reserved
[    0.580475] system 00:0a: ioport range 0xa10-0xa1f has been reserved
[    0.580488] system 00:0b: iomem range 0xfc000000-0xfdffffff has been reserved
[    0.580502] system 00:0c: iomem range 0x0-0x9ffff could not be reserved
[    0.580509] system 00:0c: iomem range 0xc0000-0xcffff could not be reserved
[    0.580517] system 00:0c: iomem range 0xe0000-0xfffff could not be reserved
[    0.580524] system 00:0c: iomem range 0x100000-0xdfffffff could not be reserved
[    0.580531] system 00:0c: iomem range 0xfec00000-0xffffffff could not be reserved
[    0.616490] AppArmor: AppArmor Filesystem Enabled
[    0.616647] pci 0000:00:09.0: PCI bridge, secondary bus 0000:01
[    0.616653] pci 0000:00:09.0:   IO window: disabled
[    0.616660] pci 0000:00:09.0:   MEM window: disabled
[    0.616667] pci 0000:00:09.0:   PREFETCH window: disabled
[    0.616674] pci 0000:00:0c.0: PCI bridge, secondary bus 0000:02
[    0.616679] pci 0000:00:0c.0:   IO window: disabled
[    0.616692] pci 0000:00:0c.0:   MEM window: disabled
[    0.616703] pci 0000:00:0c.0:   PREFETCH window: disabled
[    0.616715] pci 0000:00:10.0: PCI bridge, secondary bus 0000:03
[    0.616721] pci 0000:00:10.0:   IO window: 0xe000-0xefff
[    0.616729] pci 0000:00:10.0:   MEM window: 0xfaf00000-0xfbffffff
[    0.616737] pci 0000:00:10.0:   PREFETCH window: 0x000000e0000000-0x000000f9ffffff
[    0.616747] pci 0000:00:15.0: PCI bridge, secondary bus 0000:04
[    0.616751] pci 0000:00:15.0:   IO window: disabled
[    0.616766] pci 0000:00:15.0:   MEM window: 0xfeb00000-0xfebfffff
[    0.616777] pci 0000:00:15.0:   PREFETCH window: disabled
[    0.616788] pci 0000:00:16.0: PCI bridge, secondary bus 0000:05
[    0.616793] pci 0000:00:16.0:   IO window: disabled
[    0.616806] pci 0000:00:16.0:   MEM window: disabled
[    0.616816] pci 0000:00:16.0:   PREFETCH window: disabled
[    0.616828] pci 0000:00:17.0: PCI bridge, secondary bus 0000:06
[    0.616832] pci 0000:00:17.0:   IO window: disabled
[    0.616846] pci 0000:00:17.0:   MEM window: disabled
[    0.616856] pci 0000:00:17.0:   PREFETCH window: disabled
[    0.616867] pci 0000:00:18.0: PCI bridge, secondary bus 0000:07
[    0.616872] pci 0000:00:18.0:   IO window: disabled
[    0.616885] pci 0000:00:18.0:   MEM window: disabled
[    0.616896] pci 0000:00:18.0:   PREFETCH window: disabled
[    0.616919] pci 0000:00:09.0: setting latency timer to 64
[    0.617800] ACPI: PCI Interrupt Link [LRP0] enabled at IRQ 23
[    0.617810]   alloc irq_desc for 23 on node -1
[    0.617816]   alloc kstat_irqs on node -1
[    0.617829] pci 0000:00:0c.0: PCI INT A -> Link[LRP0] -> GSI 23 (level, low) -> IRQ 23
[    0.617843] pci 0000:00:0c.0: setting latency timer to 64
[    0.617858] pci 0000:00:10.0: setting latency timer to 64
[    0.618663] ACPI: PCI Interrupt Link [LRP3] enabled at IRQ 22
[    0.618671]   alloc irq_desc for 22 on node -1
[    0.618675]   alloc kstat_irqs on node -1
[    0.618685] pci 0000:00:15.0: PCI INT A -> Link[LRP3] -> GSI 22 (level, low) -> IRQ 22
[    0.618699] pci 0000:00:15.0: setting latency timer to 64
[    0.619507] ACPI: PCI Interrupt Link [LRP4] enabled at IRQ 21
[    0.619515]   alloc irq_desc for 21 on node -1
[    0.619520]   alloc kstat_irqs on node -1
[    0.619530] pci 0000:00:16.0: PCI INT A -> Link[LRP4] -> GSI 21 (level, low) -> IRQ 21
[    0.619544] pci 0000:00:16.0: setting latency timer to 64
[    0.620360] ACPI: PCI Interrupt Link [LRP5] enabled at IRQ 20
[    0.620367]   alloc irq_desc for 20 on node -1
[    0.620372]   alloc kstat_irqs on node -1
[    0.620382] pci 0000:00:17.0: PCI INT A -> Link[LRP5] -> GSI 20 (level, low) -> IRQ 20
[    0.620396] pci 0000:00:17.0: setting latency timer to 64
[    0.621222] ACPI: PCI Interrupt Link [LRP6] enabled at IRQ 23
[    0.621231] pci 0000:00:18.0: PCI INT A -> Link[LRP6] -> GSI 23 (level, low) -> IRQ 23
[    0.621248] pci 0000:00:18.0: setting latency timer to 64
[    0.621259] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.621266] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
[    0.621272] pci_bus 0000:01: resource 3 io:  [0x00-0xffff]
[    0.621278] pci_bus 0000:01: resource 4 mem: [0x000000-0xffffffff]
[    0.621285] pci_bus 0000:03: resource 0 io:  [0xe000-0xefff]
[    0.621291] pci_bus 0000:03: resource 1 mem: [0xfaf00000-0xfbffffff]
[    0.621298] pci_bus 0000:03: resource 2 pref mem [0xe0000000-0xf9ffffff]
[    0.621304] pci_bus 0000:04: resource 1 mem: [0xfeb00000-0xfebfffff]
[    0.621381] NET: Registered protocol family 2
[    0.621593] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.622233] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.623185] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.623616] TCP: Hash tables configured (established 131072 bind 65536)
[    0.623623] TCP reno registered
[    0.623847] NET: Registered protocol family 1
[    0.623990] Trying to unpack rootfs image as initramfs...
[    0.995852] Freeing initrd memory: 7873k freed
[    1.004711] cpufreq-nforce2: No nForce2 chipset.
[    1.005024] Scanning for low memory corruption every 60 seconds
[    1.005694] audit: initializing netlink socket (disabled)
[    1.005721] type=2000 audit(1253046207.004:1): initialized
[    1.023401] highmem bounce pool size: 64 pages
[    1.023414] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    1.031199] VFS: Disk quotas dquot_6.5.2
[    1.031441] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.034052] fuse init (API version 7.12)
[    1.034479] msgmni has been set to 1673
[    1.035171] alg: No test for stdrng (krng)
[    1.035202] io scheduler noop registered
[    1.035208] io scheduler anticipatory registered
[    1.035213] io scheduler deadline registered
[    1.035414] io scheduler cfq registered (default)
[    2.680017] pci 0000:00:06.1: EHCI: BIOS handoff failed (BIOS bug?) 01010001
[    2.680349] pci 0000:03:00.0: Boot video device
[    2.680886]   alloc irq_desc for 24 on node -1
[    2.680892]   alloc kstat_irqs on node -1
[    2.680920] pcieport-driver 0000:00:0c.0: irq 24 for MSI/MSI-X
[    2.680947] pcieport-driver 0000:00:0c.0: setting latency timer to 64
[    2.681487]   alloc irq_desc for 25 on node -1
[    2.681493]   alloc kstat_irqs on node -1
[    2.681520] pcieport-driver 0000:00:15.0: irq 25 for MSI/MSI-X
[    2.681545] pcieport-driver 0000:00:15.0: setting latency timer to 64
[    2.682057]   alloc irq_desc for 26 on node -1
[    2.682062]   alloc kstat_irqs on node -1
[    2.682086] pcieport-driver 0000:00:16.0: irq 26 for MSI/MSI-X
[    2.682112] pcieport-driver 0000:00:16.0: setting latency timer to 64
[    2.682612]   alloc irq_desc for 27 on node -1
[    2.682617]   alloc kstat_irqs on node -1
[    2.682641] pcieport-driver 0000:00:17.0: irq 27 for MSI/MSI-X
[    2.682666] pcieport-driver 0000:00:17.0: setting latency timer to 64
[    2.683177]   alloc irq_desc for 28 on node -1
[    2.683183]   alloc kstat_irqs on node -1
[    2.683207] pcieport-driver 0000:00:18.0: irq 28 for MSI/MSI-X
[    2.683232] pcieport-driver 0000:00:18.0: setting latency timer to 64
[    2.683733] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    2.684072] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    2.684930] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    2.684940] ACPI: Power Button [PWRF]
[    2.685191] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
[    2.685205] ACPI: Power Button [PWRB]
[    2.687580] processor LNXCPU:00: registered as cooling_device0
[    2.687590] ACPI: Processor [CPU0] (supports 8 throttling states)
[    2.689062] processor LNXCPU:01: registered as cooling_device1
[    2.690492] processor LNXCPU:02: registered as cooling_device2
[    2.691936] processor LNXCPU:03: registered as cooling_device3
[    2.705684] isapnp: Scanning for PnP cards...
[    3.058793] isapnp: No Plug & Play device found
[    3.068455] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    3.068664] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    3.069597] 00:01: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    3.075228] brd: module loaded
[    3.077625] loop: module loaded
[    3.078106] input: Macintosh mouse button emulation as /devices/virtual/input/input2
[    3.078678] ahci 0000:00:0b.0: version 3.0
[    3.079544] ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 22
[    3.079554] ahci 0000:00:0b.0: PCI INT A -> Link[LSA0] -> GSI 22 (level, low) -> IRQ 22
[    3.079615]   alloc irq_desc for 29 on node -1
[    3.079620]   alloc kstat_irqs on node -1
[    3.079637] ahci 0000:00:0b.0: irq 29 for MSI/MSI-X
[    3.079751] ahci 0000:00:0b.0: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    3.079760] ahci 0000:00:0b.0: flags: 64bit ncq sntf led pmp pio slum part 
[    3.079767] ahci 0000:00:0b.0: setting latency timer to 64
[    3.080652] scsi0 : ahci
[    3.081357] scsi1 : ahci
[    3.081686] scsi2 : ahci
[    3.081978] scsi3 : ahci
[    3.082277] scsi4 : ahci
[    3.082572] scsi5 : ahci
[    3.083033] ata1: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76100 irq 29
[    3.083041] ata2: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76180 irq 29
[    3.083048] ata3: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76200 irq 29
[    3.083054] ata4: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76280 irq 29
[    3.083060] ata5: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76300 irq 29
[    3.083067] ata6: SATA max UDMA/133 abar m8192@0xfae76000 port 0xfae76380 irq 29
[    3.089558] Fixed MDIO Bus: probed
[    3.089573] PPP generic driver version 2.4.2
[    3.090173] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.091060] ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 21
[    3.091071] ehci_hcd 0000:00:04.1: PCI INT B -> Link[LUB2] -> GSI 21 (level, low) -> IRQ 21
[    3.091099] ehci_hcd 0000:00:04.1: setting latency timer to 64
[    3.091105] ehci_hcd 0000:00:04.1: EHCI Host Controller
[    3.091295] ehci_hcd 0000:00:04.1: new USB bus registered, assigned bus number 1
[    3.091353] ehci_hcd 0000:00:04.1: debug port 1
[    3.091362] ehci_hcd 0000:00:04.1: cache line size of 32 is not supported
[    3.091395] ehci_hcd 0000:00:04.1: irq 21, io mem 0xfae7ec00
[    3.101238] ehci_hcd 0000:00:04.1: USB 2.0 started, EHCI 1.00
[    3.101538] usb usb1: configuration #1 chosen from 1 choice
[    3.101705] hub 1-0:1.0: USB hub found
[    3.101725] hub 1-0:1.0: 6 ports detected
[    3.102661] ACPI: PCI Interrupt Link [UB12] enabled at IRQ 20
[    3.102672] ehci_hcd 0000:00:06.1: PCI INT B -> Link[UB12] -> GSI 20 (level, low) -> IRQ 20
[    3.102697] ehci_hcd 0000:00:06.1: setting latency timer to 64
[    3.102704] ehci_hcd 0000:00:06.1: EHCI Host Controller
[    3.102899] ehci_hcd 0000:00:06.1: new USB bus registered, assigned bus number 2
[    3.102943] ehci_hcd 0000:00:06.1: debug port 1
[    3.102952] ehci_hcd 0000:00:06.1: cache line size of 32 is not supported
[    3.102987] ehci_hcd 0000:00:06.1: irq 20, io mem 0xfae7e800
[    3.113018] ehci_hcd 0000:00:06.1: USB 2.0 started, EHCI 1.00
[    3.113278] usb usb2: configuration #1 chosen from 1 choice
[    3.113439] hub 2-0:1.0: USB hub found
[    3.113456] hub 2-0:1.0: 6 ports detected
[    3.113675] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.114558] ACPI: PCI Interrupt Link [LUB0] enabled at IRQ 23
[    3.114570] ohci_hcd 0000:00:04.0: PCI INT A -> Link[LUB0] -> GSI 23 (level, low) -> IRQ 23
[    3.114594] ohci_hcd 0000:00:04.0: setting latency timer to 64
[    3.114601] ohci_hcd 0000:00:04.0: OHCI Host Controller
[    3.114800] ohci_hcd 0000:00:04.0: new USB bus registered, assigned bus number 3
[    3.114846] ohci_hcd 0000:00:04.0: irq 23, io mem 0xfae7f000
[    3.170267] usb usb3: configuration #1 chosen from 1 choice
[    3.170413] hub 3-0:1.0: USB hub found
[    3.170432] hub 3-0:1.0: 6 ports detected
[    3.171348] ACPI: PCI Interrupt Link [UB11] enabled at IRQ 22
[    3.171358] ohci_hcd 0000:00:06.0: PCI INT A -> Link[UB11] -> GSI 22 (level, low) -> IRQ 22
[    3.171380] ohci_hcd 0000:00:06.0: setting latency timer to 64
[    3.171386] ohci_hcd 0000:00:06.0: OHCI Host Controller
[    3.171557] ohci_hcd 0000:00:06.0: new USB bus registered, assigned bus number 4
[    3.171599] ohci_hcd 0000:00:06.0: irq 22, io mem 0xfae7d000
[    3.227271] usb usb4: configuration #1 chosen from 1 choice
[    3.227437] hub 4-0:1.0: USB hub found
[    3.227456] hub 4-0:1.0: 6 ports detected
[    3.227660] uhci_hcd: USB Universal Host Controller Interface driver
[    3.228126] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    3.228132] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    3.228619] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.229076] mice: PS/2 mouse device common for all mice
[    3.229615] rtc_cmos 00:07: RTC can wake from S4
[    3.229780] rtc_cmos 00:07: rtc core: registered rtc_cmos as rtc0
[    3.229843] rtc0: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    3.230315] device-mapper: uevent: version 1.0.3
[    3.230681] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
[    3.230973] device-mapper: multipath: version 1.1.0 loaded
[    3.230980] device-mapper: multipath round-robin: version 1.0.0 loaded
[    3.231501] EISA: Probing bus 0 at eisa.0
[    3.231521] Cannot allocate resource for EISA slot 4
[    3.231540] EISA: Detected 0 cards.
[    3.231969] cpuidle: using governor ladder
[    3.231974] cpuidle: using governor menu
[    3.233537] TCP cubic registered
[    3.234411] NET: Registered protocol family 10
[    3.235364] lo: Disabled Privacy Extensions
[    3.236075] NET: Registered protocol family 17
[    3.236247] Bluetooth: L2CAP ver 2.13
[    3.236252] Bluetooth: L2CAP socket layer initialized
[    3.236258] Bluetooth: SCO (Voice Link) ver 0.6
[    3.236262] Bluetooth: SCO socket layer initialized
[    3.236342] Bluetooth: RFCOMM TTY layer initialized
[    3.236352] Bluetooth: RFCOMM socket layer initialized
[    3.236357] Bluetooth: RFCOMM ver 1.11
[    3.236424] Using IPI No-Shortcut mode
[    3.236819] PM: Resume from disk failed.
[    3.236852] registered taskstats version 1
[    3.237200]   Magic number: 9:91:397
[    3.237242] mem random: hash matches
[    3.237358] rtc_cmos 00:07: setting system clock to 2009-09-15 20:23:29 UTC (1253046209)
[    3.237365] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    3.237369] EDD information not available.
[    3.254106] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
[    3.400035] ata6: SATA link down (SStatus 0 SControl 300)
[    3.400044] ata3: SATA link down (SStatus 0 SControl 300)
[    3.400078] ata5: SATA link down (SStatus 0 SControl 300)
[    3.564025] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.564049] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.564066] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.566114] ata1.00: ATA-7: Maxtor 6B200M0, BANC1B10, max UDMA/133
[    3.566122] ata1.00: 398297088 sectors, multi 0: LBA48 NCQ (not used)
[    3.569124] ata1.00: configured for UDMA/133
[    3.569356] scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6B200M0   BANC PQ: 0 ANSI: 5
[    3.570171] sd 0:0:0:0: [sda] 398297088 512-byte logical blocks: (203 GB/189 GiB)
[    3.570238] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.570366] sd 0:0:0:0: [sda] Write Protect is off
[    3.570373] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.570453] ata4.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[    3.570461] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.570471] ata4.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    3.570533] ata2.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[    3.570540] ata2.00: 2930277168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    3.570831]  sda:
[    3.577023] ata4.00: configured for UDMA/133
[    3.577090] ata2.00: configured for UDMA/133
[    3.577277] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0 PQ: 0 ANSI: 5
[    3.577913] sd 1:0:0:0: [sdb] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[    3.578047] sd 1:0:0:0: [sdb] Write Protect is off
[    3.578055] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    3.578125] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.578477]  sdb:
[    3.578800] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    3.579032] scsi 3:0:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0 PQ: 0 ANSI: 5
[    3.579607] sd 3:0:0:0: [sdc] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[    3.579775] sd 3:0:0:0: [sdc] Write Protect is off
[    3.579782] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    3.579836] sd 3:0:0:0: Attached scsi generic sg2 type 0
[    3.579866] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.580227]  sdc: unknown partition table
[    3.585921] sd 3:0:0:0: [sdc] Attached SCSI disk
[    3.590256]  unknown partition table
[    3.590875] sd 1:0:0:0: [sdb] Attached SCSI disk
[    3.594228]  sda1 sda2 sda3
[    3.595267] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.595312] Freeing unused kernel memory: 536k freed
[    3.595795] Write protecting the kernel text: 4536k
[    3.595870] Write protecting the kernel read-only data: 1824k
[    3.664559] usb 3-5: new low speed USB device using ohci_hcd and address 2
[    3.804109] Linux agpgart interface v0.103
[    3.866646] [drm] Initialized drm 1.1.0 20060810
[    3.872281] usb 3-5: configuration #1 chosen from 1 choice
[    4.337909] forcedeth: Reverse Engineered nForce ethernet driver. Version 0.64.
[    4.339006] ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 21
[    4.339018] forcedeth 0000:00:0a.0: PCI INT A -> Link[LMAC] -> GSI 21 (level, low) -> IRQ 21
[    4.339032] forcedeth 0000:00:0a.0: setting latency timer to 64
[    4.439570] usbcore: registered new interface driver hiddev
[    4.454502] input: B16_b_02 USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:04.0/usb3/3-5/3-5:1.0/input/input4
[    4.454774] generic-usb 0003:046D:C025.0001: input,hidraw0: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:04.0-5/input0
[    4.454832] usbcore: registered new interface driver usbhid
[    4.454843] usbhid: v2.6:USB HID core driver
[    4.471778] forcedeth 0000:00:0a.0: ifname eth0, PHY OUI 0x732 @ 3, addr 00:01:2e:23:2e:85
[    4.471795] forcedeth 0000:00:0a.0: highdma csum pwrctl gbit lnktim msi desc-v3
[    5.161095] EXT4-fs (sda2): barriers enabled
[    5.174296] kjournald2 starting: pid 1182, dev sda2:8, commit interval 5 seconds
[    5.174325] EXT4-fs (sda2): delayed allocation enabled
[    5.174335] EXT4-fs: file extents enabled
[    5.177327] EXT4-fs: mballoc enabled
[    5.177358] EXT4-fs (sda2): mounted filesystem with ordered data mode
[    7.003580] udev: starting version 146
[    7.837563] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    7.857751] cfg80211: Calling CRDA to update world regulatory domain
[    7.871933] i2c-adapter i2c-0: nForce2 SMBus adapter at 0x4d00
[    7.871949] ACPI: I/O resource nForce2_smbus [0x4e00-0x4e3f] conflicts with ACPI region SM00 [0x4e00-0x4e3f]
[    7.871960] ACPI: Device needs an ACPI driver
[    7.871966] nForce2_smbus 0000:00:03.2: Error probing SMB2.
[    8.483727] cfg80211: World regulatory domain updated:
[    8.483735] 	(start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
[    8.483743] 	(2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[    8.483750] 	(2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[    8.483756] 	(2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
[    8.483763] 	(5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[    8.483769] 	(5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
[    8.790117] nvidia: module license 'NVIDIA' taints kernel.
[    8.790126] Disabling lock debugging due to kernel taint
[    8.876121] ACPI: PCI Interrupt Link [LN3A] enabled at IRQ 19
[    8.876133]   alloc irq_desc for 19 on node -1
[    8.876139]   alloc kstat_irqs on node -1
[    8.876154] ath9k 0000:04:00.0: PCI INT A -> Link[LN3A] -> GSI 19 (level, low) -> IRQ 19
[    8.876170] ath9k 0000:04:00.0: setting latency timer to 64
[    9.053445] ACPI: PCI Interrupt Link [SGRU] enabled at IRQ 20
[    9.053457] nvidia 0000:03:00.0: PCI INT A -> Link[SGRU] -> GSI 20 (level, low) -> IRQ 20
[    9.053470] nvidia 0000:03:00.0: setting latency timer to 64
[    9.054590] NVRM: loading NVIDIA UNIX x86 Kernel Module  185.18.36  Fri Aug 14 17:18:04 PDT 2009
[    9.305674] ath: EEPROM regdomain: 0x60
[    9.305681] ath: EEPROM indicates we should expect a direct regpair map
[    9.305688] ath: Country alpha2 being used: 00
[    9.305692] ath: Regpair used: 0x60
[    9.833983] phy0: Selected rate control algorithm 'ath9k_rate_control'
[    9.835492] Registered led device: ath9k-phy0::radio
[    9.835531] Registered led device: ath9k-phy0::assoc
[    9.835569] Registered led device: ath9k-phy0::tx
[    9.835613] Registered led device: ath9k-phy0::rx
[    9.835657] phy0: Atheros AR9280 MAC/BB Rev:2 AR5133 RF Rev:d0: mem=0xf9740000, irq=19
[    9.900263] HDA Intel 0000:00:08.0: power state changed by ACPI to D0
[    9.901116] ACPI: PCI Interrupt Link [LAZA] enabled at IRQ 23
[    9.901127] HDA Intel 0000:00:08.0: PCI INT A -> Link[LAZA] -> GSI 23 (level, low) -> IRQ 23
[    9.901182] HDA Intel 0000:00:08.0: setting latency timer to 64
[   10.492028] hda_codec: Unknown model for ALC662 rev1, trying auto-probe from BIOS...
[   10.720259] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:08.0/input/input5
[   11.737743] lp: driver loaded but no devices found
[   12.024594] coretemp: Unknown CPU model 1c
[   12.024600] coretemp: Unknown CPU model 1c
[   12.024605] coretemp: Unknown CPU model 1c
[   12.024609] coretemp: Unknown CPU model 1c
[   13.096720] EXT4-fs (sda2): internal journal on sda2:8
[   15.387232] type=1505 audit(1253039021.646:2): operation="profile_load" pid=2041 name=/usr/bin/evince
[   15.394689] type=1505 audit(1253039021.654:3): operation="profile_load" pid=2041 name=/usr/bin/evince-previewer
[   15.399367] type=1505 audit(1253039021.658:4): operation="profile_load" pid=2041 name=/usr/bin/evince-thumbnailer
[   15.442243] type=1505 audit(1253039021.702:5): operation="profile_load" pid=2042 name=/usr/bin/virt-aa-helper
[   15.445658] type=1505 audit(1253039021.706:6): operation="profile_load" pid=2043 name=/usr/share/gdm/guest-session/Xsession
[   15.449157] type=1505 audit(1253039021.710:7): operation="profile_load" pid=2044 name=/usr/sbin/libvirtd
[   15.472710] type=1505 audit(1253039021.734:8): operation="profile_load" pid=2045 name=/usr/sbin/tcpdump
[   15.493566] type=1505 audit(1253039021.754:9): operation="profile_load" pid=2046 name=/usr/lib/cups/backend/cups-pdf
[   15.494299] type=1505 audit(1253039021.754:10): operation="profile_load" pid=2046 name=/usr/sbin/cupsd
[   15.498679] type=1505 audit(1253039021.758:11): operation="profile_load" pid=2047 name=/sbin/dhclient3
[   24.885171] QEMU Accelerator Module version 1.4.0, Copyright (c) 2005-2008 Fabrice Bellard
[   24.886162] KQEMU installed, max_locked_mem=1677700kB.
[   26.960624] vboxdrv: Trying to deactivate the NMI watchdog permanently...
[   26.960635] vboxdrv: Warning: 2.6.31+ kernel detected. Most likely the hwardware performance
[   26.960639] vboxdrv: counter framework which can generate NMIs is active. You have to prevent
[   26.960643] vboxdrv: the usage of hardware performance counters by
[   26.960646] vboxdrv:   echo 2 > /proc/sys/kernel/perf_counter_paranoid
[   26.960655] vboxdrv: Found 4 processor cores.
[   26.961800] vboxdrv: fAsync=0 offMin=0x60c offMax=0x360c
[   26.962544] vboxdrv: TSC mode is 'synchronous', kernel timer mode is 'normal'.
[   26.962552] vboxdrv: Successfully loaded version 3.0.4 (interface 0x000e0000).
[   28.949875] Bridge firewalling registered
[   29.046710] virbr0: starting userspace STP failed, starting kernel STP
[   29.205305] ip_tables: (C) 2000-2006 Netfilter Core Team
[   29.603470] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   29.605539] CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
[   29.605548] nf_conntrack.acct=1 kernel parameter, acct=1 nf_conntrack module option or
[   29.605553] sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
[   31.469026] ADDRCONF(NETDEV_UP): wlan0: link is not ready
[   32.532232] lo: Disabled Privacy Extensions
[   32.543432] ppdev: user-space parallel port driver
[   36.813713] CPU0 attaching NULL sched-domain.
[   36.813726] CPU1 attaching NULL sched-domain.
[   36.813732] CPU2 attaching NULL sched-domain.
[   36.813737] CPU3 attaching NULL sched-domain.
[   36.828639] CPU0 attaching sched-domain:
[   36.828646]  domain 0: span 0,2 level SIBLING
[   36.828653]   groups: 0 2
[   36.828662]   domain 1: span 0-3 level MC
[   36.828668]    groups: 0,2 (__cpu_power = 2048) 1,3 (__cpu_power = 2048)
[   36.828683] CPU1 attaching sched-domain:
[   36.828688]  domain 0: span 1,3 level SIBLING
[   36.828693]   groups: 1 3
[   36.828702]   domain 1: span 0-3 level MC
[   36.828707]    groups: 1,3 (__cpu_power = 2048) 0,2 (__cpu_power = 2048)
[   36.828720] CPU2 attaching sched-domain:
[   36.828726]  domain 0: span 0,2 level SIBLING
[   36.828731]   groups: 2 0
[   36.828739]   domain 1: span 0-3 level MC
[   36.828744]    groups: 0,2 (__cpu_power = 2048) 1,3 (__cpu_power = 2048)
[   36.828757] CPU3 attaching sched-domain:
[   36.828762]  domain 0: span 1,3 level SIBLING
[   36.828768]   groups: 3 1
[   36.828776]   domain 1: span 0-3 level MC
[   36.828781]    groups: 1,3 (__cpu_power = 2048) 0,2 (__cpu_power = 2048)
[   38.179127] CPU0 attaching NULL sched-domain.
[   38.179140] CPU1 attaching NULL sched-domain.
[   38.179147] CPU2 attaching NULL sched-domain.
[   38.179152] CPU3 attaching NULL sched-domain.
[   38.189670] CPU0 attaching sched-domain:
[   38.189678]  domain 0: span 0,2 level SIBLING
[   38.189685]   groups: 0 2
[   38.189694]   domain 1: span 0-3 level CPU
[   38.189700]    groups: 0,2 1,3
[   38.189711] CPU1 attaching sched-domain:
[   38.189716]  domain 0: span 1,3 level SIBLING
[   38.189721]   groups: 1 3
[   38.189730]   domain 1: span 0-3 level CPU
[   38.189735]    groups: 1,3 0,2
[   38.189744] CPU2 attaching sched-domain:
[   38.189749]  domain 0: span 0,2 level SIBLING
[   38.189754]   groups: 2 0
[   38.189763]   domain 1: span 0-3 level CPU
[   38.189768]    groups: 0,2 1,3
[   38.189778] CPU3 attaching sched-domain:
[   38.189783]  domain 0: span 1,3 level SIBLING
[   38.189788]   groups: 3 1
[   38.189796]   domain 1: span 0-3 level CPU
[   38.189801]    groups: 1,3 0,2
[   42.185030] eth0: no IPv6 routers present
[   52.765904] hda-intel: Too big adjustment 32
[   52.785273] hda-intel: Too big adjustment 32
[   52.951495] hda-intel: Too big adjustment 32
[   52.969143] hda-intel: Too big adjustment 32
[   53.080554] hda-intel: Too big adjustment 32
[   53.088348] hda-intel: Too big adjustment 32
[   53.111728] hda-intel: Too big adjustment 32
[   54.528701] hda-intel: Too big adjustment 32
[   54.550216] hda-intel: Too big adjustment 32
[   54.715482] hda-intel: Too big adjustment 32
[   54.733744] hda-intel: Too big adjustment 32
[   54.790293] hda-intel: Too big adjustment 32
[   54.795877] hda-intel: Too big adjustment 32
[   54.821438] hda-intel: Too big adjustment 32
[   77.579525] wlan0: authenticate with AP 00:23:f8:17:c8:50
[   77.776085] wlan0: authenticate with AP 00:23:f8:17:c8:50
[   77.785376] wlan0: authenticated
[   77.785386] wlan0: associate with AP 00:23:f8:17:c8:50
[   77.799786] wlan0: RX AssocResp from 00:23:f8:17:c8:50 (capab=0x431 status=0 aid=3)
[   77.799797] wlan0: associated
[   77.800675] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   78.270418] padlock: VIA PadLock not detected.
[   88.432014] wlan0: no IPv6 routers present
[   91.768084] i2c /dev entries driver
[  123.430314] wlan0: disassociating by local choice (reason=3)

--------------050504040808070401020009
Content-Type: text/plain;
 name="i2cdetect"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2cdetect"

$ sudo i2cdetect -l
i2c-0	smbus     	SMBus nForce2 adapter at 4d00   	SMBus adapter
i2c-1	i2c       	NVIDIA i2c adapter              	I2C adapter
i2c-2	i2c       	NVIDIA i2c adapter              	I2C adapter
i2c-3	i2c       	NVIDIA i2c adapter              	I2C adapter

$ sudo i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- 4c -- -- -- 
50: 50 51 52 53 54 55 56 57 -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --

$ sudo i2cdetect 1
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-1.
I will probe address range 0x03-0x77.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --

$ sudo i2cdetect 2
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-2.
I will probe address range 0x03-0x77.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --

$ sudo i2cdetect 3
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-3.
I will probe address range 0x03-0x77.
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --

--------------050504040808070401020009
Content-Type: text/plain;
 name="lmsensors"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lmsensors"

$ sudo ./sensors-detect 
# sensors-detect revision 5769 (2009-09-14 12:50:45 +0200)
# System: To Be Filled By O.E.M. To Be Filled By O.E.M.
# Board: To be filled by O.E.M. To be filled by O.E.M.

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): 
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No
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
interfaces? (YES/no): 
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): 
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): 
Using driver `i2c-nforce2' for device 0000:00:03.2: nVidia Corporation nForce SMBus (MCP79)

Next adapter: SMBus nForce2 adapter at 4d00 (i2c-0)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x4c
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `Analog Devices ADT7466'...                     No
Probing for `Andigilog aSC7511'...                          No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Analog Devices ADM1021'...                     No
Probing for `Analog Devices ADM1021A/ADM1023'...            No
Probing for `Maxim MAX1617'...                              No
Probing for `Maxim MAX1617A'...                             No
Probing for `Maxim MAX1668'...                              No
Probing for `Maxim MAX1805'...                              No
Probing for `Maxim MAX1989'...                              No
Probing for `Maxim MAX6655/MAX6656'...                      No
Probing for `TI THMC10'...                                  No
Probing for `National Semiconductor LM84'...                No
Probing for `Genesys Logic GL523SM'...                      No
Probing for `Onsemi MC1066'...                              No
Probing for `Maxim MAX1618'...                              No
Probing for `Maxim MAX1619'...                              No
Probing for `National Semiconductor LM82/LM83'...           No
Probing for `National Semiconductor LM90'...                No
Probing for `National Semiconductor LM89/LM99'...           No
Probing for `National Semiconductor LM86'...                No
Probing for `Analog Devices ADM1032'...                     No
Probing for `Maxim MAX6654/MAX6690'...                      No
Probing for `Maxim MAX6657/MAX6658/MAX6659'...              No
Probing for `Maxim MAX6648/MAX6649/MAX6692'...              No
Probing for `Maxim MAX6680/MAX6681'...                      No
Probing for `Winbond W83L771W/G'...                         No
Probing for `Texas Instruments TMP401'...                   No
Probing for `Texas Instruments TMP411'...                   No
Probing for `Texas Instruments TMP421'...                   No
Probing for `Texas Instruments TMP422'...                   No
Probing for `Texas Instruments TMP423'...                   No
Probing for `National Semiconductor LM63'...                No
Probing for `Fintek F75363SG'...                            No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `Analog Devices ADT7461'...                     No
Probing for `Analog Devices ADT7481'...                     No
Probing for `Fintek F75383S/M'...                           No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No

Next adapter: NVIDIA i2c adapter  (i2c-1)
Do you want to scan it? (YES/no/selectively): 

Next adapter: NVIDIA i2c adapter  (i2c-2)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter: NVIDIA i2c adapter  (i2c-3)
Do you want to scan it? (YES/no/selectively): 

Sorry, no sensors were detected.
Either your system has no sensors, or they are not supported, or
they are connected to an I2C or SMBus adapter that is not
supported. If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.

--------------050504040808070401020009
Content-Type: text/plain;
 name="lsmod"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod"

Module                  Size  Used by
i2c_dev                 6500  0 
aes_i586                8124  0 
aes_generic            27484  1 aes_i586
binfmt_misc             8356  1 
ppdev                   6688  0 
ipt_MASQUERADE          2204  1 
iptable_nat             5500  1 
nf_nat                 17808  2 ipt_MASQUERADE,iptable_nat
nf_conntrack_ipv4      13352  4 iptable_nat,nf_nat
nf_defrag_ipv4          1756  1 nf_conntrack_ipv4
xt_state                1820  1 
nf_conntrack           67608  5 ipt_MASQUERADE,iptable_nat,nf_nat,nf_conntrack_ipv4,xt_state
ipt_REJECT              2812  2 
xt_tcpudp               2780  4 
iptable_filter          3100  1 
ip_tables              11692  2 iptable_nat,iptable_filter
x_tables               16544  6 ipt_MASQUERADE,iptable_nat,xt_state,ipt_REJECT,xt_tcpudp,ip_tables
bridge                 47952  0 
stp                     2272  1 bridge
vboxnetadp             77928  0 
vboxnetflt             84488  0 
vboxdrv               120776  1 vboxnetflt
kqemu                 122084  0 
dm_crypt               12928  0 
sbp2                   22888  0 
ieee1394               86628  1 sbp2
lp                      8964  0 
parport                35340  2 ppdev,lp
snd_hda_codec_nvhdmi     4764  1 
snd_hda_codec_realtek   203232  1 
snd_hda_intel          26600  2 
snd_hda_codec          69276  3 snd_hda_codec_nvhdmi,snd_hda_codec_realtek,snd_hda_intel
snd_pcm_oss            37920  0 
arc4                    1660  2 
snd_mixer_oss          16028  1 snd_pcm_oss
ecb                     2524  2 
snd_pcm                75264  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_seq_dummy           2656  0 
snd_seq_oss            28576  0 
snd_seq_midi            6432  0 
snd_rawmidi            22208  1 snd_seq_midi
snd_seq_midi_event      6940  2 snd_seq_oss,snd_seq_midi
snd_seq                50224  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              22276  2 snd_pcm,snd_seq
snd_seq_device          6920  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd                    59204  15 snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore               7264  1 snd
ath9k                 258712  0 
snd_page_alloc          9156  2 snd_hda_intel,snd_pcm
nvidia               9586376  36 
mac80211              181076  1 ath9k
led_class               4096  1 ath9k
ath                     8060  1 ath9k
i2c_nforce2             6784  0 
shpchp                 32272  0 
cfg80211               93084  3 ath9k,mac80211,ath
forcedeth              54152  0 
usbhid                 38208  0 
fbcon                  36544  0 
tileblit                2460  1 fbcon
font                    8124  1 fbcon
bitblit                 5308  1 fbcon
softcursor              1756  1 bitblit
i915                  218344  0 
drm                   159584  1 i915
i2c_algo_bit            5760  1 i915
video                  19092  1 i915
output                  2780  1 video
intel_agp              26748  0 
agpgart                34988  3 nvidia,drm,intel_agp

--------------050504040808070401020009--

--------------ms020106080200010005080108
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILqTCC
Az8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENv
bnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVy
c29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5
NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9Vvy
Gna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOC
dz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhh
d3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQAD
gYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFi
w9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpb
NU1341YheILcIRk13iSx0x1G/11fZU8wggQvMIIDmKADAgECAhB1oZd0ulUyzGAiSf6CeJYS
MA0GCSqGSIb3DQEBBQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQTAeFw0wOTA1MjMwNzUyNTJaFw0xMDA1MjMwNzUyNTJaMIIBGjEOMAwGA1UEBBMF
QWduZXIxDzANBgNVBCoTBlN0ZWZhbjEVMBMGA1UEAxMMU3RlZmFuIEFnbmVyMR4wHAYJKoZI
hvcNAQkBFg9zdGVmYW5AYWduZXIuY2gxHzAdBgkqhkiG9w0BCQEWEGluZm9AZmFsc3RhZmYu
Y2gxJjAkBgkqhkiG9w0BCQEWF2ZhbHN0YWZmQHBpbGF0dXNjaGF0LmNoMSkwJwYJKoZIhvcN
AQkBFhpzdGVmYW4uYWduZXJAa211LW9mZmljZS5jaDEiMCAGCSqGSIb3DQEJARYTZmFsc3Rh
ZmZAZGVoZWltZS5jaDEoMCYGCSqGSIb3DQEJARYZc3RlZmFuLmFnbmVyQHN0dWQuaHNsdS5j
aDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKO0oa9Q0urbCn+PB8JWoqMACX+w
ssnrSfSTmVRgzQuu2m/if16/tPahCgKwYnlSVUTtsS8fyRPm0Ogs1jBFV3vtqDp2E1LWPmL5
PtmOBNvBNxQYpVlsew5oomlp+szJ7jy1uely4E6GCnyRtcExVczHv7eaVrld4zEoZG6jGbdw
fxXR1uF917dYDyzlH61TFz1KBO2SMEGBO+ItEaGsthKrlmrnaqrif4rQnIWATB7eQGI1aIXF
OAQFq7vtlHrHAFlGKjjgL2O5BwhD/pQbzcvU2P1IMHwUkUo8Tm0Ol9CqkdK20dsBKCsOMVeH
q6aXeLdHxugOfB0j/vyzMvCKBZ8CAwEAAaOBpzCBpDCBkwYDVR0RBIGLMIGIgQ9zdGVmYW5A
YWduZXIuY2iBEGluZm9AZmFsc3RhZmYuY2iBF2ZhbHN0YWZmQHBpbGF0dXNjaGF0LmNogRpz
dGVmYW4uYWduZXJAa211LW9mZmljZS5jaIETZmFsc3RhZmZAZGVoZWltZS5jaIEZc3RlZmFu
LmFnbmVyQHN0dWQuaHNsdS5jaDAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAAPk
az+hdUmmCbkDlGmMtUq1i5ZgGizIxPP9hHFrhKqvrHfp8vxZhWVsZl/+/B7ExvHyx/0xpAFb
E8RpMfXfsiWlZD+iYqgPgRdKw6MiCIB21+RPkgmFIptgvzH4yus3WRrKNOyNUf27VkudCLbR
utiCQdmLrDCPmehaaZLhE57iMIIELzCCA5igAwIBAgIQdaGXdLpVMsxgIkn+gniWEjANBgkq
hkiG9w0BAQUFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcg
KFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vpbmcg
Q0EwHhcNMDkwNTIzMDc1MjUyWhcNMTAwNTIzMDc1MjUyWjCCARoxDjAMBgNVBAQTBUFnbmVy
MQ8wDQYDVQQqEwZTdGVmYW4xFTATBgNVBAMTDFN0ZWZhbiBBZ25lcjEeMBwGCSqGSIb3DQEJ
ARYPc3RlZmFuQGFnbmVyLmNoMR8wHQYJKoZIhvcNAQkBFhBpbmZvQGZhbHN0YWZmLmNoMSYw
JAYJKoZIhvcNAQkBFhdmYWxzdGFmZkBwaWxhdHVzY2hhdC5jaDEpMCcGCSqGSIb3DQEJARYa
c3RlZmFuLmFnbmVyQGttdS1vZmZpY2UuY2gxIjAgBgkqhkiG9w0BCQEWE2ZhbHN0YWZmQGRl
aGVpbWUuY2gxKDAmBgkqhkiG9w0BCQEWGXN0ZWZhbi5hZ25lckBzdHVkLmhzbHUuY2gwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCjtKGvUNLq2wp/jwfCVqKjAAl/sLLJ60n0
k5lUYM0Lrtpv4n9ev7T2oQoCsGJ5UlVE7bEvH8kT5tDoLNYwRVd77ag6dhNS1j5i+T7ZjgTb
wTcUGKVZbHsOaKJpafrMye48tbnpcuBOhgp8kbXBMVXMx7+3mla5XeMxKGRuoxm3cH8V0dbh
fde3WA8s5R+tUxc9SgTtkjBBgTviLRGhrLYSq5Zq52qq4n+K0JyFgEwe3kBiNWiFxTgEBau7
7ZR6xwBZRio44C9juQcIQ/6UG83L1Nj9SDB8FJFKPE5tDpfQqpHSttHbASgrDjFXh6uml3i3
R8boDnwdI/78szLwigWfAgMBAAGjgacwgaQwgZMGA1UdEQSBizCBiIEPc3RlZmFuQGFnbmVy
LmNogRBpbmZvQGZhbHN0YWZmLmNogRdmYWxzdGFmZkBwaWxhdHVzY2hhdC5jaIEac3RlZmFu
LmFnbmVyQGttdS1vZmZpY2UuY2iBE2ZhbHN0YWZmQGRlaGVpbWUuY2iBGXN0ZWZhbi5hZ25l
ckBzdHVkLmhzbHUuY2gwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQUFAAOBgQAD5Gs/oXVJ
pgm5A5RpjLVKtYuWYBosyMTz/YRxa4Sqr6x36fL8WYVlbGZf/vwexMbx8sf9MaQBWxPEaTH1
37IlpWQ/omKoD4EXSsOjIgiAdtfkT5IJhSKbYL8x+MrrN1kayjTsjVH9u1ZLnQi20brYgkHZ
i6wwj5noWmmS4ROe4jGCA3EwggNtAgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAhB1oZd0ulUyzGAiSf6CeJYSMAkGBSsOAwIaBQCgggHQMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA5MDkxNTE5NDMzNlow
IwYJKoZIhvcNAQkEMRYEFHpD9zLikdnsJc+zGZbNuhuC59qCMF8GCSqGSIb3DQEJDzFSMFAw
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBhQYJKwYBBAGCNxAEMXgwdjBiMQswCQYDVQQG
EwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMj
VGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEHWhl3S6VTLMYCJJ/oJ4lhIw
gYcGCyqGSIb3DQEJEAILMXigdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENv
bnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWls
IElzc3VpbmcgQ0ECEHWhl3S6VTLMYCJJ/oJ4lhIwDQYJKoZIhvcNAQEBBQAEggEAAroKtifz
Z5bz/7ytmmnrpol4Hxt/t/bn/1oypVsvSjQNmsSZX74XpppEDageW/AL/GgTZjkQ/V7C5CgE
fQYhjAyUOD6Y5OL9jbGSrCjQnvK4iCfqW2LgR0G7Ym3D/l+kyMPPkHnWEoVW7RE4CtDVdeNH
GZY2dyqk+doVfdmRDVuShLi3FZ0HUgDSNoUTucAl5OSYt3Wb1djCbwg63nVWQEWlLk+AE7H9
VRH8B4WvslPpBIZcZXvVpha8BaL+jCSHPWC9ZGdiogWI5UsvQqb/PGL0YKSFMfmomEiINVnv
pzk2rpqRMrWZ8ozLKfDzHY3G62xyuXD9m+mQHjd2N7rIwQAAAAAAAA==
--------------ms020106080200010005080108--


--===============1566192821892615001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1566192821892615001==--
