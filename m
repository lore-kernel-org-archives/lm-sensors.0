From: Martin Wegener <killer-Bob@web.de>
Date: Thu, 28 Feb 2008 19:48:28 +0000
Subject: [lm-sensors] Need Help, Ubutnu 7.1, Asus K8V-MX, AMD 3000+,
Message-Id: <408367766@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <404946588@web.de>
In-Reply-To: <404946588@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,
I've got a problem using lm-sensors with my computer.
I'm on Ubutnu 7.1 (64bit version; 2.6.22-14-generic), with an Asus K8V-MX m=
ainboard(AMD64 3000+) and a Zalman CNPS7000A cooler.
First I just installed lm-sensors with 'sudo apt-get install lm-sensors'
worked without a problem. Then I did 'sudo sensors-detect' and answered all=
 questions with yes.
But 'sudo pwmconfig' told me to check my fans:
------------------------------------------------
Found the following devices:
hwmon0/device is k8temp
hwmon1/device is w83627ehf

Found the following PWM controls:
hwmon1/device/pwm1
hwmon1/device/pwm1_enable stuck to 1
Failed to set pwmhwmon1/device/pwm1 to full speed
Something's wrong, check your fans!
------------------------------------------------

This is what 'sudo sensors' told me:
------------------------------------------------
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
+24=B0C

