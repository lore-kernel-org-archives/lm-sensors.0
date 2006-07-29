From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 29 Jul 2006 17:23:50 +0000
Subject: [lm-sensors] Macs with Intel 82801G (ICH7 Family)
Message-Id: <20060729192350.d4469c6e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060728203712.da818e24.khali@linux-fr.org>
In-Reply-To: <20060728203712.da818e24.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brian,

> Thanks for the reply. Two things. First, there is a GPL program called
> SpeedIt that is apparently able to provide CPU temperature under OS X on
> the Intel Macs. http://speedit.increw.org/trac.cgi/wiki/SpeedIt So,
> while I don't know how it works I would think there have to be some sort
> of hardware sensors on this board.

I took a quick look and I didn't see anything related to temperature in
the code. The code is very cpu-centric, it seems, so even if it indeed
reports a temperature, I'd suspect that it is a digital value read from
the CPU itself, and not from a hardware monitoring chip.

Rudolf Marek is working on a driver for the temperature sensors
embedded in the AMD K8 processors, however we don't have anything
similar for Intel processors at the moment.

> The first time I ran sensors-detect I got:
> 
> ...
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at efa0'
>     Busdriver `i2c-i801', I2C address 0x50
>     Chip `SPD EEPROM' (confidence: 8)
>   * Bus `SMBus I801 adapter at efa0'
>     Busdriver `i2c-i801', I2C address 0x52
>     Chip `SPD EEPROM' (confidence: 8)
> 
> I will now generate the commands needed to load the I2C modules.
> 
> To make the sensors modules behave correctly, add these lines to
> /etc/modules:
> 
> #----cut here----
> # I2C adapter drivers
> i2c-i801
> # I2C chip drivers
> eeprom
> #----cut here----
> 
> Now that I've added those lines to /etc/modules sensors-detect doesn't
> seem to detect them at all.

sensors-detect cannot probe addresses which already have a driver
attached. It could confuse the driver if it did.

This has been confusing many users for years, so I just added some code
to sensors-detect to get the driver information from sysfs when an
address is busy. It only works for Linux 2.6, of course, for 2.4 we
will still have the old warning message.

> (Though I've changed kernels a couple times
> since then and could have messed something up. If there's a list of all
> needed modules for making i2c-i801 work that'd be helpful.

Such a list doesn't exist, and isn't needed. All the modules needed by
i2c-i801 are loaded automatically when you load i2c-i801. That's a
short list, BTW: i2c-core, and that's all.

> Now sensors-detect gives me this (full output:)
> 
> debian-macbook:/# sensors-detect
> # sensors-detect revision 1.413 (2006/01/19 20:28:00)
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
>  Do you want to probe now? (YES/no): y
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 00:1f.3: Intel ICH7
> Probe succesfully concluded.
> 
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
> 
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
>  i2c-dev is not loaded. Do you want to load it now? (YES/no): y
>  Module loaded succesfully.
> 
>  We are now going to do the adapter probings. Some adapters may hang halfway
>  through; we can't really help that. Also, some chips will be double
> detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address, you can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> 
> Next adapter: SMBus I801 adapter at efa0
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x08
> Client found at address 0x38
> Probing for `Philips Semiconductors SAA1064'... Failed!
> Client found at address 0x3a
> Probing for `Philips Semiconductors SAA1064'... Failed!
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
> Client at address 0x50 can not be probed - unload all client drivers first!
> Client at address 0x52 can not be probed - unload all client drivers first!
> Client found at address 0x69

OK, basically the same as what the web page had. No hardware monitoring
chips on the SMBus. No idea what the chips at 0x38 and 0x3a are.

> Some chips are also accessible through the ISA bus. ISA probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
> 
> Do you want to scan the ISA bus? (YES/no): y
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
> Probing for `Winbond W83627EHF'
>   Trying address 0x0290... Failed!
> Probing for `Silicon Integrated Systems SIS5595'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT8231 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8712F'
>   Trying address 0x0290... Failed!
> Probing for `ITE IT8705F / SiS 950'
>   Trying address 0x0290... Failed!
> Probing for `IPMI BMC KCS'
>   Trying address 0x0ca0... Failed!
> Probing for `IPMI BMC SMIC'
>   Trying address 0x0ca8... Failed!

No legacy ISA chip nor integrated PCI sensors, that was expected.

> Some Super I/O chips may also contain sensors. Super I/O probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
> 
> Do you want to scan for Super I/O sensors? (YES/no): y
> Probing for `ITE 8702F Super IO Sensors'
>   Failed! (skipping family)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (skipping family)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (skipping family)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (skipping family)
> Probing for `Winbond W83627EHF/EHG Super IO Sensors'
>   Failed! (skipping family)
> 
> Do you want to scan for secondary Super I/O sensors? (YES/no): y
> Probing for `ITE 8702F Super IO Sensors'
>   Failed! (skipping family)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (skipping family)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (0x0b)
> Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
>   Failed! (0x0b)
> Probing for `SMSC 47M14x Super IO Fan Sensors'
>   Failed! (0x0b)
> Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
>   Failed! (0x0b)
> Probing for `SMSC 47S42x Super IO Fan Sensors'
>   Failed! (0x0b)
> Probing for `SMSC 47S45x Super IO Fan Sensors'
>   Failed! (0x0b)
> Probing for `SMSC 47M172 Super IO'
>   Failed! (0x0b)
> Probing for `SMSC LPC47B397-NC Super IO'
>   Failed! (0x0b)
> Probing for `SMSC SCH5307-NS Super IO'
>   Failed! (0x0b)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (skipping family)
> Probing for `Winbond W83627EHF/EHG Super IO Sensors'
>   Failed! (skipping family)

Aha, an unknown Super-I/O chip, supposedly made by SMSC. Sometimes
Super-I/O chips have integrated hardware monitoring features. If you
can get the exact name of the chip (e.g. by opening the case and
looking for SMSC chips) and if we can get a datasheet for this chip, we
could check it.

> P.S. "successfully" is twice misspelled by sensors-detect above by
> missing an 's'. (in probe ... concluded and module ... loaded).

Actually misspelled three times total in the script, and twice more in
documentation files. All fixed, thanks for reporting!

-- 
Jean Delvare

