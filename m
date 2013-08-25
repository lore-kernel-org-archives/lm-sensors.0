From: Larry Lade <larry.p.lade@gmail.com>
Date: Sun, 25 Aug 2013 00:32:41 +0000
Subject: [lm-sensors] Trouble with sensors-detect probing ASUS 1015E-DS03 laptop
Message-Id: <CADO8fxbc7H6y32vm28GV3+ye7O+WnfpcvQQKMom5_CmbAQYbZg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I wanted to report an alarming issue running sensors-detect on my new
(Ubuntu 12.04 out of the box!) laptop.

sensors-detect revision 5984 (2011-07-10 21:22:53 +0200)
System:ASUSTeK COMPUTER INC. 1015E (laptop)

I take the default "YES" to all detections. The only thing that comes
up is "coretemp", until it tries to probe I2C/SMBus adapters.

Found unknown SMBus adapter 8086:1e22 at 0000:00:1f.3.
Sorry, no supported PCI bus adapters found

...

Next adapter: i915 gmbus panel (i2c-5)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x4f
Probing for `National Semiconductor LM75'...                No
Probing for `National Semiconductor LM75A'...               No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Maxim MAX6642'...                              No
Probing for `Texas Instruments TMP421'...                   No
Probing for `Texas Instruments TMP422'...                   No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `NXP/Philips SA56004'...                        No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter: i915 GPIOC (i2c-6)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x4f
Probing for `National Semiconductor LM75'...                No
Probing for `National Semiconductor LM75A'...               No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Maxim MAX6642'...                              No
Probing for `Texas Instruments TMP421'...                   No
Probing for `Texas Instruments TMP422'...                   No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `NXP/Philips SA56004'...                        No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)


At some point during one of these scans, there's a flash and SOMETHING
happens to the built-in LCD screen. I noticed it's as though the gamma
was all out of whack, the colors were washed out, and dithering
becomes notable everywhere. (Bad even for an 18-bit LCD.) Display
looks fine on an LCD connected by VGA port.

This change survived the re-install of the operating system.

I was getting desperate, thinking I had just zapped something and
voided the hardware, so I ran sensors-detect again. Probing either of
the two above adapters (they both seem to reference the same bit of
hardware) seemed to toggle something, restoring or corrupting the
screen quality.

Or at least it did. It seems to have it stuck in "ugly" mode again,
and nothing on the display toggles any more when I run sensors-detect
any more. Is anyone able to help?




The LCD seems to be an AUO B101XTN01 (as reported by the EDID)
http://www.panelook.com/B101XTN01.0_AUO_10.1_LCM_parameter_19387.html

lm-sensors 1:3.3.1-2ubuntu1

linux 3.2.0-52-generic #78-Ubuntu SMP x86_64


$ sudo get-edid | parse-edid:

    # EDID version 1 revision 4
Section "Monitor"
    # Block type: 2:0 3:f
    # Block type: 2:0 3:fe
    # Block type: 2:0 3:fe
    Identifier "AUO:dc11"
    VendorName "AUO"
    ModelName "AUO:dc11"
    # Block type: 2:0 3:f
    # Block type: 2:0 3:fe
    # Block type: 2:0 3:fe
    # DPMS capabilities: Active off:no  Suspend:no  Standby:no

    Mode     "1366x768"    # vfreq 60.041Hz, hfreq 47.913kHz
        DotClock    76.660000
        HTimings    1366 1404 1426 1600
        VTimings    768 771 777 798
        Flags    "-HSync" "-VSync"
    EndMode
    # Block type: 2:0 3:f
    # Block type: 2:0 3:fe
    # Block type: 2:0 3:fe
EndSection


$ sudo i2cdetect 5
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-5.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 4f
50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --


$ sudo i2cdump 5 0x4f
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-5, address 0x4f, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

$ sudo i2cdump 5 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-5, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 ff ff ff ff ff ff 00 06 af dc 11 00 00 00 00    ........????....
10: 00 16 01 04 90 16 0d 78 02 bb f5 94 55 54 90 27    .??????x????UT?'
20: 23 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01    #PT...??????????
30: 01 01 01 01 01 01 f2 1d 56 ea 50 00 1e 30 26 16    ????????V?P.?0&?
40: 36 00 de 7d 00 00 00 18 00 00 00 0f 00 00 00 00    6.?}...?...?....
50: 00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41    ......... ...?.A
60: 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe    UO?         ...?
70: 00 42 31 30 31 58 54 4e 30 31 2e 31 20 0a 00 dd    .B101XTN01.1 ?.?
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................


