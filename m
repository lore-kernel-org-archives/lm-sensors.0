From: Raivo Kask <raivo.kask@zerone.se>
Date: Wed, 30 May 2007 13:17:09 +0000
Subject: [lm-sensors] ASUS M2NPV-VM problems
Message-Id: <465D7955.7060307@zerone.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

My configuration looks like this:

MB:         ASUS M2NPV-VM
CPU:        AMD 64 X2 Dual Core Processor 4800+
OS:         Ubuntu 7.04 (Linux 2.6.20-16-generic #2 SMP)
lm_sensors: 1:2.10.1-2ubuntu2 (feisy)

I have spent many hours to get it working (scanning all forums and=20
documentation) ... but I am lost.
Hope someone can sort it our for me.
Here is what I get from sensors output and it looks strange to me ...

    - why are there 2 temps for Core0 and Core1
    - what is temp1/2/3
    - should VID be =3D 0.000 V

I have also included:

    - section of sensors.conf
    - dmesg output
    - lsmod output
    - sensors-detect output

Thanks in advance
/raivo





1) sensors output:
---------------------------------------------------------------------------=
--------
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
              +29=B0C
Core0 Temp:
              +28=B0C
Core1 Temp:
              +24=B0C
Core1 Temp:
              +29=B0C

it8716-isa-0290
Adapter: ISA adapter
VCore:     +1.23 V  (min =3D  +0.00 V, max =3D  +4.08 V)
3.3V:      +3.25 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in2:       +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
5V:        +4.73 V  (min =3D  +0.00 V, max =3D  +6.85 V)
12V:      +11.58 V  (min =3D  +0.00 V, max =3D +16.32 V)
in5:       +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in6:       +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
5VSB:      +4.62 V  (min =3D  +0.00 V, max =3D  +6.85 V)
VBat:      +2.85 V
CPU_PWM:  1717 RPM  (min =3D 3245 RPM)                   ALARM
Rear   :     0 RPM  (min =3D 3245 RPM)                   ALARM
temp1:       +49=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =3D=
 diode
temp2:       +44=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =3D=
=20
thermistor
temp3:       +25=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =3D=
=20
thermistor
VID:      +0.000 V

2) section of /etc/sensors.conf
---------------------------------------------------------------------------=
--------


chip "it8716-*"

# Voltages

label  in0  "VCore"
label  in1  "3.3V"
label  in3  "5V"
label  in4  "12V"
label  in7  "5VSB"
label  in8  "VBat"

compute in3  ((6.8/10)+1)*@ , @/((6.8/10)+1)
compute in4  ((30/10)+1)*@  , @/((30/10)+1)
compute in7  ((6.8/10)+1)*@ , @/((6.8/10)+1)
  =09
# If vid (nominal CPU voltage) isn't correct, hardcode the correct value
# instead.
#    set in0_min  vid * 0.95
#    set in0_max  vid * 1.05
#    set in2_min  3.3 * 0.95
#    set in2_max  3.3 * 1.05
#    set in3_min    5 * 0.95
#    set in3_max    5 * 1.05
#    set in4_min   12 * 0.95
#    set in4_max   12 * 1.05
#    set in7_min    5 * 0.95
#    set in7_max    5 * 1.05
# The chip does not support in8 min/max
=09
# Temperatures
  =09
# If you are lucky, the BIOS has set the proper sensor types for you.
# If your temperature readings are completely whacky you probably
# need to change the sensor types. Adujst and uncomment the
# appropriate lines below.
#
# 2 =3D thermistor; 3 =3D thermal diode; 0 =3D unused
#   set sensor1  3
#   set sensor2  3
#   set sensor3  3
  =09
# If a given sensor isn't used, you will probably want to ignore it
# as well (see ignore statement right below).
# The CPU sensor can be any of temp1, temp2 or temp3 - it's motherboard
# dependent. Same for the motherboard temperature.
  =09
#   ignore temp3
  =09
#   set temp1_over  60
#   set temp1_low   10
#   set temp2_over  50
#   set temp2_low   10
  =09
# Fans
  =09
# The CPU fan can be any of fan1, fan2 or fan3 - it's motherboard
# dependent. Same for the case fan.
  =09
    label  fan1 "CPU_PWM"
    label  fan2 "Rear   "
    ignore fan3
    label  vid "VID"
#   ignore vid
  =09
#   set fan1_min 2000
#   set fan2_min 2000
  =09
3) dmesg output:
---------------------------------------------------------------------------=
--------

