From: hanxing wang <hanker007@gmail.com>
Date: Sat, 14 Aug 2010 15:40:29 +0000
Subject: [lm-sensors] lm-sensors didn't work well on thinkpad x200
Message-Id: <AANLkTikCkiRuPNmXNY8HJZuwrthORMfwdxWtqRTMu1hP@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4411091239395250104=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4411091239395250104==
Content-Type: multipart/alternative; boundary=000e0cd5f0f249e2b1048dca6b20

--000e0cd5f0f249e2b1048dca6b20
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I have install latest version arch linux on thinkpad X200 laptop. But It ca=
n
show few sensors.

#sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +46.0=B0C  (crit =3D +127.0=B0C)
temp2:       +46.0=B0C  (crit =3D +104.0=B0C)

thinkpad-isa-0000
Adapter: ISA adapter
fan1:       1980 RPM
temp1:       +46.0=B0C
temp2:       +46.0=B0C
temp3:        +0.0=B0C
temp4:       +48.0=B0C
temp5:        +0.0=B0C
temp6:        +0.0=B0C
temp7:        +0.0=B0C
temp8:        +0.0=B0C
temp9:       +48.0=B0C
temp10:      +49.0=B0C
temp11:       +0.0=B0C
temp12:       +0.0=B0C
temp13:       +0.0=B0C
temp14:       +0.0=B0C
temp15:       +0.0=B0C
temp16:       +0.0=B0C
ERROR: Can't get value of subfeature temp3_input: Can't read
ERROR: Can't get value of subfeature temp5_input: Can't read
ERROR: Can't get value of subfeature temp6_input: Can't read
ERROR: Can't get value of subfeature temp7_input: Can't read
ERROR: Can't get value of subfeature temp8_input: Can't read
ERROR: Can't get value of subfeature temp11_input: Can't read
ERROR: Can't get value of subfeature temp12_input: Can't read
ERROR: Can't get value of subfeature temp13_input: Can't read
ERROR: Can't get value of subfeature temp14_input: Can't read
ERROR: Can't get value of subfeature temp15_input: Can't read
ERROR: Can't get value of subfeature temp16_input: Can't read




#lspci -v
00:00.0 Host bridge: Intel Corporation Mobile 4 Series Chipset Memory
Controller Hub (rev 07)
    Subsystem: Lenovo Device 20e0
    Flags: bus master, fast devsel, latency 0
    Capabilities: [e0] Vendor Specific Information: Len=3D0a <?>
    Kernel driver in use: agpgart-intel
    Kernel modules: intel-agp

00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series Chipse=
t
Integrated Graphics Controller (rev 07) (prog-if 00 [VGA controller])
    Subsystem: Lenovo Device 20e4
    Flags: bus master, fast devsel, latency 0, IRQ 31
    Memory at f2000000 (64-bit, non-prefetchable) [size=3D4M]
    Memory at d0000000 (64-bit, prefetchable) [size=3D256M]
    I/O ports at 1800 [size=3D8]
    Expansion ROM at <unassigned> [disabled]
    Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
    Capabilities: [d0] Power Management version 3
    Kernel driver in use: i915
    Kernel modules: i915

00:02.1 Display controller: Intel Corporation Mobile 4 Series Chipset
Integrated Graphics Controller (rev 07)
    Subsystem: Lenovo Device 20e4
    Flags: bus master, fast devsel, latency 0
    Memory at f2400000 (64-bit, non-prefetchable) [size=3D1M]
    Capabilities: [d0] Power Management version 3

00:03.0 Communication controller: Intel Corporation Mobile 4 Series Chipset
MEI Controller (rev 07)
    Subsystem: Lenovo Device 20e6
    Flags: bus master, fast devsel, latency 0, IRQ 11
    Memory at f2826800 (64-bit, non-prefetchable) [size=3D16]
    Capabilities: [50] Power Management version 3
    Capabilities: [8c] MSI: Enable- Count=3D1/1 Maskable- 64bit+

00:03.3 Serial controller: Intel Corporation Mobile 4 Series Chipset AMT SO=
L
Redirection (rev 07) (prog-if 02 [16550])
    Subsystem: Lenovo Device 20ec
    Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 17
    I/O ports at 1830 [size=3D8]
    Memory at f2624000 (32-bit, non-prefetchable) [size=3D4K]
    Capabilities: [c8] Power Management version 3
    Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
    Kernel driver in use: serial

00:19.0 Ethernet controller: Intel Corporation 82567LM Gigabit Network
Connection (rev 03)
    Subsystem: Lenovo Device 20ee
    Flags: bus master, fast devsel, latency 0, IRQ 28
    Memory at f2600000 (32-bit, non-prefetchable) [size=3D128K]
    Memory at f2625000 (32-bit, non-prefetchable) [size=3D4K]
    I/O ports at 1840 [size=3D32]
    Capabilities: [c8] Power Management version 2
    Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
    Capabilities: [e0] PCI Advanced Features
    Kernel driver in use: e1000e
    Kernel modules: e1000e

00:1a.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #4 (rev 03) (prog-if 00 [UHCI])
    Subsystem: Lenovo Device 20f0
    Flags: bus master, medium devsel, latency 0, IRQ 20
    I/O ports at 1860 [size=3D32]
    Capabilities: [50] PCI Advanced Features
    Kernel driver in use: uhci_hcd
    Kernel modules: uhci-hcd

