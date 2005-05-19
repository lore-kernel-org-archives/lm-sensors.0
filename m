From: aumoren.spn@heirsgroup.net (Anietie Umoren)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: No sensors dtected on Toshiba m35-s320 laptop
Message-Id: <1098011964.21400.87.camel@Proteus.spacenetltd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I will appreciate some help with my system. It is a centrino machine.
Could it be that there are no drivers for my sensor chips. The full
output from sensors -detect is attached. I'm running Fedora core 2
kernel 2.6.5-1.358



 This program will help you determine which I2C/SMBus modules you need
to
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
  Failed! (0x3c00)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x3c00)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x3c00)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x3c)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x3c)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x3c)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x3c)
Probing for `Nat. Semi. PC87365 Super IO Sensors'
  Failed! (0x3c)
Probing for `Nat. Semi. PC87366 Super IO Sensors'
  Failed! (0x3c)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x3c)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0x3c)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x3c)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x3c)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x3c)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x3c)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x3c)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x3c)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x3c)
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

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status