w83627ehf-isa-0290
Adapter: ISA adapter
VCore: +1.15 V (min =3D +0.00 V, max =3D +1.74 V)
in1: +12.41 V (min =3D +8.29 V, max =3D +12.62 V)
AVCC: +3.23 V (min =3D +3.60 V, max =3D +4.08 V) ALARM
3VCC: +3.15 V (min =3D +3.06 V, max =3D +4.08 V)
in4: +1.62 V (min =3D +1.78 V, max =3D +2.01 V) ALARM
in5: +1.73 V (min =3D +0.31 V, max =3D +1.77 V)
in6: +5.58 V (min =3D +5.50 V, max =3D +0.64 V) ALARM
VSB: +3.15 V (min =3D +4.08 V, max =3D +3.60 V) ALARM
VBAT: +2.03 V (min =3D +1.17 V, max =3D +1.52 V) ALARM
in9: +1.63 V (min =3D +0.42 V, max =3D +1.53 V) ALARM
Case Fan: 0 RPM (min =3D 42 RPM, div =3D 128) ALARM
CPU Fan: 2678 RPM (min =3D 1875 RPM, div =3D 4)
Aux Fan: 0 RPM (min =3D 48 RPM, div =3D 128) ALARM
fan5: 0 RPM (min =3D 10546 RPM, div =3D 128) ALARM
Sys Temp: +30=B0C (high =3D +93=B0C, hyst =3D -88=B0C)
CPU Temp: +21.0=B0C (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
AUX Temp: +28.5=B0C (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
-----------------------------------------------------


But becaus of pwmconfig was not working, fancontrol wasn't able to do anyth=
ing:
----------------------------------------------------
Loading configuration from /etc/fancontrol ...
grep: /etc/fancontrol: No such file or directory
grep: /etc/fancontrol: No such file or directory
grep: /etc/fancontrol: No such file or directory
grep: /etc/fancontrol: No such file or directory
grep: /etc/fancontrol: No such file or directory
grep: /etc/fancontrol: No such file or directory
grep: /etc/fancontrol: No such file or directory
grep: /etc/fancontrol: No such file or directory
grep: /etc/fancontrol: No such file or directory
Some mandatory settings missing, please check your config file!
----------------------------------------------------


So I decided to use the Subversion to get the newest lm-sensors source.
This is the result:
'sudo sensors'
------------------------------------------------------------------
w83627ehf-isa-0290
Adapter: ISA adapter
VCore:       +1.14 V  (min =3D  +0.00 V, max =3D  +1.74 V)  =20
in1:        +12.36 V  (min =3D  +8.29 V, max =3D +12.62 V)  =20
AVCC:        +3.18 V  (min =3D  +3.60 V, max =3D  +4.08 V)   ALARM
3VCC:        +3.18 V  (min =3D  +1.01 V, max =3D  +4.08 V)  =20
in4:         +1.63 V  (min =3D  +1.66 V, max =3D  +2.01 V)   ALARM
in5:         +1.73 V  (min =3D  +0.31 V, max =3D  +1.77 V)  =20
in6:         +5.63 V  (min =3D  +5.50 V, max =3D  +0.64 V)   ALARM
VSB:         +3.18 V  (min =3D  +4.05 V, max =3D  +3.60 V)   ALARM
VBAT:        +2.03 V  (min =3D  +1.17 V, max =3D  +1.52 V)   ALARM
in9:         +1.62 V  (min =3D  +0.42 V, max =3D  +1.53 V)   ALARM
Case Fan:      0 RPM  (min =3D   42 RPM, div =3D 128)  ALARM
CPU Fan:    2700 RPM  (min =3D 3750 RPM, div =3D 2)  ALARM
Aux Fan:       0 RPM  (min =3D   48 RPM, div =3D 128)  ALARM
fan5:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
Sys Temp:    +38.0=B0C  (high =3D +93.0=B0C, hyst =3D -88.0=B0C) =20
CPU Temp:    +28.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =20
AUX Temp:    +35.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =20

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +33.0=B0C=20
--------------------------------------------------------------


'sudo pwmconfig'
--------------------------------------------------------------
Found the following devices:
   hwmon0/device is k8temp
   hwmon1/device is w83627ehf

Found the following PWM controls:
   hwmon1/device/pwm1
hwmon1/device/pwm1 stuck to 0
Manual control mode not supported, skipping hwmon1/device/pwm1.
   hwmon1/device/pwm2
hwmon1/device/pwm2 stuck to 0
Manual control mode not supported, skipping hwmon1/device/pwm2.
   hwmon1/device/pwm3
hwmon1/device/pwm3 stuck to 0
Manual control mode not supported, skipping hwmon1/device/pwm3.
There are no usable PWM outputs.
--------------------------------------------------------------


Speedstepping works without I probelm (when Cool and Quiet support is activ=
ated in the bios)
I've installed the newest bios, but it didn't help me.=20
And my bios it self does not give the the possibility to control my CPU-fan=
 speed
(There is nothing like Q-fan).

So what am I doing wrong?
Thanks for your help,
Martin W.

'sudo lsmod':
---------------------------------------------------------------------------=
--------
Module                  Size  Used by
ipv6                  317192  8=20
af_packet              28172  2=20
rfcomm                 47656  2=20
l2cap                  28672  11 rfcomm
bluetooth              63876  4 rfcomm,l2cap
ppdev                  11272  0=20
ac                      7304  0=20
container               6400  0=20
dock                   12264  0=20
video                  21140  0=20
button                 10400  0=20
sbs                    21520  0=20
battery                12424  0=20
powernow_k8            16608  0=20
cpufreq_ondemand       10896  1=20
cpufreq_userspace       6048  0=20
cpufreq_powersave       3072  0=20
cpufreq_conservative     9608  0=20
cpufreq_stats           8160  0=20
freq_table              6464  3 powernow_k8,cpufreq_ondemand,cpufreq_stats
w83627ehf              24464  0=20
i2c_isa                 6400  1 w83627ehf
sbp2                   27144  0=20
lp                     15048  0=20
tda827x                 9348  1=20
saa7134_alsa           17440  0=20
saa7134_dvb            21004  0=20
dvb_pll                18436  1 saa7134_dvb
video_buf_dvb           8708  1 saa7134_dvb
dvb_core               94768  1 video_buf_dvb
tda1004x               18692  2 saa7134_dvb
tuner                  70184  0=20
snd_via82xx            33192  1=20
gameport               18704  1 snd_via82xx
snd_mpu401_uart        11008  1 snd_via82xx
snd_seq_dummy           5380  0=20
snd_seq_oss            36864  0=20
snd_seq_midi           11008  0=20
snd_rawmidi            29824  2 snd_mpu401_uart,snd_seq_midi
usbhid                 32576  0=20
nvidia               7013492  34=20
hid                    33408  1 usbhid
saa7134               148308  2 saa7134_alsa,saa7134_dvb
snd_via82xx_modem      18444  0=20
snd_ac97_codec        122200  2 snd_via82xx,snd_via82xx_modem
video_buf              30084  4 saa7134_alsa,saa7134_dvb,video_buf_dvb,saa7=
134
compat_ioctl32         11136  1 saa7134
snd_seq_midi_event      9984  2 snd_seq_oss,snd_seq_midi
parport_pc             41896  1=20
pcmcia                 46232  0=20
ac97_bus                4096  1 snd_ac97_codec
snd_pcm_oss            50048  0=20
snd_mixer_oss          20096  1 snd_pcm_oss
ir_kbd_i2c             11536  1 saa7134
snd_seq                62496  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_=
seq_midi_event
snd_seq_device         10260  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_=
rawmidi,snd_seq
psmouse                45596  0=20
parport                44172  3 ppdev,lp,parport_pc
snd_pcm                94344  5 saa7134_alsa,snd_via82xx,snd_via82xx_modem,=
snd_ac97_codec,snd_pcm_oss
snd_timer              27272  2 snd_seq,snd_pcm
ir_common              38916  2 saa7134,ir_kbd_i2c
i2c_viapro             11544  0=20
pcspkr                  4608  0=20
serio_raw               9092  0=20
videodev               31360  1 saa7134
v4l2_common            21888  4 tuner,saa7134,compat_ioctl32,videodev
v4l1_compat            15364  2 saa7134,videodev
k8temp                  7680  0=20
snd_page_alloc         12560  3 snd_via82xx,snd_via82xx_modem,snd_pcm
snd                    69288  15 saa7134_alsa,snd_via82xx,snd_mpu401_uart,s=
nd_seq_oss,snd_rawmidi,snd_via82xx_modem,snd_ac97_codec,snd_pcm_oss,snd_mix=
er_oss,snd_seq,snd_seq_device,snd_pcm,snd_timer
soundcore              10272  1 snd
shpchp                 38300  0=20
i2c_core               30208  11 w83627ehf,i2c_isa,tda827x,saa7134_dvb,dvb_=
pll,tda1004x,tuner,nvidia,saa7134,ir_kbd_i2c,i2c_viapro
yenta_socket           30220  1=20
rsrc_nonstatic         14208  1 yenta_socket
pcmcia_core            46628  3 pcmcia,yenta_socket,rsrc_nonstatic
pci_hotplug            36612  1 shpchp
evdev                  13056  4=20
ext3                  146576  7=20
jbd                    69360  1 ext3
mbcache                11272  1 ext3
ide_cd                 35488  0=20
cdrom                  41768  1 ide_cd
ide_disk               20352  9=20
ata_generic             9988  0=20
floppy                 69608  0=20
ehci_hcd               40076  0=20
via_rhine              28936  0=20
mii                     7424  1 via_rhine
uhci_hcd               29600  0=20
usbcore               161584  4 usbhid,ehci_hcd,uhci_hcd
sata_via               14596  0=20
libata                138928  2 ata_generic,sata_via
scsi_mod              172856  2 sbp2,libata
via82cxxx              11268  0 [permanent]
ide_core              141200  3 ide_cd,ide_disk,via82cxxx
ohci1394               38984  0=20
ieee1394              109528  2 sbp2,ohci1394
thermal                16528  0=20
processor              36232  2 powernow_k8,thermal
fan                     6920  0=20
fuse                   52528  1=20
apparmor               47008  0=20
commoncap               9472  1 apparmor
---------------------------------------------------------------------------=
--------


'sudo lspci':
---------------------------------------------------------------------------=
--------
00:00.0 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890=
 South]
00:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Control=
ler (rev 46)
00:0c.0 Multimedia controller: Philips Semiconductors SAA7133/SAA7135 Video=
 Broadcast Decoder (rev d1)
00:0d.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controlle=
r (rev 01)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Co=
ntroller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT82=
3x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contr=
oller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contr=
oller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contr=
oller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contr=
oller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/=
K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8=
237 AC97 Audio Controller (rev 60)
00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Contro=
ller (rev 80)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev =
78)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Hyp=
erTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Add=
ress Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRA=
M Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Mis=
cellaneous Control
01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5500=
] (rev a1)
---------------------------------------------------------------------------=
--------
_______________________________________________________________________
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 30 Tage
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/?mc=022220


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
