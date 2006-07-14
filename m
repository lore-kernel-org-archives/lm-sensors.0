From: gutierrd@us.ibm.com (David Gutierrez)
Date: Fri, 14 Jul 2006 21:43:50 +0000
Subject: [lm-sensors] IBM eServer xSeries 335 and sensors-detect problem
Message-Id: <OF3DF64E55.31F845E8-ON852571AB.0058D4DA-882571AB.007755F8@us.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hello,

I'm trying to use lm_sensors 2.10.0 on an IBM eServer xSeries 335 machine
with dual 2.4 GHz Intel Xeon processors, Fedora Core 3, Kernel 2.6.13.4,
with sysfsutils 2.0.0-1 installed.

I'm having problems using sensors-detect: it cannot load i2c_piix4, and
does not detect any chips (see below).  The module i2c_piix4 is indeed not
available (the available ones are i2c-dev.ko, i2c-core.ko, i2c-parport.ko,
i2c-algo-pcf.ko and i2c-algo-bit.ko).

The installation procedure for lm_sensors 2.10.0 clearly states that for
kernels 2.6 and above we should use the i2c that comes with it.  Given the
previous hardware problems between i2c_piix4 and some IBM machines, I'm a
bit hesitant on how to proceed:

. Is not having i2c_piix4 the problem?
. Should I make this module available?  How?

Many thanks for your help,

David

----- sensors-detect output -------

[root at obelisk david]# sensors-detect
# sensors-detect revision 1.413 (2006/01/19 20:28:00)

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
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB5 South Bridge
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):
FATAL: Module i2c_piix4 not found.
Loading failed... skipping.
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
Probing for `Winbond W83627EHF'
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
  Failed! (0xee19)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xee19)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xee19)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0xee)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0xee)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0xee)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0xee)
Probing for `Nat. Semi. PC8741x Super IO'
  Success... (no hardware monitoring capabilities)
Probing for `Nat. Semi. PCPC87427 Super IO'
  Failed! (0xee)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0xee)
Probing for `SMSC 47M172 Super IO'
  Failed! (0xee)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0xee)
Probing for `SMSC SCH5307-NS Super IO'
  Failed! (0xee)
Probing for `VT1211 Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83687THF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0xee)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0xee)
Probing for `Winbond W83L517D Super IO'
  Failed! (0xee)
Probing for `Fintek F71805F/FG Super IO Sensors'
  Failed! (0xee19)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (0xee19)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status.





