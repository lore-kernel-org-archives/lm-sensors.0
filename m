From: j.todd.patrick@gmail.com (Todd Patrick)
Date: Tue, 28 Mar 2006 04:32:58 +0000
Subject: [lm-sensors] What is the status for drivers for the SMSC 47M15x/192
Message-Id: <d7a66840603272032m42b97167nfa2e63b6078baa43@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have the following:

kernel: 2.6.16 (custom compile with AMD Cool'n'Quiet Driver Version 1.50.03)
motherboard: MSI MS-7184
cpu: AMD Athlon 64 X2 3800+
ram: 1GB

When running sensors-detect, the output is:

# I2C adapter drivers
i2c-isa
# I2C chip drivers
# no driver for SMSC 47M15x/192 Super IO Fan Sensors yet

What is the status for drivers for the SMSC 47M15x/192 Super IO Fan Sensors?

I would be happy to help test.

Thank you.

--Todd


$ sensors-detect

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
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `to-be-written' for device 00:14.0: ATI Technologies Inc ATI SMBus
Probe succesfully concluded.

As you are not root, we can't load adapter modules. We will only scan
already loaded adapters.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. As you are not root, we will just hope you edited
 `/etc/modules.conf' for automatic loading of
 this module. If not, you won't be able to open any /dev/i2c-* file.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

As you are not root, we shall skip this step.

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

As you are not root, we shall skip this step.

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status.
tpatrick at ubuntu:~$ sudo sensors-detect
Password:

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
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `to-be-written' for device 00:14.0: ATI Technologies Inc ATI SMBus
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `to-be-written' (say NO if built into your kernel)? (YES/no): YES
FATAL: Module to_be_written not found.
Loading failed... skipping.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): YES
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): YES
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

Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x6001)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x6001)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x6001)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0x60)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0x60)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0x60)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0x60)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0x60)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0x60)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x60)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x60)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x60)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Success... found at address 0x0800
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x60)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x60)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x60)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0x60)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no): YES
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

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0800 (Busdriver `i2c-isa')
    Chip `SMSC 47M15x/192 Super IO Fan Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? I2C

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-isa
# I2C chip drivers
# no driver for SMSC 47M15x/192 Super IO Fan Sensors yet
#----cut here----

Do you want to add these lines to /etc/modules automatically? (yes/NO)NO

--
--Todd

jtp51 at cox.net

