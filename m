From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Aug 2006 15:01:44 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060823170144.e2fc9d8c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> I think it is doubtful that this current, state of the art motherboard has
> an actual lm78 chip on it (although I guess it's possible).  I scanned the
> board visually for a Winbond chip or anything else that looks like a hw
> monitoring chip but did not find anything (perhaps it's just my bad old eyes).

I agree with you, this is most certainly a misdetection.

> Here's the output of sensors-detect (...)
> 
> Script started on Tue Aug 22 14:21:42 2006
> seahunt:~ # sensors-detect
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
>  Do you want to probe now? (YES/no): 
> Probing for PCI bus adapters...
> Sorry, no PCI bus adapters found.

I guess you have an Intel ICH8 chip on the board. Our detection script
didn't recognize it, I just added it in SVN. No big deal anyway as the
required driver is automatically loaded.

> We will now try to load each adapter module in turn.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
> 
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
>  i2c-dev is not loaded. Do you want to load it now? (YES/no): 
>  Module loaded succesfully.
> 
>  We are now going to do the adapter probings. Some adapters may hang halfway
>  through; we can't really help that. Also, some chips will be double detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address, you can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> 
> Next adapter: SMBus I801 adapter at 0400
> Do you want to scan it? (YES/no/selectively): 
> Client found at address 0x08
> Client found at address 0x22
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83627HF'... Failed!

I wonder what chip it can be. Can you please provide a dump of it?

To generate a dump you need to find out the correct i2c bus number.
Make sure i2c-dev is loaded, then run "i2cdetect -l" and find the i2c
bus number for "SMBus I801", then run "i2cdump N 0x22" where N is
that i2c bus number.

> Client found at address 0x30
> Client found at address 0x32
> Client at address 0x50 can not be probed - unload all client drivers first!
> Client at address 0x52 can not be probed - unload all client drivers first!
> Client found at address 0x69
> 
> Next adapter: NVIDIA I2C Device
> Do you want to scan it? (YES/no/selectively): 
> 
> Next adapter: NVIDIA I2C Device
> Do you want to scan it? (YES/no/selectively): 
> Client found at address 0x50
> Probing for `SPD EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Probing for `DDC monitor'... Success!
>     (confidence 8, driver `eeprom'), other addresses: 0x51 0x52 0x53 0x54 0x55 0x56 0x57
> Probing for `Maxim MAX6900'... Failed!
> Client found at address 0x51
> Probing for `SPD EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x52
> Probing for `SPD EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x53
> Probing for `SPD EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x54
> Probing for `SPD EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x55
> Probing for `SPD EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x56
> Probing for `SPD EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x57
> Probing for `SPD EEPROM'... Success!
>     (confidence 1, driver `eeprom')
> Probing for `Sony Vaio EEPROM'... Failed!
> 
> Next adapter: NVIDIA I2C Device
> Do you want to scan it? (YES/no/selectively): 

These are i2c busses provided by the proprietary nvidia graphics
driver. We shouldn't even accept to help you with this driver loaded...

> Some chips are also accessible through the ISA bus. ISA probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
> 
> Do you want to scan the ISA bus? (YES/no): 
> Probing for `National Semiconductor LM78'
>   Trying address 0x0290... Success!
>     (confidence 6, driver `lm78')
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
> 
> Some Super I/O chips may also contain sensors. Super I/O probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
> 
> Do you want to scan for Super I/O sensors? (YES/no): 
> Probing for `ITE 8702F Super IO Sensors'
>   Failed! (skipping family)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (skipping family)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (skipping family)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (0xa0)
> Probing for `Winbond W83627HF Super IO Sensors'
>   Failed! (0xa0)
> Probing for `Winbond W83627THF Super IO Sensors'
>   Failed! (0xa0)
> Probing for `Winbond W83637HF Super IO Sensors'
>   Failed! (0xa0)
> Probing for `Winbond W83687THF Super IO Sensors'
>   Failed! (0xa0)
> Probing for `Winbond W83697HF Super IO Sensors'
>   Failed! (0xa0)
> Probing for `Winbond W83697SF/UF Super IO PWM'
>   Failed! (0xa0)
> Probing for `Winbond W83L517D Super IO'
>   Failed! (0xa0)
> Probing for `Fintek F71805F/FG Super IO Sensors'
>   Failed! (0xa021)
> Probing for `Winbond W83627EHF/EHG Super IO Sensors'
>   Failed! (0xa021)

This Super-I/O device ID (0xa021) matches the new Winbond W83627DHG
chip. Your version of the sensors-detect script doesn't know about it
yet, but the one in SVN does.

So the good news is that we know what your hardware monitoring chip is.

The bad news is that we don't support that chip yet.

The not so bad news is that this chip might be more or less compatible
with the W83627EHG, which we do support.

Can you please provide a dump of the chip?
isadump 0x295 0x296

> Do you want to scan for secondary Super I/O sensors? (YES/no): 
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
>  Now follows a summary of the probes I have just done.
>  Just press ENTER to continue: 
> 
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `NVIDIA I2C Device'
>     Busdriver `UNKNOWN', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55 0x56 0x57)
>     Chip `DDC monitor' (confidence: 8)
> 
> Driver `lm78' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `National Semiconductor LM78' (confidence: 6)
> 
> 
> I will now generate the commands needed to load the I2C modules.
> Use of uninitialized value in numeric eq (=) at /usr/sbin/sensors-detect line 4924.
> Use of uninitialized value in numeric eq (=) at /usr/sbin/sensors-detect line 4924.
> Use of uninitialized value in numeric eq (=) at /usr/sbin/sensors-detect line 4924.

Hmm, this is bad. The line numbers don't seem to match sensors-detect
in lm_sensors 2.10.0 despite the version number, so I can't tell what's
wrong.

Can you please try the latest version of sensors-detect:
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
And tell us whether you still have these warnings?

> To make the sensors modules behave correctly, add these lines to
> /etc/modprobe.conf:
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
> 
> To load everything that is needed, add this to some /etc/rc* file:
> 
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> # modprobe unknown adapter NVIDIA I2C Device
> # modprobe unknown adapter NVIDIA I2C Device

This is odd too, this should be listed only once.

> modprobe i2c-isa
> # I2C chip drivers
> modprobe eeprom
> modprobe lm78
> # sleep 2 # optional
> /usr/bin/sensors -s # recommended
> #----cut here----
> 
> WARNING! If you have some things built into your kernel, the list above
> will contain too many modules. Skip the appropriate ones! You really should
> try these commands right now to make sure everything is working properly.
> Monitoring programs won't work until it's done.
> 
> Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): n
> seahunt:~ # exit
> 
> Script done on Tue Aug 22 14:22:19 2006

-- 
Jean Delvare

