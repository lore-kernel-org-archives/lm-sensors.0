From: Vedant Lath <vedant@lath.in>
Date: Sun, 11 Apr 2010 05:34:24 +0000
Subject: [lm-sensors] Intel DH55TC support
Message-Id: <u2h638760961004102222wec0d9deav8a132d3b6e441f74@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I have an Intel DH55TC motherboard with a Core i3-530 2.93 GHz CPU
attached to it. Sensors gives me weird values.

I tried googling but couldn't find a way to compute the readings and
determine the min and max values. There is a page for ASUS
motherboards but it's obsolete. There is a config at
http://khali.linux-fr.org/devel/lm-sensors/sensors3-MSI-K9-Neo-v3.conf
but that also gave weird values.

What is the best way to compute the readings and determine the min and
max values? Is there a way to know the fan speeds? Is QST related to
it?

I have pasted some diagnostic output below.

Motherboard: Intel DH55TC
lm_sensors version: sensors version 3.1.2 with libsensors version 3.1.2
kernel version: 2.6.32-3-amd64 #1 SMP Wed Feb 24 18:07:42 UTC 2010
x86_64 GNU/Linux (Debian testing)

sensors output:
$ sensors
w83627dhg-isa-0a10
Adapter: ISA adapter
VCore:       +0.93 V  (min =3D  +0.00 V, max =3D  +1.74 V)
AVCC:        +3.41 V  (min =3D  +2.34 V, max =3D  +3.98 V)
3VCC:        +3.41 V  (min =3D  +2.02 V, max =3D  +0.74 V)   ALARM
5VSB:        +6.73 V  (min =3D  +5.34 V, max =3D +10.38 V)
+5V:         +3.99 V  (min =3D  +6.56 V, max =3D  +4.67 V)   ALARM
+12V:       +11.62 V  (min =3D +15.14 V, max =3D +15.14 V)   ALARM
3VSB:        +3.34 V  (min =3D  +1.01 V, max =3D  +3.76 V)
VBat:        +3.36 V  (min =3D  +0.93 V, max =3D  +3.33 V)   ALARM
fan1:          0 RPM  (min =3D 3125 RPM, div =3D 16)  ALARM
CPU Fan:       0 RPM  (min =3D 6026 RPM, div =3D 16)  ALARM
fan3:          0 RPM  (min =3D 14062 RPM, div =3D 16)  ALARM
fan5:          0 RPM  (min =3D 7336 RPM, div =3D 8)  ALARM
Sys Temp:   +101.0=B0C  (high =3D -98.0=B0C, hyst =3D +19.0=B0C)  ALARM  se=
nsor
=3D thermistor
CPU Temp:    +39.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
CPU Temp:   +127.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  se=
nsor
=3D thermistor
cpu0_vid:   +2.050 V

$ sudo sensors-detect
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# Board: Intel Corporation DH55TC

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
Intel Core family thermal sensor...                         No
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
Found `Winbond W83627DHG-P Super IO Sensors'                Success!
    (address 0xa10, driver `w83627ehf')
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
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.
Sorry, no supported PCI bus adapters found.
Module i2c-dev loaded successfully.

Next adapter: intel drm CRTDDC_A (i2c-0)
Do you want to scan it? (YES/no/selectively):

Next adapter: intel drm HDMIC (i2c-1)
Do you want to scan it? (YES/no/selectively):

Next adapter: intel drm HDMID (i2c-2)
Do you want to scan it? (YES/no/selectively):

Next adapter: DPDDC-C (i2c-3)
Do you want to scan it? (YES/no/selectively):

Next adapter: DPDDC-D (i2c-4)
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus I801 adapter at f000 (i2c-5)
Do you want to scan it? (yes/NO/selectively): yes
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `w83627ehf':
  * ISA bus, address 0xa10
    Chip `Winbond W83627DHG-P Super IO Sensors' (confidence: 9)

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
w83627ehf
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)

Unloading i2c-dev... OK

$ lsmod
Module                  Size  Used by
w83627ehf              18659  0
hwmon_vid               1828  1 w83627ehf
i2c_scmi                3412  0
i2c_i801                7798  0
ppdev                   5030  0
lp                      7462  0
loop                   11783  0
snd_hda_codec_intelhdmi    10695  1
snd_hda_codec_realtek   235378  1
snd_hda_intel          19619  0
snd_hda_codec          54212  3
snd_hda_codec_intelhdmi,snd_hda_codec_realtek,snd_hda_intel
snd_pcsp                6579  0
snd_hwdep               5364  1 snd_hda_codec
snd_pcm                60615  3 snd_hda_intel,snd_hda_codec,snd_pcsp
usbhid                 33132  1
snd_timer              15502  1 snd_pcm
usblp                   9571  0
snd                    46350  8
snd_hda_codec_intelhdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,s=
nd_pcsp,snd_hwdep,snd_pcm,snd_timer
parport_pc             18855  1
hid                    62825  1 usbhid
parport                27938  3 ppdev,lp,parport_pc
soundcore               4598  1 snd
snd_page_alloc          6217  2 snd_hda_intel,snd_pcm
processor              30215  4
evdev                   7336  3
ext3                  106486  2
jbd                    37053  1 ext3
mbcache                 4970  1 ext3
dm_mod                 53674  0
sg                     18728  0
ide_pci_generic         2788  0
sr_mod                 12602  0
sd_mod                 29689  4
crc_t10dif              1276  1 sd_mod
cdrom                  29399  1 sr_mod
ide_core               76850  1 ide_pci_generic
ata_generic             2983  0
i915                  248774  0
drm_kms_helper         18899  1 i915
drm                   137190  2 i915,drm_kms_helper
i2c_algo_bit            4225  1 i915
ahci                   32038  3
i2c_core               15584  5 i2c_scmi,i2c_i801,i915,drm,i2c_algo_bit
video                  17445  1 i915
libata                132183  2 ata_generic,ahci
ehci_hcd               30706  0
e1000                  85501  0
usbcore               121703  5 usbhid,usblp,ehci_hcd
output                  1692  1 video
nls_base                6377  1 usbcore
scsi_mod              121925  4 sg,sr_mod,sd_mod,libata
button                  4634  1 i915
e1000e                109919  0
intel_agp              25593  1
thermal                11674  0
fan                     3346  0
thermal_sys            11878  4 processor,video,thermal,fan

$ lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation Core Processor DRAM
Controller [8086:0040] (rev 12)
00:01.0 PCI bridge [0604]: Intel Corporation Core Processor PCI
Express x16 Root Port [8086:0041] (rev 12)
00:02.0 VGA compatible controller [0300]: Intel Corporation Core
Processor Integrated Graphics Controller [8086:0042] (rev 12)
00:16.0 Communication controller [0780]: Intel Corporation 5
Series/3400 Series Chipset HECI Controller [8086:3b64] (rev 06)
00:16.2 IDE interface [0101]: Intel Corporation 5 Series/3400 Series
Chipset PT IDER Controller [8086:3b66] (rev 06)
00:16.3 Serial controller [0700]: Intel Corporation 5 Series/3400
Series Chipset KT Controller [8086:3b67] (rev 06)
00:19.0 Ethernet controller [0200]: Intel Corporation 82578DC Gigabit
Network Connection [8086:10f0] (rev 06)
00:1a.0 USB Controller [0c03]: Intel Corporation 5 Series/3400 Series
Chipset USB2 Enhanced Host Controller [8086:3b3c] (rev 06)
00:1b.0 Audio device [0403]: Intel Corporation 5 Series/3400 Series
Chipset High Definition Audio [8086:3b56] (rev 06)
00:1c.0 PCI bridge [0604]: Intel Corporation 5 Series/3400 Series
Chipset PCI Express Root Port 1 [8086:3b42] (rev 06)
00:1c.4 PCI bridge [0604]: Intel Corporation 5 Series/3400 Series
Chipset PCI Express Root Port 5 [8086:3b4a] (rev 06)
00:1d.0 USB Controller [0c03]: Intel Corporation 5 Series/3400 Series
Chipset USB2 Enhanced Host Controller [8086:3b34] (rev 06)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge
[8086:244e] (rev a6)
00:1f.0 ISA bridge [0601]: Intel Corporation 5 Series Chipset LPC
Interface Controller [8086:3b06] (rev 06)
00:1f.2 SATA controller [0106]: Intel Corporation 5 Series/3400 Series
Chipset 6 port SATA AHCI Controller [8086:3b22] (rev 06)
00:1f.3 SMBus [0c05]: Intel Corporation 5 Series/3400 Series Chipset
SMBus Controller [8086:3b30] (rev 06)
04:00.0 Ethernet controller [0200]: Intel Corporation 82540EM Gigabit
Ethernet Controller [8086:100e] (rev 02)

$ dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.32-3-amd64 (Debian 2.6.32-9)
(maks@debian.org) (gcc version 4.3.4 (Debian 4.3.4-8) ) #1 SMP Wed Feb
24 18:07:42 UTC 2010
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-2.6.32-3-amd64
root=3DUUIDoe199ea-1c6f-4e39-bb7e-f8e0b93fa5ed ro
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009ac00 (usable)
[    0.000000]  BIOS-e820: 000000000009ac00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cb43d000 (usable)
[    0.000000]  BIOS-e820: 00000000cb43d000 - 00000000cb47f000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cb47f000 - 00000000cb4fd000 (reserved)
[    0.000000]  BIOS-e820: 00000000cb4fd000 - 00000000cb511000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cb511000 - 00000000cb616000 (reserved)
[    0.000000]  BIOS-e820: 00000000cb616000 - 00000000cb617000 (usable)
[    0.000000]  BIOS-e820: 00000000cb617000 - 00000000cb618000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cb618000 - 00000000cb622000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cb622000 - 00000000cb62b000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cb62b000 - 00000000cb649000 (reserved)
[    0.000000]  BIOS-e820: 00000000cb649000 - 00000000cb68c000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cb68c000 - 00000000cb800000 (usable)
[    0.000000]  BIOS-e820: 00000000cdc00000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000128000000 (usable)
[    0.000000] DMI 2.6 present.
[    0.000000] last_pfn =3D 0x128000 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F00000000 write-back
[    0.000000]   1 base 100000000 mask FE0000000 write-back
[    0.000000]   2 base 120000000 mask FF8000000 write-back
[    0.000000]   3 base 0CC000000 mask FFC000000 uncachable
[    0.000000]   4 base 0D0000000 mask FF0000000 uncachable
[    0.000000]   5 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x701060007=
0106
[    0.000000] e820 update range: 00000000cc000000 - 0000000100000000
(usable) =3D> (reserved)
[    0.000000] last_pfn =3D 0xcb800 max_arch_pfn =3D 0x400000000
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000cb800000
[    0.000000]  0000000000 - 00cb800000 page 2M
[    0.000000] kernel direct mapping tables up to cb800000 @ 8000-d000
[    0.000000] init_memory_mapping: 0000000100000000-0000000128000000
[    0.000000]  0100000000 - 0128000000 page 2M
[    0.000000] kernel direct mapping tables up to 128000000 @ b000-11000
[    0.000000] RAMDISK: 37726000 - 37fef217
[    0.000000] ACPI: RSDP 00000000000f0410 00024 (v02  INTEL)
[    0.000000] ACPI: XSDT 00000000cb620e18 0005C (v01 INTEL  DH55TC
01072009 MSFT 00010013)
[    0.000000] ACPI: FACP 00000000cb61fd98 000F4 (v04 INTEL  DH55TC
01072009 MSFT 00010013)
[    0.000000] ACPI Warning: 32/64 FACS address mismatch in FADT - two
FACS tables! (20090903/tbfadt-369)
[    0.000000] ACPI Warning: 32/64X FACS address mismatch in FADT -
CB628E40/00000000CB628D40, using 32 (20090903/tbfadt-486)
[    0.000000] ACPI: DSDT 00000000cb618018 069C3 (v01 INTEL  DH55TC
00000000 INTL 20051117)
[    0.000000] ACPI: FACS 00000000cb628e40 00040
[    0.000000] ACPI: APIC 00000000cb61ff18 000CC (v02 INTEL  DH55TC
01072009 MSFT 00010013)
[    0.000000] ACPI: SSDT 00000000cb61fc18 0014E (v01 INTEL  DH55TC
00000001 MSFT 03000001)
[    0.000000] ACPI: MCFG 00000000cb621f18 0003C (v01 INTEL  DH55TC
01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000cb621e98 00038 (v01 INTEL  DH55TC
01072009 AMI. 00000003)
[    0.000000] ACPI: ASF! 00000000cb620c18 000A0 (v32 INTEL  DH55TC
00000001 TFSM 000F4240)
[    0.000000] ACPI: DMAR 00000000cb620b18 000B8 (v01 INTEL  DH55TC
00000001 INTL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000128000000
[    0.000000] Bootmem setup node 0 0000000000000000-0000000128000000
[    0.000000]   NODE_DATA [000000000000c000 - 0000000000013fff]
[    0.000000]   bootmap [0000000000014000 -  0000000000038fff] pages 25
[    0.000000] (8 early reservations) =3D> bootmem [0000000000 - 0128000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page =3D>
[0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE =3D>
[0000006000 - 0000008000]
[    0.000000]   #2 [0001000000 - 000166aa14]    TEXT DATA BSS =3D>
[0001000000 - 000166aa14]
[    0.000000]   #3 [0037726000 - 0037fef217]          RAMDISK =3D>
[0037726000 - 0037fef217]
[    0.000000]   #4 [000009ac00 - 0000100000]    BIOS reserved =3D>
[000009ac00 - 0000100000]
[    0.000000]   #5 [000166b000 - 000166b1f8]              BRK =3D>
[000166b000 - 000166b1f8]
[    0.000000]   #6 [0000008000 - 000000b000]          PGTABLE =3D>
[0000008000 - 000000b000]
[    0.000000]   #7 [000000b000 - 000000c000]          PGTABLE =3D>
[000000b000 - 000000c000]
[    0.000000] found SMP MP-table at [ffff8800000fcd50] fcd50
[    0.000000]  [ffffea0000000000-ffffea00041fffff] PMD ->
[ffff880001800000-ffff880004ffffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00128000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[5] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009a
[    0.000000]     0: 0x00000100 -> 0x000cb43d
[    0.000000]     0: 0x000cb616 -> 0x000cb617
[    0.000000]     0: 0x000cb68c -> 0x000cb800
[    0.000000]     0: 0x00100000 -> 0x00128000
[    0.000000] On node 0 totalpages: 996684
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 108 pages reserved
[    0.000000]   DMA zone: 3830 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 814570 pages, LIFO batch:31
[    0.000000]   Normal zone: 2240 pages used for memmap
[    0.000000]   Normal zone: 161600 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x05] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x06] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x08] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x09] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x0a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x0b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x0c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x0d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x0e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x0f] disabled)
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] SMP: Allowing 16 CPUs, 12 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000009a000 - 00000000000=
9b000
[    0.000000] PM: Registered nosave memory: 000000000009b000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 00000000001=
00000
[    0.000000] PM: Registered nosave memory: 00000000cb43d000 - 00000000cb4=
7f000
[    0.000000] PM: Registered nosave memory: 00000000cb47f000 - 00000000cb4=
fd000
[    0.000000] PM: Registered nosave memory: 00000000cb4fd000 - 00000000cb5=
11000
[    0.000000] PM: Registered nosave memory: 00000000cb511000 - 00000000cb6=
16000
[    0.000000] PM: Registered nosave memory: 00000000cb617000 - 00000000cb6=
18000
[    0.000000] PM: Registered nosave memory: 00000000cb618000 - 00000000cb6=
22000
[    0.000000] PM: Registered nosave memory: 00000000cb622000 - 00000000cb6=
2b000
[    0.000000] PM: Registered nosave memory: 00000000cb62b000 - 00000000cb6=
49000
[    0.000000] PM: Registered nosave memory: 00000000cb649000 - 00000000cb6=
8c000
[    0.000000] PM: Registered nosave memory: 00000000cb800000 - 00000000cdc=
00000
[    0.000000] PM: Registered nosave memory: 00000000cdc00000 - 00000000d00=
00000
[    0.000000] PM: Registered nosave memory: 00000000d0000000 - 00000000fed=
1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed=
20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000ff0=
00000
[    0.000000] PM: Registered nosave memory: 00000000ff000000 - 00000001000=
00000
[    0.000000] Allocating PCI resources starting at d0000000 (gap:
d0000000:2ed1c000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:16 nr_node_ids:1
[    0.000000] PERCPU: Embedded 29 pages/cpu @ffff880005200000 s89880
r8192 d20712 u131072
[    0.000000] pcpu-alloc: s89880 r8192 d20712 u131072 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14=
 15
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.
Total pages: 980000
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:
BOOT_IMAGE=3D/boot/vmlinuz-2.6.32-3-amd64
root=3DUUIDoe199ea-1c6f-4e39-bb7e-f8e0b93fa5ed ro
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at
/build/mattems-linux-2.6_2.6.32-9-amd64-NYTFdD/linux-2.6-2.6.32-9/debian/bu=
ild/source_amd64_none/drivers/pci/dmar.c:636
check_zero_address+0x151/0x19b()
[    0.000000] Hardware name:
[    0.000000] Your BIOS is broken; DMAR reported at address fed91000
returns all ones!
[    0.000000] BIOS vendor: Intel Corp.; Ver:
TCIBX10H.86A.0027.2009.1119.1517; Product Version:
[    0.000000] Modules linked in:
[    0.000000] Pid: 0, comm: swapper Not tainted 2.6.32-3-amd64 #1
[    0.000000] Call Trace:
[    0.000000]  [<ffffffff814fedf3>] ? check_zero_address+0x151/0x19b
[    0.000000]  [<ffffffff814fedf3>] ? check_zero_address+0x151/0x19b
[    0.000000]  [<ffffffff8104dbf0>] ? warn_slowpath_common+0x77/0xa3
[    0.000000]  [<ffffffff8104dc78>] ? warn_slowpath_fmt+0x51/0x59
[    0.000000]  [<ffffffff814da140>] ? early_idt_handler+0x0/0x71
[    0.000000]  [<ffffffff812f1b59>] ? _etext+0x0/0x1e84a7
[    0.000000]  [<ffffffff814eeb6e>] ? __early_ioremap+0x1a3/0x23b
[    0.000000]  [<ffffffff814da140>] ? early_idt_handler+0x0/0x71
[    0.000000]  [<ffffffff814eed5f>] ? early_iounmap+0x13b/0x196
[    0.000000]  [<ffffffff814fedf3>] ? check_zero_address+0x151/0x19b
[    0.000000]  [<ffffffff814da140>] ? early_idt_handler+0x0/0x71
[    0.000000]  [<ffffffff812f1b59>] ? _etext+0x0/0x1e84a7
[    0.000000]  [<ffffffff814fee4f>] ? detect_intel_iommu+0x12/0x8c
[    0.000000]  [<ffffffff814e0172>] ? pci_iommu_alloc+0x56/0x61
[    0.000000]  [<ffffffff814ee525>] ? mem_init+0x15/0xe5
[    0.000000]  [<ffffffff814daafd>] ? start_kernel+0x1f6/0x3dc
[    0.000000]  [<ffffffff814da3b7>] ? x86_64_start_kernel+0xf9/0x106
[    0.000000] ---[ end trace a7919e7f17c0a725 ]---
[    0.000000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.000000] Placing 64MB software IO TLB between ffff8800053fd000 -
ffff8800093fd000
[    0.000000] software IO TLB at phys 0x53fd000 - 0x93fd000
[    0.000000] Memory: 3845568k/4849664k available (3014k kernel code,
862928k absent, 141168k reserved, 1860k data, 580k init)
[    0.000000] SLUB: Genslabs=14, HWalignd, Order=3D0-3, MinObjects=3D0,
CPUs=16, Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:4352 nr_irqs:536
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000]   alloc irq_desc for 24 on node 0
[    0.000000]   alloc kstat_irqs on node 0
[    0.000000]   alloc irq_desc for 25 on node 0
[    0.000000]   alloc kstat_irqs on node 0
[    0.000000]   alloc irq_desc for 26 on node 0
[    0.000000]   alloc kstat_irqs on node 0
[    0.000000]   alloc irq_desc for 27 on node 0
[    0.000000]   alloc kstat_irqs on node 0
[    0.000000]   alloc irq_desc for 28 on node 0
[    0.000000]   alloc kstat_irqs on node 0
[    0.000000] HPET: 8 timers in total, 5 timers will be used for per-cpu t=
imer
[    0.000000] Fast TSC calibration using PIT
[    0.004000] Detected 2926.163 MHz processor.
[    0.000005] Calibrating delay loop (skipped), value calculated
using timer frequency.. 5852.32 BogoMIPS (lpj=11704652)
[    0.000121] Security Framework initialized
[    0.000173] SELinux:  Disabled at boot.
[    0.000456] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes)
[    0.001386] Inode-cache hash table entries: 262144 (order: 9, 2097152 by=
tes)
[    0.001833] Mount-cache hash table entries: 256
[    0.001990] Initializing cgroup subsys ns
[    0.002040] Initializing cgroup subsys cpuacct
[    0.002092] Initializing cgroup subsys devices
[    0.002141] Initializing cgroup subsys freezer
[    0.002190] Initializing cgroup subsys net_cls
[    0.002254] CPU: Physical Processor ID: 0
[    0.002301] CPU: Processor Core ID: 0
[    0.002350] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.002416] CPU: L2 cache: 256K
[    0.002462] CPU: L3 cache: 4096K
[    0.002507] CPU 0/0x0 -> Node 0
[    0.002555] mce: CPU supports 9 MCE banks
[    0.002610] CPU0: Thermal monitoring enabled (TM1)
[    0.002662] CPU 0 MCA banks CMCI:2 CMCI:3 CMCI:5 CMCI:6
[    0.002811] using mwait in idle threads.
[    0.002858] Performance Events: Nehalem/Corei7 events, Intel PMU driver.
[    0.002952] ... version:                3
[    0.002999] ... bit width:              48
[    0.003048] ... generic registers:      4
[    0.003096] ... value mask:             0000ffffffffffff
[    0.003146] ... max period:             000000007fffffff
[    0.003198] ... fixed-purpose events:   3
[    0.003245] ... event mask:             000000070000000f
[    0.004073] ACPI: Core revision 20090903
[    0.013491] DMAR: Host address width 36
[    0.013540] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.013595] IOMMU fed90000: ver 1:0 cap c9008020e30272 ecap 1000
[    0.013650] DMAR: DRHD base: 0x000000fed91000 flags: 0x0
[    0.013709] DMAR: parse DMAR table failure.
[    0.013766] Setting APIC routing to flat
[    0.014154] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.053783] CPU0: Intel(R) Core(TM) i3 CPU         530  @ 2.93GHz steppi=
ng 02
[    0.161135] Booting processor 1 APIC 0x1 ip 0x6000
[    0.171571] Initializing CPU#1
[    0.248793] CPU: Physical Processor ID: 0
[    0.248794] CPU: Processor Core ID: 0
[    0.248796] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.248798] CPU: L2 cache: 256K
[    0.248799] CPU: L3 cache: 4096K
[    0.248801] CPU 1/0x1 -> Node 0
[    0.248811] CPU1: Thermal monitoring enabled (TM1)
[    0.248814] CPU 1 MCA banks SHD:2 SHD:3 SHD:5 SHD:6
[    0.248870] CPU1: Intel(R) Core(TM) i3 CPU         530  @ 2.93GHz steppi=
ng 02
[    0.249387] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.269485] Booting processor 2 APIC 0x4 ip 0x6000
[    0.279668] Initializing CPU#2
[    0.356491] CPU: Physical Processor ID: 0
[    0.356492] CPU: Processor Core ID: 2
[    0.356495] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.356496] CPU: L2 cache: 256K
[    0.356497] CPU: L3 cache: 4096K
[    0.356499] CPU 2/0x4 -> Node 0
[    0.356510] CPU2: Thermal monitoring enabled (TM1)
[    0.356513] CPU 2 MCA banks CMCI:2 CMCI:3 CMCI:5 SHD:6
[    0.356536] CPU2: Intel(R) Core(TM) i3 CPU         530  @ 2.93GHz steppi=
ng 02
[    0.357052] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    0.377153] Booting processor 3 APIC 0x5 ip 0x6000
[    0.387335] Initializing CPU#3
[    0.464190] CPU: Physical Processor ID: 0
[    0.464191] CPU: Processor Core ID: 2
[    0.464193] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.464194] CPU: L2 cache: 256K
[    0.464195] CPU: L3 cache: 4096K
[    0.464197] CPU 3/0x5 -> Node 0
[    0.464206] CPU3: Thermal monitoring enabled (TM1)
[    0.464209] CPU 3 MCA banks SHD:2 SHD:3 SHD:5 SHD:6
[    0.464304] CPU3: Intel(R) Core(TM) i3 CPU         530  @ 2.93GHz steppi=
ng 02
[    0.464817] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
[    0.484852] Brought up 4 CPUs
[    0.484898] Total of 4 processors activated (23407.93 BogoMIPS).
[    0.486148] CPU0 attaching sched-domain:
[    0.486151]  domain 0: span 0-1 level SIBLING
[    0.486153]   groups: 0 (cpu_power =3D 589) 1 (cpu_power =3D 589)
[    0.486157]   domain 1: span 0-3 level MC
[    0.486158]    groups: 0-1 (cpu_power =3D 1178) 2-3 (cpu_power =3D 1178)
[    0.486164] CPU1 attaching sched-domain:
[    0.486165]  domain 0: span 0-1 level SIBLING
[    0.486167]   groups: 1 (cpu_power =3D 589) 0 (cpu_power =3D 589)
[    0.486170]   domain 1: span 0-3 level MC
[    0.486171]    groups: 0-1 (cpu_power =3D 1178) 2-3 (cpu_power =3D 1178)
[    0.486175] CPU2 attaching sched-domain:
[    0.486176]  domain 0: span 2-3 level SIBLING
[    0.486177]   groups: 2 (cpu_power =3D 589) 3 (cpu_power =3D 589)
[    0.486180]   domain 1: span 0-3 level MC
[    0.486182]    groups: 2-3 (cpu_power =3D 1178) 0-1 (cpu_power =3D 1178)
[    0.486186] CPU3 attaching sched-domain:
[    0.486187]  domain 0: span 2-3 level SIBLING
[    0.486188]   groups: 3 (cpu_power =3D 589) 2 (cpu_power =3D 589)
[    0.486191]   domain 1: span 0-3 level MC
[    0.486192]    groups: 2-3 (cpu_power =3D 1178) 0-1 (cpu_power =3D 1178)
[    0.486402] devtmpfs: initialized
[    0.489672] regulator: core version 0.5
[    0.489762] NET: Registered protocol family 16
[    0.489875] ACPI: bus type pci registered
[    0.489992] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 63
[    0.490048] PCI: Not using MMCONFIG.
[    0.490094] PCI: Using configuration type 1 for base access
[    0.490435] bio: create slab <bio-0> at 0
[    0.490992] ACPI: EC: Look up EC in DSDT
[    0.492677] ACPI: Executed 1 blocks of module-level executable AML code
[    0.498653] ACPI: Interpreter enabled
[    0.498702] ACPI: (supports S0 S1 S3 S4 S5)
[    0.498857] ACPI: Using IOAPIC for interrupt routing
[    0.498949] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 63
[    0.499085] PCI: MCFG area at e0000000 reserved in ACPI motherboard reso=
urces
[    0.500933] PCI: Using MMCONFIG at e0000000 - e3ffffff
[    0.501130] ACPI: BIOS _OSI(Linux) query ignored
[    0.508047] ACPI: No dock devices found.
[    0.508290] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.508407] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.508462] pci 0000:00:01.0: PME# disabled
[    0.508528] pci 0000:00:02.0: reg 10 64bit mmio: [0xfe000000-0xfe3fffff]
[    0.508532] pci 0000:00:02.0: reg 18 64bit mmio pref: [0xd0000000-0xdfff=
ffff]
[    0.508535] pci 0000:00:02.0: reg 20 io port: [0xf100-0xf107]
[    0.508612] pci 0000:00:16.0: reg 10 64bit mmio: [0xfe52a000-0xfe52a00f]
[    0.508664] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.508720] pci 0000:00:16.0: PME# disabled
[    0.508813] pci 0000:00:16.2: reg 10 io port: [0xf0f0-0xf0f7]
[    0.508820] pci 0000:00:16.2: reg 14 io port: [0xf0e0-0xf0e3]
[    0.508826] pci 0000:00:16.2: reg 18 io port: [0xf0d0-0xf0d7]
[    0.508832] pci 0000:00:16.2: reg 1c io port: [0xf0c0-0xf0c3]
[    0.508838] pci 0000:00:16.2: reg 20 io port: [0xf0b0-0xf0bf]
[    0.508908] pci 0000:00:16.3: reg 10 io port: [0xf0a0-0xf0a7]
[    0.508914] pci 0000:00:16.3: reg 14 32bit mmio: [0xfe529000-0xfe529fff]
[    0.509000] pci 0000:00:19.0: reg 10 32bit mmio: [0xfe500000-0xfe51ffff]
[    0.509005] pci 0000:00:19.0: reg 14 32bit mmio: [0xfe528000-0xfe528fff]
[    0.509011] pci 0000:00:19.0: reg 18 io port: [0xf040-0xf05f]
[    0.509044] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.509097] pci 0000:00:19.0: PME# disabled
[    0.509187] pci 0000:00:1a.0: reg 10 32bit mmio: [0xfe527000-0xfe5273ff]
[    0.509233] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.509289] pci 0000:00:1a.0: PME# disabled
[    0.509375] pci 0000:00:1b.0: reg 10 64bit mmio: [0xfe520000-0xfe523fff]
[    0.509411] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.509467] pci 0000:00:1b.0: PME# disabled
[    0.509570] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.509626] pci 0000:00:1c.0: PME# disabled
[    0.509732] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.509787] pci 0000:00:1c.4: PME# disabled
[    0.509882] pci 0000:00:1d.0: reg 10 32bit mmio: [0xfe526000-0xfe5263ff]
[    0.509929] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.509983] pci 0000:00:1d.0: PME# disabled
[    0.510192] pci 0000:00:1f.2: reg 10 io port: [0xf090-0xf097]
[    0.510197] pci 0000:00:1f.2: reg 14 io port: [0xf080-0xf083]
[    0.510203] pci 0000:00:1f.2: reg 18 io port: [0xf070-0xf077]
[    0.510207] pci 0000:00:1f.2: reg 1c io port: [0xf060-0xf063]
[    0.510211] pci 0000:00:1f.2: reg 20 io port: [0xf020-0xf03f]
[    0.510217] pci 0000:00:1f.2: reg 24 32bit mmio: [0xfe525000-0xfe5257ff]
[    0.510245] pci 0000:00:1f.2: PME# supported from D3hot
[    0.510298] pci 0000:00:1f.2: PME# disabled
[    0.510366] pci 0000:00:1f.3: reg 10 64bit mmio: [0xfe524000-0xfe5240ff]
[    0.510377] pci 0000:00:1f.3: reg 20 io port: [0xf000-0xf01f]
[    0.510564] pci 0000:04:00.0: reg 10 32bit mmio: [0xfe440000-0xfe45ffff]
[    0.510570] pci 0000:04:00.0: reg 14 32bit mmio: [0xfe420000-0xfe43ffff]
[    0.510576] pci 0000:04:00.0: reg 18 io port: [0xe000-0xe03f]
[    0.510593] pci 0000:04:00.0: reg 30 32bit mmio pref: [0xfe400000-0xfe41=
ffff]
[    0.510616] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[    0.510672] pci 0000:04:00.0: PME# disabled
[    0.510766] pci 0000:00:1e.0: transparent bridge
[    0.510817] pci 0000:00:1e.0: bridge io port: [0xe000-0xefff]
[    0.510821] pci 0000:00:1e.0: bridge 32bit mmio: [0xfe400000-0xfe4fffff]
[    0.510840] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.511029] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[    0.511076] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
[    0.511124] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.BR20._PRT]
[    0.516043] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14=
 15)