[    0.000000] Linux version 2.6.20-16-generic (root@terranova) (gcc=20
version 4.1.2 (Ubuntu 4.1.2-0ubuntu4)) #2 SMP Wed May 23 01:46:23 UTC=20
2007 (Ubuntu 2.6.20-16.28-generic)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size:=20
000000000009f000 end: 000000000009f000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000000009f000 size:=20
0000000000001000 end: 00000000000a0000 type: 2
[    0.000000] copy_e820_map() start: 00000000000f0000 size:=20
0000000000010000 end: 0000000000100000 type: 2
[    0.000000] copy_e820_map() start: 0000000000100000 size:=20
000000007ddf0000 end: 000000007def0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000007def0000 size:=20
0000000000003000 end: 000000007def3000 type: 4
[    0.000000] copy_e820_map() start: 000000007def3000 size:=20
000000000000d000 end: 000000007df00000 type: 3
[    0.000000] copy_e820_map() start: 000000007e000000 size:=20
0000000002000000 end: 0000000080000000 type: 2
[    0.000000] copy_e820_map() start: 00000000e0000000 size:=20
0000000010000000 end: 00000000f0000000 type: 2
[    0.000000] copy_e820_map() start: 00000000fec00000 size:=20
0000000001400000 end: 0000000100000000 type: 2
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[    0.000000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007def0000 (usable)
[    0.000000]  BIOS-e820: 000000007def0000 - 000000007def3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007def3000 - 000000007df00000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007e000000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] 1118MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f5ab0
[    0.000000] Entering add_active_range(0, 0, 515824) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   515824
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   515824
[    0.000000] On node 0 totalpages: 515824
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 2237 pages used for memmap
[    0.000000]   HighMem zone: 284211 pages, LIFO batch:31
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP (v002 Nvidia                                )=20
@ 0x000f7570
[    0.000000] ACPI: XSDT (v001 Nvidia ASUSACPI 0x42302e31 AWRD=20
0x00000000) @ 0x7def30c0
[    0.000000] ACPI: FADT (v003 Nvidia ASUSACPI 0x42302e31 AWRD=20
0x00000000) @ 0x7defb480
[    0.000000] ACPI: MCFG (v001 Nvidia ASUSACPI 0x42302e31 AWRD=20
0x00000000) @ 0x7defb700
[    0.000000] ACPI: MADT (v001 Nvidia ASUSACPI 0x42302e31 AWRD=20
0x00000000) @ 0x7defb5c0
[    0.000000] ACPI: DSDT (v001 NVIDIA ASUSACPI 0x00001000 MSFT=20
0x03000000) @ 0x00000000
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] If you got timer trouble try acpi_use_timer_override
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] If you got timer trouble try acpi_use_timer_override
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] If you got timer trouble try acpi_use_timer_override
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] If you got timer trouble try acpi_use_timer_override
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:11 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:11 APIC version 16
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI=20
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 0 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 88000000 (gap:=20
80000000:60000000)
[    0.000000] Detected 2505.367 MHz processor.
[   21.092112] Built 1 zonelists.  Total pages: 511795
[   21.092114] Kernel command line:=20
root=3DUUID=0B2f2bd8-86ac-482d-b2c1-17b5643d78f3 ro quiet splash
[   21.092214] mapped APIC to ffffd000 (fee00000)
[   21.092216] mapped IOAPIC to ffffc000 (fec00000)
[   21.092218] Enabling fast FPU save and restore... done.
[   21.092220] Enabling unmasked SIMD FPU exception support... done.
[   21.092225] Initializing CPU#0
[   21.092265] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   21.095047] Console: colour VGA+ 80x25
[   21.095318] Dentry cache hash table entries: 131072 (order: 7, 524288=20
bytes)
[   21.095599] Inode-cache hash table entries: 65536 (order: 6, 262144=20
bytes)
[   21.143333] Memory: 2034540k/2063296k available (1992k kernel code,=20
27464k reserved, 896k data, 328k init, 1145792k highmem)
[   21.143341] virtual kernel memory layout:
[   21.143342]     fixmap  : 0xfff4e000 - 0xfffff000   ( 708 kB)
[   21.143343]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   21.143344]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   21.143345]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   21.143346]       .init : 0xc03d9000 - 0xc042b000   ( 328 kB)
[   21.143347]       .data : 0xc02f2354 - 0xc03d26d4   ( 896 kB)
[   21.143348]       .text : 0xc0100000 - 0xc02f2354   (1992 kB)
[   21.143350] Checking if this processor honours the WP bit even in=20
supervisor mode... Ok.
[   21.220045] Calibrating delay using timer specific routine.. 5014.83=20
BogoMIPS (lpj=10029672)
[   21.220074] Security Framework v1.0.0 initialized
[   21.220079] SELinux:  Disabled at boot.
[   21.220090] Mount-cache hash table entries: 512
[   21.220184] CPU: After generic identify, caps: 178bfbff ebd3fbff=20
00000000 00000000 00002001 00000000 0000011f
[   21.220191] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64=20
bytes/line)
[   21.220193] CPU: L2 Cache: 512K (64 bytes/line)
[   21.220195] CPU 0(2) -> Core 0
[   21.220196] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000=20
00000410 00002001 00000000 0000011f
[   21.220203] Compat vDSO mapped to ffffe000.
[   21.220207] Remapping vsyscall page to ffffe000
[   21.220214] Checking 'hlt' instruction... OK.
[   21.236111] SMP alternatives: switching to UP code
[   21.236388] Early unpacking initramfs... done
[   21.458620] ACPI: Core revision 20060707
[   21.461777] ACPI: Looking for DSDT in initramfs... file /DSDT.aml not=20
found, using machine DSDT.
[   21.466409] CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4800+=20
stepping 01
[   21.466425] SMP alternatives: switching to SMP code
[   21.466488] Booting processor 1/1 eip 3000
[   21.477059] Initializing CPU#1
[   21.555849] Calibrating delay using timer specific routine.. 5010.79=20
BogoMIPS (lpj=10021596)
[   21.555854] CPU: After generic identify, caps: 178bfbff ebd3fbff=20
00000000 00000000 00002001 00000000 0000011f
[   21.555860] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64=20
bytes/line)
[   21.555861] CPU: L2 Cache: 512K (64 bytes/line)
[   21.555863] CPU 1(2) -> Core 1
[   21.555864] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000=20
00000410 00002001 00000000 0000011f
[   21.555623] CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4800+=20
stepping 01
[   21.555635] Total of 2 processors activated (10025.63 BogoMIPS).
[   21.555927] ENABLING IO-APIC IRQs
[   21.556156] ..TIMER: vector=3D0x31 apic1=3D0 pin1=3D0 apic2=3D-1 pin2=3D=
-1
[   21.703193] checking TSC synchronization across 2 CPUs:
[    0.000001] CPU#0 had -200 usecs TSC skew, fixed it up.
[    0.000003] CPU#1 had 200 usecs TSC skew, fixed it up.
[    0.003995] Brought up 2 CPUs
[    0.029606] migration_cost=190
[    0.029791] Booting paravirtualized kernel on bare hardware
[    0.029851] Time:  7:26:13  Date: 04/30/107
[    0.029874] NET: Registered protocol family 16
[    0.029934] EISA bus registered
[    0.029936] ACPI: bus type pci registered
[    0.036231] PCI: PCI BIOS revision 3.00 entry at 0xf1ff0, last bus=3D4
[    0.036232] PCI: Using configuration type 1
[    0.036233] Setting up standard PCI resources
[    0.046489] ACPI: Interpreter enabled
[    0.046491] ACPI: Using IOAPIC for interrupt routing
[    0.046937] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.046941] PCI: Probing PCI hardware (bus 00)
[    0.048876] Boot video device is 0000:00:05.0
[    0.049534] PCI: Transparent bridge - 0000:00:10.0
[    0.049562] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.138043] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[    0.143812] ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15)=20
*0, disabled.
[    0.144193] ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15)=20
*0, disabled.
[    0.144570] ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15)=20
*0, disabled.
[    0.144949] ACPI: PCI Interrupt Link [LNK4] (IRQs *5 7 9 10 11 14 15)
[    0.145327] ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15)=20
*0, disabled.
[    0.145708] ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15)=20
*0, disabled.
[    0.146085] ACPI: PCI Interrupt Link [LNK7] (IRQs *5 7 9 10 11 14 15)
[    0.146466] ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15)=20
*0, disabled.
[    0.146845] ACPI: PCI Interrupt Link [LUBA] (IRQs *5 7 9 10 11 14 15)
[    0.147222] ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15)=20
*0, disabled.
[    0.147601] ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 10 *11 14 15)
[    0.147980] ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 11 14 15)=20
*0, disabled.
[    0.148357] ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 *11 14 15)
[    0.148732] ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15)=20
*0, disabled.
[    0.149109] ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15)=20
*0, disabled.
[    0.149485] ACPI: PCI Interrupt Link [LSMB] (IRQs *5 7 9 10 11 14 15)
[    0.149861] ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 *11 14 15)
[    0.150237] ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15)=20
*0, disabled.
[    0.150614] ACPI: PCI Interrupt Link [LSID] (IRQs *5 7 9 10 11 14 15)
[    0.150993] ACPI: PCI Interrupt Link [LFID] (IRQs *5 7 9 10 11 14 15)
[    0.151429] ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
[    0.151861] ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
[    0.152290] ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
[    0.152719] ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
[    0.153149] ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
[    0.153579] ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
[    0.154008] ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
[    0.154438] ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
[    0.154869] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.155299] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.155733] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.156168] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.156598] ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.157027] ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.157458] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.157888] ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.158318] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.158748] ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.159177] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.159607] ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.160040] ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0,=20
disabled.
[    0.160319] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.160326] pnp: PnP ACPI init
[    0.168962] pnp: PnP ACPI: found 14 devices
[    0.168965] PnPBIOS: Disabled by ACPI PNP
[    0.169004] PCI: Using ACPI for IRQ routing
[    0.169007] PCI: If a device doesn't work, try "pci=3Drouteirq".  If it =

