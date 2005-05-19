From: tango@lugmen.org.ar (TaNgO)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: need more than eeprom :)
Message-Id: <425C221D.5010909@lugmen.org.ar>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guys!

First of all... GREAT SITE! The workflow to detect and configure the=20
chips it's simple and easy to follow.

After 3 hours reading it, plus lm-sensors package doc, plus google=20
search I finally write to you.
Early in the morning I started a ticket, but... after reading more, I=20
find out that was incomplete.

Here is my full report. Only thing detected is EEPROM. Nothing about=20
HW's health.
Not included here, but I have syslog lines, more than 5000 lines of=20
messages from i2c modules. If you think they are needed, just ask for=20
them. ;)

---------------------------------------------------------------------------=
------------------------------
Motherboard: ASRock P4i65GV
System: Debian GNU/Linux Sarge
Kernel: 2.6.11-5 (from ftp.kernel.org)
lm-sensors: 2.9.0 (via apt-get)

First, this lspci output

rosita:/usr/share/doc/lm-sensors/examples/config# lspci
0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM=20
Controller/Host-Hub Interface (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated=20
Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB=20
UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB=20
UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB=20
UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB=20
UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2=20
EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge=20
(rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra=20
ATA 100 Storage Controller (rev 02)
0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150=20
Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller=20
(rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER=20
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
0000:01:02.0 Ethernet controller: Silicon Integrated Systems [SiS]=20
SiS900 PCI Fast Ethernet (rev 02)
0000:01:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd.=20
RTL-8139/8139C/8139C+ (rev 10)

lspci detalied output suppresing irrelevant ones...

rosita:/usr/share/doc/lm-sensors/examples/config# lspci -vv
0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM=20
Controller/Host-Hub Interface (rev 02)
 Subsystem: Unknown device 1849:2570
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B-
 Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <TAbort-=20
<MAbort+ >SERR- <PERR-
 Latency: 0
 Region 0: Memory at fe800000 (32-bit, prefetchable) [size=3D4M]
 Capabilities: [e4] #09 [1106]

[...]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if=20
00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR+ FastB2B-
 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=FAst >TAbort- <TAbort-=20
<MAbort- >SERR- <PERR-
 Latency: 0
 Bus: primary=00, secondary=01, subordinate=01, sec-latencyd
 I/O behind bridge: 0000b000-0000bfff
 Memory behind bridge: fe500000-fe5fffff
 BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge=20
(rev 02)
 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B-
 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 0

[...]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller=20
(rev 02)
 Subsystem: Unknown device 1849:24d0
 Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=20
Stepping- SERR- FastB2B-
 Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=20
<TAbort- <MAbort- >SERR- <PERR-
 Interrupt: pin B routed to IRQ 5
 Region 4: I/O ports at 0400 [size2]

[...]

This was my kernel config:

<M> I2C support                        =20
<M>   I2C device interface             =20
      I2C Algorithms  ---> (If I2C in on kernel, these appear as modules)
 --- I2C bit-banging interfaces
 --- I2C PCF 8584 interfaces =20
 --- I2C PCA 9564 interfaces =20

      I2C Hardware Bus support  ---> (everything as module, including)  =20
 <M> Intel 801     =20
 <M> Intel 810/815

      Hardware Sensors Chip support  ---> (everything as module, including)
 <M> Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F
 <M> Winbond W83L785TS-S                     =20
 <M> Winbond W83627HF, W83627THF, W83637HF, W83697HF

      Other I2C Chip support  --->     =20
 <M> EEPROM reader
 <M> Philips PCF8574 and PCF8574A
 <M> Philips PCF8591
 <M> Epson 8564 RTC chip

[*]   I2C Core debugging messages      =20
[*]   I2C Algorithm debugging messages     =20
[*]   I2C Bus debugging messages      =20
[*]   I2C Chip debugging messages =20


This was my procedure to detect sensors

rosita:/# sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double=20
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 0400
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83627HF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x52)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x52)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)

