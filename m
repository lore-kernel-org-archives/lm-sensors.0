From: Guillaume Delacour <guillaume.delacour@gmail.com>
Date: Tue, 27 Jan 2009 19:30:16 +0000
Subject: [lm-sensors] HP VL400 sensors (2)
Message-Id: <5a54eff70901271130p1a948a5clb67baf0c93b8fa@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have an HP VL 400 (Version: R3B, P/N: D9820-60011) motherboard. None
of hardware status are displayed.
I want to know if is it possible to have temperature and more if
possible (voltage ?) via sensors:

# sensors
pc87360-isa-0820
Adapter: ISA adapter
fan1:        0 RPM  (min =  952 RPM, div = 8)          OVERFLOW
fan2:     1290 RPM  (min =  944 RPM, div = 4)

I just have fan2 speed value; fan1 is not plugged yet :)

# lspci -nn
00:00.0 Host bridge [0600]: Intel Corporation 82815 815 Chipset Host
Bridge and Memory Controller Hub [8086:1130] (rev 02)
00:01.0 PCI bridge [0604]: Intel Corporation 82815 815 Chipset AGP
Bridge [8086:1131] (rev 02)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801AA PCI Bridge
[8086:2418] (rev 02)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801AA ISA Bridge (LPC)
[8086:2410] (rev 02)
00:1f.1 IDE interface [0101]: Intel Corporation 82801AA IDE [8086:2411] (rev 02)
00:1f.2 USB Controller [0c03]: Intel Corporation 82801AA USB
[8086:2412] (rev 02)
00:1f.3 SMBus [0c05]: Intel Corporation 82801AA SMBus [8086:2413] (rev 02)
00:1f.5 Multimedia audio controller [0401]: Intel Corporation 82801AA
AC'97 Audio [8086:2415] (rev 02)
01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ [10ec:8139] (rev 10)
01:02.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ [10ec:8139] (rev 10)
01:04.0 Ethernet controller [0200]: 3Com Corporation 3c905C-TX/TX-M
[Tornado] [10b7:9200] (rev 78)
02:00.0 VGA compatible controller [0300]: Matrox Graphics, Inc. MGA
G400/G450 [102b:0525] (rev 04)

# lsmod
Module                  Size  Used by
pc87360                16944  0
hwmon_vid               2784  1 pc87360
i2c_isa                 5152  1 pc87360
eeprom                  7024  0
i2c_dev                 8548  0
i2c_matroxfb            5152  0
i2c_algo_bit            8424  1 i2c_matroxfb
matroxfb_base          28316  2 i2c_matroxfb
matroxfb_DAC1064       10560  1 matroxfb_base
matroxfb_accel          4320  1 matroxfb_base
matroxfb_Ti3026         5888  1 matroxfb_base
matroxfb_g450           6752  1 matroxfb_base
g450_pll                6048  2 matroxfb_DAC1064,matroxfb_g450
matroxfb_misc           8544  6
i2c_matroxfb,matroxfb_base,matroxfb_DAC1064,matroxfb_Ti3026,matroxfb_g450,g450_pll
ipv6                  226272  14
button                  6672  0
ac                      5188  0
battery                 9636  0
dm_snapshot            15552  0
dm_mirror              19152  0
dm_mod                 50200  2 dm_snapshot,dm_mirror
loop                   15048  0
snd_intel8x0           30332  0
snd_ac97_codec         83104  1 snd_intel8x0
snd_ac97_bus            2400  1 snd_ac97_codec
snd_pcm                68676  2 snd_intel8x0,snd_ac97_codec
snd_timer              20996  1 snd_pcm
snd                    47012  4 snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc         10184  2 snd_intel8x0,snd_pcm
parport_pc             32132  0
parport                33256  1 parport_pc
rtc                    12372  0
psmouse                35016  0
serio_raw               6660  0
floppy                 53124  0
i810_audio             32916  0
ac97_codec             17196  1 i810_audio
intel_agp              22204  1
agpgart                29896  1 intel_agp
pcspkr                  3072  0
soundcore               9248  2 snd,i810_audio
shpchp                 33024  0
pci_hotplug            28704  1 shpchp
i2c_i801                7468  0
i2c_core               19680  6
pc87360,i2c_isa,eeprom,i2c_dev,i2c_algo_bit,i2c_i801
evdev                   9088  0
ext3                  119336  1
jbd                    52456  1 ext3
mbcache                 8356  1 ext3
raid1                  21056  1
md_mod                 70388  2 raid1
ide_generic             1408  0 [permanent]
8139too                25120  0
ide_disk               14848  6
3c59x                  40360  0
8139cp                 21920  0
mii                     5344  3 8139too,3c59x,8139cp
uhci_hcd               21164  0
usbcore               112644  2 uhci_hcd
piix                    9444  0 [permanent]
generic                 4868  0 [permanent]
ide_core              110504  4 ide_generic,ide_disk,piix,generic
thermal                13608  0
processor              28840  1 thermal
fan                     4804  0

