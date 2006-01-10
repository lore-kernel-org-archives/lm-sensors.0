From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 10 Jan 2006 10:33:52 +0000
Subject: [lm-sensors] lm_sensors configured but not working?
Message-Id: <20060110113352.119e30e2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200601101102.54777.ramon.oliver@uib.es>
In-Reply-To: <200601101102.54777.ramon.oliver@uib.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ramon,

> I am having problems with a Dell Optiplex GX520 that hangs randomly (this 
> computer runs SUSE 10.0, 64 bit version). It looks to me that the cause of 
> the trouble is the processor overheating, so I decided to monitor its 
> temperature using lm_sensors. I issue sensors --version and get
> 
> sensors version 2.9.1 with libsensors version 2.9.1
> 
> Moreover, uname -r gives
> 
> 2.6.13-15.7-smp
> 
> Next I follow the flow-chart at http://www2.lm-sensors.nu/~lm78/identify.html 
> and everything seems to run smoothly; this makes me believe that lm_sensors 
> is well configured (but is it?). The output of sensors-detect (with default 
> answers) is
> 
> ##################################
> # Start of output from sensors-detect #
> 
> This program will help you determine which I2C/SMBus modules you need to load 
> to use lm_sensors most effectively. You need to have i2c and
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
>  Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 00:1f.3: Intel ICH7
> Probe succesfully concluded.
> 
> We will now try to load each adapter module in turn.
> Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
> Module loaded succesfully.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
> 
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
> i2c-dev is already loaded.
> 
>  We are now going to do the adapter probings. Some adapters may hang halfway
>  through; we can't really help that. Also, some chips will be double detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address, you can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> 
> Next adapter: SMBus I801 adapter at e8a0
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x08
> Client found at address 0x30
> Client found at address 0x32
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
> Client found at address 0x50
> Probing for `SPD EEPROM'... Success!
>     (confidence 8, driver `eeprom')
> Probing for `DDC monitor'... Failed!
> Probing for `Maxim MAX6900'... Failed!
> Client found at address 0x52
> Probing for `SPD EEPROM'... Success!
>     (confidence 8, driver `eeprom')
> Client found at address 0x69

This is pretty clear that you have no I2C/SMBus hardware monitoring
chip here.

> Some chips are also accessible through the ISA bus. ISA probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
> 
> Do you want to scan the ISA bus? (YES/no):
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
> Probing for `Winbond W83697HF'
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

And no legacy ISA or PCI integrated hardware monitoring chip either.

> Some Super I/O chips may also contain sensors. Super I/O probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
> 
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for `ITE 8702F Super IO Sensors'
>   Failed! (0x7901)
> Probing for `ITE 8705F Super IO Sensors'
>   Failed! (0x7901)
> Probing for `ITE 8712F Super IO Sensors'
>   Failed! (0x7901)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87591 Super IO'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC87371 Super IO'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC97371 Super IO'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC8739x Super IO'
>   Failed! (0x79)
> Probing for `Nat. Semi. PC8741x Super IO'
>   Failed! (0x79)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `SMSC 47M14x Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `SMSC 47S42x Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `SMSC 47S45x Super IO Fan Sensors'
>   Failed! (0x79)
> Probing for `SMSC 47M172 Super IO'
>   Failed! (0x79)
> Probing for `SMSC LPC47B397-NC Super IO'
>   Failed! (0x79)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (skipping family)
> Probing for `Winbond W83627EHF Super IO Sensors'
>   Failed! (skipping family)

You do have a primary Super-I/O chip, but we do not recognize it. If
you have some technical documentation about your system, try finding
out what Super-I/O chip this is. Some  of these chips integrate
hardware monitoring features, but not all.

> So here comes MY QUESTION. I was expecting to get readings of the temperature 
> and fan speed (and perhaps more stuff) but I do not. I believe I must be 
> doing something wrong, but I do not know what it is. Perhaps my chip is not 
> defined in /etc/sensors.conf ?
> 
> I would appreciate any ideas you can give me. Thanks in advance.

You did nothing wrong, it's just that either your system doesn't have
any hardware monitoring capabilities, or we do not support your chip at
this point in time. /etc/sensors.conf just tweaks the display for
recognized chips, so it's not the problem here.

Search the available technical documentation for your system for
information about hardware monitoring. If your system supports it, it
is probably advertised somewhere. Also check if the BIOS setup screen
shows hardware monitoring data. This is usually a good indication of
whether or not the system has a hardware monitoring chip.

In the meantime, you might give a try to ACPI. The "thermal" and "fan"
ACPI drivers may provide minimum information. Try loading them and
check in /proc/acpi/thermal_zone and /proc/acpi/fan if you have
something there. If you do it'll be very limited compared to what
lm_sensors usually offers, but that's still better than nothing at all,
especially if it turns up being your only option.

-- 
Jean Delvare