00:1a.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #5 (rev 03) (prog-if 00 [UHCI])
    Subsystem: Lenovo Device 20f0
    Flags: bus master, medium devsel, latency 0, IRQ 21
    I/O ports at 1880 [size=3D32]
    Capabilities: [50] PCI Advanced Features
    Kernel driver in use: uhci_hcd
    Kernel modules: uhci-hcd

00:1a.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #6 (rev 03) (prog-if 00 [UHCI])
    Subsystem: Lenovo Device 20f0
    Flags: bus master, medium devsel, latency 0, IRQ 22
    I/O ports at 18a0 [size=3D32]
    Capabilities: [50] PCI Advanced Features
    Kernel driver in use: uhci_hcd
    Kernel modules: uhci-hcd

00:1a.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI
Controller #2 (rev 03) (prog-if 20 [EHCI])
    Subsystem: Lenovo Device 20f1
    Flags: bus master, medium devsel, latency 0, IRQ 23
    Memory at f2826c00 (32-bit, non-prefetchable) [size=3D1K]
    Capabilities: [50] Power Management version 2
    Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
    Capabilities: [98] PCI Advanced Features
    Kernel driver in use: ehci_hcd
    Kernel modules: ehci-hcd

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio
Controller (rev 03)
    Subsystem: Lenovo Device 20f2
    Flags: bus master, fast devsel, latency 0, IRQ 29
    Memory at f2620000 (64-bit, non-prefetchable) [size=3D16K]
    Capabilities: [50] Power Management version 2
    Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
    Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
    Capabilities: [100] Virtual Channel
    Capabilities: [130] Root Complex Link
    Kernel driver in use: HDA Intel
    Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port
1 (rev 03) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
    I/O behind bridge: 00003000-00003fff
    Memory behind bridge: bc000000-bc1fffff
    Prefetchable memory behind bridge: 00000000bc200000-00000000bc3fffff
    Capabilities: [40] Express Root Port (Slot+), MSI 00
    Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
    Capabilities: [90] Subsystem: Lenovo Device 20f3
    Capabilities: [a0] Power Management version 2
    Capabilities: [100] Virtual Channel
    Capabilities: [180] Root Complex Link
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port
2 (rev 03) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
    I/O behind bridge: 00004000-00004fff
    Memory behind bridge: f2500000-f25fffff
    Prefetchable memory behind bridge: 00000000bc400000-00000000bc5fffff
    Capabilities: [40] Express Root Port (Slot+), MSI 00
    Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
    Capabilities: [90] Subsystem: Lenovo Device 20f3
    Capabilities: [a0] Power Management version 2
    Capabilities: [100] Virtual Channel
    Capabilities: [180] Root Complex Link
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1c.3 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port
4 (rev 03) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=3D00, secondary=3D05, subordinate=3D0c, sec-latency=3D0
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: f0000000-f1ffffff
    Prefetchable memory behind bridge: 00000000f2900000-00000000f29fffff
    Capabilities: [40] Express Root Port (Slot+), MSI 00
    Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
    Capabilities: [90] Subsystem: Lenovo Device 20f3
    Capabilities: [a0] Power Management version 2
    Capabilities: [100] Virtual Channel
    Capabilities: [180] Root Complex Link
    Kernel driver in use: pcieport
    Kernel modules: shpchp

00:1d.0 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #1 (rev 03) (prog-if 00 [UHCI])
    Subsystem: Lenovo Device 20f0
    Flags: bus master, medium devsel, latency 0, IRQ 16
    I/O ports at 18c0 [size=3D32]
    Capabilities: [50] PCI Advanced Features
    Kernel driver in use: uhci_hcd
    Kernel modules: uhci-hcd

00:1d.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #2 (rev 03) (prog-if 00 [UHCI])
    Subsystem: Lenovo Device 20f0
    Flags: bus master, medium devsel, latency 0, IRQ 17
    I/O ports at 18e0 [size=3D32]
    Capabilities: [50] PCI Advanced Features
    Kernel driver in use: uhci_hcd
    Kernel modules: uhci-hcd

00:1d.2 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI
Controller #3 (rev 03) (prog-if 00 [UHCI])
    Subsystem: Lenovo Device 20f0
    Flags: bus master, medium devsel, latency 0, IRQ 18
    I/O ports at 1c00 [size=3D32]
    Capabilities: [50] PCI Advanced Features
    Kernel driver in use: uhci_hcd
    Kernel modules: uhci-hcd

00:1d.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI
Controller #1 (rev 03) (prog-if 20 [EHCI])
    Subsystem: Lenovo Device 20f1
    Flags: bus master, medium devsel, latency 0, IRQ 19
    Memory at f2827000 (32-bit, non-prefetchable) [size=3D1K]
    Capabilities: [50] Power Management version 2
    Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
    Capabilities: [98] PCI Advanced Features
    Kernel driver in use: ehci_hcd
    Kernel modules: ehci-hcd

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93)
(prog-if 01 [Subtractive decode])
    Flags: bus master, fast devsel, latency 0
    Bus: primary=3D00, secondary=3D0d, subordinate=3D0d, sec-latency=3D0
    Capabilities: [50] Subsystem: Lenovo Device 20f4

00:1f.0 ISA bridge: Intel Corporation ICH9M-E LPC Interface Controller (rev
03)
    Subsystem: Lenovo Device 20f5
    Flags: bus master, medium devsel, latency 0
    Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
    Kernel modules: iTCO_wdt

