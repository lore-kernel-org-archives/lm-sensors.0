From: descart avel <descartavel.1@gmail.com>
Date: Mon, 17 Aug 2015 23:02:53 +0000
Subject: [lm-sensors] ASRock AM1H-ITX
Message-Id: <CAJV44BPR3uN3NgsFQXHpAenqNyjMSTF3pHe9Vqw=3vAeGfpC-g@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="047d7b3a9ba229a048051d89cd7e"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--047d7b3a9ba229a048051d89cd7e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

++ Motherboard vendor and model
ASRock AM1H-ITX

++ Lm_sensors and kernel versions
Linux 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt11-1+deb8u3 (2015-08-04)
x86_64 GNU/Linux
lm-sensors 1:3.3.5-2

++ The output of sensors
# sensors
fam15h_power-pci-00c4
Adapter: PCI adapter
power1:        0.00 W  (crit =3D  25.00 W)

k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +17.6=C2=B0C  (high =3D +70.0=C2=B0C)
                       (crit =3D +70.0=C2=B0C, hyst =3D +69.0=C2=B0C)

++ The relevant parts of dmesg or /var/log/messages (not the whole
files, they are way too large)
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-3.16.0-4-amd64
root=3D/dev/mapper/vhs--vg-root ro quiet
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By
O.E.M./AM1H-ITX, BIOS P1.00 02/19/2014
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F04A0 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000007CF42080 00007C (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000007CF47520 00010C (v05 ALASKA A M I
  01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field
Pm2ControlBlock has zero address or length: 0x0000000000000000/0x1
(20140424/tbfadt-649)
[    0.000000] ACPI: DSDT 0x000000007CF42190 00538A (v02 ALASKA A M I
  00000000 INTL 20051117)
[    0.000000] ACPI: FACS 0x000000007CF75E80 000040
[    0.000000] ACPI: APIC 0x000000007CF47630 00007E (v03 ALASKA A M I
  01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000007CF476B0 000044 (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x000000007CF476F8 00003C (v01 ALASKA A M I
  01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x000000007CF47738 000038 (v01 ALASKA A M I
  01072009 AMI  00000005)
[    0.000000] ACPI: AAFT 0x000000007CF47770 0001A5 (v01 ALASKA
OEMAAFT  01072009 MSFT 00000097)
[    0.000000] ACPI: SSDT 0x000000007CF47918 000E58 (v01 AMD    AGESA
  00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000007CF48770 0046B7 (v02 AMD    AGESA
  00000002 MSFT 04000000)
[    0.000000] ACPI: CRAT 0x000000007CF4CE28 0003A8 (v01 AMD    AGESA
  00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x000000007CF4D1D0 0006CA (v01 AMD
CPMADPS4 00000001 INTL 20051117)
[    0.000000] ACPI: SSDT 0x000000007CF4D8A0 001120 (v01 AMD    CPMCMN
  00000001 INTL 20051117)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x05] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 5, version 33, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: IOAPIC (id[0x06] address[0xfec01000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 6, version 33, address 0xfec01000, GSI 24=
-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 72
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
(a few more of those)
[    0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffffffff]
[    0.000000] e820: [mem 0x7f000000-0xfebfffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512
nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88023ec00000 s80896
r8192 d21504 u524288
[    0.000000] pcpu-alloc: s80896 r8192 d21504 u524288 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 1793681
[    0.000069] ACPI: Core revision 20140424
[    0.014305] ACPI: All ACPI Tables successfully acquired
[    0.035425] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.075079] smpboot: CPU0: AMD Athlon(tm) 5350 APU with Radeon(tm)
R3 (fam: 16, model: 00, stepping: 01)
[    0.179535] Performance Events: AMD PMU driver.
[    0.179541] ... version:                0
[    0.179544] ... bit width:              48
[    0.179545] ... generic registers:      4
[    0.179547] ... value mask:             0000ffffffffffff
[    0.179549] ... max period:             00007fffffffffff
[    0.179551] ... fixed-purpose events:   0
[    0.179552] ... event mask:             000000000000000f
[    0.230143] PM: Registering ACPI NVS region [mem
0x7cebe000-0x7cf7efff] (790528 bytes)
[    0.230176] PM: Registering ACPI NVS region [mem
0x7e3c9000-0x7e3d0fff] (32768 bytes)
[    0.232881] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.232883] mtrr: probably your BIOS does not setup all CPUs.
[    0.232884] mtrr: corrected configuration.
[    0.244552] ACPI: Added _OSI(Module Device)
[    0.244559] ACPI: Added _OSI(Processor Device)
[    0.244561] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.244563] ACPI: Added _OSI(Processor Aggregator Device)
[    0.247364] ACPI: Executed 1 blocks of module-level executable AML code
[    0.254395] ACPI: Interpreter enabled
[    0.254406] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep
State [\_S1_] (20140424/hwxface-580)
[    0.254414] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep
State [\_S2_] (20140424/hwxface-580)
[    0.255152] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=3Dnocrs" and report a bug
[    0.358668] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    0.359211] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.359221] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.359516] acpi PNP0A08:00: _OSC: platform does not support
[PCIeHotplug PME]
[    0.359777] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]

...i'm not even sure what i'm looking for here.

++ The output of (as root) sensors-detect
attached

++ The output of lsmod
Module                  Size  Used by
cfg80211              405538  0
rfkill                 18867  2 cfg80211
nfsd                  263032  2
auth_rpcgss            51211  1 nfsd
oid_registry           12419  1 auth_rpcgss
nfs_acl                12511  1 nfsd
nfs                   188136  0
lockd                  83389  2 nfs,nfsd
fscache                45542  1 nfs
sunrpc                237402  6 nfs,nfsd,auth_rpcgss,lockd,nfs_acl
joydev                 17063  0
hid_logitech_dj        17192  0
usbhid                 44460  0
hid                   102264  3 usbhid,hid_logitech_dj
amd_freq_sensitivity    12452  0
kvm_amd                59091  0
kvm                   388635  1 kvm_amd
crc32_pclmul           12915  0
evdev                  17445  15
ghash_clmulni_intel    12978  0
snd_hda_codec_realtek    67127  1
snd_hda_codec_generic    63181  1 snd_hda_codec_realtek
radeon               1345162  0
snd_hda_codec_hdmi     45118  1
aesni_intel           151423  0
aes_x86_64             16719  1 aesni_intel
lrw                    12757  1 aesni_intel
gf128mul               12970  1 lrw
glue_helper            12695  1 aesni_intel
ablk_helper            12572  1 aesni_intel
cryptd                 14516  3 ghash_clmulni_intel,aesni_intel,ablk_helper
psmouse                99249  0
snd_hda_intel          26327  5
serio_raw              12849  0
pcspkr                 12595  0
snd_hda_controller     26646  1 snd_hda_intel
snd_hda_codec         104463  5
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_inte=
l,snd_hda_controller
ttm                    77862  1 radeon
snd_hwdep              13148  1 snd_hda_codec
k10temp                12618  0
snd_pcm                88662  4
snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel,snd_hda_controller
snd_timer              26614  1 snd_pcm
drm_kms_helper         49210  1 radeon
fam15h_power           12684  0
edac_mce_amd           21166  0
snd                    65244  18
snd_hda_codec_realtek,snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_pcm,snd_hd=
a_codec_generic,snd_hda_codec,snd_hda_intel
drm                   249955  3 ttm,drm_kms_helper,radeon
edac_core              51465  0
soundcore              13026  2 snd,snd_hda_codec
i2c_piix4              20864  0
i2c_algo_bit           12751  1 radeon
shpchp                 31121  0
i2c_core               46012  5 drm,i2c_piix4,drm_kms_helper,i2c_algo_bit,r=
adeon
tpm_tis                17231  0
tpm                    31511  1 tpm_tis
acpi_cpufreq           17218  0
processor              28221  5 acpi_cpufreq
button                 12944  0
thermal_sys            27642  1 processor
fuse                   83350  3
autofs4                35529  2
ext4                  473802  5
crc16                  12343  1 ext4
mbcache                17171  1 ext4
jbd2                   82413  1 ext4
dm_mod                 89405  15
sg                     29973  0
sd_mod                 44356  3
crc_t10dif             12431  1 sd_mod
crct10dif_generic      12581  0
ohci_pci               12808  0
crct10dif_pclmul       13387  1
crct10dif_common       12356  3 crct10dif_pclmul,crct10dif_generic,crc_t10d=
if
crc32c_intel           21809  0
ahci                   33291  2
libahci                27158  1 ahci
ohci_hcd               42982  1 ohci_pci
xhci_hcd              148881  0
ehci_pci               12512  0
ehci_hcd               69837  1 ehci_pci
libata                177457  2 ahci,libahci
usbcore               195340  6
ohci_hcd,ohci_pci,ehci_hcd,ehci_pci,usbhid,xhci_hcd
scsi_mod              191405  3 sg,libata,sd_mod
r8169                  68262  0
usb_common             12440  1 usbcore
mii                    12675  1 r8169

++ If a PCI chip problem: the output of lspci -nn
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
16h Processor Root Complex [1022:1536]
00:01.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
[AMD/ATI] Kabini [Radeon HD 8400 / R3 Series] [1002:9830]
00:01.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI]
Kabini HDMI/DP Audio [1002:9840]
00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
16h Processor Function 0 [1022:1538]
00:02.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family
16h Processor Functions 5:1 [1022:1439]
00:02.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family
16h Processor Functions 5:1 [1022:1439]
00:10.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] FCH
USB XHCI Controller [1022:7814] (rev 01)
00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH
SATA Controller [AHCI mode] [1022:7801] (rev 40)
00:12.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] FCH
USB OHCI Controller [1022:7807] (rev 39)
00:12.2 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] FCH
USB EHCI Controller [1022:7808] (rev 39)
00:13.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] FCH
USB OHCI Controller [1022:7807] (rev 39)
00:13.2 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] FCH
USB EHCI Controller [1022:7808] (rev 39)
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus
Controller [1022:780b] (rev 3a)
00:14.2 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] FCH
Azalia Controller [1022:780d] (rev 02)
00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC
Bridge [1022:780e] (rev 11)
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
16h Processor Function 0 [1022:1530]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
16h Processor Function 1 [1022:1531]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
16h Processor Function 2 [1022:1532]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
16h Processor Function 3 [1022:1533]
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
16h Processor Function 4 [1022:1534]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family
16h Processor Function 5 [1022:1535]
01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168]
(rev 11)
02:00.0 USB controller [0c03]: ASMedia Technology Inc. ASM1042A USB
3.0 Host Controller [1b21:1142]


