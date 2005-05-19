From: reuben-lmsensors@reub.net (Reuben Farrelly)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: it87 and lm85 tickets
Message-Id: <4247CE59.5030904@reub.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <42374305.6030000@mds.gotdns.com>
In-Reply-To: <42374305.6030000@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip,

Philip Pokorny wrote:
> Jean Delvare wrote:
> 
>>> lm85 new stepping 0x69: ticket 1933 (khali)
>>>   
>>
>>
>> I AM NOT THE LM85 GUY!
>>
>> The driver was written and is maintained by Philip Pokorny and Justin
>> Thiessen at Penguin Computing.
>>
>> #1933: [waiting for user data]
>>  
>>
> 
> So, I guess I *am* the LM85 guy.
> 
> Yes, please send or reply with 'i2c-dump 0 0x2e' when lm85 is *not* loaded.

Here you go..

[root@typhoon ~]# i2cdump 0 0x2e
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2e, mode byte
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 72 6d c8 c7 be 2c 27 2d d7 09 ff ff ff ff ff ff    rm???,'-??......
30: 4d 4d 4d 00 00 00 00 00 00 00 00 00 00 00 01 69    MMM...........?i
40: 05 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ?.............??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 02 22 42 7a    ????........?"Bz
60: 8a 80 e8 88 4d 4d 4d 38 2d 37 45 41 4b 24 40 00    ????MMM8-7EAK$@.
70: 2f 26 2d 05 00 07 00 00 00 00 00 60 07 27 6e 56    /&-?.?.....`?'nV
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
[root@typhoon ~]#

Here is also the output of sensors-detect without lm85 or any other lm modules 
  loaded:

[root@typhoon ~]# sensors-detect

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

  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
  IBM Thinkpads have a severely broken i2c/SMBus implementation, just scanning
  the bus will break your Thinkpad forever!
  If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We have
  had users reporting system breakage on other IBM systems as well.

  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no):
[root@typhoon ~]# /etc/init.d/lm_sensors stop
Stopping lm_sensors:                                       [  OK  ]
[root@typhoon ~]#
[root@typhoon ~]#
[root@typhoon ~]# sensors-detect

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

  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
  IBM Thinkpads have a severely broken i2c/SMBus implementation, just scanning
  the bus will break your Thinkpad forever!
  If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We have
  had users reporting system breakage on other IBM systems as well.

  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel ICH6
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
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

Next adapter: SMBus I801 adapter at c800
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Success!
     (confidence 7, driver `lm85')
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 or EMC6D101'... Failed!
Probing for `Analog Devices ADT7467'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
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
Probing for `Analog Devices ADM1028'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x30
Client found at address 0x32
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
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
   Failed! (0x7401)
Probing for `ITE 8705F Super IO Sensors'
   Failed! (0x7401)
Probing for `ITE 8712F Super IO Sensors'
   Failed! (0x7401)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
   Failed! (0x74)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
   Failed! (0x74)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
   Failed! (0x74)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
   Failed! (0x74)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
   Failed! (0x74)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
   Failed! (0x74)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
   Failed! (0x74)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
   Failed! (0x74)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
   Failed! (0x74)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
   Failed! (0x74)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
   Failed! (0x74)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
   Failed! (0x74)
Probing for `Nat. Semi. PC8739x Super IO'
   Failed! (0x74)
Probing for `Nat. Semi. PC8741x Super IO'
   Failed! (0x74)
Probing for `SMSC 47B27x Super IO Fan Sensors'
   Failed! (0x74)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
   Failed! (0x74)
Probing for `SMSC 47M14x Super IO Fan Sensors'
   Failed! (0x74)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
   Failed! (0x74)
Probing for `SMSC 47S42x Super IO Fan Sensors'
   Failed! (0x74)
Probing for `SMSC 47S45x Super IO Fan Sensors'
   Failed! (0x74)
Probing for `SMSC 47M172 Super IO'
   Failed! (0x74)
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

Driver `lm85' (should be inserted):
   Detects correctly:
   * Bus `SMBus I801 adapter at c800' (Algorithm unavailable)
     Busdriver `i2c-i801', I2C address 0x2e
     Chip `National Semiconductor LM85 or LM96000' (confidence: 7)

Driver `eeprom' (should be inserted):
   Detects correctly:
   * Bus `SMBus I801 adapter at c800' (Algorithm unavailable)
     Busdriver `i2c-i801', I2C address 0x50
     Chip `SPD EEPROM' (confidence: 8)
   * Bus `SMBus I801 adapter at c800' (Algorithm unavailable)
     Busdriver `i2c-i801', I2C address 0x51
     Chip `SPD EEPROM' (confidence: 8)
   * Bus `SMBus I801 adapter at c800' (Algorithm unavailable)
     Busdriver `i2c-i801', I2C address 0x52
     Chip `SPD EEPROM' (confidence: 8)
   * Bus `SMBus I801 adapter at c800' (Algorithm unavailable)
     Busdriver `i2c-i801', I2C address 0x53
     Chip `SPD EEPROM' (confidence: 8)


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
# I2C chip drivers
modprobe lm85
modprobe eeprom
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
[root@typhoon ~]#

The chip is pretty hard to locate on the board but if it's really necessary I 
can try again :(

reuben
