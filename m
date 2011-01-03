From: Joris Creyghton <jorisctn@gmail.com>
Date: Mon, 03 Jan 2011 11:07:47 +0000
Subject: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <1294052867.1860.36.camel@Asus5>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-LkTDHN8zF1doh5qupEd5"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--=-LkTDHN8zF1doh5qupEd5
Content-Type: multipart/alternative; boundary="=-jbYIa5y9SRLSvsdN18+4"


--=-jbYIa5y9SRLSvsdN18+4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear reader,

Problem:
The sensors command reports 0C for the MCH temp., while the BIOS gives a
reasonable value of about 40C.

Output of sensors command:


        joris@Asus5:~$ sensors
        atk0110-acpi-0
        Adapter: ACPI interface
        Vcore Voltage:      +0.93 V  (min =3D  +0.80 V, max =3D  +1.60 V)
         +3.3 Voltage:      +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
         +5 Voltage:        +5.12 V  (min =3D  +4.50 V, max =3D  +5.50 V)
         +12 Voltage:      +12.25 V  (min =3D +10.20 V, max =3D +13.80 V)
        CPU FAN Speed:      958 RPM  (min =3D  600 RPM)
        CHASSIS1 FAN Speed: 669 RPM  (min =3D  600 RPM)
        CHASSIS2 FAN Speed: 496 RPM  (min =3D  600 RPM)
        CHASSIS3 FAN Speed:   0 RPM  (min =3D  600 RPM)
        POWER FAN Speed:    774 RPM  (min =3D    0 RPM)
        CPU Temperature:    +32.5=C2=B0C  (high =3D +60.0=C2=B0C, crit =3D =
+75.0=C2=B0C) =20
        MB Temperature:     +31.0=C2=B0C  (high =3D +45.0=C2=B0C, crit =3D =
+75.0=C2=B0C) =20
        MCH Temperature:     +0.0=C2=B0C  (high =3D +60.0=C2=B0C, crit =3D =
+95.0=C2=B0C) =20
       =20

Output of dmesg, sensors-detect and lsmod atttached as files.

I have added the suggested chipdrivers coretemp and w83627ehf
to /etc/modules but that didn't solve the problem; removed them again.

Hardware:
MB: Asus Sabertooth X58
CPU: Intel i7 950
Chipset: Intel X58 / ICH 10R

Software:
OS: Ubuntu 10.10 64 bit desktop
Kernel: 2.6.35-23
Sensors: version 3.1.2 with libsensors version 3.1.2
BIOS: AMI version 0603, build date 10/29/10



--=-jbYIa5y9SRLSvsdN18+4
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.30.3">
</HEAD>
<BODY>
Dear reader,<BR>
<BR>
Problem:<BR>
The sensors command reports 0C for the MCH temp., while the BIOS gives a reasonable value of about 40C.<BR>
<BR>
Output of sensors command:<BR>
<BR>
<BLOCKQUOTE>
    <A HREF="mailto:joris@Asus5">joris@Asus5</A>:~$ sensors<BR>
    atk0110-acpi-0<BR>
    Adapter: ACPI interface<BR>
    Vcore Voltage:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +0.93 V&nbsp; (min =&nbsp; +0.80 V, max =&nbsp; +1.60 V)<BR>
     +3.3 Voltage:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +3.31 V&nbsp; (min =&nbsp; +2.97 V, max =&nbsp; +3.63 V)<BR>
     +5 Voltage:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +5.12 V&nbsp; (min =&nbsp; +4.50 V, max =&nbsp; +5.50 V)<BR>
     +12 Voltage:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +12.25 V&nbsp; (min = +10.20 V, max = +13.80 V)<BR>
    CPU FAN Speed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 958 RPM&nbsp; (min =&nbsp; 600 RPM)<BR>
    CHASSIS1 FAN Speed: 669 RPM&nbsp; (min =&nbsp; 600 RPM)<BR>
    CHASSIS2 FAN Speed: 496 RPM&nbsp; (min =&nbsp; 600 RPM)<BR>
    CHASSIS3 FAN Speed:&nbsp;&nbsp; 0 RPM&nbsp; (min =&nbsp; 600 RPM)<BR>
    POWER FAN Speed:&nbsp;&nbsp;&nbsp; 774 RPM&nbsp; (min =&nbsp;&nbsp;&nbsp; 0 RPM)<BR>
    CPU Temperature:&nbsp;&nbsp;&nbsp; +32.5&#176;C&nbsp; (high = +60.0&#176;C, crit = +75.0&#176;C)&nbsp; <BR>
    MB Temperature:&nbsp;&nbsp;&nbsp;&nbsp; +31.0&#176;C&nbsp; (high = +45.0&#176;C, crit = +75.0&#176;C)&nbsp; <BR>
    MCH Temperature:&nbsp;&nbsp;&nbsp;&nbsp; +0.0&#176;C&nbsp; (high = +60.0&#176;C, crit = +95.0&#176;C)&nbsp; <BR>
    <BR>
</BLOCKQUOTE>
Output of dmesg, sensors-detect and lsmod atttached as files.<BR>
<BR>
I have added the suggested chipdrivers coretemp and w83627ehf to /etc/modules but that didn't solve the problem; removed them again.<BR>
<BR>
Hardware:<BR>
MB: Asus Sabertooth X58<BR>
CPU: Intel i7 950<BR>
Chipset: Intel X58 / ICH 10R<BR>
<BR>
Software:<BR>
OS: Ubuntu 10.10 64 bit desktop<BR>
Kernel: 2.6.35-23<BR>
Sensors: version 3.1.2 with libsensors version 3.1.2<BR>
BIOS: AMI version 0603, build date 10/29/10<BR>
<BR>
<BR>
</BODY>
</HTML>

--=-jbYIa5y9SRLSvsdN18+4--

