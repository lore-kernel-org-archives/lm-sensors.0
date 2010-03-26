From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Fri, 26 Mar 2010 22:18:23 +0000
Subject: [lm-sensors] Jetway NC92-330-LF and Fintek 71862FG Sensors
Message-Id: <6350.199.74.155.50.1269641903.squirrel@webmail.myamigos.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_20100326171823_74909"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

------=_20100326171823_74909
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I am using the Jetway NC-92-330-LF as a multi-purpose firewall and router
with the attachment of the 3 port GigE daughterboard. In Fedora Core 10,
the sensors on the Fintek 71862FG Super I/O chip were detected and
accessible to LM-Sensors.

Now in Fedora Core 12 running kernel 2.6.32.9-70.fc12.i686.PAE the Fintek
F71862FG sensors are not accessible to LM-Sensors, apparently due to ACPI
conflict.

The output of "sensors" on kernel 2.6.32.9-70.fc12.i686.PAE looks like this:

[root@XX ~]# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +36.0=C2=B0C  (crit =3D +100.0=C2=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +43.0=C2=B0C  (crit =3D +90.0=C2=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +36.0=C2=B0C  (crit =3D +90.0=C2=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +37.0=C2=B0C  (crit =3D +90.0=C2=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +43.0=C2=B0C  (crit =3D +90.0=C2=B0C)

Examination of "/var/log/messages" shows:

Mar 26 16:34:58 XX yum: Installed: i2c-tools-3.0.2-4.fc12.i686
Mar 26 16:37:06 XX kernel: i2c /dev entries driver
Mar 26 16:37:21 XX kernel: f71882fg: Found f71862fg chip at 0x290,
revision 18
Mar 26 16:37:21 XX kernel: ACPI: I/O resource f71882fg [0x290-0x297]
conflicts with ACPI region IP__ [0x295-0x296]
Mar 26 16:37:21 XX kernel: ACPI: If an ACPI driver is available for this
device, you should use it instead of the native driver


The output of lspci -nn looks like this:

[root@XX ~]# lspci -nn | more
00:00.0 Host bridge [0600]: Intel Corporation 82945G/GZ/P/PL Memory
Controller Hub [8086:2770] (rev 02)
00:02.0 VGA compatible controller [0300]: Intel Corporation 82945G/GZ
Integrated Graphics Controller [8086:2772] (rev 02)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 1 [8086:27d0] (rev 01)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #1 [8086:27c8] (rev 01)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #2 [8086:27c9] (rev 01)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #3 [8086:27ca] (rev 01)
00:1d.3 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #4 [8086:27cb] (rev 01)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller [8086:27cc] (rev 01)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e]
(rev e1)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge [8086:27b8] (rev 01)
00:1f.2 IDE interface [0101]: Intel Corporation 82801GB/GR/GH (ICH7
Family) SATA IDE Controller [8086:27c0] (rev 01)
00:1f.3 SMBus [0c05]: Intel Corporation 82801G (ICH7 Family) SMBus
Controller [8086:27da] (rev 01)
01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller [10ec:8168] (rev 02)
02:04.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL-8110SC/8169SC Gigabit Ethernet [10ec:8167] (rev 10)
02:06.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL-8110SC/8169SC Gigabit Ethernet [10ec:8167] (rev 10)
02:07.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL-8110SC/8169SC Gigabit Ethernet [10ec:8167] (rev 10)

The "i2cdetect -l" command does not output anything on the console.

The output of "sensors-detect" is included in the attached
"XX_sensors-detect_output.txt" file.

The output of "lsmod" is included in the attached "XX_lsmod_output.txt" fil=
e.

The output of "dmesg" is included in the attached "XX_dmesg_output.txt" fil=
e.

Regressing the machine back to Fedora Core 10, or compiling code on this
hardware is not an option. The reference setup on the lm-sensors web site,
"http://www.lm-sensors.org/wiki/Configurations/Jetway/NC92-330-LF", did
work for me in Fedora Core 10.

Any comments or assistance is greatly appreciated.

Jeff

------=_20100326171823_74909
Content-Type: text/plain; name="XX_dmesg_output.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="XX_dmesg_output.txt"