00:1f.2 SATA controller: Intel Corporation ICH9M/M-E SATA AHCI Controller
(rev 03) (prog-if 01 [AHCI 1.0])
    Subsystem: Lenovo Device 20f8
    Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 27
    I/O ports at 1c48 [size=3D8]
    I/O ports at 183c [size=3D4]
    I/O ports at 1c40 [size=3D8]
    I/O ports at 1838 [size=3D4]
    I/O ports at 1c20 [size=3D32]
    Memory at f2826000 (32-bit, non-prefetchable) [size=3D2K]
    Capabilities: [80] MSI: Enable+ Count=3D1/16 Maskable- 64bit-
    Capabilities: [70] Power Management version 3
    Capabilities: [a8] SATA HBA v1.0
    Capabilities: [b0] PCI Advanced Features
    Kernel driver in use: ahci
    Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev
03)
    Subsystem: Lenovo Device 20f9
    Flags: medium devsel, IRQ 23
    Memory at f2827400 (64-bit, non-prefetchable) [size=3D256]
    I/O ports at 1c60 [size=3D32]
    Kernel driver in use: i801_smbus
    Kernel modules: i2c-i801

03:00.0 Network controller: Intel Corporation PRO/Wireless 5100 AGN [Shiloh=
]
Network Connection
    Subsystem: Intel Corporation PRO/Wireless 5100AGN Network Connection
    Flags: bus master, fast devsel, latency 0, IRQ 30
    Memory at f2500000 (64-bit, non-prefetchable) [size=3D8K]
    Capabilities: [c8] Power Management version 3
    Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
    Capabilities: [e0] Express Endpoint, MSI 00
    Capabilities: [100] Advanced Error Reporting
    Capabilities: [140] Device Serial Number 00-22-fa-ff-ff-ca-c6-ec
    Kernel driver in use: iwlagn
    Kernel modules: iwlagn


and here is my modules auto loaded
#lsmod
Module                  Size  Used by
bsd_comp                5098  0
ipv6                  280376  16
ppp_synctty             5918  0
ppp_async               7259  1
crc_ccitt               1315  1 ppp_async
ppp_generic            23019  7 bsd_comp,ppp_synctty,ppp_async
slhc                    4923  1 ppp_generic
ext4                  330125  2
mbcache                 5762  1 ext4
jbd2                   75607  1 ext4
crc16                   1281  1 ext4
usbhid                 38274  0
hid                    75887  1 usbhid
arc4                    1362  2
ecb                     1993  2
snd_seq_dummy           1447  0
snd_hda_codec_conexant    31150  1
joydev                  9863  0
i915                  296298  2
hdaps                   8872  1
snd_seq_oss            28928  0
snd_seq_midi_event      5420  1 snd_seq_oss
snd_seq                50530  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_even=
t
snd_seq_device          5241  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_hda_intel          21906  4
iwlagn                249180  0
tp_smapi               20697  0
thinkpad_ec             4174  2 hdaps,tp_smapi
snd_pcm_oss            39096  0
snd_mixer_oss          16932  1 snd_pcm_oss
cpufreq_ondemand        7990  2
uhci_hcd               22075  0
i2c_i801                8598  0
snd_hda_codec          76787  2 snd_hda_codec_conexant,snd_hda_intel
drm_kms_helper         23740  1 i915
iwlcore               164024  1 iwlagn
snd_hwdep               6126  1 snd_hda_codec
drm                   162265  3 i915,drm_kms_helper
thinkpad_acpi          61719  0
snd_pcm                71653  4 snd_hda_intel,snd_pcm_oss,snd_hda_codec
phc_intel              10281  1
snd_timer              19660  3 snd_seq,snd_pcm
e1000e                127876  0
i2c_algo_bit            5071  1 i915
snd                    57225  18
snd_hda_codec_conexant,snd_seq_oss,snd_seq,snd_seq_device,snd_hda_intel,snd=
_pcm_oss,snd_mixer_oss,snd_hda_codec,snd_hwdep,thinkpad_acpi,snd_pcm,snd_ti=
mer
ehci_hcd               36042  0
led_class               2347  1 thinkpad_acpi
soundcore               6089  1 snd
mac80211              182919  2 iwlagn,iwlcore
freq_table              2339  2 cpufreq_ondemand,phc_intel
iTCO_wdt               10669  0
iTCO_vendor_support     1849  1 iTCO_wdt
usbcore               145453  4 usbhid,uhci_hcd,ehci_hcd
i2c_core               18364  5
i915,i2c_i801,drm_kms_helper,drm,i2c_algo_bit
snd_page_alloc          7201  2 snd_hda_intel,snd_pcm
video                  19077  1 i915
battery                10055  0
psmouse                53592  0
cfg80211              141632  3 iwlagn,iwlcore,mac80211
rfkill                 15518  2 thinkpad_acpi,cfg80211
wmi                     5925  0
thermal                12258  0
ac                      3089  0
button                  4818  1 i915
output                  1956  1 video
intel_agp              29074  2 i915
sg                     25328  0
serio_raw               4470  0
processor              29040  3 phc_intel
tpm_tis                 8248  0
tpm                    11109  1 tpm_tis
tpm_bios                5457  1 tpm
nvram                   5597  1 thinkpad_acpi
pcspkr                  1803  0
evdev                   8775  17
rtc_cmos                8886  0
rtc_core               14439  1 rtc_cmos
rtc_lib                 1882  1 rtc_core
jfs                   171701  1
sd_mod                 27923  5
ahci                   36972  4
libata                155099  1 ahci
scsi_mod               94212  3 sg,sd_mod,libata

