From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 04 Oct 2006 13:15:28 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <20061004151528.7b1baba0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> I'm having problems with lm_sensors on the motherboard Supermicro X6DH8-G2+
> sensors-detect gives me the output attached in the textfile
> sensors-detect-output.txt
> 
> As soon as I execute the recommended 'modprobe smbus-arp' I receive the
> following message:
> FATAL: Module smbus_arp not found.

Forget about smbus-arp, it's an old experimental module which was never
ported to Linux 2.6 (and never will be.)

> When I execute sensors, I receive the following:
> ===========================
> [root at matrix ~]# sensors
> eeprom-i2c-0-57
> Adapter: SMBus I801 adapter at 1100
> Unknown EEPROM type (8)
> 
> eeprom-i2c-0-53
> Adapter: SMBus I801 adapter at 1100
> Unknown EEPROM type (8)
> ===========================

You must be using an old version of lm_sensors. Type 8 is DDR2 SDRAM,
which is supported for quite some time now.

> I also attached sensors.conf from /etc for reference.

Not really helpful, we distribute the file, so we know what's inside,
and this file isn't relevant at this point anyway, as you don't even
have a hardware monitoring driver loaded.

> I'm using xen-3.0.2 with kernel 2.6.16 and all Hardware Monitoring and
> i2c stuff compiled as modules (as being done in the standard kernel).
> My distribution is CentOS-4.4 hence my sensors version is
> 'lm_sensors-2.8.7-2.40.3'

This is quite old, and your hardware is brand new. This just can't work.

> sensors doesn't run either with the non-xen kernel, i.e. the stock
> kernel that came with CentOS-4.4: kernel-2.6.9-42.0.2.EL
> 
> Is there any way to get sensors on the mainboard running?