$ lsmod

Module                  Size  Used by
pci_stub               12622  1
vboxpci                23237  0
vboxnetadp             13382  0
uvcvideo               72627  0
vboxnetflt             23478  0
videodev               98259  1 uvcvideo
vboxdrv               287130  3 vboxpci,vboxnetadp,vboxnetflt
v4l2_compat_ioctl32    17128  1 videodev
snd_hda_codec_hdmi     36727  1
snd_hda_codec_realtek    78471  1
bcma                   26696  0
arc4                   12529  2
joydev                 17693  0
dm_multipath           23275  0
snd_hda_intel          39382  3
snd_hda_codec         140267  3
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel
snd_hwdep              17764  1 snd_hda_codec
snd_pcm                97275  3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec
snd_seq_midi           13324  0
snd_rawmidi            30748  1 snd_seq_midi
snd_seq_midi_event     14899  1 snd_seq_midi
snd_seq                61929  2 snd_seq_midi,snd_seq_midi_event
snd_timer              29990  2 snd_pcm,snd_seq
snd_seq_device         14540  3 snd_seq_midi,snd_rawmidi,snd_seq
snd                    79041  16
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
psmouse                97519  0
brcmsmac              570930  0
mac80211              506862  1 brcmsmac
alx                    81350  0
serio_raw              13211  0
i915                  461962  3
compat                 13447  1 alx
soundcore              15091  1 snd
brcmutil               15139  1 brcmsmac
cfg80211              205774  2 brcmsmac,mac80211
crc8                   12893  1 brcmsmac
cordic                 12574  1 brcmsmac
drm_kms_helper         46978  1 i915
snd_page_alloc         18529  2 snd_hda_intel,snd_pcm
drm                   241971  4 i915,drm_kms_helper
mei                    41616  0
i2c_algo_bit           13423  1 i915
rfcomm                 47604  0
bnep                   18281  2
parport_pc             32866  0
bluetooth             180113  10 rfcomm,bnep
ppdev                  17113  0
video                  19651  1 i915
binfmt_misc            17540  1
nls_iso8859_1          12713  2
nls_cp437              16991  2
mac_hid                13253  0
vfat                   17585  2
fat                    61512  1 vfat
asus_nb_wmi            16990  0
asus_wmi               24392  1 asus_nb_wmi
wmi                    19256  1 asus_wmi
sparse_keymap          13890  1 asus_wmi
lp                     17799  0
parport                46562  3 parport_pc,ppdev,lp
usb_storage            49198  1
dm_raid45              78155  0
xor                    12894  1 dm_raid45
dm_mirror              22203  0
dm_region_hash         20961  1 dm_mirror
dm_log                 18564  3 dm_raid45,dm_mirror,dm_region_hash

dmesg currently dumping this during probe of 0x4f:
[  783.847244] i2c i2c-6: sendbytes: NAK bailout.
[  783.848321] i2c i2c-6: sendbytes: NAK bailout.
[  783.849399] i2c i2c-6: sendbytes: NAK bailout.
[  783.850497] i2c i2c-6: sendbytes: NAK bailout.
[  783.851666] i2c i2c-6: sendbytes: NAK bailout.
[  783.852746] i2c i2c-6: sendbytes: NAK bailout.
[  783.853827] i2c i2c-6: sendbytes: NAK bailout.
[  783.854908] i2c i2c-6: sendbytes: NAK bailout.
[  783.855988] i2c i2c-6: sendbytes: NAK bailout.
[  783.857065] i2c i2c-6: sendbytes: NAK bailout.
[  783.858150] i2c i2c-6: sendbytes: NAK bailout.
[  783.859230] i2c i2c-6: sendbytes: NAK bailout.
[  783.860306] i2c i2c-6: sendbytes: NAK bailout.
[  783.861383] i2c i2c-6: sendbytes: NAK bailout.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