--000e0cd5f0f249e2b1048dca6b20
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I have install latest version arch linux on thinkpad X200 laptop. But It ca=
n show few sensors.<br><br>#sensors<br>acpitz-virtual-0<br>Adapter: Virtual=
 device<br>temp1:=A0=A0=A0=A0=A0=A0 +46.0=B0C=A0 (crit =3D +127.0=B0C)=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
temp2:=A0=A0=A0=A0=A0=A0 +46.0=B0C=A0 (crit =3D +104.0=B0C)=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br><br>thinkpad-isa-0000<br>Adapter: =
ISA adapter<br>fan1:=A0=A0=A0=A0=A0=A0 1980 RPM<br>temp1:=A0=A0=A0=A0=A0=A0=
 +46.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>temp2:=A0=A0=A0=A0=A0=A0 +46=
.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
temp3:=A0=A0=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>temp=
4:=A0=A0=A0=A0=A0=A0 +48.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>temp5:=A0=
=A0=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>temp6:=A0=A0=
=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
temp7:=A0=A0=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>temp=
8:=A0=A0=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>temp9:=
=A0=A0=A0=A0=A0=A0 +48.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>temp10:=A0=
=A0=A0=A0=A0 +49.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
temp11:=A0=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>temp=
12:=A0=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>temp13:=A0=
=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>temp14:=A0=A0=A0=
=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
temp15:=A0=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>temp=
16:=A0=A0=A0=A0=A0=A0 +0.0=B0C=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>ERROR: Can=
&#39;t get value of subfeature temp3_input: Can&#39;t read<br>ERROR: Can&#3=
9;t get value of subfeature temp5_input: Can&#39;t read<br>
ERROR: Can&#39;t get value of subfeature temp6_input: Can&#39;t read<br>ERR=
OR: Can&#39;t get value of subfeature temp7_input: Can&#39;t read<br>ERROR:=
 Can&#39;t get value of subfeature temp8_input: Can&#39;t read<br>ERROR: Ca=
n&#39;t get value of subfeature temp11_input: Can&#39;t read<br>
ERROR: Can&#39;t get value of subfeature temp12_input: Can&#39;t read<br>ER=
ROR: Can&#39;t get value of subfeature temp13_input: Can&#39;t read<br>ERRO=
R: Can&#39;t get value of subfeature temp14_input: Can&#39;t read<br>ERROR:=
 Can&#39;t get value of subfeature temp15_input: Can&#39;t read<br>
ERROR: Can&#39;t get value of subfeature temp16_input: Can&#39;t read<br><b=
r><br><br><br>#lspci -v<br>00:00.0 Host bridge: Intel Corporation Mobile 4 =
Series Chipset Memory Controller Hub (rev 07)<br>=A0=A0=A0 Subsystem: Lenov=
o Device 20e0<br>
=A0=A0=A0 Flags: bus master, fast devsel, latency 0<br>=A0=A0=A0 Capabiliti=
es: [e0] Vendor Specific Information: Len=3D0a &lt;?&gt;<br>=A0=A0=A0 Kerne=
l driver in use: agpgart-intel<br>=A0=A0=A0 Kernel modules: intel-agp<br><b=
r>00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series Chip=
set Integrated Graphics Controller (rev 07) (prog-if 00 [VGA controller])<b=
r>
=A0=A0=A0 Subsystem: Lenovo Device 20e4<br>=A0=A0=A0 Flags: bus master, fas=
t devsel, latency 0, IRQ 31<br>=A0=A0=A0 Memory at f2000000 (64-bit, non-pr=
efetchable) [size=3D4M]<br>=A0=A0=A0 Memory at d0000000 (64-bit, prefetchab=
le) [size=3D256M]<br>=A0=A0=A0 I/O ports at 1800 [size=3D8]<br>
=A0=A0=A0 Expansion ROM at &lt;unassigned&gt; [disabled]<br>=A0=A0=A0 Capab=
ilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-<br>=A0=A0=A0 Capabi=
lities: [d0] Power Management version 3<br>=A0=A0=A0 Kernel driver in use: =
i915<br>=A0=A0=A0 Kernel modules: i915<br>
<br>00:02.1 Display controller: Intel Corporation Mobile 4 Series Chipset I=
ntegrated Graphics Controller (rev 07)<br>=A0=A0=A0 Subsystem: Lenovo Devic=
e 20e4<br>=A0=A0=A0 Flags: bus master, fast devsel, latency 0<br>=A0=A0=A0 =
Memory at f2400000 (64-bit, non-prefetchable) [size=3D1M]<br>
=A0=A0=A0 Capabilities: [d0] Power Management version 3<br><br>00:03.0 Comm=
unication controller: Intel Corporation Mobile 4 Series Chipset MEI Control=
ler (rev 07)<br>=A0=A0=A0 Subsystem: Lenovo Device 20e6<br>=A0=A0=A0 Flags:=
 bus master, fast devsel, latency 0, IRQ 11<br>