[root@XX ~]# dmesg | less
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Linux version 2.6.32.9-70.fc12.i686.PAE (mockbuild@x86-02.phx2.fedoraproject.org) (gcc version 4.4.3 20100127 (Red Hat 4.4.3-4) (GCC) ) #1 SMP Wed Mar 3 04:57:21 UTC 2010
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  NSC Geode by NSC
  Cyrix CyrixInstead
  Centaur CentaurHauls
  Transmeta GenuineTMx86
  Transmeta TransmetaCPU
  UMC UMC UMC UMC
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007f690000 (usable)
 BIOS-e820: 000000007f690000 - 000000007f6e0000 (reserved)
 BIOS-e820: 000000007f6e0000 - 000000007f6e3000 (ACPI NVS)
 BIOS-e820: 000000007f6e3000 - 000000007f6f0000 (ACPI data)
 BIOS-e820: 000000007f6f0000 - 000000007f700000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
DMI 2.2 present.
Phoenix BIOS detected: BIOS may corrupt low RAM, working around it.
e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
last_pfn = 0x7f690 max_arch_pfn = 0x1000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-F7FFF uncachable
  F8000-FBFFF write-through
  FC000-FFFFF uncachable
MTRR variable ranges enabled:
  0 base 000000000 mask 080000000 write-back
  1 base 07F800000 mask 0FF800000 uncachable
  2 base 07F700000 mask 0FFF00000 uncachable
  3 disabled
  4 disabled
  5 disabled
  6 disabled
  7 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
original variable MTRRs
reg 0, base: 0GB, range: 2GB, type WB
reg 1, base: 2040MB, range: 8MB, type UC
reg 2, base: 2039MB, range: 1MB, type UC
total RAM covered: 2039M
Found optimal setting for mtrr clean up
 gran_size: 64K         chunk_size: 16M         num_reg: 3      lose cover RAM: 0G
New variable MTRRs
reg 0, base: 0GB, range: 2GB, type WB
reg 1, base: 2039MB, range: 1MB, type UC
reg 2, base: 2040MB, range: 8MB, type UC
initial memory mapped : 0 - 01000000
init_memory_mapping: 0000000000000000-00000000375fe000
Using x86 segment limits to approximate NX protection
 0000000000 - 0000200000 page 4k
 0000200000 - 0037400000 page 2M
 0037400000 - 00375fe000 page 4k
kernel direct mapping tables up to 375fe000 @ 10000-18000
RAMDISK: 374cd000 - 37fef0d8
Allocated new RAMDISK: 00b6a000 - 0168c0d8
Move RAMDISK from 00000000374cd000 - 0000000037fef0d7 to 00b6a000 - 0168c0d7
ACPI: RSDP 000f8110 00014 (v00 IntelR)
ACPI: RSDT 7f6e3000 00030 (v01 IntelR AWRDACPI 42302E31 AWRD 00000000)
ACPI: FACP 7f6e3080 00074 (v01 IntelR AWRDACPI 42302E31 AWRD 00000000)
ACPI: DSDT 7f6e3100 05155 (v01 INTELR AWRDACPI 00001000 MSFT 03000000)
ACPI: FACS 7f6e0000 00040
ACPI: MCFG 7f6e8340 0003C (v01 IntelR AWRDACPI 42302E31 AWRD 00000000)
ACPI: APIC 7f6e8280 00084 (v01 IntelR AWRDACPI 42302E31 AWRD 00000000)
ACPI: Local APIC address 0xfee00000
1152MB HIGHMEM available.
885MB LOWMEM available.
  mapped low ram: 0 - 375fe000
  low ram: 0 - 375fe000
  node 0 low ram: 00000000 - 375fe000
  node 0 bootmap 00014000 - 0001aec0
(9 early reservations) ==> bootmem [0000000000 - 00375fe000]
  #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
  #1 [0000001000 - 0000002000]    EX TRAMPOLINE ==> [0000001000 - 0000002000]
  #2 [0000006000 - 0000007000]       TRAMPOLINE ==> [0000006000 - 0000007000]
  #3 [0000400000 - 0000b600d8]    TEXT DATA BSS ==> [0000400000 - 0000b600d8]
  #4 [000009f000 - 0000100000]    BIOS reserved ==> [000009f000 - 0000100000]
  #5 [0000b61000 - 0000b6906e]              BRK ==> [0000b61000 - 0000b6906e]
  #6 [0000010000 - 0000014000]          PGTABLE ==> [0000010000 - 0000014000]
  #7 [0000b6a000 - 000168c0d8]      NEW RAMDISK ==> [0000b6a000 - 000168c0d8]
  #8 [0000014000 - 000001b000]          BOOTMAP ==> [0000014000 - 000001b000]
