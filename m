From: greanie@yahoo.com (Michael Greenish)
Date: Thu, 30 Jun 2005 14:41:57 +0000
Subject: [lm-sensors] could not create ticket
Message-Id: <20050630124115.65074.qmail@web60418.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I tried several times to submit this ticket but did
not get a confirmation email and could not find my
ticket in any of the lists.  Below, please find my
issue.  I have tried to include everything requested
in the FAQ section 5.1.  Thank you in advance for your
help.

motherboard: asus P5GD2 Premium
chipsets: Intel? 915P, Intel? ICH6R
distribution: SuSE 9.2
kernel: 2.6.8-24.14-smp
processor: Intel P4 3.0 GHz
lm-sensors: 2.9.1 (trying to install)

My overall goal is to get my cpu temperature since I
am getting over-temperature messages.  

First I did a sensors-detect.

****** START OF sensors-detect: *********

ishare:/home/greanie # sensors-detect

This program will help you determine which I2C/SMBus
modules you need to
load to use lm_sensors most effectively. You need to
have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access
to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers
built in, you can
safely answer NO if asked to load some modules. In
this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the
default answers to all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus
adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-matroxfb' for device 01:0a.0: MGA
2164W [Millennium II]
Use driver `i2c-i801' for device 00:1f.3: Intel ICH6
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-matroxfb' (say NO if built into your
kernel)? (YES/no): y
FATAL: Module i2c_matroxfb not found.
Loading failed... skipping.
Load `i2c-i801' (say NO if built into your kernel)?
(YES/no): y
Module loaded succesfully.
If you have undetectable or unsupported adapters, you
can have them
scanned by manually loading the modules before running
this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely
skip this.
 i2c-dev is not loaded. Do you want to load it now?
(YES/no): y
 Module loaded succesfully.

 We are now going to do the adapter probings. Some
adapters may hang halfway
 through; we can't really help that. Also, some chips
will be double detected;
 we choose the one with the highest confidence value
in that case.
 If you found that the adapter hung after probing a
certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 0400 (Algorithm
unavailable)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x08
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'...
Failed!
Client found at address 0x31
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x48
Probing for `National Semiconductor LM75'... Success!
    (confidence 6, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Maxim MAX6650/MAX6651'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x49
Probing for `National Semiconductor LM75'... Success!
    (confidence 6, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x53
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')
Client found at address 0x69

Some chips are also accessible through the ISA bus.
ISA probes are
typically a bit more dangerous, as we have to write to
I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): y
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
Probing for `VIA Technologies VT82C686 Integrated
Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated
Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super
I/O probes are
typically a bit more dangerous, as we have to write to
I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): y
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x88)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x88)

Do you want to scan for secondary Super I/O sensors?
(YES/no): y
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

Driver `lm75' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400' (Algorithm
unavailable)
    Busdriver `i2c-i801', I2C address 0x48
    Chip `National Semiconductor LM75' (confidence: 6)
  * Bus `SMBus I801 adapter at 0400' (Algorithm
unavailable)
    Busdriver `i2c-i801', I2C address 0x49
    Chip `National Semiconductor LM75' (confidence: 6)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400' (Algorithm
unavailable)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 0400' (Algorithm
unavailable)
    Busdriver `i2c-i801', I2C address 0x53
    Chip `SPD EEPROM' (confidence: 8)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400' (Algorithm
unavailable)
    Busdriver `i2c-i801', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence:
1)


 I will now generate the commands needed to load the
I2C modules.
 Sometimes, a chip is available both through the ISA
bus and an I2C bus.
 ISA bus access is faster, but you need to load an
additional driver module
 for it. If you have the choice, do you want to use
the ISA bus or the
 I2C/SMBus (ISA/smbus)? ISA

To make the sensors modules behave correctly, add
these lines to
/etc/modprobe.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some
/etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
# I2C chip drivers
modprobe lm75
modprobe eeprom
modprobe smbus-arp
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your
kernel, the list above
will contain too many modules. Skip the appropriate
ones! You really should
try these commands right now to make sure everything
is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors?
(YES/no): Y
Copy
/usr/share/doc/packages/sensors/prog/init/lm_sensors.init.suse
to /etc/init.d/lm_sensors for initialization at boot
time.

****** END OF sensors-detect: *********

I copied over the files as suggested.

Next I did sensors:

****** START OF sensors *********
share:/home/greanie # sensors
eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 0400
Unknown EEPROM type (8)

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 0400
Unknown EEPROM type (8)