[    0.516402] ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 10 11 12 14=
 15)
[    0.516762] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 1=
5)
[    0.517098] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.517433] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 *7 10 11 12 14=
 15)
[    0.517787] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14=
 15)
[    0.518142] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14=
 15)
[    0.518499] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14=
 15)
[    0.518847] vgaarb: device added:
PCI:0000:00:02.0,decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.518931] vgaarb: loaded
[    0.519012] PCI: Using ACPI for IRQ routing
[    0.519176] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 24, 25, 26, 27, 28, 0
[    0.519398] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.524040] hpet: hpet2 irq 24 for MSI
[    0.524723] hpet: hpet3 irq 25 for MSI
[    0.528691] hpet: hpet4 irq 26 for MSI
[    0.528750] hpet: hpet5 irq 27 for MSI
[    0.528755] Switching to clocksource tsc
[    0.529638] pnp: PnP ACPI init
[    0.529689] ACPI: bus type pnp registered
[    0.532240] pnp: PnP ACPI: found 13 devices
[    0.532286] ACPI: ACPI bus type pnp unregistered
[    0.532340] system 00:01: iomem range 0xfed14000-0xfed19fff has been res=
erved
[    0.532398] system 00:01: iomem range 0xe0000000-0xe3ffffff has been res=
erved
[    0.532455] system 00:01: iomem range 0xfed90000-0xfed93fff has been res=
erved
[    0.532513] system 00:01: iomem range 0xfed20000-0xfed3ffff has been res=
erved
[    0.532570] system 00:01: iomem range 0xfee00000-0xfee0ffff has been res=
erved
[    0.532631] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
[    0.532691] system 00:0b: ioport range 0x400-0x47f has been reserved
[    0.532747] system 00:0b: ioport range 0x1180-0x119f has been reserved
[    0.532802] system 00:0b: ioport range 0x500-0x57f has been reserved
[    0.532857] system 00:0b: iomem range 0xfed1c000-0xfed1ffff has been res=
erved
[    0.532912] system 00:0b: iomem range 0xfec00000-0xfecfffff could
not be reserved
[    0.532990] system 00:0b: iomem range 0xfed08000-0xfed08fff has been res=
erved
[    0.533045] system 00:0b: iomem range 0xff000000-0xffffffff has been res=
erved
[    0.537704] pci 0000:04:00.0: BAR 6: address space collision on of
device [0xfe400000-0xfe41ffff]
[    0.537806] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.537859] pci 0000:00:01.0:   IO window: disabled
[    0.537909] pci 0000:00:01.0:   MEM window: disabled
[    0.537961] pci 0000:00:01.0:   PREFETCH window: disabled
[    0.538014] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:02
[    0.538067] pci 0000:00:1c.0:   IO window: disabled
[    0.538119] pci 0000:00:1c.0:   MEM window: disabled
[    0.538170] pci 0000:00:1c.0:   PREFETCH window: disabled
[    0.538225] pci 0000:00:1c.4: PCI bridge, secondary bus 0000:03
[    0.538276] pci 0000:00:1c.4:   IO window: disabled
[    0.538329] pci 0000:00:1c.4:   MEM window: disabled
[    0.538382] pci 0000:00:1c.4:   PREFETCH window: disabled
[    0.538438] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:04
[    0.538492] pci 0000:00:1e.0:   IO window: 0xe000-0xefff
[    0.538547] pci 0000:00:1e.0:   MEM window: 0xfe400000-0xfe4fffff
[    0.538603] pci 0000:00:1e.0:   PREFETCH window: 0xe4000000-0xe40fffff
[    0.538664]   alloc irq_desc for 16 on node -1
[    0.538666]   alloc kstat_irqs on node -1
[    0.538670] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.538726] pci 0000:00:01.0: setting latency timer to 64
[    0.538732]   alloc irq_desc for 17 on node -1
[    0.538733]   alloc kstat_irqs on node -1
[    0.538736] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.538791] pci 0000:00:1c.0: setting latency timer to 64
[    0.538797] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.538854] pci 0000:00:1c.4: setting latency timer to 64
[    0.538859] pci 0000:00:1e.0: setting latency timer to 64
[    0.538862] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.538863] pci_bus 0000:00: resource 1 mem: [0x000000-0xfffffffffffffff=
f]
[    0.538865] pci_bus 0000:04: resource 0 io:  [0xe000-0xefff]
[    0.538867] pci_bus 0000:04: resource 1 mem: [0xfe400000-0xfe4fffff]
[    0.538868] pci_bus 0000:04: resource 2 pref mem [0xe4000000-0xe40fffff]
[    0.538870] pci_bus 0000:04: resource 3 io:  [0x00-0xffff]
[    0.538872] pci_bus 0000:04: resource 4 mem: [0x000000-0xfffffffffffffff=
f]
[    0.538890] NET: Registered protocol family 2
[    0.539050] IP route cache hash table entries: 131072 (order: 8,
1048576 bytes)
[    0.539801] TCP established hash table entries: 524288 (order: 11,
8388608 bytes)
[    0.542015] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.542326] TCP: Hash tables configured (established 524288 bind 65536)
[    0.542380] TCP reno registered
[    0.542540] NET: Registered protocol family 1
[    0.544676] pci 0000:00:02.0: Boot video device
[    0.592580] Unpacking initramfs...
[    0.738292] Freeing initrd memory: 8996k freed
[    0.740235] audit: initializing netlink socket (disabled)
[    0.740297] type 00 audit(1270905825.591:1): initialized
[    0.740630] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.741543] VFS: Disk quotas dquot_6.5.2
[    0.741624] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.741735] msgmni has been set to 7528
[    0.741935] alg: No test for stdrng (krng)
[    0.742018] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 253)
[    0.742095] io scheduler noop registered
[    0.742143] io scheduler anticipatory registered
[    0.742193] io scheduler deadline registered
[    0.742260] io scheduler cfq registered (default)
[    0.742370]   alloc irq_desc for 29 on node -1
[    0.742372]   alloc kstat_irqs on node -1
[    0.742379] pcieport 0000:00:01.0: irq 29 for MSI/MSI-X
[    0.742383] pcieport 0000:00:01.0: setting latency timer to 64
[    0.742452]   alloc irq_desc for 30 on node -1
[    0.742453]   alloc kstat_irqs on node -1
[    0.742459] pcieport 0000:00:1c.0: irq 30 for MSI/MSI-X
[    0.742466] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.742543]   alloc irq_desc for 31 on node -1
[    0.742544]   alloc kstat_irqs on node -1
[    0.742550] pcieport 0000:00:1c.4: irq 31 for MSI/MSI-X
[    0.742556] pcieport 0000:00:1c.4: setting latency timer to 64
[    0.743468] Linux agpgart interface v0.103
[    0.743518] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.743664] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    0.743961] 00:0a: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    0.744060] serial 0000:00:16.3: PCI INT B -> GSI 17 (level, low) -> IRQ=
 17
