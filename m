From: aizvorski@gmail.com (Alex Izvorski)
Date: Wed, 17 May 2006 16:53:25 +0000
Subject: [lm-sensors] new chip request: SMSC DME1737
Message-Id: <1147884805.12397.145.camel@starfire>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have a board with an unsupported chip, any chance to add it?

The board is Tyan Tomcat K8E-SLI S2866 (Tyan S2865 has the same chip).
The chip is the SMSC DME1737 (according to Tyan).  It shows up at i2c
bus 1, address 0x2e.  Using  "modprobe lm85 force_emc6d102=1,0x2e" most
data may be read from it - voltages, fans and temperatures - I'm not
sure it is scaled correctly and the limits are definitely not set
correctly, but aside from that it's there.  It almost seems that we can
treat this as a emc6d102 clone, if only we could auto-detect it?

I can certainly provide debugging and testing, and possibly more if you
can give me some pointers on where to get started.

Sincerely,
Alex Izvorski


Here is a (very brief) datasheet:

http://pdf1.alldatasheet.com/datasheet-pdf/view/86009/SMSC/DME1737/datasheet.pdf

I am trying to obtain a more complete datasheet from SMSC.

My system is:

kernel 2.17-rc3
lm_sensors 2.9.2


Here is what I get from sensors after "modprobe lm85
force_emc6d102=1,0x2e" :

---------------------------------------------
emc6d102-i2c-1-2e
Adapter: SMBus nForce2 adapter at 1c40
in0:        +1.31 V  (min =  +0.00 V, max =  +3.32 V)
in1:        +1.28 V  (min =  +0.00 V, max =  +2.99 V)
in2:        +3.35 V  (min =  +0.00 V, max =  +4.38 V)
in3:       +4.99 V  (min =  +0.00 V, max =  +6.64 V)
in4:      +12.37 V  (min =  +0.00 V, max = +15.94 V)
fan1:      2618 RPM  (min =    0 RPM)
fan2:         0 RPM  (min =    0 RPM)
fan3:         0 RPM  (min =    0 RPM)
fan4:         0 RPM  (min =    0 RPM)
temp1:       +47 C  (low  =  -127 C, high =  +127 C)
temp2:       +30 C  (low  =  -127 C, high =  +127 C)
temp3:       +28 C  (low  =  -127 C, high =  +127 C)
pwm1:      255
pwm2:      255
pwm3:      255
vid:      +1.550 V  (VRM Version 2.4)
---------------------------------------------


The output of "i2cdump 1 0x2e b" :
---------------------------------------------
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c/1, address 0x2e, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe    ...............?
20: 64 6d c3 bf c5 2e 1d 1b 14 08 ff ff ff ff ff ff    dm???.????......
30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 5c 89    ..............\?
40: 05 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ?.............??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 ab    ????........bbb?
60: ab ab 00 00 80 80 80 2d 2d 2d 64 64 64 44 40 00    ??..???---dddD at .
70: ff ff ff 09 09 09 09 09 09 00 30 00 40 00 00 1c    ...??????.0. at ..?
80: 00 a4 00 00 00 a2 e1 b8 27 00 4d 4d 0b 0b 0c 00    .?...???'.MM???.
90: cc 04 04 04 0c 0c 0c 5a f1 c1 b0 00 ff 00 ff 00    ???????Z???.....
a0: 00 00 0c 00 02 00 00 0b 0b fe ff fe ff ff ff ff    ..?.?..???.?....
b0: ff 00 00 00 00 00 28 28 0e 0e 2b 2b 00 00 00 00    ......((??++....
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
---------------------------------------------


The output of sensors-detect:

---------------------------------------------
# sensors-detect revision 1.393 (2005/08/30 18:51:18)

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to
all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce4
SMBus (MCP)
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus nForce2 adapter at 1c40
Do you want to scan it? (YES/no/selectively): Client found at address
0x08
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Failed!
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `Analog Devices ADT7467'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
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
Probing for `Analog Devices ADM1028'... Failed!
Probing for `ITE IT8712F'... Failed!
Client found at address 0x37

Next adapter: SMBus nForce2 adapter at 1c00
Do you want to scan it? (YES/no/selectively): Client found at address
0x08
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x53
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): Probing for `National
Semiconductor LM78'
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

Do you want to scan for Super I/O sensors? (YES/no): Probing for `ITE
8702F Super IO Sensors'
  Failed! (0x7801)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x7801)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x7801)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x78)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x78)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x78)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x78)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0x78)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0x78)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0x78)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0x78)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0x78)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0x78)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x78)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0x78)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0x78)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0x78)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0x78)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0x78)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0x78)
Probing for `Nat. Semi. PCPC87427 Super IO'
  Failed! (0x78)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x78)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x78)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x78)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x78)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x78)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x78)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x78)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0x78)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no): Probing
for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:
Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x52
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x53
    Chip `SPD EEPROM' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?
If you want to load the modules at startup, generate a config file
below and make sure lm_sensors gets started; e.g
$ rc-update add lm_sensors default.

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----end cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really
should
try these commands right now to make sure everything is working
properly.
Monitoring programs won't work until it's done.
To load everything that is needed, execute the commands above...

#----cut here----
# I2C adapter drivers
modprobe i2c-nforce2
# I2C chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/bin/sensors -s # recommended

Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify
other file name?
  (yes/NO/s):
---------------------------------------------


