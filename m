From: filip.tsachev@gmail.com (Filip Tsachev)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: hi about lm_sensors issue
Message-Id: <ea9ff50b050315215248daf6e5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

pls help me out here:


[root@cook etc]# sensors-detect

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
 Do you want to probe now? (YES/no): yes
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation
nForce2 SMBus (MCP)
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus nForce2 adapter at 2000
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x08

Next adapter: SMBus nForce2 adapter at 1c00
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client at address 0x51 can not be probed - unload all client drivers first!

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
  Trying address 0x0290... Success!
    (confidence 8, driver `it87')
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x8712)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8712)
Probing for `ITE 8712F Super IO Sensors'
  Success... found at address 0x0290
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)

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

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE 8712F Super IO Sensors' (confidence: 9)


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
modprobe i2c-isa
# I2C chip drivers
modprobe it87
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

it's a GB GA7N400L MB with Athlon 266MhzFSB

[root@cook rc.d]# /etc/rc.d/init.d/lm_sensors stop
Stopping lm_sensors:                                       [  OK  ]
[root@cook rc.d]# /etc/rc.d/init.d/lm_sensors start
Starting lm_sensors: loading module i2c-isa it87           [  OK  ]
[root@cook rc.d]# lsmod
Module                  Size  Used by
it87                   19045  0
i2c_isa                 2241  0
ipt_REJECT              6593  1
ipt_LOG                 6465  3
ipt_limit               3009  3
ipt_state               1857  1
ip_conntrack           40309  1 ipt_state
iptable_filter          3521  1
ip_tables              16321  5
ipt_REJECT,ipt_LOG,ipt_limit,ipt_state,iptable_filter
eeprom                  7641  0
i2c_sensor              3393  2 it87,eeprom
i2c_dev                10433  0
appletalk              31785  2
ipx                    29801  2
fglrx                 228156  7
parport_pc             26629  1
lp                     12077  0
parport                37001  2 parport_pc,lp
nls_utf8                2113  4
ntfs                   95984  3
dm_mod                 55637  0
video                  15813  0
button                  6609  0
battery                 9285  0
ac                      4805  0
ohci_hcd               23765  0
ehci_hcd               32585  0
i2c_nforce2             6337  0
i2c_core               20801  6
it87,i2c_isa,eeprom,i2c_sensor,i2c_dev,i2c_nforce2
snd_intel8x0           33249  1
snd_ac97_codec         67489  1 snd_intel8x0
snd_pcm_oss            47989  0
snd_mixer_oss          17089  2 snd_pcm_oss
snd_pcm                93001  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              29125  1 snd_pcm
snd                    52645  6
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10017  2 snd
snd_page_alloc          9541  2 snd_intel8x0,snd_pcm
8139too                26433  0
mii                     4673  1 8139too
ext3                  116297  1
jbd                    69977  1 ext3
[root@cook rc.d]#


problem is in :
[root@cook rc.d]# sensors
it8712-isa-0290
Adapter: ISA adapter
VCore 1:   +1.70 V  (min =  +1.42 V, max =  +1.57 V)   ALARM
VCore 2:   +2.61 V  (min =  +2.40 V, max =  +2.61 V)   ALARM
+3.3V:     +3.31 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.25 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
+12V:     +11.84 V  (min = +11.39 V, max = +12.61 V)
-12V:     -15.70 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -8.10 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
Stdby:     +4.65 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
VBat:      +4.08 V
fan1:     2596 RPM  (min =  664 RPM, div = 8)
CPU Temp:    +38?C  (low  =   +15?C, high =   +60?C)   sensor = thermistor
M/B Temp:    +27?C  (low  =   +15?C, high =   +50?C)   sensor = thermistor

eeprom-i2c-0-51
Adapter: SMBus nForce2 adapter at 1c00
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

[root@cook rc.d]#

CPU temp is at leasr 55C and that's mostly what I want to monitor and
voltages but they are not right
-- 
Regards,
Filip Tsachev

Technical Department
www.infodesign.bg
F-Secure Business Partner
