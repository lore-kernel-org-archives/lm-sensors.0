From: chekov@alum.wpi.edu (chekov@alum.wpi.edu)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: temperature monitor on my w83627hf-isa-0290
Message-Id: <Pine.LNX.4.61.0505062352260.4119@c-24-130-248-54.hsd1.ca.comcast.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have an ABIT AG8 motherboard which uses a Winbond W83627HF-AW chip for 
I/O (other MB specs at: http://www.mbreview.com/ag8.php).
I am running Fedora Core to patched to kernel 2.6.10-1.771_FC2smp with 
lm_sensors 2.9.1 installed

I ran sensors-detect and received the output attached.  So far so good, it 
detected my w83627hf (as well as my tv-tuner card and a bunch of other 
stuff).  modprobed (see attached for full lsmod output)
Module                  Size  Used by
w83627hf               28129  0
eeprom                 11481  0
i2c_sensor              7361  2 w83627hf,eeprom
i2c_isa                 6081  0
i2c_dev                13377  0
i2c_i801               11981  0
..

then ran sensors -s, then sensors:

[12:37am] root@atlas:/etc> sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +4.08 V  (min =  +0.00 V, max =  +0.00 V)
VCore 2:   +4.08 V  (min =  +0.00 V, max =  +0.00 V)
+3.3V:     +4.08 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.24 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +11.98 V  (min = +10.82 V, max = +13.19 V)
-12V:      +1.54 V  (min = -13.18 V, max = -10.80 V)
V5SB:      +5.46 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +1.60 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min = 3391 RPM, div = 2)
fan2:        0 RPM  (min =    0 RPM, div = 2)
fan3:        0 RPM  (min = 5314 RPM, div = 2)
temp1:       -48C  (high =  -116C, hyst =   -65C)   sensor = thermistor
temp2:     -48.0C  (high =   +80C, hyst =   +75C)   sensor = thermistor
temp3:     -48.0C  (high =   +80C, hyst =   +75C)   sensor = thermistor
vid:      +0.000 V  (VRM Version 10.0)
alarms:
beep_enable:
           Sound alarm disabled
..

and I got -48C for all of my temps.
I know temperature monitoring is hooked up becaues I can enter the BIOS 
utility (abit calls it uguru) to give me realtime temp stats.  my processor 
tends to run around 50-80C depending on load.  I'd like to be able to see 
that realtime in linux but I've gone through the docs, FAQs, google, etc 
and haven't found a solution. 
I tried to change my "sensor" in the /etc/sensors.conf file to 1 or 2, but 
they both gave me +127C as the temp.  The voltages also seem off, but I 
don't much care about those at this point.
I also tried using the w83781d module instead of the w83627hf but got the 
same results (even installed clean after a reboot).
I'm stumped, wondering if this'll work at all.  any help would be great.

here's more of the info you wanted.  since I'm not that familiar with i2c I 
included both the i2cdetect output and the isa dump

[12:44am] root@atlas:/etc> isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff c2 c5 c7 ca d0 ff ff ff 00 00 00 00 d9
30: c4 c3 b1 d9 b2 32 15 3b 31 8c bf c7 ff 7f 00 00
40: 01 00 00 00 00 00 00 5f 1f 03 89 44 40 95 00 a3
50: ff ff 80 ff ff ff 00 00 21 60 ff ff 19 00 ff 05
60: ff ff ff c2 c5 c7 ca d0 ff ff ff 00 00 00 00 d9
70: c4 c3 b1 d9 b2 32 15 3b 31 8c bf c7 ff 7f 00 00
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff c2 c5 c7 ca d0 ff ff ff 00 00 00 00 d9
b0: c4 c3 b1 d9 b2 32 15 3b 31 8c bf c7 ff 7f 00 00
c0: 01 00 00 00 00 00 00 5f 1f 03 89 44 40 95 00 a3
d0: ff ff 80 ff ff ff 00 00 21 60 ff ff 19 00 ff 05
e0: ff ff ff c2 c5 c7 ca d0 ff ff ff 00 00 00 00 d9
f0: c4 c3 b1 d9 b2 32 15 3b 31 8c bf c7 ff 7f 00 00

[11:54pm] root@atlas:~> i2cdetect 0
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
50: UU XX UU XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX
-------------- next part --------------
[12:01am] root@atlas:/usr/share/doc/lm_sensors-2.9.1/doc> sensors-detect

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
Use driver `i2c-i801' for device 00:1f.3: Intel 82801FB ICH6
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
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 0500
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')

Next adapter: bt878 #0 [sw]
Do you want to scan it? (YES/no/selectively):
Can't open /dev/i2c-2

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
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
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
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (0x5241)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0500'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0500'
    Busdriver `i2c-i801', I2C address 0x52
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
modprobe eeprom
modprobe w83627hf
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.

-------------- next part --------------
Module                  Size  Used by
w83627hf               28129  0 
eeprom                 11481  0 
i2c_sensor              7361  2 w83627hf,eeprom
i2c_isa                 6081  0 
i2c_dev                13377  0 
i2c_i801               11981  0 
snd_intel8x0           33889  0 
snd_ac97_codec         68513  1 snd_intel8x0
nvidia               3908124  12 
snd_pcm_oss            51317  0 
snd_mixer_oss          21185  2 snd_pcm_oss
snd_bt87x              16645  1 
snd_pcm                89925  4 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_bt87x
snd_timer              27333  1 snd_pcm
snd                    55461  7 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_bt87x,snd_pcm,snd_timer
snd_page_alloc         13509  3 snd_intel8x0,snd_bt87x,snd_pcm
soundcore              12961  2 snd
tuner                  23661  0 
tvaudio                24033  0 
msp3400                27113  0 
bttv                  146769  2 
video_buf              24261  1 bttv
i2c_algo_bit           12361  1 bttv
v4l2_common             9793  1 bttv
btcx_risc               8521  1 bttv
videodev               13249  1 bttv
lirc_i2c               10116  1 
lirc_dev               15172  1 lirc_i2c
ipt_MASQUERADE          7617  1 
ipt_state               5953  2 
iptable_filter          7617  1 
ip_nat_ftp              8881  0 
iptable_nat            27877  3 ipt_MASQUERADE,ip_nat_ftp
ip_tables              21185  4 ipt_MASQUERADE,ipt_state,iptable_filter,iptable_nat
ip_conntrack_ftp       76145  1 ip_nat_ftp
ip_conntrack           45573  5 ipt_MASQUERADE,ipt_state,ip_nat_ftp,iptable_nat,ip_conntrack_ftp
i2c_core               24769  12 w83627hf,eeprom,i2c_sensor,i2c_isa,i2c_dev,i2c_i801,tuner,tvaudio,msp3400,bttv,i2c_algo_bit,lirc_i2c
sunrpc                135973  1 
e100                   35905  0 
mii                     8641  1 e100
r8169                  22473  0 
floppy                 56913  0 
sg                     38881  0 
microcode              11489  0 
raw1394                31661  0 
ohci1394               35161  0 
ieee1394              301945  2 raw1394,ohci1394
dm_mod                 58181  4 
joydev                 13057  0 
uhci_hcd               33753  0 
ehci_hcd               33737  0 
video                  19653  0 
button                 10577  0 
battery                13253  0 
ac                      8773  0 
ext3                  121929  3 
jbd                    57561  1 ext3
ahci                   14277  6 
libata                 44357  1 ahci
sd_mod                 19905  7 
scsi_mod              116289  4 sg,ahci,libata,sd_mod
