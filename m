From: Owl <owl@umail.ru>
Date: Wed, 09 Mar 2011 20:52:43 +0000
Subject: Re: [lm-sensors] New fintek f718xx driver now available, please test
Message-Id: <4D77E89B.80101@umail.ru>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020205040701060809080900"
List-Id: <lm-sensors.vger.kernel.org>
References: <4D77DAB5.6080601@redhat.com>
In-Reply-To: <4D77DAB5.6080601@redhat.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020205040701060809080900
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

09.03.2011 22:53, Hans de Goede wrote:
> To test, drop the attached C-file and Makefile into
> a directory and do:
> make
> sudo insmod f71882fg.ko
>
> Note this assumed that ou have development tools like
> make and gcc, as well as kernel headers for module
> compilation installed.
>
> Once you've done this, you should be able to
> see the sensor readings using the sensors command.
>
> Also please do:
> ls /sys/class/hwmon/*/>  ls1
> ls /sys/class/hwmon/*/device>  ls2
> dmesg>  dmesg

gentoo ~ # insmod /usr/src/f71882fg/f71882fg.ko
gentoo ~ # sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +17.0=B0C  (crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +21.0=B0C  (crit =3D +100.0=B0C)

f71869-isa-0290
Adapter: ISA adapter
in0:         +1.66 V
in1:         +1.04 V
in2:         +1.04 V
in3:         +1.34 V
in4:         +1.02 V
in5:         +1.37 V
in6:         +1.10 V
in7:         +1.65 V
in8:         +1.62 V
fan1:       1758 RPM
fan2:          0 RPM  ALARM
fan3:       2002 RPM
temp1:       +43.0=B0C  (high =3D +85.0=B0C, hyst =3D +81.0=B0C)
                       (crit =3D +65.0=B0C, hyst =3D +61.0=B0C)  sensor =3D=
 transistor
temp2:       +52.0=B0C  (high =3D +85.0=B0C, hyst =3D +81.0=B0C)
                       (crit =3D +100.0=B0C, hyst =3D +96.0=B0C)  sensor =
=3D=20
transistor

seems it work ;)

--------------020205040701060809080900
Content-Type: text/plain;
 name="ls1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ls1"

/sys/class/hwmon/hwmon0/:
device
power
subsystem
uevent

/sys/class/hwmon/hwmon1/:
device
power
subsystem
uevent

/sys/class/hwmon/hwmon2/:
device
power
subsystem
uevent

--------------020205040701060809080900
Content-Type: text/plain;
 name="ls2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ls2"

/sys/class/hwmon/hwmon0/device:
driver
hwmon
modalias
name
power
subsystem
temp1_crit
temp1_crit_alarm
temp1_input
temp1_label
uevent

/sys/class/hwmon/hwmon1/device:
driver
hwmon
modalias
name
power
subsystem
temp1_crit
temp1_crit_alarm
temp1_input
temp1_label
uevent

/sys/class/hwmon/hwmon2/device:
driver
fan1_alarm
fan1_beep
fan1_full_speed
fan1_input
fan2_alarm
fan2_beep
fan2_full_speed
fan2_input
fan3_alarm
fan3_beep
fan3_full_speed
fan3_input
hwmon
in0_input
in1_input
in2_input
in3_input
in4_input
in5_input
in6_input
in7_input
in8_input
modalias
name
power
pwm1
pwm1_auto_channels_temp
pwm1_auto_point1_pwm
pwm1_auto_point1_temp
pwm1_auto_point1_temp_hyst
pwm1_auto_point2_pwm
pwm1_auto_point2_temp
pwm1_auto_point2_temp_hyst
pwm1_auto_point3_pwm
pwm1_enable
pwm1_interpolate
pwm2
pwm2_auto_channels_temp
pwm2_auto_point1_pwm
pwm2_auto_point1_temp
pwm2_auto_point1_temp_hyst
pwm2_auto_point2_pwm
pwm2_auto_point2_temp
pwm2_auto_point2_temp_hyst
pwm2_auto_point3_pwm
pwm2_enable
pwm2_interpolate
pwm3
pwm3_auto_channels_temp
pwm3_auto_point1_pwm
pwm3_auto_point1_temp
pwm3_auto_point1_temp_hyst
pwm3_auto_point2_pwm
pwm3_auto_point2_temp
pwm3_auto_point2_temp_hyst
pwm3_auto_point3_pwm
pwm3_enable
pwm3_interpolate
subsystem
temp1_alarm
temp1_crit
temp1_crit_alarm
temp1_crit_beep
temp1_crit_hyst
temp1_fault
temp1_input
temp1_max
temp1_max_beep
temp1_max_hyst
temp1_type
temp2_alarm
temp2_crit
temp2_crit_alarm
temp2_crit_beep
temp2_crit_hyst
temp2_fault
temp2_input
temp2_max
temp2_max_beep
temp2_max_hyst
temp2_type
uevent

