From: mross@rs-net.org (Ross Skaliotis)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: ADM1027 not detected on Tyan S5112
Message-Id: <Pine.LNX.4.44.0406171051020.30199-100000@mail.internal.brightstareng.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is in regards to ticket #1697.

The S5112 is a new motherboard, only released a few months ago.

I was told to send the complete output of sensors-detect. Here you go. I
really appreciate your help. One point of interest is that sensors-detect
wants to load i2c-dev, yet it is already loaded. Could this be a problem?

----------------

root@camilla root # lsmod
Module                  Size  Used by
i2c_dev                 8704  0
i2c_core               21124  1 i2c_dev
e1000                  76804  0

root@camilla root # sensors -v
sensors version 2.8.6

root@camilla root # cat /proc/version
Linux version 2.6.6 (root@camilla) (gcc version 3.3.3 20040412 (Gentoo
Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #3 SMP Tue Jun 15 20:29:06 EST
2004

root@camilla root # sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c/*
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
Sorry, no PCI bus adapters found.

We will now try to load each adapter module in turn.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

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
  Failed! (0x5217)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x5217)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x5217)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87365 Super IO Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87366 Super IO Sensors'
  Failed! (0x52)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x52)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x52)
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
Probing for `Winbond W83697UF Super IO PWM'
  Failed! (0x52)

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
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

If you want to load the modules at startup, generate a config file
below and make sure lm_sensors get started (eg. rc-update add lm_sensors
default).

To make the sensor modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----end cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really
should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.
To load everything that is needed, execute the commands above...

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----end cut here----

Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify other
file name?
  (yes/NO/s):

--------------------------------------------

