From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 25 Mar 2012 15:23:12 +0000
Subject: Re: [lm-sensors] Incorrect Temperature Readings
Message-Id: <20120325152311.GA6544@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT120-W272CB289017CB6E4F875EC87440@phx.gbl>
In-Reply-To: <SNT120-W272CB289017CB6E4F875EC87440@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scott Ondercin <sgo542@hotmail.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Sun, Mar 25, 2012 at 07:49:46AM -0400, Scott Ondercin wrote:
> So, once upon a time, my computer worked fine.  I have a Dell Inspiron 1420,
> which has a good ventilation system and usually runs quite cool.  A few months
> ago my fan broke and I had to have it replaced.  The new one, however, runs all
> the time and is very loud.
> 
> My lm-sensors is screwed up, and scanning various threads I can't seem to find
> a problem like mine.  So, here is what running sensors gets me:
> 
> sgo542@NostalgiaforInfinity:~$ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +32.5 C  (crit = +87.0 C)
> 
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +30.0 C  (high = +85.0 C, crit = +85.0 C)
> Core 1:       +33.0 C  (high = +85.0 C, crit = +85.0 C)
> 
> nouveau-pci-0100
> Adapter: PCI adapter
> temp1:        +97.0 C  (high = +100.0 C, crit = +110.0 C)
> 
Scott,

That temperature reading is from your graphics adapter. No idea how it comes
that it reports such a high temperature. Does it have a fan, and are you sure
it is working ?

Copying the driver maintainer and the drm mailing list. Maybe someone there
has an idea.

Guenter