=A0=A0=A0 Memory at f2826800 (64-bit, non-prefetchable) [size=3D16]<br>=A0=
=A0=A0 Capabilities: [50] Power Management version 3<br>=A0=A0=A0 Capabilit=
ies: [8c] MSI: Enable- Count=3D1/1 Maskable- 64bit+<br><br>00:03.3 Serial c=
ontroller: Intel Corporation Mobile 4 Series Chipset AMT SOL Redirection (r=
ev 07) (prog-if 02 [16550])<br>
=A0=A0=A0 Subsystem: Lenovo Device 20ec<br>=A0=A0=A0 Flags: bus master, 66M=
Hz, fast devsel, latency 0, IRQ 17<br>=A0=A0=A0 I/O ports at 1830 [size=3D8=
]<br>=A0=A0=A0 Memory at f2624000 (32-bit, non-prefetchable) [size=3D4K]<br=
>=A0=A0=A0 Capabilities: [c8] Power Management version 3<br>
=A0=A0=A0 Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+<br>=
=A0=A0=A0 Kernel driver in use: serial<br><br>00:19.0 Ethernet controller: =
Intel Corporation 82567LM Gigabit Network Connection (rev 03)<br>=A0=A0=A0 =
Subsystem: Lenovo Device 20ee<br>
=A0=A0=A0 Flags: bus master, fast devsel, latency 0, IRQ 28<br>=A0=A0=A0 Me=
mory at f2600000 (32-bit, non-prefetchable) [size=3D128K]<br>=A0=A0=A0 Memo=
ry at f2625000 (32-bit, non-prefetchable) [size=3D4K]<br>=A0=A0=A0 I/O port=
s at 1840 [size=3D32]<br>=A0=A0=A0 Capabilities: [c8] Power Management vers=
ion 2<br>
=A0=A0=A0 Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+<br>=
=A0=A0=A0 Capabilities: [e0] PCI Advanced Features<br>=A0=A0=A0 Kernel driv=
er in use: e1000e<br>=A0=A0=A0 Kernel modules: e1000e<br><br>00:1a.0 USB Co=
ntroller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #4 (re=
v 03) (prog-if 00 [UHCI])<br>
=A0=A0=A0 Subsystem: Lenovo Device 20f0<br>=A0=A0=A0 Flags: bus master, med=
ium devsel, latency 0, IRQ 20<br>=A0=A0=A0 I/O ports at 1860 [size=3D32]<br=
>=A0=A0=A0 Capabilities: [50] PCI Advanced Features<br>=A0=A0=A0 Kernel dri=
ver in use: uhci_hcd<br>=A0=A0=A0 Kernel modules: uhci-hcd<br>
<br>00:1a.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=
 Controller #5 (rev 03) (prog-if 00 [UHCI])<br>=A0=A0=A0 Subsystem: Lenovo =
Device 20f0<br>=A0=A0=A0 Flags: bus master, medium devsel, latency 0, IRQ 2=
1<br>=A0=A0=A0 I/O ports at 1880 [size=3D32]<br>
=A0=A0=A0 Capabilities: [50] PCI Advanced Features<br>=A0=A0=A0 Kernel driv=
er in use: uhci_hcd<br>=A0=A0=A0 Kernel modules: uhci-hcd<br><br>00:1a.2 US=
B Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #6=
 (rev 03) (prog-if 00 [UHCI])<br>
=A0=A0=A0 Subsystem: Lenovo Device 20f0<br>=A0=A0=A0 Flags: bus master, med=
ium devsel, latency 0, IRQ 22<br>=A0=A0=A0 I/O ports at 18a0 [size=3D32]<br=
>=A0=A0=A0 Capabilities: [50] PCI Advanced Features<br>=A0=A0=A0 Kernel dri=
ver in use: uhci_hcd<br>=A0=A0=A0 Kernel modules: uhci-hcd<br>
<br>00:1a.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHC=
I Controller #2 (rev 03) (prog-if 20 [EHCI])<br>=A0=A0=A0 Subsystem: Lenovo=
 Device 20f1<br>=A0=A0=A0 Flags: bus master, medium devsel, latency 0, IRQ =
23<br>=A0=A0=A0 Memory at f2826c00 (32-bit, non-prefetchable) [size=3D1K]<b=
r>
=A0=A0=A0 Capabilities: [50] Power Management version 2<br>=A0=A0=A0 Capabi=
lities: [58] Debug port: BAR=3D1 offset=3D00a0<br>=A0=A0=A0 Capabilities: [=
98] PCI Advanced Features<br>=A0=A0=A0 Kernel driver in use: ehci_hcd<br>=
=A0=A0=A0 Kernel modules: ehci-hcd<br>
<br>00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio C=
ontroller (rev 03)<br>=A0=A0=A0 Subsystem: Lenovo Device 20f2<br>=A0=A0=A0 =
Flags: bus master, fast devsel, latency 0, IRQ 29<br>=A0=A0=A0 Memory at f2=
620000 (64-bit, non-prefetchable) [size=3D16K]<br>
=A0=A0=A0 Capabilities: [50] Power Management version 2<br>=A0=A0=A0 Capabi=
lities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+<br>=A0=A0=A0 Capabil=
ities: [70] Express Root Complex Integrated Endpoint, MSI 00<br>=A0=A0=A0 C=
apabilities: [100] Virtual Channel<br>
=A0=A0=A0 Capabilities: [130] Root Complex Link<br>=A0=A0=A0 Kernel driver =
in use: HDA Intel<br>=A0=A0=A0 Kernel modules: snd-hda-intel<br><br>00:1c.0=
 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express Port 1 (rev=
 03) (prog-if 00 [Normal decode])<br>