found SMP MP-table at [c00f3e20] f3e20
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  Normal   0x00001000 -> 0x000375fe
  HighMem  0x000375fe -> 0x0007f690
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000010 -> 0x0000009f
    0: 0x00000100 -> 0x0007f690
On node 0 totalpages: 521759
free_area_init_node: node 0, pgdat c09d6a40, node_mem_map c168e200
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 3951 pages, LIFO batch:0
  Normal zone: 1740 pages used for memmap
  Normal zone: 220978 pages, LIFO batch:31
  HighMem zone: 2306 pages used for memmap
  HighMem zone: 292752 pages, LIFO batch:31
Using APIC driver default
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x03] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
SMP: Allowing 4 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 24
PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 7f700000 (gap: 7f700000:60900000)
Booting paravirtualized kernel on bare hardware
NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:4 nr_node_ids:1
PERCPU: Embedded 15 pages/cpu @c2800000 s37816 r0 d23624 u524288
pcpu-alloc: s37816 r0 d23624 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 517681
Kernel command line: ro root=UUID=4d1a174c-248e-45ee-a8dd-c82f70426900 nomodeset LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us vga=791 cgroup_disable=memory
Disabling memory control group subsystem
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Initializing HighMem for node 0 (000375fe:0007f690)
Memory: 2049528k/2087488k available (3749k kernel code, 36428k reserved, 2358k data, 564k init, 1180232k highmem)
virtual kernel memory layout:
    fixmap  : 0xffad5000 - 0xfffff000   (5288 kB)
    pkmap   : 0xff600000 - 0xff800000   (2048 kB)
    vmalloc : 0xf7dfe000 - 0xff5fe000   ( 120 MB)
    lowmem  : 0xc0000000 - 0xf75fe000   ( 885 MB)
      .init : 0xc09f8000 - 0xc0a85000   ( 564 kB)
      .data : 0xc07a9548 - 0xc09f7118   (2358 kB)
      .text : 0xc0400000 - 0xc07a9548   (3749 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
SLUB: Genslabs=13, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:1280
Console: colour dummy device 80x25
console [tty0] enabled
Fast TSC calibration using PIT
Detected 1600.107 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.. 3200.21 BogoMIPS (lpj=1600107)
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
CPU: L1 I cache: 32K, L1 D cache: 24K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 5 MCE banks
CPU0: Thermal monitoring enabled (TM1)
using mwait in idle threads.
Performance Events: Atom events, Intel PMU driver.
... version:                3
... bit width:              40
... generic registers:      2
... value mask:             000000ffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             0000000700000003
Checking 'hlt' instruction... OK.
ACPI: Core revision 20090903
ftrace: converting mcount calls to 0f 1f 44 00 00
ftrace: allocating 23414 entries in 46 pages
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Atom(TM) CPU  330   @ 1.60GHz stepping 02
Booting processor 1 APIC 0x2 ip 0x6000
Initializing CPU#1
CPU: L1 I cache: 32K, L1 D cache: 24K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
CPU1: Intel(R) Atom(TM) CPU  330   @ 1.60GHz stepping 02
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Booting processor 2 APIC 0x3 ip 0x6000
Initializing CPU#2
CPU: L1 I cache: 32K, L1 D cache: 24K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU2: Thermal monitoring enabled (TM2)
CPU2: Intel(R) Atom(TM) CPU  330   @ 1.60GHz stepping 02
checking TSC synchronization [CPU#0 -> CPU#2]: passed.
Booting processor 3 APIC 0x1 ip 0x6000
Initializing CPU#3
CPU: L1 I cache: 32K, L1 D cache: 24K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU3: Thermal monitoring enabled (TM2)
CPU3: Intel(R) Atom(TM) CPU  330   @ 1.60GHz stepping 02
checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Brought up 4 CPUs
Total of 4 processors activated (12797.71 BogoMIPS).
sizeof(vma)=88 bytes
sizeof(page)=32 bytes
sizeof(inode)=352 bytes
sizeof(dentry)=132 bytes
sizeof(ext3inode)=508 bytes
sizeof(buffer_head)=56 bytes
sizeof(skbuff)=184 bytes
sizeof(task_struct)=3256 bytes
CPU0 attaching sched-domain:
 domain 0: span 0,3 level SIBLING
  groups: 0 (cpu_power = 589) 3 (cpu_power = 589)
  domain 1: span 0,3 level MC
   groups: 0,3 (cpu_power = 1178)
   domain 2: span 0-3 level CPU
    groups: 0,3 (cpu_power = 1178) 1-2 (cpu_power = 1178)
CPU1 attaching sched-domain:
 domain 0: span 1-2 level SIBLING
  groups: 1 (cpu_power = 589) 2 (cpu_power = 589)
  domain 1: span 1-2 level MC
   groups: 1-2 (cpu_power = 1178)
   domain 2: span 0-3 level CPU
    groups: 1-2 (cpu_power = 1178) 0,3 (cpu_power = 1178)
CPU2 attaching sched-domain:
 domain 0: span 1-2 level SIBLING
  groups: 2 (cpu_power = 589) 1 (cpu_power = 589)
  domain 1: span 1-2 level MC
   groups: 1-2 (cpu_power = 1178)
   domain 2: span 0-3 level CPU
    groups: 1-2 (cpu_power = 1178) 0,3 (cpu_power = 1178)
CPU3 attaching sched-domain:
 domain 0: span 0,3 level SIBLING
  groups: 3 (cpu_power = 589) 0 (cpu_power = 589)
  domain 1: span 0,3 level MC
   groups: 0,3 (cpu_power = 1178)
   domain 2: span 0-3 level CPU
    groups: 0,3 (cpu_power = 1178) 1-2 (cpu_power = 1178)
devtmpfs: initialized
regulator: core version 0.5
Time:  1:03:29  Date: 03/24/10
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Found Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub with MMCONFIG support.
PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
PCI: MCFG area at e0000000 reserved in E820
PCI: Using MMCONFIG for extended config space
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: No dock devices found.
ACPI: PCI Root Bridge [PCI0] (0000:00)
pci 0000:00:02.0: reg 10 32bit mmio: [0xfdf00000-0xfdf7ffff]
pci 0000:00:02.0: reg 14 io port: [0xff00-0xff07]
pci 0000:00:02.0: reg 18 32bit mmio pref: [0xd0000000-0xdfffffff]
pci 0000:00:02.0: reg 1c 32bit mmio: [0xfdf80000-0xfdfbffff]
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1d.0: reg 20 io port: [0xfe00-0xfe1f]
pci 0000:00:1d.1: reg 20 io port: [0xfd00-0xfd1f]
pci 0000:00:1d.2: reg 20 io port: [0xfc00-0xfc1f]
pci 0000:00:1d.3: reg 20 io port: [0xfb00-0xfb1f]
pci 0000:00:1d.7: reg 10 32bit mmio: [0xfdfff000-0xfdfff3ff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0480-04bf claimed by ICH6 GPIO
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0294 (mask 007f)
pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 04e0 (mask 001f)
pci 0000:00:1f.2: reg 10 io port: [0x00-0x07]
pci 0000:00:1f.2: reg 14 io port: [0x00-0x03]
pci 0000:00:1f.2: reg 18 io port: [0x00-0x07]
pci 0000:00:1f.2: reg 1c io port: [0x00-0x03]
pci 0000:00:1f.2: reg 20 io port: [0xf800-0xf80f]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:00:1f.3: reg 20 io port: [0x500-0x51f]
pci 0000:01:00.0: reg 10 io port: [0xce00-0xceff]
pci 0000:01:00.0: reg 18 64bit mmio: [0xfdbff000-0xfdbfffff]
pci 0000:01:00.0: reg 20 64bit mmio pref: [0xfdcf0000-0xfdcfffff]
pci 0000:01:00.0: reg 30 32bit mmio pref: [0x000000-0x01ffff]
pci 0000:01:00.0: supports D1 D2
pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:01:00.0: PME# disabled
pci 0000:00:1c.0: bridge io port: [0xc000-0xcfff]
pci 0000:00:1c.0: bridge 32bit mmio: [0xfdb00000-0xfdbfffff]
pci 0000:00:1c.0: bridge 64bit mmio pref: [0xfdc00000-0xfdcfffff]
pci 0000:02:04.0: reg 10 io port: [0xde00-0xdeff]
pci 0000:02:04.0: reg 14 32bit mmio: [0xfdeff000-0xfdeff0ff]
pci 0000:02:04.0: reg 30 32bit mmio pref: [0xfdec0000-0xfdedffff]
pci 0000:02:04.0: supports D1 D2
pci 0000:02:04.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:02:04.0: PME# disabled
pci 0000:02:06.0: reg 10 io port: [0xdc00-0xdcff]
pci 0000:02:06.0: reg 14 32bit mmio: [0xfdefe000-0xfdefe0ff]
pci 0000:02:06.0: reg 30 32bit mmio pref: [0xfdec0000-0xfdedffff]
pci 0000:02:06.0: supports D1 D2
pci 0000:02:06.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:02:06.0: PME# disabled
pci 0000:02:07.0: reg 10 io port: [0xda00-0xdaff]
pci 0000:02:07.0: reg 14 32bit mmio: [0xfdefd000-0xfdefd0ff]
pci 0000:02:07.0: reg 30 32bit mmio pref: [0xfdec0000-0xfdedffff]
pci 0000:00:1e.0: transparent bridge
pci 0000:00:1e.0: bridge io port: [0xd000-0xdfff]
pci 0000:00:1e.0: bridge 32bit mmio: [0xfde00000-0xfdefffff]
pci 0000:00:1e.0: bridge 64bit mmio pref: [0xfdd00000-0xfddfffff]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 *11 12 14 15)
vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: old code would have set cacheline size to 32 bytes, but clflush_size = 64
PCI: pci_cache_line_size set to 64 bytes
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
hpet clockevent registered
HPET: 3 timers in total, 0 timers will be used for per-cpu timer
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 comparators, 64-bit 14.318180 MHz counter
Switching to clocksource tsc
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp 00:06: IRQ 4 override to edge, high
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: ioport range 0x4d0-0x4d1 has been reserved
system 00:01: ioport range 0x290-0x29f has been reserved
system 00:01: ioport range 0x290-0x297 has been reserved
system 00:01: ioport range 0x880-0x88f has been reserved
system 00:09: ioport range 0x400-0x4bf could not be reserved
system 00:0b: iomem range 0xe0000000-0xefffffff has been reserved
system 00:0c: iomem range 0xf0000-0xfffff could not be reserved
system 00:0c: iomem range 0x7f6e0000-0x7f6fffff could not be reserved
system 00:0c: iomem range 0x0-0x9ffff could not be reserved
system 00:0c: iomem range 0x100000-0x7f6dffff could not be reserved
system 00:0c: iomem range 0xfec00000-0xfec00fff could not be reserved
system 00:0c: iomem range 0xfed13000-0xfed1dfff has been reserved
system 00:0c: iomem range 0xfed20000-0xfed8ffff has been reserved
system 00:0c: iomem range 0xfee00000-0xfee00fff has been reserved
system 00:0c: iomem range 0xffb00000-0xffb7ffff has been reserved
system 00:0c: iomem range 0xfff00000-0xffffffff has been reserved
system 00:0c: iomem range 0xe0000-0xeffff has been reserved
pci 0000:02:04.0: BAR 6: address space collision on of device [0xfdec0000-0xfdedffff]
pci 0000:02:06.0: BAR 6: address space collision on of device [0xfdec0000-0xfdedffff]
pci 0000:02:07.0: BAR 6: address space collision on of device [0xfdec0000-0xfdedffff]
pci 0000:00:1c.0: PCI bridge, secondary bus 0000:01
pci 0000:00:1c.0:   IO window: 0xc000-0xcfff
pci 0000:00:1c.0:   MEM window: 0xfdb00000-0xfdbfffff
pci 0000:00:1c.0:   PREFETCH window: 0x000000fdc00000-0x000000fdcfffff
pci 0000:00:1e.0: PCI bridge, secondary bus 0000:02
pci 0000:00:1e.0:   IO window: 0xd000-0xdfff
pci 0000:00:1e.0:   MEM window: 0xfde00000-0xfdefffff
pci 0000:00:1e.0:   PREFETCH window: 0x000000fdd00000-0x000000fddfffff
pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
pci_bus 0000:01: resource 0 io:  [0xc000-0xcfff]
pci_bus 0000:01: resource 1 mem: [0xfdb00000-0xfdbfffff]
pci_bus 0000:01: resource 2 pref mem [0xfdc00000-0xfdcfffff]
pci_bus 0000:02: resource 0 io:  [0xd000-0xdfff]
pci_bus 0000:02: resource 1 mem: [0xfde00000-0xfdefffff]
pci_bus 0000:02: resource 2 pref mem [0xfdd00000-0xfddfffff]
pci_bus 0000:02: resource 3 io:  [0x00-0xffff]
pci_bus 0000:02: resource 4 mem: [0x000000-0xffffffffffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
NET: Registered protocol family 1
pci 0000:00:02.0: Boot video device
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 11400k freed
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
audit: initializing netlink socket (disabled)
type=2000 audit(1269392610.003:1): initialized
highmem bounce pool size: 64 pages
HugeTLB registered 2 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 1722
SELinux:  Registering netfilter hooks
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pcieport 0000:00:1c.0: irq 24 for MSI/MSI-X
pcieport 0000:00:1c.0: setting latency timer to 64
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
pci-stub: invalid id string ""
vesafb: framebuffer at 0xd0000000, mapped to 0xf7e80000, using 3072k, total 7872k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
fbcon: VESA VGA (fb0) is primary device
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
ACPI: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
ACPI: Power Button [PWRF]
fan PNP0C0B:00: registered as cooling_device0
ACPI: Fan [FAN] (on)
processor LNXCPU:00: registered as cooling_device1
processor LNXCPU:01: registered as cooling_device2
processor LNXCPU:02: registered as cooling_device3
processor LNXCPU:03: registered as cooling_device4
thermal LNXTHERM:01: registered as thermal_zone0
ACPI: Thermal Zone [THRM] (39 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
agpgart-intel 0000:00:00.0: Intel 945G Chipset
agpgart-intel 0000:00:00.0: detected 7932K stolen memory
agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
brd: module loaded
loop: module loaded
input: Macintosh mouse button emulation as /devices/virtual/input/input2
ata_piix 0000:00:1f.2: version 2.13
ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ata_piix 0000:00:1f.2: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xf800 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf808 irq 15
Fixed MDIO Bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: using broken periodic workaround
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 64 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfdfff000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.32.9-70.fc12.i686.PAE ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000fe00
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.32.9-70.fc12.i686.PAE uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
ata1.00: ATA-7: ST3250824AS, 3.AAH, max UDMA/133
ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 0/32)
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000fd00
usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.32.9-70.fc12.i686.PAE uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3250824AS      3.AA PQ: 0 ANSI: 5
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/232 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000fc00
usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.32.9-70.fc12.i686.PAE uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: setting latency timer to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000fb00
usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.32.9-70.fc12.i686.PAE uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.3
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
 sda:
rtc_cmos 00:03: RTC can wake from S4
rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, 242 bytes nvram, hpet irqs
 sda1 sda2 sda3 sda4 <
device-mapper: uevent: version 1.0.3
 sda5 sda6
device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
 sda7 >
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input3
cpuidle: using governor ladder
sd 0:0:0:0: [sda] Attached SCSI disk
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
Using IPI No-Shortcut mode
PM: Resume from disk failed.
registered taskstats version 1
No TPM chip found, activating TPM-bypass!
  Magic number: 2:400:54
rtc_cmos 00:03: setting system clock to 2010-03-24 01:03:31 UTC (1269392611)
Initalizing network drop monitor service
Freeing unused kernel memory: 564k freed
Write protecting the kernel text: 3752k
Write protecting the kernel read-only data: 1776k
dracut: dracut-004-4.fc12
psmouse serio1: ID: 10 00 28
udev: starting version 145
[drm] Initialized drm 1.1.0 20060810
pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:02.0: setting latency timer to 64
[drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input4
dracut: Starting plymouth daemon
device-mapper: multipath: version 1.1.0 loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
dracut: Remounting /dev/disk/by-uuid/4d1a174c-248e-45ee-a8dd-c82f70426900 with -o ro,defaults,noatime,norelatime,nodiratime
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
dracut: Mounted root filesystem /dev/sda2
dracut: Switching root
udev: starting version 145
intel_rng: FWH not detected
i801_smbus 0000:00:1f.3: PCI INT B -> GSI 19 (level, low) -> IRQ 19
iTCO_vendor_support: vendor-support=0
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
r8169 0000:01:00.0: setting latency timer to 64
r8169 0000:01:00.0: irq 25 for MSI/MSI-X
eth0: RTL8168c/8111c at 0xf8640000, 00:30:18:ac:b6:b0, XID 1c4000c0 IRQ 25
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:02:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
r8169 0000:02:04.0: no PCI Express capability
eth1: RTL8169sc/8110sc at 0xf8644000, 00:30:18:af:13:e4, XID 18000000 IRQ 18
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:02:06.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
r8169 0000:02:06.0: no PCI Express capability
eth2: RTL8169sc/8110sc at 0xf8648000, 00:30:18:af:13:e5, XID 18000000 IRQ 19
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:02:07.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
r8169 0000:02:07.0: no PCI Express capability
eth3: RTL8169sc/8110sc at 0xf864c000, 00:30:18:af:13:e6, XID 18000000 IRQ 16
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2, TCOBASE=0x0460)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem sda5
Ending clean XFS mount for filesystem: sda5
Adding 2047992k swap on /dev/sda6.  Priority:-1 extents:1 across:2047992k 
microcode: CPU0 sig=0x106c2, pf=0x8, revision=0x209
platform microcode: firmware: requesting intel-ucode/06-1c-02
microcode: CPU1 sig=0x106c2, pf=0x8, revision=0x209
platform microcode: firmware: requesting intel-ucode/06-1c-02
microcode: CPU2 sig=0x106c2, pf=0x8, revision=0x209
platform microcode: firmware: requesting intel-ucode/06-1c-02
microcode: CPU3 sig=0x106c2, pf=0x8, revision=0x209
platform microcode: firmware: requesting intel-ucode/06-1c-02
Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
microcode: CPU0 updated to revision 0x219, date = 2009-04-10 
microcode: CPU1 updated to revision 0x219, date = 2009-04-10 
microcode: CPU2 updated to revision 0x219, date = 2009-04-10 
microcode: CPU3 updated to revision 0x219, date = 2009-04-10 
Microcode Update Driver: v2.00 removed.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
r8169: eth0: link up
r8169: eth0: link up
r8169: eth3: link up
r8169: eth3: link up
WARNING! Changing of MTU on this NIC May lead to frame reception errors!
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
f71882fg: Found f71862fg chip at 0x290, revision 18
ACPI: I/O resource f71882fg [0x290-0x297] conflicts with ACPI region IP__ [0x295-0x296]
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Netfilter messages via NETLINK v0.30.
ctnetlink v0.93: registering with nfnetlink.
ClusterIP Version 0.8 loaded successfully
xt_time: kernel timezone is -0500
u32 classifier
    Performance counters on
    input device check on 
    Actions configured 
type=1305 audit(1269410653.564:17668): audit_enabled=0 old=1 auid=4294967295 ses=4294967295 subj=kernel res=1
i2c /dev entries driver
f71882fg: Found f71862fg chip at 0x290, revision 18
ACPI: I/O resource f71882fg [0x290-0x297] conflicts with ACPI region IP__ [0x295-0x296]
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
i2c /dev entries driver
f71882fg: Found f71862fg chip at 0x290, revision 18
ACPI: I/O resource f71882fg [0x290-0x297] conflicts with ACPI region IP__ [0x295-0x296]
ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[root@XX ~]# 
------=_20100326171823_74909
Content-Type: text/plain; name="XX_lsmod_output.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="XX_lsmod_output.txt"

[root@XX ~]# lsmod
Module                  Size  Used by
coretemp                4300  0 
act_police              3209  0 
cls_flow                5106  0 
cls_fw                  3069  2 
cls_u32                 4949  1 
sch_htb                10736  1 
sch_hfsc               13393  0 
sch_ingress             1314  0 
sch_sfq                 4176  2 
xt_time                 1585  0 
xt_connlimit            2594  0 
xt_realm                 706  0 
iptable_raw             1686  0 
xt_comment               688  18 
xt_recent               5969  0 
xt_policy               1898  0 
ipt_ULOG                7222  18 
ipt_REDIRECT            1334  0 
ipt_NETMAP              1334  0 
ipt_MASQUERADE          1776  2 
ipt_ECN                 1373  1 
ipt_ecn                 1013  0 
ipt_CLUSTERIP           5163  0 
ipt_ah                   841  0 
ipt_addrtype            1514  4 
nf_nat_tftp              668  0 
nf_nat_snmp_basic       6655  0 
nf_nat_sip              4032  0 
nf_nat_pptp             3582  0 
nf_nat_proto_gre        2124  1 nf_nat_pptp
nf_nat_irc              1316  0 
nf_nat_h323             6900  0 
nf_nat_ftp              2452  0 
nf_nat_amanda            790  0 
ts_kmp                  1531  5 
nf_conntrack_amanda     2016  1 nf_nat_amanda
nf_conntrack_sane       4145  0 
nf_conntrack_tftp       3457  1 nf_nat_tftp
nf_conntrack_sip       13248  1 nf_nat_sip
nf_conntrack_proto_sctp     9251  0 
nf_conntrack_pptp       8936  1 nf_nat_pptp
nf_conntrack_proto_gre     5269  1 nf_conntrack_pptp
nf_conntrack_netlink    12281  0 
nf_conntrack_netbios_ns     1110  0 
nf_conntrack_irc        3949  1 nf_nat_irc
nf_conntrack_h323      51848  1 nf_nat_h323
nf_conntrack_ftp        9435  1 nf_nat_ftp
xt_tcpmss               1089  0 
xt_pkttype               772  0 
xt_physdev              1395  0 
xt_owner                 854  0 
xt_NFQUEUE              1708  0 
xt_NFLOG                 813  0 
nfnetlink_log           6080  1 xt_NFLOG
xt_multiport            1930  4 
xt_MARK                  703  6 
xt_mark                  703  0 
xt_mac                   756  0 
xt_limit                1246  1 
xt_length                904  0 
xt_iprange              1719  0 
xt_helper                995  0 
xt_hashlimit            6776  0 
xt_DSCP                 1593  0 
xt_dscp                 1249  0 
xt_dccp                 1573  0 
xt_CONNMARK             1061  0 
xt_connmark              921  0 
xt_CLASSIFY              711  0 
ipt_LOG                 4231  0 
iptable_nat             4647  1 
nf_nat                 15785  12 ipt_REDIRECT,ipt_NETMAP,ipt_MASQUERADE,nf_nat_tftp,nf_nat_sip,nf_nat_pptp,nf_nat_proto_gre,nf_nat_irc,nf_nat_h323,nf_nat_ftp,nf_nat_amanda,iptable_nat
iptable_mangle          2599  1 
nfnetlink               2711  2 nf_conntrack_netlink,nfnetlink_log
p4_clockmod             3003  2 
ipv6                  223738  16 
xfs                   403533  1 
exportfs                2903  1 xfs
iTCO_wdt                7862  0 
r8169                  29749  0 
iTCO_vendor_support     2023  1 iTCO_wdt
i2c_i801                8337  0 
mii                     3510  1 r8169
dm_multipath           12324  0 
i915                  239486  0 
drm_kms_helper         22251  1 i915
drm                   135451  2 i915,drm_kms_helper
i2c_algo_bit            4073  1 i915
i2c_core               21732  5 i2c_i801,i915,drm_kms_helper,drm,i2c_algo_bit
video                  16522  1 i915
output                  1605  1 video
------=_20100326171823_74909
Content-Type: text/plain; name="XX_sensors-detect_output.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="XX_sensors-detect_output.txt"

[root@XX ~]# sensors-detect
Stopping lm_sensors: [  OK  ]
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): yes
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Fintek F71862FG Super IO Sensors'                    Success!
    (address 0x295, driver `f71882fg')

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no): yes
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): yes
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
Module i2c-dev loaded successfully.

Next adapter: SMBus I801 adapter at 0500 (i2c-0)
Do you want to scan it? (yes/NO/selectively): yes
Client found at address 0x2f
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83791D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Nuvoton W83795G/ADG'...                        No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG/W83667HG/W83677HG'...        No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1029'...                     No
Probing for `ITE IT8712F'...                                No
Probing for `Fintek custom power control IC'...             No
Probing for `Winbond W83791SD'...                           No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `coretemp':
  * Chip `Intel Atom thermal sensor' (confidence: 9)

Driver `f71882fg':
  * ISA bus, address 0x295
    Chip `Fintek F71862FG Super IO Sensors' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): yes
Starting lm_sensors: loading module coretemp f71882fg [  OK  ]
Unloading i2c-dev... OK
------=_20100326171823_74909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_20100326171823_74909--


