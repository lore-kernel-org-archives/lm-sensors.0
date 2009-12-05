From: firstname lastname <vajorie@gmail.com>
Date: Sat, 05 Dec 2009 02:47:59 +0000
Subject: [lm-sensors] No sensors on Acer Aspire One AOD250-1613
Message-Id: <a03cbe4f0912041847k40be96dauae2a84ecf281cc0e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

Please CC me on replies as I am not subscribed to the list.

I have an Acer Aspire One AOD250-1613 (Android+XP), with Intel Atom
N280. I am trying to get lm-sensors working mainly because acpi
reports my cpu temperature as 27C... I was hoping you could help me,
especially as Atom is marked as supported (cpucore) in lm-sensors'
website. here's more detail about my problems and hardware:

Error: sensors-detect finds no sensors.

Motherboard vendor and model: I do not know how to find this out.
Would this help at all:
http://us.acer.com/acer/productv.do?LanguageISOCtxParam=3Den&kcond61e.c2att=
101X051&sp=3Dpage16e&ctx2.c2att1%&link=3Dln438e&CountryISOCtxParam=3DUS&ctx=
1g.c2att92=843&ctx1.att21k=3D1&CRC=127634522#

CPU Info (I don't know why it lists two cores, Atom has just one afaik):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 28
model name      : Intel(R) Atom(TM) CPU N280   @ 1.66GHz
stepping        : 2
cpu MHz         : 800.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
constant_tsc arch_perfmon pebs bts pni dtes64 monitor ds_cpl est tm2
ssse3 xtpr pdcm movbe lahf_lm
bogomips        : 3326.54
clflush size    : 64
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 28
model name      : Intel(R) Atom(TM) CPU N280   @ 1.66GHz
stepping        : 2
cpu MHz         : 800.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
apicid          : 1
initial apicid  : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
constant_tsc arch_perfmon pebs bts pni dtes64 monitor ds_cpl est tm2
ssse3 xtpr pdcm movbe lahf_lm
bogomips        : 3326.54
clflush size    : 64
power management:


Lm_sensors and kernel versions
lm-sensors: 3.1.1
kernel: 2.6.31
OS: Arch Linux

The output of sensors (see the absurd temp just for fun):
acpitz-virtual-0
Adapter: Virtual device
temp1:       +26.8=B0C  (crit =3D +100.0=B0C)

The output of (as root) sensors-detect:
# sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)
# System: Acer Aspire one (laptop)

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
AMD K10 thermal sensors...                                  No
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
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
Module i2c-dev loaded successfully.

Next adapter: SMBus I801 adapter at 6000 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No


Sorry, no sensors were detected.
This is relatively common on laptops, where thermal management is
handled by ACPI rather than the OS.


The output of lsmod:
Module                  Size  Used by
i2c_dev                 6756  0
hwmon_vid               2844  0
ext3                  134020  1
jbd                    49136  1 ext3
hfs                    46720  0
hfsplus                76864  0
vfat                   11132  0
fat                    53052  1 vfat
isofs                  33764  0
nls_utf8                1664  0
udf                    86564  0
crc_itu_t               1724  1 udf
i915                  233928  1
drm                   156160  2 i915
i2c_algo_bit            5888  1 i915
aes_i586                8124  1
aes_generic            27228  1 aes_i586
ipv6                  279604  12
cpufreq_userspace       3008  2
ext2                   68964  1
loop                   15336  2
snd_seq_dummy           2720  0
snd_seq_oss            31232  0
snd_seq_midi_event      7036  1 snd_seq_oss
snd_seq                53808  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          6792  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            40320  0
snd_mixer_oss          17564  1 snd_pcm_oss
joydev                 10528  0
arc4                    1756  2
ecb                     2812  2
snd_hda_codec_realtek   210048  1
fan                     4448  0
ath9k                 239188  0
mac80211              155788  1 ath9k
ath                     7708  1 ath9k
pciehp                 37020  0
snd_hda_intel          27528  0
usb_storage            51904  1
snd_hda_codec          72700  2 snd_hda_codec_realtek,snd_hda_intel
snd_hwdep               7712  1 snd_hda_codec
pci_hotplug            28732  1 pciehp
snd_pcm                74496  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              21188  2 snd_seq,snd_pcm
video                  20116  1 i915
snd                    58820  11
snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_hda_codec_=
realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer
soundcore               6944  1 snd
cfg80211               90364  3 ath9k,mac80211,ath
iTCO_wdt               11072  0
iTCO_vendor_support     3136  1 iTCO_wdt
psmouse                60084  0
output                  2908  1 video
rfkill                 19696  1 cfg80211
acpi_cpufreq            8648  0
ac                      4224  0
i2c_i801                9616  0
led_class               4000  1 ath9k
uhci_hcd               23692  0
snd_page_alloc          8900  2 snd_hda_intel,snd_pcm
battery                10816  0
thermal                13912  0
intel_agp              28604  1
freq_table              3740  1 acpi_cpufreq
i2c_core               21808  5 i2c_dev,i915,drm,i2c_algo_bit,i2c_i801
wmi                     6600  0
button                  5612  0
sg                     27728  0
atl1c                  32160  0
agpgart                32660  3 drm,intel_agp
serio_raw               5792  0
evdev                  10240  13
ehci_hcd               36620  0
usbcore               154032  4 usb_storage,uhci_hcd,ehci_hcd
processor              36076  3 acpi_cpufreq
rtc_cmos               11344  0
rtc_core               17976  1 rtc_cmos
rtc_lib                 2524  1 rtc_core
ext4                  334112  2
mbcache                 7104  3 ext3,ext2,ext4
jbd2                   82016  1 ext4
crc16                   1660  1 ext4
sd_mod                 28344  5
ahci                   35788  2
libata                169548  1 ahci
scsi_mod              112468  4 usb_storage,sg,sd_mod,libata


If a PCI chip problem (I don't know): the output of lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation Mobile 945GME Express
Memory Controller Hub [8086:27ac] (rev 03)
00:02.0 VGA compatible controller [0300]: Intel Corporation Mobile
945GME Express Integrated Graphics Controller [8086:27ae] (rev 03)
00:02.1 Display controller [0380]: Intel Corporation Mobile
945GM/GMS/GME, 943/940GML Express Integrated Graphics Controller
[8086:27a6] (rev 03)
00:1b.0 Audio device [0403]: Intel Corporation 82801G (ICH7 Family)
High Definition Audio Controller [8086:27d8] (rev 02)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 1 [8086:27d0] (rev 02)
00:1c.1 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 2 [8086:27d2] (rev 02)
00:1c.2 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 3 [8086:27d4] (rev 02)
00:1c.3 PCI bridge [0604]: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 4 [8086:27d6] (rev 02)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #1 [8086:27c8] (rev 02)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #2 [8086:27c9] (rev 02)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #3 [8086:27ca] (rev 02)
00:1d.3 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB UHCI Controller #4 [8086:27cb] (rev 02)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801G (ICH7 Family)
USB2 EHCI Controller [8086:27cc] (rev 02)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge
[8086:2448] (rev e2)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801GBM (ICH7-M) LPC
Interface Bridge [8086:27b9] (rev 02)
00:1f.2 SATA controller [0106]: Intel Corporation 82801GBM/GHM (ICH7
Family) SATA AHCI Controller [8086:27c5] (rev 02)
00:1f.3 SMBus [0c05]: Intel Corporation 82801G (ICH7 Family) SMBus
Controller [8086:27da] (rev 02)
01:00.0 Network controller [0280]: Atheros Communications Inc. AR9285
Wireless Network Adapter (PCI-Express) [168c:002b] (rev 01)
03:00.0 Ethernet controller [0200]: Attansic Technology Corp. Atheros
AR8132 / L1c Gigabit Ethernet Adapter [1969:1062] (rev c0)

Part numbers of chips on your motherboard you think are the sensor
chips (look at your motherboard):
I rather not do that, the laptop is still under warranty...

Thank you so much in advance for your help,
V.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