=A0=A0=A0 Flags: bus master, fast devsel, latency 0<br>=A0=A0=A0 Bus: prima=
ry=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0<br>=A0=A0=A0 I/O=
 behind bridge: 00003000-00003fff<br>=A0=A0=A0 Memory behind bridge: bc0000=
00-bc1fffff<br>=A0=A0=A0 Prefetchable memory behind bridge: 00000000bc20000=
0-00000000bc3fffff<br>
=A0=A0=A0 Capabilities: [40] Express Root Port (Slot+), MSI 00<br>=A0=A0=A0=
 Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-<br>=A0=A0=A0 =
Capabilities: [90] Subsystem: Lenovo Device 20f3<br>=A0=A0=A0 Capabilities:=
 [a0] Power Management version 2<br>
=A0=A0=A0 Capabilities: [100] Virtual Channel<br>=A0=A0=A0 Capabilities: [1=
80] Root Complex Link<br>=A0=A0=A0 Kernel driver in use: pcieport<br>=A0=A0=
=A0 Kernel modules: shpchp<br><br>00:1c.1 PCI bridge: Intel Corporation 828=
01I (ICH9 Family) PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])<=
br>
=A0=A0=A0 Flags: bus master, fast devsel, latency 0<br>=A0=A0=A0 Bus: prima=
ry=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0<br>=A0=A0=A0 I/O=
 behind bridge: 00004000-00004fff<br>=A0=A0=A0 Memory behind bridge: f25000=
00-f25fffff<br>=A0=A0=A0 Prefetchable memory behind bridge: 00000000bc40000=
0-00000000bc5fffff<br>
=A0=A0=A0 Capabilities: [40] Express Root Port (Slot+), MSI 00<br>=A0=A0=A0=
 Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-<br>=A0=A0=A0 =
Capabilities: [90] Subsystem: Lenovo Device 20f3<br>=A0=A0=A0 Capabilities:=
 [a0] Power Management version 2<br>
=A0=A0=A0 Capabilities: [100] Virtual Channel<br>=A0=A0=A0 Capabilities: [1=
80] Root Complex Link<br>=A0=A0=A0 Kernel driver in use: pcieport<br>=A0=A0=
=A0 Kernel modules: shpchp<br><br>00:1c.3 PCI bridge: Intel Corporation 828=
01I (ICH9 Family) PCI Express Port 4 (rev 03) (prog-if 00 [Normal decode])<=
br>
=A0=A0=A0 Flags: bus master, fast devsel, latency 0<br>=A0=A0=A0 Bus: prima=
ry=3D00, secondary=3D05, subordinate=3D0c, sec-latency=3D0<br>=A0=A0=A0 I/O=
 behind bridge: 00002000-00002fff<br>=A0=A0=A0 Memory behind bridge: f00000=
00-f1ffffff<br>=A0=A0=A0 Prefetchable memory behind bridge: 00000000f290000=
0-00000000f29fffff<br>
=A0=A0=A0 Capabilities: [40] Express Root Port (Slot+), MSI 00<br>=A0=A0=A0=
 Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-<br>=A0=A0=A0 =
Capabilities: [90] Subsystem: Lenovo Device 20f3<br>=A0=A0=A0 Capabilities:=
 [a0] Power Management version 2<br>
=A0=A0=A0 Capabilities: [100] Virtual Channel<br>=A0=A0=A0 Capabilities: [1=
80] Root Complex Link<br>=A0=A0=A0 Kernel driver in use: pcieport<br>=A0=A0=
=A0 Kernel modules: shpchp<br><br>00:1d.0 USB Controller: Intel Corporation=
 82801I (ICH9 Family) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])<b=
r>
=A0=A0=A0 Subsystem: Lenovo Device 20f0<br>=A0=A0=A0 Flags: bus master, med=
ium devsel, latency 0, IRQ 16<br>=A0=A0=A0 I/O ports at 18c0 [size=3D32]<br=
>=A0=A0=A0 Capabilities: [50] PCI Advanced Features<br>=A0=A0=A0 Kernel dri=
ver in use: uhci_hcd<br>=A0=A0=A0 Kernel modules: uhci-hcd<br>
<br>00:1d.1 USB Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI=
 Controller #2 (rev 03) (prog-if 00 [UHCI])<br>=A0=A0=A0 Subsystem: Lenovo =
Device 20f0<br>=A0=A0=A0 Flags: bus master, medium devsel, latency 0, IRQ 1=
7<br>=A0=A0=A0 I/O ports at 18e0 [size=3D32]<br>
=A0=A0=A0 Capabilities: [50] PCI Advanced Features<br>=A0=A0=A0 Kernel driv=
er in use: uhci_hcd<br>=A0=A0=A0 Kernel modules: uhci-hcd<br><br>00:1d.2 US=
B Controller: Intel Corporation 82801I (ICH9 Family) USB UHCI Controller #3=
 (rev 03) (prog-if 00 [UHCI])<br>
=A0=A0=A0 Subsystem: Lenovo Device 20f0<br>=A0=A0=A0 Flags: bus master, med=
ium devsel, latency 0, IRQ 18<br>=A0=A0=A0 I/O ports at 1c00 [size=3D32]<br=
>=A0=A0=A0 Capabilities: [50] PCI Advanced Features<br>=A0=A0=A0 Kernel dri=
ver in use: uhci_hcd<br>=A0=A0=A0 Kernel modules: uhci-hcd<br>
<br>00:1d.7 USB Controller: Intel Corporation 82801I (ICH9 Family) USB2 EHC=
I Controller #1 (rev 03) (prog-if 20 [EHCI])<br>=A0=A0=A0 Subsystem: Lenovo=
 Device 20f1<br>=A0=A0=A0 Flags: bus master, medium devsel, latency 0, IRQ =
