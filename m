From: Shane Helms <shanehelms0@googlemail.com>
Date: Fri, 13 Mar 2009 11:18:44 +0000
Subject: Re: [lm-sensors] unknown chips/clients
Message-Id: <20090313111844.c306e052.shanehelms0@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090311104958.59769db6.shanehelms0@gmail.com>
In-Reply-To: <20090311104958.59769db6.shanehelms0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

Is there any documentation that could help me figure out these unknown sens=
ors?

Cheers,
Shane

On Wed, 11 Mar 2009 10:49:58 +0000
Shane Helms <shanehelms0@gmail.com> wrote:

> Hi Guys,
>=20
> I used the latest sensors-detect script, and found some unknown chips/cli=
ents.
> Found unknown chip with ID 0x0b00
> Client found at address 0x19
>=20
> I was wondering what they are - one of them is probably my fan.
> You can see them in the sensors-detect output below.
>=20
> Thanks,
> Shane
> --=20
> Shane Helms <shanehelms@gmail.com>
>=20
>=20
> Here are the details:
>=20
> [root@tinybox ~]# uname -a
> Linux tinybox 2.6.28-ARCH #1 SMP PREEMPT Sun Feb 22 11:03:50 UTC 2009 i68=
6 Intel(R) Core(TM) Solo CPU U1400 @ 1.20GHz GenuineIntel GNU/Linux
>=20
> [root@tinybox ~]# pacman -Qs lm_sensors
> local/lm_sensors 3.1.0-1
>=20
> [root@tinybox ~]# sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +60.0=B0C  (crit =3D +100.0=B0C)                 =20
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +26.8=B0C  (crit =3D +100.0=B0C)                 =20
> temp2:       +26.8=B0C  (crit =3D +100.0=B0C)                 =20
>=20
> [root@tinybox ~]# lsmod
> Module                  Size  Used by
> i915                   58372  2=20
> drm                    83880  3 i915
> ipv6                  260340  14=20
> cpufreq_conservative     7944  1=20
> sbs                    12936  0=20
> sbshc                   6656  1 sbs
> nls_cp437               7424  1=20
> vfat                   12800  1=20
> fat                    50720  1 vfat
> btusb                  13464  0=20
> bluetooth              54372  1 btusb
> joydev                 11712  0=20
> pcmcia                 35532  0=20
> uhci_hcd               24592  0=20
> sdhci_pci               9088  0=20
> sdhci                  17028  1 sdhci_pci
> ehci_hcd               36876  0=20
> ohci1394               31280  0=20
> yenta_socket           25996  1=20
> rsrc_nonstatic         13056  1 yenta_socket
> mmc_core               46876  1 sdhci
> iTCO_wdt               12836  0=20
> iTCO_vendor_support     4996  1 iTCO_wdt
> ieee1394               79940  1 ohci1394
> pcmcia_core            34452  3 pcmcia,yenta_socket,rsrc_nonstatic
> sg                     26804  0=20
> intel_agp              27836  1=20
> usbcore               136848  4 btusb,uhci_hcd,ehci_hcd
> agpgart                31572  3 drm,intel_agp
> psmouse                55828  0=20
> serio_raw               7172  0=20
> snd_pcsp               11048  0=20
> video                  18704  0=20
> output                  4608  1 video
> fujitsu_laptop         13960  0=20
> thermal                17180  0=20
> fan                     6276  0=20
> button                  7824  0=20
> battery                12036  0=20
> ac                      6020  0=20
> acpi_cpufreq            9868  0=20
> freq_table              5632  1 acpi_cpufreq
> processor              41388  3 thermal,acpi_cpufreq
> evdev                  11296  13=20
> snd_hda_intel         412980  1=20
> snd_seq_oss            31872  0=20
> snd_seq_midi_event      8192  1 snd_seq_oss
> snd_seq                49968  4 snd_seq_oss,snd_seq_midi_event
> snd_seq_device          8204  2 snd_seq_oss,snd_seq
> snd_hwdep               9092  1 snd_hda_intel
> snd_pcm_oss            40192  0=20
> snd_pcm                70020  3 snd_pcsp,snd_hda_intel,snd_pcm_oss
> snd_timer              21384  2 snd_seq,snd_pcm
> snd_page_alloc         10120  2 snd_hda_intel,snd_pcm
> snd_mixer_oss          16512  2 snd_pcm_oss
> snd                    50852  10 snd_pcsp,snd_hda_intel,snd_seq_oss,snd_s=
eq,snd_seq_device,snd_hwdep,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
> soundcore               8160  2 snd
> arc4                    3712  2=20
> ecb                     4608  2=20
> iwl3945                91128  0=20
> rfkill                 11596  2 iwl3945
> mac80211              161184  1 iwl3945
> led_class               5508  1 iwl3945
> cfg80211               31760  2 iwl3945,mac80211
> sky2                   48132  0=20
> coretemp                7808  0=20
> i2c_i801               10896  0=20
> i2c_core               22804  1 i2c_i801
> rtc_cmos               12332  0=20
> rtc_core               17564  1 rtc_cmos
> rtc_lib                 4480  1 rtc_core
> reiserfs              231424  3=20
> sd_mod                 26904  6=20
> pata_acpi               6016  0=20
> ata_generic             6788  0=20
> ata_piix               23300  5=20
> libata                157856  3 pata_acpi,ata_generic,ata_piix
> scsi_mod              102164  3 sg,sd_mod,libata
>=20
>=20
> [root@tinybox ~]# sensors-detect
> # sensors-detect revision $Revision$
> # System: FUJITSU 0000000000 (laptop)
> # Board: FUJITSU FJNB1B4
>=20
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>=20
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no):=20
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD K10 thermal sensors...                                  No
> Intel Core family thermal sensor...                         Success!
>     (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         No
> VIA C7 thermal and voltage sensors...                       No
>=20
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):=20
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x0b00
>=20
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (YES/no):=20
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
>=20
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no):=20
> Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
> Module i2c-dev loaded successfully.
>=20
> Next adapter: SMBus I801 adapter at 18a0 (i2c-0)
> Do you want to scan it? (YES/no/selectively):=20
> Client found at address 0x0b
> Probing for `Smart Battery'...                              Success!
>     (confidence 5, driver `sbs')
> Client found at address 0x19
> Probing for `Analog Devices ADM1021'...                     No
> Probing for `Analog Devices ADM1021A/ADM1023'...            No
> Probing for `Maxim MAX1617'...                              No
> Probing for `Maxim MAX1617A'...                             No
> Probing for `Maxim MAX1668'...                              No
> Probing for `Maxim MAX1805'...                              No
> Probing for `Maxim MAX1989'...                              No
> Probing for `Maxim MAX6655/MAX6656'...                      No
> Probing for `TI THMC10'...                                  No
> Probing for `National Semiconductor LM84'...                No
> Probing for `Genesys Logic GL523SM'...                      No
> Probing for `Onsemi MC1066'...                              No
> Probing for `Maxim MAX1618'...                              No
> Probing for `Maxim MAX1619'...                              No
> Probing for `National Semiconductor LM82/LM83'...           No
> Probing for `Maxim MAX6654/MAX6690'...                      No
> Probing for `Maxim MAX6680/MAX6681'...                      No
> Probing for `National Semiconductor LM95231'...             No
>=20
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:=20
>=20
> Driver `coretemp':
>   * Chip `Intel Core family thermal sensor' (confidence: 9)
>=20
> Driver `sbs':
>   * Bus `SMBus I801 adapter at 18a0'
>     Busdriver `i2c_i801', I2C address 0x0b
>     Chip `Smart Battery' (confidence: 5)
>=20
> Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):=20
> To load everything that is needed, add this to one of the system
> initialization scripts (e.g. /etc/rc.d/rc.local):
>=20
> #----cut here----
> # Chip drivers
> modprobe coretemp
> modprobe sbs
> /usr/bin/sensors -s
> #----cut here----
>=20
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones! You really
> should try these commands right now to make sure everything is
> working properly. Monitoring programs won't work until the needed
> modules are loaded.
>=20
> Unloading i2c-dev... OK
>=20
>=20
>=20
>=20
> [root@tinybox ~]# lspci -nn
> 00:00.0 Host bridge [0600]: Intel Corporation Mobile 945GM/PM/GMS, 943/94=
0GML and 945GT Express Memory Controller Hub [8086:27a0] (rev 03)
> 00:02.0 VGA compatible controller [0300]: Intel Corporation Mobile 945GM/=
GMS, 943/940GML Express Integrated Graphics Controller [8086:27a2] (rev 03)
> 00:02.1 Display controller [0380]: Intel Corporation Mobile 945GM/GMS/GME=
, 943/940GML Express Integrated Graphics Controller [8086:27a6] (rev 03)
> 00:1b.0 Audio device [0403]: Intel Corporation 82801G (ICH7 Family) High =
Definition Audio Controller [8086:27d8] (rev 02)
> 00:1c.0 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI Exp=
ress Port 1 [8086:27d0] (rev 02)
> 00:1c.1 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI Exp=
ress Port 2 [8086:27d2] (rev 02)
> 00:1c.3 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI Exp=
ress Port 4 [8086:27d6] (rev 02)
> 00:1d.0 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB=
 UHCI Controller #1 [8086:27c8] (rev 02)