****** END OF sensors *******

Since I couldn't get the modules loaded properly, I
decided just to reinstall the lm_sensors from source. 
So I downloaded i2c-2.9.1.tar.gz to my home directory
and expanded it.  Then I went inside the i2c-2.9.1
directory and typed "make user" and got the following:

****** START of make user *******

share:/home/greanie # cd i2c-2.9.1
ishare:/home/greanie/i2c-2.9.1 # make user; make
user_install
grep: /lib/modules/2.6.8-24.14-smp/build/Makefile: No
such file or directory
grep:
/lib/modules/2.6.8-24.14-smp/build/include/linux/autoconf.h:
No such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
Makefile:184: kernel/i2c-core.d: No such file or
directory
Makefile:184: kernel/i2c-dev.d: No such file or
directory
Makefile:184: kernel/i2c-algo-bit.d: No such file or
directory
Makefile:184: kernel/i2c-algo-biths.d: No such file or
directory
Makefile:184: kernel/i2c-elv.d: No such file or
directory
Makefile:184: kernel/i2c-velleman.d: No such file or
directory
Makefile:184: kernel/i2c-algo-pcf.d: No such file or
directory
Makefile:184: kernel/i2c-proc.d: No such file or
directory
Makefile:184: kernel/i2c-pport.d: No such file or
directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory

Error - missing file
/lib/modules/2.6.8-24.14-smp/build/.config !!
  Verify kernel source is in
/lib/modules/2.6.8-24.14-smp/build and then
  cd to /lib/modules/2.6.8-24.14-smp/build and run
'make config' !!

Exception: if you're using a stock RedHat/Fedora
kernel...
  (1) Install the appropriate kernel-source RPM.
  (2) Copy the appropriate config...
      from
/lib/modules/2.6.8-24.14-smp/build/configs/<...>
      to /lib/modules/2.6.8-24.14-smp/build/.config
  (3) Do *NOT* 'make dep' or 'make config'.

make: *** [/lib/modules/2.6.8-24.14-smp/build/.config]
Error 1
grep: /lib/modules/2.6.8-24.14-smp/build/Makefile: No
such file or directory
grep:
/lib/modules/2.6.8-24.14-smp/build/include/linux/autoconf.h:
No such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory
Makefile:184: kernel/i2c-core.d: No such file or
directory
Makefile:184: kernel/i2c-dev.d: No such file or
directory
Makefile:184: kernel/i2c-algo-bit.d: No such file or
directory
Makefile:184: kernel/i2c-algo-biths.d: No such file or
directory
Makefile:184: kernel/i2c-elv.d: No such file or
directory
Makefile:184: kernel/i2c-velleman.d: No such file or
directory
Makefile:184: kernel/i2c-algo-pcf.d: No such file or
directory
Makefile:184: kernel/i2c-proc.d: No such file or
directory
Makefile:184: kernel/i2c-pport.d: No such file or
directory
grep: /lib/modules/2.6.8-24.14-smp/build/.config: No
such file or directory

Error - missing file
/lib/modules/2.6.8-24.14-smp/build/.config !!
  Verify kernel source is in
/lib/modules/2.6.8-24.14-smp/build and then
  cd to /lib/modules/2.6.8-24.14-smp/build and run
'make config' !!

Exception: if you're using a stock RedHat/Fedora
kernel...
  (1) Install the appropriate kernel-source RPM.
  (2) Copy the appropriate config...
      from
/lib/modules/2.6.8-24.14-smp/build/configs/<...>
      to /lib/modules/2.6.8-24.14-smp/build/.config
  (3) Do *NOT* 'make dep' or 'make config'.

make: *** [/lib/modules/2.6.8-24.14-smp/build/.config]
Error 1

******* END of make user ********

I looked through all the installation documentation,
the FAQ and searched the user group.  I found one
reference to someone who had a similar issue, ticket
1851 or something like that, but I could not repeat
what he did.  I would greatly appreciate some help!!!

I also did a lsmod along the way