--------------020205040701060809080900
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg"

Linux version 2.6.36-gentoo-r8 (root@gentoo.owlsnest.ru) (gcc version 4.5.2 (Gentoo 4.5.2 p1.0, pie-0.4.5) ) #1 SMP Mon Feb 21 14:01:46 MSK 2011
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007f590000 (usable)
 BIOS-e820: 000000007f590000 - 000000007f59e000 (ACPI data)
 BIOS-e820: 000000007f59e000 - 000000007f5d0000 (ACPI NVS)
 BIOS-e820: 000000007f5d0000 - 000000007f5e0000 (reserved)
 BIOS-e820: 000000007f5e8000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
NX (Execute Disable) protection: active
DMI present.
AMI BIOS detected: BIOS may corrupt low RAM, working around it.
e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
last_pfn = 0x7f590 max_arch_pfn = 0x1000000
MTRR default type: uncachable
MTRR fixed ranges enabled:
  00000-9FFFF write-back
  A0000-BFFFF uncachable
  C0000-CFFFF write-protect
  D0000-DFFFF uncachable
  E0000-EFFFF write-through
  F0000-FFFFF write-protect
MTRR variable ranges enabled:
  0 base 000000000 mask 080000000 write-back
  1 base 07F600000 mask 0FFF00000 write-through
  2 base 07F700000 mask 0FFF00000 uncachable
  3 base 07F800000 mask 0FF800000 uncachable
  4 disabled
  5 disabled
  6 disabled
x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
initial memory mapped : 0 - 00a00000
found SMP MP-table at [c00ff780] ff780
init_memory_mapping: 0000000000000000-0000000037bfe000
 0000000000 - 0000200000 page 4k
 0000200000 - 0037a00000 page 2M
 0037a00000 - 0037bfe000 page 4k
kernel direct mapping tables up to 37bfe000 @ 11000-16000
RAMDISK: 37eed000 - 37ff0000
Allocated new RAMDISK: 005cf000 - 006d1e39
Move RAMDISK from 0000000037eed000 - 0000000037fefe38 to 005cf000 - 006d1e38
ACPI: RSDP 000f9fe0 00024 (v02 ACPIAM)
ACPI: XSDT 7f590100 0005C (v01 122710 XSDT1157 20101227 MSFT 00000097)
ACPI: FACP 7f590290 000F4 (v04 122710 FACP1157 20101227 MSFT 00000097)
ACPI: DSDT 7f590440 06DB0 (v02  BC9CA BC9CA004 00000004 INTL 20051117)
ACPI: FACS 7f59e000 00040
ACPI: APIC 7f590390 0006C (v02 122710 APIC1157 20101227 MSFT 00000097)
ACPI: MCFG 7f590400 0003C (v01 122710 OEMMCFG  20101227 MSFT 00000097)
ACPI: OEMB 7f59e040 00082 (v01 122710 OEMB1157 20101227 MSFT 00000097)
ACPI: HPET 7f59a440 00038 (v01 122710 OEMHPET  20101227 MSFT 00000097)
ACPI: GSCI 7f59e0d0 02024 (v01 122710 GMCHSCI  20101227 MSFT 00000097)
ACPI: SSDT 7f5a0d00 00999 (v01  PmRef   CpuPm4 00003000 INTL 20051117)
ACPI: Local APIC address 0xfee00000
1145MB HIGHMEM available.
891MB LOWMEM available.
  mapped low ram: 0 - 37bfe000
  low ram: 0 - 37bfe000
Zone PFN ranges:
  DMA      0x00000010 -> 0x00001000
  Normal   0x00001000 -> 0x00037bfe
  HighMem  0x00037bfe -> 0x0007f590
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00000010 -> 0x0000009f
    0: 0x00000100 -> 0x0007f590
On node 0 totalpages: 521503
free_area_init_node: node 0, pgdat c0501600, node_mem_map c1001200
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 3951 pages, LIFO batch:0
  Normal zone: 1752 pages used for memmap
  Normal zone: 222502 pages, LIFO batch:31
  HighMem zone: 2292 pages used for memmap
  HighMem zone: 290974 pages, LIFO batch:31