[    0.744196] 0000:00:16.3: ttyS1 at I/O 0xf0a0 (irq =3D 17) is a 16550A
[    0.744308] input: Macintosh mouse button emulation as
/devices/virtual/input/input0
[    0.744418] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    0.744472] PNP: PS/2 appears to have AUX port disabled, if this is
incorrect please boot with i8042.nopnp
[    0.745020] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.745122] mice: PS/2 mouse device common for all mice
[    0.745198] rtc_cmos 00:05: RTC can wake from S4
[    0.745268] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    0.745346] rtc0: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    0.745409] cpuidle: using governor ladder
[    0.745457] cpuidle: using governor menu
[    0.745506] No iBFT detected.
[    0.745763] TCP cubic registered
[    0.745876] NET: Registered protocol family 10
[    0.746277] lo: Disabled Privacy Extensions
[    0.746497] Mobile IPv6
[    0.746541] NET: Registered protocol family 17
[    0.746642] PM: Resume from disk failed.
[    0.746644] registered taskstats version 1
[    0.747016] rtc_cmos 00:05: setting system clock to 2010-04-10
13:23:46 UTC (1270905826)
[    0.747141] Freeing unused kernel memory: 580k freed
[    0.747295] Write protecting the kernel read-only data: 4144k
[    0.766870] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input1
[    0.812476] agpgart-intel 0000:00:00.0: Intel IGDNG/D Chipset
[    0.813332] agpgart-intel 0000:00:00.0: detected 32764K stolen memory
[    0.817174] e1000e: Intel(R) PRO/1000 Network Driver - 1.0.2-k2
[    0.817232] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[    0.822292] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
[    0.822382] ACPI: Power Button [PWRB]
[    0.822483] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.822559] ACPI: Power Button [PWRF]
[    0.861494] SCSI subsystem initialized
[    0.875673] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    0.875792]   alloc irq_desc for 20 on node -1
[    0.875794]   alloc kstat_irqs on node -1
[    0.875802] e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ=
 20