****** START of lsmod ***********
ishare:/home/greanie # lsmod
Module                  Size  Used by
udf                    93572  0
eeprom                 12448  0
lm75                   12828  0
i2c_dev                14080  0
i2c_i801               12300  0
i2c_sensor              7936  2 eeprom,lm75
i2c_core               28160  5
eeprom,lm75,i2c_dev,i2c_i801,i2c_sensor
joydev                 13760  0
sg                     42528  0
st                     43164  0
sr_mod                 21156  0
nvram                  13832  0
usbserial              33000  0
parport_pc             43968  1
lp                     14984  0
parport                44616  2 parport_pc,lp
edd                    14620  0
snd_pcm_oss            66728  0
snd_pcm               113284  1 snd_pcm_oss
snd_page_alloc         14600  1 snd_pcm
snd_mixer_oss          25216  1 snd_pcm_oss
snd_virmidi             8132  0
snd_seq_virmidi        11776  1 snd_virmidi
snd_rawmidi            30628  1 snd_seq_virmidi
snd_seq_midi_event     11904  1 snd_seq_virmidi
snd_seq                63376  2
snd_seq_virmidi,snd_seq_midi_event
snd_timer              31620  2 snd_pcm,snd_seq
snd_seq_device         13196  2 snd_rawmidi,snd_seq
snd                    70532  10
snd_pcm_oss,snd_pcm,snd_mixer_oss,snd_virmidi,snd_seq_virmidi,snd_rawmidi,snd_seq_midi_event,snd_seq,snd_timer,snd_seq_device
soundcore              13792  1 snd
ipv6                  272256  27
af_packet              26760  0
ide_cd                 44448  0
cdrom                  42652  2 sr_mod,ide_cd
subfs                  12672  1
sk98lin               189548  1
ehci_hcd               35204  0
uhci_hcd               36496  0
ohci1394               37764  0
ieee1394              116536  1 ohci1394
intel_agp              25504  1
agpgart                37804  1 intel_agp
evdev                  13184  0
dm_mod                 63104  0
usbcore               120164  5
usbserial,ehci_hcd,uhci_hcd
reiserfs              265680  8
sata_sil               12164  0
ata_piix               12932  9
libata                 48644  2 sata_sil,ata_piix
sd_mod                 22144  10
scsi_mod              121412  5
sg,st,sr_mod,libata,sd_mod

****** END of lsmod ***********

Other stuff:

ishare:/home/greanie # i2cdetect 0
  WARNING! This program can confuse your I2C bus,
cause data loss and worse!
  I will probe file /dev/i2c-0.
  I will probe address range 0x03-0x77.
  You have five seconds to reconsider and press
CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 2f
30: XX 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX 48 49 XX XX XX XX XX XX
50: XX UU XX UU XX XX XX XX XX XX XX XX XX XX XX XX
60: XX 61 XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX

ishare:/home/greanie # i2cdump 0 0x51
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus,
cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x51, mode
byte
  You have five seconds to reconsider and press
CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f   
0123456789abcdef
00: 80 08 08 0d 0a 61 40 00 05 3d 50 00 82 08 00 00   
?????a@.?=P.??..
10: 0c 04 18 00 02 00 01 50 60 00 00 3c 1e 3c 2d 40   
???.?.?P`..<?<-@
20: 25 37 10 22 3c 1e 1e 00 00 3c 4b 80 1e 28 00 00   
%7?"<??..<K??(..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 95   
...............?
40: 7f 7f 9e 00 00 00 00 00 01 56 53 35 31 32 4d 42   
???.....?VS512MB
50: 35 33 33 44 32 20 20 20 20 20 20 4d 42 05 07 18   
533D2      MB???
60: 1b 24 e8 00 00 35 30 34 38 30 38 36 00 ff 00 00   
?$?..5048086....
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................

ishare:/home/greanie # i2cdump 0 0x53
No size specified (using byte-data access)
  WARNING! This program can confuse your I2C bus,
cause data loss and worse!
  I will probe file /dev/i2c-0, address 0x53, mode
byte
  You have five seconds to reconsider and press
CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f   
0123456789abcdef
00: 80 08 08 0d 0a 61 40 00 05 3d 50 00 82 08 00 00   
?????a@.?=P.??..
10: 0c 04 18 00 02 00 01 50 60 00 00 3c 1e 3c 2d 40   
???.?.?P`..<?<-@
20: 25 37 10 22 3c 1e 1e 00 00 3c 4b 80 1e 28 00 00   
%7?"<??..<K??(..
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 95   
...............?
40: 7f 7f 9e 00 00 00 00 00 01 56 53 35 31 32 4d 42   
???.....?VS512MB
50: 35 33 33 44 32 20 20 20 20 20 20 4d 42 05 07 18   
533D2      MB???
60: 1a fb 29 00 00 35 30 34 37 31 38 37 00 ff 00 00   
??)..5047187....
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
................


ishare:/home/greanie # sensors -v
sensors version 2.8.7 with libsensors version 2.8.7


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