--=-LkTDHN8zF1doh5qupEd5
Content-Disposition: attachment; filename="dmesg.txt"
Content-Type: text/plain; name="dmesg.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.35-23-generic (buildd@allspice) (gcc version 4.4.5 (Ubuntu/Linaro 4.4.4-14ubuntu5) ) #41-Ubuntu SMP Wed Nov 24 11:55:36 UTC 2010 (Ubuntu 2.6.35-23.41-generic 2.6.35.7)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-2.6.35-23-generic root=UUID=efc654c2-7fd0-4a12-aedc-0df0ba49d3a7 ro quiet splash
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e2c00 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000bf780000 (usable)
[    0.000000]  BIOS-e820: 00000000bf780000 - 00000000bf798000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000bf798000 - 00000000bf7da000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000bf7da000 - 00000000c0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000340000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.5 present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working around it.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 update range: 0000000000000000 - 0000000000001000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x340000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-EBFFF write-through
[    0.000000]   EC000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask E00000000 write-back
[    0.000000]   1 base 200000000 mask F00000000 write-back
[    0.000000]   2 base 300000000 mask FC0000000 write-back
[    0.000000]   3 base 0C0000000 mask FC0000000 uncachable
[    0.000000]   4 base 0BF800000 mask FFF800000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000bf800000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xbf780 max_arch_pfn = 0x400000000
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009fc00 (usable)
[    0.000000]  modified: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e2c00 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 00000000bf780000 (usable)
[    0.000000]  modified: 00000000bf780000 - 00000000bf798000 (ACPI data)
[    0.000000]  modified: 00000000bf798000 - 00000000bf7da000 (ACPI NVS)
[    0.000000]  modified: 00000000bf7da000 - 00000000c0000000 (reserved)
[    0.000000]  modified: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  modified: 00000000ffe00000 - 0000000100000000 (reserved)
[    0.000000]  modified: 0000000100000000 - 0000000340000000 (usable)
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] found SMP MP-table at [ffff8800000ff780] ff780
[    0.000000] init_memory_mapping: 0000000000000000-00000000bf780000
[    0.000000]  0000000000 - 00bf600000 page 2M
[    0.000000]  00bf600000 - 00bf780000 page 4k
[    0.000000] kernel direct mapping tables up to bf780000 @ 16000-1b000
[    0.000000] init_memory_mapping: 0000000100000000-0000000340000000
[    0.000000]  0100000000 - 0340000000 page 2M
[    0.000000] kernel direct mapping tables up to 340000000 @ 19000-27000
[    0.000000] RAMDISK: 37573000 - 37ff0000
[    0.000000] ACPI: RSDP 00000000000fb940 00014 (v00 ACPIAM)
[    0.000000] ACPI: RSDT 00000000bf780000 00044 (v01 102910 RSDT2206 20101029 MSFT 00000097)
[    0.000000] ACPI: FACP 00000000bf780200 00084 (v01 102910 FACP2206 20101029 MSFT 00000097)
[    0.000000] ACPI: DSDT 00000000bf7804b0 0C469 (v01  A1682 A1682001 00000001 INTL 20060113)
[    0.000000] ACPI: FACS 00000000bf798000 00040
[    0.000000] ACPI: APIC 00000000bf780390 000D8 (v01 102910 APIC2206 20101029 MSFT 00000097)
[    0.000000] ACPI: MCFG 00000000bf780470 0003C (v01 102910 OEMMCFG  20101029 MSFT 00000097)
[    0.000000] ACPI: OEMB 00000000bf798040 00072 (v01 102910 OEMB2206 20101029 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000bf78f4b0 00038 (v01 102910 OEMHPET  20101029 MSFT 00000097)
[    0.000000] ACPI: ASPT 00000000bf798360 00034 (v06 102910 PerfTune 20101029 MSFT 00000097)
[    0.000000] ACPI: OSFR 00000000bf78f4f0 000B0 (v01 102910 OEMOSFR  20101029 MSFT 00000097)
[    0.000000] ACPI: SSDT 00000000bf79a5e0 00363 (v01 DpgPmm    CpuPm 00000012 INTL 20060113)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000340000000
[    0.000000] Initmem setup node 0 0000000000000000-0000000340000000
[    0.000000]   NODE_DATA [0000000100000000 - 0000000100004fff]
[    0.000000]  [ffffea0000000000-ffffea000b5fffff] PMD -> [ffff880100200000-ffff88010a9fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00340000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x000bf780
[    0.000000]     0: 0x00100000 -> 0x00340000
[    0.000000] On node 0 totalpages: 3143439
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3927 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 765880 pages, LIFO batch:31
[    0.000000]   Normal zone: 32256 pages used for memmap
[    0.000000]   Normal zone: 2327040 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x88] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x89] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x8a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x8b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x8c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x8d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x8e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x8f] disabled)
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec8a000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec8a000, GSI 24-47
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] SMP: Allowing 16 CPUs, 8 hotplug CPUs
[    0.000000] nr_irqs_gsi: 64
[    0.000000] early_res array is doubled to 64 at [22000 - 227ff]
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e3000
[    0.000000] PM: Registered nosave memory: 00000000000e3000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000bf780000 - 00000000bf798000
[    0.000000] PM: Registered nosave memory: 00000000bf798000 - 00000000bf7da000
[    0.000000] PM: Registered nosave memory: 00000000bf7da000 - 00000000c0000000
[    0.000000] PM: Registered nosave memory: 00000000c0000000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000ffe00000
[    0.000000] PM: Registered nosave memory: 00000000ffe00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at c0000000 (gap: c0000000:3ee00000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] early_res array is doubled to 128 at [22800 - 237ff]
[    0.000000] PERCPU: Embedded 30 pages/cpu @ffff880001e00000 s91520 r8192 d23168 u131072
[    0.000000] pcpu-alloc: s91520 r8192 d23168 u131072 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 3096847
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-2.6.35-23-generic root=UUID=efc654c2-7fd0-4a12-aedc-0df0ba49d3a7 ro quiet splash
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Subtract (68 early reservations)
[    0.000000]   #1 [0001000000 - 0001d17114]   TEXT DATA BSS
[    0.000000]   #2 [0037573000 - 0037ff0000]         RAMDISK
[    0.000000]   #3 [0001d18000 - 0001d18294]             BRK
[    0.000000]   #4 [00000ff790 - 0000100000]   BIOS reserved
[    0.000000]   #5 [00000ff780 - 00000ff790]    MP-table mpf
[    0.000000]   #6 [000009fc00 - 00000f1300]   BIOS reserved
[    0.000000]   #7 [00000f14bc - 00000ff780]   BIOS reserved
[    0.000000]   #8 [00000f1300 - 00000f14bc]    MP-table mpc
[    0.000000]   #9 [0000010000 - 0000012000]      TRAMPOLINE
[    0.000000]   #10 [0000012000 - 0000016000]     ACPI WAKEUP
[    0.000000]   #11 [0000016000 - 0000019000]         PGTABLE
[    0.000000]   #12 [0000019000 - 0000022000]         PGTABLE
[    0.000000]   #13 [0100000000 - 0100005000]       NODE_DATA
[    0.000000]   #14 [0001d182c0 - 0001d192c0]         BOOTMEM
[    0.000000]   #15 [0001d17140 - 0001d17a40]         BOOTMEM
[    0.000000]   #16 [0100005000 - 0100006000]         BOOTMEM
[    0.000000]   #17 [0100006000 - 0100007000]         BOOTMEM
[    0.000000]   #18 [0100200000 - 010aa00000]        MEMMAP 0
[    0.000000]   #19 [0001d17a40 - 0001d17bc0]         BOOTMEM
[    0.000000]   #20 [0001d192c0 - 0001d312c0]         BOOTMEM
[    0.000000]   #21 [0001d312c0 - 0001d492c0]         BOOTMEM
[    0.000000]   #22 [0001d4a000 - 0001d4b000]         BOOTMEM
[    0.000000]   #23 [0001d17bc0 - 0001d17c01]         BOOTMEM
[    0.000000]   #24 [0001d17c40 - 0001d17cc6]         BOOTMEM
[    0.000000]   #25 [0001d17d00 - 0001d17f68]         BOOTMEM
[    0.000000]   #26 [0001d17f80 - 0001d17fe8]         BOOTMEM
[    0.000000]   #27 [0001d492c0 - 0001d49328]         BOOTMEM
[    0.000000]   #28 [0001d49340 - 0001d493a8]         BOOTMEM
[    0.000000]   #29 [0001d493c0 - 0001d49428]         BOOTMEM
[    0.000000]   #30 [0001d49440 - 0001d494a8]         BOOTMEM
[    0.000000]   #31 [0001d494c0 - 0001d49528]         BOOTMEM
[    0.000000]   #32 [0001d49540 - 0001d495a8]         BOOTMEM
[    0.000000]   #33 [0001d495c0 - 0001d49628]         BOOTMEM
[    0.000000]   #34 [0001d49640 - 0001d496a8]         BOOTMEM
[    0.000000]   #35 [0001d496c0 - 0001d49728]         BOOTMEM
[    0.000000]   #36 [0001d49740 - 0001d49760]         BOOTMEM
[    0.000000]   #37 [0001d49780 - 0001d497a0]         BOOTMEM
[    0.000000]   #38 [0001d497c0 - 0001d4982a]         BOOTMEM
[    0.000000]   #39 [0001d49840 - 0001d498aa]         BOOTMEM
[    0.000000]   #40 [0001e00000 - 0001e1e000]         BOOTMEM
[    0.000000]   #41 [0001e20000 - 0001e3e000]         BOOTMEM
[    0.000000]   #42 [0001e40000 - 0001e5e000]         BOOTMEM
[    0.000000]   #43 [0001e60000 - 0001e7e000]         BOOTMEM
[    0.000000]   #44 [0001e80000 - 0001e9e000]         BOOTMEM
[    0.000000]   #45 [0001ea0000 - 0001ebe000]         BOOTMEM
[    0.000000]   #46 [0001ec0000 - 0001ede000]         BOOTMEM
[    0.000000]   #47 [0001ee0000 - 0001efe000]         BOOTMEM
[    0.000000]   #48 [0001f00000 - 0001f1e000]         BOOTMEM
[    0.000000]   #49 [0001f20000 - 0001f3e000]         BOOTMEM
[    0.000000]   #50 [0001f40000 - 0001f5e000]         BOOTMEM
[    0.000000]   #51 [0001f60000 - 0001f7e000]         BOOTMEM
[    0.000000]   #52 [0001f80000 - 0001f9e000]         BOOTMEM
[    0.000000]   #53 [0001fa0000 - 0001fbe000]         BOOTMEM
[    0.000000]   #54 [0001fc0000 - 0001fde000]         BOOTMEM
[    0.000000]   #55 [0001fe0000 - 0001ffe000]         BOOTMEM
[    0.000000]   #56 [0001d498c0 - 0001d498c8]         BOOTMEM
[    0.000000]   #57 [0001d49900 - 0001d49908]         BOOTMEM
[    0.000000]   #58 [0001d49940 - 0001d49980]         BOOTMEM
[    0.000000]   #59 [0001d49980 - 0001d49a00]         BOOTMEM
[    0.000000]   #60 [0001d49a00 - 0001d49b10]         BOOTMEM
[    0.000000]   #61 [0001d49b40 - 0001d49b88]         BOOTMEM
[    0.000000]   #62 [0001d49bc0 - 0001d49c08]         BOOTMEM
[    0.000000]   #63 [0001d4b000 - 0001d53000]         BOOTMEM
[    0.000000]   #64 [0001ffe000 - 0005ffe000]         BOOTMEM
[    0.000000]   #65 [0001d53000 - 0001d73000]         BOOTMEM
[    0.000000]   #66 [0001d73000 - 0001db3000]         BOOTMEM
[    0.000000]   #67 [0000023800 - 000002b800]         BOOTMEM
[    0.000000] Memory: 12309364k/13631488k available (5710k kernel code, 1057732k absent, 264392k reserved, 5380k data, 908k init)
[    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU-based detection of stalled CPUs is disabled.
[    0.000000] 	Verbose stalled-CPUs detection is disabled.
[    0.000000] NR_IRQS:4352 nr_irqs:1216
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 125829120 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.010000] Detected 3073.921 MHz processor.
[    0.000007] Calibrating delay loop (skipped), value calculated using timer frequency.. 6147.84 BogoMIPS (lpj=30739210)
[    0.000010] pid_max: default: 32768 minimum: 301
[    0.000028] Security Framework initialized
[    0.000039] AppArmor: AppArmor initialized
[    0.000040] Yama: becoming mindful.
[    0.001310] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.007034] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.008214] Mount-cache hash table entries: 256
[    0.008311] Initializing cgroup subsys ns
[    0.008314] Initializing cgroup subsys cpuacct
[    0.008318] Initializing cgroup subsys memory
[    0.008324] Initializing cgroup subsys devices
[    0.008326] Initializing cgroup subsys freezer
[    0.008328] Initializing cgroup subsys net_cls
[    0.008347] CPU: Physical Processor ID: 0
[    0.008349] CPU: Processor Core ID: 0
[    0.008353] mce: CPU supports 9 MCE banks
[    0.008365] CPU0: Thermal monitoring enabled (TM1)
[    0.008373] using mwait in idle threads.
[    0.008375] Performance Events: PEBS fmt1+, Nehalem events, Intel PMU driver.
[    0.008381] ... version:                3
[    0.008382] ... bit width:              48
[    0.008383] ... generic registers:      4
[    0.008384] ... value mask:             0000ffffffffffff
[    0.008385] ... max period:             000000007fffffff
[    0.008386] ... fixed-purpose events:   3
[    0.008387] ... event mask:             000000070000000f
[    0.010228] ACPI: Core revision 20100428
[    0.050648] ftrace: converting mcount calls to 0f 1f 44 00 00
[    0.050656] ftrace: allocating 22688 entries in 89 pages
[    0.056500] Setting APIC routing to physical flat
[    0.056958] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.169956] CPU0: Intel(R) Core(TM) i7 CPU         950  @ 3.07GHz stepping 05
[    0.288892] APIC calibration not consistent with PM-Timer: 97ms instead of 100ms
[    0.288895] APIC delta adjusted to PM-Timer: 835223 (817607)
[    0.289029] Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7
[    1.548408] Brought up 8 CPUs
[    1.548411] Total of 8 processors activated (48789.38 BogoMIPS).
[    1.552034] devtmpfs: initialized
[    1.552751] regulator: core version 0.5
[    1.552773] Time:  9:50:13  Date: 01/03/11
[    1.552796] NET: Registered protocol family 16
[    1.552859] Trying to unpack rootfs image as initramfs...
[    1.552871] ACPI: bus type pci registered
[    1.552921] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    1.552923] PCI: not using MMCONFIG
[    1.552924] PCI: Using configuration type 1 for base access
[    1.553449] bio: create slab <bio-0> at 0
[    1.554641] ACPI: EC: Look up EC in DSDT
[    1.555791] ACPI: Executed 1 blocks of module-level executable AML code
[    1.600357] ACPI: SSDT 00000000bf7983a0 0223C (v01 DpgPmm  P001Ist 00000011 INTL 20060113)
[    1.600731] ACPI: Dynamic OEM Table Load:
[    1.600733] ACPI: SSDT (null) 0223C (v01 DpgPmm  P001Ist 00000011 INTL 20060113)
[    1.600918] ACPI: Interpreter enabled
[    1.600920] ACPI: (supports S0 S1 S3 S4 S5)
[    1.600937] ACPI: Using IOAPIC for interrupt routing
[    1.600981] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    1.602669] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    1.639758] ACPI: No dock devices found.
[    1.639761] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.639879] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.640107] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    1.640109] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    1.640111] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    1.640112] pci_root PNP0A08:00: host bridge window [mem 0x000d0000-0x000dffff]
[    1.640114] pci_root PNP0A08:00: host bridge window [mem 0xc0000000-0xdfffffff]
[    1.640115] pci_root PNP0A08:00: host bridge window [mem 0xf0000000-0xfed8ffff]
[    1.640164] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.640167] pci 0000:00:00.0: PME# disabled
[    1.640219] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.640222] pci 0000:00:01.0: PME# disabled
[    1.640271] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    1.640274] pci 0000:00:02.0: PME# disabled
[    1.640322] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.640325] pci 0000:00:03.0: PME# disabled
[    1.640377] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    1.640379] pci 0000:00:07.0: PME# disabled
[    1.640574] pci 0000:00:1a.0: reg 20: [io  0xa800-0xa81f]
[    1.640630] pci 0000:00:1a.1: reg 20: [io  0xa880-0xa89f]
[    1.640686] pci 0000:00:1a.2: reg 20: [io  0xac00-0xac1f]
[    1.640742] pci 0000:00:1a.7: reg 10: [mem 0xf7dff000-0xf7dff3ff]
[    1.640790] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    1.640793] pci 0000:00:1a.7: PME# disabled
[    1.640822] pci 0000:00:1b.0: reg 10: [mem 0xf7df8000-0xf7dfbfff 64bit]
[    1.640858] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.640861] pci 0000:00:1b.0: PME# disabled
[    1.640917] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.640919] pci 0000:00:1c.0: PME# disabled
[    1.640979] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.640982] pci 0000:00:1c.4: PME# disabled
[    1.641026] pci 0000:00:1d.0: reg 20: [io  0xa080-0xa09f]
[    1.641083] pci 0000:00:1d.1: reg 20: [io  0xa400-0xa41f]
[    1.641139] pci 0000:00:1d.2: reg 20: [io  0xa480-0xa49f]
[    1.641194] pci 0000:00:1d.7: reg 10: [mem 0xf7dfe000-0xf7dfe3ff]
[    1.641242] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    1.641246] pci 0000:00:1d.7: PME# disabled
[    1.641346] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by ICH6 ACPI/GPIO/TCO
[    1.641349] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by ICH6 GPIO
[    1.641352] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0294 (mask 0003)
[    1.641395] pci 0000:00:1f.2: reg 10: [io  0x9000-0x9007]
[    1.641399] pci 0000:00:1f.2: reg 14: [io  0x8c00-0x8c03]
[    1.641404] pci 0000:00:1f.2: reg 18: [io  0x8880-0x8887]
[    1.641408] pci 0000:00:1f.2: reg 1c: [io  0x8800-0x8803]
[    1.641412] pci 0000:00:1f.2: reg 20: [io  0x8480-0x848f]
[    1.641417] pci 0000:00:1f.2: reg 24: [io  0x8400-0x840f]
[    1.641455] pci 0000:00:1f.3: reg 10: [mem 0xf7dfd000-0xf7dfd0ff 64bit]
[    1.641466] pci 0000:00:1f.3: reg 20: [io  0x1000-0x101f]
[    1.641498] pci 0000:00:1f.5: reg 10: [io  0xa000-0xa007]
[    1.641502] pci 0000:00:1f.5: reg 14: [io  0x9c00-0x9c03]
[    1.641507] pci 0000:00:1f.5: reg 18: [io  0x9880-0x9887]
[    1.641511] pci 0000:00:1f.5: reg 1c: [io  0x9800-0x9803]
[    1.641515] pci 0000:00:1f.5: reg 20: [io  0x9480-0x948f]
[    1.641520] pci 0000:00:1f.5: reg 24: [io  0x9400-0x940f]
[    1.641591] pci 0000:01:00.0: reg 10: [io  0xbc00-0xbc07]
[    1.641595] pci 0000:01:00.0: reg 14: [io  0xb880-0xb883]
[    1.641599] pci 0000:01:00.0: reg 18: [io  0xb800-0xb807]
[    1.641604] pci 0000:01:00.0: reg 1c: [io  0xb480-0xb483]
[    1.641608] pci 0000:01:00.0: reg 20: [io  0xb400-0xb40f]
[    1.641612] pci 0000:01:00.0: reg 24: [mem 0xf7eff800-0xf7efffff]
[    1.641617] pci 0000:01:00.0: reg 30: [mem 0xf7ee0000-0xf7eeffff pref]
[    1.641635] pci 0000:01:00.0: PME# supported from D3hot
[    1.641638] pci 0000:01:00.0: PME# disabled
[    1.658250] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    1.658254] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
[    1.658257] pci 0000:00:01.0:   bridge window [mem 0xf7e00000-0xf7efffff]
[    1.658261] pci 0000:00:01.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.658321] pci 0000:02:00.0: reg 10: [mem 0xf7ffe000-0xf7ffffff 64bit]
[    1.658368] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    1.658372] pci 0000:02:00.0: PME# disabled
[    1.678243] pci 0000:00:02.0: PCI bridge to [bus 02-02]
[    1.678247] pci 0000:00:02.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.678250] pci 0000:00:02.0:   bridge window [mem 0xf7f00000-0xf7ffffff]
[    1.678254] pci 0000:00:02.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.678303] pci 0000:03:00.0: reg 10: [mem 0xf8000000-0xf9ffffff]
[    1.678311] pci 0000:03:00.0: reg 14: [mem 0xd8000000-0xdfffffff 64bit pref]
[    1.678318] pci 0000:03:00.0: reg 1c: [mem 0xd4000000-0xd7ffffff 64bit pref]
[    1.678322] pci 0000:03:00.0: reg 24: [io  0xcc00-0xcc7f]
[    1.678326] pci 0000:03:00.0: reg 30: [mem 0xfbc00000-0xfbc7ffff pref]
[    1.678373] pci 0000:03:00.1: reg 10: [mem 0xfbcfc000-0xfbcfffff]
[    1.698232] pci 0000:00:03.0: PCI bridge to [bus 03-03]
[    1.698237] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    1.698239] pci 0000:00:03.0:   bridge window [mem 0xf8000000-0xfbcfffff]
[    1.698244] pci 0000:00:03.0:   bridge window [mem 0xd4000000-0xdfffffff 64bit pref]
[    1.698278] pci 0000:00:07.0: PCI bridge to [bus 04-04]
[    1.698280] pci 0000:00:07.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.698283] pci 0000:00:07.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.698287] pci 0000:00:07.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.698323] pci 0000:00:1c.0: PCI bridge to [bus 06-06]
[    1.698326] pci 0000:00:1c.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.698329] pci 0000:00:1c.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.698333] pci 0000:00:1c.0:   bridge window [mem 0xf6f00000-0xf6ffffff 64bit pref]
[    1.698406] pci 0000:05:00.0: reg 10: [io  0xdc00-0xdc07]
[    1.698414] pci 0000:05:00.0: reg 14: [io  0xd880-0xd883]
[    1.698422] pci 0000:05:00.0: reg 18: [io  0xd800-0xd807]
[    1.698429] pci 0000:05:00.0: reg 1c: [io  0xd480-0xd483]
[    1.698437] pci 0000:05:00.0: reg 20: [io  0xd400-0xd40f]
[    1.698445] pci 0000:05:00.0: reg 24: [mem 0xfbdffc00-0xfbdffdff]
[    1.698453] pci 0000:05:00.0: reg 30: [mem 0x00000000-0x0000ffff pref]
[    1.698485] pci 0000:05:00.0: PME# supported from D3hot
[    1.698490] pci 0000:05:00.0: PME# disabled
[    1.719597] pci 0000:00:1c.4: PCI bridge to [bus 05-05]
[    1.719602] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    1.719605] pci 0000:00:1c.4:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    1.719610] pci 0000:00:1c.4:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.719658] pci 0000:07:01.0: reg 10: [io  0xe800-0xe8ff]
[    1.719663] pci 0000:07:01.0: reg 14: [mem 0xfbeffc00-0xfbeffcff]
[    1.719685] pci 0000:07:01.0: reg 30: [mem 0xfbec0000-0xfbedffff pref]
[    1.719708] pci 0000:07:01.0: supports D1 D2
[    1.719709] pci 0000:07:01.0: PME# supported from D1 D2 D3hot D3cold
[    1.719713] pci 0000:07:01.0: PME# disabled
[    1.719740] pci 0000:07:02.0: reg 10: [mem 0xfbefe000-0xfbefe7ff]
[    1.719746] pci 0000:07:02.0: reg 14: [io  0xec00-0xec7f]
[    1.719785] pci 0000:07:02.0: supports D2
[    1.719786] pci 0000:07:02.0: PME# supported from D2 D3hot D3cold
[    1.719789] pci 0000:07:02.0: PME# disabled
[    1.719827] pci 0000:00:1e.0: PCI bridge to [bus 07-07] (subtractive decode)
[    1.719830] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    1.719833] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.719838] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.719840] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    1.719841] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    1.719843] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    1.719845] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff] (subtractive decode)
[    1.719846] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffffff] (subtractive decode)
[    1.719848] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfed8ffff] (subtractive decode)
[    1.719879] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.720103] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    1.720190] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
[    1.720242] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
[    1.720298] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE1._PRT]
[    1.720341] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE2._PRT]
[    1.720384] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE3._PRT]
[    1.720426] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE7._PRT]
[    1.743036] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12 14 15)
[    1.743134] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 *10 11 12 14 15)
[    1.743229] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 11 12 *14 15)
[    1.743328] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 6 7 10 11 12 14 15)
[    1.743423] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12 14 *15)
[    1.743521] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 *7 10 11 12 14 15)
[    1.743616] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *6 7 10 11 12 14 15)
[    1.743711] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 *10 11 12 14 15)
[    1.743750] HEST: Table is not found!
[    1.743800] vgaarb: device added: PCI:0000:03:00.0,decodes=io+mem,owns=io+mem,locks=none
[    1.743802] vgaarb: loaded
[    1.743889] SCSI subsystem initialized
[    1.744004] libata version 3.00 loaded.
[    1.744035] usbcore: registered new interface driver usbfs
[    1.744041] usbcore: registered new interface driver hub
[    1.744057] usbcore: registered new device driver usb
[    1.744157] ACPI: WMI: Mapper loaded
[    1.744159] PCI: Using ACPI for IRQ routing
[    1.744160] PCI: pci_cache_line_size set to 64 bytes
[    1.744245] reserve RAM buffer: 000000000009fc00 - 000000000009ffff 
[    1.744246] reserve RAM buffer: 00000000bf780000 - 00000000bfffffff 
[    1.744305] NetLabel: Initializing
[    1.744306] NetLabel:  domain hash size = 128
[    1.744307] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.744315] NetLabel:  unlabeled traffic allowed by default
[    1.744334] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    1.744338] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    1.744341] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    1.775170] Freeing initrd memory: 10740k freed
[    1.778323] Switching to clocksource tsc
[    1.783754] AppArmor: AppArmor Filesystem Enabled
[    1.783764] pnp: PnP ACPI init
[    1.783776] ACPI: bus type pnp registered
[    1.786139] pnp: PnP ACPI: found 16 devices
[    1.786140] ACPI: ACPI bus type pnp unregistered
[    1.786149] system 00:01: [mem 0xfbf00000-0xfbffffff] has been reserved
[    1.786150] system 00:01: [mem 0xfc000000-0xfcffffff] has been reserved
[    1.786152] system 00:01: [mem 0xfd000000-0xfdffffff] has been reserved
[    1.786154] system 00:01: [mem 0xfe000000-0xfebfffff] has been reserved
[    1.786155] system 00:01: [mem 0xfec8a000-0xfec8afff] could not be reserved
[    1.786157] system 00:01: [mem 0xfed10000-0xfed10fff] has been reserved
[    1.786161] system 00:06: [io  0x0290-0x029f] has been reserved
[    1.786165] system 00:07: [io  0x04d0-0x04d1] has been reserved
[    1.786166] system 00:07: [io  0x0800-0x087f] has been reserved
[    1.786168] system 00:07: [io  0x0500-0x057f] could not be reserved
[    1.786169] system 00:07: [io  0x0600-0x0607] has been reserved
[    1.786171] system 00:07: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.786173] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.786175] system 00:07: [mem 0xfed40000-0xfed8ffff] has been reserved
[    1.786178] system 00:0a: [mem 0xffc00000-0xffdfffff] has been reserved
[    1.786181] system 00:0b: [mem 0xfec00000-0xfec00fff] could not be reserved
[    1.786182] system 00:0b: [mem 0xfee00000-0xfee00fff] has been reserved
[    1.786186] system 00:0e: [mem 0xe0000000-0xefffffff] has been reserved
[    1.786189] system 00:0f: [mem 0x00000000-0x0009ffff] could not be reserved
[    1.786190] system 00:0f: [mem 0x000c0000-0x000cffff] has been reserved
[    1.786194] system 00:0f: [mem 0x000e0000-0x000fffff] could not be reserved
[    1.786196] system 00:0f: [mem 0x00100000-0xbfffffff] could not be reserved
[    1.786197] system 00:0f: [mem 0xfed90000-0xffffffff] could not be reserved
[    1.794110] pci 0000:00:1c.0: BAR 14: assigned [mem 0xc0000000-0xc03fffff]
[    1.794113] pci 0000:00:1c.4: BAR 15: assigned [mem 0xc0400000-0xc05fffff pref]
[    1.794115] pci 0000:00:1c.0: BAR 13: assigned [io  0x2000-0x2fff]
[    1.794117] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    1.794119] pci 0000:00:01.0:   bridge window [io  0xb000-0xbfff]
[    1.794123] pci 0000:00:01.0:   bridge window [mem 0xf7e00000-0xf7efffff]
[    1.794125] pci 0000:00:01.0:   bridge window [mem pref disabled]
[    1.794129] pci 0000:00:02.0: PCI bridge to [bus 02-02]
[    1.794130] pci 0000:00:02.0:   bridge window [io  disabled]
[    1.794133] pci 0000:00:02.0:   bridge window [mem 0xf7f00000-0xf7ffffff]
[    1.794136] pci 0000:00:02.0:   bridge window [mem pref disabled]
[    1.794140] pci 0000:00:03.0: PCI bridge to [bus 03-03]
[    1.794142] pci 0000:00:03.0:   bridge window [io  0xc000-0xcfff]
[    1.794145] pci 0000:00:03.0:   bridge window [mem 0xf8000000-0xfbcfffff]
[    1.794148] pci 0000:00:03.0:   bridge window [mem 0xd4000000-0xdfffffff 64bit pref]
[    1.794152] pci 0000:00:07.0: PCI bridge to [bus 04-04]
[    1.794153] pci 0000:00:07.0:   bridge window [io  disabled]
[    1.794156] pci 0000:00:07.0:   bridge window [mem disabled]
[    1.794158] pci 0000:00:07.0:   bridge window [mem pref disabled]
[    1.794162] pci 0000:00:1c.0: PCI bridge to [bus 06-06]
[    1.794164] pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
[    1.794168] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc03fffff]
[    1.794171] pci 0000:00:1c.0:   bridge window [mem 0xf6f00000-0xf6ffffff 64bit pref]
[    1.794176] pci 0000:05:00.0: BAR 6: assigned [mem 0xc0400000-0xc040ffff pref]
[    1.794178] pci 0000:00:1c.4: PCI bridge to [bus 05-05]
[    1.794180] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    1.794183] pci 0000:00:1c.4:   bridge window [mem 0xfbd00000-0xfbdfffff]
[    1.794186] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc05fffff pref]
[    1.794191] pci 0000:00:1e.0: PCI bridge to [bus 07-07]
[    1.794193] pci 0000:00:1e.0:   bridge window [io  0xe000-0xefff]
[    1.794197] pci 0000:00:1e.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.794199] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    1.794211] pci 0000:00:01.0: setting latency timer to 64
[    1.794218] pci 0000:00:02.0: setting latency timer to 64
[    1.794224] pci 0000:00:03.0: setting latency timer to 64
[    1.794231] pci 0000:00:07.0: setting latency timer to 64
[    1.794236] pci 0000:00:1c.0: enabling device (0106 -> 0107)
[    1.794241]   alloc irq_desc for 17 on node -1
[    1.794243]   alloc kstat_irqs on node -1
[    1.794248] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.794251] pci 0000:00:1c.0: setting latency timer to 64
[    1.794257] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.794260] pci 0000:00:1c.4: setting latency timer to 64
[    1.794265] pci 0000:00:1e.0: setting latency timer to 64
[    1.794268] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    1.794270] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    1.794271] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    1.794272] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
[    1.794274] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff]
[    1.794275] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff]
[    1.794276] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
[    1.794278] pci_bus 0000:01: resource 1 [mem 0xf7e00000-0xf7efffff]
[    1.794279] pci_bus 0000:02: resource 1 [mem 0xf7f00000-0xf7ffffff]
[    1.794281] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    1.794282] pci_bus 0000:03: resource 1 [mem 0xf8000000-0xfbcfffff]
[    1.794283] pci_bus 0000:03: resource 2 [mem 0xd4000000-0xdfffffff 64bit pref]
[    1.794285] pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]
[    1.794286] pci_bus 0000:06: resource 1 [mem 0xc0000000-0xc03fffff]
[    1.794288] pci_bus 0000:06: resource 2 [mem 0xf6f00000-0xf6ffffff 64bit pref]
[    1.794289] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
[    1.794290] pci_bus 0000:05: resource 1 [mem 0xfbd00000-0xfbdfffff]
[    1.794292] pci_bus 0000:05: resource 2 [mem 0xc0400000-0xc05fffff pref]
[    1.794293] pci_bus 0000:07: resource 0 [io  0xe000-0xefff]
[    1.794294] pci_bus 0000:07: resource 1 [mem 0xfbe00000-0xfbefffff]
[    1.794296] pci_bus 0000:07: resource 4 [io  0x0000-0x0cf7]
[    1.794297] pci_bus 0000:07: resource 5 [io  0x0d00-0xffff]
[    1.794298] pci_bus 0000:07: resource 6 [mem 0x000a0000-0x000bffff]
[    1.794300] pci_bus 0000:07: resource 7 [mem 0x000d0000-0x000dffff]
[    1.794301] pci_bus 0000:07: resource 8 [mem 0xc0000000-0xdfffffff]
[    1.794302] pci_bus 0000:07: resource 9 [mem 0xf0000000-0xfed8ffff]
[    1.794331] NET: Registered protocol family 2
[    1.794628] IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    1.795597] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    1.796765] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.796887] TCP: Hash tables configured (established 524288 bind 65536)
[    1.796888] TCP reno registered
[    1.796907] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    1.796962] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    1.797077] NET: Registered protocol family 1
[    1.799280] pci 0000:02:00.0: xHCI HW did not halt within 2000 usec status = 0x0
[    1.799294] pci 0000:03:00.0: Boot video device
[    1.799307] PCI: CLS mismatch (256 != 64), using 64 bytes
[    1.799310] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.799312] Placing 64MB software IO TLB between ffff880001ffe000 - ffff880005ffe000
[    1.799313] software IO TLB at phys 0x1ffe000 - 0x5ffe000
[    1.799645] Scanning for low memory corruption every 60 seconds
[    1.799722] audit: initializing netlink socket (disabled)
[    1.799729] type=2000 audit(1294048212.600:1): initialized
[    4.617082] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    4.618067] VFS: Disk quotas dquot_6.5.2
[    4.618109] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    4.618499] fuse init (API version 7.14)
[    4.618555] msgmni has been set to 24062
[    4.620031] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    4.620033] io scheduler noop registered
[    4.620034] io scheduler deadline registered
[    4.620060] io scheduler cfq registered (default)
[    4.620138] pcieport 0000:00:01.0: setting latency timer to 64
[    4.620163]   alloc irq_desc for 64 on node -1
[    4.620164]   alloc kstat_irqs on node -1
[    4.620174] pcieport 0000:00:01.0: irq 64 for MSI/MSI-X
[    4.620224] pcieport 0000:00:02.0: setting latency timer to 64
[    4.620246]   alloc irq_desc for 65 on node -1
[    4.620247]   alloc kstat_irqs on node -1
[    4.620252] pcieport 0000:00:02.0: irq 65 for MSI/MSI-X
[    4.620297] pcieport 0000:00:03.0: setting latency timer to 64
[    4.620319]   alloc irq_desc for 66 on node -1
[    4.620320]   alloc kstat_irqs on node -1
[    4.620325] pcieport 0000:00:03.0: irq 66 for MSI/MSI-X
[    4.620370] pcieport 0000:00:07.0: setting latency timer to 64
[    4.620392]   alloc irq_desc for 67 on node -1
[    4.620393]   alloc kstat_irqs on node -1
[    4.620397] pcieport 0000:00:07.0: irq 67 for MSI/MSI-X
[    4.620445] pcieport 0000:00:1c.0: setting latency timer to 64
[    4.620471]   alloc irq_desc for 68 on node -1
[    4.620471]   alloc kstat_irqs on node -1
[    4.620476] pcieport 0000:00:1c.0: irq 68 for MSI/MSI-X
[    4.620532] pcieport 0000:00:1c.4: setting latency timer to 64
[    4.620558]   alloc irq_desc for 69 on node -1
[    4.620559]   alloc kstat_irqs on node -1
[    4.620564] pcieport 0000:00:1c.4: irq 69 for MSI/MSI-X
[    4.620626] aer 0000:00:01.0:pcie02: AER service couldn't init device: no _OSC support
[    4.620630] aer 0000:00:02.0:pcie02: AER service couldn't init device: no _OSC support
[    4.620633] aer 0000:00:03.0:pcie02: AER service couldn't init device: no _OSC support
[    4.620636] aer 0000:00:07.0:pcie02: AER service couldn't init device: no _OSC support
[    4.620646] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    4.620693] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    4.620740] intel_idle: MWAIT substates: 0x1120
[    4.620741] intel_idle: v0.4 model 0x1A
[    4.620742] intel_idle: lapic_timer_reliable_states 0x2
[    4.620832] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    4.620835] ACPI: Power Button [PWRB]
[    4.620861] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    4.620863] ACPI: Power Button [PWRF]
[    4.621123] ACPI: acpi_idle yielding to intel_idle
[    4.623228] ERST: Table is not found!
[    4.623363] Linux agpgart interface v0.103
[    4.623375] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.623462] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    4.623711] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    4.624371] brd: module loaded
[    4.624670] loop: module loaded
[    4.624766] ata_piix 0000:00:1f.2: version 2.13
[    4.624777]   alloc irq_desc for 20 on node -1
[    4.624778]   alloc kstat_irqs on node -1
[    4.624782] ata_piix 0000:00:1f.2: PCI INT B -> GSI 20 (level, low) -> IRQ 20
[    4.624787] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[    4.624811] ata_piix 0000:00:1f.2: setting latency timer to 64
[    4.624851] scsi0 : ata_piix
[    4.624899] scsi1 : ata_piix
[    4.629095] ata1: SATA max UDMA/133 cmd 0x9000 ctl 0x8c00 bmdma 0x8480 irq 20
[    4.629100] ata2: SATA max UDMA/133 cmd 0x8880 ctl 0x8800 bmdma 0x8488 irq 20
[    4.629129] ata_piix 0000:00:1f.5: PCI INT B -> GSI 20 (level, low) -> IRQ 20
[    4.629133] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
[    4.629167] ata_piix 0000:00:1f.5: setting latency timer to 64
[    4.629196] scsi2 : ata_piix
[    4.629241] scsi3 : ata_piix
[    4.630056] ata3: SATA max UDMA/133 cmd 0xa000 ctl 0x9c00 bmdma 0x9480 irq 20
[    4.630059] ata4: SATA max UDMA/133 cmd 0x9880 ctl 0x9800 bmdma 0x9488 irq 20
[    4.630099]   alloc irq_desc for 28 on node -1
[    4.630101]   alloc kstat_irqs on node -1
[    4.630107] pata_acpi 0000:01:00.0: PCI INT A -> GSI 28 (level, low) -> IRQ 28
[    4.630121] pata_acpi 0000:01:00.0: setting latency timer to 64
[    4.630129] pata_acpi 0000:01:00.0: PCI INT A disabled
[    4.630285] Fixed MDIO Bus: probed
[    4.630304] PPP generic driver version 2.4.2
[    4.630338] tun: Universal TUN/TAP device driver, 1.6
[    4.630339] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    4.630390] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.630403]   alloc irq_desc for 18 on node -1
[    4.630404]   alloc kstat_irqs on node -1
[    4.630407] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    4.630429] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    4.630432] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    4.630456] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    4.630477] ehci_hcd 0000:00:1a.7: debug port 1
[    4.634370] ehci_hcd 0000:00:1a.7: cache line size of 64 is not supported
[    4.634382] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf7dff000
[    4.648529] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    4.648659] hub 1-0:1.0: USB hub found
[    4.648662] hub 1-0:1.0: 6 ports detected
[    4.648725]   alloc irq_desc for 23 on node -1
[    4.648727]   alloc kstat_irqs on node -1
[    4.648732] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    4.648751] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    4.648753] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    4.648780] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    4.648799] ehci_hcd 0000:00:1d.7: debug port 1
[    4.652672] ehci_hcd 0000:00:1d.7: cache line size of 64 is not supported
[    4.652684] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf7dfe000
[    4.678516] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    4.678641] hub 2-0:1.0: USB hub found
[    4.678644] hub 2-0:1.0: 6 ports detected
[    4.678702] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.678711] uhci_hcd: USB Universal Host Controller Interface driver
[    4.678760]   alloc irq_desc for 16 on node -1
[    4.678761]   alloc kstat_irqs on node -1
[    4.678766] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    4.678772] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    4.678774] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    4.678798] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    4.678828] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000a800
[    4.678895] hub 3-0:1.0: USB hub found
[    4.678898] hub 3-0:1.0: 2 ports detected
[    4.678937]   alloc irq_desc for 21 on node -1
[    4.678938]   alloc kstat_irqs on node -1
[    4.678941] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    4.678945] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    4.678948] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    4.678967] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    4.678993] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000a880
[    4.679059] hub 4-0:1.0: USB hub found
[    4.679061] hub 4-0:1.0: 2 ports detected
[    4.679099]   alloc irq_desc for 19 on node -1
[    4.679100]   alloc kstat_irqs on node -1
[    4.679103] uhci_hcd 0000:00:1a.2: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    4.679108] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[    4.679110] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    4.679131] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    4.679157] uhci_hcd 0000:00:1a.2: irq 19, io base 0x0000ac00
[    4.679227] hub 5-0:1.0: USB hub found
[    4.679230] hub 5-0:1.0: 2 ports detected
[    4.679267] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    4.679271] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    4.679273] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    4.679295] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    5.145479] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000a080
[    5.145603] hub 6-0:1.0: USB hub found
[    5.145606] hub 6-0:1.0: 2 ports detected
[    5.145657] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    5.145662] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    5.145665] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    5.145692] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    5.145715] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000a400
[    5.145782] hub 7-0:1.0: USB hub found
[    5.145785] hub 7-0:1.0: 2 ports detected
[    5.145823] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    5.145827] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    5.145830] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    5.145849] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    5.145869] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000a480
[    5.145933] hub 8-0:1.0: USB hub found
[    5.145936] hub 8-0:1.0: 2 ports detected
[    5.146012] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    5.146013] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    5.146487] serio: i8042 KBD port at 0x60,0x64 irq 1
[    5.146538] mice: PS/2 mouse device common for all mice
[    5.146609] rtc_cmos 00:03: RTC can wake from S4
[    5.146632] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    5.146654] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    5.146732] device-mapper: uevent: version 1.0.3
[    5.146806] device-mapper: ioctl: 4.17.0-ioctl (2010-03-05) initialised: dm-devel@redhat.com
[    5.146907] device-mapper: multipath: version 1.1.1 loaded
[    5.146914] device-mapper: multipath round-robin: version 1.0.0 loaded
[    5.147238] cpuidle: using governor ladder
[    5.147434] cpuidle: using governor menu
[    5.147617] TCP cubic registered
[    5.147695] NET: Registered protocol family 10
[    5.147946] lo: Disabled Privacy Extensions
[    5.148078] NET: Registered protocol family 17
[    5.150815] PM: Resume from disk failed.
[    5.150822] registered taskstats version 1
[    5.151136]   Magic number: 11:931:827
[    5.151308] rtc_cmos 00:03: setting system clock to 2011-01-03 09:50:16 UTC (1294048216)
[    5.151315] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    5.151317] EDD information not available.
[    5.170213] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    5.271176] ata3: SATA link down (SStatus 0 SControl 300)
[    5.281627] ata4: SATA link down (SStatus 0 SControl 300)
[    5.457039] usb 6-1: new low speed USB device using uhci_hcd and address 2
[    5.767048] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.767063] ata2.01: SATA link down (SStatus 0 SControl 300)
[    5.767194] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.767206] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.787870] ata2.00: ATA-8: WDC WD2001FASS-00W2B0, 05.01D05, max UDMA/133
[    5.787875] ata2.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    5.807156] ata1.00: ATA-8: OCZ-VERTEX2, 1.24, max UDMA/133
[    5.807161] ata1.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    5.807195] ata1.01: ATAPI: HL-DT-ST BD-RE  BH10LS30, 1.00, max UDMA/133
[    5.807894] ata2.00: configured for UDMA/133
[    5.847112] ata1.00: configured for UDMA/133
[    5.887096] ata1.01: configured for UDMA/133
[    5.893043] scsi 0:0:0:0: Direct-Access     ATA      OCZ-VERTEX2      1.24 PQ: 0 ANSI: 5
[    5.893215] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.902077] scsi 0:0:1:0: CD-ROM            HL-DT-ST BD-RE  BH10LS30  1.00 PQ: 0 ANSI: 5
[    5.902130] sd 0:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/223 GiB)
[    5.941542] sd 0:0:0:0: [sda] Write Protect is off
[    5.941547] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.943814] sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
[    5.943818] Uniform CD-ROM driver Revision: 3.20
[    5.943907] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.943962] sr 0:0:1:0: Attached scsi CD-ROM sr0
[    5.944004] sr 0:0:1:0: Attached scsi generic sg1 type 5
[    5.944030]  sda:
[    5.944186] scsi 1:0:0:0: Direct-Access     ATA      WDC WD2001FASS-0 05.0 PQ: 0 ANSI: 5
[    5.944289]  sda1 sda2
[    5.944347] sd 1:0:0:0: Attached scsi generic sg2 type 0
[    5.944395] sd 1:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[    5.944449] sd 1:0:0:0: [sdb] Write Protect is off
[    5.944452] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.944467] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.944584] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.944597]  sdb: sdb1 sdb2 sdb3
[    5.983532] sd 1:0:0:0: [sdb] Attached SCSI disk
[    5.983630] Freeing unused kernel memory: 908k freed
[    5.983763] Write protecting the kernel read-only data: 10240k
[    5.984389] Freeing unused kernel memory: 412k freed
[    5.987217] Freeing unused kernel memory: 1644k freed
[    6.001252] udev[155]: starting version 163
[    6.045611] ahci 0000:05:00.0: version 3.0
[    6.045629] ahci 0000:05:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    6.045721] ahci 0000:05:00.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
[    6.045724] ahci 0000:05:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
[    6.045729] ahci 0000:05:00.0: setting latency timer to 64
[    6.045828] scsi4 : ahci
[    6.045882] scsi5 : ahci
[    6.045948] ata5: SATA max UDMA/133 abar m512@0xfbdffc00 port 0xfbdffd00 irq 16
[    6.045951] ata6: SATA max UDMA/133 abar m512@0xfbdffc00 port 0xfbdffd80 irq 16
[    6.050126] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    6.050136] r8169 0000:07:01.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
[    6.050207] r8169 0000:07:01.0: (unregistered net_device): no PCI Express capability
[    6.050223] usbcore: registered new interface driver hiddev
[    6.050676] r8169 0000:07:01.0: eth0: RTL8169sc/8110sc at 0xffffc90001870c00, bc:ae:c5:19:e7:49, XID 18000000 IRQ 19
[    6.067600] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.0/input/input3
[    6.067658] generic-usb 0003:046D:C50E.0001: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:1d.0-1/input0
[    6.067696] usbcore: registered new interface driver usbhid
[    6.067697] usbhid: USB HID core driver
[    6.279197] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    6.386723] ata5: SATA link down (SStatus 0 SControl 300)
[    6.386762] ata6: SATA link down (SStatus 0 SControl 300)
[    6.507972] Adding 29296636k swap on /dev/sdb2.  Priority:-1 extents:1 across:29296636k 
[    6.544174] udev[442]: starting version 163
[    6.879390]   alloc irq_desc for 29 on node -1
[    6.879392]   alloc kstat_irqs on node -1
[    6.881848] xhci_hcd 0000:02:00.0: PCI INT A -> GSI 29 (level, low) -> IRQ 29
[    6.882034] xhci_hcd 0000:02:00.0: setting latency timer to 64
[    6.882037] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    6.882087] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 9
[    6.882198] xhci_hcd 0000:02:00.0: irq 29, io mem 0xf7ffe000
[    6.885562] usb usb9: No SuperSpeed endpoint companion for config 1  interface 0 altsetting 0 ep 129: using minimum values
[    6.885612] xHCI xhci_add_endpoint called for root hub
[    6.885614] xHCI xhci_check_bandwidth called for root hub
[    6.885648] hub 9-0:1.0: USB hub found
[    6.885651] hub 9-0:1.0: 4 ports detected
[    6.984134]   alloc irq_desc for 22 on node -1
[    6.984136]   alloc kstat_irqs on node -1
[    6.984142] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[    6.984229]   alloc irq_desc for 70 on node -1
[    6.984231]   alloc kstat_irqs on node -1
[    6.984240] HDA Intel 0000:00:1b.0: irq 70 for MSI/MSI-X
[    6.984261] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    6.989881] firewire_ohci 0000:07:02.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    6.995511] EDAC MC: Ver: 2.1.0 Nov 24 2010
[    6.998740] PCI: Discovered peer bus ff
[    7.105687] nvidia: module license 'NVIDIA' taints kernel.
[    7.105690] Disabling lock debugging due to kernel taint
[    7.122434] lp: driver loaded but no devices found
[    7.147326] firewire_ohci: Added fw-ohci device 0000:07:02.0, OHCI v1.10, 4 IR + 8 IT contexts, quirks 0x1
[    7.245328] type=1400 audit(1294048218.576:2): apparmor="STATUS" operation="profile_load" name="/sbin/dhclient3" pid=873 comm="apparmor_parser"
[    7.245673] type=1400 audit(1294048218.576:3): apparmor="STATUS" operation="profile_load" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=873 comm="apparmor_parser"
[    7.245860] type=1400 audit(1294048218.576:4): apparmor="STATUS" operation="profile_load" name="/usr/lib/connman/scripts/dhclient-script" pid=873 comm="apparmor_parser"
[    7.264869] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    7.312413] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: errors=remount-ro
[    7.452366]   alloc irq_desc for 24 on node -1
[    7.452369]   alloc kstat_irqs on node -1
[    7.452375] nvidia 0000:03:00.0: PCI INT A -> GSI 24 (level, low) -> IRQ 24
[    7.452381] nvidia 0000:03:00.0: setting latency timer to 64
[    7.452384] vgaarb: device changed decodes: PCI:0000:03:00.0,olddecodes=io+mem,decodes=none:owns=io+mem
[    7.452825] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  260.19.06  Mon Sep 13 04:29:19 PDT 2010
[    7.626328] firewire_core: created device fw0: GUID 001fc600000710d5, S400
[    7.629607] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
[    7.692308] EXT4-fs (sdb3): mounted filesystem with ordered data mode. Opts: (null)
[    7.713497] type=1400 audit(1294048219.046:5): apparmor="STATUS" operation="profile_load" name="/usr/share/gdm/guest-session/Xsession" pid=1027 comm="apparmor_parser"
[    7.713640] type=1400 audit(1294048219.046:6): apparmor="STATUS" operation="profile_replace" name="/sbin/dhclient3" pid=1028 comm="apparmor_parser"
[    7.714066] type=1400 audit(1294048219.046:7): apparmor="STATUS" operation="profile_replace" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=1028 comm="apparmor_parser"
[    7.714307] type=1400 audit(1294048219.046:8): apparmor="STATUS" operation="profile_replace" name="/usr/lib/connman/scripts/dhclient-script" pid=1028 comm="apparmor_parser"
[    7.714569] type=1400 audit(1294048219.046:9): apparmor="STATUS" operation="profile_load" name="/usr/lib/cups/backend/cups-pdf" pid=1031 comm="apparmor_parser"
[    7.715019] type=1400 audit(1294048219.046:10): apparmor="STATUS" operation="profile_load" name="/usr/sbin/tcpdump" pid=1032 comm="apparmor_parser"
[    7.715114] type=1400 audit(1294048219.046:11): apparmor="STATUS" operation="profile_load" name="/usr/sbin/cupsd" pid=1031 comm="apparmor_parser"
[    7.725005] r8169 0000:07:01.0: eth0: link up
[    8.256659] hda_codec: ALC892: BIOS auto-probing.
[    8.261951] Too many connections
[    8.263269]   alloc irq_desc for 34 on node -1
[    8.263271]   alloc kstat_irqs on node -1
[    8.263278] HDA Intel 0000:03:00.1: PCI INT B -> GSI 34 (level, low) -> IRQ 34
[    8.263279] hda_intel: Disable MSI for Nvidia chipset
[    8.263387] HDA Intel 0000:03:00.1: setting latency timer to 64
[    8.263438] EDAC MC0: Giving out device to 'i7core_edac.c' 'i7 core #0': DEV 0000:ff:03.0
[    8.263456] EDAC PCI0: Giving out device to module 'i7core_edac' controller 'EDAC PCI controller': DEV '0000:ff:03.0' (POLLED)
[    8.263458] EDAC i7core: Driver loaded.