Driver `w83781d' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
i2c-isa
# I2C chip drivers
eeprom
w83627hf
#----cut here----

Do you want to add these lines to /etc/modules automatically? (yes/NO)yes


After doing this, reboot and this is lsmod output

rosita:/# lsmod
Module                  Size  Used by
eeprom                  7824  0
w83627hf               30760  0
i2c_isa                 2176  0
i2c_sensor              4480  2 eeprom,w83627hf
i2c_dev                11392  0
i2c_i801               11276  0
i2c_core               26000  6=20
eeprom,w83627hf,i2c_isa,i2c_sensor,i2c_dev,i2c_i801
lp                     11972  0
usblp                  13312  0
af_packet              22792  2
tsdev                   8000  0
mousedev               12056  2
evdev                   9856  0
parport_pc             36548  1
parport                37448  2 lp,parport_pc
floppy                 61264  0
pcspkr                  3812  0
rtc                    12984  0
usb_storage            71360  0
8139cp                 20224  0
shpchp                102628  0
pci_hotplug            34736  1 shpchp
uhci_hcd               33296  0
intel_mch_agp          10896  0
8139too                26368  0
sis900                 20996  0
piix                   10756  0 [permanent]
ehci_hcd               35080  0
usbcore               122744  5 usblp,usb_storage,uhci_hcd,ehci_hcd
ntfs                  109296  1
nls_iso8859_1           4224  2
nls_cp850               4992  1
vfat                   14208  1
fat                    41884  1 vfat
dm_mod                 62332  0
snd_intel8x0           33856  1
snd_ac97_codec         78840  1 snd_intel8x0
snd_pcm_oss            54176  0
snd_mixer_oss          20480  1 snd_pcm_oss
snd_pcm                95752  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_page_alloc         10244  2 snd_intel8x0,snd_pcm
snd_seq_oss            35712  0
snd_seq_midi            8992  0
snd_rawmidi            25248  1 snd_seq_midi
snd_seq_midi_event      7808  2 snd_seq_oss,snd_seq_midi
snd_seq                55056  5 snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              26116  2 snd_pcm,snd_seq
snd_seq_device          8844  4 snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd                    57444  12=20
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,s=
nd_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore              10464  1 snd
intelfb                32388  1
cfbcopyarea             4224  1 intelfb
cfbimgblt               3200  1 intelfb
cfbfillrect             3840  1 intelfb
i830                   28928  1
drm                    67604  2 i830
intel_agp              23196  1
agpgart                35112  5 intel_mch_agp,intelfb,drm,intel_agp
hangcheck_timer         3480  0
psmouse                29704  0
ide_generic             1408  0 [permanent]
ide_cd                 42244  0
ide_core              130004  4 usb_storage,piix,ide_generic,ide_cd
cdrom                  41632  1 ide_cd
ext3                  144520  4
jbd                    61720  1 ext3
sd_mod                 19344  9
sg                     40096  0
unix                   29236  235


I'm using udev. At /sys/bus/i2c only have empty directories:

rosita:/etc# cd /sys
rosita:/sys# ls
block  bus  class  devices  firmware  kernel  module  power
rosita:/sys# cd bus
rosita:/sys/bus# ls
eisa  i2c  ide  ieee1394  MCA  pci  platform  pnp  scsi  serio  usb
rosita:/sys/bus# cd i2c
rosita:/sys/bus/i2c# ls
devices  drivers
rosita:/sys/bus/i2c# ls -Ra
.:
.  ..  devices  drivers

./devices:
.  ..

./drivers:
.  ..  dev_driver  i2c_adapter  w83627hf

./drivers/dev_driver:
.  ..

./drivers/i2c_adapter:
.  ..

./drivers/w83627hf:
.  ..

And... at /dev I have 2 nodes:

rosita:/dev# ll -a i2*
crw-rw----  1 root root 89, 0 2005-04-11 20:58 i2c-0
crw-rw----  1 root root 89, 1 2005-04-11 21:00 i2c-1

rosita:~# i2cdetect -l
i2c-1  dummy       ISA main adapter                     ISA bus algorithm
i2c-0  unknown     SMBus I801 adapter at 0400           Algorithm=20
unavailable
rosita:~# i2cdetect 1
Error: Can't use SMBus Quick Write command on this bus (ISA bus?)
rosita:~# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: 50 XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX                       =20
rosita:~# i2cdump 0 0x08
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x8, mode byte
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
rosita:~# i2cdump 0 0x44
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x44, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 0f 02 00 00 00 00 00 00 00 00 00 00 00 00    ..??............
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
rosita:~# i2cdump 0 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x50, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 40 00 04 50 60 00 82 08 00 01    ??????@.?P`.??.?
10: 0e 04 1c 01 02 20 00 60 70 75 75 3c 28 3c 28 40    ????? .`puu<(<(@
20: 60 60 40 40 00 00 00 00 00 37 46 20 28 50 00 00    ``@@.....7F (P..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8f    ...............?
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
rosita:~# i2cdump 0 0x69
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x69, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 16 14 e2 ff ef fc 22 00 40 8a 13 13 1f 91 0a 27    ???.??".@??????'
10: 3c 24 00 00 0a 47 50 ff ff ff ff ff ff ff ff ff    <$..?GP.........
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 16 14 e2 ff ef fc 22 00 40 8a 13 13 1f 91 0a 27    ???.??".@??????'
90: 3c 24 00 00 0a 47 50 ff ff ff ff ff ff ff ff ff    <$..?GP.........
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

rosita:/usr/src/linux# isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 65 6d d3 bf cb d1 d5 22 ff 3c ff 64 4b 64 4b ed
30: b0 56 08 2e a8 25 4c 2c 64 57 f3 af 32 45 00 00
40: 01 cb 0f 00 00 00 00 fd 2d 02 01 44 08 15 80 5c
50: ff ff 00 ff ff ff 00 80 21 70 ff ff 11 04 ff 05
60: 65 6d d3 bf cb d1 d5 22 ff 3c ff 64 4b 64 4b ed
70: b0 56 08 2e a8 25 4c 2c 64 57 f3 af 32 45 00 00
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 65 6d d3 bf cb d1 d5 22 ff 3c ff 64 4b 64 4b ed
b0: b0 56 08 2e a8 25 4c 2c 64 57 f3 af 32 45 00 00
c0: 01 00 00 00 00 00 00 fd 2d 02 01 44 08 15 80 5c
d0: ff ff 00 ff ff ff 00 80 21 70 ff ff 11 04 ff 05
e0: 65 6d d3 bf cb d1 d5 22 ff 3c ff 64 4b 64 4b ed
f0: b0 56 08 2e a8 25 4c 2c 64 57 f3 af 32 45 00 00


Using /etc/sensors.conf provided with lm-sensors-2.9.0, run sensors -s

Before load eeprom module

rosita:/etc# sensors
No sensors found!

After load eeprom module

rosita:/# sensors =20
eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

BUT.... I know I paied for 512 MB of RAM. :)
I don't see anything about CPU Temp, FAN Speed, o anything about my=20
hardwares health. :(

After this, I read more and found that I need run=20
/usr/share/doc/lm-sensors/config/grab_busses.sh

rosita:/# cd /usr/share/doc/lm-sensors/
rosita:/usr/share/doc/lm-sensors# ls
BACKGROUND           changelog.gz     copyright  examples      =20
README.gz           TODO.gz
changelog.Debian.gz  CONTRIBUTORS.gz  doc        README.Debian =20
README.thinkpad.gz
rosita:/usr/share/doc/lm-sensors# cd examples/
rosita:/usr/share/doc/lm-sensors/examples# ls
config  daemon  eeprom  hotplug  matorb  maxilife  tellerstats  xeon
rosita:/usr/share/doc/lm-sensors/examples# cd config
rosita:/usr/share/doc/lm-sensors/examples/config# ls
grab_busses.sh
rosita:/usr/share/doc/lm-sensors/examples/config# cat grab_busses.sh
#!/bin/bash

# This simple shell script grabs the contents of /proc/bus/i2c and=20
outputs it
# in sensors.conf format through stdout. You can use it to generate those
# nasty 'bus' statements in config files.

if [ $# =3D 0 ] ; then
  file=3D/proc/bus/i2c
elif [ $# =3D 1 ] ; then
  file=3D"$1"
else
  echo "Syntax: grab_busses [file]" >&2
  exit 1
fi

if [ ! -e "$file" ]; then
  echo "Can't find file \`$file';"\
       "try \`modprobe i2c-proc' for /proc/bus/i2c" >&2
  exit 1
fi

cat -- "$file" | awk \
 '  BEGIN { FS =3D "\t" }
     { sub(" *$","",$3)
       sub(" *$","",$4)
       printf "bus \"%s\" \"%s\" \"%s\"\n",$1,$3,$4 }
     { nrlines++ }
    END { printf "Total lines: %d\n",nrlines > "/dev/stderr"  }
 '
rosita:/usr/share/doc/lm-sensors/examples/config# ./grab_busses.sh
Can't find file `/proc/bus/i2c'; try `modprobe i2c-proc' for /proc/bus/i2c
rosita:/usr/share/doc/lm-sensors/examples/config#

But... As I explained early, I'm using udev, so I have no /proc/bus/i2c,=20
but /sys/bus/i2c

I don't know what to do next...
It seems like I don't have a valid sensors.conf file, but, don't know=20
how to build a valid one.

I hope this don't disturb too much to you. Thanks in advance

Mauro Dionisi
Mendoza - Argentina


--=20

------------------------------------------------
TaNgO - Mendoza (San Rafael)
Usuario Linux Registrado #270014
JID..: TaNgO@lugmen.org.ar
UIN: 41100189
msn, yahoo: mhdion

