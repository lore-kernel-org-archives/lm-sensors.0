From: jtp51@cox.net (Todd Patrick)
Date: Wed, 29 Mar 2006 03:38:39 +0000
Subject: [lm-sensors] What is the status for drivers for the SMSC
Message-Id: <20060329033839.HQHE5868.centrmmtao05.cox.net@[172.18.53.8]>
List-Id: <lm-sensors.vger.kernel.org>
References: <d7a66840603272032m42b97167nfa2e63b6078baa43@mail.gmail.com>
In-Reply-To: <d7a66840603272032m42b97167nfa2e63b6078baa43@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare: Thank you so much for your feedback.

I did install the patch as recommended with no errors and I ran sensors-detect again:

# sudo sensors-detect

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
Load `to-be-written' (say NO if built into your kernel)? (YES/no): no
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
 I2C/SMBus (ISA/smbus)? ISA

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-isa
# I2C chip drivers
# no driver for SMSC 47M15x/192 Super IO Fan Sensors yet
#----cut here----

Do you want to add these lines to /etc/modules automatically? (yes/NO)NO


I still have the same issues after the patch. Plus, I have this error as well:

# sudo modprobe smsc47m1
FATAL: Error inserting smsc47m1 (/lib/modules/2.6.12-10-386/kernel/drivers/i2c/chips/smsc47m1.ko): No such device

However in the directory you can see that smsc47m1 *is* there:

$ ls -la
total 760
drwxr-xr-x 2 root root 4096 2006-03-24 21:32 .
drwxr-xr-x 5 root root 4096 2006-03-24 21:32 ..
-rw-r--r-- 1 root root 17820 2006-03-11 11:42 adm1021.ko
-rw-r--r-- 1 root root 20784 2006-03-11 11:42 adm1025.ko
-rw-r--r-- 1 root root 46251 2006-03-11 11:42 adm1026.ko
-rw-r--r-- 1 root root 22380 2006-03-11 11:42 adm1031.ko
-rw-r--r-- 1 root root 26173 2006-03-11 11:42 asb100.ko
-rw-r--r-- 1 root root 9657 2006-03-11 11:42 ds1337.ko
-rw-r--r-- 1 root root 11407 2006-03-11 11:42 ds1621.ko
-rw-r--r-- 1 root root 9918 2006-03-11 11:42 eeprom.ko
-rw-r--r-- 1 root root 17874 2006-03-11 11:42 fscher.ko
-rw-r--r-- 1 root root 18245 2006-03-11 11:42 fscpos.ko
-rw-r--r-- 1 root root 20184 2006-03-11 11:42 gl518sm.ko
-rw-r--r-- 1 root root 21805 2006-03-11 11:42 gl520sm.ko
-rw-r--r-- 1 root root 29264 2006-03-11 11:42 it87.ko
-rw-r--r-- 1 root root 13614 2006-03-11 11:42 lm63.ko
-rw-r--r-- 1 root root 10539 2006-03-11 11:42 lm75.ko
-rw-r--r-- 1 root root 12487 2006-03-11 11:42 lm77.ko
-rw-r--r-- 1 root root 21538 2006-03-11 11:42 lm78.ko
-rw-r--r-- 1 root root 21437 2006-03-11 11:42 lm80.ko
-rw-r--r-- 1 root root 12877 2006-03-11 11:42 lm83.ko
-rw-r--r-- 1 root root 37334 2006-03-11 11:42 lm85.ko
-rw-r--r-- 1 root root 24137 2006-03-11 11:42 lm87.ko
-rw-r--r-- 1 root root 17784 2006-03-11 11:42 lm90.ko
-rw-r--r-- 1 root root 12789 2006-03-11 11:42 lm92.ko
-rw-r--r-- 1 root root 11776 2006-03-11 11:42 max1619.ko
-rw-r--r-- 1 root root 42463 2006-03-11 11:42 pc87360.ko
-rw-r--r-- 1 root root 9628 2006-03-11 11:42 pcf8574.ko
-rw-r--r-- 1 root root 11185 2006-03-11 11:42 pcf8591.ko
-rw-r--r-- 1 root root 7858 2006-03-11 11:42 rtc8564.ko
-rw-r--r-- 1 root root 20654 2006-03-11 11:42 sis5595.ko
-rw-r--r-- 1 root root 8291 2006-03-11 11:42 smsc47b397.ko
-rw-r--r-- 1 root root 11287 2006-03-11 11:42 smsc47m1.ko
-rw-r--r-- 1 root root 22882 2006-03-11 11:42 via686a.ko
-rw-r--r-- 1 root root 34362 2006-03-11 11:42 w83627hf.ko
-rw-r--r-- 1 root root 38506 2006-03-11 11:42 w83781d.ko
-rw-r--r-- 1 root root 9614 2006-03-11 11:42 w83l785ts.ko

Again, I do appreciate your help.

Thanks,

--Todd


-----------------------------------------------------




Hi Todd,

> I have the following:
>
> kernel: 2.6.16 (custom compile with AMD Cool'n'Quiet Driver Version 1.50.03)
> motherboard: MSI MS-7184
> cpu: AMD Athlon 64 X2 3800+
> ram: 1GB
>
> When running sensors-detect, the output is:
>
> # I2C adapter drivers
> i2c-isa
> # I2C chip drivers
> # no driver for SMSC 47M15x/192 Super IO Fan Sensors yet
>
> What is the status for drivers for the SMSC 47M15x/192 Super IO Fan Sensors?

It's supported by the smsc47m1 driver since 2.6.14, so it should work
fine for you, just "modprobe smsc47m1".

The problem here is that sensors-detect isn't aware that the support
was added. We only updated the information in lm_sensors 2.9.2, so I
guess you have an older version. Except for the incomplete driver
listing in sensors-detect, it should still work OK.

> Probing for PCI bus adapters...
> Use driver `to-be-written' for device 00:14.0: ATI Technologies Inc ATI SMBus
> Probe succesfully concluded.

Note that we now have support for this SMBus master. It requires this patch:
http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-piix4-add-ati-smbus-support.patch
Which will be merged in mainline soon.

You may have additional devices behind that master. In particular, the
SMSC LPC47M192 chip is know to have voltage and temperature sensors,
for which support is being added these days. You motherboard may or may
not make use of this feature.

--
Jean Delvare

--Todd
jtp51 at cox.net