++ If an I2C sensor chip problem: the output of (as root) i2cdetect X
where X =3D the bus number (run i2cdetect -l to list the buses)
# i2cdetect -l
(nothing)

++ Part numbers of chips on your motherboard you think are the sensor
chips (look at your motherboard)
also not sure what to look for.

I will install windows on this build soon, and then will add any
information i get from there.

--047d7b3a9ba229a048051d89cd7e
Content-Type: text/plain; charset=US-ASCII; name="am1h-itx_lm-detect.txt"
Content-Disposition: attachment; filename="am1h-itx_lm-detect.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_idgiztgx0

IyAuL3NlbnNvcnMtZGV0ZWN0IAojIHNlbnNvcnMtZGV0ZWN0IHJldmlzaW9uIDYzMTMgKDIwMTUt
MDgtMTAgMTE6MDQ6NTMgKzAyMDApCiMgQm9hcmQ6IEFTUm9jayBBTTFILUlUWAojIEtlcm5lbDog
My4xNi4wLTQtYW1kNjQgeDg2XzY0CiMgUHJvY2Vzc29yOiBBTUQgQXRobG9uKHRtKSA1MzUwIEFQ
VSB3aXRoIFJhZGVvbih0bSkgUjMgKDIyLzAvMSkKClRoaXMgcHJvZ3JhbSB3aWxsIGhlbHAgeW91
IGRldGVybWluZSB3aGljaCBrZXJuZWwgbW9kdWxlcyB5b3UgbmVlZAp0byBsb2FkIHRvIHVzZSBs
bV9zZW5zb3JzIG1vc3QgZWZmZWN0aXZlbHkuIEl0IGlzIGdlbmVyYWxseSBzYWZlCmFuZCByZWNv
bW1lbmRlZCB0byBhY2NlcHQgdGhlIGRlZmF1bHQgYW5zd2VycyB0byBhbGwgcXVlc3Rpb25zLAp1
bmxlc3MgeW91IGtub3cgd2hhdCB5b3UncmUgZG9pbmcuCgpTb21lIHNvdXRoIGJyaWRnZXMsIENQ
VXMgb3IgbWVtb3J5IGNvbnRyb2xsZXJzIGNvbnRhaW4gZW1iZWRkZWQgc2Vuc29ycy4KRG8geW91
IHdhbnQgdG8gc2NhbiBmb3IgdGhlbT8gVGhpcyBpcyB0b3RhbGx5IHNhZmUuIChZRVMvbm8pOiAK
TW9kdWxlIGNwdWlkIGxvYWRlZCBzdWNjZXNzZnVsbHkuClNpbGljb24gSW50ZWdyYXRlZCBTeXN0
ZW1zIFNJUzU1OTUuLi4gICAgICAgICAgICAgICAgICAgICAgIE5vClZJQSBWVDgyQzY4NiBJbnRl
Z3JhdGVkIFNlbnNvcnMuLi4gICAgICAgICAgICAgICAgICAgICAgICAgIE5vClZJQSBWVDgyMzEg
SW50ZWdyYXRlZCBTZW5zb3JzLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vCkFNRCBL
OCB0aGVybWFsIHNlbnNvcnMuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5v
CkFNRCBGYW1pbHkgMTBoIHRoZXJtYWwgc2Vuc29ycy4uLiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE5vCkFNRCBGYW1pbHkgMTFoIHRoZXJtYWwgc2Vuc29ycy4uLiAgICAgICAgICAgICAgICAg
ICAgICAgICAgIE5vCkFNRCBGYW1pbHkgMTJoIGFuZCAxNGggdGhlcm1hbCBzZW5zb3JzLi4uICAg
ICAgICAgICAgICAgICAgIE5vCkFNRCBGYW1pbHkgMTVoIHRoZXJtYWwgc2Vuc29ycy4uLiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE5vCkFNRCBGYW1pbHkgMTZoIHRoZXJtYWwgc2Vuc29ycy4u
LiAgICAgICAgICAgICAgICAgICAgICAgICAgIFN1Y2Nlc3MhCiAgICAoZHJpdmVyIGBrMTB0ZW1w
JykKQU1EIEZhbWlseSAxNWggcG93ZXIgc2Vuc29ycy4uLiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgTm8KQU1EIEZhbWlseSAxNmggcG93ZXIgc2Vuc29ycy4uLiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgU3VjY2VzcyEKICAgIChkcml2ZXIgYGZhbTE1aF9wb3dlcicpCkludGVsIGRp
Z2l0YWwgdGhlcm1hbCBzZW5zb3IuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vCklu
dGVsIEFNQiBGQi1ESU1NIHRoZXJtYWwgc2Vuc29yLi4uICAgICAgICAgICAgICAgICAgICAgICAg
IE5vCkludGVsIDU1MDAvNTUyMC9YNTggdGhlcm1hbCBzZW5zb3IuLi4gICAgICAgICAgICAgICAg
ICAgICAgIE5vClZJQSBDNyB0aGVybWFsIHNlbnNvci4uLiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE5vClZJQSBOYW5vIHRoZXJtYWwgc2Vuc29yLi4uICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE5vCgpTb21lIFN1cGVyIEkvTyBjaGlwcyBjb250YWluIGVtYmVk
ZGVkIHNlbnNvcnMuIFdlIGhhdmUgdG8gd3JpdGUgdG8Kc3RhbmRhcmQgSS9PIHBvcnRzIHRvIHBy
b2JlIHRoZW0uIFRoaXMgaXMgdXN1YWxseSBzYWZlLgpEbyB5b3Ugd2FudCB0byBzY2FuIGZvciBT
dXBlciBJL08gc2Vuc29ycz8gKFlFUy9ubyk6IApQcm9iaW5nIGZvciBTdXBlci1JL08gYXQgMHgy
ZS8weDJmClRyeWluZyBmYW1pbHkgYE5hdGlvbmFsIFNlbWljb25kdWN0b3IvSVRFJy4uLiAgICAg
ICAgICAgICAgIE5vClRyeWluZyBmYW1pbHkgYFNNU0MnLi4uICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE5vClRyeWluZyBmYW1pbHkgYFZJQS9XaW5ib25kL051dm90b24vRmlu
dGVrJy4uLiAgICAgICAgICAgICAgIFllcwpGb3VuZCBgTnV2b3RvbiBOQ1Q1NTczRC9OQ1Q1NTc3
RC9OQ1Q2Nzc2RiBTdXBlciBJTyBTZW5zb3JzJyBTdWNjZXNzIQogICAgKGFkZHJlc3MgMHgyOTAs
IGRyaXZlciBgbmN0Njc3NScpClByb2JpbmcgZm9yIFN1cGVyLUkvTyBhdCAweDRlLzB4NGYKVHJ5
aW5nIGZhbWlseSBgTmF0aW9uYWwgU2VtaWNvbmR1Y3Rvci9JVEUnLi4uICAgICAgICAgICAgICAg
Tm8KVHJ5aW5nIGZhbWlseSBgU01TQycuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgTm8KVHJ5aW5nIGZhbWlseSBgVklBL1dpbmJvbmQvTnV2b3Rvbi9GaW50ZWsnLi4uICAg
ICAgICAgICAgICAgTm8KVHJ5aW5nIGZhbWlseSBgSVRFJy4uLiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTm8KClNvbWUgc3lzdGVtcyAobWFpbmx5IHNlcnZlcnMpIGltcGxl
bWVudCBJUE1JLCBhIHNldCBvZiBjb21tb24gaW50ZXJmYWNlcwp0aHJvdWdoIHdoaWNoIHN5c3Rl
bSBoZWFsdGggZGF0YSBtYXkgYmUgcmV0cmlldmVkLCBhbW9uZ3N0IG90aGVyIHRoaW5ncy4KV2Ug
Zmlyc3QgdHJ5IHRvIGdldCB0aGUgaW5mb3JtYXRpb24gZnJvbSBTTUJJT1MuIElmIHdlIGRvbid0
IGZpbmQgaXQKdGhlcmUsIHdlIGhhdmUgdG8gcmVhZCBmcm9tIGFyYml0cmFyeSBJL08gcG9ydHMg
dG8gcHJvYmUgZm9yIHN1Y2gKaW50ZXJmYWNlcy4gVGhpcyBpcyBub3JtYWxseSBzYWZlLiBEbyB5
b3Ugd2FudCB0byBzY2FuIGZvciBJUE1JCmludGVyZmFjZXM/IChZRVMvbm8pOiAKUHJvYmluZyBm
b3IgYElQTUkgQk1DIEtDUycgYXQgMHhjYTAuLi4gICAgICAgICAgICAgICAgICAgICAgTm8KUHJv
YmluZyBmb3IgYElQTUkgQk1DIFNNSUMnIGF0IDB4Y2E4Li4uICAgICAgICAgICAgICAgICAgICAg
Tm8KClNvbWUgaGFyZHdhcmUgbW9uaXRvcmluZyBjaGlwcyBhcmUgYWNjZXNzaWJsZSB0aHJvdWdo
IHRoZSBJU0EgSS9PIHBvcnRzLgpXZSBoYXZlIHRvIHdyaXRlIHRvIGFyYml0cmFyeSBJL08gcG9y
dHMgdG8gcHJvYmUgdGhlbS4gVGhpcyBpcyB1c3VhbGx5CnNhZmUgdGhvdWdoLiBZZXMsIHlvdSBk
byBoYXZlIElTQSBJL08gcG9ydHMgZXZlbiBpZiB5b3UgZG8gbm90IGhhdmUgYW55CklTQSBzbG90
cyEgRG8geW91IHdhbnQgdG8gc2NhbiB0aGUgSVNBIEkvTyBwb3J0cz8gKHllcy9OTyk6IAoKTGFz
dGx5LCB3ZSBjYW4gcHJvYmUgdGhlIEkyQy9TTUJ1cyBhZGFwdGVycyBmb3IgY29ubmVjdGVkIGhh
cmR3YXJlCm1vbml0b3JpbmcgZGV2aWNlcy4gVGhpcyBpcyB0aGUgbW9zdCByaXNreSBwYXJ0LCBh
bmQgd2hpbGUgaXQgd29ya3MKcmVhc29uYWJseSB3ZWxsIG9uIG1vc3Qgc3lzdGVtcywgaXQgaGFz
IGJlZW4gcmVwb3J0ZWQgdG8gY2F1c2UgdHJvdWJsZQpvbiBzb21lIHN5c3RlbXMuCkRvIHlvdSB3
YW50IHRvIHByb2JlIHRoZSBJMkMvU01CdXMgYWRhcHRlcnMgbm93PyAoWUVTL25vKTogClVzaW5n
IGRyaXZlciBgaTJjLXBpaXg0JyBmb3IgZGV2aWNlIDAwMDA6MDA6MTQuMDogQU1EIEh1ZHNvbi0y
IFNNQnVzCk1vZHVsZSBpMmMtZGV2IGxvYWRlZCBzdWNjZXNzZnVsbHkuCgpOZXh0IGFkYXB0ZXI6
IFNNQnVzIFBJSVg0IGFkYXB0ZXIgYXQgMGIwMCAoaTJjLTApCkRvIHlvdSB3YW50IHRvIHNjYW4g
aXQ/ICh5ZXMvTk8vc2VsZWN0aXZlbHkpOiAKCk5leHQgYWRhcHRlcjogU01CdXMgUElJWDQgYWRh
cHRlciBhdCAwYjIwIChpMmMtMSkKRG8geW91IHdhbnQgdG8gc2NhbiBpdD8gKHllcy9OTy9zZWxl
Y3RpdmVseSk6IAoKCk5vdyBmb2xsb3dzIGEgc3VtbWFyeSBvZiB0aGUgcHJvYmVzIEkgaGF2ZSBq
dXN0IGRvbmUuCkp1c3QgcHJlc3MgRU5URVIgdG8gY29udGludWU6IAoKRHJpdmVyIGBrMTB0ZW1w
JyAoYXV0b2xvYWRlZCk6CiAgKiBDaGlwIGBBTUQgRmFtaWx5IDE2aCB0aGVybWFsIHNlbnNvcnMn
IChjb25maWRlbmNlOiA5KQoKRHJpdmVyIGBuY3Q2Nzc1JzoKICAqIElTQSBidXMsIGFkZHJlc3Mg
MHgyOTAKICAgIENoaXAgYE51dm90b24gTkNUNTU3M0QvTkNUNTU3N0QvTkNUNjc3NkYgU3VwZXIg
SU8gU2Vuc29ycycgKGNvbmZpZGVuY2U6IDkpCgpEcml2ZXIgYGZhbTE1aF9wb3dlcicgKGF1dG9s
b2FkZWQpOgogICogQ2hpcCBgQU1EIEZhbWlseSAxNmggcG93ZXIgc2Vuc29ycycgKGNvbmZpZGVu
Y2U6IDkpCgpEbyB5b3Ugd2FudCB0byBnZW5lcmF0ZSAvZXRjL3N5c2NvbmZpZy9sbV9zZW5zb3Jz
PyAoeWVzL05PKTogWUVTCkNvcHkgcHJvZy9pbml0L2xtX3NlbnNvcnMuc2VydmljZSB0byAvbGli
L3N5c3RlbWQvc3lzdGVtCmFuZCBydW4gJ3N5c3RlbWN0bCBlbmFibGUgbG1fc2Vuc29ycy5zZXJ2
aWNlJwpmb3IgaW5pdGlhbGl6YXRpb24gYXQgYm9vdCB0aW1lLgpVbmxvYWRpbmcgaTJjLWRldi4u
LiBPSwpVbmxvYWRpbmcgY3B1aWQuLi4gT0sKCgo=
--047d7b3a9ba229a048051d89cd7e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--047d7b3a9ba229a048051d89cd7e--