> [root at matrix ~]# sensors-detect
> 
> This program will help you determine which I2C/SMBus modules you need to
> load to use lm_sensors most effectively. You need to have i2c and
> lm_sensors installed before running this program.
> Also, you need to be `root', or at least have access to the /dev/i2c-*
> files, for most things.
> If you have patched your kernel and have some drivers built in, you can
> safely answer NO if asked to load some modules. In this case, things may
> seem a bit confusing, but they will still work.
> 
> It is generally safe and recommended to accept the default answers to all
> questions, unless you know what you're doing.
> 
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no): YES
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
> Probe succesfully concluded.
> 
> We will now try to load each adapter module in turn.
> Load `i2c-i801' (say NO if built into your kernel)? (YES/no): YES
> Module loaded succesfully.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
> 
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
>  i2c-dev is not loaded. Do you want to load it now? (YES/no): YES
>  Module loaded succesfully.
> 
>  We are now going to do the adapter probings. Some adapters may hang halfway
>  through; we can't really help that. Also, some chips will be double detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address, you can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> 
> Next adapter: SMBus I801 adapter at 1100 (Algorithm unavailable)
> Do you want to scan it? (YES/no/selectively): YES
> Client found at address 0x08
> Client found at address 0x2e
> Probing for `Myson MTP008'... Failed!
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `National Semiconductor LM85'... Failed!
> Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
> Probing for `SMSC EMC6D100 or EMC6D101'... Failed!
> Probing for `Analog Devices ADT7467'... Failed!
> Probing for `National Semiconductor LM87'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83791D'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F (rev.1)'... Failed!
> Probing for `Asus AS99127F (rev.2)'... Failed!
> Probing for `Asus ASB100 Bach'... Failed!
> Probing for `Winbond W83L785TS-S'... Failed!
> Probing for `Analog Devices ADM9240'... Failed!
> Probing for `Dallas Semiconductor DS1780'... Failed!
> Probing for `National Semiconductor LM81'... Failed!
> Probing for `Analog Devices ADM1026'... Failed!
> Probing for `Analog Devices ADM1025'... Failed!
> Probing for `Analog Devices ADM1024'... Failed!
> Probing for `Analog Devices ADM1029'... Failed!
> Probing for `Analog Devices ADM1030'... Failed!
> Probing for `Analog Devices ADM1031'... Failed!
> Probing for `Analog Devices ADM1022'... Failed!
> Probing for `Texas Instruments THMC50'... Failed!
> Probing for `Analog Devices ADM1028'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x30
> Client found at address 0x33
> Client found at address 0x37
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
> Client found at address 0x53
> Probing for `SPD EEPROM'... Success!
>     (confidence 8, driver `eeprom')
> Client found at address 0x57
> Probing for `SPD EEPROM'... Success!
>     (confidence 8, driver `eeprom')
> Probing for `Sony Vaio EEPROM'... Failed!
> Client found at address 0x60
> Client found at address 0x61
> Probing for `SMBus 2.0 ARP-Capable Device'... Success!
>     (confidence 1, driver `smbus-arp')
> Client found at address 0x69
> Client found at address 0x6c
> Client found at address 0x6e
> 
> Some chips are also accessible through the ISA bus. ISA probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
> 
> Do you want to scan the ISA bus? (YES/no): YES
> Probing for `National Semiconductor LM78'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM78-J'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM79'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83781D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83782D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83627HF'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83697HF'
>   Trying address 0x0290... Failed!
> Probing for `Silicon Integrated Systems SIS5595'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT8231 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290... Failed!
> Probing for `IPMI BMC KCS'
>   Trying address 0x0ca0... Failed!
> Probing for `IPMI BMC SMIC'
>   Trying address 0x0ca8... Failed!
> 
> Some Super I/O chips may also contain sensors. Super I/O probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
> 
> Do you want to scan for Super I/O sensors? (YES/no): YES
> Probing for `ITE 8702F Super IO Sensors'
>   Failed! (0xf211)
> Probing for `ITE 8705F Super IO Sensors'
>   Failed! (0xf211)
> Probing for `ITE 8712F Super IO Sensors'
>   Failed! (0xf211)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
>   Failed! (0xf2)
> Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
>   Failed! (0xf2)
> Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
>   Failed! (0xf2)
> Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
>   Failed! (0xf2)
> Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `Nat. Semi. PC8741x Super IO'
>   Failed! (0xf2)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `SMSC 47M14x Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `SMSC 47S42x Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `SMSC 47S45x Super IO Fan Sensors'
>   Failed! (0xf2)
> Probing for `SMSC 47M172 Super IO'
>   Failed! (0xf2)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (0xf2)
> Probing for `Winbond W83627HF Super IO Sensors'
>   Failed! (0xf2)
> Probing for `Winbond W83627THF Super IO Sensors'
>   Failed! (0xf2)
> Probing for `Winbond W83637HF Super IO Sensors'
>   Failed! (0xf2)
> Probing for `Winbond W83697HF Super IO Sensors'
>   Failed! (0xf2)
> Probing for `Winbond W83697SF/UF Super IO PWM'
>   Failed! (0xf2)
> Probing for `Winbond W83L517D Super IO'
>   Failed! (0xf2)
> 
> Do you want to scan for secondary Super I/O sensors? (YES/no): YES
> Probing for `ITE 8702F Super IO Sensors'
>   Failed! (0xe111)
> Probing for `ITE 8705F Super IO Sensors'
>   Failed! (0xe111)
> Probing for `ITE 8712F Super IO Sensors'
>   Failed! (0xe111)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
>   Success... but not activated
> Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
>   Failed! (0xe1)
> Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
>   Failed! (0xe1)
> Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
>   Failed! (0xe1)
> Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
>   Failed! (0xe1)
> Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `Nat. Semi. PC8741x Super IO'
>   Failed! (0xe1)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `SMSC 47M14x Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `SMSC 47S42x Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `SMSC 47S45x Super IO Fan Sensors'
>   Failed! (0xe1)
> Probing for `SMSC 47M172 Super IO'
>   Failed! (0xe1)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (0xe1)
> Probing for `Winbond W83627HF Super IO Sensors'
>   Failed! (0xe1)
> Probing for `Winbond W83627THF Super IO Sensors'
>   Failed! (0xe1)
> Probing for `Winbond W83637HF Super IO Sensors'
>   Failed! (0xe1)
> Probing for `Winbond W83697HF Super IO Sensors'
>   Failed! (0xe1)
> Probing for `Winbond W83697SF/UF Super IO PWM'
>   Failed! (0xe1)
> Probing for `Winbond W83L517D Super IO'
>   Failed! (0xe1)
> 
>  Now follows a summary of the probes I have just done.
>  Just press ENTER to continue:
> 
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at 1100' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x53
>     Chip `SPD EEPROM' (confidence: 8)
>   * Bus `SMBus I801 adapter at 1100' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x57
>     Chip `SPD EEPROM' (confidence: 8)
> 
> Driver `smbus-arp' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at 1100' (Algorithm unavailable)
>     Busdriver `i2c-i801', I2C address 0x61
>     Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

This is an old version of sensors-detect, no wonder it doesn't detect
your sensors. Please try again with the version of sensors-detect which
comes with the freshly released lm_sensors 2.10.1.

I think I've seen this motherboard before, so I guess it'll find a
National Semiconductor LM93 for the temperatures and voltages, and a
National Semiconductor PC87427 Super-I/O chip for the fans. Status for
these chips is as follows:

* A driver for the LM93 chip exists but wasn't officially ported to
Linux 2.6. There was a preliminary port posted to this list at the
times of ~ 2.6.10, but it was never properly reviewed due to lack of
time.

* We have a datasheet for the PC87427 but no public driver yet. I've
been working on the fan support though, I have a preliminary driver
waiting for testers.

> BTW, what Power supply do you recommend if I've got a 2U chassis with 4
> Fans, 4 SATA II drives, an SATA Backplane, Dual Xeon 3.6 GHz, 4 GB RAM,
> eRIC remote console card, a double layer DVD writer and 3ware
> 9550SXU-4LP. Is a 510W power supply from Emacs P2G-6510P sufficient?

No idea, sorry. The motherboard maker should tell you.

-- 
Jean Delvare

