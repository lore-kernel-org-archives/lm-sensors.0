From: Matthieu.Rioteau@skf.com
Date: Wed, 27 Jan 2010 11:26:00 +0000
Subject: [lm-sensors] Can't get temperature sensor values on Atom N330
Message-Id: <OF0C3158F5.B652D0B7-ONC12576B8.003A2BDC-C12576B8.003ECE1D@skf.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,
I'm having troubles getting temperature sensor values on an Intel Atom=20
N330 processor.
The strangest thing si that a collegue of mine has exactly the same=20
hardware and uses the same distro, and he is able to correctly get the=20
values.
We try to compare everything we can between our 2 systems but we saw no=20
significant differences. So maybe you can help me fixing this boring=20
issue.

Here are are some basic information. I can give you more on demand if=20
needed.

Motherboard : Zotac IONITX A-E (ION chipset with Atom N330 core)
Distro : Debian Squeeze amd64 (kernel 2.6.32-trunk-amd64)
Lm-sensors : sensors version 3.1.1 with libsensors version 3.1.1

Output of sensors :
--------------------------------------------------
coretemp-isa-0000
Adapter: ISA adapter
ERROR: Can't get value of subfeature temp1_input: Can't read
Core 0:       +0.0=B0C  (crit =3D +90.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:       +3.0=B0C  (crit =3D +90.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
ERROR: Can't get value of subfeature temp1_input: Can't read
Core 2:       +0.0=B0C  (crit =3D +90.0=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:       +3.0=B0C  (crit =3D +90.0=B0C)
--------------------------------------------------

Nothing significant in dmesg (from my point of view), everything is well=20
loaded.

Sensors-detect detects nothing but it's the same on my collegue's PC tha=20
is working.

Output of lsmod :
--------------------------------------------------
Module                  Size  Used by
coretemp                4165  0
loop                   11767  0
snd_hda_codec_nvhdmi     3279  1
snd_hda_codec_realtek   235095  1
arc4                    1274  2
ecb                     1841  2
ath9k                 249632  0
snd_hda_intel          18147  0
snd_hda_codec          54212  3=20
snd_hda_codec_nvhdmi,snd_hda_codec_realtek,snd_hda_intel
mac80211              135407  1 ath9k
ath                     8006  1 ath9k
snd_hwdep               5364  1 snd_hda_codec
snd_pcm                60615  2 snd_hda_intel,snd_hda_codec
cfg80211              101253  3 ath9k,mac80211,ath
snd_timer              15502  1 snd_pcm
evdev                   7336  4
i2c_nforce2             5264  0
i2c_core               15584  1 i2c_nforce2
rfkill                 12996  1 cfg80211
led_class               2401  1 ath9k
pcspkr                  1699  0
snd                    44718  6=20
snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_tim=
er
soundcore               4598  1 snd
snd_page_alloc          6217  2 snd_hda_intel,snd_pcm
shpchp                 25928  0
pci_hotplug            21171  1 shpchp
serio_raw               3752  0
psmouse                49521  0
wmi                     4307  0
processor              29479  0
ext3                  106454  2
jbd                    37037  1 ext3
mbcache                 4970  1 ext3
sd_mod                 29673  5
crc_t10dif              1276  1 sd_mod
ata_generic             2983  0
ide_pci_generic         2788  0
ide_core               76802  1 ide_pci_generic
ahci                   31494  5
ohci_hcd               19196  0
libata                131655  2 ata_generic,ahci
ehci_hcd               30578  0
scsi_mod              121909  2 sd_mod,libata
forcedeth              45432  0
usbcore               121687  3 ohci_hcd,ehci_hcd
nls_base                6377  1 usbcore
button                  4634  0
thermal                11674  0
fan                     3346  0
thermal_sys            11878  3 processor,thermal,fan
--------------------------------------------------

I think lspci or i2cdetect isn't needed since the temperature is read as a =

CPU register from what I understood of the code.

If somebody needs more information for deeper investigation, feel free to=20
ask for it and I'll try to quickly provide.

Thanks for support,
Matthieu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
