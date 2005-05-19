From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors on Itanium
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F3@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Looks like I don't need a new kernel after all,

make -f Makefile.p4b
insmod p4b_smbus.o
modprobe  i2c-core
modprobe  i2c-i801
modprobe  i2c-dev
modprobe  i2c-proc
modprobe adm1026

[root@gb0010 sensors]# cat /proc/bus/i2c
i2c-1   smbus           SMBus I801 adapter at 0600              Non-I2C SMBus adapter

Still no luck, though,

[root@gb0010 sensors]# ./sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801DB ICH4
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 0600 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
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
 this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x5101)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x5101)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x5101)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87365 Super IO Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87366 Super IO Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x51)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x51)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x51)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83697UF Super IO PWM'
  Failed! (0x51)

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status.
