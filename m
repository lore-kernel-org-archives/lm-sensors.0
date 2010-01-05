From: vajorie <vajorie@gmail.com>
Date: Tue, 05 Jan 2010 00:51:24 +0000
Subject: [lm-sensors] sensors show hdd temp instead of cpu temp using
Message-Id: <b4184b2f1001041651x593dec41tf7e6a0dc71acecf8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

I guess this could be a follow up from my previous email trying to get
lm-sensors working in this laptop. Since kernel 2.6.32, coretemp seems
to support atom cpus, as I found out, but the temperature reported as
cpu temperature (I guess?) is hdd temperature, not cpu temperature.

The bug report in kernel.org indicated that I should report it here.
Here is that bug report:
http://bugzilla.kernel.org/show_bug.cgi?id161

Here's some info that I hope is useful:

Motherboard: I don't know (an Acer netbook using Atom N280 cpu)

lm-sensors v. 3.1.1

kernel 2.6.32 (arch linux)

sensors output:

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +45.0°C  (crit = +90.0°C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +45.0°C  (crit = +90.0°C)

acpitz-virtual-0
Adapter: Virtual device
temp1:       +26.8°C  (crit = +100.0°C)

(note: 45C is hdd temp --booted to Windows and checked with hwmonitor,
which reports cpu temp as 50C on average)

lsmod:

Module                  Size  Used by
fuse                   51628  2
aes_i586                6880  1
aes_generic            25834  1 aes_i586
ipt_REJECT              1801  2
ipt_LOG                 4383  1
xt_limit                1288  2
xt_tcpudp               1943  7
xt_state                 967  6
ipt_addrtype            1465  4
ip6table_filter          959  1
ip6_tables              9622  1 ip6table_filter
ipv6                  237500  12
nf_nat_irc               990  0
nf_conntrack_irc        2639  1 nf_nat_irc
nf_nat_ftp              1679  0
nf_nat                 12383  2 nf_nat_irc,nf_nat_ftp
nf_conntrack_ipv4       8951  8 nf_nat
nf_defrag_ipv4           795  1 nf_conntrack_ipv4
nf_conntrack_ftp        4896  1 nf_nat_ftp
nf_conntrack           46129  7
xt_state,nf_nat_irc,nf_conntrack_irc,nf_nat_ftp,nf_nat,nf_conntrack_ipv4,nf_conntrack_ftp
iptable_filter          1082  1
ip_tables               8669  1 iptable_filter
x_tables               10432  8
ipt_REJECT,ipt_LOG,xt_limit,xt_tcpudp,xt_state,ipt_addrtype,ip6_tables,ip_tables
cpufreq_conservative     5100  2
ext2                   56463  1
loop                   11399  2
snd_seq_dummy           1099  0
snd_seq_oss            25304  0
snd_seq_midi_event      4452  1 snd_seq_oss
snd_seq                42628  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          4313  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_hda_codec_realtek   179240  1
arc4                    1058  2
ecb                     1545  2
snd_hda_intel          18697  0
snd_hda_codec          56728  2 snd_hda_codec_realtek,snd_hda_intel
joydev                  7768  0
snd_hwdep               5102  1 snd_hda_codec
snd_pcm_oss            33693  0
ath9k                  65185  0
ath9k_common            1993  1 ath9k
snd_mixer_oss          14810  1 snd_pcm_oss
snd_pcm                57479  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
mac80211              155343  2 ath9k,ath9k_common
usb_storage            33430  0
fan                     2598  0
ac                      2255  0
snd_timer              16117  2 snd_seq,snd_pcm
ath9k_hw              206370  2 ath9k,ath9k_common
battery                 7328  0
ath                     6876  2 ath9k,ath9k_hw
snd                    43847  11
snd_seq_oss,snd_seq,snd_seq_device,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               5007  1 snd
pciehp                 26539  0
snd_page_alloc          5809  2 snd_hda_intel,snd_pcm
cfg80211              111475  4 ath9k,ath9k_common,mac80211,ath
iTCO_wdt                6745  0
uhci_hcd               19092  0
rfkill                 12320  1 cfg80211
wmi                     4083  0
led_class               1933  1 ath9k
iTCO_vendor_support     1453  1 iTCO_wdt
sg                     20887  0
thermal                 9326  0
pci_hotplug            23492  1 pciehp
psmouse                55619  0
ehci_hcd               31434  0
usbcore               118825  4 usb_storage,uhci_hcd,ehci_hcd
acpi_cpufreq            5599  0
i2c_i801                7122  0
evdev                   6970  13
freq_table              1955  1 acpi_cpufreq
serio_raw               3620  0
processor              25790  3 acpi_cpufreq
coretemp                3789  0
rtc_cmos                7504  0
rtc_core               12011  1 rtc_cmos
rtc_lib                 1450  1 rtc_core
ext4                  313234  2
mbcache                 4278  2 ext2,ext4
jbd2                   68146  1 ext4
crc16                   1041  1 ext4
sd_mod                 24101  3
ahci                   29290  2
libata                135162  1 ahci
scsi_mod               78933  4 usb_storage,sg,sd_mod,libata
i915                  263409  2
drm_kms_helper         21971  1 i915
drm                   126588  3 i915,drm_kms_helper
i2c_algo_bit            4219  1 i915
button                  3638  1 i915
i2c_core               15369  4 i2c_i801,i915,drm,i2c_algo_bit
video                  14871  1 i915
output                  1404  1 video
intel_agp              23157  1
agpgart                23331  2 drm,intel_agp

What other info should I send? (Please CC me as I'm not subscribed)

Thanks.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
