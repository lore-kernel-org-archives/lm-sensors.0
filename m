From: jriehl@knology.net (John Riehl)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: lm-sensors install goes fine, but I only get status of EEPROMs
Message-Id: <409C6578.2040008@knology.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

First, thanks for providing such a robust support page...you didn't have 
to do that for free software, but you did.  I tried to post this on the 
web-based help interface, but there was too much data to fit in the 
space provided.

OK, my problem:  the install of lm_sensors seems to go fine.  Everything 
gets detected like it should, but when I run 'sensors', all I see are 
the EEPROMs.  I've check the FAQ entry for this and think I've done what 
it says to do--still no luck.  This is an Intel D865PERL board.  I don't 
know the specific sesnor ID , but they are detected as an SMSC EMC6D100 
chipset...technical information is at 
http://www.smsc.com/main/catalog/emc6d100.html#Additional%20Information.  
If the lm85 driver isn't right for this chipset, and there isn't one 
that is, I'd be glad to try to build a driver...I will probably need 
some help on that.

Here's the stuff you asked for in the "How to Ask For Help" FAQ.  Let me 
know if I missed anything.  Thanks.

John

---------

lm_sensors verion 2.8.6, linux 2.6.5 SMP

[root@zippy lm_sensors-2.8.6]# prog/detect/sensors-detect
 
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
 through; we can't really help that. Also, some chips will be double 
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).
 
Next adapter: SMBus I801 adapter at c800 (Algorithm unavailable)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85'... Failed!
Probing for `Analog Devices ADM1027 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 and EMC6D101'... Success!
    (confidence 7, driver `lm85')
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Winbond W83L785TS-S'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1030'... Failed!
Probing for `Analog Devices ADM1031'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x44
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x52 can not be probed - unload all client drivers first!
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
  Trying address 0x0290... Failed!
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
  Failed! (0xf0d1)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xf0d1)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xf0d1)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87365 Super IO Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87366 Super IO Sensors'
  Failed! (0xf0)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Success... found at address 0x06e0
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0xf0)
Probing for `VT1211 Super IO Sensors'
  Failed! (0xf0)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0xf0)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0xf0)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0xf0)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0xf0)
Probing for `Winbond W83697UF Super IO PWM'
  Failed! (0xf0)
 
Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed!
Probing for `ITE 8705F Super IO Sensors'
  Failed!
Probing for `ITE 8712F Super IO Sensors'
  Failed!
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87365 Super IO Sensors'
  Failed!
Probing for `Nat. Semi. PC87366 Super IO Sensors'
  Failed!
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed!
Probing for `VT1211 Super IO Sensors'
  Failed!
Probing for `Winbond W83627HF Super IO Sensors'
  Failed!
Probing for `Winbond W83627THF Super IO Sensors'
  Failed!
Probing for `Winbond W83637HF Super IO Sensors'
  Failed!
Probing for `Winbond W83697HF Super IO Sensors'
  Failed!
Probing for `Winbond W83697UF Super IO PWM'
  Failed!
 
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:
 