19<br>=A0=A0=A0 Memory at f2827000 (32-bit, non-prefetchable) [size=3D1K]<b=
r>
=A0=A0=A0 Capabilities: [50] Power Management version 2<br>=A0=A0=A0 Capabi=
lities: [58] Debug port: BAR=3D1 offset=3D00a0<br>=A0=A0=A0 Capabilities: [=
98] PCI Advanced Features<br>=A0=A0=A0 Kernel driver in use: ehci_hcd<br>=
=A0=A0=A0 Kernel modules: ehci-hcd<br>
<br>00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 93) =
(prog-if 01 [Subtractive decode])<br>=A0=A0=A0 Flags: bus master, fast devs=
el, latency 0<br>=A0=A0=A0 Bus: primary=3D00, secondary=3D0d, subordinate=
=3D0d, sec-latency=3D0<br>
=A0=A0=A0 Capabilities: [50] Subsystem: Lenovo Device 20f4<br><br>00:1f.0 I=
SA bridge: Intel Corporation ICH9M-E LPC Interface Controller (rev 03)<br>=
=A0=A0=A0 Subsystem: Lenovo Device 20f5<br>=A0=A0=A0 Flags: bus master, med=
ium devsel, latency 0<br>
=A0=A0=A0 Capabilities: [e0] Vendor Specific Information: Len=3D0c &lt;?&gt=
;<br>=A0=A0=A0 Kernel modules: iTCO_wdt<br><br>00:1f.2 SATA controller: Int=
el Corporation ICH9M/M-E SATA AHCI Controller (rev 03) (prog-if 01 [AHCI 1.=
0])<br>=A0=A0=A0 Subsystem: Lenovo Device 20f8<br>
=A0=A0=A0 Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 27<br>=A0=
=A0=A0 I/O ports at 1c48 [size=3D8]<br>=A0=A0=A0 I/O ports at 183c [size=3D=
4]<br>=A0=A0=A0 I/O ports at 1c40 [size=3D8]<br>=A0=A0=A0 I/O ports at 1838=
 [size=3D4]<br>=A0=A0=A0 I/O ports at 1c20 [size=3D32]<br>