--=-LkTDHN8zF1doh5qupEd5
Content-Disposition: attachment; filename="lsmod.txt"
Content-Type: text/plain; name="lsmod.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

joris@Asus5:~$ lsmod
Module                  Size  Used by
parport_pc             30086  0 
ppdev                   6804  0 
snd_hda_codec_nvhdmi    15451  4 
binfmt_misc             7984  1 
vboxnetadp              5267  0 
vboxnetflt             14966  0 
vboxdrv              1792472  2 vboxnetadp,vboxnetflt
snd_hda_codec_realtek   299524  1 
nvidia              10221046  38 
lp                     10201  0 
asus_atk0110           12987  0 
i7core_edac            18090  0 
edac_core              46822  3 i7core_edac
parport                37032  3 parport_pc,ppdev,lp
firewire_ohci          24679  0 
snd_hda_intel          26019  1 
snd_hda_codec         100919  3 snd_hda_codec_nvhdmi,snd_hda_codec_realtek,snd_hda_intel
snd_hwdep               6660  1 snd_hda_codec
snd_pcm                89104  2 snd_hda_intel,snd_hda_codec
snd_seq_midi            5932  0 
snd_rawmidi            22207  1 snd_seq_midi
snd_seq_midi_event      7291  1 snd_seq_midi
snd_seq                57512  2 snd_seq_midi,snd_seq_midi_event
xhci_hcd               58578  0 
snd_timer              23850  2 snd_pcm,snd_seq
snd_seq_device          6912  3 snd_seq_midi,snd_rawmidi,snd_seq
snd                    64117  11 snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore               1240  1 snd
snd_page_alloc          8588  2 snd_hda_intel,snd_pcm
r8169                  42222  0 
usbhid                 42062  0 
firewire_core          54327  1 firewire_ohci
ahci                   21857  0 
libahci                26199  1 ahci
mii                     5261  1 r8169
hid                    84678  1 usbhid
crc_itu_t               1739  1 firewire_core
joris@Asus5:~$ 