helps, post a report
[    0.245728] NET: Registered protocol family 8
[    0.245729] NET: Registered protocol family 20
[    0.246149] pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
[    0.246151] pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
[    0.246153] pnp: 00:01: ioport range 0x4400-0x447f has been reserved
[    0.246155] pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
[    0.246157] pnp: 00:01: ioport range 0x4800-0x487f has been reserved
[    0.246159] pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
[    0.246161] pnp: 00:01: ioport range 0x2000-0x207f has been reserved
[    0.246163] pnp: 00:01: ioport range 0x2080-0x20ff has been reserved
[    0.246357] PCI: Bridge: 0000:00:02.0
[    0.246359]   IO window: a000-afff
[    0.246361]   MEM window: fd800000-fd8fffff
[    0.246363]   PREFETCH window: fd700000-fd7fffff
[    0.246365] PCI: Bridge: 0000:00:03.0
[    0.246367]   IO window: 8000-8fff
[    0.246369]   MEM window: fde00000-fdefffff
[    0.246371]   PREFETCH window: fdd00000-fddfffff
[    0.246373] PCI: Bridge: 0000:00:04.0
[    0.246375]   IO window: b000-bfff
[    0.246377]   MEM window: fdc00000-fdcfffff
[    0.246379]   PREFETCH window: fd900000-fd9fffff
[    0.246381] PCI: Bridge: 0000:00:10.0
[    0.246383]   IO window: 9000-9fff
[    0.246385]   MEM window: fdb00000-fdbfffff
[    0.246388]   PREFETCH window: fda00000-fdafffff
[    0.246397] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    0.246402] PCI: Setting latency timer of device 0000:00:03.0 to 64
[    0.246407] PCI: Setting latency timer of device 0000:00:04.0 to 64
[    0.246413] PCI: Setting latency timer of device 0000:00:10.0 to 64
[    0.246441] NET: Registered protocol family 2
[    0.287533] IP route cache hash table entries: 32768 (order: 5,=20
131072 bytes)
[    0.287652] TCP established hash table entries: 131072 (order: 8,=20
1048576 bytes)
[    0.288212] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.288447] TCP: Hash tables configured (established 131072 bind 65536)
[    0.288449] TCP reno registered
[    0.303546] checking if image is initramfs... it is
[    0.741988] Freeing initrd memory: 6781k freed
[    1.256000] audit: initializing netlink socket (disabled)
[    1.256000] audit(1180509973.440:1): initialized
[    1.256000] highmem bounce pool size: 64 pages
[    1.256000] VFS: Disk quotas dquot_6.5.1
[    1.256000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.256000] io scheduler noop registered
[    1.256000] io scheduler anticipatory registered
[    1.256000] io scheduler deadline registered
[    1.256000] io scheduler cfq registered (default)
[    1.276000] PCI: Setting latency timer of device 0000:00:02.0 to 64
[    1.276000] assign_interrupt_mode Found MSI capability
[    1.276000] Allocate Port Service[0000:00:02.0:pcie00]
[    1.276000] PCI: Setting latency timer of device 0000:00:03.0 to 64
[    1.276000] assign_interrupt_mode Found MSI capability
[    1.276000] Allocate Port Service[0000:00:03.0:pcie00]
[    1.276000] PCI: Setting latency timer of device 0000:00:04.0 to 64
[    1.276000] assign_interrupt_mode Found MSI capability
[    1.276000] Allocate Port Service[0000:00:04.0:pcie00]
[    1.276000] isapnp: Scanning for PnP cards...
[    1.628000] isapnp: No Plug & Play device found
[    1.644000] Real Time Clock Driver v1.12ac
[    1.644000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ=20
sharing enabled
[    1.644000] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.644000] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[    1.644000] 00:08: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    1.644000] 00:09: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[    1.644000] mice: PS/2 mouse device common for all mice
[    1.644000] RAMDISK driver initialized: 16 RAM disks of 65536K size=20
1024 blocksize
[    1.648000] input: Macintosh mouse button emulation as=20
/class/input/input0
[    1.648000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    1.648000] ide: Assuming 33MHz system bus speed for PIO modes;=20
override with idebus=3Dxx
[    1.648000] PNP: No PS/2 controller found. Probing ports directly.
[    1.648000] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.648000] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.648000] EISA: Probing bus 0 at eisa.0
[    1.648000] Cannot allocate resource for EISA slot 2
[    1.648000] Cannot allocate resource for EISA slot 4
[    1.648000] Cannot allocate resource for EISA slot 8
[    1.648000] EISA: Detected 0 cards.
[    1.676000] TCP cubic registered
[    1.676000] NET: Registered protocol family 1
[    1.676000] Starting balanced_irq
[    1.676000] Using IPI No-Shortcut mode
[    1.676000] ACPI: (supports S0 S1 S3 S4 S5)
[    1.676000]   Magic number: 7:363:421
[    1.676000] Freeing unused kernel memory: 328k freed
[    1.680000] Time: acpi_pm clocksource has been installed.
[    2.848000] Capability LSM initialized
[    2.876000] ACPI: Fan [FAN] (on)
[    2.880000] ACPI: Thermal Zone [THRM] (40 C)
[    3.280000] SCSI subsystem initialized
[    3.296000] libata version 2.20 loaded.
[    3.300000] sata_nv 0000:00:0e.0: version 3.3
[    3.300000] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
[    3.300000] ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI=20
23 (level, low) -> IRQ 16
[    3.300000] PCI: Setting latency timer of device 0000:00:0e.0 to 64
[    3.300000] ata1: SATA max UDMA/133 cmd 0x000109f0 ctl 0x00010bf2=20
bmdma 0x0001e000 irq 16
[    3.300000] ata2: SATA max UDMA/133 cmd 0x00010970 ctl 0x00010b72=20
bmdma 0x0001e008 irq 16
[    3.300000] scsi0 : sata_nv
[    3.344000] usbcore: registered new interface driver usbfs
[    3.344000] usbcore: registered new interface driver hub
[    3.344000] usbcore: registered new device driver usb
[    3.348000] ieee1394: Initialized config rom entry `ip1394'
[    3.348000] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller=20
(OHCI) Driver
[    3.352000] forcedeth.c: Reverse Engineered nForce ethernet driver.=20
Version 0.59.
[    3.352000] Floppy drive(s): fd0 is 1.44M
[    3.376000] FDC 0 is a post-1991 82077
[    3.768000] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.784000] ata1.00: ata_hpa_resize 1: sectors =3D 488397168,=20
hpa_sectors =3D 488397168
[    3.784000] ata1.00: ATA-7: SAMSUNG SP2504C, VT100-33, max UDMA7
[    3.784000] ata1.00: 488397168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    3.796000] ata1.00: ata_hpa_resize 1: sectors =3D 488397168,=20
hpa_sectors =3D 488397168
[    3.796000] ata1.00: configured for UDMA/133
[    3.796000] scsi1 : sata_nv
[    4.264000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    4.436000] ata2.00: ATAPI, max UDMA/33
[    4.436000] ata2.00: applying bridge limits
[    4.608000] ata2.00: configured for UDMA/33
[    4.608000] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SP2504C=20
  VT10 PQ: 0 ANSI: 5
[    4.608000] scsi 1:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183A=20
SB02 PQ: 0 ANSI: 5
[    4.608000] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
[    4.608000] ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [APSJ] -> GSI=20
22 (level, low) -> IRQ 17
[    4.608000] PCI: Setting latency timer of device 0000:00:0f.0 to 64
[    4.608000] ata3: SATA max UDMA/133 cmd 0x000109e0 ctl 0x00010be2=20
bmdma 0x0001cc00 irq 17
[    4.608000] ata4: SATA max UDMA/133 cmd 0x00010960 ctl 0x00010b62=20
bmdma 0x0001cc08 irq 17
[    4.608000] scsi2 : sata_nv
[    4.920000] ata3: SATA link down (SStatus 0 SControl 300)
[    4.920000] ATA: abnormal status 0x7F on port 0x000109e7
[    4.924000] scsi3 : sata_nv
[    5.236000] ata4: SATA link down (SStatus 0 SControl 300)
[    5.236000] ATA: abnormal status 0x7F on port 0x00010967
[    5.240000] NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
[    5.240000] NFORCE-MCP51: chipset revision 161
[    5.240000] NFORCE-MCP51: not 100% native mode: will probe irqs later
[    5.240000] NFORCE-MCP51: 0000:00:0d.0 (rev a1) UDMA133 controller
[    5.240000]     ide0: BM-DMA at 0xf400-0xf407, BIOS settings:=20
hda:DMA, hdb:DMA
[    5.240000]     ide1: BM-DMA at 0xf408-0xf40f, BIOS settings:=20
hdc:DMA, hdd:DMA
[    5.240000] Probing IDE interface ide0...
[    5.256000] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[    5.256000] sda: Write Protect is off
[    5.256000] sda: Mode Sense: 00 3a 00 00
[    5.256000] SCSI device sda: write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[    5.256000] SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
[    5.256000] sda: Write Protect is off
[    5.256000] sda: Mode Sense: 00 3a 00 00
[    5.256000] SCSI device sda: write cache: enabled, read cache:=20
enabled, doesn't support DPO or FUA
[    5.256000]  sda: sda1 sda2 < sda5 >
[    5.292000] sd 0:0:0:0: Attached scsi disk sda
[    5.296000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.296000] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    5.304000] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw=20
xa/form2 cdda tray
[    5.304000] Uniform CD-ROM driver Revision: 3.20
[    5.304000] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    5.508000] Attempting manual resume
[    5.508000] swsusp: Resume From Partition 8:5
[    5.508000] PM: Checking swsusp image.
[    5.508000] PM: Resume from disk failed.
[    5.544000] kjournald starting.  Commit interval 5 seconds
[    5.544000] EXT3-fs: mounted filesystem with ordered data mode.
[    5.812000] Probing IDE interface ide1...
[    6.388000] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
[    6.388000] ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCL] -> GSI=20
21 (level, low) -> IRQ 18
[    6.388000] PCI: Setting latency timer of device 0000:00:0b.1 to 64
[    6.388000] ehci_hcd 0000:00:0b.1: EHCI Host Controller
[    6.388000] ehci_hcd 0000:00:0b.1: new USB bus registered, assigned=20
bus number 1
[    6.388000] ehci_hcd 0000:00:0b.1: debug port 1
[    6.388000] PCI: cache line size of 64 is not supported by device=20
0000:00:0b.1
[    6.388000] ehci_hcd 0000:00:0b.1: irq 18, io mem 0xfe02e000
[    6.388000] ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver=20
10 Dec 2004
[    6.388000] usb usb1: configuration #1 chosen from 1 choice
[    6.388000] hub 1-0:1.0: USB hub found
[    6.388000] hub 1-0:1.0: 8 ports detected
[    6.496000] ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
[    6.496000] ACPI: PCI Interrupt 0000:04:05.0[A] -> Link [APC4] -> GSI=20
19 (level, low) -> IRQ 19
[    6.544000] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[19]=20
MMIO=3D[fdbff000-fdbff7ff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/8]
[    6.544000] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
[    6.544000] ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [APCH] -> GSI=20
20 (level, low) -> IRQ 20
[    6.544000] PCI: Setting latency timer of device 0000:00:14.0 to 64
[    6.544000] forcedeth: using HIGHDMA
[    7.068000] eth0: forcedeth.c: subsystem: 01043:816a bound to=20
0000:00:14.0
[    7.068000] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
[    7.068000] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCF] -> GSI=20
23 (level, low) -> IRQ 16
[    7.068000] PCI: Setting latency timer of device 0000:00:0b.0 to 64
[    7.068000] ohci_hcd 0000:00:0b.0: OHCI Host Controller
[    7.068000] ohci_hcd 0000:00:0b.0: new USB bus registered, assigned=20
bus number 2
[    7.068000] ohci_hcd 0000:00:0b.0: irq 16, io mem 0xfe02f000
[    7.128000] usb usb2: configuration #1 chosen from 1 choice
[    7.128000] hub 2-0:1.0: USB hub found
[    7.128000] hub 2-0:1.0: 8 ports detected
[    7.536000] usb 2-3: new low speed USB device using ohci_hcd and=20
address 2
[    7.780000] usb 2-3: configuration #1 chosen from 1 choice
[    7.816000] ieee1394: Host added: ID:BUS[0-00:1023]=20
GUID[0011d8000123f79c]
[    8.088000] usb 2-4: new full speed USB device using ohci_hcd and=20
address 3
[    8.296000] usb 2-4: configuration #1 chosen from 1 choice
[    8.296000] hub 2-4:1.0: USB hub found
[    8.300000] hub 2-4:1.0: 3 ports detected
[    8.724000] usb 2-7: new full speed USB device using ohci_hcd and=20
address 4
[    8.908000] usb 2-7: device descriptor read/64, error -62
[    9.196000] usb 2-7: device descriptor read/64, error -62
[    9.476000] usb 2-7: new full speed USB device using ohci_hcd and=20
address 5
[    9.660000] usb 2-7: device descriptor read/64, error -62
[    9.948000] usb 2-7: device descriptor read/64, error -62
[   10.228000] usb 2-7: new full speed USB device using ohci_hcd and=20
address 6
[   10.644000] usb 2-7: device not accepting address 6, error -62
[   10.820000] usb 2-7: new full speed USB device using ohci_hcd and=20
address 7
[   11.236000] usb 2-7: device not accepting address 7, error -62
[   11.472000] usb 2-4.1: new full speed USB device using ohci_hcd and=20
address 8
[   11.608000] usb 2-4.1: configuration #1 chosen from 1 choice
[   11.844000] usb 2-4.2: new full speed USB device using ohci_hcd and=20
address 9
[   11.968000] usb 2-4.2: configuration #1 chosen from 1 choice
[   12.208000] usb 2-4.3: new full speed USB device using ohci_hcd and=20
address 10
[   12.332000] usb 2-4.3: configuration #1 chosen from 1 choice
[   13.504000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   13.504000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   13.676000] input: PC Speaker as /class/input/input1
[   13.736000] Linux agpgart interface v0.102 (c) Dave Jones
[   13.764000] i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
[   13.764000] i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
[   13.964000] NET: Registered protocol family 17
[   13.992000] parport: PnPBIOS parport detected.
[   13.992000] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
[   14.020000] nvidia: module license 'NVIDIA' taints kernel.
[   14.272000] ACPI: PCI Interrupt Link [APC7] enabled at IRQ 16
[   14.272000] ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APC7] -> GSI=20
16 (level, low) -> IRQ 21
[   14.272000] PCI: Setting latency timer of device 0000:00:05.0 to 64
[   14.272000] Bluetooth: Core ver 2.11
[   14.276000] NET: Registered protocol family 31
[   14.276000] Bluetooth: HCI device and connection manager initialized
[   14.276000] Bluetooth: HCI socket layer initialized
[   14.276000] NVRM: loading NVIDIA UNIX x86 Kernel Module  1.0-9755=20
Mon Feb 26 23:21:15 PST 2007
[   14.312000] usbcore: registered new interface driver hiddev
[   14.328000] Bluetooth: HCI USB driver ver 2.9
[   14.488000] ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 22
[   14.488000] ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [AAZA] -> GSI=20
22 (level, low) -> IRQ 17
[   14.488000] PCI: Setting latency timer of device 0000:00:10.1 to 64
[   14.652000] hiddev96: USB HID v1.10 Device [APC Back-UPS ES 700=20
FW:829.D2.I USB FW:D2] on usb-0000:00:0b.0-3
[   14.728000] input: HID 045e:00bf as /class/input/input2
[   14.728000] input: USB HID v1.11 Keyboard [HID 045e:00bf] on=20
usb-0000:00:0b.0-4.2
[   14.804000] input: HID 045e:00be as /class/input/input3
[   14.804000] input: USB HID v1.11 Mouse [HID 045e:00be] on=20
usb-0000:00:0b.0-4.3
[   14.804000] usbcore: registered new interface driver usbhid
[   14.804000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   14.804000] usbcore: registered new interface driver hci_usb
[   14.876000] usbcore: registered new interface driver xpad
[   14.876000] drivers/usb/input/xpad.c: driver for Xbox controllers v0.1.6
[   15.024000] fuse init (API version 7.8)
[   15.044000] lp0: using parport0 (interrupt-driven).
[   15.376000] it87: Found IT8716F chip at 0x290, revision 1
[   15.376000] it87: in3 is VCC (+5V)
[   15.376000] it87: in7 is VCCH (+5V Stand-By)
[   15.408000] Adding 5984172k swap on=20
/dev/disk/by-uuid/3fdf8305-54a2-41f3-aa06-5e6b82102e55.  Priority:-1=20
extents:1 across:5984172k
[   15.580000] EXT3 FS on sda1, internal journal
[   16.032000] NET: Registered protocol family 10
[   16.032000] lo: Disabled Privacy Extensions
[   21.268000] ibm_acpi: ec object not found
[   21.304000] No dock devices found.
[   21.312000] input: Power Button (FF) as /class/input/input4
[   21.312000] ACPI: Power Button (FF) [PWRF]
[   21.312000] input: Power Button (CM) as /class/input/input5
[   21.312000] ACPI: Power Button (CM) [PWRB]
[   21.364000] Using specific hotkey driver
[   21.400000] pcc_acpi: loading...
[   21.588000] powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core=20
Processor 4800+ processors (version 2.00.00)
[   21.588000] powernow-k8: MP systems not supported by PSB BIOS structure
[   21.588000] powernow-k8: MP systems not supported by PSB BIOS structure
[   25.612000] ppdev: user-space parallel port driver
[   25.892000] apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
[   25.892000] apm: disabled - APM is not SMP safe.
[   26.452000] Bluetooth: L2CAP ver 2.8
[   26.452000] Bluetooth: L2CAP socket layer initialized
[   26.504000] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   26.560000] Bluetooth: RFCOMM socket layer initialized
[   26.560000] Bluetooth: RFCOMM TTY layer initialized
[   26.560000] Bluetooth: RFCOMM ver 1.8
[   31.472000] usb 2-4.2: USB disconnect, address 9
[   31.624000] usb 2-4.3: USB disconnect, address 10
[   38.124000] eth0: no IPv6 routers present
[ 1495.908000] input: Microsoft Five Button Mouse as /class/input/input6
[ 1508.084000] input: Microsoft A keyboard that runs over Bluetooth as=20
/class/input/input7
[15047.344000] eth0: too many iterations (6) in nv_nic_irq.
[15729.028000] input: Microsoft Five Button Mouse as /class/input/input8
[15754.280000] input: Microsoft A keyboard that runs over Bluetooth as=20
/class/input/input9
[16453.008000] input: Microsoft A keyboard that runs over Bluetooth as=20
/class/input/input10

=09
4) lsmod output:
---------------------------------------------------------------------------=
--------

Module                  Size  Used by
snd_rtctimer            4384  0
joydev                 10816  0
binfmt_misc            12680  1
rfcomm                 40856  0
hidp                   20608  4
l2cap                  25728  18 rfcomm,hidp
ppdev                  10116  0
cpufreq_powersave       2688  0
cpufreq_ondemand        9228  0
cpufreq_userspace       5408  0
cpufreq_conservative     8200  0
cpufreq_stats           7360  0
freq_table              5792  2 cpufreq_ondemand,cpufreq_stats
sony_acpi               6284  0
tc1100_wmi              8068  0
dev_acpi               12292  0
pcc_acpi               13184  0
battery                10756  0
button                  8720  0
dock                   10268  0
sbs                    15652  0
asus_acpi              17308  0
container               5248  0
i2c_ec                  6016  1 sbs
backlight               7040  1 asus_acpi
ac                      6020  0
video                  16388  0
ipv6                  268960  17
nls_cp437               6784  0
nls_utf8                3072  7
cifs                  217080  7
it87                   19472  0
hwmon_vid               4224  1 it87
i2c_isa                 6272  1 it87
eeprom                  8336  0
sbp2                   23812  0
lp                     12452  0
fuse                   46612  0
xpad                    9988  0
snd_hda_intel          21912  1
snd_hda_codec         205056  1 snd_hda_intel
snd_pcm_oss            44544  0
snd_mixer_oss          17408  1 snd_pcm_oss
snd_pcm                79876  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_seq_dummy           4740  0
snd_seq_oss            32896  0
snd_seq_midi            9600  0
snd_rawmidi            25472  1 snd_seq_midi
snd_seq_midi_event      8448  2 snd_seq_oss,snd_seq_midi
snd_seq                52592  6=20
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              23684  3 snd_rtctimer,snd_pcm,snd_seq
snd_seq_device          9100  5=20
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
hci_usb                18204  4
usbhid                 26592  1
bluetooth              55908  8 rfcomm,hidp,l2cap,hci_usb
nvidia               6837140  22
parport_pc             36388  1
parport                36936  3 ppdev,lp,parport_pc
hid                    27392  2 hidp,usbhid
analog                 12832  0
af_packet              23816  2
serio_raw               7940  0
psmouse                38920  0
snd                    54020  12=20
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,s=
nd_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore               8672  1 snd
gameport               16520  1 analog
i2c_nforce2             6784  0
k8temp                  6656  0
agpgart                35400  1 nvidia
snd_page_alloc         10888  2 snd_hda_intel,snd_pcm
pcspkr                  4224  0
i2c_core               22656  6=20
i2c_ec,it87,i2c_isa,eeprom,nvidia,i2c_nforce2
shpchp                 34324  0
pci_hotplug            32576  1 shpchp
tsdev                   8768  0
evdev                  11008  3
ext3                  133128  1
jbd                    59816  1 ext3
mbcache                 9604  1 ext3
sg                     36252  0
sr_mod                 17060  0
cdrom                  37664  1 sr_mod
sd_mod                 23428  3
floppy                 59524  0
forcedeth              46728  0
ohci_hcd               22532  0
ohci1394               36528  0
ieee1394              299448  2 sbp2,ohci1394
ehci_hcd               34188  0
amd74xx                15260  0 [permanent]
usbcore               134280  7 xpad,hci_usb,usbhid,ohci_hcd,ehci_hcd
sata_nv                20868  3
ata_generic             9092  0
libata                125720  2 sata_nv,ata_generic
scsi_mod              142348  5 sbp2,sg,sr_mod,sd_mod,libata
generic                 5124  0 [permanent]
thermal                14856  0
processor              31048  1 thermal
fan                     5636  0
fbcon                  42656  0
tileblit                3584  1 fbcon
font                    9216  1 fbcon
bitblit                 6912  1 fbcon
softcursor              3200  1 bitblit
vesafb                  9220  0
capability              5896  0
commoncap               8192  1 capability

5) sensors-detect output:
---------------------------------------------------------------------------=
--------

# sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 0000:00:0a.1: nVidia Corporation=20
nForce4 SMBus (MCP51)

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no):
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: NVIDIA i2c adapter 2 at 0:05.0
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter 1 at 0:05.0
Do you want to scan it? (YES/no/selectively):
Client found at address 0x37
Client found at address 0x3a
Probing for `Philips Semiconductors SAA1064'...             No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Success!
     (confidence 1, driver `eeprom')
Probing for `EDID EEPROM'...                                Success!
     (confidence 8, driver `eeprom'), other addresses: 0x51 0x52 0x53=20
0x54 0x55 0x56 0x57
Probing for `Maxim MAX6900'...                              No

Next adapter: NVIDIA i2c adapter 0 at 0:05.0
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus nForce2 adapter at 4c40
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08

Next adapter: SMBus nForce2 adapter at 4c00
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x52
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x53
Handled by driver `eeprom' (already loaded), chip type `eeprom'

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     Success!
     (confidence 9, driver `k8temp')
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      Yes
Found `ITE IT8716F Super IO Sensors'                        Success!
     (address 0x290, driver `it87')
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `eeprom' (should be inserted):
   Detects correctly:
   * Bus `NVIDIA i2c adapter 1 at 0:05.0'
     Busdriver `UNKNOWN', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55=20
0x56 0x57)
     Chip `EDID EEPROM' (confidence: 8)
   * Bus `SMBus nForce2 adapter at 4c00'
     Busdriver `i2c-nforce2', I2C address 0x52
     Chip `eeprom' (confidence: 6)
   * Bus `SMBus nForce2 adapter at 4c00'
     Busdriver `i2c-nforce2', I2C address 0x53
     Chip `eeprom' (confidence: 6)

   EEPROMs are *NOT* sensors! They are data storage chips commonly
   found on memory modules (SPD), in monitors (EDID), or in some
   laptops, for example.

Driver `k8temp' (should be inserted):
   Detects correctly:
   * ISA bus, undetermined address (Busdriver `i2c-isa')
     Chip `AMD K8 thermal sensors' (confidence: 9)

Driver `it87' (should be inserted):
   Detects correctly:
   * ISA bus address 0x0290 (Busdriver `i2c-isa')
     Chip `ITE IT8716F Super IO Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
# modprobe unknown adapter NVIDIA i2c adapter 0 at 0:05.0
# modprobe unknown adapter NVIDIA i2c adapter 1 at 0:05.0
# modprobe unknown adapter NVIDIA i2c adapter 2 at 0:05.0
i2c-nforce2
# Chip drivers
eeprom
k8temp
it87
#----cut here----


Do you want to add these lines to /etc/modules automatically? (yes/NO)



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