=A0=A0=A0 Memory at f2826000 (32-bit, non-prefetchable) [size=3D2K]<br>=A0=
=A0=A0 Capabilities: [80] MSI: Enable+ Count=3D1/16 Maskable- 64bit-<br>=A0=
=A0=A0 Capabilities: [70] Power Management version 3<br>=A0=A0=A0 Capabilit=
ies: [a8] SATA HBA v1.0<br>
=A0=A0=A0 Capabilities: [b0] PCI Advanced Features<br>=A0=A0=A0 Kernel driv=
er in use: ahci<br>=A0=A0=A0 Kernel modules: ahci<br><br>00:1f.3 SMBus: Int=
el Corporation 82801I (ICH9 Family) SMBus Controller (rev 03)<br>=A0=A0=A0 =
Subsystem: Lenovo Device 20f9<br>
=A0=A0=A0 Flags: medium devsel, IRQ 23<br>=A0=A0=A0 Memory at f2827400 (64-=
bit, non-prefetchable) [size=3D256]<br>=A0=A0=A0 I/O ports at 1c60 [size=3D=
32]<br>=A0=A0=A0 Kernel driver in use: i801_smbus<br>=A0=A0=A0 Kernel modul=
es: i2c-i801<br><br>03:00.0 Network controller: Intel Corporation PRO/Wirel=
ess 5100 AGN [Shiloh] Network Connection<br>
=A0=A0=A0 Subsystem: Intel Corporation PRO/Wireless 5100AGN Network Connect=
ion<br>=A0=A0=A0 Flags: bus master, fast devsel, latency 0, IRQ 30<br>=A0=
=A0=A0 Memory at f2500000 (64-bit, non-prefetchable) [size=3D8K]<br>=A0=A0=
=A0 Capabilities: [c8] Power Management version 3<br>
=A0=A0=A0 Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+<br>=
=A0=A0=A0 Capabilities: [e0] Express Endpoint, MSI 00<br>=A0=A0=A0 Capabili=
ties: [100] Advanced Error Reporting<br>=A0=A0=A0 Capabilities: [140] Devic=
e Serial Number 00-22-fa-ff-ff-ca-c6-ec<br>
=A0=A0=A0 Kernel driver in use: iwlagn<br>=A0=A0=A0 Kernel modules: iwlagn<=
br><br><br>and here is my modules auto loaded<br>#lsmod<br>Module=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Size=A0 Used by<br>bsd_comp=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5098=A0 0 <br>ipv6=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 280376=A0 16 <br>
ppp_synctty=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5918=A0 0 <br>ppp_async=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 7259=A0 1 <br>crc_ccitt=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1315=A0 1 ppp_async<br>ppp_generic=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 23019=A0 7 bsd_comp,ppp_synctty,ppp_async<br>slhc=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4923=A0 1 ppp_gen=
eric<br>
ext4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 330125=A0 2 <br>mbc=
ache=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5762=A0 1 ext4<br>jbd2=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 75607=A0 1 ext4<br>c=
rc16=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1281=A0 1 ext4<b=
r>usbhid=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 38274=A0 0 <br>hid=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 75887=A0 1 usbhid=
<br>
arc4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1362=A0 2 <br=
>ecb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1993=A0 2 =
<br>snd_seq_dummy=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1447=A0 0 <br>snd_hda_codec=
_conexant=A0=A0=A0 31150=A0 1 <br>joydev=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 9863=A0 0 <br>i915=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 296298=A0 2 <br>hdaps=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 8872=A0 1 <br>
snd_seq_oss=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 28928=A0 0 <br>snd_seq_midi_ev=
ent=A0=A0=A0=A0=A0 5420=A0 1 snd_seq_oss<br>snd_seq=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 50530=A0 5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_eve=
nt<br>snd_seq_device=A0=A0=A0=A0=A0=A0=A0=A0=A0 5241=A0 3 snd_seq_dummy,snd=
_seq_oss,snd_seq<br>
snd_hda_intel=A0=A0=A0=A0=A0=A0=A0=A0=A0 21906=A0 4 <br>iwlagn=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 249180=A0 0 <br>tp_smapi=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 20697=A0 0 <br>thinkpad_ec=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 4174=A0 2 hdaps,tp_smapi<br>snd_pcm_oss=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 39096=A0 0 <br>snd_mixer_oss=A0=A0=A0=A0=A0=A0=A0=A0=A0 169=
32=A0 1 snd_pcm_oss<br>
cpufreq_ondemand=A0=A0=A0=A0=A0=A0=A0 7990=A0 2 <br>uhci_hcd=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 22075=A0 0 <br>i2c_i801=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 8598=A0 0 <br>snd_hda_codec=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 76787=A0 2 snd_hda_codec_conexant,snd_hda_intel<br>drm_kms_helper=A0=A0=
=A0=A0=A0=A0=A0=A0 23740=A0 1 i915<br>iwlcore=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 164024=A0 1 iwlagn<br>
snd_hwdep=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 6126=A0 1 snd_hda_codec=
<br>drm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 162265=A0 3 i=
915,drm_kms_helper<br>thinkpad_acpi=A0=A0=A0=A0=A0=A0=A0=A0=A0 61719=A0 0 <=
br>snd_pcm=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 71653=A0 4 snd_hda_=
intel,snd_pcm_oss,snd_hda_codec<br>phc_intel=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 10281=A0 1 <br>
snd_timer=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 19660=A0 3 snd_seq,snd_pcm=
<br>e1000e=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 127876=A0 0 <br>i2c=
_algo_bit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5071=A0 1 i915<br>snd=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 57225=A0 18 snd_hda_codec_=
conexant,snd_seq_oss,snd_seq,snd_seq_device,snd_hda_intel,snd_pcm_oss,snd_m=
ixer_oss,snd_hda_codec,snd_hwdep,thinkpad_acpi,snd_pcm,snd_timer<br>
ehci_hcd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 36042=A0 0 <br>led_class=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2347=A0 1 thinkpad_acpi<br>sound=
core=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 6089=A0 1 snd<br>mac80211=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 182919=A0 2 iwlagn,iwlcore<br>freq_tab=
le=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2339=A0 2 cpufreq_ondemand,phc_in=
tel<br>
iTCO_wdt=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10669=A0 0 <br>iTCO_vend=
or_support=A0=A0=A0=A0 1849=A0 1 iTCO_wdt<br>usbcore=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 145453=A0 4 usbhid,uhci_hcd,ehci_hcd<br>i2c_core=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 18364=A0 5 i915,i2c_i801,drm_kms_he=
lper,drm,i2c_algo_bit<br>
snd_page_alloc=A0=A0=A0=A0=A0=A0=A0=A0=A0 7201=A0 2 snd_hda_intel,snd_pcm<b=
r>video=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 19077=A0 1 i915<=
br>battery=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10055=A0 0 <br>psmo=
use=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 53592=A0 0 <br>cfg80211=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 141632=A0 3 iwlagn,iwlcore,mac80211<br=
>
rfkill=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 15518=A0 2 thinkpad_=
acpi,cfg80211<br>wmi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 5925=A0 0 <br>thermal=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=
2258=A0 0 <br>ac=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 3089=A0 0 <br>button=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 4818=A0 1 i915<br>output=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 1956=A0 1 video<br>
intel_agp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 29074=A0 2 i915<br>sg=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 25328=A0 0 <br>se=
rio_raw=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4470=A0 0 <br>processor=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 29040=A0 3 phc_intel<br>tpm_tis=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8248=A0 0 <br>tpm=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 11109=A0 1 tpm_tis<br>
tpm_bios=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5457=A0 1 tpm<br>nvra=
m=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5597=A0 1 thinkpad_=
acpi<br>pcspkr=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1803=A0 0=
 <br>evdev=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8775=A0 17=
 <br>rtc_cmos=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8886=A0 0 <br>rt=
c_core=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 14439=A0 1 rtc_cmos<br>
rtc_lib=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1882=A0 1 rtc_core<=
br>jfs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 171701=A0 1 <b=
r>sd_mod=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 27923=A0 5 <br>ahc=
i=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 36972=A0 4 <br>liba=
ta=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 155099=A0 1 ahci<br>scsi_mo=
d=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 94212=A0 3 sg,sd_mod,libata<br>

--000e0cd5f0f249e2b1048dca6b20--


--===============4411091239395250104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4411091239395250104==--