Using APIC driver default
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0xffffffff base: 0xfed00000
SMP: Allowing 4 CPUs, 0 hotplug CPUs
nr_irqs_gsi: 40
early_res array is doubled to 64 at [12000 - 127ff]
Allocating PCI resources starting at 80000000 (gap: 80000000:7ee00000)
setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
PERCPU: Embedded 15 pages/cpu @c2000000 s38016 r0 d23424 u524288
pcpu-alloc: s38016 r0 d23424 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 517427
Kernel command line: root=/dev/ram0 real_root=LABEL=ROOT vga=0x31b console=ttyS0 console=tty0 acpi_osi=Linux
ACPI: Added _OSI(Linux)
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Subtract (48 early reservations)
  #1 [0000001000 - 0000002000]   EX TRAMPOLINE
  #2 [0000100000 - 00005c8f24]   TEXT DATA BSS
  #3 [00005c9000 - 00005ce1fb]             BRK
  #4 [00000ff790 - 0000100000]   BIOS reserved
  #5 [00000ff780 - 00000ff790]    MP-table mpf
  #6 [000009f400 - 00000fdd60]   BIOS reserved
  #7 [00000fdedc - 00000ff780]   BIOS reserved
  #8 [00000fdd60 - 00000fdedc]    MP-table mpc
  #9 [0000010000 - 0000011000]      TRAMPOLINE
  #10 [0000011000 - 0000012000]         PGTABLE
  #11 [00005cf000 - 00006d2000]     NEW RAMDISK
  #12 [0001000000 - 0001001000]         BOOTMEM
  #13 [0001001000 - 0001ff1000]         BOOTMEM
  #14 [0001ff1000 - 0001ff1004]         BOOTMEM
  #15 [0001ff1040 - 0001ff1100]         BOOTMEM
  #16 [0001ff1100 - 0001ff11a8]         BOOTMEM
  #17 [0001ff11c0 - 0001ff41c0]         BOOTMEM
  #18 [0001ff41c0 - 0001ff4298]         BOOTMEM
  #19 [0001ff42c0 - 0001ffa2c0]         BOOTMEM
  #20 [0001ffa2c0 - 0001ffa2ed]         BOOTMEM
  #21 [0001ffa300 - 0001ffa32f]         BOOTMEM
  #22 [0001ffa340 - 0001ffa4cc]         BOOTMEM
  #23 [0001ffa500 - 0001ffa540]         BOOTMEM
  #24 [0001ffa540 - 0001ffa580]         BOOTMEM
  #25 [0001ffa580 - 0001ffa5c0]         BOOTMEM
  #26 [0001ffa5c0 - 0001ffa600]         BOOTMEM
  #27 [0001ffa600 - 0001ffa640]         BOOTMEM
  #28 [0001ffa640 - 0001ffa680]         BOOTMEM
  #29 [0001ffa680 - 0001ffa6c0]         BOOTMEM
  #30 [0001ffa6c0 - 0001ffa700]         BOOTMEM
  #31 [0001ffa700 - 0001ffa740]         BOOTMEM
  #32 [0001ffa740 - 0001ffa780]         BOOTMEM
  #33 [0001ffa780 - 0001ffa7d8]         BOOTMEM
  #34 [0001ffa800 - 0001ffa858]         BOOTMEM
  #35 [0002000000 - 000200f000]         BOOTMEM
  #36 [0002080000 - 000208f000]         BOOTMEM
  #37 [0002100000 - 000210f000]         BOOTMEM
  #38 [0002180000 - 000218f000]         BOOTMEM
  #39 [0001ffc880 - 0001ffc884]         BOOTMEM
  #40 [0001ffc8c0 - 0001ffc8c4]         BOOTMEM
  #41 [0001ffc900 - 0001ffc910]         BOOTMEM
  #42 [0001ffc940 - 0001ffc950]         BOOTMEM
  #43 [0001ffc980 - 0001ffca18]         BOOTMEM
  #44 [0001ffca40 - 0001ffca78]         BOOTMEM
  #45 [000200f000 - 0002013000]         BOOTMEM
  #46 [000218f000 - 000220f000]         BOOTMEM
  #47 [0002013000 - 0002053000]         BOOTMEM