Driver `lm85' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at c800' (Algorithm unavailable)
    Busdriver `i2c-i801', I2C address 0x2e
    Chip `SMSC EMC6D100 and EMC6D101' (confidence: 7)
 
Driver `to-be-written' (should be inserted):
  Detects correctly:
  * ISA bus address 0x06e0 (Busdriver `i2c-isa')
    Chip `Nat. Semi. PC87372 Super IO Fan Sensors' (confidence: 9)
 
 
 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?
 
To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:
 
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
 
To load everything that is needed, add this to some /etc/rc* file:
 
#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe lm85
# no driver for Nat. Semi. PC87372 Super IO Fan Sensors yet, ask us for one!
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----
 
WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
 
Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.

[root@zippy lm_sensors-2.8.6]# lsmod
Module                  Size  Used by
snd_pcm_oss            49700  0
snd_pcm                88224  1 snd_pcm_oss
snd_page_alloc          9860  1 snd_pcm
snd_timer              23684  1 snd_pcm
snd_mixer_oss          18304  1 snd_pcm_oss
snd                    47332  4 snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
soundcore               8544  1 snd
radeon                116144  0
lp                     10664  0
autofs                 15744  0
8139too                22912  0
floppy                 55412  0
sg                     34848  0
parport_pc             23232  1
parport                36296  2 lp,parport_pc
ehci_hcd               25348  0
uhci_hcd               32016  0
usbcore                93276  4 ehci_hcd,uhci_hcd
sr_mod                 15908  0
ide_scsi               15108  0
ide_cd                 38148  0
cdrom                  38688  2 sr_mod,ide_cd
eeprom                  7304  0
lm85                   20740  0
i2c_dev                 9728  0
i2c_sensor              3456  2 eeprom,lm85
i2c_algo_pcf            7300  0
i2c_algo_bit            9992  0
i2c_isa                 2816  0
i2c_i801                8080  0
i2c_core               19716  8 
eeprom,lm85,i2c_dev,i2c_sensor,i2c_algo_pcf,i2c_algo_bit,i2c_isa,i2c_i801
thermal                11920  0
processor              12240  1 thermal
fan                    3980  0
button                  5656  0
battery                 9100  0
ac                      4620  0
ata_piix                7428  0
libata                 35712  1 ata_piix,[permanent]
sd_mod                 18176  0
[root@zippy lm_sensors-2.8.6]# lspci -n
00:00.0 Class 0600: 8086:2570 (rev 02)
00:01.0 Class 0604: 8086:2571 (rev 02)
00:1d.0 Class 0c03: 8086:24d2 (rev 02)
00:1d.1 Class 0c03: 8086:24d4 (rev 02)
00:1d.2 Class 0c03: 8086:24d7 (rev 02)
00:1d.3 Class 0c03: 8086:24de (rev 02)
00:1d.7 Class 0c03: 8086:24dd (rev 02)
00:1e.0 Class 0604: 8086:244e (rev c2)
00:1f.0 Class 0601: 8086:24d0 (rev 02)
00:1f.1 Class 0101: 8086:24db (rev 02)
00:1f.2 Class 0101: 8086:24d1 (rev 02)
00:1f.3 Class 0c05: 8086:24d3 (rev 02)
00:1f.5 Class 0401: 8086:24d5 (rev 02)
01:00.0 Class 0300: 1002:5964 (rev 01)
01:00.1 Class 0380: 1002:5d44 (rev 01)
02:01.0 Class 0200: 10ec:8139 (rev 10)
[root@zippy lm_sensors-2.8.6]# prog/detect/i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 2e XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: UU XX UU XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

(*** 0x08 was all 'XX' ***)

[root@zippy lm_sensors-2.8.6]# prog/dump/i2cdump 0 0x2e
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x2e, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 72 70 c2 c6 bf 34 29 2c 15 04 ff ff d9 0f 9d 0c    rp???4),??..????
30: ff ff b7 00 00 00 00 00 00 00 00 00 00 00 5c 65    ..?...........\e
40: 05 00 00 13 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ?..?..........??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 22 70    ????........bb"p
60: 70 70 e0 00 80 80 4d 1e 23 23 41 2d 2d 44 40 00    pp?.??M?##A--D@.
70: ff ff c9 09 09 09 09 09 09 00 00 00 40 00 ec 18    ..???????...@.??
80: 1e a4 0e 00 00 ac 2e d4 9f 00 4d 4d 09 09 0b 00    ???..?.??.MM???.
90: 04 04 04 04 0c 0c 0c 5a f1 00 00 00 00 00 00 00    ???????Z?.......
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12    ...............?
[root@zippy lm_sensors-2.8.6]# prog/dump/i2cdump 0 0x44
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x44, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 0f 3f 00 00 00 00 00 00 00 00 00 00 00 00    ..??............
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
[root@zippy lm_sensors-2.8.6]# prog/dump/i2cdump 0 0x50
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x50, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 40 00 04 50 65 00 82 08 00 01    ??????@.?Pe.??.?
10: 0e 04 1c 01 02 20 00 60 70 75 75 38 28 38 28 40    ????? .`puu8(8(@
20: 60 60 40 40 00 00 00 00 00 37 46 20 28 50 00 00    ``@@.....7F (P..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c    ...............?
40: 7f 98 00 00 00 00 00 00 04 4b 00 00 00 00 00 00    ??......?K......
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 04 0a 60    .............??`
60: 10 34 92 00 00 00 00 00 00 00 00 00 00 00 00 00    ?4?.............
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 39 39 30 35 31 39 33 2d 30 31 35 2e 41 30 30 00    9905193-015.A00.
[root@zippy lm_sensors-2.8.6]# prog/dump/i2cdump 0 0x52
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x52, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 80 08 07 0d 0a 02 40 00 04 50 65 00 82 08 00 01    ??????@.?Pe.??.?
10: 0e 04 1c 01 02 20 00 60 70 75 75 38 28 38 28 40    ????? .`puu8(8(@
20: 60 60 40 40 00 00 00 00 00 37 46 20 28 50 00 00    ``@@.....7F (P..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 8c    ...............?
40: 7f 98 00 00 00 00 00 00 04 4b 00 00 00 00 00 00    ??......?K......
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 04 0a 60    .............??`
60: 10 2f 92 00 00 00 00 00 00 00 00 00 00 00 00 00    ?/?.............
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 39 39 30 35 31 39 33 2d 30 31 35 2e 41 30 30 00    9905193-015.A00.

[root@zippy lm_sensors-2.8.6]# prog/dump/i2cdump 0 0x69
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x69, mode byte
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
10: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
20: 0f 1f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
30: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
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
[root@zippy lm_sensors-2.8.6]# sensors
eeprom-i2c-0-52
Adapter: SMBus I801 adapter at c800
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512
 
eeprom-i2c-0-50
Adapter: SMBus I801 adapter at c800
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