> 00:1d.1 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB=
 UHCI Controller #2 [8086:27c9] (rev 02)
> 00:1d.2 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB=
 UHCI Controller #3 [8086:27ca] (rev 02)
> 00:1d.3 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB=
 UHCI Controller #4 [8086:27cb] (rev 02)
> 00:1d.7 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family) USB=
2 EHCI Controller [8086:27cc] (rev 02)
> 00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge [808=
6:2448] (rev e2)
> 00:1f.0 ISA bridge [0601]: Intel Corporation 82801GBM (ICH7-M) LPC Interf=
ace Bridge [8086:27b9] (rev 02)
> 00:1f.1 IDE interface [0101]: Intel Corporation 82801G (ICH7 Family) IDE =
Controller [8086:27df] (rev 02)
> 00:1f.3 SMBus [0c05]: Intel Corporation 82801G (ICH7 Family) SMBus Contro=
ller [8086:27da] (rev 02)
> 02:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8055=
 PCI-E Gigabit Ethernet Controller [11ab:4363] (rev 12)
> 05:00.0 Network controller [0280]: Intel Corporation PRO/Wireless 3945ABG=
 [Golan] Network Connection [8086:4222] (rev 02)
> 08:03.0 CardBus bridge [0607]: Ricoh Co Ltd RL5c476 II [1180:0476] (rev b=
3)
> 08:03.1 FireWire (IEEE 1394) [0c00]: Ricoh Co Ltd R5C552 IEEE 1394 Contro=
ller [1180:0552] (rev 08)
> 08:03.2 SD Host controller [0805]: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSP=
ro Host Adapter [1180:0822] (rev 17)
>=20
>=20
> [root@tinybox ~]# dmesg
> BIOS EBDA/lowmem at: 0009f800/0009f800
> Linux version 2.6.28-ARCH (root@T-POWA-LX) (gcc version 4.3.3 (GCC) ) #1 =
SMP PREEMPT Sun Feb 22 11:03:50 UTC 2009
> KERNEL supported cpus:
>   Intel GenuineIntel
>   AMD AuthenticAMD
>   NSC Geode by NSC
>   Cyrix CyrixInstead
>   Centaur CentaurHauls
>   Transmeta GenuineTMx86
>   Transmeta TransmetaCPU
>   UMC UMC UMC UMC
> PAT WC disabled due to known CPU erratum.
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003f640000 (usable)
>  BIOS-e820: 000000003f640000 - 000000003f655000 (ACPI data)
>  BIOS-e820: 000000003f655000 - 000000003f700000 (ACPI NVS)
>  BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
>  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fed90000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
> DMI 2.4 present.
> Phoenix BIOS detected: BIOS may corrupt low RAM, working it around.
> last_pfn =3D 0x3f640 max_arch_pfn =3D 0x100000
> Scanning 0 areas for low memory corruption
> modified physical RAM map:
>  modified: 0000000000000000 - 0000000000010000 (reserved)
>  modified: 0000000000010000 - 000000000009f800 (usable)
>  modified: 000000000009f800 - 00000000000a0000 (reserved)
>  modified: 00000000000dc000 - 0000000000100000 (reserved)
>  modified: 0000000000100000 - 000000003f640000 (usable)
>  modified: 000000003f640000 - 000000003f655000 (ACPI data)
>  modified: 000000003f655000 - 000000003f700000 (ACPI NVS)
>  modified: 000000003f700000 - 0000000040000000 (reserved)
>  modified: 00000000f8000000 - 00000000fc000000 (reserved)
>  modified: 00000000fec00000 - 00000000fed90000 (reserved)
>  modified: 00000000fee00000 - 00000000fee01000 (reserved)
>  modified: 00000000ff000000 - 0000000100000000 (reserved)
> kernel direct mapping tables up to 377fe000 @ 10000-16000
> RAMDISK: 3f5ad000 - 3f62f6f2
> Allocated new RAMDISK: 00012000 - 000946f2
> Move RAMDISK from 000000003f5ad000 - 000000003f62f6f1 to 00012000 - 00094=
6f1
> ACPI: RSDP 000F58B0, 0014 (r0 FUJ   )
> ACPI: RSDT 3F64DB00, 0048 (r1 FUJ    PC        1170000 FUJ       100)
> ACPI: FACP 3F654F8C, 0074 (r1 FUJ    PC        1170000 FUJ       100)
> ACPI: DSDT 3F64DB50, 661C (r1 FUJ    FJNB1B4   1170000 MSFT  100000E)
> ACPI: FACS 3F655FC0, 0040
> ACPI: MCFG 3F65416C, 003C (r1 FUJ    FJNB1B4   1170000 FUJ       100)
> ACPI: SSDT 3F6541A8, 04DC (r1 FUJ    FJNB1B4   1170000 INTL 20050624)
> ACPI: SSDT 3F654684, 0166 (r1 FUJ    FJNB1B4   1170000 INTL 20050624)
> ACPI: SSDT 3F654B07, 01D0 (r1 FUJ    FJNB1B4   1170000 INTL 20050624)
> ACPI: APIC 3F654D5C, 005A (r1 FUJ    FJNB1B4   1170000  LTP        0)
> ACPI: HPET 3F654DB6, 0038 (r1 FUJ    FJNB1B4   1170000 FUJ       100)
> ACPI: BOOT 3F654DEE, 0028 (r1 FUJ    FJNB1B4   1170000 FUJ       100)
> ACPI: SLIC 3F654E16, 0176 (r1 FUJ    PC        1170000 FUJ       100)
> ACPI: Local APIC address 0xfee00000
> 126MB HIGHMEM available.
> 887MB LOWMEM available.
>   mapped low ram: 0 - 377fe000
>   low ram: 00000000 - 377fe000
>   bootmap 00095000 - 0009bf00
> (9 early reservations) =3D> bootmem [0000000000 - 00377fe000]
>   #0 [0000000000 - 0000001000]   BIOS data page =3D> [0000000000 - 000000=
1000]
>   #1 [0000001000 - 0000002000]    EX TRAMPOLINE =3D> [0000001000 - 000000=
2000]
>   #2 [0000006000 - 0000007000]       TRAMPOLINE =3D> [0000006000 - 000000=
7000]
>   #3 [0000100000 - 000055b520]    TEXT DATA BSS =3D> [0000100000 - 000055=
b520]
>   #4 [000055c000 - 000055f000]    INIT_PG_TABLE =3D> [000055c000 - 000055=
f000]
>   #5 [000009f800 - 0000100000]    BIOS reserved =3D> [000009f800 - 000010=
0000]
>   #6 [0000010000 - 0000012000]          PGTABLE =3D> [0000010000 - 000001=
2000]
>   #7 [0000012000 - 00000946f2]      NEW RAMDISK =3D> [0000012000 - 000009=
46f2]
>   #8 [0000095000 - 000009c000]          BOOTMAP =3D> [0000095000 - 000009=
c000]
> Zone PFN ranges:
>   DMA      0x00000010 -> 0x00001000
>   Normal   0x00001000 -> 0x000377fe
>   HighMem  0x000377fe -> 0x0003f640
> Movable zone start PFN for each node
> early_node_map[2] active PFN ranges
>     0: 0x00000010 -> 0x0000009f
>     0: 0x00000100 -> 0x0003f640
> On node 0 totalpages: 259535
> free_area_init_node: node 0, pgdat c0406600, node_mem_map c1000200
>   DMA zone: 32 pages used for memmap
>   DMA zone: 0 pages reserved
>   DMA zone: 3951 pages, LIFO batch:0
>   Normal zone: 1744 pages used for memmap
>   Normal zone: 221486 pages, LIFO batch:31
>   HighMem zone: 253 pages used for memmap
>   HighMem zone: 32069 pages, LIFO batch:7
>   Movable zone: 0 pages used for memmap
> ACPI: PM-Timer IO Port: 0x1008
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> ACPI: HPET id: 0x8086a201 base: 0xfed00000
> Using ACPI (MADT) for SMP configuration information
> SMP: Allowing 1 CPUs, 0 hotplug CPUs
> PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
> PM: Registered nosave memory: 00000000000a0000 - 00000000000dc000
> PM: Registered nosave memory: 00000000000dc000 - 0000000000100000
> Allocating PCI resources starting at 50000000 (gap: 40000000:b8000000)
> PERCPU: Allocating 36864 bytes of per cpu data
> NR_CPUS: 16, nr_cpu_ids: 1, nr_node_ids 1
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2575=
06
> Kernel command line: root=3D/dev/disk/by-uuid/5097edde-a577-4138-8869-e7c=
eb917fc26 ro vgay1
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 16384 bytes)
> Fast TSC calibration using PIT
> Detected 1196.925 MHz processor.
> Console: colour dummy device 80x25
> console [tty0] enabled
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Scanning for low memory corruption every 60 seconds
> Memory: 1023752k/1038592k available (2228k kernel code, 14004k reserved, =
1026k data, 332k init, 129288k highmem)
> virtual kernel memory layout:
>     fixmap  : 0xffee8000 - 0xfffff000   (1116 kB)
>     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
>     vmalloc : 0xf7ffe000 - 0xff7fe000   ( 120 MB)
>     lowmem  : 0xc0000000 - 0xf77fe000   ( 887 MB)
>       .init : 0xc0433000 - 0xc0486000   ( 332 kB)
>       .data : 0xc032d1b9 - 0xc042db5c   (1026 kB)
>       .text : 0xc0100000 - 0xc032d1b9   (2228 kB)
> Checking if this processor honours the WP bit even in supervisor mode...O=
k.
> SLUB: Genslabs=12, HWalignd, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=
=3D1
> hpet clockevent registered
> HPET: 3 timers in total, 0 timers will be used for per-cpu timer
> Calibrating delay loop (skipped), value calculated using timer frequency.=
. 2394.59 BogoMIPS (lpj989750)
> Security Framework initialized
> Mount-cache hash table entries: 512
> CPU: L1 I cache: 32K, L1 D cache: 32K
> CPU: L2 cache: 2048K
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> using mwait in idle threads.
> Checking 'hlt' instruction... OK.
> SMP alternatives: switching to UP code
> Freeing SMP alternatives: 9k freed
> ACPI: Core revision 20080926
> ACPI: Checking initramfs for custom DSDT
> ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
> CPU0: Intel(R) Core(TM) Solo CPU     U1400  @ 1.20GHz stepping 0c
> Brought up 1 CPUs
> Total of 1 processors activated (2394.59 BogoMIPS).
> net_namespace: 768 bytes
> Booting paravirtualized kernel on bare hardware
> NET: Registered protocol family 16
> ACPI: bus type pci registered
> PCI: MCFG configuration 0: base f8000000 segment 0 buses 0 - 63
> PCI: MCFG area at f8000000 reserved in E820
> PCI: Using MMCONFIG for extended config space
> PCI: Using configuration type 1 for base access
> ACPI: EC: Look up EC in DSDT
> ACPI: SSDT 3F6555C3, 0893 (r1 FUJ    FJNB1B4   1170000 INTL 20050624)
> ACPI: Interpreter enabled
> ACPI: (supports S0 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> ACPI: EC: GPE =3D 0x17, I/O: command/status =3D 0x66, data =3D 0x62
> ACPI: EC: driver started in poll mode
> ACPI: No dock devices found.
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> pci 0000:00:02.0: reg 10 32bit mmio: [0xf0300000-0xf037ffff]
> pci 0000:00:02.0: reg 14 io port: [0x1800-0x1807]
> pci 0000:00:02.0: reg 18 32bit mmio: [0xe0000000-0xefffffff]
> pci 0000:00:02.0: reg 1c 32bit mmio: [0xf0400000-0xf043ffff]
> pci 0000:00:02.1: reg 10 32bit mmio: [0xf0380000-0xf03fffff]
> pci 0000:00:1b.0: reg 10 64bit mmio: [0xf0640000-0xf0643fff]
> pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:1b.0: PME# disabled
> pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:1c.0: PME# disabled
> pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
> pci 0000:00:1c.1: PME# disabled
> pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> pci 0000:00:1c.3: PME# disabled
> pci 0000:00:1d.0: reg 20 io port: [0x1820-0x183f]
> pci 0000:00:1d.1: reg 20 io port: [0x1840-0x185f]
> pci 0000:00:1d.2: reg 20 io port: [0x1860-0x187f]
> pci 0000:00:1d.3: reg 20 io port: [0x1880-0x189f]
> pci 0000:00:1d.7: reg 10 32bit mmio: [0xf0644000-0xf06443ff]
> pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
> pci 0000:00:1d.7: PME# disabled
> pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
> pci 0000:00:1f.0: quirk: region 1180-11bf claimed by ICH6 GPIO
> pci 0000:00:1f.1: reg 10 io port: [0x00-0x07]
> pci 0000:00:1f.1: reg 14 io port: [0x00-0x03]
> pci 0000:00:1f.1: reg 18 io port: [0x00-0x07]
> pci 0000:00:1f.1: reg 1c io port: [0x00-0x03]
> pci 0000:00:1f.1: reg 20 io port: [0x1810-0x181f]
> pci 0000:00:1f.3: reg 20 io port: [0x18a0-0x18bf]
> pci 0000:02:00.0: reg 10 64bit mmio: [0xf0000000-0xf0003fff]
> pci 0000:02:00.0: reg 18 io port: [0x2000-0x20ff]
> pci 0000:02:00.0: reg 30 32bit mmio: [0x000000-0x01ffff]
> pci 0000:02:00.0: supports D1 D2
> pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:02:00.0: PME# disabled
> pci 0000:00:1c.0: bridge io port: [0x2000-0x2fff]
> pci 0000:00:1c.0: bridge 32bit mmio: [0xf0000000-0xf00fffff]
> pci 0000:00:1c.1: bridge io port: [0x00-0xfff]
> pci 0000:00:1c.1: bridge 32bit mmio: [0x000000-0x0fffff]
> pci 0000:00:1c.1: bridge 64bit mmio pref: [0x000000-0x0fffff]
> pci 0000:05:00.0: reg 10 32bit mmio: [0xf0100000-0xf0100fff]
> pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
> pci 0000:05:00.0: PME# disabled
> pci 0000:00:1c.3: bridge 32bit mmio: [0xf0100000-0xf01fffff]
> pci 0000:08:03.0: reg 10 32bit mmio: [0x000000-0x000fff]
> pci 0000:08:03.0: supports D1 D2
> pci 0000:08:03.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:08:03.0: PME# disabled
> pci 0000:08:03.1: reg 10 32bit mmio: [0xf0200000-0xf02007ff]
> pci 0000:08:03.1: supports D1 D2
> pci 0000:08:03.1: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:08:03.1: PME# disabled
> pci 0000:08:03.2: reg 10 32bit mmio: [0xf0200800-0xf02008ff]
> pci 0000:08:03.2: supports D1 D2
> pci 0000:08:03.2: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:08:03.2: PME# disabled
> pci 0000:00:1e.0: transparent bridge
> pci 0000:00:1e.0: bridge 32bit mmio: [0xf0200000-0xf02fffff]
> bus 00 -> node 0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
> ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
> ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
> ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *11 12 14 15)
> PCI: Using ACPI for IRQ routing
> pci 0000:00:1c.1: BAR 7: can't allocate resource
> pci 0000:00:1c.1: BAR 8: can't allocate resource
> pci 0000:00:1c.1: BAR 9: can't allocate resource
> NetLabel: Initializing
> NetLabel:  domain hash size =3D 128
> NetLabel:  protocols =3D UNLABELED CIPSOv4
> NetLabel:  unlabeled traffic allowed by default
> pnp: PnP ACPI init
> ACPI: bus type pnp registered
> pnp: PnP ACPI: found 10 devices
> ACPI: ACPI bus type pnp unregistered
> system 00:00: iomem range 0xf8000000-0xfbffffff has been reserved
> system 00:02: ioport range 0x4d0-0x4d1 has been reserved
> system 00:02: ioport range 0x800-0x80f has been reserved
> system 00:02: ioport range 0x1000-0x107f has been reserved
> system 00:02: ioport range 0x1080-0x10ff has been reserved
> system 00:02: ioport range 0x1100-0x111f has been reserved
> system 00:02: ioport range 0x1180-0x11bf has been reserved
> system 00:02: ioport range 0xf800-0xf87f has been reserved
> system 00:02: ioport range 0xf880-0xf8ff has been reserved
> system 00:02: ioport range 0xfc00-0xfc7f has been reserved
> system 00:02: ioport range 0xfc80-0xfcff has been reserved
> system 00:02: ioport range 0xfd0c-0xfd7f has been reserved
> system 00:02: ioport range 0xfe00-0xfe01 has been reserved
> system 00:02: iomem range 0xf8000000-0xfbffffff has been reserved
> system 00:02: iomem range 0xfed14000-0xfed17fff has been reserved
> system 00:02: iomem range 0xfed18000-0xfed18fff has been reserved
> system 00:02: iomem range 0xfed19000-0xfed19fff has been reserved
> system 00:02: iomem range 0xfed1c000-0xfed1ffff has been reserved
> system 00:02: iomem range 0xfed20000-0xfed3ffff has been reserved
> system 00:02: iomem range 0xfed45000-0xfed8ffff has been reserved
> system 00:02: iomem range 0xfec00000-0xfec00fff has been reserved
> system 00:02: iomem range 0xfee00000-0xfee00fff has been reserved
> system 00:02: iomem range 0xfef00000-0xfeffffff has been reserved
> system 00:02: iomem range 0xcec00-0xcefff has been reserved
> system 00:02: iomem range 0xffb00000-0xffbfffff has been reserved
> system 00:02: iomem range 0xfed40000-0xfed44fff has been reserved
> system 00:09: iomem range 0xfed00000-0xfed003ff has been reserved
> pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
> pci 0000:00:1c.0:   IO window: 0x2000-0x2fff
> pci 0000:00:1c.0:   MEM window: 0xf0000000-0xf00fffff
> pci 0000:00:1c.0:   PREFETCH window: 0x00000054000000-0x000000540fffff
> pci 0000:00:1c.1: PCI bridge, secondary bus 0000:03
> pci 0000:00:1c.1:   IO window: disabled
> pci 0000:00:1c.1:   MEM window: disabled
> pci 0000:00:1c.1:   PREFETCH window: disabled
> pci 0000:00:1c.3: PCI bridge, secondary bus 0000:05
> pci 0000:00:1c.3:   IO window: disabled
> pci 0000:00:1c.3:   MEM window: 0xf0100000-0xf01fffff
> pci 0000:00:1c.3:   PREFETCH window: disabled
> pci 0000:08:03.0: CardBus bridge, secondary bus 0000:09
> pci 0000:08:03.0:   IO window: 0x003000-0x0030ff
> pci 0000:08:03.0:   IO window: 0x003400-0x0034ff
> pci 0000:08:03.0:   PREFETCH window: 0x50000000-0x53ffffff
> pci 0000:08:03.0:   MEM window: 0x58000000-0x5bffffff
> pci 0000:00:1e.0: PCI bridge, secondary bus 0000:08
> pci 0000:00:1e.0:   IO window: 0x3000-0x3fff
> pci 0000:00:1e.0:   MEM window: 0xf0200000-0xf02fffff
> pci 0000:00:1e.0:   PREFETCH window: 0x00000050000000-0x00000053ffffff
> pci 0000:00:1c.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
> pci 0000:00:1c.0: setting latency timer to 64
> pci 0000:00:1c.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
> pci 0000:00:1c.1: setting latency timer to 64
> pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
> pci 0000:00:1c.3: setting latency timer to 64
> pci 0000:00:1e.0: setting latency timer to 64
> pci 0000:08:03.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> bus: 00 index 0 io port: [0x00-0xffff]
> bus: 00 index 1 mmio: [0x000000-0xffffffff]
> bus: 02 index 0 io port: [0x2000-0x2fff]
> bus: 02 index 1 mmio: [0xf0000000-0xf00fffff]
> bus: 02 index 2 mmio: [0x54000000-0x540fffff]
> bus: 02 index 3 mmio: [0x0-0x0]
> bus: 03 index 0 mmio: [0x0-0xfff]
> bus: 03 index 1 mmio: [0x0-0xfffff]
> bus: 03 index 2 mmio: [0x0-0xfffff]
> bus: 03 index 3 mmio: [0x0-0x0]
> bus: 05 index 0 mmio: [0x0-0x0]
> bus: 05 index 1 mmio: [0xf0100000-0xf01fffff]
> bus: 05 index 2 mmio: [0x0-0x0]
> bus: 05 index 3 mmio: [0x0-0x0]
> bus: 08 index 0 io port: [0x3000-0x3fff]
> bus: 08 index 1 mmio: [0xf0200000-0xf02fffff]
> bus: 08 index 2 mmio: [0x50000000-0x53ffffff]
> bus: 08 index 3 io port: [0x00-0xffff]
> bus: 08 index 4 mmio: [0x000000-0xffffffff]
> bus: 09 index 0 io port: [0x3000-0x30ff]
> bus: 09 index 1 io port: [0x3400-0x34ff]
> bus: 09 index 2 mmio: [0x50000000-0x53ffffff]
> bus: 09 index 3 mmio: [0x58000000-0x5bffffff]
> NET: Registered protocol family 2
> IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
> TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
> TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> TCP reno registered
> NET: Registered protocol family 1
> Unpacking initramfs... done
> Freeing initrd memory: 521k freed
> Simple Boot Flag at 0x7b set to 0x1
> apm: BIOS not found.
> highmem bounce pool size: 64 pages
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> msgmni has been set to 1748
> alg: No test for stdrng (krng)
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> pci 0000:00:02.0: Boot video device
> pcieport-driver 0000:00:1c.0: setting latency timer to 64
> pcieport-driver 0000:00:1c.0: found MSI capability
> pcieport-driver 0000:00:1c.0: irq 767 for MSI/MSI-X
> pci_express 0000:00:1c.0:pcie00: allocate port service
> pci_express 0000:00:1c.0:pcie02: allocate port service
> pci_express 0000:00:1c.0:pcie03: allocate port service
> pcieport-driver 0000:00:1c.1: setting latency timer to 64
> pcieport-driver 0000:00:1c.1: found MSI capability
> pcieport-driver 0000:00:1c.1: irq 766 for MSI/MSI-X
> pci_express 0000:00:1c.1:pcie00: allocate port service
> pci_express 0000:00:1c.1:pcie02: allocate port service
> pci_express 0000:00:1c.1:pcie03: allocate port service
> pcieport-driver 0000:00:1c.3: setting latency timer to 64
> pcieport-driver 0000:00:1c.3: found MSI capability
> pcieport-driver 0000:00:1c.3: irq 765 for MSI/MSI-X
> pci_express 0000:00:1c.3:pcie00: allocate port service
> pci_express 0000:00:1c.3:pcie02: allocate port service
> pci_express 0000:00:1c.3:pcie03: allocate port service
> vesafb: framebuffer at 0xe0000000, mapped to 0xf8080000, using 3072k, tot=
al 7872k
> vesafb: mode is 1024x768x16, linelength 48, pages=3D4
> vesafb: scrolling: redraw
> vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
> Console: switching to colour frame buffer device 128x48
> fb0: VESA VGA frame buffer device
> isapnp: Scanning for PnP cards...
> Switched to high resolution mode on CPU 0
> isapnp: No Plug & Play device found
> Serial: 8250/16550 driver4 ports, IRQ sharing disabled
> input: Macintosh mouse button emulation as /class/input/input0
> PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> i8042.c: Detected active multiplexing controller, rev 1.1.
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX0 port at 0x60,0x64 irq 12
> serio: i8042 AUX1 port at 0x60,0x64 irq 12
> serio: i8042 AUX2 port at 0x60,0x64 irq 12
> serio: i8042 AUX3 port at 0x60,0x64 irq 12
> mice: PS/2 mouse device common for all mice
> cpuidle: using governor ladder
> cpuidle: using governor menu
> TCP cubic registered
> NET: Registered protocol family 17
> Using IPI No-Shortcut mode
> registered taskstats version 1
> Freeing unused kernel memory: 332k freed
> input: AT Translated Set 2 keyboard as /class/input/input1
> SCSI subsystem initialized
> libata version 3.00 loaded.
> ata_piix 0000:00:1f.1: version 2.12
> ata_piix 0000:00:1f.1: PCI INT A -> GSI 18 (level, low) -> IRQ 18
> ata_piix 0000:00:1f.1: setting latency timer to 64
> scsi0 : ata_piix
> scsi1 : ata_piix
> ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x1810 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
> ata1.00: ATA-6: TOSHIBA MK4007GAL, BG101F, max UDMA/100
> ata1.00: 78140160 sectors, multi 16: LBA48=20
> ata1.00: configured for UDMA/100
> ata2: port disabled. ignoring.
> scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK4007GA BG10 PQ: 0 ANSI=
: 5
> Driver 'sd' needs updating - please use bus_type methods
> sd 0:0:0:0: [sda] 78140160 512-byte hardware sectors: (40.0 GB/37.2 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't supp=
ort DPO or FUA
> sd 0:0:0:0: [sda] 78140160 512-byte hardware sectors: (40.0 GB/37.2 GiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't supp=
ort DPO or FUA
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
> sd 0:0:0:0: [sda] Attached SCSI disk
> ReiserFS: sda5: found reiserfs format "3.6" with standard journal
> ReiserFS: sda5: using ordered data mode
> ReiserFS: sda5: journal params: device sda5, size 8192, journal first blo=
ck 18, max trans len 1024, max batch 900, max commit age 30, max trans age =
30
> ReiserFS: sda5: checking transaction log (sda5)
> ReiserFS: sda5: Using r5 hash to sort names
> rtc_cmos 00:04: RTC can wake from S4
> rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
> rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> i801_smbus 0000:00:1f.3: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> sky2 driver version 1.22
> sky2 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> sky2 0000:02:00.0: setting latency timer to 64
> sky2 0000:02:00.0: Yukon-2 EC Ultra chip revision 2
> sky2 0000:02:00.0: Marvell Yukon 88E8055 Gigabit Ethernet Controller
>  Part Number: Yukon 88E8055
>  Engineering Level: Rev. 1.2
>  Manufacturer: Marvell
> sky2 0000:02:00.0: irq 764 for MSI/MSI-X
> sky2 eth0: addr 00:17:42:69:5e:cb
> cfg80211: Using static regulatory domain info
> cfg80211: Regulatory domain: US
> 	(start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
> 	(2402000 KHz - 2472000 KHz @ 40000 KHz), (600 mBi, 2700 mBm)
> 	(5170000 KHz - 5190000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
> 	(5190000 KHz - 5210000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
> 	(5210000 KHz - 5230000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
> 	(5230000 KHz - 5330000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
> 	(5735000 KHz - 5835000 KHz @ 40000 KHz), (600 mBi, 3000 mBm)
> cfg80211: Calling CRDA for country: US
> iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection driver for L=
inux, 1.2.26ks
> iwl3945: Copyright(c) 2003-2008 Intel Corporation
> iwl3945 0000:05:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
> iwl3945 0000:05:00.0: setting latency timer to 64
> iwl3945: Detected Intel Wireless WiFi Link 3945ABG
> iwl3945: Tunable channels: 11 802.11bg, 13 802.11a channels
> phy0: Selected rate control algorithm 'iwl-3945-rs'
> iwl3945 0000:05:00.0: PCI INT A disabled
> HDA Intel 0000:00:1b.0: power state changed by ACPI to D0
> HDA Intel 0000:00:1b.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
> HDA Intel 0000:00:1b.0: setting latency timer to 64
> input: HDA Digital PCBeep as /class/input/input2
> ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> processor ACPI_CPU:00: registered as cooling_device0
> Marking TSC unstable due to TSC halts in idle
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Battery Slot [CMB1] (battery present)
> input: Power Button (FF) as /class/input/input3
> ACPI: Power Button (FF) [PWRF]
> input: Lid Switch as /class/input/input4
> ACPI: Lid Switch [LID]
> input: Power Button (CM) as /class/input/input5
> ACPI: Power Button (CM) [PWRB]
> thermal LNXTHERM:01: registered as thermal_zone0
> ACPI: Thermal Zone [TZ00] (27 C)
> thermal LNXTHERM:02: registered as thermal_zone1
> ACPI: Thermal Zone [TZ01] (27 C)
> input: Fujitsu FUJ02B1 as /class/input/input6
> ACPI: Fujitsu FUJ02B1 [FJEX] (on)
> input: Fujitsu FUJ02E3 as /class/input/input7
> ACPI: Fujitsu FUJ02E3 [FEXT] (on)
> fujitsu-laptop: driver 0.4.3 successfully loaded.
> acpi device:03: registered as cooling_device1
> input: Video Bus as /class/input/input8
> ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> input: PC Speaker as /class/input/input9
> Error: Driver 'pcspkr' is already registered, aborting...
> Linux agpgart interface v0.103
> intel_rng: FWH not detected
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> agpgart-intel 0000:00:00.0: Intel 945GM Chipset
> agpgart-intel 0000:00:00.0: detected 7932K stolen memory
> agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe0000000
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> iTCO_vendor_support: vendor-support=3D0
> iTCO_wdt: Intel TCO WatchDog Timer Driver v1.05
> iTCO_wdt: Found a ICH7-M or ICH7-U TCO device (Version=3D2, TCOBASE=3D0x1=
060)
> iTCO_wdt: initialized. heartbeat0 sec (nowayout=3D0)
> yenta_cardbus 0000:08:03.0: CardBus bridge found [10cf:1254]
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
> ehci_hcd 0000:00:1d.7: setting latency timer to 64
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
> Error: Driver 'pcspkr' is already registered, aborting...
> ehci_hcd 0000:00:1d.7: debug port 1
> ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
> ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf0644000
> ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 8 ports detected
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> uhci_hcd: USB Universal Host Controller Interface driver
> uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
> uhci_hcd 0000:00:1d.0: setting latency timer to 64
> uhci_hcd 0000:00:1d.0: UHCI Host Controller
> uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
> uhci_hcd 0000:00:1d.0: irq 23, io base 0x00001820
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 20 (level, low) -> IRQ 20
> uhci_hcd 0000:00:1d.1: setting latency timer to 64
> uhci_hcd 0000:00:1d.1: UHCI Host Controller
> uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
> uhci_hcd 0000:00:1d.1: irq 20, io base 0x00001840
> usb usb3: configuration #1 chosen from 1 choice
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
> uhci_hcd 0000:00:1d.2: setting latency timer to 64
> uhci_hcd 0000:00:1d.2: UHCI Host Controller
> uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
> uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001860
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low) -> IRQ 16
> uhci_hcd 0000:00:1d.3: setting latency timer to 64
> uhci_hcd 0000:00:1d.3: UHCI Host Controller
> uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
> uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001880
> usb usb5: configuration #1 chosen from 1 choice
> hub 5-0:1.0: USB hub found
> hub 5-0:1.0: 2 ports detected
> yenta_cardbus 0000:08:03.0: ISA IRQ mask 0x0cb8, PCI irq 16
> yenta_cardbus 0000:08:03.0: Socket status: 30000006
> pci_bus 0000:08: Raising subordinate bus# of parent bus (#08) from #09 to=
 #0c
> yenta_cardbus 0000:08:03.0: pcmcia: parent PCI bridge I/O window: 0x3000 =
- 0x3fff
> pcmcia_socket pcmcia_socket0: cs: IO port probe 0x3000-0x3fff: clean.
> yenta_cardbus 0000:08:03.0: pcmcia: parent PCI bridge Memory window: 0xf0=
200000 - 0xf02fffff
> yenta_cardbus 0000:08:03.0: pcmcia: parent PCI bridge Memory window: 0x50=
000000 - 0x53ffffff
> ohci1394 0000:08:03.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
> ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[17]  MMIO=3D[f0200000-f02=
007ff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/4]
> sdhci-pci 0000:08:03.2: SDHCI controller found [1180:0822] (rev 17)
> sdhci-pci 0000:08:03.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> mmc0: SDHCI controller on PCI [0000:08:03.2] using PIO
> Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1a0b1, caps: 0xa04711/0x2020=
00
> input: SynPS/2 Synaptics TouchPad as /class/input/input10
> pcmcia_socket pcmcia_socket0: cs: IO port probe 0x100-0x3af: clean.
> pcmcia_socket pcmcia_socket0: cs: IO port probe 0x3e0-0x4ff: clean.
> pcmcia_socket pcmcia_socket0: cs: IO port probe 0x820-0x8ff: clean.
> pcmcia_socket pcmcia_socket0: cs: IO port probe 0xc00-0xcf7: clean.
> pcmcia_socket pcmcia_socket0: cs: IO port probe 0xa00-0xaff: clean.
> usb 3-2: new full speed USB device using uhci_hcd and address 2
> Clocksource tsc unstable (delta =3D -107815724 ns)
> usb 3-2: configuration #1 chosen from 1 choice
> usb 4-1: new full speed USB device using uhci_hcd and address 2
> usb 4-1: configuration #1 chosen from 1 choice
> ReiserFS: sda7: found reiserfs format "3.6" with standard journal
> ReiserFS: sda7: using ordered data mode
> ReiserFS: sda7: journal params: device sda7, size 8192, journal first blo=
ck 18, max trans len 1024, max batch 900, max commit age 30, max trans age =
30
> ReiserFS: sda7: checking transaction log (sda7)
> ReiserFS: sda7: Using r5 hash to sort names
> ReiserFS: sda2: found reiserfs format "3.6" with standard journal
> ReiserFS: sda2: using ordered data mode
> ReiserFS: sda2: journal params: device sda2, size 8192, journal first blo=
ck 18, max trans len 1024, max batch 900, max commit age 30, max trans age =
30
> ReiserFS: sda2: checking transaction log (sda2)
> Bluetooth: Core ver 2.13
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> ReiserFS: sda2: Using r5 hash to sort names
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00000e1003c6fc1b]
> Bluetooth: Generic Bluetooth USB driver ver 0.3
> usbcore: registered new interface driver btusb
> Adding 2104472k swap on /dev/sda6.  Priority:-1 extents:1 across:2104472k
> sky2 eth0: enabling interface
> NET: Registered protocol family 10
> lo: Disabled Privacy Extensions
> ADDRCONF(NETDEV_UP): eth0: link is not ready
> iwl3945 0000:05:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
> iwl3945 0000:05:00.0: restoring config space at offset 0x1 (was 0x100002,=
 writing 0x100006)
> iwl3945 0000:05:00.0: irq 763 for MSI/MSI-X
> iwl3945 0000:05:00.0: firmware: requesting iwlwifi-3945-1.ucode
> Registered led device: iwl-phy0:radio
> Registered led device: iwl-phy0:assoc
> Registered led device: iwl-phy0:RX
> Registered led device: iwl-phy0:TX
> ADDRCONF(NETDEV_UP): wlan0: link is not ready
> wlan0: direct probe to AP 00:17:3f:76:11:72 try 1
> wlan0 direct probe responded
> wlan0: authenticate with AP 00:17:3f:76:11:72
> wlan0: authenticated
> wlan0: associate with AP 00:17:3f:76:11:72
> wlan0: RX AssocResp from 00:17:3f:76:11:72 (capab=3D0x461 status=3D0 aid=
=3D2)
> wlan0: associated
> ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> wlan0: no IPv6 routers present
> wlan0: deauthenticated
> wlan0: direct probe to AP 00:17:3f:76:11:72 try 1
> wlan0 direct probe responded
> wlan0: authenticate with AP 00:17:3f:76:11:72
> wlan0: authenticated
> wlan0: associate with AP 00:17:3f:76:11:72
> wlan0: RX ReassocResp from 00:17:3f:76:11:72 (capab=3D0x461 status=3D0 ai=
d=3D2)
> wlan0: associated
> [drm] Initialized drm 1.1.0 20060810
> pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> pci 0000:00:02.0: setting latency timer to 64
> [drm] Initialized i915 1.6.0 20080730 on minor 0
> i2c /dev entries driver
> i2c /dev entries driver
>=20


--=20
Shane Helms <shanehelms@gmail.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