[    0.875864] e1000e 0000:00:19.0: setting latency timer to 64
[    0.875938]   alloc irq_desc for 32 on node -1
[    0.875940]   alloc kstat_irqs on node -1
[    0.875950] e1000e 0000:00:19.0: irq 32 for MSI/MSI-X
[    0.876524] usbcore: registered new interface driver usbfs
[    0.876594] usbcore: registered new interface driver hub
[    0.876665] usbcore: registered new device driver usb
[    0.877252] Intel(R) PRO/1000 Network Driver - version 7.3.21-k5-NAPI
[    0.877305] Copyright (c) 1999-2006 Intel Corporation.
[    0.877377]   alloc irq_desc for 21 on node -1
[    0.877379]   alloc kstat_irqs on node -1
[    0.877384] e1000 0000:04:00.0: PCI INT A -> GSI 21 (level, low) -> IRQ =
21
[    0.878280] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.886675] libata version 3.00 loaded.
[    0.899506] [drm] Initialized drm 1.1.0 20060810
[    1.131350] e1000: 0000:04:00.0: e1000_probe: (PCI:33MHz:32-bit)
00:07:e9:06:14:b5
[    1.168334] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connecti=
on
[    1.307655] 0000:00:19.0: eth1: (PCI Express:2.5GB/s:Width x1)
00:27:0e:0a:c9:79
[    1.307734] 0000:00:19.0: eth1: Intel(R) PRO/1000 Network Connection
[    1.307825] 0000:00:19.0: eth1: MAC: 9, PHY: 9, PBA No: ffffff-0ff
[    1.307905] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> I=
RQ 16
[    1.307996] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    1.308000] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    1.308071] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned
bus number 1
[    1.308170] ehci_hcd 0000:00:1a.0: debug port 2
[    1.312157] ehci_hcd 0000:00:1a.0: cache line size of 32 is not supported
[    1.312172] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xfe527000
[    1.330681] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.330761] usb usb1: New USB device found, idVendor=1D6b, idProduct=0002
[    1.330816] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    1.330893] usb usb1: Product: EHCI Host Controller
[    1.330943] usb usb1: Manufacturer: Linux 2.6.32-3-amd64 ehci_hcd
[    1.330997] usb usb1: SerialNumber: 0000:00:1a.0
[    1.331100] usb usb1: configuration #1 chosen from 1 choice
[    1.331172] hub 1-0:1.0: USB hub found
[    1.331223] hub 1-0:1.0: 3 ports detected
[    1.331308] ahci 0000:00:1f.2: version 3.0
[    1.331319]   alloc irq_desc for 19 on node -1
[    1.331320]   alloc kstat_irqs on node -1
[    1.331326] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    1.331409]   alloc irq_desc for 33 on node -1
[    1.331410]   alloc kstat_irqs on node -1
[    1.331419] ahci 0000:00:1f.2: irq 33 for MSI/MSI-X
[    1.350903] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3
Gbps 0x3f impl SATA mode
[    1.350991] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck pm led
clo pio slum part ems sxs apst
[    1.351073] ahci 0000:00:1f.2: setting latency timer to 64
[    1.394818] scsi0 : ahci
[    1.394942] scsi1 : ahci
[    1.395032] scsi2 : ahci
[    1.395117] scsi3 : ahci
[    1.395202] scsi4 : ahci
[    1.395287] scsi5 : ahci
[    1.395447] ata1: SATA max UDMA/133 abar m2048@0xfe525000 port
0xfe525100 irq 33
[    1.395523] ata2: SATA max UDMA/133 abar m2048@0xfe525000 port
0xfe525180 irq 33
[    1.395599] ata3: SATA max UDMA/133 abar m2048@0xfe525000 port
0xfe525200 irq 33
[    1.395676] ata4: SATA max UDMA/133 abar m2048@0xfe525000 port
0xfe525280 irq 33
[    1.395753] ata5: SATA max UDMA/133 abar m2048@0xfe525000 port
0xfe525300 irq 33
[    1.395831] ata6: SATA max UDMA/133 abar m2048@0xfe525000 port
0xfe525380 irq 33
[    1.395929] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.395987] i915 0000:00:02.0: setting latency timer to 64
[    1.406251] mtrr: type mismatch for d0000000,10000000 old:
write-back new: write-combining
[    1.406334] [drm] MTRR allocation failed.  Graphics performance may suff=
er.
[    1.406533]   alloc irq_desc for 34 on node -1
[    1.406535]   alloc kstat_irqs on node -1
[    1.406542] i915 0000:00:02.0: irq 34 for MSI/MSI-X
[    1.406550] [drm] set up 31M of stolen space
[    1.462091] ------------[ cut here ]------------
[    1.462146] WARNING: at
/build/mattems-linux-2.6_2.6.32-9-amd64-NYTFdD/linux-2.6-2.6.32-9/debian/bu=
ild/source_amd64_none/drivers/gpu/drm/drm_crtc_helper.c:1035
drm_helper_initial_config+0x41/0x5a [drm_kms_helper]()
[    1.462272] Hardware name:
[    1.462319] No connectors reported connected with modes
[    1.462372] Modules linked in: ata_generic(+) i915(+)
drm_kms_helper drm i2c_algo_bit ahci i2c_core video libata ehci_hcd(+)
e1000 usbcore output nls_base scsi_mod button e1000e intel_agp thermal
fan thermal_sys
[    1.462907] Pid: 298, comm: modprobe Tainted: G        W  2.6.32-3-amd64=
 #1
