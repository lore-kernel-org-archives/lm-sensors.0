From: ballen@gravity.phys.uwm.edu (Bruce Allen)
Date: Wed, 01 Mar 2006 21:03:56 +0000
Subject: [lm-sensors] HT1000 support (see lm_sensors ticket 2031,
Message-Id: <Pine.LNX.4.62.0603011455030.27761@trinity.phys.uwm.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
In-Reply-To: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> -- I've rebuilt a stock 2.6.15.4 kernel using the HT1000 patch referenced
>>     on the newdrivers page:
>>     http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-piix4-add-ht1000-support.patch
>>
>> -- I then built and installed sysfsutils-2.0.0
>>
>> -- I then built and installed lm_sensors-2.10.0.
>>
>> -- I loaded the i2c_piix4 module using modprobe.
>>
>> -- I mounted sysfs on /sysfs
>>
>> However sensors-detect does not find ANYTHING.  Not even eeprom!  Am I
>> doing something stupid?
>
> The HT-1000 is (from our simplified point of view) an SMBus master. It
> may give you access to I2C/SMBus hardware monitoring chips, but isn't
> itself a hardware monitoring chip.

OK.  I tried loading the adm1026 module that Martin uses -- no go.
>
>> (Note: for kicks I also went into the lm_sensors source and 'hacked' the
>> SERVERWORKS CSB6 0x0203 PCI-id to be 0x0205 both the sensors-detect script
>> and in the i2c_piix4 code contained there. It didn't help.)
>
> The i2c-piix4 driver found in the lm_sensors is a Linux 2.4 driver, so
> it is of no use to you.

OK.  In any case I am loading the i2c-piix4 modules from the (modified) 
2.6.15 tree.

> Adding the ID to sensors-detect will let it autoload the i2c-piix4
> driver, but given that you had manually loaded it beforehand anyway, it
> did not change anything for you.
>
> Please check your logs after loading the i2c-piix4 driver. Did it
> complain of anything?

I just did:
   rmmod i2c_piix4
   modprobe  i2c_piix4
lsmod shows the module loaded, but there was NO output in 
/var/log/messages.

> Second, please provide the full output of sensors-detect. There are
> many possible reasons why no chips were found on your HT-1000, and this
> output should help us sort through them.

It's attached to this email.

> You may also provide the
> output of "i2cdetect 0" (assuming that the HT-1000 is the only i2c
> adapter on the system; if not try "i2cdetect -l" first.)

[root at nemo-slave0017 lm_sensors-2.10.0]# i2cdetect 0
Error: Could not open file `/dev/i2c-0': No such device
[root at nemo-slave0017 lm_sensors-2.10.0]# i2cdetect 1
Error: Could not open file `/dev/i2c-1': No such device

[root at nemo-slave0017 lm_sensors-2.10.0]# ls /dev/i2c*
/dev/i2c0   /dev/i2c1   /dev/i2c2   /dev/i2c3   /dev/i2c4   /dev/i2c5 
/dev/i2c6   /dev/i2c7
/dev/i2c-0  /dev/i2c-1  /dev/i2c-2  /dev/i2c-3  /dev/i2c-4  /dev/i2c-5 
/dev/i2c-6  /dev/i2c-7

>> One other possibility is that because I have a BMC card plugged in to the
>> motherboard (SuperMicro H8SSL-i) the BMC card is not allowing access to
>> the devices from lm_sensors.
>
> BMC are handled by a different set of drivers which were not yet merged
> into Linux 2.6. See http://bmcsensors-26.sourceforge.net/ if you think
> this is what you need. I can not help much on this myself.

I actually have access to the BMC directly, via ipmitool.  And perhaps 
this is the problem.  I am loading these modules:
   modprobe ipmi_msghandler
   modprobe ipmi_si type=kcs ports=0xca8 regspacings=4
   modprobe ipmi_devintf
Perhaps they interfere with the i2c functionality needed by lm_sensors.

Thanks very much for your help with this!

Cheers,
 	Bruce
-------------- next part --------------
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
 Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:02.0: ServerWorks CSB6 South Bridge
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
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

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): Probing for `National Semiconductor LM78'
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

Do you want to scan for Super I/O sensors? (YES/no): Probing for `ITE 8702F Super IO Sensors'
  Failed! (0xf219)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xf219)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xf219)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0xf2)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0xf2)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0xf2)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0xf2)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0xf2)
Probing for `Nat. Semi. PCPC87427 Super IO'
  Success... (no hardware monitoring capabilities)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0xf2)
Probing for `SMSC 47M172 Super IO'
  Failed! (0xf2)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0xf2)
Probing for `SMSC SCH5307-NS Super IO'
  Failed! (0xf2)
Probing for `VT1211 Super IO Sensors'
  Failed! (0xf2)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0xf2)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0xf2)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0xf2)
Probing for `Winbond W83687THF Super IO Sensors'
  Failed! (0xf2)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0xf2)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0xf2)
Probing for `Winbond W83L517D Super IO'
  Failed! (0xf2)
Probing for `Fintek F71805F/FG Super IO Sensors'
  Failed! (0xf219)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (0xf219)

Do you want to scan for secondary Super I/O sensors? (YES/no): Probing for `ITE 8702F Super IO Sensors'
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