Initializing HighMem for node 0 (00037bfe:0007f590)
Memory: 2062652k/2086464k available (2753k kernel code, 23360k reserved, 1374k data, 392k init, 1173064k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff67000 - 0xfffff000   ( 608 kB)
    pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0xf83fe000 - 0xffbfe000   ( 120 MB)
    lowmem  : 0xc0000000 - 0xf7bfe000   ( 891 MB)
      .init : 0xc0509000 - 0xc056b000   ( 392 kB)
      .data : 0xc03b0771 - 0xc05081a8   (1374 kB)
      .text : 0xc0100000 - 0xc03b0771   (2753 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
Hierarchical RCU implementation.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:384
CPU 0 irqstacks, hard=c2000000 soft=c2001000
Extended CMOS year: 2000
Console: colour dummy device 80x25
console [tty0] enabled
console [ttyS0] enabled
hpet clockevent registered
Fast TSC calibration using PIT
Detected 1500.268 MHz processor.
Calibrating delay loop (skipped), value calculated using timer frequency.. 3000.53 BogoMIPS (lpj=15002680)
pid_max: default: 32768 minimum: 301
Security Framework initialized
Mount-cache hash table entries: 512
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
mce: CPU supports 5 MCE banks
CPU0: Thermal monitoring enabled (TM2)
using mwait in idle threads.
Performance Events: PEBS fmt0+, Atom events, Intel PMU driver.
... version:                3
... bit width:              40
... generic registers:      2
... value mask:             000000ffffffffff
... max period:             000000007fffffff
... fixed-purpose events:   3
... event mask:             0000000700000003
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20100702
Enabling APIC mode:  Flat.  Using 1 I/O APICs
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
CPU0: Intel(R) Atom(TM) CPU N550   @ 1.50GHz stepping 0a
CPU 1 irqstacks, hard=c2080000 soft=c2081000
Booting Node   0, Processors  #1
Initializing CPU#1
TSC synchronization [CPU#0 -> CPU#1]:
Measured 45 cycles TSC warp between CPUs, turning off TSC clock.
Marking TSC unstable due to check_tsc_sync_source failed
CPU 2 irqstacks, hard=c2100000 soft=c2101000
 #2
Initializing CPU#2
CPU 3 irqstacks, hard=c2180000 soft=c2181000
 #3 Ok.
Initializing CPU#3
Brought up 4 CPUs
Total of 4 processors activated (12000.83 BogoMIPS).
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: not using MMCONFIG
PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=5
PCI: Using configuration type 1 for base access
bio: create slab <bio-0> at 0
ACPI: EC: Look up EC in DSDT
ACPI: Executed 1 blocks of module-level executable AML code
ACPI: SSDT 7f5a03b0 001FB (v01  PmRef  Cpu0Ist 00003000 INTL 20051117)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT (null) 001FB (v01  PmRef  Cpu0Ist 00003000 INTL 20051117)
ACPI: SSDT 7f5a0760 00594 (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT (null) 00594 (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
ACPI: SSDT 7f5a02a0 0010F (v01  PmRef  Cpu1Ist 00003000 INTL 20051117)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT (null) 0010F (v01  PmRef  Cpu1Ist 00003000 INTL 20051117)
ACPI: SSDT 7f5a06d0 00085 (v01  PmRef  Cpu1Cst 00003000 INTL 20051117)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT (null) 00085 (v01  PmRef  Cpu1Cst 00003000 INTL 20051117)
ACPI: SSDT 7f5a01d0 000C8 (v01  PmRef  Cpu2Ist 00003000 INTL 20051117)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT (null) 000C8 (v01  PmRef  Cpu2Ist 00003000 INTL 20051117)
ACPI: SSDT 7f5a0640 00085 (v01  PmRef  Cpu2Cst 00003000 INTL 20051117)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT (null) 00085 (v01  PmRef  Cpu2Cst 00003000 INTL 20051117)
ACPI: SSDT 7f5a0100 000C8 (v01  PmRef  Cpu3Ist 00003000 INTL 20051117)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT (null) 000C8 (v01  PmRef  Cpu3Ist 00003000 INTL 20051117)
ACPI: SSDT 7f5a05b0 00085 (v01  PmRef  Cpu3Cst 00003000 INTL 20051117)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT (null) 00085 (v01  PmRef  Cpu3Cst 00003000 INTL 20051117)
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
PCI: Using MMCONFIG for extended config space
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
pci_root PNP0A08:00: host bridge window [mem 0x000d0000-0x000dffff]
pci_root PNP0A08:00: host bridge window [mem 0x7f700000-0xdfffffff]
pci_root PNP0A08:00: host bridge window [mem 0xf0000000-0xfed8ffff]
pci_root PNP0A08:00: host bridge window [mem 0x400000000-0xfffffffff]
pci 0000:00:02.0: reg 10: [mem 0xfea00000-0xfea7ffff]
pci 0000:00:02.0: reg 14: [io  0xbc00-0xbc07]
pci 0000:00:02.0: reg 18: [mem 0xd0000000-0xdfffffff pref]
pci 0000:00:02.0: reg 1c: [mem 0xfe800000-0xfe8fffff]
pci 0000:00:02.1: reg 10: [mem 0xfe700000-0xfe77ffff]
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.0: PME# disabled
pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.1: PME# disabled
pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.2: PME# disabled
pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
pci 0000:00:1c.3: PME# disabled
pci 0000:00:1d.0: reg 20: [io  0xb880-0xb89f]
pci 0000:00:1d.1: reg 20: [io  0xb800-0xb81f]
pci 0000:00:1d.2: reg 20: [io  0xb480-0xb49f]
pci 0000:00:1d.3: reg 20: [io  0xb400-0xb41f]
pci 0000:00:1d.7: reg 10: [mem 0xfeaf7c00-0xfeaf7fff]
pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
pci 0000:00:1d.7: PME# disabled
pci 0000:00:1f.0: [Firmware Bug]: TigerPoint LPC.BM_STS cleared
pci 0000:00:1f.2: reg 10: [io  0xa800-0xa807]
pci 0000:00:1f.2: reg 14: [io  0xb080-0xb083]
pci 0000:00:1f.2: reg 18: [io  0xb000-0xb007]
pci 0000:00:1f.2: reg 1c: [io  0xac00-0xac03]
pci 0000:00:1f.2: reg 20: [io  0xa880-0xa89f]
pci 0000:00:1f.2: reg 24: [mem 0xfeaf7800-0xfeaf7bff]
pci 0000:00:1f.2: PME# supported from D3hot
pci 0000:00:1f.2: PME# disabled
pci 0000:00:1f.3: reg 20: [io  0x0400-0x041f]
pci 0000:01:00.0: reg 10: [mem 0xfe9f0000-0xfe9fffff 64bit]
pci 0000:01:00.0: supports D1
pci 0000:01:00.0: PME# supported from D0 D1 D3hot D3cold
pci 0000:01:00.0: PME# disabled
pci 0000:00:1c.0: PCI bridge to [bus 01-01]
pci 0000:00:1c.0:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:1c.0:   bridge window [mem 0xfe900000-0xfe9fffff]
pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:02:00.0: reg 10: [io  0xc800-0xc8ff]
pci 0000:02:00.0: reg 18: [mem 0xfdefb000-0xfdefbfff 64bit pref]
pci 0000:02:00.0: reg 20: [mem 0xfdefc000-0xfdefffff 64bit pref]
pci 0000:02:00.0: supports D1 D2
pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:02:00.0: PME# disabled
pci 0000:00:1c.1: PCI bridge to [bus 02-02]
pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.1:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:00:1c.1:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
pci 0000:03:00.0: reg 10: [io  0xd800-0xd8ff]
pci 0000:03:00.0: reg 18: [mem 0xfdffb000-0xfdffbfff 64bit pref]
pci 0000:03:00.0: reg 20: [mem 0xfdffc000-0xfdffffff 64bit pref]
pci 0000:03:00.0: supports D1 D2
pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:03:00.0: PME# disabled
pci 0000:00:1c.2: PCI bridge to [bus 03-03]
pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.2:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:00:1c.2:   bridge window [mem 0xfdf00000-0xfdffffff 64bit pref]
pci 0000:00:1c.3: PCI bridge to [bus 04-04]
pci 0000:00:1c.3:   bridge window [io  0xf000-0x0000] (disabled)
pci 0000:00:1c.3:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
pci 0000:00:1c.3:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:05:04.0: reg 10: [io  0xe800-0xe8ff]
pci 0000:05:04.0: reg 14: [mem 0xfebdfc00-0xfebdfcff]
pci 0000:05:04.0: reg 30: [mem 0xfebe0000-0xfebfffff pref]
pci 0000:05:04.0: supports D1 D2
pci 0000:05:04.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:05:04.0: PME# disabled
pci 0000:05:06.0: reg 10: [io  0xe400-0xe4ff]
pci 0000:05:06.0: reg 14: [mem 0xfebdf800-0xfebdf8ff]
pci 0000:05:06.0: reg 30: [mem 0xfeba0000-0xfebbffff pref]
pci 0000:05:06.0: supports D1 D2
pci 0000:05:06.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:05:06.0: PME# disabled
pci 0000:05:07.0: reg 10: [io  0xe000-0xe0ff]
pci 0000:05:07.0: reg 14: [mem 0xfebdf400-0xfebdf4ff]
pci 0000:05:07.0: reg 30: [mem 0xfeb80000-0xfeb9ffff pref]
pci 0000:05:07.0: supports D1 D2
pci 0000:05:07.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:05:07.0: PME# disabled
pci 0000:00:1e.0: PCI bridge to [bus 05-05] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1e.0:   bridge window [mem 0xfeb00000-0xfebfffff]
pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x7f700000-0xdfffffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfed8ffff] (subtractive decode)
pci 0000:00:1e.0:   bridge window [mem 0x400000000-0xfffffffff] (subtractive decode)
pci_bus 0000:00: on NUMA node 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 *14 15)
vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
Expanded resource reserved due to conflict with PCI Bus 0000:00
reserve RAM buffer: 000000000009f400 - 000000000009ffff 
reserve RAM buffer: 000000007f590000 - 000000007fffffff 
HPET: 3 timers in total, 0 timers will be used for per-cpu timer
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 comparators, 64-bit 14.318180 MHz counter
Switching to clocksource hpet
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp 00:06: IRQ 4 override to edge, high
pnp: PnP ACPI: found 16 devices
ACPI: ACPI bus type pnp unregistered
system 00:01: [mem 0xfed14000-0xfed19fff] has been reserved
system 00:01: [mem 0xfed90000-0xfed93fff] has been reserved
system 00:08: [io  0x04d0-0x04d1] has been reserved
system 00:08: [io  0x0800-0x087f] has been reserved
system 00:08: [io  0x0480-0x04bf] has been reserved
system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reserved
system 00:08: [mem 0xfed20000-0xfed8ffff] has been reserved
system 00:0b: [mem 0xffc00000-0xffefffff] has been reserved
system 00:0c: [mem 0xfec00000-0xfec00fff] could not be reserved
system 00:0c: [mem 0xfee00000-0xfee00fff] has been reserved
system 00:0d: [io  0x0290-0x0291] has been reserved
system 00:0d: [io  0x0ae0-0x0aef] has been reserved
system 00:0e: [mem 0xe0000000-0xefffffff] has been reserved
system 00:0f: [mem 0x00000000-0x0009ffff] could not be reserved
system 00:0f: [mem 0x000c0000-0x000cffff] could not be reserved
system 00:0f: [mem 0x000e0000-0x000fffff] could not be reserved
system 00:0f: [mem 0x00100000-0x7f6fffff] could not be reserved
system 00:0f: [mem 0xfed90000-0xffffffff] could not be reserved
pci 0000:00:1c.0: BAR 9: assigned [mem 0x7f700000-0x7f8fffff 64bit pref]
pci 0000:00:1c.1: BAR 8: assigned [mem 0x7f900000-0x7fcfffff]
pci 0000:00:1c.2: BAR 8: assigned [mem 0x7fd00000-0x800fffff]
pci 0000:00:1c.3: BAR 8: assigned [mem 0x80100000-0x802fffff]
pci 0000:00:1c.3: BAR 9: assigned [mem 0x80300000-0x804fffff 64bit pref]
pci 0000:00:1c.0: BAR 7: assigned [io  0x1000-0x1fff]
pci 0000:00:1c.3: BAR 7: assigned [io  0x2000-0x2fff]
pci 0000:00:1c.0: PCI bridge to [bus 01-01]
pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
pci 0000:00:1c.0:   bridge window [mem 0xfe900000-0xfe9fffff]
pci 0000:00:1c.0:   bridge window [mem 0x7f700000-0x7f8fffff 64bit pref]
pci 0000:00:1c.1: PCI bridge to [bus 02-02]
pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
pci 0000:00:1c.1:   bridge window [mem 0x7f900000-0x7fcfffff]
pci 0000:00:1c.1:   bridge window [mem 0xfde00000-0xfdefffff 64bit pref]
pci 0000:00:1c.2: PCI bridge to [bus 03-03]
pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
pci 0000:00:1c.2:   bridge window [mem 0x7fd00000-0x800fffff]
pci 0000:00:1c.2:   bridge window [mem 0xfdf00000-0xfdffffff 64bit pref]
pci 0000:00:1c.3: PCI bridge to [bus 04-04]
pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
pci 0000:00:1c.3:   bridge window [mem 0x80100000-0x802fffff]
pci 0000:00:1c.3:   bridge window [mem 0x80300000-0x804fffff 64bit pref]
pci 0000:00:1e.0: PCI bridge to [bus 05-05]
pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
pci 0000:00:1e.0:   bridge window [mem 0xfeb00000-0xfebfffff]
pci 0000:00:1e.0:   bridge window [mem pref disabled]
pci 0000:00:1c.0: enabling device (0106 -> 0107)
pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
pci 0000:00:1c.0: setting latency timer to 64
pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
pci 0000:00:1c.1: setting latency timer to 64
pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
pci 0000:00:1c.2: setting latency timer to 64
pci 0000:00:1c.3: enabling device (0104 -> 0107)
pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
pci 0000:00:1c.3: setting latency timer to 64
pci 0000:00:1e.0: setting latency timer to 64
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
pci_bus 0000:00: resource 8 [mem 0x7f700000-0xdfffffff]
pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff]
pci_bus 0000:00: resource 10 [mem 0x400000000-0xfffffffff]
pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
pci_bus 0000:01: resource 1 [mem 0xfe900000-0xfe9fffff]
pci_bus 0000:01: resource 2 [mem 0x7f700000-0x7f8fffff 64bit pref]
pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
pci_bus 0000:02: resource 1 [mem 0x7f900000-0x7fcfffff]
pci_bus 0000:02: resource 2 [mem 0xfde00000-0xfdefffff 64bit pref]
pci_bus 0000:03: resource 0 [io  0xd000-0xdfff]
pci_bus 0000:03: resource 1 [mem 0x7fd00000-0x800fffff]
pci_bus 0000:03: resource 2 [mem 0xfdf00000-0xfdffffff 64bit pref]
pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
pci_bus 0000:04: resource 1 [mem 0x80100000-0x802fffff]
pci_bus 0000:04: resource 2 [mem 0x80300000-0x804fffff 64bit pref]
pci_bus 0000:05: resource 0 [io  0xe000-0xefff]
pci_bus 0000:05: resource 1 [mem 0xfeb00000-0xfebfffff]
pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
pci_bus 0000:05: resource 7 [mem 0x000d0000-0x000dffff]
pci_bus 0000:05: resource 8 [mem 0x7f700000-0xdfffffff]
pci_bus 0000:05: resource 9 [mem 0xf0000000-0xfed8ffff]
pci_bus 0000:05: resource 10 [mem 0x400000000-0xfffffffff]
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
UDP hash table entries: 512 (order: 2, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
NET: Registered protocol family 1
pci 0000:00:02.0: Boot video device
PCI: CLS 32 bytes, default 64
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 1036k freed
highmem bounce pool size: 64 pages
HugeTLB registered 2 MB page size, pre-allocated 0 pages
msgmni has been set to 1739
io scheduler noop registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xd0000000, mapped to 0xf8480000, using 8128k, total 8128k
vesafb: mode is 1280x1024x32, linelength=5120, pages=0
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
brd: module loaded
loop: module loaded
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
rtc_cmos 00:03: RTC can wake from S4
rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
cpuidle: using governor ladder
TCP cubic registered
NET: Registered protocol family 17
Using IPI Shortcut mode
rtc_cmos 00:03: setting system clock to 2011-03-09 23:44:11 UTC (1299714251)
Freeing unused kernel memory: 392k freed
ahci 0000:00:1f.2: version 3.0
ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: irq 40 for MSI/MSI-X
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
ahci 0000:00:1f.2: setting latency timer to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 40
ata2: SATA max UDMA/133 abar m1024@0xfeaf7800 port 0xfeaf7980 irq 40
ata3: DUMMY
ata4: DUMMY
ata2: SATA link down (SStatus 0 SControl 300)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-8: WDC WD6400AAKS-22A7B0, 01.03B01, max UDMA/133
ata1.00: 1250263728 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      WDC WD6400AAKS-2 01.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 1250263728 512-byte logical blocks: (640 GB/596 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:02:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
r8169 0000:02:00.0: setting latency timer to 64
r8169 0000:02:00.0: (unregistered net_device): unknown MAC, using family default
r8169 0000:02:00.0: irq 41 for MSI/MSI-X
r8169 0000:02:00.0: eth0: RTL8168b/8111b at 0xf8c98000, 00:30:18:a4:da:26, XID 0c200000 IRQ 41
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:03:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
r8169 0000:03:00.0: setting latency timer to 64
r8169 0000:03:00.0: (unregistered net_device): unknown MAC, using family default
r8169 0000:03:00.0: irq 42 for MSI/MSI-X
r8169 0000:03:00.0: eth1: RTL8168b/8111b at 0xf8c9c000, 00:30:18:a4:da:27, XID 0c200000 IRQ 42
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:05:04.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
r8169 0000:05:04.0: (unregistered net_device): no PCI Express capability
r8169 0000:05:04.0: (unregistered net_device): unknown MAC, using family default
r8169 0000:05:04.0: eth2: RTL8169 at 0xf8ca0c00, 00:30:18:a9:6e:48, XID 18000000 IRQ 18
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:05:06.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
r8169 0000:05:06.0: (unregistered net_device): no PCI Express capability
r8169 0000:05:06.0: (unregistered net_device): unknown MAC, using family default
r8169 0000:05:06.0: eth3: RTL8169 at 0xf8ca4800, 00:30:18:a9:6e:49, XID 18000000 IRQ 19
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:05:07.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
r8169 0000:05:07.0: (unregistered net_device): no PCI Express capability
r8169 0000:05:07.0: (unregistered net_device): unknown MAC, using family default
r8169 0000:05:07.0: eth4: RTL8169 at 0xf8ca8400, 00:30:18:a9:6e:4a, XID 18000000 IRQ 16
EXT3-fs: barriers not enabled
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda3): mounted filesystem with writeback data mode
udev[1401]: starting version 164
Linux agpgart interface v0.103
agpgart-intel 0000:00:00.0: Intel GMA3150 Chipset
agpgart-intel 0000:00:00.0: detected 7676K stolen memory
agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
sd 0:0:0:0: Attached scsi generic sg0 type 0
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
ACPI: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
ACPI: Power Button [PWRF]
ACPI: acpi_idle registered with cpuidle
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i801_smbus 0000:00:1f.3: PCI INT B -> GSI 19 (level, low) -> IRQ 19
cfg80211: Calling CRDA to update world regulatory domain
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: setting latency timer to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: using broken periodic workaround
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfeaf7c00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
uhci_hcd 0000:00:1d.0: setting latency timer to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000b880
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: setting latency timer to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000b800
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: setting latency timer to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000b480
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: setting latency timer to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000b400
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
cfg80211: World regulatory domain updated:
    (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
    (2402000 KHz - 2472000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
    (2457000 KHz - 2482000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
    (2474000 KHz - 2494000 KHz @ 20000 KHz), (300 mBi, 2000 mBm)
    (5170000 KHz - 5250000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
    (5735000 KHz - 5835000 KHz @ 40000 KHz), (300 mBi, 2000 mBm)
ath9k 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ath9k 0000:01:00.0: setting latency timer to 64
ath: EEPROM regdomain: 0x60
ath: EEPROM indicates we should expect a direct regpair map
ath: Country alpha2 being used: 00
ath: Regpair used: 0x60
usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x03F0 pid 0x7A04
usbcore: registered new interface driver usblp
phy0: Selected rate control algorithm 'ath9k_rate_control'
Registered led device: ath9k-phy0::radio
Registered led device: ath9k-phy0::assoc
Registered led device: ath9k-phy0::tx
Registered led device: ath9k-phy0::rx
phy0: Atheros AR9285 Rev:2 mem=0xf9320000, irq=16
usb 2-2: new full speed USB device using uhci_hcd and address 3
usbcore: registered new interface driver usbserial
USB Serial support registered for generic
usb 3-1: new full speed USB device using uhci_hcd and address 2
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial Driver core
Bluetooth: Core ver 2.15
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
USB Serial support registered for pl2303
pl2303 2-2:1.0: pl2303 converter detected
usb 2-2: pl2303 converter now attached to ttyUSB0
usbcore: registered new interface driver pl2303
pl2303: Prolific PL2303 USB to serial adaptor driver
Bluetooth: Generic Bluetooth USB driver ver 0.6
usbcore: registered new interface driver btusb
EXT3-fs (sda3): using internal journal
EXT3-fs: barriers not enabled
kjournald starting.  Commit interval 5 seconds
EXT3-fs (sda1): using internal journal
EXT3-fs (sda1): mounted filesystem with writeback data mode
ip_tables: (C) 2000-2006 Netfilter Core Team
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
device eth1 entered promiscuous mode
r8169 0000:03:00.0: eth1: link up
r8169 0000:03:00.0: eth1: link up
device eth2 entered promiscuous mode
r8169 0000:05:04.0: eth2: link down
device eth3 entered promiscuous mode
r8169 0000:05:06.0: eth3: link down
device eth4 entered promiscuous mode
r8169 0000:05:07.0: eth4: link down
device tap0 entered promiscuous mode
br0: port 1(eth1) entering forwarding state
br0: port 1(eth1) entering forwarding state
r8169 0000:02:00.0: eth0: link up
r8169 0000:02:00.0: eth0: link up
device wlan0 entered promiscuous mode
br0: port 6(wlan0) entering forwarding state
br0: port 6(wlan0) entering forwarding state
cfg80211: Calling CRDA for country: RU
cfg80211: Regulatory domain changed to country: RU
    (start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
    (2402000 KHz - 2482000 KHz @ 40000 KHz), (N/A, 2000 mBm)
coretemp coretemp.0: Unable to read TjMax from CPU.
coretemp coretemp.0: Using relative temperature scale!
coretemp coretemp.1: Unable to read TjMax from CPU.
coretemp coretemp.1: Using relative temperature scale!
CE: hpet increased min_delta_ns to 7500 nsec
CE: hpet increased min_delta_ns to 11250 nsec
f71882fg: Found f71869 chip at 0x290, revision 17
f71882fg f71882fg.656: Fan: 1 is in duty-cycle mode
f71882fg f71882fg.656: Fan: 2 is in duty-cycle mode
f71882fg f71882fg.656: Fan: 3 is in duty-cycle mode

--------------020205040701060809080900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020205040701060809080900--