# i2cdetect -l
i2c-3   i2c             MAVEN:fb0
Algorithm unavailable
i2c-2   i2c             DDC:fb0 #1
Algorithm unavailable
i2c-1   i2c             DDC:fb0 #0
Algorithm unavailable
i2c-0   smbus           SMBus I801 adapter at 1810
Non-I2C SMBus adapter
# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: UU UU XX XX UU UU XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX



# sensors --version
sensors version 2.10.1 with libsensors version 2.10.1

# uname -r
2.6.18-6-686

# cat /etc/debian_version
4.0
(Debian stable Etch)

I followed steps founded in an old thread (and about this motherboard):
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012588.html

and it detect pc87360 module to load:

# sensors-detect > /tmp/sensors-detect
# cat /tmp/sensors-detect
-------------------------------------------------------------
# sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801AA ICH
Use driver `i2c-matroxfb' for device 0000:02:00.0: MGA G400 AGP

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
Module `i2c-matroxfb' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: MAVEN:fb0
Do you want to scan it? (YES/no/selectively):
Next adapter: DDC:fb0 #1
Do you want to scan it? (YES/no/selectively):
Next adapter: DDC:fb0 #0
Do you want to scan it? (YES/no/selectively):
Next adapter: SMBus I801 adapter at 1810
Do you want to scan it? (YES/no/selectively): Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x51
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x54
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x55
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x69

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): Probing for `National
Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): Probing for
Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                      Yes
Found unknown chip with ID 0xe111
Trying family `National Semiconductor'...                   Yes
Found `Nat. Semi. PC87360 Super IO Fan Sensors'             Success!
    (address 0x820, driver `pc87360')
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0xe111
Trying family `VIA/Winbond/Fintek'...                       Yes
Found unknown chip with ID 0xe111
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:
Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 1810'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `eeprom' (confidence: 6)
  * Bus `SMBus I801 adapter at 1810'
    Busdriver `i2c-i801', I2C address 0x51
    Chip `eeprom' (confidence: 6)
  * Bus `SMBus I801 adapter at 1810'
    Busdriver `i2c-i801', I2C address 0x54
    Chip `eeprom' (confidence: 6)
  * Bus `SMBus I801 adapter at 1810'
    Busdriver `i2c-i801', I2C address 0x55
    Chip `eeprom' (confidence: 6)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

Driver `pc87360' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0820 (Busdriver `i2c-isa')
    Chip `Nat. Semi. PC87360 Super IO Fan Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:
To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
# Chip drivers
eeprom
pc87360
#----cut here----


Do you want to add these lines to /etc/modules automatically? (yes/NO)

-------------------------------------------------------------

Modules are loaded successfully except *i2c-i801*.

Please note that i have tried last lm-sensors version 3.0.3 (by
sources) and there is same behaviour with sensors-detect/sensors.

Thanks and sorry if this is a my-side-configuration problem.

-- 
Guillaume Delacour.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