> I've been casually browsing FireFox for a half hour and that is what it gives
> me.  Now, I can sit this computer comfortably in my lap.  That 97C temperature
> is clearly off, almost like it's reading in Farenheit but forgetting to convert
> it to Celsius.  Normally it just makes my fan run all the time, but now that
> spring has come, it gets hotter faster.  A few days ago I could only run it for
> 20-30 minutes before the reading hit 105C and the automatic emergency shut-down
> kicked in.  Obviously, this needs to be fixed before sumer strikes.
> 
> For reference, this is what I get from sensors-detect:
> 
> sgo542@NostalgiaforInfinity:~$ sudo sensors-detect
> # sensors-detect revision 5946 (2011-03-23 11:54:44 +0100)
> # System: Dell Inc. Inspiron 1420 (laptop)
> # Board: Dell Inc. 0JX269
> 
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
> 
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no): y
> Module cpuid loaded successfully.
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD Family 10h thermal sensors...                           No
> AMD Family 11h thermal sensors...                           No
> AMD Family 12h and 14h thermal sensors...                   No
> Intel digital thermal sensor...                             Success!
>     (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         No
> VIA C7 thermal sensor...                                    No
> VIA Nano thermal sensor...                                  No
> 
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): y
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x3201
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      No
> 
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (YES/no): y
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> 
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no): y
> Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801H ICH8
> Module i2c-dev loaded successfully.
> 
> Next adapter: nouveau-0000:01:00.0-2 (i2c-0)
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Probing for `EDID EEPROM'...                                Yes
>     (confidence 8, not a hardware monitoring chip)
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Client found at address 0x53
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> 
> Next adapter: nouveau-0000:01:00.0-0 (i2c-1)
> Do you want to scan it? (YES/no/selectively): y
> 
> Next adapter: SMBus I801 adapter at 10c0 (i2c-2)
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> 
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `coretemp':
>   * Chip `Intel digital thermal sensor' (confidence: 9)
> 
> To load everything that is needed, add this to /etc/modules:
> #----cut here----
> # Chip drivers
> coretemp
> #----cut here----
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones!
> 
> Do you want to add these lines automatically to /etc/modules? (yes/NO)y
> Successful!
> 
> Monitoring programs won't work until the needed modules are
> loaded. You may want to run 'service module-init-tools start'
> to load them.
> 
> Unloading i2c-dev... OK
> Unloading cpuid... OK
> 
> sgo542@NostalgiaforInfinity:~$ sudo service module-init-tools start
> module-init-tools stop/waiting
> sgo542@NostalgiaforInfinity:~$ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +32.5 C  (crit = +87.0 C)
> 
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +31.0 C  (high = +85.0 C, crit = +85.0 C)
> Core 1:       +33.0 C  (high = +85.0 C, crit = +85.0 C)
> 
> nouveau-pci-0100
> Adapter: PCI adapter
> temp1:        +97.0 C  (high = +100.0 C, crit = +110.0 C)
> 
> sgo542@NostalgiaforInfinity:~$ sudo modprobe coretemp
> sgo542@NostalgiaforInfinity:~$ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +32.5 C  (crit = +87.0 C)
> 
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +30.0 C  (high = +85.0 C, crit = +85.0 C)
> Core 1:       +33.0 C  (high = +85.0 C, crit = +85.0 C)
> 
> nouveau-pci-0100
> Adapter: PCI adapter
> temp1:        +97.0 C  (high = +100.0 C, crit = +110.0 C)
> 
> sgo542@NostalgiaforInfinity:~$ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +33.5 C  (crit = +87.0 C)
> 
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +31.0 C  (high = +85.0 C, crit = +85.0 C)
> Core 1:       +33.0 C  (high = +85.0 C, crit = +85.0 C)
> 
> nouveau-pci-0100
> Adapter: PCI adapter
> temp1:        +97.0 C  (high = +100.0 C, crit = +110.0 C)
> 
> sgo542@NostalgiaforInfinity:~$ sensors-detect
> You need to be root to run this script.
> sgo542@NostalgiaforInfinity:~$ sudo sensors-detect
> # sensors-detect revision 5946 (2011-03-23 11:54:44 +0100)
> # System: Dell Inc. Inspiron 1420 (laptop)
> # Board: Dell Inc. 0JX269
> 
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
> 
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no): y
> Module cpuid loaded successfully.
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD Family 10h thermal sensors...                           No
> AMD Family 11h thermal sensors...                           No
> AMD Family 12h and 14h thermal sensors...                   No
> Intel digital thermal sensor...                             Success!
>     (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         No
> VIA C7 thermal sensor...                                    No
> VIA Nano thermal sensor...                                  No
> 
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): y
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x3201
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      No
> 
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (YES/no): y
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> 
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no): y
> Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801H ICH8
> Module i2c-dev loaded successfully.
> 
> Next adapter: nouveau-0000:01:00.0-2 (i2c-0)
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Probing for `EDID EEPROM'...                                Yes
>     (confidence 8, not a hardware monitoring chip)
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Client found at address 0x53
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> 
> Next adapter: nouveau-0000:01:00.0-0 (i2c-1)
> Do you want to scan it? (YES/no/selectively): y
> 
> Next adapter: SMBus I801 adapter at 10c0 (i2c-2)
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> 
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `coretemp':
>   * Chip `Intel digital thermal sensor' (confidence: 9)
> 
> To load everything that is needed, add this to /etc/modules:
> #----cut here----
> # Chip drivers
> coretemp
> #----cut here----
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones!
> 
> Do you want to add these lines automatically to /etc/modules? (yes/NO)y
> Successful!
> 
> Monitoring programs won't work until the needed modules are
> loaded. You may want to run 'service module-init-tools start'
> to load them.
> 
> Unloading i2c-dev... OK
> Unloading cpuid... OK
> 
> And when I try to run module-init-tools, I get:
> 
> sgo542@NostalgiaforInfinity:~$ sudo service module-init-tools start
> module-init-tools stop/waiting
> 
> I've heard I might be able to fix this by tweaking the /etc/sensors.conf file,
> but I'm unsure how to even start with that.  I am moderately experiences with
> Linux, but by no means an expert.  Any help would be appreciated, before it
> gets hot outside and my computer becomes completely unusable.

> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
