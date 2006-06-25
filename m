From: roger@planbit.co.uk (Roger Lucas)
Date: Sun, 25 Jun 2006 11:17:46 +0000
Subject: [lm-sensors] Struggled with this for months (resending)
Message-Id: <20060625111748.C613812EDC@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060624193309.85639.qmail@web52103.mail.yahoo.com>
In-Reply-To: <20060624193309.85639.qmail@web52103.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tom,

You didn't say which motherboard you are using.  This information may help a
lot in case someone else on the list has the same mobo and has found the
work-around.  The output you supplied is very useful, but the motherboard
name and version is a "short cut" if someone else has already solved the
problem.

- Roger

> -----Original Message-----
> From: lm-sensors-bounces at lm-sensors.org [mailto:lm-sensors-bounces at lm-
> sensors.org] On Behalf Of Tom
> Sent: 24 June 2006 20:33
> To: lm-sensors at lm-sensors.org
> Subject: [lm-sensors] Struggled with this for months (resending)
> 
> No replies to this last month, so sending it again.
> 
> OK, I have tried reading documentation, following
> the flowchart, and searching the mailing list, the
> site, and the entire web to try to figure out what
> I have. I just don't get it. :(
> 
> I have decided to finally ask for help from the list.
> 
> Let me know if I have forgotten anything.
> 
> # uname -mpr
> 2.6.16-gentoo-r6 i686 Pentium III (Coppermine)
> 
> 
> # equery list lm_sensors
> [ Searching for package 'lm_sensors' in all categories among: ]
>  * installed packages
> [I--] [  ] sys-apps/lm_sensors-2.10.0 (0)
> 
> 
> # lsmod
> Module                  Size  Used by
> hwmon_vid               1984  0
> i2c_isa                 3072  0
> 
> 
> # /usr/sbin/sensors-detect
> # sensors-detect revision 1.413 (2006/01/19 20:28:00)
> 
> This program will help you determine which I2C/SMBus modules you need
> to
> load to use lm_sensors most effectively. You need to have i2c and
> lm_sensors installed before running this program.
> Also, you need to be `root', or at least have access to the /dev/i2c-*
> files, for most things.
> If you have patched your kernel and have some drivers built in, you can
> safely answer NO if asked to load some modules. In this case, things
> may
> seem a bit confusing, but they will still work.
> 
> It is generally safe and recommended to accept the default answers to
> all
> questions, unless you know what you're doing.
> 
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-i810' for device 00:01.0: Intel 82810E GMCH
> Use driver `i2c-i801' for device 00:1f.3: Intel 82801AA ICH
> Probe succesfully concluded.
> 
> We will now try to load each adapter module in turn.
> Load `i2c-i810' (say NO if built into your kernel)? (YES/no): n
> Load `i2c-i801' (say NO if built into your kernel)? (YES/no): n
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
> 
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
>  i2c-dev is not loaded. Do you want to load it now? (YES/no): n
>  Well, you will know best. We will just hope you edited
> `/etc/modules.conf'
>  for automatic loading of this module. If not,
>  you won't be able to open any /dev/i2c-* file (unless youhave it
> built-in
>  into your kernel)
> 
>  We are now going to do the adapter probings. Some adapters may hang
> halfway
>  through; we can't really help that. Also, some chips will be double
> detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address,
> you can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> 
> Next adapter: SMBus I801 adapter at dcd0
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x31
> Client found at address 0x50
> Probing for `SPD EEPROM'... Success!
>     (confidence 8, driver `eeprom')
> Probing for `DDC monitor'... Failed!
> Probing for `Maxim MAX6900'... Failed!
> Client found at address 0x51
> Probing for `SPD EEPROM'... Success!
>     (confidence 8, driver `eeprom')
> Client found at address 0x69
> 
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
>   Failed! (0xe411)
> Probing for `ITE 8705F Super IO Sensors'
>   Failed! (0xe411)
> Probing for `ITE 8712F Super IO Sensors'
>   Failed! (0xe411)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
>   Success... but not activated
> Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87591 Super IO'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87371 Super IO'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC97371 Super IO'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC8739x Super IO'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC8741x Super IO'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PCPC87427 Super IO'
>   Failed! (0xe4)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `SMSC 47M14x Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `SMSC 47S42x Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `SMSC 47S45x Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `SMSC 47M172 Super IO'
>   Failed! (0xe4)
> Probing for `SMSC LPC47B397-NC Super IO'
>   Failed! (0xe4)
> Probing for `SMSC SCH5307-NS Super IO'
>   Failed! (0xe4)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (0xe4)
> Probing for `Winbond W83627HF Super IO Sensors'
>   Failed! (0xe4)
> Probing for `Winbond W83627THF Super IO Sensors'
>   Failed! (0xe4)
> Probing for `Winbond W83637HF Super IO Sensors'
>   Failed! (0xe4)
> Probing for `Winbond W83687THF Super IO Sensors'
>   Failed! (0xe4)
> Probing for `Winbond W83697HF Super IO Sensors'
>   Failed! (0xe4)
> Probing for `Winbond W83697SF/UF Super IO PWM'
>   Failed! (0xe4)
> Probing for `Winbond W83L517D Super IO'
>   Failed! (0xe4)
> Probing for `Fintek F71805F/FG Super IO Sensors'
>   Failed! (0xe411)
> Probing for `Winbond W83627EHF/EHG Super IO Sensors'
>   Failed! (0xe411)
> 
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
>   * Bus `SMBus I801 adapter at dcd0'
>     Busdriver `i2c-i801', I2C address 0x50
>     Chip `SPD EEPROM' (confidence: 8)
>   * Bus `SMBus I801 adapter at dcd0'
>     Busdriver `i2c-i801', I2C address 0x51
>     Chip `SPD EEPROM' (confidence: 8)
> 
> 
> I will now generate the commands needed to load the I2C modules.
> 
> If you want to load the modules at startup, generate a config file
> below and make sure lm_sensors gets started at boot time; e.g
> $ rc-update add lm_sensors default
> 
> To make the sensors modules behave correctly, add these lines to
> /etc/modules.d/lm_sensors and run modules-update:
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----end cut here----
> 
> WARNING! If you have some things built into your kernel, the list above
> will contain too many modules. Skip the appropriate ones! You really
> should
> try these commands right now to make sure everything is working
> properly.
> Monitoring programs won't work until it's done.
> To load everything that is needed, execute the commands below...
> 
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> # I2C chip drivers
> modprobe eeprom
> # sleep 2 # optional
> /usr/bin/sensors -s # recommended
> #----end cut here----
> 
> Do you want to generate /etc/conf.d/lm_sensors? Enter s to specify
> other file name?
>   (YES/no/s): n
> 
> 
> # modprobe eeprom
> # lsmod
> Module                  Size  Used by
> eeprom                  5040  0
> hwmon_vid               1984  0
> i2c_isa                 3072  0
> 
> 
> # /usr/sbin/sensors-detect
> # sensors-detect revision 1.413 (2006/01/19 20:28:00)
> 
> This program will help you determine which I2C/SMBus modules you need
> to
> load to use lm_sensors most effectively. You need to have i2c and
> lm_sensors installed before running this program.
> Also, you need to be `root', or at least have access to the /dev/i2c-*
> files, for most things.
> If you have patched your kernel and have some drivers built in, you can
> safely answer NO if asked to load some modules. In this case, things
> may
> seem a bit confusing, but they will still work.
> 
> It is generally safe and recommended to accept the default answers to
> all
> questions, unless you know what you're doing.
> 
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-i810' for device 00:01.0: Intel 82810E GMCH
> Use driver `i2c-i801' for device 00:1f.3: Intel 82801AA ICH
> Probe succesfully concluded.
> 
> We will now try to load each adapter module in turn.
> Load `i2c-i810' (say NO if built into your kernel)? (YES/no): n
> Load `i2c-i801' (say NO if built into your kernel)? (YES/no): n
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
> 
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
>  i2c-dev is not loaded. Do you want to load it now? (YES/no): n
>  Well, you will know best. We will just hope you edited
> `/etc/modules.conf'
>  for automatic loading of this module. If not,
>  you won't be able to open any /dev/i2c-* file (unless youhave it
> built-in
>  into your kernel)
> 
>  We are now going to do the adapter probings. Some adapters may hang
> halfway
>  through; we can't really help that. Also, some chips will be double
> detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address,
> you can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> 
> Next adapter: SMBus I801 adapter at dcd0
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x31
> Client at address 0x50 can not be probed - unload all client drivers
> first!
> Client at address 0x51 can not be probed - unload all client drivers
> first!
> Client found at address 0x69
> 
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
>   Failed! (0xe411)
> Probing for `ITE 8705F Super IO Sensors'
>   Failed! (0xe411)
> Probing for `ITE 8712F Super IO Sensors'
>   Failed! (0xe411)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
>   Success... but not activated
> Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87591 Super IO'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC87371 Super IO'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC97371 Super IO'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC8739x Super IO'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PC8741x Super IO'
>   Failed! (0xe4)
> Probing for `Nat. Semi. PCPC87427 Super IO'
>   Failed! (0xe4)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `SMSC 47M14x Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `SMSC 47S42x Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `SMSC 47S45x Super IO Fan Sensors'
>   Failed! (0xe4)
> Probing for `SMSC 47M172 Super IO'
>   Failed! (0xe4)
> Probing for `SMSC LPC47B397-NC Super IO'
>   Failed! (0xe4)
> Probing for `SMSC SCH5307-NS Super IO'
>   Failed! (0xe4)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (0xe4)
> Probing for `Winbond W83627HF Super IO Sensors'
>   Failed! (0xe4)
> Probing for `Winbond W83627THF Super IO Sensors'
>   Failed! (0xe4)
> Probing for `Winbond W83637HF Super IO Sensors'
>   Failed! (0xe4)
> Probing for `Winbond W83687THF Super IO Sensors'
>   Failed! (0xe4)
> Probing for `Winbond W83697HF Super IO Sensors'
>   Failed! (0xe4)
> Probing for `Winbond W83697SF/UF Super IO PWM'
>   Failed! (0xe4)
> Probing for `Winbond W83L517D Super IO'
>   Failed! (0xe4)
> Probing for `Fintek F71805F/FG Super IO Sensors'
>   Failed! (0xe411)
> Probing for `Winbond W83627EHF/EHG Super IO Sensors'
>   Failed! (0xe411)
> 
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
>  Sorry, no chips were detected.
>  Either your sensors are not supported, or they are
>  connected to an I2C bus adapter that we do not support.
>  See doc/FAQ, doc/lm_sensors-FAQ.html, or
> 
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
>  (FAQ #4.24.3) for further information.
>  If you find out what chips are on your board, see
>  http://secure.netroedge.com/~lm78/newdrivers.html for driver status.
> 
> 
> # i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c/0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 50: UU UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX
> 
> 
> # /usr/sbin/i2cdump 0 0x50
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c/0, address 0x50, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 80 08 04 0c 0a 02 40 00 01 a0 60 00 80 08 00 01    ??????@.??`.??.?
> 10: 8f 04 06 01 01 00 0e a0 60 00 00 14 14 14 32 20    ?????.??`..???2
> 20: 20 10 20 10 00 00 00 00 00 00 00 00 00 00 00 00     ? ?............
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12 17    ..............??
> 40: 7f 98 00 00 00 00 00 00 04 20 33 32 4d 58 36 34    ??......? 32MX64
> 50: 50 43 31 30 30 43 4c 32 31 36 38 50 20 03 02 04    PC100CL2168P ???
> 60: 0f 9b 07 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 64 f7    ..............d?
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: 39 39 30 35 31 32 31 2d 30 32 35 2e 61 30 32 00    9905121-025.a02.
> 
> 
> # /usr/sbin/i2cdump 0 0x51
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c/0, address 0x51, mode byte
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 80 08 04 0c 09 02 40 00 01 a0 60 00 80 08 00 01    ??????@.??`.??.?
> 10: 8f 04 06 01 01 00 0e a0 60 ff ff 14 10 14 2d 10    ?????.??`..???-?
> 20: 20 10 20 10 ff ff ff ff ff ff ff ff ff ff ff ff     ? ?............
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 12 e1    ..............??
> 40: c1 49 4e 46 49 4e 45 4f 09 48 59 53 36 34 56 31    ?INFINEO?HYS64V1
> 50: 36 32 32 30 47 55 2d 38 ff ff ff 01 02 00 22 01    6220GU-8...??."?
> 60: 06 c4 86 ff ff ff ff ff ff ff ff ff ff ff ff ff    ???.............
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 64 ff    ..............d.
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 
> 
> Thank you in advance for your help.
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


