From: Tom Gundersen <teg@jklm.no>
Date: Sat, 21 Jan 2012 17:27:17 +0000
Subject: [lm-sensors] w83627ehf can not be modprobed as of 3.3-rc1
Message-Id: <CAG-2HqVsLbpTrUAJ06AU-9_rOjQtkHap1ygYqpH_RBfM5ESb6w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi guys,

I don't know the importance of this, or if it is even a bug, but I get
a difference in behavior when updating from 3.2 to 3.3:

# modprobe w83627ehf
FATAL: Error inserting w83627ehf
(/lib/modules/3.3.0-rc1-ARCH/kernel/drivers/hwmon/w83627ehf.ko):
Device or resource busy


from dmesg:

w83627ehf: Found W83627DHG chip at 0x290
ACPI Warning: 0x0000000000000295-0x0000000000000296 SystemIO conflicts
with Region \_SB_.PCI0.SBRG.SIOR.HWRE 1 (20120111/utaddress-251)
ACPI: If an ACPI driver is available for this device, you should use
it instead of the native driver


My inserted modules:

Module                  Size  Used by
ext2                   63483  1
ext4                  421672  2
crc16                   1359  1 ext4
jbd2                   71683  1 ext4
mbcache                 5881  2 ext2,ext4
dm_mod                 71344  5
arc4                    1410  2
rt61pci                21801  0
snd_hda_codec_hdmi     24240  1
rt2x00pci               5050  1 rt61pci
radeon                782350  2
snd_hda_codec_realtek   112357  1
hwmon_vid               3292  0
sr_mod                 15047  0
rt2x00lib              35183  2 rt61pci,rt2x00pci
drm_kms_helper         26471  1 radeon
ttm                    63693  1 radeon
snd_hda_intel          23599  2
microcode              12025  0
acpi_cpufreq            5877  1
mac80211              392380  2 rt2x00pci,rt2x00lib
cdrom                  36521  1 sr_mod
cfg80211              176889  2 rt2x00lib,mac80211
snd_hda_codec          92529  3
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel
ata_generic             3455  0
mperf                   1243  1 acpi_cpufreq
usblp                  11218  0
atl1                   30282  0
snd_hwdep               6389  1 snd_hda_codec
drm                   204545  4 radeon,drm_kms_helper,ttm
freq_table              2515  1 acpi_cpufreq
snd_pcm                74812  3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec
pata_acpi               3376  0
rfkill                 15530  1 cfg80211
firewire_ohci          31637  0
ata_piix               22182  0
pata_jmicron            2480  3
eeprom_93cx6            2175  1 rt61pci
firewire_core          51352  1 firewire_ohci
snd_page_alloc          7121  2 snd_hda_intel,snd_pcm
intel_agp              10904  0
i2c_i801                8187  0
crc_itu_t               1363  2 rt61pci,firewire_core
iTCO_wdt               11885  0
iTCO_vendor_support     1961  1 iTCO_wdt
i2c_algo_bit            5263  1 radeon
pcspkr                  1835  0
evdev                   9626  5
serio_raw               4653  0
snd_timer              19544  1 snd_pcm
snd                    59666  11
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer
mii                     4091  1 atl1
i2c_core               20524  5 radeon,drm_kms_helper,drm,i2c_i801,i2c_algo_bit
intel_gtt              14519  1 intel_agp
soundcore               6210  1 snd
floppy                 58735  0
asus_atk0110           10131  0
button                  4470  0
processor              25616  1 acpi_cpufreq
ipv6                  272691  38
autofs4                23991  5
usbhid                 35836  0
hid_apple               5450  0
hid                    84190  2 usbhid,hid_apple
uhci_hcd               23084  0
ehci_hcd               40634  0
usbcore               146070  5 usblp,usbhid,uhci_hcd,ehci_hcd
usb_common               954  1 usbcore
btrfs                 652888  1
zlib_deflate           20340  1 btrfs
crc32c                  2888  1
libcrc32c               1034  1 btrfs
sd_mod                 28371  10
ahci                   20133  4
libahci                19455  1 ahci
libata                167582  6
ata_generic,pata_acpi,ata_piix,pata_jmicron,ahci,libahci
scsi_mod              133795  3 sr_mod,sd_mod,libata


Cheers,

Tom

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