[    1.462963] Call Trace:
[    1.463010]  [<ffffffffa016b1e2>] ?
drm_helper_initial_config+0x41/0x5a [drm_kms_helper]
[    1.463090]  [<ffffffffa016b1e2>] ?
drm_helper_initial_config+0x41/0x5a [drm_kms_helper]
[    1.463172]  [<ffffffff8104dbf0>] ? warn_slowpath_common+0x77/0xa3
[    1.463227]  [<ffffffff8104dc78>] ? warn_slowpath_fmt+0x51/0x59
[    1.463281]  [<ffffffffa016b0af>] ?
drm_helper_probe_single_connector_modes+0x1df/0x26b [drm_kms_helper]
[    1.463365]  [<ffffffffa016b170>] ?
drm_helper_probe_connector_modes+0x35/0x66 [drm_kms_helper]
[    1.463446]  [<ffffffffa016b1e2>] ?
drm_helper_initial_config+0x41/0x5a [drm_kms_helper]
[    1.463536]  [<ffffffffa0176248>] ? i915_driver_load+0xebb/0xf87 [i915]
[    1.463596]  [<ffffffffa013be9c>] ? drm_sysfs_device_add+0x7f/0xa0 [drm]
[    1.463654]  [<ffffffffa013a222>] ? drm_get_dev+0x336/0x420 [drm]
[    1.463711]  [<ffffffff8119aa02>] ? local_pci_probe+0x12/0x16
[    1.463765]  [<ffffffff8119b652>] ? pci_device_probe+0xc0/0xe9
[    1.463821]  [<ffffffff81214fc0>] ? driver_probe_device+0xa3/0x14b
[    1.463875]  [<ffffffff812150b7>] ? __driver_attach+0x4f/0x6f
[    1.463929]  [<ffffffff81215068>] ? __driver_attach+0x0/0x6f
[    1.463981]  [<ffffffff8121488f>] ? bus_for_each_dev+0x43/0x74
[    1.464036]  [<ffffffff8121424f>] ? bus_add_driver+0xaf/0x1f8
[    1.464090]  [<ffffffff8121536f>] ? driver_register+0xa7/0x111
[    1.464151]  [<ffffffffa01b3000>] ? i915_init+0x0/0x52 [i915]
[    1.464205]  [<ffffffff8119b880>] ? __pci_register_driver+0x50/0xb7
[    1.464265]  [<ffffffffa01b3000>] ? i915_init+0x0/0x52 [i915]
[    1.464324]  [<ffffffffa01b3000>] ? i915_init+0x0/0x52 [i915]
[    1.464378]  [<ffffffff8100a065>] ? do_one_initcall+0x64/0x174
[    1.464432]  [<ffffffff8107a23a>] ? sys_init_module+0xc5/0x21a
[    1.464487]  [<ffffffff81010b42>] ? system_call_fastpath+0x16/0x1b
[    1.464541] ---[ end trace a7919e7f17c0a727 ]---
[    1.464595] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on mi=
nor 0
[    1.464696]   alloc irq_desc for 23 on node -1
[    1.464698]   alloc kstat_irqs on node -1
[    1.464703] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> I=
RQ 23
[    1.464767] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    1.464771] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    1.464832] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned
bus number 2
[    1.464931] ehci_hcd 0000:00:1d.0: debug port 2
[    1.468923] ehci_hcd 0000:00:1d.0: cache line size of 32 is not supported
[    1.468934] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xfe526000
[    1.482272] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.482355] usb usb2: New USB device found, idVendor=1D6b, idProduct=0002
[    1.482410] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    1.482485] usb usb2: Product: EHCI Host Controller
[    1.482536] usb usb2: Manufacturer: Linux 2.6.32-3-amd64 ehci_hcd
[    1.482590] usb usb2: SerialNumber: 0000:00:1d.0
[    1.482682] usb usb2: configuration #1 chosen from 1 choice
[    1.482752] hub 2-0:1.0: USB hub found
[    1.482804] hub 2-0:1.0: 3 ports detected
[    1.649821] usb 1-1: new high speed USB device using ehci_hcd and addres=
s 2
[    1.725621] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.725696] ata5: SATA link down (SStatus 0 SControl 300)
[    1.725761] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.725827] ata1: SATA link down (SStatus 0 SControl 300)
[    1.725889] ata6: SATA link down (SStatus 0 SControl 300)
[    1.726809] ata4.00: ATA-8: WDC WD5000AAKS-00V1A0, 05.01D05, max UDMA/133
[    1.726866] ata4.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32=
), AA
[    1.728033] ata4.00: configured for UDMA/133
[    1.729760] ata2.00: ATAPI: HL-DT-ST DVDRAM GH22NS50, TN02, max
UDMA/100, ATAPI AN
[    1.734092] ata2.00: configured for UDMA/100
[    1.757015] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRAM
GH22NS50  TN02 PQ: 0 ANSI: 5
[    1.781895] usb 1-1: New USB device found, idVendor=8087, idProduct=0020
[    1.781956] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    1.782037] usb 1-1: configuration #1 chosen from 1 choice
[    1.782162] hub 1-1:1.0: USB hub found
[    1.782261] hub 1-1:1.0: 6 ports detected
[    1.893173] usb 2-1: new high speed USB device using ehci_hcd and addres=
s 2
[    1.949013] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.949830] ata3.00: ATA-8: WDC WD10EAVS-00D7B0, 01.01A01, max UDMA/133
[    1.949889] ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth
31/32), AA
[    1.950828] ata3.00: configured for UDMA/133
[    1.965045] scsi 2:0:0:0: Direct-Access     ATA      WDC
WD10EAVS-00D 01.0 PQ: 0 ANSI: 5
[    1.965222] scsi 3:0:0:0: Direct-Access     ATA      WDC
WD5000AAKS-0 05.0 PQ: 0 ANSI: 5
[    1.973226] Uniform Multi-Platform E-IDE driver
[    1.977442] sd 2:0:0:0: [sda] 1953525168 512-byte logical blocks:
(1.00 TB/931 GiB)
[    1.977557] sd 2:0:0:0: [sda] Write Protect is off
[    1.977607] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.977629] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.977826]  sda:
[    1.977935] sd 3:0:0:0: [sdb] 976773168 512-byte logical blocks:
(500 GB/465 GiB)
[    1.978088] sd 3:0:0:0: [sdb] Write Protect is off
[    1.978139] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.978160] sd 3:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.978335]  sdb: sdb1 sdb2 < sdb5sr0: scsi3-mmc drive: 48x/48x
writer dvd-ram cd/rw xa/form2 cdda tray
[    2.000386] Uniform CD-ROM driver Revision: 3.20
[    2.000531] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    2.005239]  sda1
[    2.005472] sd 2:0:0:0: [sda] Attached SCSI disk
[    2.007980]  sdb6 >
[    2.008285] sd 3:0:0:0: [sdb] Attached SCSI disk
[    2.010603] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    2.010678] sd 2:0:0:0: Attached scsi generic sg1 type 0
[    2.010792] sd 3:0:0:0: Attached scsi generic sg2 type 0
[    2.025222] usb 2-1: New USB device found, idVendor=8087, idProduct=0020
[    2.025279] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    2.025378] usb 2-1: configuration #1 chosen from 1 choice
[    2.025490] hub 2-1:1.0: USB hub found
[    2.025591] hub 2-1:1.0: 6 ports detected
[    2.097154] usb 1-1.1: new high speed USB device using ehci_hcd and addr=
ess 3
[    2.189887] usb 1-1.1: New USB device found, idVendor=03f0, idProduct;17
[    2.189948] usb 1-1.1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[    2.190019] usb 1-1.1: Product: HP LaserJet M1005
[    2.190065] usb 1-1.1: Manufacturer: Hewlett-Packard
[    2.190113] usb 1-1.1: SerialNumber: KJ1Y5G5
[    2.190214] usb 1-1.1: configuration #1 chosen from 1 choice
[    2.260704] usb 1-1.2: new low speed USB device using ehci_hcd and addre=
ss 4
[    2.282342] device-mapper: uevent: version 1.0.3
[    2.282474] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01)
initialised: dm-devel@redhat.com
[    2.310644] kjournald starting.  Commit interval 5 seconds
[    2.310667] EXT3-fs: mounted filesystem with ordered data mode.
[    2.522096] usb 1-1.2: New USB device found, idVendor=051d, idProduct=00=
02
[    2.522161] usb 1-1.2: New USB device strings: Mfr=3D3, Product=3D1,
SerialNumber=3D2
[    2.522229] usb 1-1.2: Product: Back-UPS RS 1000 FW:7.g9a.I USB FW:g9a
[    2.522278] usb 1-1.2: Manufacturer: American Power Conversion
[    2.522327] usb 1-1.2: SerialNumber: BB0944000914
[    2.522435] usb 1-1.2: configuration #1 chosen from 1 choice
[    3.052879] udev: starting version 151
[    3.287467] ACPI: SSDT 00000000cb617c18 0038C (v01    AMI      IST
00000001 MSFT 03000001)
[    3.288926] Monitor-Mwait will be used to enter C-2 state
[    3.288950] Monitor-Mwait will be used to enter C-3 state
[    3.289037] processor LNXCPU:00: registered as cooling_device0
[    3.289732] processor LNXCPU:01: registered as cooling_device1
[    3.290320] processor LNXCPU:02: registered as cooling_device2
[    3.290904] processor LNXCPU:03: registered as cooling_device3
[    3.398992]   alloc irq_desc for 18 on node -1
[    3.398995]   alloc kstat_irqs on node -1
[    3.399002] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level,
low) -> IRQ 18
[    3.411744] parport_pc 00:03: reported by Plug and Play ACPI
[    3.411915] parport0: PC-style at 0x378 (0x778), irq 5 [PCSPP,TRISTATE,E=
PP]
[    3.416816] usblp0: USB Bidirectional printer dev 3 if 1 alt 0
proto 2 vid 0x03F0 pid 0x3B17
[    3.416895] usbcore: registered new interface driver usblp
[    3.481257] usbcore: registered new interface driver hiddev
[    3.552378] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    3.652271] Error: Driver 'pcspkr' is already registered, aborting...
[    3.673127]   alloc irq_desc for 22 on node -1
[    3.673130]   alloc kstat_irqs on node -1
[    3.673138] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level,
low) -> IRQ 22
[    3.673268] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    3.854748] hda_codec: ALC888: BIOS auto-probing.
[    3.856096] input: HDA Digital PCBeep as
/devices/pci0000:00/0000:00:1b.0/input/input5
[    4.544617] generic-usb 0003:051D:0002.0001: hiddev1,hidraw0: USB
HID v1.10 Device [American Power Conversion Back-UPS RS 1000
FW:7.g9a.I USB FW:g9a] on usb-0000:00:1a.0-1.2/input0
[    4.544752] usbcore: registered new interface driver usbhid
[    4.544801] usbhid: v2.6:USB HID core driver
[    5.157051] Adding 11301688k swap on /dev/sdb5.  Priority:-1
extents:1 across:11301688k
[    5.272427] EXT3 FS on sdb1, internal journal
[    5.603101] kjournald starting.  Commit interval 5 seconds
[    5.603357] EXT3 FS on sdb6, internal journal
[    5.603437] EXT3-fs: mounted filesystem with ordered data mode.
[    6.005444] loop: module loaded
[    6.497295] e1000e 0000:00:19.0: irq 32 for MSI/MSI-X
[    6.553013] e1000e 0000:00:19.0: irq 32 for MSI/MSI-X
[    6.553451] ADDRCONF(NETDEV_UP): eth1: link is not ready
[    9.364351] lp0: using parport0 (interrupt-driven).
[    9.382778] ppdev: user-space parallel port driver
[   10.059022] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: RX
[   10.060950] ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   20.797585] eth1: no IPv6 routers present
[51843.216116] i2c /dev entries driver
[51868.354576] i2c /dev entries driver
[54072.817502] w83627ehf: Found W83627DHG-P chip at 0xa10
[56313.371412] i2c /dev entries driver

Thanks,
Vedant

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