--=-LkTDHN8zF1doh5qupEd5
Content-Disposition: attachment; filename="sensors-detect.txt"
Content-Type: text/plain; name="sensors-detect.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

joris@Asus5:~$ sudo sensors-detect
[sudo] password for joris: 
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# System: System manufacturer System Product Name
# Board: ASUSTeK Computer INC. SABERTOOTH X58

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
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Winbond W83667HG Super IO Sensors'                   Success!
    (address 0x290, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
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
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): 

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): 
Using driver `i2c-i801' for device 0000:00:1f.3: Intel ICH10
Module i2c-i801 loaded successfully.
Module i2c-dev loaded successfully.

Next adapter: NVIDIA i2c adapter  (i2c-0)
Do you want to scan it? (YES/no/selectively): 

Next adapter: NVIDIA i2c adapter  (i2c-1)
Do you want to scan it? (YES/no/selectively): 

Next adapter: NVIDIA i2c adapter  (i2c-2)
Do you want to scan it? (YES/no/selectively): 

Next adapter: NVIDIA i2c adapter  (i2c-3)
Do you want to scan it? (YES/no/selectively): 

Next adapter: NVIDIA i2c adapter  (i2c-4)
Do you want to scan it? (YES/no/selectively): 

Next adapter: NVIDIA i2c adapter  (i2c-5)
Do you want to scan it? (YES/no/selectively): 

Next adapter: NVIDIA i2c adapter  (i2c-6)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter: NVIDIA i2c adapter  (i2c-7)
Do you want to scan it? (YES/no/selectively): 

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `w83627ehf':
  * ISA bus, address 0x290
    Chip `Winbond W83667HG Super IO Sensors' (confidence: 9)

Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
coretemp
w83627ehf
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)

Unloading i2c-dev... OK
Unloading i2c-i801... OK

joris@Asus5:~$ 


--=-LkTDHN8zF1doh5qupEd5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-LkTDHN8zF1doh5qupEd5--

